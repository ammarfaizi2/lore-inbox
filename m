Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266330AbRGFJRJ>; Fri, 6 Jul 2001 05:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266326AbRGFJRC>; Fri, 6 Jul 2001 05:17:02 -0400
Received: from melancholia.rimspace.net ([203.36.211.210]:26383 "HELO
	melancholia.danann.net") by vger.kernel.org with SMTP
	id <S266325AbRGFJQw>; Fri, 6 Jul 2001 05:16:52 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Updates to Maestro{1,2,2E} driver -- multiple open of dsp, persistent buffers.
From: Daniel Pittman <daniel@rimspace.net>
Organization: Not today, thank you, Mother.
X-Homepage: http://danann.net/
X-spies: counter-intelligence Ft. Bragg ammunition cryptographic quiche security Uzi spy Cocaine explosion militia KGB NWO NORAD munitions 
Date: 06 Jul 2001 19:16:40 +1000
Message-ID: <87u20qa03r.fsf@inanna.rimspace.net>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.5 (anise)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

The attached patch modifies the kernel Maestro sound driver to add a
couple of features:

* open /dev/dsp many times, not /dev/dsp[0-3]
* persistent DMA buffers

This code has been well tested and has run for quite a long time with
stability and success on a number of Maestro-using computers.

The patch has the blessing of Zach Brown, the current maintainer, as far
as that goes -- but it's my own work. :)

It would be good if people could test this and let me know if they
encounter any problems. If not, I will submit it for inclusion in the
kernel proper soon.

The patch is against 2.4.7-pre3 but should apply successfully to version
2.4.6 or later.

        Daniel


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
  filename=maestro-2001-07-06-multi-open-2.4.7-pre1.diff

diff -ru linux/Documentation/Configure.help linux.maestro/Documentation/Configure.help
--- linux/Documentation/Configure.help	Fri Jul  6 17:15:55 2001
+++ linux.maestro/Documentation/Configure.help	Thu Jul  5 11:58:39 2001
@@ -15607,6 +15607,22 @@
   of PCI sound chips.  These include the Maestro 1, Maestro 2, and
   Maestro 2E.  See Documentation/sound/Maestro for more details.
 
+The number of DSP device to create.
+CONFIG_MAESTRO_CHANNELS
+  The number of DSP devices to allocate. Each device functions as
+  a fully independent sound system. The more devices allocated,
+  however, the larger the memory requirement for the driver.
+  You can allocate up to four DSP devices, but only in multiples
+  of two. This allows one, two or four devices.
+
+Allocate memory for DSP devices persistently
+CONFIG_MAESTRO_PERSIST
+  If you say Y to this, the memory for the DSP devices provided
+  by the Maestro device will be retained even when the sound
+  system is not in use.
+  This is beneficial if you find that sound cannot be used after
+  doing other things on the machine for a while.
+
 Are you using a crosscompiler
 CONFIG_CROSSCOMPILE
   Say Y here if you are compiling the kernel on a different
diff -ru linux/Documentation/sound/Maestro linux.maestro/Documentation/sound/Maestro
--- linux/Documentation/sound/Maestro	Sat Jul 29 05:50:52 2000
+++ linux.maestro/Documentation/sound/Maestro	Thu Jul  5 11:58:22 2001
@@ -80,16 +80,32 @@
 an IRQ.  This operation is incredibly system specific, so you're on your
 own.  Sometimes the magic lies in 'PNP Capable Operating System' settings.
 
-There are very few options to the driver.  One is 'debug' which will 
-tell the driver to print minimal debugging information as it runs.  This
-can be collected with 'dmesg' or through the klogd daemon.
-
-The other, more interesting option, is 'dsps_order'.  Typically at
-install time the driver will only register one available /dev/dsp device
-for its use.  The 'dsps_order' module parameter allows for more devices
-to be allocated, as a power of two.  Up to 4 devices can be registered
-( dsps_order=2 ).  These devices act as fully distinct units and use
-separate channels in the maestro.
+There are very few options to the driver. Options can be specified as either
+module options or on the kernel command line. Command line arguments are in
+the form 'maestro=<option>:<value>,<option>:<value>'.
+
+One is 'debug' which will tell the driver to print minimal debugging
+information as it runs. This can be collected with 'dmesg' or through the
+klogd daemon. Setting this to one will cause debug information to be dumped.
+
+The other, more interesting option, is 'channels'. At install time the driver
+will register /dev/dsp and makes a number of channels available through this
+device. Multiple programs can open /dev/dsp, until all channels are used.
+
+The 'channels' parameter specifies the number of channels to be specified. Up
+to 4 channels can be allocated, but only in powers of two. Thus, you can have
+one, two or four devices. The default value is to allocate one channel.
+
+When multiple channels are open, they act as distinct sound devices. This
+allows multiple applications to generate sound simultaneously without blocking
+each other.
+
+At compile time you may also select to use persistent dsp buffers. Because of
+some oddities of the hardware, a large number of channels requires a large
+slab of contiguous memory. The persistent buffers option allocates this memory
+when the cards are detected and holds it all the time, preventing memory
+fragmentation from preventing the sound device from working.
+
 
 Power Management
 ----------------
diff -ru linux/drivers/sound/Config.in linux.maestro/drivers/sound/Config.in
--- linux/drivers/sound/Config.in	Fri Jul  6 17:16:21 2001
+++ linux.maestro/drivers/sound/Config.in	Thu Jul  5 14:15:43 2001
@@ -36,6 +36,10 @@
 dep_tristate '  Creative Ensoniq AudioPCI 97 (ES1371)' CONFIG_SOUND_ES1371 $CONFIG_SOUND $CONFIG_PCI
 dep_tristate '  ESS Technology Solo1' CONFIG_SOUND_ESSSOLO1 $CONFIG_SOUND
 dep_tristate '  ESS Maestro, Maestro2, Maestro2E driver' CONFIG_SOUND_MAESTRO $CONFIG_SOUND
+if [ "$CONFIG_SOUND_MAESTRO" = "y" -o "$CONFIG_SOUND_MAESTRO" = "m" ]; then
+   int  '    Number of channels (1,2,4)' CONFIG_MAESTRO_CHANNELS 1
+   bool '    Persistent Maestro dsp buffers' CONFIG_MAESTRO_PERSIST
+fi
 dep_tristate '  ESS Maestro3/Allegro driver (EXPERIMENTAL)' CONFIG_SOUND_MAESTRO3 $CONFIG_SOUND $CONFIG_PCI $CONFIG_EXPERIMENTAL
 dep_tristate '  Intel ICH (i8xx) audio support' CONFIG_SOUND_ICH $CONFIG_PCI
 dep_tristate '  S3 SonicVibes' CONFIG_SOUND_SONICVIBES $CONFIG_SOUND
diff -ru linux/drivers/sound/maestro.c linux.maestro/drivers/sound/maestro.c
--- linux/drivers/sound/maestro.c	Fri Jul  6 17:16:21 2001
+++ linux.maestro/drivers/sound/maestro.c	Thu Jul  5 15:42:42 2001
@@ -1,6 +1,6 @@
 /*****************************************************************************
  *
- *      ESS Maestro/Maestro-2/Maestro-2E driver for Linux 2.[23].x
+ *      ESS Maestro/Maestro-2/Maestro-2E driver for Linux 2.[234].x
  *
  *      This program is free software; you can redistribute it and/or modify
  *      it under the terms of the GNU General Public License as published by
@@ -28,7 +28,7 @@
  *	proprietors of Hack Central for fine lodging.
  *
  *  Supported devices:
- *  /dev/dsp0-3    standard /dev/dsp device, (mostly) OSS compatible
+ *  /dev/dsp    standard /dev/dsp device, (mostly) OSS compatible
  *  /dev/mixer  standard /dev/mixer device, (mostly) OSS compatible
  *
  *  Hardware Description
@@ -39,7 +39,7 @@
  *	channels.  They can take data from a number of sources and perform
  *	basic encodings of the data.  The wavecache is a storehouse for
  *	PCM data.  Typically it deals with PCI and interracts with the
- *	APUs.  The ASSP is a wacky DSP like device that ESS is loth
+ *	APUs.  The ASSP is a wacky DSP like device that ESS is loath
  *	to release docs on.  Thankfully it isn't required on the Maestro
  *	until you start doing insane things like FM emulation and surround
  *	encoding.  The codecs are almost always AC-97 compliant codecs, 
@@ -69,20 +69,19 @@
  *	software.  The pass between the 2 APUs is supposedly what requires us
  *	to have a 512 byte buffer sitting around in wavecache/memory.
  *
- *	The wavecache makes our life even more fun.  First off, it can
- *	only address the first 28 bits of PCI address space, making it
- *	useless on quite a few architectures.  Secondly, its insane.
- *	It claims to fetch from 4 regions of PCI space, each 4 meg in length.
- *	But that doesn't really work.  You can only use 1 region.  So all our
- *	allocations have to be in 4meg of each other.  Booo.  Hiss.
- *	So we have a module parameter, dsps_order, that is the order of
- *	the number of dsps to provide.  All their buffer space is allocated
- *	on open time.  The sonicvibes OSS routines we inherited really want
- *	power of 2 buffers, so we have all those next to each other, then
- *	512 byte regions for the recording wavecaches.  This ends up
- *	wasting quite a bit of memory.  The only fixes I can see would be 
- *	getting a kernel allocator that could work in zones, or figuring out
- *	just how to coerce the WP into doing what we want.
+ *      The wavecache makes our life even more fun. First off, it can only address
+ *      the first 28 bits of PCI address space, making it useless on quite a
+ *      few architectures. Secondly, its insane. It claims to fetch from 4
+ *      regions of PCI space, each 4 meg in length. But that doesn't really
+ *      work. You can only use 1 region. So all our allocations have to be in
+ *      4meg of each other. Booo. Hiss. So we have a module parameter,
+ *      channels, that is the number of dsps to provide. All their buffer
+ *      space is allocated on open time. The sonicvibes OSS routines we
+ *      inherited really want power of 2 buffers, so we have all those next to
+ *      each other, then 512 byte regions for the recording wavecaches. This
+ *      ends up wasting quite a bit of memory. The only fixes I can see would
+ *      be getting a kernel allocator that could work in zones, or figuring
+ *      out just how to coerce the WP into doing what we want.
  *
  *	The indirection of the various registers means we have to spinlock
  *	nearly all register accesses.  We have the main register indirection
@@ -115,6 +114,15 @@
  *	themselves, but we'll see.  
  *	
  * History
+ *  v0.15 - Jul 05 2001 - Daniel Pittman <daniel@rimspace.net>
+ *      Support multiple open of /dev/dsp, not multiple dsp devices.
+ *      Parse the kernel command line for arguments.
+ *      Add module parameter descriptions.
+ *      Added configure time support for setting default number of dsp
+ *      channels to use. This is not the dsps_order value, because that's
+ *      totally, like, impossible to explain to anyone who isn't a math geek.
+ *      Added support for persistent sound buffer allocation for a card so
+ *      that my laptop will still be able to play sound after a compile.
  *  v0.15 - May 21 2001 - Marcus Meissner <mm@caldera.de>
  *      Ported to Linux 2.4 PCI API. Some clean ups, global devs list
  *      removed (now using pci device driver data).
@@ -246,26 +254,48 @@
 #define M_printk(x)
 #endif
 
-/* we try to setup 2^(dsps_order) /dev/dsp devices */
-static int dsps_order=0;
+/* Number of dsp channels to allocate. (1,2 or 4) */
+static int channels = CONFIG_MAESTRO_CHANNELS;
+
+/* Should we allocate persistent DMA buffers? */
+#ifdef CONFIG_MAESTRO_PERSIST
+static int persist = 1;
+#else
+static int persist = 0;
+#endif
+
 /* wether or not we mess around with power management */
 static int use_pm=2; /* set to 1 for force */
+
 /* clocking for broken hardware - a few laptops seem to use a 50Khz clock
 	ie insmod with clocking=50000 or so */
-	
 static int clocking=48000;
 
+/* --------------------------------------------------------------------- */
+#define DRIVER_VERSION "0.16"
+
+#ifdef MODULE
 MODULE_AUTHOR("Zach Brown <zab@zabbo.net>, Alan Cox <alan@redhat.com>");
 MODULE_DESCRIPTION("ESS Maestro Driver");
 #ifdef M_DEBUG
 MODULE_PARM(debug,"i");
+MODULE_PARM_DESC(debug,"Extra debug information from the driver.");
 #endif
-MODULE_PARM(dsps_order,"i");
+
+MODULE_PARM(channels,"i");
+MODULE_PARM_DESC(channels,"Number of channels to support on /dev/dsp.");
+
 MODULE_PARM(use_pm,"i");
-MODULE_PARM(clocking, "i");
+MODULE_PARM_DESC(use_pm,"Use power management? (0 to disable, 1 to try, 2 to force).");
 
-/* --------------------------------------------------------------------- */
-#define DRIVER_VERSION "0.15"
+MODULE_PARM(persist,"i");
+MODULE_PARM_DESC(persist,"Allocate persistent DMA buffers? (0 to disable, 1 to force)");
+
+MODULE_PARM(clocking, "i");
+MODULE_PARM_DESC(clocking,"Set the clocking for broken hardware.
+A few laptops seem to use a 50Khz clock.
+ie insmod with clocking=50000 or so.");
+#endif /* MODULE */
 
 #ifndef PCI_VENDOR_ESS
 #define PCI_VENDOR_ESS			0x125D
@@ -300,8 +330,9 @@
 #define ADC_RUNNING		2
 
 #define MAX_DSP_ORDER	2
+#define DSP_ORDER	(channels/2)
 #define MAX_DSPS	(1<<MAX_DSP_ORDER)
-#define NR_DSPS		(1<<dsps_order)
+#define NR_DSPS		(1<<DSP_ORDER)
 #define NR_IDRS		32
 
 #define NR_APUS		64
@@ -395,13 +426,9 @@
 
 	/* this locks around the oss state in the driver */
 	spinlock_t lock;
-	/* only let 1 be opening at a time */
-	struct semaphore open_sem;
-	wait_queue_head_t open_wait;
-	mode_t open_mode;
 
-	/* soundcore stuff */
-	int dev_audio;
+	/* Current open modes for the channel. */
+	mode_t open_mode;
 
 	struct dmabuf {
 		void *rawbuf;
@@ -440,6 +467,8 @@
 	/* We keep maestro cards in a linked list */
 	struct ess_card *next;
 
+	/* soundcore stuff */
+	int dev_audio;
 	int dev_mixer;
 
 	int card_type;
@@ -463,6 +492,13 @@
 	int in_suspend;
 	wait_queue_head_t suspend_queue;
 
+	/* Lock to protect the channel list during open. */
+	struct semaphore open_semaphore;
+
+	/* Queue for sleepers waiting for a free channel. */
+	wait_queue_head_t open_queue;
+
+	int channel_count;
 	struct ess_state channels[MAX_DSPS];
 	u16 maestro_map[NR_IDRS];	/* Register map */
 	/* we have to store this junk so that we can come back from a
@@ -787,7 +823,7 @@
 	
 /* read or write the recmask 
 	the ac97 can really have left and right recording
-	inputs independantly set, but OSS doesn't seem to 
+	inputs independently set, but OSS doesn't seem to 
 	want us to express that to the user. 
 	the caller guarantees that we have a supported bit set,
 	and they must be holding the card's spinlock */
@@ -842,7 +878,7 @@
 		vend1,vend2,caps,maestro_ac97_get(card,0x26) & 0xf);
 
 	if (! (caps & 0x4) ) {
-		/* no bass/treble nobs */
+		/* no bass/treble knobs */
 		card->mix.supported_mixers &= ~(SOUND_MASK_BASS|SOUND_MASK_TREBLE);
 	}
 
@@ -1454,7 +1490,7 @@
  *	Native record driver 
  */
 
-/* again, passed mode is alrady shifted/masked */
+/* again, passed mode is already shifted/masked */
 static void 
 ess_rec_setup(struct ess_state *ess, int mode, u32 rate, void *buffer, int size)
 {
@@ -1512,7 +1548,7 @@
 				pa = virt_to_bus(buffer);
 			} else {
 				/* right channel records its split half.
-				*2 accomodates for rampant shifting earlier */
+				*2 accommodates for rampant shifting earlier */
 				pa = virt_to_bus(buffer + size*2);
 			}
 
@@ -1653,7 +1689,7 @@
 		if(freq > (ESS_SYSCLK>>(prescale+9)))
 			break;
 			
-	/* next, back off prescaler whilst getting divider into optimum range */
+	/* next, back off prescaler while getting divider into optimum range */
 	divide=1;
 	while((prescale > 5) && (divide<32))
 	{
@@ -1822,10 +1858,11 @@
 
 	/* update ADC pointer */
 	if (s->dma_adc.ready) {
-		/* oh boy should this all be re-written.  everything in the current code paths think
-		that the various counters/pointers are expressed in bytes to the user but we have
-		two apus doing stereo stuff so we fix it up here.. it propogates to all the various
-		counters from here.  */
+		/* oh boy should this all be re-written. everything in the
+		current code paths think that the various counters/pointers
+		are expressed in bytes to the user but we have two apus doing
+		stereo stuff so we fix it up here.. it propagates to all the
+		various counters from here. */
 		if ( s->fmt & (ESS_FMT_STEREO << ESS_ADC_SHIFT)) {
 			hwptr = (get_dmac(s)*2) % s->dma_adc.dmasize;
 		} else {
@@ -1958,11 +1995,10 @@
 	/*
 	 *	Update the pointers for all APU's we are running.
 	 */
-	for(i=0;i<NR_DSPS;i++)
+	for(i = 0; i < c->channel_count; i++)
 	{
 		s=&c->channels[i];
-		if(s->dev_audio == -1)
-			break;
+
 		spin_lock(&s->lock);
 		ess_update_ptr(s);
 		spin_unlock(&s->lock);
@@ -2893,14 +2929,14 @@
 	|silly fifo word	| 512byte mixbuf per adc	| dac/adc * channels |
 */
 static int
-allocate_buffers(struct ess_state *s)
+allocate_buffers(struct ess_card *c)
 {
 	void *rawbuf=NULL;
 	int order,i;
 	struct page *page, *pend;
 
 	/* alloc as big a chunk as we can */
-	for (order = (dsps_order + (16-PAGE_SHIFT) + 1); order >= (dsps_order + 2 + 1); order--)
+	for (order = (DSP_ORDER + (16-PAGE_SHIFT) + 1); order >= (DSP_ORDER + 2 + 1); order--)
 		if((rawbuf = (void *)__get_free_pages(GFP_KERNEL|GFP_DMA, order)))
 			break;
 
@@ -2916,18 +2952,15 @@
 		return 1;
 	}
 
-	s->card->dmapages = rawbuf;
-	s->card->dmaorder = order;
+	c->dmapages = rawbuf;
+	c->dmaorder = order;
 
-	for(i=0;i<NR_DSPS;i++) {
-		struct ess_state *ess = &s->card->channels[i];
+	for(i = 0; i < c->channel_count; i++) {
+		struct ess_state *ess = &c->channels[i];
 
-		if(ess->dev_audio == -1)
-			continue;
-
-		ess->dma_dac.ready = s->dma_dac.mapped = 0;
-		ess->dma_adc.ready = s->dma_adc.mapped = 0;
-		ess->dma_adc.buforder = ess->dma_dac.buforder = order - 1 - dsps_order - 1;
+		ess->dma_dac.ready = 0;
+		ess->dma_adc.ready = 0;
+		ess->dma_adc.buforder = ess->dma_dac.buforder = order - 1 - DSP_ORDER - 1;
 
 		/* offset dac and adc buffers starting half way through and then at each [da][ad]c's
 			order's intervals.. */
@@ -2950,105 +2983,104 @@
 	return 0;
 } 
 static void
-free_buffers(struct ess_state *s)
+free_buffers(struct ess_card *c)
 {
 	struct page *page, *pend;
 
-	s->dma_dac.rawbuf = s->dma_adc.rawbuf = NULL;
-	s->dma_dac.mapped = s->dma_adc.mapped = 0;
-	s->dma_dac.ready = s->dma_adc.ready = 0;
+	M_printk("maestro: freeing %p\n",c->dmapages);
 
-	M_printk("maestro: freeing %p\n",s->card->dmapages);
 	/* undo marking the pages as reserved */
-
-	pend = virt_to_page(s->card->dmapages + (PAGE_SIZE << s->card->dmaorder) - 1);
-	for (page = virt_to_page(s->card->dmapages); page <= pend; page++)
+	pend = virt_to_page(c->dmapages + (PAGE_SIZE << c->dmaorder) - 1);
+	for (page = virt_to_page(c->dmapages); page <= pend; page++)
 		mem_map_unreserve(page);
 
-	free_pages((unsigned long)s->card->dmapages,s->card->dmaorder);
-	s->card->dmapages = NULL;
+	free_pages((unsigned long)c->dmapages,c->dmaorder);
+	c->dmapages = NULL;
 }
 
 static int 
 ess_open(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
+	struct ess_card *card = NULL;
 	struct ess_state *s = NULL;
+ 	struct pci_dev *pdev = NULL;
+	int i;
 	unsigned char fmtm = ~0, fmts = 0;
-	struct pci_dev *pdev;
-	/*
-	 *	Scan the cards and find the channel. We only
-	 *	do this at open time so it is ok
-	 */
 
-	pci_for_each_dev(pdev) {
-		struct ess_card *c;
-		struct pci_driver *drvr;
-
-		drvr = pci_dev_driver (pdev);
-		if (drvr == &maestro_pci_driver) {
-			int i;
-			struct ess_state *sp;
+ 	pci_for_each_dev(pdev) {
+ 		struct pci_driver *drvr;
+ 
+ 		drvr = pci_dev_driver (pdev);
+ 		if (drvr == &maestro_pci_driver) {
+ 			card = (struct ess_card*)pci_get_drvdata (pdev);
+ 			if (!card)
+ 				continue;
+			if (card->dev_audio == minor)
+				break;
+  		}
+  	}
 
-			c = (struct ess_card*)pci_get_drvdata (pdev);
-			if (!c)
-				continue;
-			for(i=0;i<NR_DSPS;i++)
-			{
-				sp=&c->channels[i];
-				if(sp->dev_audio < 0)
-					continue;
-				if((sp->dev_audio ^ minor) & ~0xf)
-					continue;
-				s=sp;
-			}
-		}
-	}
-	if (!s)
+	/* Found the card the user wanted? */
+	if (card == NULL)
 		return -ENODEV;
+	
+	/* Find the card that the user opened. */
+	while (s == NULL)
+	{
+		/* Lock the list of channels. */
+		down(&card->open_semaphore);
+	
+		/* Scan the card and find an available channel. */
+		for(i = 0; i < card->channel_count && s == NULL; i++)
+		{
+			if(card->channels[i].open_mode != 0)
+				continue; /* busy */
+			
+			s = &card->channels[i];
+		}
 
-       	VALIDATE_STATE(s);
-	file->private_data = s;
-	/* wait for device to become free */
-	down(&s->open_sem);
-	while (s->open_mode & file->f_mode) {
-		if (file->f_flags & O_NONBLOCK) {
-			up(&s->open_sem);
+		if (s != NULL)
+			break;
+		
+		/* Unlock this card. */
+		up(&card->open_semaphore);
+		if (file->f_flags & O_NONBLOCK)
 			return -EWOULDBLOCK;
-		}
-		up(&s->open_sem);
-		interruptible_sleep_on(&s->open_wait);
+	
+		/* Sleep until something happens. */
+		interruptible_sleep_on(&card->open_queue);
 		if (signal_pending(current))
 			return -ERESTARTSYS;
-		down(&s->open_sem);
 	}
+		
+	/* Found an available channel. */
+       	VALIDATE_STATE(s);
+	file->private_data = s;
 
-	/* under semaphore.. */
-	if ((s->card->dmapages==NULL) && allocate_buffers(s)) {
-		up(&s->open_sem);
-		return -ENOMEM;
+	if (!persist)
+	{
+		if ((card->dmapages==NULL) && allocate_buffers(card)) {
+			up(&card->open_semaphore);
+			return -ENOMEM;
+		}
 	}
 
 	/* we're covered by the open_sem */
-	if( ! s->card->dsps_open )  {
-		maestro_power(s->card,ACPI_D0);
+	if( ! card->dsps_open )  {
+		maestro_power(card,ACPI_D0);
 		start_bob(s);
 	}
-	s->card->dsps_open++;
-	M_printk("maestro: open, %d bobs now\n",s->card->dsps_open);
+	card->dsps_open++;
+	M_printk("maestro: open, %d bobs now\n",card->dsps_open);
 
 	/* ok, lets write WC base regs now that we've 
-		powered up the chip */
-	M_printk("maestro: writing 0x%lx (bus 0x%lx) to the wp\n",virt_to_bus(s->card->dmapages),
-		((virt_to_bus(s->card->dmapages))&0xFFE00000)>>12);
-	set_base_registers(s,s->card->dmapages);
+	   powered up the chip */
+	M_printk("maestro: writing 0x%lx (bus 0x%lx) to the wp\n",virt_to_bus(card->dmapages),
+		 ((virt_to_bus(card->dmapages))&0xFFE00000)>>12);
+	set_base_registers(s,card->dmapages);
 
 	if (file->f_mode & FMODE_READ) {
-/*
-		fmtm &= ~((ESS_FMT_STEREO | ESS_FMT_16BIT) << ESS_ADC_SHIFT);
-		if ((minor & 0xf) == SND_DEV_DSP16)
-			fmts |= ESS_FMT_16BIT << ESS_ADC_SHIFT; */
-
 		fmtm &= ~((ESS_FMT_STEREO|ESS_FMT_16BIT) << ESS_ADC_SHIFT);
 		fmts = (ESS_FMT_STEREO|ESS_FMT_16BIT) << ESS_ADC_SHIFT;
 
@@ -3066,7 +3098,7 @@
 	set_fmt(s, fmtm, fmts);
 	s->open_mode |= file->f_mode & (FMODE_READ | FMODE_WRITE);
 
-	up(&s->open_sem);
+	up(&card->open_semaphore);
 	return 0;
 }
 
@@ -3074,12 +3106,14 @@
 ess_release(struct inode *inode, struct file *file)
 {
 	struct ess_state *s = (struct ess_state *)file->private_data;
+	struct ess_card  *card = s->card;
 
 	VALIDATE_STATE(s);
-	lock_kernel();
+	lock_kernel();			/* need this? --daniel */
 	if (file->f_mode & FMODE_WRITE)
 		drain_dac(s, file->f_flags & O_NONBLOCK);
-	down(&s->open_sem);
+
+	down(&card->open_semaphore);
 	if (file->f_mode & FMODE_WRITE) {
 		stop_dac(s);
 	}
@@ -3089,15 +3123,18 @@
 		
 	s->open_mode &= (~file->f_mode) & (FMODE_READ|FMODE_WRITE);
 	/* we're covered by the open_sem */
-	M_printk("maestro: %d dsps now alive\n",s->card->dsps_open-1);
-	if( --s->card->dsps_open <= 0) {
-		s->card->dsps_open = 0;
+	M_printk("maestro: %d dsps now alive\n",card->dsps_open-1);
+	if( --card->dsps_open <= 0) {
+		card->dsps_open = 0;
 		stop_bob(s);
-		free_buffers(s);
-		maestro_power(s->card,ACPI_D2);
+		if (!persist)
+			free_buffers(card);
+		maestro_power(card,ACPI_D2);
 	}
-	up(&s->open_sem);
-	wake_up(&s->open_wait);
+
+	/* Tell callers they can find an open channel. */
+	up(&card->open_semaphore);
+	wake_up(&card->open_queue);
 	unlock_kernel();
 	return 0;
 }
@@ -3384,14 +3421,13 @@
 static int __init
 maestro_probe(struct pci_dev *pcidev,const struct pci_device_id *pdid)
 {
-	int card_type = pdid->driver_data;
+ 	int card_type = pdid->driver_data;
 	u32 n;
 	int iobase;
-	int i, ret;
+ 	int i, ret;
 	struct ess_card *card;
 	struct ess_state *ess;
 	struct pm_dev *pmdev;
-	int num = 0;
 
 /* when built into the kernel, we only print version if device is found */
 #ifndef MODULE
@@ -3402,24 +3438,23 @@
 
 	/* don't pick up weird modem maestros */
 	if(((pcidev->class >> 8) & 0xffff) != PCI_CLASS_MULTIMEDIA_AUDIO)
-		return -ENODEV;
-
-
-	if ((ret=pci_enable_device(pcidev)))
-		return ret;
-			
-	iobase = pci_resource_start(pcidev,0);
-	if (!iobase || !(pci_resource_flags(pcidev, 0 ) & IORESOURCE_IO))
-		return -ENODEV;
-
-	if(pcidev->irq == 0)
-		return -ENODEV;
+ 		return -ENODEV;
+ 
+ 	if ((ret=pci_enable_device(pcidev)))
+ 		return ret;
+  			
+ 	iobase = pci_resource_start(pcidev,0);
+ 	if (!iobase || !(pci_resource_flags(pcidev, 0 ) & IORESOURCE_IO))
+ 		return -ENODEV;
+ 
+ 	if(pcidev->irq == 0)
+ 		return -ENODEV;
 
 	/* stake our claim on the iospace */
 	if( request_region(iobase, 256, card_names[card_type]) == NULL )
 	{
 		printk(KERN_WARNING "maestro: can't allocate 256 bytes I/O at 0x%4.4x\n", iobase);
-		return -EBUSY;
+ 		return -EBUSY;
 	}
 
 	/* just to be sure */
@@ -3437,18 +3472,29 @@
 	card->pcidev = pcidev;
 
 	pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev),
-			maestro_pm_callback);
+			    maestro_pm_callback);
 	if (pmdev)
 		pmdev->data = card;
 
+	/* Allocate the DSP channel. */
+	if ((card->dev_audio = register_sound_dsp(&ess_audio_fops, -1)) < 0)
+	{
+		kfree(card);
+		printk(KERN_WARNING "maestro: unable to allocate DSP device.\n");
+		return -ENOMEM;
+	}
+	
 	card->iobase = iobase;
 	card->card_type = card_type;
 	card->irq = pcidev->irq;
 	card->magic = ESS_CARD_MAGIC;
+ 	card->dock_mute_vol = 50;
 	spin_lock_init(&card->lock);
 	init_waitqueue_head(&card->suspend_queue);
+ 
 
-	card->dock_mute_vol = 50;
+	init_waitqueue_head(&card->open_queue);
+	init_MUTEX(&card->open_semaphore);
 	
 	/* init our groups of 6 apus */
 	for(i=0;i<NR_DSPS;i++)
@@ -3460,9 +3506,7 @@
 		s->card = card;
 		init_waitqueue_head(&s->dma_adc.wait);
 		init_waitqueue_head(&s->dma_dac.wait);
-		init_waitqueue_head(&s->open_wait);
 		spin_lock_init(&s->lock);
-		init_MUTEX(&s->open_sem);
 		s->magic = ESS_STATE_MAGIC;
 		
 		s->apu[0] = 6*i;
@@ -3473,44 +3517,39 @@
 		s->apu[5] = (6*i)+5;
 		
 		if(s->dma_adc.ready || s->dma_dac.ready || s->dma_adc.rawbuf)
-			printk("maestro: BOTCH!\n");
+			printk(KERN_WARNING "maestro: Failed to init card DAC correctly!\n");
 		/* register devices */
-		if ((s->dev_audio = register_sound_dsp(&ess_audio_fops, -1)) < 0)
-			break;
-	}
-	
-	num = i;
-	
-	/* clear the rest if we ran out of slots to register */
-	for(;i<NR_DSPS;i++)
-	{
-		struct ess_state *s=&card->channels[i];
-		s->dev_audio = -1;
 	}
+
+	/* Remember the number of channels allocated on this card. */
+	card->channel_count = i;
+
+	/* REVISIT: 'num' becomes 'card->channel_count'  */
 	
 	ess = &card->channels[0];
 
+
 	/*
 	 *	Ok card ready. Begin setup proper
 	 */
 
 	printk(KERN_INFO "maestro: Configuring %s found at IO 0x%04X IRQ %d\n", 
-		card_names[card_type],iobase,card->irq);
+	       card_names[card_type],iobase,card->irq);
 	pci_read_config_dword(pcidev, PCI_SUBSYSTEM_VENDOR_ID, &n);
 	printk(KERN_INFO "maestro:  subvendor id: 0x%08x\n",n); 
 
 	/* turn off power management unless:
 	 *	- the user explicitly asks for it
 	 * 		or
-	 *		- we're not a 2e, lesser chipps seem to have problems.
-	 *		- we're not on our _very_ small whitelist.  some implemenetations
-	 *			really dont' like the pm code, others require it.
+	 *		- we're not a 2e, lesser chips seem to have problems.
+	 *		- we're not on our _very_ small whitelist.  some implementations
+	 *			really don't like the pm code, others require it.
 	 *			feel free to expand this as required.
 	 */
 #define SUBSYSTEM_VENDOR(x) (x&0xffff)
 	if(	(use_pm != 1) && 
 		((card_type != TYPE_MAESTRO2E)	|| (SUBSYSTEM_VENDOR(n) != 0x1028)))
-			use_pm = 0;
+		use_pm = 0;
 
 	if(!use_pm) 
 		printk(KERN_INFO "maestro: not attempting power management.\n");
@@ -3527,7 +3566,7 @@
 
 	if(maestro_ac97_get(card, 0x00)==0x0080) {
 		printk(KERN_ERR "maestro: my goodness!  you seem to have a pt101 codec, which is quite rare.\n"
-				"\tyou should tell someone about this.\n");
+		       "\tyou should tell someone about this.\n");
 	} else {
 		maestro_ac97_init(card);
 	}
@@ -3541,50 +3580,62 @@
 	
 	if((ret=request_irq(card->irq, ess_interrupt, SA_SHIRQ, card_names[card_type], card)))
 	{
-		printk(KERN_ERR "maestro: unable to allocate irq %d,\n", card->irq);
+		printk(KERN_ERR "maestro: unable to allocate irq %d.\n", card->irq);
 		unregister_sound_mixer(card->dev_mixer);
-		for(i=0;i<NR_DSPS;i++)
-		{
-			struct ess_state *s = &card->channels[i];
-			if(s->dev_audio != -1)
-				unregister_sound_dsp(s->dev_audio);
-		}
+		unregister_sound_dsp(card->dev_audio);
 		release_region(card->iobase, 256);		
 		unregister_reboot_notifier(&maestro_nb);
 		kfree(card);
 		return ret;
 	}
 
-	/* Turn on hardware volume control interrupt.
-	   This has to come after we grab the IRQ above,
-	   or a crash will result on installation if a button has been pressed,
-	   because in that case we'll get an immediate interrupt. */
-	n = inw(iobase+0x18);
-	n|=(1<<6);
-	outw(n, iobase+0x18);
-
-	pci_set_drvdata(pcidev,card);
+	/* Allocate buffers if we are doing them persistently. */
+	if (persist)
+	{
+		if (allocate_buffers(card))
+		{
+			printk(KERN_ERR "maestro: unable to allocate dsp buffer.\n");
+			unregister_sound_mixer(card->dev_mixer);
+			unregister_sound_dsp(card->dev_audio);
+			release_region(card->iobase, 256);		
+			unregister_reboot_notifier(&maestro_nb);
+			kfree(card);
+			return -ENOMEM;
+		}
+		printk(KERN_INFO "maestro: persistent dsp buffer allocated.\n");
+	}
+ 
+ 	/* Turn on hardware volume control interrupt.
+ 	   This has to come after we grab the IRQ above,
+ 	   or a crash will result on installation if a button has been pressed,
+ 	   because in that case we'll get an immediate interrupt. */
+ 	n = inw(iobase+0x18);
+ 	n|=(1<<6);
+ 	outw(n, iobase+0x18);
+ 
+ 	pci_set_drvdata(pcidev,card);
+	
 	/* now go to sleep 'till something interesting happens */
 	maestro_power(card,ACPI_D2);
 
-	printk(KERN_INFO "maestro: %d channels configured.\n", num);
-	return 0;
+	printk(KERN_INFO "maestro: %d channels configured.\n", card->channel_count);
+	return 0; 
 }
 
 static void maestro_remove(struct pci_dev *pcidev) {
 	struct ess_card *card = pci_get_drvdata(pcidev);
-	int i;
 	
 	/* XXX maybe should force stop bob, but should be all 
 		stopped by _release by now */
+
+	/* Release any persistent buffer from the card. */
+	if (persist)
+		free_buffers(card);
+ 
 	free_irq(card->irq, card);
 	unregister_sound_mixer(card->dev_mixer);
-	for(i=0;i<NR_DSPS;i++)
-	{
-		struct ess_state *ess = &card->channels[i];
-		if(ess->dev_audio != -1)
-			unregister_sound_dsp(ess->dev_audio);
-	}
+	unregister_sound_dsp(card->dev_audio);
+
 	/* Goodbye, Mr. Bond. */
 	maestro_power(card,ACPI_D3);
  	release_region(card->iobase, 256);
@@ -3615,14 +3666,22 @@
 #ifdef MODULE
 	printk(version);
 #endif
-	if (dsps_order < 0)   {
-		dsps_order = 1;
-		printk(KERN_WARNING "maestro: clipping dsps_order to %d\n",dsps_order);
-	}
-	else if (dsps_order > MAX_DSP_ORDER)  {
-		dsps_order = MAX_DSP_ORDER;
-		printk(KERN_WARNING "maestro: clipping dsps_order to %d\n",dsps_order);
+	if (channels < 0)   {
+		channels = 1;
+		printk(KERN_WARNING "maestro: minimum channel count 1.\n");
+	}
+	else if (channels > MAX_DSPS)  {
+		channels = MAX_DSPS;
+		printk(KERN_WARNING "maestro: maximum channel count %d.\n",MAX_DSPS);
+	}
+
+	/* Make sure we have a sensible order value. */
+	if (channels != NR_DSPS)
+	{
+		channels = NR_DSPS;
+		printk(KERN_WARNING "maestro: clipping channel count to %d\n",channels);
 	}
+
 	return 0;
 }
 
@@ -3630,22 +3689,58 @@
 {
 	/* this notifier is called when the kernel is really shut down. */
 	M_printk("maestro: shutting down\n");
-	/* this will remove all card instances too */
-	pci_unregister_driver(&maestro_pci_driver);
-	/* XXX dunno about power management */
+ 	/* this will remove all card instances too */
+ 	pci_unregister_driver(&maestro_pci_driver);
+ 	/* XXX dunno about power management */
 	return NOTIFY_OK;
 }
 
 /* --------------------------------------------------------------------- */
 
-
 void cleanup_maestro(void) {
 	M_printk("maestro: unloading\n");
-	pci_unregister_driver(&maestro_pci_driver);
-	pm_unregister_all(maestro_pm_callback);
-	unregister_reboot_notifier(&maestro_nb);
+ 	pci_unregister_driver(&maestro_pci_driver);
+ 	pm_unregister_all(maestro_pm_callback);
+ 	unregister_reboot_notifier(&maestro_nb);
+}
+
+
+#if !defined(MODULE)
+
+/* Process our command line arguments. */
+static int __init setup_maestro(char *str)
+{
+	char *option;
+	
+	if (!str || !*str)
+		return 0;
+
+	/* Read out our options. */
+	for (option = strtok(str, ",");
+	     option != NULL;
+	     option = strtok(NULL, ",")
+	)
+	{
+		if (!strncmp(option, "channels:", 9))
+			channels = simple_strtoul(option + 9, NULL, 0);
+		else if (!strncmp(option, "use_pm:", 7))
+			use_pm = simple_strtoul(option + 7, NULL, 0);
+		else if (!strncmp(option, "persist:", 8))
+			persist = simple_strtoul(option + 8, NULL, 0);
+		else if (!strncmp(option, "clocking:", 9))
+			clocking = simple_strtoul(option + 9, NULL, 0);
+#ifdef M_DEBUG		
+		else if (!strncmp(option, "debug:", 6))
+			debug = simple_strtoul(option + 6, NULL, 0);
+#endif /* M_DEBUG */
+	}
+
+	return 1;
 }
 
+__setup("maestro=", setup_maestro);
+#endif
+
 /* --------------------------------------------------------------------- */
 
 void
@@ -3678,18 +3773,14 @@
 		to power it up */
 	maestro_power(card,ACPI_D0);
 
-	for(i=0;i<NR_DSPS;i++) {
+	for(i=0;i<card->channel_count;i++) {
 		struct ess_state *s = &card->channels[i];
 
-		if(s->dev_audio == -1)
-			continue;
-
 		M_printk("maestro: stopping apus for device %d\n",i);
 		stop_dac(s);
 		stop_adc(s);
 		for(j=0;j<6;j++) 
 			card->apu_map[s->apu[j]][5]=apu_get_register(s,j,5);
-
 	}
 
 	/* get rid of interrupts? */
@@ -3730,13 +3821,10 @@
 	/* set each channels' apu control registers before
 	 * restoring audio 
 	 */
-	for(i=0;i<NR_DSPS;i++) {
+	for(i=0;i<card->channel_count;i++) {
 		struct ess_state *s = &card->channels[i];
 		int chan,reg;
 
-		if(s->dev_audio == -1)
-			continue;
-
 		for(chan = 0 ; chan < 6 ; chan++) {
 			wave_set_register(s,s->apu[chan]<<3,s->apu_base[chan]);
 			for(reg = 1 ; reg < NR_APU_REGS ; reg++)  
@@ -3756,7 +3844,7 @@
 			this card */
 		maestro_power(card,ACPI_D0);
 		start_bob(&card->channels[0]);
-		for(i=0;i<NR_DSPS;i++) {
+		for(i = 0;i < card->channel_count; i++) {
 			struct ess_state *s = &card->channels[i];
 
 			/* these use the apu_mode, and can handle

--=-=-=


-- 
Sweet is pleasure after pain.
        -- John Dryden,  _Alexander's Feast_, 1697

--=-=-=--
