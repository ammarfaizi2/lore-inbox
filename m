Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132627AbRAZMaZ>; Fri, 26 Jan 2001 07:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130895AbRAZMaQ>; Fri, 26 Jan 2001 07:30:16 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:24082 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S129562AbRAZMaH>; Fri, 26 Jan 2001 07:30:07 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101261229.f0QCTvl00489@wellhouse.underworld>
Subject: [PATCH] (revised): spinlocks in SoundBlaster
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Fri, 26 Jan 2001 23:29:56 +1100 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled an SMP kernel on my UP box to test my spinlock patch
properly. Suffice to say that here is a revised version (ahem! ;-)

The other patches I posted seem to be OK.

Cheers,
Chris

--- linux-2.4.0/drivers/sound/sb.h.orig	Fri Jan 26 13:57:40 2001
+++ linux-2.4.0/drivers/sound/sb.h	Fri Jan 26 13:58:42 2001
@@ -137,6 +137,8 @@
 	   void (*midi_input_intr) (int dev, unsigned char data);
 	   void *midi_irq_cookie;		/* IRQ cookie for the midi */
 
+	   spinlock_t lock;
+
 	   struct sb_module_options sbmo;	/* Module options */
 
 	} sb_devc;
--- linux-2.4.0/drivers/sound/sb_audio.c.orig	Fri Jan 26 13:54:56 2001
+++ linux-2.4.0/drivers/sound/sb_audio.c	Fri Jan 26 15:16:59 2001
@@ -19,8 +19,11 @@
  * Daniel J. Rodriksson: Changes to make sb16 work full duplex.
  *                       Maybe other 16 bit cards in this code could behave
  *                       the same.
+ * Chris Rankin:         Use spinlocks instead of CLI/STI
  */
 
+#include <linux/spinlock.h>
+
 #include "sound_config.h"
 
 #include "sb_mixer.h"
@@ -43,23 +46,22 @@
 		if (mode == OPEN_READ)
 			return -EPERM;
 	}
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (devc->opened)
 	{
-		  restore_flags(flags);
+		  spin_unlock_irqrestore(&devc->lock, flags);
 		  return -EBUSY;
 	}
 	if (devc->dma16 != -1 && devc->dma16 != devc->dma8 && !devc->duplex)
 	{
 		if (sound_open_dma(devc->dma16, "Sound Blaster 16 bit"))
 		{
-			restore_flags(flags);
+		  	spin_unlock_irqrestore(&devc->lock, flags);
 			return -EBUSY;
 		}
 	}
 	devc->opened = mode;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	devc->irq_mode = IMODE_NONE;
 	devc->irq_mode_16 = IMODE_NONE;
@@ -182,8 +184,7 @@
 
 	devc->irq_mode = IMODE_OUTPUT;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x14))		/* 8 bit DAC using DMA */
 	{
 		sb_dsp_command(devc, (unsigned char) (count & 0xff));
@@ -191,7 +192,7 @@
 	}
 	else
 		printk(KERN_WARNING "Sound Blaster:  unable to start DAC.\n");
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 	devc->intr_active = 1;
 }
 
@@ -213,8 +214,7 @@
 
 	devc->irq_mode = IMODE_INPUT;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x24))		/* 8 bit ADC using DMA */
 	{
 		sb_dsp_command(devc, (unsigned char) (count & 0xff));
@@ -222,7 +222,7 @@
 	}
 	else
 		printk(KERN_ERR "Sound Blaster:  unable to start ADC.\n");
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	devc->intr_active = 1;
 }
@@ -258,12 +258,11 @@
 	sb_devc *devc = audio_devs[dev]->devc;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x40))
 		sb_dsp_command(devc, devc->tconst);
 	sb_dsp_command(devc, DSP_CMD_SPKOFF);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	devc->trigger_bits = 0;
 	return 0;
@@ -274,12 +273,11 @@
 	sb_devc *devc = audio_devs[dev]->devc;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x40))
 		sb_dsp_command(devc, devc->tconst);
 	sb_dsp_command(devc, DSP_CMD_SPKON);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 	devc->trigger_bits = 0;
 	return 0;
 }
@@ -327,10 +325,9 @@
 	unsigned long flags;
 	sb_devc *devc = audio_devs[dev]->devc;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	sb_dsp_reset(devc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 /*
@@ -353,8 +350,7 @@
 
 	devc->irq_mode = IMODE_OUTPUT;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x48))		/* DSP Block size */
 	{
 		sb_dsp_command(devc, (unsigned char) (count & 0xff));
@@ -370,7 +366,7 @@
 	}
 	else
 		printk(KERN_ERR "Sound Blaster: unable to start DAC.\n");
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 	devc->intr_active = 1;
 }
 
@@ -393,8 +389,7 @@
 
 	devc->irq_mode = IMODE_INPUT;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x48))		/* DSP Block size */
 	{
 		sb_dsp_command(devc, (unsigned char) (count & 0xff));
@@ -410,7 +405,7 @@
 	}
 	else
 		printk(KERN_ERR "Sound Blaster:  unable to start ADC.\n");
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 	devc->intr_active = 1;
 }
 
@@ -484,8 +479,7 @@
 		if (devc->bits == AFMT_S16_LE)
 			bits = 0x04;	/* 16 bit mode */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x40))
 		sb_dsp_command(devc, devc->tconst);
 	sb_dsp_command(devc, DSP_CMD_SPKOFF);
@@ -493,7 +487,7 @@
 		sb_dsp_command(devc, 0xa0 | bits);	/* Mono input */
 	else
 		sb_dsp_command(devc, 0xa8 | bits);	/* Stereo input */
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	devc->trigger_bits = 0;
 	return 0;
@@ -511,8 +505,7 @@
 	if (devc->model == MDL_SBPRO)
 		sb_mixer_set_stereo(devc, devc->channels == 2);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (sb_dsp_command(devc, 0x40))
 		sb_dsp_command(devc, devc->tconst);
 	sb_dsp_command(devc, DSP_CMD_SPKON);
@@ -536,7 +529,7 @@
 			tmp |= 0x02;
 		sb_setmixer(devc, 0x0e, tmp);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 	devc->trigger_bits = 0;
 	return 0;
 }
@@ -706,21 +699,19 @@
 	}
 
 	/* save value */
-	save_flags (flags);
-	cli ();
+	spin_lock_irqsave(&devc->lock, flags);
 	bits = devc->bits;
 	if (devc->fullduplex)
 		devc->bits = (devc->bits == AFMT_S16_LE) ?
 			AFMT_U8 : AFMT_S16_LE;
-	restore_flags (flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	cnt = count;
 	if (devc->bits == AFMT_S16_LE)
 		cnt >>= 1;
 	cnt--;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 
 	/* DMAbuf_start_dma (dev, buf, count, DMA_MODE_WRITE); */
 
@@ -736,7 +727,7 @@
 
 	/* restore real value after all programming */
 	devc->bits = bits;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 
@@ -768,8 +759,7 @@
 		cnt >>= 1;
 	cnt--;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 
 	/* DMAbuf_start_dma (dev, buf, count, DMA_MODE_READ); */
 
@@ -783,7 +773,7 @@
 	sb_dsp_command(devc, (unsigned char) (cnt & 0xff));
 	sb_dsp_command(devc, (unsigned char) (cnt >> 8));
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 static void sb16_audio_trigger(int dev, int bits)
--- linux-2.4.0/drivers/sound/sb_ess.c.orig	Fri Jan 26 13:55:19 2001
+++ linux-2.4.0/drivers/sound/sb_ess.c	Fri Jan 26 15:17:28 2001
@@ -186,6 +186,7 @@
  */
 
 #include <linux/delay.h>
+#include <linux/spinlock.h>
 
 #include "sound_config.h"
 #include "sb_mixer.h"
@@ -524,10 +525,9 @@
 	unsigned long flags;
 	sb_devc *devc = audio_devs[dev]->devc;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	sb_dsp_reset(devc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	/*
 	 * Audio 2 may still be operational! Creates awful sounds!
@@ -969,8 +969,7 @@
 	unsigned int val;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	outb(((unsigned char) (0x40 & 0xff)), MIXER_ADDR);
 
 	udelay(20);
@@ -978,7 +977,7 @@
 	udelay(20);
 	val |= inb(MIXER_DATA);
 	udelay(20);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	return val;
 }
@@ -1565,8 +1564,7 @@
 printk(KERN_INFO "FKS: write mixer %x: %x\n", port, value);
 #endif
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (port >= 0xa0) {
 		ess_write (devc, port, value);
 	} else {
@@ -1576,7 +1574,7 @@
 		outb(((unsigned char) (value & 0xff)), MIXER_DATA);
 		udelay(20);
 	};
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 unsigned int ess_getmixer (sb_devc * devc, unsigned int port)
@@ -1584,8 +1582,7 @@
 	unsigned int val;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 
 	if (port >= 0xa0) {
 		val = ess_read (devc, port);
@@ -1596,7 +1593,7 @@
 		val = inb(MIXER_DATA);
 		udelay(20);
 	}
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	return val;
 }
--- linux-2.4.0/drivers/sound/sb_midi.c.orig	Fri Jan 26 13:55:25 2001
+++ linux-2.4.0/drivers/sound/sb_midi.c	Fri Jan 26 15:19:01 2001
@@ -11,6 +11,8 @@
  * for more info.
  */
 
+#include <linux/spinlock.h>
+
 #include "sound_config.h"
 
 #include "sb.h"
@@ -36,15 +38,14 @@
 	if (devc == NULL)
 		return -ENXIO;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	if (devc->opened)
 	{
-		restore_flags(flags);
+		spin_unlock_irqrestore(&devc->lock, flags);
 		return -EBUSY;
 	}
 	devc->opened = 1;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	devc->irq_mode = IMODE_MIDI;
 	devc->midi_broken = 0;
@@ -74,13 +75,12 @@
 	if (devc == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	sb_dsp_reset(devc);
 	devc->intr_active = 0;
 	devc->input_opened = 0;
 	devc->opened = 0;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 static int sb_midi_out(int dev, unsigned char midi_byte)
@@ -131,14 +131,13 @@
 	if (devc == NULL)
 		return;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 
 	data = inb(DSP_READ);
 	if (devc->input_opened)
 		devc->midi_input_intr(devc->my_mididev, data);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 #define MIDI_SYNTH_NAME	"Sound Blaster Midi"
--- linux-2.4.0/drivers/sound/sb_common.c.orig	Fri Jan 26 13:55:12 2001
+++ linux-2.4.0/drivers/sound/sb_common.c	Fri Jan 26 23:06:02 2001
@@ -21,12 +21,16 @@
  *
  * 2000/09/18 - got rid of attach_uart401
  * Arnaldo Carvalho de Melo <acme@conectiva.com.br>
+ *
+ * 2001/01/26 - replaced CLI/STI with spinlocks
+ * Chris Rankin <rankinc@zipworld.com.au>
  */
 
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/spinlock.h>
 
 #include "sound_config.h"
 #include "sound_firmware.h"
@@ -62,6 +66,7 @@
 
 static int jazz16_base = 0;		/* Not detected */
 static unsigned char jazz16_bits = 0;	/* I/O relocation bits */
+static spinlock_t jazz16_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * Logitech Soundman Wave specific initialization code
@@ -251,8 +256,7 @@
 	unsigned long   flags;
 
 	DDB(printk("Entered dsp_get_vers()\n"));
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	devc->major = devc->minor = 0;
 	sb_dsp_command(devc, 0xe1);	/* Get version */
 
@@ -269,8 +273,8 @@
 			}
 		}
 	}
+	spin_unlock_irqrestore(&devc->lock, flags);
 	DDB(printk("DSP version %d.%02d\n", devc->major, devc->minor));
-	restore_flags(flags);
 }
 
 static int sb16_set_dma_hw(sb_devc * devc)
@@ -368,12 +372,11 @@
 	/*
 	 *	Magic wake up sequence by writing to 0x201 (aka Joystick port)
 	 */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&jazz16_lock, flags);
 	outb((0xAF), 0x201);
 	outb((0x50), 0x201);
 	outb((bits), 0x201);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&jazz16_lock, flags);
 }
 
 static int init_Jazz16(sb_devc * devc, struct address_info *hw_config)
@@ -523,6 +526,7 @@
 		return 0;
 	}
 
+	devc->lock = SPIN_LOCK_UNLOCKED;
 	devc->type = hw_config->card_subtype;
 
 	devc->base = hw_config->io_base;
@@ -552,7 +556,9 @@
 	
 	if (devc->sbmo.acer)
 	{
-		cli();
+		unsigned long flags;
+
+		spin_lock_irqsave(&devc->lock, flags);
 		inb(devc->base + 0x09);
 		inb(devc->base + 0x09);
 		inb(devc->base + 0x09);
@@ -564,7 +570,7 @@
 		inb(devc->base + 0x0b);
 		inb(devc->base + 0x09);
 		inb(devc->base + 0x00);
-		sti();
+		spin_unlock_irqrestore(&devc->lock, flags);
 	}
 	/*
 	 * Detect the device
@@ -631,7 +637,7 @@
 		printk(KERN_ERR "sb: Can't allocate memory for device information\n");
 		return 0;
 	}
-	memcpy((char *) detected_devc, (char *) devc, sizeof(sb_devc));
+	memcpy(detected_devc, devc, sizeof(sb_devc));
 	MDB(printk(KERN_INFO "SB %d.%02d detected OK (%x)\n", devc->major, devc->minor, hw_config->io_base));
 	return 1;
 }
@@ -937,15 +943,14 @@
 
 	if (devc->model == MDL_ESS) return ess_setmixer (devc, port, value);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 
 	outb(((unsigned char) (port & 0xff)), MIXER_ADDR);
 	udelay(20);
 	outb(((unsigned char) (value & 0xff)), MIXER_DATA);
 	udelay(20);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 unsigned int sb_getmixer(sb_devc * devc, unsigned int port)
@@ -955,15 +960,14 @@
 
 	if (devc->model == MDL_ESS) return ess_getmixer (devc, port);
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 
 	outb(((unsigned char) (port & 0xff)), MIXER_ADDR);
 	udelay(20);
 	val = inb(MIXER_DATA);
 	udelay(20);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	return val;
 }
@@ -986,14 +990,13 @@
 {
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&jazz16_lock, flags);  /* NOT the SB card? */
 
 	outb((addr & 0xff), base + 1);	/* Low address bits */
 	outb((addr >> 8), base + 2);	/* High address bits */
 	outb((val), base);	/* Data */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&jazz16_lock, flags);
 }
 
 static unsigned char smw_getmem(sb_devc * devc, int base, int addr)
@@ -1001,14 +1004,13 @@
 	unsigned long flags;
 	unsigned char val;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&jazz16_lock, flags);  /* NOT the SB card? */
 
 	outb((addr & 0xff), base + 1);	/* Low address bits */
 	outb((addr >> 8), base + 2);	/* High address bits */
 	val = inb(base);	/* Data */
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&jazz16_lock, flags);
 	return val;
 }
 
@@ -1168,12 +1170,11 @@
 	/*
 	 *	Magic wake up sequence by writing to 0x201 (aka Joystick port)
 	 */
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&jazz16_lock, flags);
 	outb(0xAF, 0x201);
 	outb(0x50, 0x201);
 	outb(bits, 0x201);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&jazz16_lock, flags);
 
 	hw_config->name = "Jazz16";
 	smw_midi_init(devc, hw_config);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
