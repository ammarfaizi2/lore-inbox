Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261419AbSJ1Rna>; Mon, 28 Oct 2002 12:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSJ1Rn3>; Mon, 28 Oct 2002 12:43:29 -0500
Received: from gateway.cinet.co.jp ([210.166.75.129]:1808 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S261419AbSJ1RYF>; Mon, 28 Oct 2002 12:24:05 -0500
Date: Tue, 29 Oct 2002 02:30:21 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCHSET 21/23] add support for PC-9800 architecture (sound oss #1)
Message-ID: <20021029023021.A2343@precia.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a part 21/23 of patchset for add support NEC PC-9800 architecture,
against 2.5.44.

Summary:
 OSS sound driver related modules.
  - add hardware specific initialization.
  - IO port address and IRQ number change.

diffstat:
 sound/oss/Config.in      |   16 ++++
 sound/oss/Makefile       |    1 
 sound/oss/ad1848.c       |   45 +++++++++++
 sound/oss/dev_table.h    |    3 
 sound/oss/dmabuf.c       |    3 
 sound/oss/mpu401.c       |  178 +++++++++++++++++++++++++++++++++++++++++++++++
 sound/oss/opl3.c         |  132 +++++++++++++++++++++++++++++++++-
 sound/oss/sb.h           |   34 ++++++++
 sound/oss/sb_common.c    |  103 ++++++++++++++++++++++++++-
 sound/oss/sound_config.h |   12 +++
 sound/oss/uart401.c      |   17 ++++
 11 files changed, 538 insertions(+), 6 deletions(-)

patch:
diff -urN linux/sound/oss/Config.in linux98/sound/oss/Config.in
--- linux/sound/oss/Config.in	Sat Oct 19 13:02:24 2002
+++ linux98/sound/oss/Config.in	Sat Oct 19 16:35:25 2002
@@ -132,6 +132,9 @@
   
    dep_tristate '    Microsoft Sound System support' CONFIG_SOUND_MSS $CONFIG_SOUND_OSS
    dep_tristate '    MPU-401 support (NOT for SB16)' CONFIG_SOUND_MPU401 $CONFIG_SOUND_OSS
+     if [ "$CONFIG_SOUND_MPU401" != "n" -a "$CONFIG_PC9800" = "y" ]; then
+        dep_bool '      Roland MPU-PC98II support' CONFIG_MPU_PC98II y
+     fi
    dep_tristate '    NM256AV/NM256ZX audio support' CONFIG_SOUND_NM256 $CONFIG_SOUND_OSS
    dep_tristate '    OPTi MAD16 and/or Mozart based cards' CONFIG_SOUND_MAD16 $CONFIG_SOUND_OSS $CONFIG_SOUND_GAMEPORT
    if [ "$CONFIG_SOUND_MAD16" = "y" -o "$CONFIG_SOUND_MAD16" = "m" ]; then
@@ -151,6 +154,9 @@
 
    dep_tristate '    100% Sound Blaster compatibles (SB16/32/64, ESS, Jazz16) support' CONFIG_SOUND_SB $CONFIG_SOUND_OSS
    dep_tristate '    AWE32 synth' CONFIG_SOUND_AWE32_SYNTH $CONFIG_SOUND_OSS
+   if [ "$CONFIG_PC9800" = "y" -a "$CONFIG_SOUND_SB" != "n" ]; then
+ 	define_bool CONFIG_SB16_PC9800 y
+   fi
    dep_tristate '    Full support for Turtle Beach WaveFront (Tropez Plus, Tropez, Maui) synth/soundcards' CONFIG_SOUND_WAVEFRONT $CONFIG_SOUND_OSS m
    dep_tristate '    Limited support for Turtle Beach Wave Front (Maui, Tropez) synthesizers' CONFIG_SOUND_MAUI $CONFIG_SOUND_OSS
    if [ "$CONFIG_SOUND_MAUI" = "y" ]; then
@@ -161,6 +167,9 @@
    fi
 
    dep_tristate '    Yamaha FM synthesizer (YM3812/OPL-3) support' CONFIG_SOUND_YM3812 $CONFIG_SOUND_OSS
+   if [ "$CONFIG_PC9800" = "y" -a "$CONFIG_SOUND_YM3812" != "n" ]; then
+       define_bool CONFIG_PC9801_118 y
+   fi
    dep_tristate '    Yamaha OPL3-SA1 audio controller' CONFIG_SOUND_OPL3SA1 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha OPL3-SA2 and SA3 based PnP cards' CONFIG_SOUND_OPL3SA2 $CONFIG_SOUND_OSS
    dep_tristate '    Yamaha YMF7xx PCI audio (native mode)' CONFIG_SOUND_YMFPCI $CONFIG_SOUND_OSS $CONFIG_PCI
@@ -197,6 +206,13 @@
       dep_tristate '    Netwinder WaveArtist' CONFIG_SOUND_WAVEARTIST $CONFIG_SOUND_OSS $CONFIG_ARCH_NETWINDER
    fi
 
+   if [ "$CONFIG_PC9800" = "y" -a "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      dep_tristate '    NEC PC-9801-86 PCM support' CONFIG_SOUND_PC9801_86 $CONFIG_SOUND_OSS
+      if [ "$CONFIG_SOUND_PC9801_86" != "n" ]; then
+         hex '      PC-9801-86 I/O base' CONFIG_PC9801_86_BASE a460
+      fi
+   fi
+
 fi
 
 dep_tristate '  TV card (bt848) mixer support' CONFIG_SOUND_TVMIXER $CONFIG_SOUND $CONFIG_I2C
diff -urN linux/sound/oss/Makefile linux98/sound/oss/Makefile
--- linux/sound/oss/Makefile	Fri Aug  2 06:16:16 2002
+++ linux98/sound/oss/Makefile	Wed Aug  7 10:04:10 2002
@@ -42,6 +42,7 @@
 obj-$(CONFIG_SOUND_AD1816)	+= ad1816.o
 obj-$(CONFIG_SOUND_ACI_MIXER)	+= aci.o
 obj-$(CONFIG_SOUND_AWE32_SYNTH)	+= awe_wave.o
+obj-$(CONFIG_SOUND_PC9801_86)	+= pc9801_86_pcm.o
 
 obj-$(CONFIG_SOUND_VIA82CXXX)	+= via82cxxx_audio.o ac97_codec.o
 ifeq ($(CONFIG_MIDI_VIA82CXXX),y)
diff -urN linux/sound/oss/ad1848.c linux98/sound/oss/ad1848.c
--- linux/sound/oss/ad1848.c	Sat Oct 19 13:01:59 2002
+++ linux98/sound/oss/ad1848.c	Sat Oct 19 16:24:54 2002
@@ -57,6 +57,10 @@
 #include "ad1848.h"
 #include "ad1848_mixer.h"
 
+#ifdef CONFIG_PC9800
+#include <sound/sound_pc9800.h>
+#endif
+
 typedef struct
 {
 	spinlock_t	lock;
@@ -2563,6 +2567,9 @@
 	}
 	DDB(printk("MSS signature = %x\n", tmp & 0x3f));
 	if ((tmp & 0x3f) != 0x04 &&
+#ifdef CONFIG_PC9800
+	    (tmp & 0x3f) != 0x05 &&
+#endif
 	    (tmp & 0x3f) != 0x0f &&
 	    (tmp & 0x3f) != 0x00)
 	{
@@ -2576,12 +2583,19 @@
 		hw_config->card_subtype = 1;
 		return 1;
 	}
+#ifndef CONFIG_PC9800
 	if ((hw_config->irq != 5)  &&
 	    (hw_config->irq != 7)  &&
 	    (hw_config->irq != 9)  &&
 	    (hw_config->irq != 10) &&
 	    (hw_config->irq != 11) &&
 	    (hw_config->irq != 12))
+#else /* CONFIG_PC9800 */
+	if ((hw_config->irq != 3)  &&
+	    (hw_config->irq != 5)  &&
+	    (hw_config->irq != 10) &&
+	    (hw_config->irq != 12))
+#endif /* CONFIG_PC9800 */
 	{
 		printk(KERN_ERR "MSS: Bad IRQ %d\n", hw_config->irq);
 		return 0;
@@ -2610,10 +2624,24 @@
 
 void attach_ms_sound(struct address_info *hw_config, struct module *owner)
 {
+#ifndef CONFIG_PC9800
 	static signed char interrupt_bits[12] =
 	{
 		-1, -1, -1, -1, -1, 0x00, -1, 0x08, -1, 0x10, 0x18, 0x20
 	};
+#else /* CONFIG_PC9800 */
+	/* Valid IRQs are: 3 (INT0), 5 (INT1), 10 (INT41), 12 (INT5) */
+	static signed char interrupt_bits[13] =
+	{
+		-1, -1, -1, 0x08, -1, 0x10, -1, -1, -1, -1, 0x18, -1, 0x20 
+	};
+/* # ifdef CONFIG_PC9800_CANBE ??? */
+	static signed char interrupt_bits2[13] =
+	{
+		-1, -1, -1, 0x03, -1, 0x08, -1, -1, -1, -1, 0x02, -1, 0x00
+	};
+/* # endif */
+#endif /* CONFIG_PC9800 */
 	signed char     bits;
 	char            dma2_bit = 0;
 
@@ -2648,6 +2676,23 @@
 		printk(KERN_ERR "MSS: Bad IRQ %d\n", hw_config->irq);
 		return;
 	}
+
+#ifdef CONFIG_PC9800
+	if (PC9800_SOUND_ID() == PC9800_SOUND_ID_118) {
+		/* Set up CanBe control registers. */
+		unsigned long flags;
+		static spinlock_t canbe_lock = SPIN_LOCK_UNLOCKED;
+
+		printk(KERN_DEBUG "MSS: "
+			"Setting up CanBe Sound System control register\n");
+		spin_lock_irqsave(&canbe_lock, flags);
+		outb(inb(PC9800_SOUND_IO_ID) | 0x3, PC9800_SOUND_IO_ID);
+		outb(0x01, 0x0f4a);
+		outb(interrupt_bits2[hw_config->irq], 0x0f4b);
+		spin_unlock_irqrestore(&canbe_lock, flags);
+	}
+#endif /* CONFIG_PC9800 */
+
 	outb((bits | 0x40), config_port);
 	if ((inb(version_port) & 0x40) == 0)
 		printk(KERN_ERR "[MSS: IRQ Conflict?]\n");
diff -urN linux/sound/oss/dev_table.h linux98/sound/oss/dev_table.h
--- linux/sound/oss/dev_table.h	Sun Sep  1 07:05:30 2002
+++ linux98/sound/oss/dev_table.h	Sun Sep  1 10:26:10 2002
@@ -34,6 +34,9 @@
 #define SNDCARD_OPL3SA2_MPU             43
 #define SNDCARD_WAVEARTIST              44	/* Waveartist */
 #define SNDCARD_OPL3SA2_MSS             45	/* Originally missed */
+#ifdef CONFIG_PC9800
+#define SNDCARD_PC9801_86               86	/* PC-9801-86 */
+#endif
 #define SNDCARD_AD1816                  88
 
 /*
diff -urN linux/sound/oss/dmabuf.c linux98/sound/oss/dmabuf.c
--- linux/sound/oss/dmabuf.c	Sun Aug 11 10:41:18 2002
+++ linux98/sound/oss/dmabuf.c	Fri Aug 23 20:36:52 2002
@@ -153,6 +157,9 @@
 	/* printk( "Start DMA%d %d, %d\n",  chan,  (int)(physaddr-dmap->raw_buf_phys),  count); */
 
 	flags = claim_dma_lock();
+#ifdef CONFIG_PC9800
+	outb(chan,0x29);
+#endif /* CONFIG_PC9800 */
 	disable_dma(chan);
 	clear_dma_ff(chan);
 	set_dma_mode(chan, dma_mode);
diff -urN linux/sound/oss/mpu401.c linux98/sound/oss/mpu401.c
--- linux/sound/oss/mpu401.c	Tue Sep 10 02:35:16 2002
+++ linux98/sound/oss/mpu401.c	Thu Sep 12 22:54:17 2002
@@ -71,9 +71,15 @@
 	  spinlock_t	lock;
   };
 
+#if !defined(CONFIG_SB16_PC9800) && !defined(CONFIG_MPU_PC98II)
 #define	DATAPORT(base)   (base)
 #define	COMDPORT(base)   (base+1)
 #define	STATPORT(base)   (base+1)
+#else
+#define	DATAPORT(base)   (base)
+#define	COMDPORT(base)   (base+2)
+#define	STATPORT(base)   (base+2)
+#endif
 
 
 static void mpu401_close(int dev);
@@ -1023,7 +1029,11 @@
 			mpu401_chk_version(m, devc);
 			spin_unlock_irqrestore(&devc->lock,flags);
 	}
+#if !defined(CONFIG_SB16_PC9800) && !defined(CONFIG_MPU_PC98II)
 	request_region(hw_config->io_base, 2, "mpu401");
+#else
+	request_region(hw_config->io_base, 4, "mpu401");
+#endif
 
 	if (devc->version != 0)
 		if (mpu_cmd(m, 0xC5, 0) >= 0)	/* Set timebase OK */
@@ -1152,7 +1162,12 @@
 		{
 			spin_lock_irqsave(&devc->lock,flags);
 			if (input_avail(devc))
+#ifdef CONFIG_PC9801_118
+				/* PC-9801-118 doesn't respond ACK for RESET Command */
+				read_data(devc);
+#else
 				if (read_data(devc) == MPU_ACK)
+#endif
 					ok = 1;
 			spin_unlock_irqrestore(&devc->lock,flags);
 		}
@@ -1194,7 +1209,11 @@
 	int ok = 0;
 	struct mpu_config tmp_devc;
 
+#if !defined(CONFIG_SB16_PC9800) && !defined(CONFIG_MPU_PC98II)
 	if (check_region(hw_config->io_base, 2))
+#else
+	if (check_region(hw_config->io_base, 4))
+#endif
 	{
 		printk(KERN_ERR "mpu401: I/O port %x already in use\n\n", hw_config->io_base);
 		return 0;
@@ -1208,7 +1227,162 @@
 	if (hw_config->always_detect)
 		return 1;
 
+#ifdef CONFIG_PC9801_118
+	{
+		#include <sound/pc9801_118_magic.h>
+		#define outp118(reg,data) outb((reg),0x148e);outb((data),0x148f)
+		#define WAIT118 outb(0x00,0x5f)
+		int	mpu_intr, count;
+#ifdef OOKUBO_ORIGINAL
+		int	err = 0;
+#endif /* OOKUBO_ORIGINAL */
+
+		switch (hw_config->irq)
+		{
+			case 3:
+				mpu_intr = 3;
+				break;
+			case 5:
+				mpu_intr = 2;
+				break;
+			case 6:
+				mpu_intr = 1;
+				break;
+			case 10:
+				mpu_intr = 0;
+				break;
+			default:
+				printk(KERN_ERR "mpu401: Bad irq %d\n\n", hw_config->irq);
+				return 0;
+		}
+
+		outp118(0x21, mpu_intr);
+		WAIT118;
+		outb(0x00, 0x148e);
+		if (inb(0x148f) & 0x08)
+		{
+			printk(KERN_DEBUG "mpu401: No MIDI daughter board found\n\n");
+			goto exit_mode_118;
+		}
+
+		outp118(0x20, 0x00);
+		outp118(0x05, 0x04);
+		for (count = 0; count < 35000; count ++)
+			WAIT118;
+		outb(0x05, 0x148e);
+		for (count = 0; count < 65000; count ++)
+			if (inb(0x148f) == 0x04)
+				goto set_mode_118;
+		printk(KERN_ERR "mpu401: MIDI daughter board initalize failed at stage1\n\n");
+		return 0;
+
+		set_mode_118:
+		outp118(0x05, 0x0c);
+		outb(0xaa, 0x485);
+		outb(0x99, 0x485);
+		outb(0x2a, 0x485);
+		for (count = 0; count < sizeof(Data0485_99); count ++)
+		{
+			outb(Data0485_99[count], 0x485);
+			WAIT118;
+		}
+
+		outb(0x00, 0x486);
+		outb(0xaa, 0x485);
+		outb(0x9e, 0x485);
+		outb(0x2a, 0x485);
+		for (count = 0; count < sizeof(Data0485_9E); count ++)
+			if (inb(0x485) != Data0485_9E[count])
+			{
+#ifdef OOKUBO_ORIGINAL
+				err = 1;
+#endif /* OOKUBO_ORIGINAL */
+				break;
+			}
+		outb(0x00, 0x486);
+		for (count = 0; count < 2000; count ++)
+			WAIT118;
+#ifdef OOKUBO_ORIGINAL
+		if (!err)
+		{
+			outb(0xaa, 0x485);
+			outb(0x36, 0x485);
+			outb(0x28, 0x485);
+			for (count = 0; count < sizeof(Data0485_36); count ++)
+				outb(Data0485_36[count], 0x485);
+			outb(0x00, 0x486);
+			for (count = 0; count < 1500; count ++)
+				WAIT118;
+			outp118(0x05, inb(0x148f) | 0x08);
+			outb(0xff, 0x148c);
+			outp118(0x05, inb(0x148f) & 0xf7);
+			for (count = 0; count < 1500; count ++)
+				WAIT118;
+		}
+#endif /* OOKUBO_ORIGINAL */
+
+		outb(0xaa, 0x485);
+		outb(0xa9, 0x485);
+		outb(0x21, 0x485);
+		for (count = 0; count < sizeof(Data0485_A9); count ++)
+		{
+			outb(Data0485_A9[count], 0x485);
+			WAIT118;
+		}
+
+		outb(0x00, 0x486);
+		outb(0xaa, 0x485);
+		outb(0x0c, 0x485);
+		outb(0x20, 0x485);
+		for (count = 0; count < sizeof(Data0485_0C); count ++)
+		{
+			outb(Data0485_0C[count], 0x485);
+			WAIT118;
+		}
+
+		outb(0x00, 0x486);
+		outb(0xaa, 0x485);
+		outb(0x66, 0x485);
+		outb(0x20, 0x485);
+		for (count = 0; count < sizeof(Data0485_66); count ++)
+		{
+			outb(Data0485_66[count], 0x485);
+			WAIT118;
+		}
+
+		outb(0x00, 0x486);
+		outb(0xaa, 0x485);
+		outb(0x60, 0x485);
+		outb(0x20, 0x485);
+		for (count = 0; count < sizeof(Data0485_60); count ++)
+		{
+			outb(Data0485_60[count], 0x485);
+			WAIT118;
+		}
+
+		outb(0x00, 0x486);
+		outp118(0x05, 0x04);
+		outp118(0x05, 0x00);
+		for (count = 0; count < 35000; count ++)
+			WAIT118;
+		outb(0x05, 0x148e);
+		for (count = 0; count < 65000; count ++)
+			if (inb(0x148f) == 0x00)
+				goto end_mode_118;
+		printk(KERN_ERR "mpu401: MIDI daughter board initalize failed at stage2\n\n");
+		return 0;
+
+		end_mode_118:
+		outb(0x3f, 0x148d);
+		exit_mode_118:
+	}
+#endif /* CONFIG_PC9801_118 */
+
+#if !defined(CONFIG_SB16_PC9800) && !defined(CONFIG_MPU_PC98II)
 	if (inb(hw_config->io_base + 1) == 0xff)
+#else
+	if (inb(hw_config->io_base + 2) == 0xff)
+#endif
 	{
 		DDB(printk("MPU401: Port %x looks dead.\n", hw_config->io_base));
 		return 0;	/* Just bus float? */
@@ -1227,7 +1401,11 @@
 	void *p;
 	int n=hw_config->slots[1];
 	
+#if !defined(CONFIG_SB16_PC9800) && !defined(CONFIG_MPU_PC98II)
 	release_region(hw_config->io_base, 2);
+#else
+	release_region(hw_config->io_base, 4);
+#endif
 	if (hw_config->always_detect == 0 && hw_config->irq > 0)
 		free_irq(hw_config->irq, (void *)n);
 	p=mpu401_synth_operations[n];
diff -urN linux/sound/oss/opl3.c linux98/sound/oss/opl3.c
--- linux/sound/oss/opl3.c	Tue Oct  8 03:24:38 2002
+++ linux98/sound/oss/opl3.c	Fri Oct 11 13:54:21 2002
@@ -37,6 +37,10 @@
 #include "opl3.h"
 #include "opl3_hw.h"
 
+#ifdef CONFIG_PC9800
+#include <sound/sound_pc9800.h>
+#endif
+
 #define MAX_VOICE	18
 #define OFFS_4OP	11
 
@@ -74,6 +78,9 @@
 
 	int             is_opl4;
 	int            *osp;
+#ifdef CONFIG_PC9800
+	int             is_sb16;
+#endif
 } opl_devinfo;
 
 static struct opl_devinfo *devc = NULL;
@@ -182,10 +189,43 @@
 		printk(KERN_WARNING "opl3: I/O port 0x%x already in use\n", ioaddr);
 		goto cleanup_devc;
 	}
+#ifdef CONFIG_PC9800
+	if (devc->is_sb16) {
+		if (!request_region(ioaddr + 0x200, 2, devc->fm_info.name)) {
+			printk(KERN_WARNING "opl3: I/O port 0x%x already in use\n", ioaddr + 0x200);
+			goto cleanup_region2;
+		}
+		if (!request_region(ioaddr + 0x800, 2, devc->fm_info.name)) {
+			printk(KERN_WARNING "opl3: I/O port 0x%x already in use\n", ioaddr + 0x800);
+			goto cleanup_region1;
+		}
+	}
+#endif
 
 	devc->osp = osp;
 	devc->base = ioaddr;
 
+#ifdef CONFIG_PC9800
+	switch (PC9800_SOUND_ID()) {
+	case PC9800_SOUND_ID_XMATE:
+	case PC9800_SOUND_ID_118:
+		outb(inb(PC9800_SOUND_IO_ID) | 0x3, PC9800_SOUND_IO_ID);
+		printk(KERN_INFO "opl3: PC-9801-118 (or compatible) found,"
+		       " and enabled OPL-3 functions.\n");
+		devc->is_sb16 = 0;
+		break;
+	case PC9800_SOUND_ID_UNKNOWN:
+		printk(KERN_INFO "opl3: Sound ID is UNKNOWN."
+		       " Try to detect SB16 for PC-9800.\n");
+		devc->is_sb16 = 1;
+		break;
+	default:
+		printk(KERN_ERR "opl3: "
+		       "This sound system doesn't support OPL-3.\n");
+		return 0;
+	}
+#endif
+
 	/* Reset timers 1 and 2 */
 	opl3_command(ioaddr, TIMER_CONTROL_REGISTER, TIMER1_MASK | TIMER2_MASK);
 
@@ -216,10 +256,15 @@
 		 * only after a cold boot. In addition the OPL4 port
 		 * of the chip may not be connected to the PC bus at all.
 		 */
-
+#ifndef CONFIG_PC9800
 		opl3_command(ioaddr + 2, OPL3_MODE_REGISTER, 0x00);
 		opl3_command(ioaddr + 2, OPL3_MODE_REGISTER, OPL3_ENABLE | OPL4_ENABLE);
-
+#else
+		opl3_command(ioaddr + (devc->is_sb16 ? 0x200 : 2),
+			     OPL3_MODE_REGISTER, 0x00);
+		opl3_command(ioaddr + (devc->is_sb16 ? 0x200 : 2),
+			     OPL3_MODE_REGISTER, OPL3_ENABLE | OPL4_ENABLE);
+#endif
 		if ((tmp = inb(ioaddr)) == 0x02)	/* Have a OPL4 */
 		{
 			detected_model = 4;
@@ -248,7 +293,12 @@
 				detected_model = 3;
 			}
 		}
+#ifndef CONFIG_PC9800
 		opl3_command(ioaddr + 2, OPL3_MODE_REGISTER, 0);
+#else
+		opl3_command(ioaddr + (devc->is_sb16 ? 0x200 : 2),
+			     OPL3_MODE_REGISTER, 0);
+#endif
 	}
 	for (i = 0; i < 9; i++)
 		opl3_command(ioaddr, KEYON_BLOCK + i, 0);	/*
@@ -261,6 +311,14 @@
 								 */
 	return 1;
 cleanup_region:
+#ifdef CONFIG_PC9800
+	if (devc->is_sb16) {
+		release_region(ioaddr + 0x800, 2);
+cleanup_region1:
+		release_region(ioaddr + 0x200, 2);
+cleanup_region2:
+	}
+#endif
 	release_region(ioaddr, 4);
 cleanup_devc:
 	kfree(devc);
@@ -735,9 +793,12 @@
 	else
 		for (i = 0; i < 2; i++)
 			inb(io_addr);
-
+#ifndef CONFIG_PC9800
 	outb(((unsigned char) (val & 0xff)), io_addr + 1);
-
+#else
+	outb(((unsigned char) (val & 0xff)),
+	     io_addr + (devc->is_sb16 ? 0x100 : 1));
+#endif
 	if (devc->model != 2)
 		udelay(30);
 	else
@@ -1102,6 +1163,33 @@
 	setup_voice:	opl3_setup_voice
 };
 
+#ifdef CONFIG_PC9801_118
+static inline void pc9801_118_opl3_init(unsigned long ioaddr)
+{
+	/* ??? */
+	outb(0x00, ioaddr + 6);
+	inb(ioaddr + 7);
+	/* Enable OPL-3 Function */
+	outb(inb(PC9800_SOUND_IO_ID)|0x03, PC9800_SOUND_IO_ID);
+
+	/* Initialize? */
+	opl3_command(ioaddr + 2, 0x05, 0x05);
+	opl3_command(ioaddr + 2, 0x08, 0x04);
+	opl3_command(ioaddr + 2, 0x08, 0x00);
+	opl3_command(ioaddr, 0xf7, 0x00);
+	opl3_command(ioaddr, 0x04, 0x60);
+	opl3_command(ioaddr, 0x04, 0x80);
+	inb(ioaddr);
+
+	opl3_command(ioaddr, 0x02, 0xff);
+	opl3_command(ioaddr, 0x04, 0x21);
+	inb(ioaddr);
+
+	opl3_command(ioaddr, 0x04, 0x60);
+	opl3_command(ioaddr, 0x04, 0x80);
+}
+#endif
+
 int opl3_init(int ioaddr, int *osp, struct module *owner)
 {
 	int i;
@@ -1119,6 +1207,27 @@
 		return -1;
 	}
 
+#ifdef CONFIG_PC9800
+	/* Inspect Sound Functions ID */
+	switch (PC9800_SOUND_ID()){
+#ifdef CONFIG_PC9801_118
+	case PC9800_SOUND_ID_XMATE:
+	case PC9800_SOUND_ID_118:
+		pc9801_118_opl3_init(ioaddr);
+		devc->is_sb16 = 0;
+		break;
+#endif
+#ifdef CONFIG_SB16_PC9800
+	case PC9800_SOUND_ID_UNKNOWN:
+		devc->is_sb16 = 1;
+		break;
+#endif
+	default:
+		printk(KERN_ERR "opl3: Sorry, this driver is not configured for your sound system.\n");
+		return -1;
+	}
+#endif
+
 	devc->nr_voice = 9;
 
 	devc->fm_info.device = 0;
@@ -1131,7 +1240,14 @@
 	devc->fm_info.capabilities = 0;
 	devc->left_io = ioaddr;
 	devc->right_io = ioaddr + 2;
-
+#ifdef CONFIG_PC9800
+#define OPL3_LEFT     0x20d2
+#define OPL3_RIGHT    0x22d2
+	if (devc->is_sb16) {
+		devc->left_io = OPL3_LEFT;
+		devc->right_io = OPL3_RIGHT;
+	}
+#endif
 	if (detected_model <= 2)
 		devc->model = 1;
 	else
@@ -1223,6 +1339,12 @@
 	{
 		if (devc->base) {
 			release_region(devc->base,4);
+#ifdef CONFIG_PC9800
+			if (devc->is_sb16) {
+				release_region(devc->base + 0x800, 2);
+				release_region(devc->base + 0x200, 2);
+			}
+#endif
 			if (devc->is_opl4)
 				release_region(devc->base - 8, 2);
 		}
diff -urN linux/sound/oss/sb.h linux98/drivers/sound/sb.h
--- linux/sound/oss/sb.h	Sat Feb 17 09:02:37 2001
+++ linux98/sound/oss/sb.h	Fri Aug 17 21:50:17 2001
@@ -1,3 +1,7 @@
+#include <linux/config.h>
+
+#ifndef CONFIG_SB16_PC9800
+
 #define DSP_RESET	(devc->base + 0x6)
 #define DSP_READ	(devc->base + 0xA)
 #define DSP_WRITE	(devc->base + 0xC)
@@ -10,6 +14,26 @@
 #define OPL3_LEFT	(devc->base + 0x0)
 #define OPL3_RIGHT	(devc->base + 0x2)
 #define OPL3_BOTH	(devc->base + 0x8)
+
+#else /* CONFIG_SB16_PC9800 */
+
+#define _SB_98_IOINCR	(devc->type == MDL_SB16_PC9800 ? 0x100 : 1)
+
+#define DSP_RESET	(devc->base + 0x6 * _SB_98_IOINCR)
+#define DSP_READ	(devc->base + 0xA * _SB_98_IOINCR)
+#define DSP_WRITE	(devc->base + 0xC * _SB_98_IOINCR)
+#define DSP_COMMAND	(devc->base + 0xC * _SB_98_IOINCR)
+#define DSP_STATUS	(devc->base + 0xC * _SB_98_IOINCR)
+#define DSP_DATA_AVAIL	(devc->base + 0xE * _SB_98_IOINCR)
+#define DSP_DATA_AVL16	(devc->base + 0xF * _SB_98_IOINCR)
+#define MIXER_ADDR	(devc->base + 0x4 * _SB_98_IOINCR)
+#define MIXER_DATA	(devc->base + 0x5 * _SB_98_IOINCR)
+#define OPL3_LEFT	(devc->base + 0x0 * _SB_98_IOINCR)
+#define OPL3_RIGHT	(devc->base + 0x2 * _SB_98_IOINCR)
+#define OPL3_BOTH	(devc->base + 0x8 * _SB_98_IOINCR)
+
+#endif /* CONFIG_SB16_PC9800 */
+
 /* DSP Commands */
 
 #define DSP_CMD_SPKON		0xD1
@@ -46,6 +70,10 @@
 #define MDL_ESSPCI	16	/* ESS PCI card */
 #define MDL_YMPCI	17	/* Yamaha PCI sb in emulation */
 
+#ifdef CONFIG_SB16_PC9800
+#define MDL_SB16_PC9800	9801 /* SB16 for PC-9800 */
+#endif
+
 #define SUBMDL_ALS007	42	/* ALS-007 differs from SB16 only in mixer */
 				/* register assignment */
 #define SUBMDL_ALS100	43	/* ALS-100 allows sampling rates of up */
@@ -175,6 +203,12 @@
 int sb_audio_open(int dev, int mode);
 void sb_audio_close(int dev);
 
+#ifdef CONFIG_SB16_PC9800
+int sb16_pc9800_check_region(int ioaddr);
+void sb16_pc9800_request_region(int ioaddr, const char *name);
+void sb16_pc9800_release_region(int ioaddr);
+#endif
+
 extern sb_devc *last_sb;
 
 /*	From sb_common.c */
diff -urN linux/sound/oss/sb_common.c linux98/sound/oss/sb_common.c
--- linux/sound/oss/sb_common.c	Sun Aug 11 10:41:18 2002
+++ linux98/sound/oss/sb_common.c	Fri Aug 23 20:39:27 2002
@@ -305,6 +305,9 @@
 	switch (hw_config->io_base)
 	{
 		case 0x300:
+#ifdef CONFIG_SB16_PC9800
+		case 0x80d2:
+#endif
 			sb_setmixer(devc, 0x84, bits | 0x04);
 			break;
 
@@ -322,6 +324,26 @@
 {
 	int ival;
 
+#ifdef CONFIG_SB16_PC9800
+	if (devc->type == MDL_SB16_PC9800)
+		switchh (level)
+		{
+		case 3:
+			ival = 1;
+			break;
+		case 5:
+			ival = 8;
+			break;
+		case 10:
+			ival = 2;
+			break;
+		default:
+			printk(KERN_ERR "SB16: Invalid IRQ%d\n", level);
+			return 0;
+		}
+	else
+#endif
+
 	switch (level)
 	{
 		case 5:
@@ -518,7 +541,13 @@
 	 */
 	
 	DDB(printk("sb_dsp_detect(%x) entered\n", hw_config->io_base));
+#ifndef CONFIG_SB16_PC9800
 	if (check_region(hw_config->io_base, 16))
+#else
+	if (hw_config->card_subtype == MDL_SB16_PC9800
+	    ? sb16_pc9800_check_region(hw_config->io_base, 16)
+	    : check_region(hw_config->io_base, 16))
+#endif
 	{
 #ifdef MODULE
 		printk(KERN_INFO "sb: I/O region in use.\n");
@@ -532,8 +561,11 @@
 	devc->base = hw_config->io_base;
 	devc->irq = hw_config->irq;
 	devc->dma8 = hw_config->dma;
-
+#ifdef CONFIG_SB16_PC9800
+	devc->dma16 = hw_config->dma;
+#else
 	devc->dma16 = -1;
+#endif
 	devc->pcibase = pciio;
 	
 	if(pci == SB_PCI_ESSMAESTRO)
@@ -733,6 +764,11 @@
 			}
 		}
 	}			/* IRQ setup */
+#ifdef CONFIG_SB16_PC9800
+	if (devc->type == MDL_SB16_PC9800)
+		sb16_pc9800_request_region(hw_config->io_base, "soundblaster");
+	else
+#endif
 	request_region(hw_config->io_base, 16, "soundblaster");
 
 	last_sb = devc;
@@ -796,6 +832,13 @@
 				}
 				sb_setmixer(devc,0x30,mixer30);
 			}
+#ifdef CONFIG_SB16_PC9800
+			else if (devc->type == MDL_SB16_PC9800){
+				/* devc->submodel = SUBMDL_SB16_PC9800; */
+				if(hw_config->name == NULL)
+					hw_config->name = "Sound Blaster 16 (for PC-9800)";
+			}
+#endif
 			else if (hw_config->name == NULL)
 				hw_config->name = "Sound Blaster 16";
 
@@ -803,7 +846,9 @@
 				devc->dma16 = devc->dma8;
 			else if (hw_config->dma2 < 5 || hw_config->dma2 > 7)
 			{
+#ifndef CONFIG_SB16_PC9800
 				printk(KERN_WARNING  "SB16: Bad or missing 16 bit DMA channel\n");
+#endif
 				devc->dma16 = devc->dma8;
 			}
 			else
@@ -811,7 +856,13 @@
 
 			if(!sb16_set_dma_hw(devc)) {
 				free_irq(devc->irq, devc);
+#ifdef CONFIG_SB16_PC9800
+				if(devc->type == MDL_SB16_PC9800)
+					sb16_pc9800_release_region(hw_config->io_base);
+				else
+#endif
 			        release_region(hw_config->io_base, 16);
+
 				return 0;
 			}
 
@@ -900,6 +951,11 @@
 	{
 		if ((devc->model & MDL_ESS) && devc->pcibase)
 			release_region(devc->pcibase, 8);
+#ifdef CONFIG_SB16_PC9800
+		if(devc->type == MDL_SB16_PC9800)
+			sb16_pc9800_release_region(devc->base);
+		else
+#endif
 
 		release_region(devc->base, 16);
 
@@ -1240,6 +1295,18 @@
 	switch (devc->model)
 	{
 		case MDL_SB16:
+#ifdef CONFIG_SB16_PC9800
+			if (devc->type == MDL_SB16_PC9800)
+			{
+				if (hw_config->io_base != 0x80d2
+				    || hw_config->io_base != 0xc8d2)
+				{
+					printk(KERN_ERR "SB16: Invalid MIDI port %x\n", hw_config->io_base);
+					return 0;
+				}
+			}
+			else
+#endif
 			if (hw_config->io_base != 0x300 && hw_config->io_base != 0x330)
 			{
 				printk(KERN_ERR "SB16: Invalid MIDI port %x\n", hw_config->io_base);
@@ -1284,6 +1351,38 @@
 	unload_uart401(hw_config);
 }
 
+#ifdef CONFIG_SB16_PC9800
+int sb16_pc9800_check_region(int ioaddr)
+{
+	int n;
+	for (n = 4; n < 7; n++)
+		if(check_region(ioaddr + n*0x100, 1))
+			return 0;
+	for (n = 10; n < 16; n++)
+		if(check_region(ioaddr + n*0x100, 1))
+			return 0;
+	return 1;
+}
+
+void sb16_pc9800_request_region(int ioaddr, const char *name)
+{
+	int n;
+	for (n = 4; n < 7; n++)
+		request_region(ioaddr + n*0x100, 1, name);
+	for (n = 10; n < 16; n++)
+		request_region(ioaddr + n*0x100, 1, name);
+}
+
+void sb16_pc9800_release_region(int ioaddr)
+{
+	int n;
+	for (n = 4; n < 7; n++)
+		release_region(ioaddr + n*0x100, 1);
+	for (n = 10; n < 16; n++)
+		release_region(ioaddr + n*0x100, 1);
+}
+#endif /* CONFIG_SB16_PC9800 */
+
 EXPORT_SYMBOL(sb_dsp_init);
 EXPORT_SYMBOL(sb_dsp_detect);
 EXPORT_SYMBOL(sb_dsp_unload);
diff -urN linux/sound/oss/sound_config.h linux98/sound/oss/sound_config.h
--- linux/sound/oss/sound_config.h	Tue Dec 12 06:02:27 2000
+++ linux98/sound/oss/sound_config.h	Sun Aug 19 14:13:08 2001
@@ -34,13 +34,25 @@
  * Use always 64k buffer size. There is no reason to use shorter.
  */
 #undef DSP_BUFFSIZE
+#ifdef CONFIG_PC9800
+#define DSP_BUFFSIZE          61440
+#else
 #define DSP_BUFFSIZE		(64*1024)
+#endif
 
 #ifndef DSP_BUFFCOUNT
 #define DSP_BUFFCOUNT		1	/* 1 is recommended. */
 #endif
 
+#ifdef CONFIG_PC9800
+#define FM_MONO         0x28d2  /* This is the I/O address used by AdLib */
+#else
 #define FM_MONO		0x388	/* This is the I/O address used by AdLib */
+#endif
+
+#ifdef CONFIG_PC9801_118
+#define FM_MONO_118		0x1488	/* This is the I/O address used by AdLib */
+#endif
 
 #ifndef CONFIG_PAS_BASE
 #define CONFIG_PAS_BASE	0x388
diff -urN linux/sound/oss/uart401.c linux98/sound/oss/uart401.c
--- linux/sound/oss/uart401.c	Sun Sep  1 07:05:31 2002
+++ linux98/sound/oss/uart401.c	Sun Sep  1 10:26:11 2002
@@ -21,6 +21,7 @@
  *		Untested
  */
 
+#include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
@@ -43,8 +44,13 @@
 uart401_devc;
 
 #define	DATAPORT   (devc->base)
+#ifndef CONFIG_SB16_PC9800
 #define	COMDPORT   (devc->base+1)
 #define	STATPORT   (devc->base+1)
+#else
+#define	COMDPORT   (devc->base+0x100)
+#define	STATPORT   (devc->base+0x100)
+#endif
 
 static int uart401_status(uart401_devc * devc)
 {
@@ -304,6 +310,14 @@
 		return 0;
 	}
 
+#ifdef CONFIG_SB16_PC9800
+	if (!request_region(hw_config->io_base + 0x100, 4, "MPU-401 UART SB16-PC98")) {
+		printk(KERN_INFO "uart401: could not request_region(%d, 4)\n", hw_config->io_base + 0x100);
+		release_region(hw_config->io_base, 4);
+		return 0;
+	}
+#endif
+
 	devc = kmalloc(sizeof(uart401_devc), GFP_KERNEL);
 	if (!devc) {
 		printk(KERN_WARNING "uart401: Can't allocate memory\n");
@@ -408,6 +422,9 @@
 
 	reset_uart401(devc);
 	release_region(hw_config->io_base, 4);
+#ifdef CONFIG_SB16_PC9800
+	release_region(hw_config->io_base + 0x100, 4);
+#endif
 
 	if (!devc->share_irq)
 		free_irq(devc->irq, devc);
