Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129904AbRAZGmy>; Fri, 26 Jan 2001 01:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRAZGmp>; Fri, 26 Jan 2001 01:42:45 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:18702 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S129184AbRAZGmi>; Fri, 26 Jan 2001 01:42:38 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200101260642.f0Q6gR419611@wellhouse.underworld>
Subject: [PATCH](s): Use spinlocks instead of STI/CLI in SoundBlaster
To: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
Date: Fri, 26 Jan 2001 17:42:27 +1100 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I hear on the grapevine that 2.4 kernel modules should use spinlocks
in preference to cli() and sti(). Well I'm not sure how big a win it
is, particularly on a UP machine, but here's a patch for the
SoundBlaster. I've added a spinlock_t to the "struct b_devc" so that
multiple SoundBlasters each get their own lock. After all, each SB has
its own IRQ and IO, correct?

There also seems to be something here called a Jazz16. This has a
global lock because it looks like there can only be one of them.

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
+++ linux-2.4.0/drivers/sound/sb_common.c	Fri Jan 26 16:50:32 2001
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
@@ -552,7 +555,9 @@
 	
 	if (devc->sbmo.acer)
 	{
-		cli();
+		unsigned long flags;
+
+		spin_lock_irqsave(&devc->lock, flags);
 		inb(devc->base + 0x09);
 		inb(devc->base + 0x09);
 		inb(devc->base + 0x09);
@@ -564,7 +569,7 @@
 		inb(devc->base + 0x0b);
 		inb(devc->base + 0x09);
 		inb(devc->base + 0x00);
-		sti();
+		spin_unlock_irqrestore(&devc->lock, flags);
 	}
 	/*
 	 * Detect the device
@@ -631,7 +636,11 @@
 		printk(KERN_ERR "sb: Can't allocate memory for device information\n");
 		return 0;
 	}
-	memcpy((char *) detected_devc, (char *) devc, sizeof(sb_devc));
+	memcpy(detected_devc, devc, sizeof(sb_devc));
+	/*
+	 * This "detected_devc" hack is SCARY-ugly! Need to think of a cleaner way!
+	 */
+	detected_devc->lock = SPIN_LOCK_UNLOCKED;
 	MDB(printk(KERN_INFO "SB %d.%02d detected OK (%x)\n", devc->major, devc->minor, hw_config->io_base));
 	return 1;
 }
@@ -937,15 +946,14 @@
 
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
@@ -955,15 +963,14 @@
 
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
@@ -986,14 +993,13 @@
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
@@ -1001,14 +1007,13 @@
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
 
@@ -1168,12 +1173,11 @@
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


And for an encore, I noticed that my SoundBlaster module loaded the
uart401 module. So here's a spinlock patch for the uart401:

--- linux-2.4.0/drivers/sound/uart401.c.orig	Wed Jan 17 01:24:40 2001
+++ linux-2.4.0/drivers/sound/uart401.c	Fri Jan 26 13:51:37 2001
@@ -16,6 +16,7 @@
  *				Fixed to allow IRQ > 15
  *	Christoph Hellwig	Adapted to module_init/module_exit
  *	Arnaldo C. de Melo	got rid of check_region
+ *	Chris Rankin		Used spinlocks instead of STI/CLI
  *
  * Status:
  *		Untested
@@ -23,6 +24,7 @@
 
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/spinlock.h> 
 
 #include "sound_config.h"
 
@@ -38,6 +40,7 @@
 	volatile unsigned char input_byte;
 	int             my_dev;
 	int             share_irq;
+	spinlock_t      lock;
 }
 uart401_devc;
 
@@ -152,13 +155,12 @@
 	 * Test for input since pending input seems to block the output.
 	 */
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 
 	if (input_avail(devc))
 		uart401_input_loop(devc);
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	/*
 	 * Sometimes it takes about 13000 loops before the output becomes ready
@@ -222,8 +224,8 @@
 	int ok, timeout;
 	unsigned long flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
+
 	for (timeout = 30000; timeout > 0 && !output_ready(devc); timeout--);
 
 	devc->input_byte = 0;
@@ -237,7 +239,7 @@
 			if (uart401_read(devc) == MPU_ACK)
 				ok = 1;
 
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 }
 
 static int reset_uart401(uart401_devc * devc)
@@ -320,11 +322,11 @@
 	devc->input_byte = 0;
 	devc->my_dev = 0;
 	devc->share_irq = 0;
+	devc->lock = SPIN_LOCK_UNLOCKED;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&devc->lock, flags);
 	ok = reset_uart401(devc);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&devc->lock, flags);
 
 	if (!ok)
 		goto cleanup_devc;


Then I got cocky and noticed a CLI/STI pair in the sound_open_dma()
and sound_close_dma() functions. I couldn't identify a device to
associate the spinlock with, and so I made it global:

--- linux-2.4.0/drivers/sound/soundcard.c.orig	Tue Sep 26 06:32:54 2000
+++ linux-2.4.0/drivers/sound/soundcard.c	Fri Jan 26 15:41:49 2001
@@ -20,6 +20,7 @@
  * Richard Gooch     : moved common (non OSS-specific) devices to sound_core.c
  * Rob Riggs	     : Added persistent DMA buffers support (1998/10/17)
  * Christoph Hellwig : Some cleanup work (2000/03/01)
+ * Chris Rankin      : Protect DMA access with a spinlock
  */
 
 #include <linux/config.h>
@@ -44,6 +45,9 @@
 #include <linux/delay.h>
 #include <linux/proc_fs.h>
 #include <linux/smp_lock.h>
+#include <linux/spinlock.h>
+
+static spinlock_t dma_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  * This ought to be moved into include/asm/dma.h
@@ -672,16 +676,15 @@
 		printk(KERN_ERR "sound_open_dma: Invalid DMA channel %d\n", chn);
 		return 1;
 	}
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dma_lock, flags);
 
 	if (dma_alloc_map[chn] != DMA_MAP_FREE) {
+		spin_unlock_irqrestore(&dma_lock, flags);
 		printk("sound_open_dma: DMA channel %d busy or not allocated (%d)\n", chn, dma_alloc_map[chn]);
-		restore_flags(flags);
 		return 1;
 	}
 	dma_alloc_map[chn] = DMA_MAP_BUSY;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 	return 0;
 }
 
@@ -699,16 +702,15 @@
 {
 	unsigned long   flags;
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&dma_lock, flags);
 
 	if (dma_alloc_map[chn] != DMA_MAP_BUSY) {
+		spin_unlock_irqrestore(&dma_lock, flags);
 		printk(KERN_ERR "sound_close_dma: Bad access to DMA channel %d\n", chn);
-		restore_flags(flags);
 		return;
 	}
 	dma_alloc_map[chn] = DMA_MAP_FREE;
-	restore_flags(flags);
+	spin_unlock_irqrestore(&dma_lock, flags);
 }
 
 static void do_sequencer_timer(unsigned long dummy)


And THEN I thought that it might be a good idea to put a few "const"
declarations into a few function prototypes. I think that this kind of
stuff doesn't hurt, and might even allow someone (?) to move a few
structs (which shouldn't be changing anyway) into the .text section:


--- linux-2.4.0/drivers/sound/uart401.c.orig	Wed Jan 17 01:24:40 2001
+++ linux-2.4.0/drivers/sound/uart401.c	Thu Jan 18 01:44:49 2001
@@ -292,7 +292,7 @@
 int probe_uart401(struct address_info *hw_config, struct module *owner)
 {
 	uart401_devc *devc;
-	char *name = "MPU-401 (UART) MIDI";
+	const char *name = "MPU-401 (UART) MIDI";
 	int ok = 0;
 	unsigned long flags;
 
--- linux-2.4.0/drivers/sound/sound_calls.h.orig	Mon Apr  3 08:45:06 2000
+++ linux-2.4.0/drivers/sound/sound_calls.h	Thu Jan 18 02:49:24 2001
@@ -80,8 +80,8 @@
 /*	From soundcard.c	*/
 void request_sound_timer (int count);
 void sound_stop_timer(void);
-void conf_printf(char *name, struct address_info *hw_config);
-void conf_printf2(char *name, int base, int irq, int dma, int dma2);
+void conf_printf(const char *name, const struct address_info *hw_config);
+void conf_printf2(const char *name, int base, int irq, int dma, int dma2);
 
 /*	From sound_timer.c */
 void sound_timer_interrupt(void);
--- linux-2.4.0/drivers/sound/soundcard.c.orig	Tue Sep 26 06:32:54 2000
+++ linux-2.4.0/drivers/sound/soundcard.c	Thu Jan 18 02:47:36 2001
@@ -745,7 +745,7 @@
 	del_timer(&seq_timer);;
 }
 
-void conf_printf(char *name, struct address_info *hw_config)
+void conf_printf(const char *name, const struct address_info *hw_config)
 {
 #ifndef CONFIG_SOUND_TRACEINIT
 	return;
@@ -765,7 +765,7 @@
 #endif
 }
 
-void conf_printf2(char *name, int base, int irq, int dma, int dma2)
+void conf_printf2(const char *name, int base, int irq, int dma, int dma2)
 {
 #ifndef CONFIG_SOUND_TRACEINIT
 	return;

--- linux-vanilla/drivers/sound/dev_table.h	Fri Aug 11 16:26:43 2000
+++ linux-2.4.0-ac3/drivers/sound/dev_table.h	Mon Jan  8 18:59:13 2001
@@ -376,16 +377,16 @@
 extern int num_sound_timers;
 #endif	/* _DEV_TABLE_C_ */
 
-extern int sound_map_buffer (int dev, struct dma_buffparms *dmap, buffmem_desc *info);
 void sound_timer_init (struct sound_lowlev_timer *t, char *name);
-void sound_dma_intr (int dev, struct dma_buffparms *dmap, int chan);
 
 #define AUDIO_DRIVER_VERSION	2
 #define MIXER_DRIVER_VERSION	2
-int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
+int sound_install_audiodrv(int vers, const char *name,
+			const struct audio_driver *driver,
 			int driver_size, int flags, unsigned int format_mask,
 			void *devc, int dma1, int dma2);
-int sound_install_mixer(int vers, char *name, struct mixer_operations *driver,
+int sound_install_mixer(int vers, const char *name,
+			const struct mixer_operations *driver,
 			int driver_size, void *devc);
 
 void sound_unload_audiodev(int dev);
--- linux-vanilla/drivers/sound/dev_table.c	Mon Sep 25 20:32:54 2000
+++ linux-2.4.0-ac3/drivers/sound/dev_table.c	Mon Jan  8 19:54:48 2001
@@ -16,7 +16,8 @@
 #define _DEV_TABLE_C_
 #include "sound_config.h"
 
-int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
+int sound_install_audiodrv(int vers, const char *name,
+			const struct audio_driver *driver,
 			int driver_size, int flags, unsigned int format_mask,
 			void *devc, int dma1, int dma2)
 {
@@ -48,14 +49,14 @@
 		sound_unload_audiodev(num);
 		return -(ENOMEM);
 	}
-	memset((char *) op, 0, sizeof(struct audio_operations));
+	memset(op, 0, sizeof(struct audio_operations));
 	init_waitqueue_head(&op->in_sleeper);
 	init_waitqueue_head(&op->out_sleeper);	
 	init_waitqueue_head(&op->poll_sleeper);
 	if (driver_size < sizeof(struct audio_driver))
-		memset((char *) d, 0, sizeof(struct audio_driver));
+		memset(d, 0, sizeof(struct audio_driver));
 
-	memcpy((char *) d, (char *) driver, driver_size);
+	memcpy(d, driver, driver_size);
 
 	op->d = d;
 	l = strlen(name) + 1;
@@ -78,7 +79,8 @@
 	return num;
 }
 
-int sound_install_mixer(int vers, char *name, struct mixer_operations *driver,
+int sound_install_mixer(int vers, const char *name,
+	const struct mixer_operations *driver,
 	int driver_size, void *devc)
 {
 	struct mixer_operations *op;
@@ -107,8 +109,8 @@
 		printk(KERN_ERR "Sound: Can't allocate mixer driver for (%s)\n", name);
 		return -ENOMEM;
 	}
-	memset((char *) op, 0, sizeof(struct mixer_operations));
-	memcpy((char *) op, (char *) driver, driver_size);
+	memset(op, 0, sizeof(struct mixer_operations));
+	memcpy(op, driver, driver_size);
 
 	l = strlen(name) + 1;
 	if (l > sizeof(op->name))


OK, that's all. I think that the const-stuff is trivial in the sense
that once the function bodies compile then you're home and dry because
their callers don't care. I'm more concerned about the spinlock stuff
- would 2.4's improved locking scheme make some of them completely
redundant anyway?

Cheers,
Chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
