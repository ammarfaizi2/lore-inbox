Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267594AbSLMBls>; Thu, 12 Dec 2002 20:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbSLMBls>; Thu, 12 Dec 2002 20:41:48 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:61646
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267594AbSLMBlb>; Thu, 12 Dec 2002 20:41:31 -0500
Date: Thu, 12 Dec 2002 20:51:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Adam Belay <ambx1@neo.rr.com>
Subject: [PATCH][2.5][CFT] ad1848 PnP updates + fixes
Message-ID: <Pine.LNX.4.50.0212122048590.6931-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried not to leak too many 'fixes' in there, but some stuff got into the
way of debugging. I've tested this on;

ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996
pnp: the driver 'ad1848' has been registered
ad1848: No ISAPnP cards found, trying standard ones...
pnp: the driver 'opl3sa2' has been registered
pnp: pnp: match found with the PnP device '00:01.00' and the driver
'opl3sa2'
pnp: the device '00:01.00' has been activated
opl3sa2: chipset version = 0x3
opl3sa2: Found OPL3-SA3 (YMF715B or YMF719B)
<OPL3-SA3> at 0x100 irq 5 dma 1,3
<MS Sound System (CS4231)> at 0xe84 irq 5 dma 1,3
<MPU-401 0.0  Midi interface #1> at 0x300 irq 5
opl3sa2: 1 PnP card(s) found.

Index: linux-2.5.51/sound/oss/ad1848.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.51/sound/oss/ad1848.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 ad1848.c
--- linux-2.5.51/sound/oss/ad1848.c	10 Dec 2002 12:48:01 -0000	1.1.1.1
+++ linux-2.5.51/sound/oss/ad1848.c	13 Dec 2002 01:19:49 -0000
@@ -33,6 +33,7 @@
  * Alan Cox		: Added CS4236->4239 identification
  * Daniel T. Cobra	: Alernate config/mixer for later chips
  * Alan Cox		: Merged chip idents and config code
+ * Zwane Mwaikambo	: Converted to 2.5 PnP API
  *
  * TODO
  *		APM save restore assist code on IBM thinkpad
@@ -47,7 +48,6 @@
 #include <linux/module.h>
 #include <linux/stddef.h>
 #include <linux/pm.h>
-#include <linux/isapnp.h>
 #include <linux/pnp.h>
 #include <linux/spinlock.h>

@@ -107,6 +107,9 @@

 	/* Power management */
 	struct		pm_dev *pmdev;
+#ifdef CONFIG_PNP
+	struct pnp_dev	*pnp_dev;
+#endif
 } ad1848_info;

 typedef struct ad1848_port_info
@@ -180,9 +183,6 @@

 #ifdef CONFIG_PNP
 static int isapnp	= 1;
-static int isapnpjump	= 0;
-static int reverse	= 0;
-
 static int audio_activated = 0;
 #else
 static int isapnp	= 0;
@@ -207,17 +207,15 @@
 static void ad1848_tmr_reprogram(int dev);
 #endif

+/* has to be called with devc->lock held */
 static int ad_read(ad1848_info * devc, int reg)
 {
-	unsigned long flags;
 	int x;
 	int timeout = 900000;

 	while (timeout > 0 && inb(devc->base) == 0x80)	/*Are we initializing */
 		timeout--;

-	spin_lock_irqsave(&devc->lock,flags);
-
 	if(reg < 32)
 	{
 		outb(((unsigned char) (reg & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
@@ -233,21 +231,18 @@
 		outb(((unsigned char) (xra & 0xff)), io_Indexed_Data(devc));
 		x = inb(io_Indexed_Data(devc));
 	}
-	spin_unlock_irqrestore(&devc->lock,flags);

 	return x;
 }

+/* has to be called with the devc->lock held */
 static void ad_write(ad1848_info * devc, int reg, int data)
 {
-	unsigned long flags;
 	int timeout = 900000;

 	while (timeout > 0 && inb(devc->base) == 0x80)	/* Are we initializing */
 		timeout--;

-	spin_lock_irqsave(&devc->lock,flags);
-
 	if(reg < 32)
 	{
 		outb(((unsigned char) (reg & 0xff) | devc->MCE_bit), io_Index_Addr(devc));
@@ -263,7 +258,6 @@
 		outb(((unsigned char) (xra & 0xff)), io_Indexed_Data(devc));
 		outb((unsigned char) (data & 0xff), io_Indexed_Data(devc));
 	}
-	spin_unlock_irqrestore(&devc->lock,flags);
 }

 static void wait_for_calibration(ad1848_info * devc)
@@ -307,10 +301,7 @@
 	 */

 	for (i = 6; i < 8; i++)
-	{
 		prev = devc->saved_regs[i] = ad_read(devc, i);
-	}
-
 }

 static void ad_unmute(ad1848_info * devc)
@@ -319,37 +310,28 @@

 static void ad_enter_MCE(ad1848_info * devc)
 {
-	unsigned long flags;
 	int timeout = 1000;
 	unsigned short prev;

 	while (timeout > 0 && inb(devc->base) == 0x80)	/*Are we initializing */
 		timeout--;

-	spin_lock_irqsave(&devc->lock,flags);
-
 	devc->MCE_bit = 0x40;
 	prev = inb(io_Index_Addr(devc));
 	if (prev & 0x40)
-	{
-		spin_unlock_irqrestore(&devc->lock,flags);
 		return;
-	}
+
 	outb((devc->MCE_bit), io_Index_Addr(devc));
-	spin_unlock_irqrestore(&devc->lock,flags);
 }

 static void ad_leave_MCE(ad1848_info * devc)
 {
-	unsigned long flags;
 	unsigned char prev, acal;
 	int timeout = 1000;

 	while (timeout > 0 && inb(devc->base) == 0x80)	/*Are we initializing */
 		timeout--;

-	spin_lock_irqsave(&devc->lock,flags);
-
 	acal = ad_read(devc, 9);

 	devc->MCE_bit = 0x00;
@@ -357,14 +339,11 @@
 	outb((0x00), io_Index_Addr(devc));	/* Clear the MCE bit */

 	if ((prev & 0x40) == 0)	/* Not in MCE mode */
-	{
-		spin_unlock_irqrestore(&devc->lock,flags);
 		return;
-	}
+
 	outb((0x00), io_Index_Addr(devc));	/* Clear the MCE bit */
 	if (acal & 0x08)	/* Auto calibration is enabled */
 		wait_for_calibration(devc);
-	spin_unlock_irqrestore(&devc->lock,flags);
 }

 static int ad1848_set_recmask(ad1848_info * devc, int mask)
@@ -527,7 +506,9 @@
 {
 	int regoffs, muteregoffs;
 	unsigned char val, muteval;
+	unsigned long flags;

+	spin_lock_irqsave(&devc->lock, flags);
 	regoffs = devc->mix_devices[dev][channel].regno;
 	muteregoffs = devc->mix_devices[dev][channel].mutereg;
 	val = ad_read(devc, regoffs);
@@ -545,6 +526,7 @@
 		ad_write(devc, muteregoffs, muteval);
 		devc->saved_regs[muteregoffs] = muteval;
 	}
+	spin_unlock_irqrestore(&devc->lock, flags);
 }

 static int ad1848_mixer_set(ad1848_info * devc, int dev, int value)
@@ -600,7 +582,8 @@
 {
 	int i;
 	char name[32];
-
+	unsigned long flags;
+
 	devc->mix_devices = &(ad1848_mix_devices[0]);

 	sprintf(name, "%s_%d", devc->chip_name, nr_ad1848_devs);
@@ -661,7 +644,8 @@
 		if (devc->supported_devices & (1 << i))
 			ad1848_mixer_set(devc, i, devc->levels[i]);
 	}
-
+
+	spin_lock_irqsave(&devc->lock, flags);
 	ad1848_set_recmask(devc, SOUND_MASK_MIC);

 	devc->mixer_output_port = devc->levels[31] | AUDIO_HEADPHONE | AUDIO_LINE_OUT;
@@ -679,13 +663,15 @@
 		/* Enable surround mode and SB16 mixer */
 		ad_write(devc, 16, 0x60);
 	}
+	spin_unlock_irqrestore(&devc->lock, flags);
 }

 static int ad1848_mixer_ioctl(int dev, unsigned int cmd, caddr_t arg)
 {
 	ad1848_info *devc = mixer_devs[dev]->devc;
+	unsigned long flags;
 	int val;
-
+
 	if (cmd == SOUND_MIXER_PRIVATE1)
 	{
 		if (get_user(val, (int *)arg))
@@ -697,10 +683,12 @@
 			devc->mixer_output_port = val;
 			val |= AUDIO_HEADPHONE | AUDIO_LINE_OUT;	/* Always on */
 			devc->mixer_output_port = val;
+			spin_lock_irqsave(&devc->lock, flags);
 			if (val & AUDIO_SPEAKER)
 				ad_write(devc, 26, ad_read(devc, 26) & ~0x40);	/* Unmute mono out */
 			else
 				ad_write(devc, 26, ad_read(devc, 26) | 0x40);		/* Mute mono out */
+			spin_unlock_irqrestore(&devc->lock, flags);
 		}
 		val = devc->mixer_output_port;
 		return put_user(val, (int *)arg);
@@ -720,7 +708,9 @@
 				case SOUND_MIXER_RECSRC:
 					if (get_user(val, (int *)arg))
 						return -EFAULT;
+					spin_lock_irqsave(&devc->lock, flags);
 					val = ad1848_set_recmask(devc, val);
+					spin_unlock_irqrestore(&devc->lock, flags);
 					break;

 				default:
@@ -977,7 +967,7 @@
 {
 	ad1848_info    *devc;
 	ad1848_port_info *portc;
-	unsigned long   flags;
+	unsigned long flags;

 	if (dev < 0 || dev >= num_audiodevs)
 		return -ENXIO;
@@ -985,18 +975,16 @@
 	devc = (ad1848_info *) audio_devs[dev]->devc;
 	portc = (ad1848_port_info *) audio_devs[dev]->portc;

-	spin_lock_irqsave(&devc->lock,flags);
-	if (portc->open_mode || (devc->open_mode & mode))
-	{
-		spin_unlock_irqrestore(&devc->lock,flags);
+	spin_lock_irqsave(&devc->lock, flags);
+	if (portc->open_mode || (devc->open_mode & mode)) {
+		spin_unlock_irqrestore(&devc->lock, flags);
 		return -EBUSY;
 	}
 	devc->dual_dma = 0;

 	if (audio_devs[dev]->flags & DMA_DUPLEX)
-	{
 		devc->dual_dma = 1;
-	}
+
 	devc->intr_active = 0;
 	devc->audio_mode = 0;
 	devc->open_mode |= mode;
@@ -1007,10 +995,10 @@
 		devc->record_dev = dev;
 	if (mode & OPEN_WRITE)
 		devc->playback_dev = dev;
-	spin_unlock_irqrestore(&devc->lock,flags);
 /*
  * Mute output until the playback really starts. This decreases clicking (hope so).
  */
+	spin_unlock_irqrestore(&devc->lock, flags);
 	ad_mute(devc);

 	return 0;
@@ -1018,23 +1006,24 @@

 static void ad1848_close(int dev)
 {
-	unsigned long   flags;
 	ad1848_info    *devc = (ad1848_info *) audio_devs[dev]->devc;
 	ad1848_port_info *portc = (ad1848_port_info *) audio_devs[dev]->portc;
+	unsigned long flags;

 	DEB(printk("ad1848_close(void)\n"));
-
-	spin_lock_irqsave(&devc->lock,flags);
-
+
+	spin_lock_irqsave(&devc->lock, flags);
 	devc->intr_active = 0;
+	spin_unlock_irqrestore(&devc->lock, flags);
+
 	ad1848_halt(dev);

+	spin_lock_irqsave(&devc->lock, flags);
 	devc->audio_mode = 0;
 	devc->open_mode &= ~portc->open_mode;
 	portc->open_mode = 0;
-
+	spin_unlock_irqrestore(&devc->lock, flags);
 	ad_unmute(devc);
-	spin_unlock_irqrestore(&devc->lock,flags);
 }

 static void ad1848_output_block(int dev, unsigned long buf, int count, int intrflag)
@@ -1111,13 +1100,10 @@
 	}
 	spin_lock_irqsave(&devc->lock,flags);

-	if (devc->model == MD_1848)
-	{
+	if (devc->model == MD_1848) {
 		  ad_write(devc, 15, (unsigned char) (cnt & 0xff));
 		  ad_write(devc, 14, (unsigned char) ((cnt >> 8) & 0xff));
-	}
-	else
-	{
+	} else {
 		  ad_write(devc, 31, (unsigned char) (cnt & 0xff));
 		  ad_write(devc, 30, (unsigned char) ((cnt >> 8) & 0xff));
 	}
@@ -1336,9 +1322,8 @@
 	if (!(ad_read(devc, 9) & 0x02))
 		return;		/* Capture not enabled */

-	spin_lock_irqsave(&devc->lock,flags);
-
 	ad_mute(devc);
+	spin_lock_irqsave(&devc->lock,flags);

 	{
 		int             tmout;
@@ -1372,9 +1357,9 @@
 	if (!(ad_read(devc, 9) & 0x01))
 		return;		/* Playback not enabled */

+	ad_mute(devc);
 	spin_lock_irqsave(&devc->lock,flags);

-	ad_mute(devc);
 	{
 		int             tmout;

@@ -1404,35 +1389,28 @@
 {
 	ad1848_info    *devc = (ad1848_info *) audio_devs[dev]->devc;
 	ad1848_port_info *portc = (ad1848_port_info *) audio_devs[dev]->portc;
-	unsigned long   flags;
 	unsigned char   tmp, old;

-	spin_lock_irqsave(&devc->lock,flags);
 	state &= devc->audio_mode;
-
 	tmp = old = ad_read(devc, 9);

-	if (portc->open_mode & OPEN_READ)
-	{
+	if (portc->open_mode & OPEN_READ) {
 		  if (state & PCM_ENABLE_INPUT)
 			  tmp |= 0x02;
 		  else
 			  tmp &= ~0x02;
 	}
-	if (portc->open_mode & OPEN_WRITE)
-	{
+	if (portc->open_mode & OPEN_WRITE) {
 		if (state & PCM_ENABLE_OUTPUT)
 			tmp |= 0x01;
 		else
 			tmp &= ~0x01;
 	}
 	/* ad_mute(devc); */
-	if (tmp != old)
-	{
+	if (tmp != old) {
 		  ad_write(devc, 9, tmp);
 		  ad_unmute(devc);
 	}
-	spin_unlock_irqrestore(&devc->lock,flags);
 }

 static void ad1848_init_hw(ad1848_info * devc)
@@ -1580,11 +1558,7 @@
 		printk(KERN_ERR "ad1848 - Too many audio devices\n");
 		return 0;
 	}
-	if (check_region(io_base, 4))
-	{
-		printk(KERN_ERR "ad1848.c: Port %x not free.\n", io_base);
-		return 0;
-	}
+
 	devc->base = io_base;
 	devc->irq_ok = 0;
 	devc->timer_running = 0;
@@ -1969,7 +1943,6 @@

 	ad1848_port_info *portc = NULL;

-	spin_lock_init(&devc->lock);
 	devc->irq = (irq > 0) ? irq : 0;
 	devc->open_mode = 0;
 	devc->timer_ticks = 0;
@@ -2039,17 +2012,14 @@

 	ad1848_init_hw(devc);

-	if (irq > 0)
-	{
+	if (irq > 0) {
 		devc->dev_no = my_dev;
-		if (request_irq(devc->irq, adintr, 0, devc->name, (void *)my_dev) < 0)
-		{
+		if (request_irq(devc->irq, adintr, 0, devc->name, (void *)my_dev) < 0) {
 			printk(KERN_WARNING "ad1848: Unable to allocate IRQ\n");
 			/* Don't free it either then.. */
 			devc->irq = 0;
 		}
-		if (capabilities[devc->model].flags & CAP_F_TIMER)
-		{
+		if (capabilities[devc->model].flags & CAP_F_TIMER) {
 #ifndef CONFIG_SMP
 			int x;
 			unsigned char tmp = ad_read(devc, 16);
@@ -2066,8 +2036,7 @@

 			if (devc->timer_ticks == 0)
 				printk(KERN_WARNING "ad1848: Interrupt test failed (IRQ%d)\n", irq);
-			else
-			{
+			else {
 				DDB(printk("Interrupt test OK\n"));
 				devc->irq_ok = 1;
 			}
@@ -2086,8 +2055,7 @@
 		ad1848_tmr_install(my_dev);
 #endif

-	if (!share_dma)
-	{
+	if (!share_dma) {
 		if (sound_alloc_dma(dma_playback, devc->name))
 			printk(KERN_WARNING "ad1848.c: Can't allocate DMA%d\n", dma_playback);

@@ -2100,8 +2068,7 @@
 				     dev_name,
 				     &ad1848_mixer_operations,
 				     sizeof(struct mixer_operations),
-				     devc)) >= 0)
-	{
+				     devc)) >= 0) {
 		audio_devs[my_dev]->mixer_dev = e;
 		if (owner)
 			mixer_devs[e]->owner = owner;
@@ -2112,6 +2079,7 @@
 int ad1848_control(int cmd, int arg)
 {
 	ad1848_info *devc;
+	unsigned long flags;

 	if (nr_ad1848_devs < 1)
 		return -ENODEV;
@@ -2123,9 +2091,11 @@
 		case AD1848_SET_XTAL:	/* Change clock frequency of AD1845 (only ) */
 			if (devc->model != MD_1845 || devc->model != MD_1845_SSCAPE)
 				return -EINVAL;
+			spin_lock_irqsave(&devc->lock, flags);
 			ad_enter_MCE(devc);
 			ad_write(devc, 29, (ad_read(devc, 29) & 0x1f) | (arg << 5));
 			ad_leave_MCE(devc);
+			spin_unlock_irqrestore(&devc->lock, flags);
 			break;

 		case AD1848_MIXER_REROUTE:
@@ -2171,23 +2141,19 @@
 	int i, mixer, dev = 0;
 	ad1848_info *devc = NULL;

-	for (i = 0; devc == NULL && i < nr_ad1848_devs; i++)
-	{
-		if (adev_info[i].base == io_base)
-		{
+	for (i = 0; devc == NULL && i < nr_ad1848_devs; i++) {
+		if (adev_info[i].base == io_base) {
 			devc = &adev_info[i];
 			dev = devc->dev_no;
 		}
 	}

-	if (devc != NULL)
-	{
+	if (devc != NULL) {
 		if(audio_devs[dev]->portc!=NULL)
 			kfree(audio_devs[dev]->portc);
 		release_region(devc->base, 4);

-		if (!share_dma)
-		{
+		if (!share_dma) {
 			if (devc->irq > 0) /* There is no point in freeing irq, if it wasn't allocated */
 				free_irq(devc->irq, (void *)devc->dev_no);

@@ -2198,12 +2164,14 @@

 		}
 		mixer = audio_devs[devc->dev_no]->mixer_dev;
-		if(mixer>=0)
+		if (mixer>=0)
 			sound_unload_mixerdev(mixer);

 		if (devc->pmdev)
 			pm_unregister(devc->pmdev);
-
+#ifdef CONFIG_PNP
+		put_device(&devc->pnp_dev->dev);
+#endif
 		nr_ad1848_devs--;
 		for ( ; i < nr_ad1848_devs ; i++)
 			adev_info[i] = adev_info[i+1];
@@ -2223,6 +2191,7 @@

 	dev = (int)dev_id;
 	devc = (ad1848_info *) audio_devs[dev]->devc;
+	spin_lock(&devc->lock);

 interrupt_again:		/* Jump back here if int status doesn't reset */

@@ -2237,18 +2206,12 @@
 	{
 		if (devc->model == MD_C930)
 		{		/* 82C930 has interrupt status register in MAD16 register MC11 */
-
-			spin_lock(&devc->lock);
-
 			/* 0xe0e is C930 address port
 			 * 0xe0f is C930 data port
 			 */
 			outb(11, 0xe0e);
 			c930_stat = inb(0xe0f);
 			outb((~c930_stat), 0xe0f);
-
-			spin_unlock(&devc->lock);
-
 			alt_stat = (c930_stat << 2) & 0x30;
 		}
 		else if (devc->model != MD_1848)
@@ -2285,6 +2248,7 @@
 	{
 		  goto interrupt_again;
 	}
+	spin_unlock(&devc->lock);
 }

 /*
@@ -2524,11 +2488,6 @@

 	DDB(printk("Entered probe_ms_sound(%x, %d)\n", hw_config->io_base, hw_config->card_subtype));

-	if (check_region(hw_config->io_base, 8))
-	{
-		printk(KERN_ERR "MSS: I/O port conflict\n");
-		return 0;
-	}
 	if (hw_config->card_subtype == 1)	/* Has no IRQ/DMA registers */
 	{
 		/* check_opl3(0x388, hw_config); */
@@ -2723,8 +2682,6 @@
 	unsigned long   xtal_nsecs;	/* nanoseconds per xtal oscillator tick */
 	unsigned long   divider;

-	spin_lock_irqsave(&devc->lock,flags);
-
 	/*
 	 * Length of the timer interval (in nanoseconds) depends on the
 	 * selected crystal oscillator. Check this from bit 0x01 of I8.
@@ -2751,6 +2708,7 @@
 	if (divider > 65535)	/* Overflow check */
 		divider = 65535;

+	spin_lock_irqsave(&devc->lock,flags);
 	ad_write(devc, 21, (divider >> 8) & 0xff);	/* Set upper bits */
 	ad_write(devc, 20, divider & 0xff);	/* Set lower bits */
 	ad_write(devc, 16, ad_read(devc, 16) | 0x40);	/* Start the timer */
@@ -2819,13 +2777,8 @@

 static int ad1848_suspend(ad1848_info *devc)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&devc->lock,flags);
-
 	ad_mute(devc);

-	spin_unlock_irqrestore(&devc->lock,flags);
 	return 0;
 }

@@ -2833,9 +2786,8 @@
 {
 	unsigned long flags;
 	int mixer_levels[32], i;
-
-	spin_lock_irqsave(&devc->lock,flags);

+	local_irq_save(flags);
 	/* Thinkpad is a bit more of PITA than normal. The BIOS tends to
 	   restore it in a different config to the one we use.  Need to
 	   fix this somehow */
@@ -2860,7 +2812,7 @@
 		bits = interrupt_bits[devc->irq];
 		if (bits == -1) {
 			printk(KERN_ERR "MSS: Bad IRQ %d\n", devc->irq);
-			spin_unlock_irqrestore(&devc->lock,flags);
+			local_irq_restore(flags);
 			return -1;
 		}

@@ -2875,7 +2827,7 @@
 		outb((bits | dma_bits[devc->dma1] | dma2_bit), config_port);
 	}

-	spin_unlock_irqrestore(&devc->lock,flags);
+	local_irq_restore(flags);
 	return 0;
 }

@@ -2924,13 +2876,7 @@

 #ifdef CONFIG_PNP
 MODULE_PARM(isapnp,	"i");
-MODULE_PARM(isapnpjump,	"i");
-MODULE_PARM(reverse,	"i");
 MODULE_PARM_DESC(isapnp,	"When set to 0, Plug & Play support will be disabled");
-MODULE_PARM_DESC(isapnpjump,	"Jumps to a specific slot in the driver's PnP table. Use the source, Luke.");
-MODULE_PARM_DESC(reverse,	"When set to 1, will reverse ISAPnP search order");
-
-struct pnp_dev	*ad1848_dev  = NULL;

 /* Please add new entries at the end of the table */
 static struct {
@@ -2952,10 +2898,12 @@
                 ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0100),
 		0, 0, 0, 1, 0},
-        {"OPL3-SA2 WSS mode",
+        /* This is handled by the opl3sa2 driver
+	{"OPL3-SA2 WSS mode",
         	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021),
                 1, 0, 0, 1, 1},
+	*/
 	{"Advanced Gravis InterWave Audio",
 		ISAPNP_VENDOR('G','R','V'), ISAPNP_DEVICE(0x0001),
 		ISAPNP_VENDOR('G','R','V'), ISAPNP_FUNCTION(0x0000),
@@ -2963,137 +2911,81 @@
 	{0}
 };

-static struct isapnp_device_id id_table[] __devinitdata = {
-	{	ISAPNP_VENDOR('C','M','I'), ISAPNP_DEVICE(0x0001),
-		ISAPNP_VENDOR('@','@','@'), ISAPNP_FUNCTION(0x0001), 0 },
-        {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0000), 0 },
-        {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('C','S','C'), ISAPNP_FUNCTION(0x0100), 0 },
-        {       ISAPNP_ANY_ID, ISAPNP_ANY_ID,
-		ISAPNP_VENDOR('Y','M','H'), ISAPNP_FUNCTION(0x0021), 0 },
-	{	ISAPNP_VENDOR('G','R','V'), ISAPNP_DEVICE(0x0001),
-		ISAPNP_VENDOR('G','R','V'), ISAPNP_FUNCTION(0x0000), 0 },
-	{0}
+static const struct pnp_device_id ad1848_id_table[] __devinitdata = {
+	{.id = "CMI0001" },
+	{.id = "@@@0001" },
+	{.id = "CSC0000" },
+	{.id = "CSC0100" },
+	/* {.id = "YMH0021" }, */
+	{.id = "GRV0001" },
+	{.id = "GRV0000" },
+	{.id = ""}
 };

-MODULE_DEVICE_TABLE(isapnp, id_table);
+MODULE_DEVICE_TABLE(pnp, ad1848_id_table);

-static struct pnp_dev *activate_dev(char *devname, char *resname, struct pnp_dev *dev)
+static int ad1848_isapnp_probe(struct pnp_dev *pnp_dev, const struct pnp_device_id *dev_id)
 {
-	int err;
+	ad1848_info *priv;
+	int mss_io_index, irq_index, dma_index, dma2_index;

-	/* Device already active? Let's use it */
-	if(dev->active)
-		return(dev);
+	if (nr_ad1848_devs >= MAX_AUDIO_DEV)
+		return -ENOSPC;

-	if((err = pnp_activate_dev(dev)) < 0) {
-		printk(KERN_ERR "ad1848: %s %s config failed (out of resources?)[%d]\n", devname, resname, err);
+	priv = &adev_info[nr_ad1848_devs];
+	priv->pnp_dev = pnp_dev;
+	get_device(&pnp_dev->dev);
+
+	mss_io_index = ad1848_isapnp_list[nr_ad1848_devs].mss_io;
+	irq_index = ad1848_isapnp_list[nr_ad1848_devs].irq;
+	dma_index = ad1848_isapnp_list[nr_ad1848_devs].dma;
+	dma2_index = ad1848_isapnp_list[nr_ad1848_devs].dma2;
+
+	cfg.io_base = pnp_dev->resource[mss_io_index].start;
+	cfg.irq = pnp_dev->irq_resource[irq_index].start;
+	cfg.dma = pnp_dev->dma_resource[dma_index].start;

-		pnp_disable_dev(dev);
+	if (dma2_index != -1)
+		cfg.dma2 = pnp_dev->dma_resource[dma2_index].start;
+	else
+		cfg.dma2 = -1;

-		return(NULL);
-	}
+	printk(KERN_NOTICE "ad1848: ISAPnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n",
+		pnp_dev->name, cfg.io_base, cfg.irq, cfg.dma, cfg.dma2);
 	audio_activated = 1;
-	return(dev);
-}
-
-static struct pnp_dev *ad1848_init_generic(struct pnp_card *bus, struct address_info *hw_config, int slot)
-{
-
-	/* Configure Audio device */
-	if((ad1848_dev = pnp_find_dev(bus, ad1848_isapnp_list[slot].vendor, ad1848_isapnp_list[slot].function, NULL)))
-	{
-		if((ad1848_dev = activate_dev(ad1848_isapnp_list[slot].name, "ad1848", ad1848_dev)))
-		{
-			get_device(&ad1848_dev->dev);
-			hw_config->io_base 	= ad1848_dev->resource[ad1848_isapnp_list[slot].mss_io].start;
-			hw_config->irq 		= ad1848_dev->irq_resource[ad1848_isapnp_list[slot].irq].start;
-			hw_config->dma 		= ad1848_dev->dma_resource[ad1848_isapnp_list[slot].dma].start;
-			if(ad1848_isapnp_list[slot].dma2 != -1)
-				hw_config->dma2 = ad1848_dev->dma_resource[ad1848_isapnp_list[slot].dma2].start;
-			else
-				hw_config->dma2 = -1;
-                        hw_config->card_subtype = ad1848_isapnp_list[slot].type;
-		} else
-			return(NULL);
-	} else
-		return(NULL);

-	return(ad1848_dev);
-}
-
-static int __init ad1848_isapnp_init(struct address_info *hw_config, struct pnp_card *bus, int slot)
-{
-	char *busname = bus->name[0] ? bus->name : ad1848_isapnp_list[slot].name;
-
-	/* Initialize this baby. */
-
-	if(ad1848_init_generic(bus, hw_config, slot)) {
-		/* We got it. */
-
-		printk(KERN_NOTICE "ad1848: ISAPnP reports '%s' at i/o %#x, irq %d, dma %d, %d\n",
-		       busname,
-		       hw_config->io_base, hw_config->irq, hw_config->dma,
-		       hw_config->dma2);
-		return 1;
-	}
 	return 0;
 }

-static int __init ad1848_isapnp_probe(struct address_info *hw_config)
-{
-	static int first = 1;
-	int i;
-
-	/* Count entries in sb_isapnp_list */
-	for (i = 0; ad1848_isapnp_list[i].card_vendor != 0; i++);
-	i--;
-
-	/* Check and adjust isapnpjump */
-	if( isapnpjump < 0 || isapnpjump > i) {
-		isapnpjump = reverse ? i : 0;
-		printk(KERN_ERR "ad1848: Valid range for isapnpjump is 0-%d. Adjusted to %d.\n", i, isapnpjump);
-	}
-
-	if(!first || !reverse)
-		i = isapnpjump;
-	first = 0;
-	while(ad1848_isapnp_list[i].card_vendor != 0) {
-		static struct pnp_card *bus = NULL;
-
-		while ((bus = pnp_find_card(
-				ad1848_isapnp_list[i].card_vendor,
-				ad1848_isapnp_list[i].card_device,
-				bus))) {
-
-			if(ad1848_isapnp_init(hw_config, bus, i)) {
-				isapnpjump = i; /* start next search from here */
-				return 0;
-			}
-		}
-		i += reverse ? -1 : 1;
-	}
-
-	return -ENODEV;
-}
+static struct pnp_driver ad1848_driver = {
+	.name		= "ad1848",
+	.id_table	= ad1848_id_table,
+	.probe		= ad1848_isapnp_probe,
+};
 #endif


 static int __init init_ad1848(void)
 {
+	int i;
 	printk(KERN_INFO "ad1848/cs4248 codec driver Copyright (C) by Hannu Savolainen 1993-1996\n");

+	for (i = 0; i < MAX_AUDIO_DEV; i++)
+		spin_lock_init(&adev_info[i].lock);
+
 #ifdef CONFIG_PNP
-	if(isapnp && (ad1848_isapnp_probe(&cfg) < 0) ) {
-		printk(KERN_NOTICE "ad1848: No ISAPnP cards found, trying standard ones...\n");
-		isapnp = 0;
+	if (isapnp) {	/* FIXME I don't think this override can work anymore... -Zwane */
+		/* On return our settings are in cfg */
+		pnp_register_driver(&ad1848_driver);
+		if (audio_activated == 0) {
+			printk(KERN_NOTICE "ad1848: No ISAPnP cards found, trying standard ones...\n");
+			isapnp = 0;
+		}
 	}
 #endif

-	if(io != -1) {
-	        if( isapnp == 0 )
-	        {
+	if (io != -1) {
+	        if ( isapnp == 0 ) {
 			if(irq == -1 || dma == -1) {
 				printk(KERN_WARNING "ad1848: must give I/O , IRQ and DMA.\n");
 				return -EINVAL;
@@ -3106,7 +2998,7 @@
 			cfg.card_subtype = type;
 	        }

-		if(!probe_ms_sound(&cfg))
+		if (!probe_ms_sound(&cfg))
 			return -ENODEV;
 		attach_ms_sound(&cfg, THIS_MODULE);
 		loaded = 1;
@@ -3116,15 +3008,23 @@

 static void __exit cleanup_ad1848(void)
 {
-	if(loaded)
+	if (loaded)
 		unload_ms_sound(&cfg);

 #ifdef CONFIG_PNP
-	if(ad1848_dev){
-		if(audio_activated)
-			pnp_disable_dev(ad1848_dev);
-		put_device(&ad1848_dev->dev);
+{
+	ad1848_info *p;
+
+	if (audio_activated == 0)
+		return;
+
+	while (--nr_ad1848_devs >= 0) {
+		p = &adev_info[nr_ad1848_devs];
+		pnp_disable_dev(p->pnp_dev);	/* XXX Should this be done here? */
+		put_device(&p->pnp_dev->dev);
 	}
+	pnp_unregister_driver(&ad1848_driver);
+}
 #endif
 }


-- 
function.linuxpower.ca
