Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130509AbQKIMj5>; Thu, 9 Nov 2000 07:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQKIMjs>; Thu, 9 Nov 2000 07:39:48 -0500
Received: from ns.caldera.de ([212.34.180.1]:64528 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130509AbQKIMjY>;
	Thu, 9 Nov 2000 07:39:24 -0500
Date: Thu, 9 Nov 2000 13:39:10 +0100
Message-Id: <200011091239.NAA05580@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: david@linux.com (David Ford)
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: OOPS loading cs46xx module, test11-pre1
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3A09FFFB.97E1C739@linux.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A09FFFB.97E1C739@linux.com> you wrote:
>
> [...]
>
> This is also the card that doesn't init if it's compiled in and only
> works as a module.

I have an (untested) update for the cs46xx driver in Linux 2.4.
It includes Nils' 2.2 changes, use of initcalls (so compiled-in
should work) and use of the 2.4 PCI interface.

Could you try it?

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.

--- linux.orig/drivers/sound/cs46xx.c	Thu Oct 19 13:21:34 2000
+++ linux/drivers/sound/cs46xx.c	Tue Oct 24 23:55:01 2000
@@ -26,6 +26,12 @@
  *	20000815	Updated driver to kernel 2.4, some cleanups/fixes
  *			Nils Faerber <nils@kernelconcepts.de>
  *
+ *	20000909	Changed cs_read, cs_write and drain_dac
+ *			Nils Faerber <nils@kernelconcepts.de>
+ *
+ *	20001023	Ported to Linux 2.4 PCI interface
+ *			Christoph Hellwig <hch@caldera.de>
+ *
  */
  
 #include <linux/module.h>
@@ -70,18 +76,11 @@
 
 #define GOF_PER_SEC	200
 
-/*
- * Define this to enable recording,
- * this is curently broken and using it will cause data corruption
- * in kernel- and user-space!
- */
-/* #define CS46XX_ENABLE_RECORD */
-
 static int external_amp = 0;
 static int thinkpad = 0;
 
 
-/* an instance of the 4610 channel */
+/* An instance of the 4610 channel */
 
 struct cs_channel 
 {
@@ -90,7 +89,7 @@
 	void *state;
 };
 
-#define DRIVER_VERSION "0.09"
+#define DRIVER_VERSION "0.14"
 
 /* magic numbers to protect our data structures */
 #define CS_CARD_MAGIC		0x46524F4D /* "FROM" */
@@ -167,7 +166,7 @@
 	unsigned int magic;
 
 	/* We keep cs461x cards in a linked list */
-	struct cs_card *next;
+	struct list_head devs;
 
 	/* The cs461x has a certain amount of cross channel interaction
 	   so we use a single per card lock */
@@ -218,7 +217,7 @@
 	void (*free_pcm_channel)(struct cs_card *, int chan);
 };
 
-static struct cs_card *devs = NULL;
+static LIST_HEAD(devs);
 
 static int cs_open_mixdev(struct inode *inode, struct file *file);
 static int cs_release_mixdev(struct inode *inode, struct file *file);
@@ -785,7 +784,7 @@
 
 		tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
 		tmo >>= sample_shift[dmabuf->fmt];
-		tmo += (4096*HZ)/dmabuf->rate;
+		tmo += (2048*HZ)/dmabuf->rate;
 
 		if (!schedule_timeout(tmo ? tmo : 1) && tmo){
 			printk(KERN_ERR "cs461x: drain_dac, dma timeout? %d\n", count);
@@ -842,8 +841,9 @@
 					memset (dmabuf->rawbuf + swptr, silence, clear_cnt);
 					dmabuf->endcleared = 1;
 				}
-			}			
-			wake_up(&dmabuf->wait);
+			}
+			if (dmabuf->count < (signed)dmabuf->dmasize/2)
+				wake_up(&dmabuf->wait);
 		}
 	}
 	/* error handling and process wake up for DAC */
@@ -862,7 +862,8 @@
 				__stop_dac(state);
 				dmabuf->error++;
 			}
-			wake_up(&dmabuf->wait);
+			if (dmabuf->count < (signed)dmabuf->dmasize/2)
+				wake_up(&dmabuf->wait);
 		}
 	}
 }
@@ -872,7 +873,7 @@
 	memcpy(state->dmabuf.rawbuf + (2048*state->dmabuf.pringbuf++),
 		state->dmabuf.pbuf+2048*state->dmabuf.ppingbuf++, 2048);
 	state->dmabuf.ppingbuf&=1;
-	if(state->dmabuf.pringbuf > (PAGE_SIZE<<state->dmabuf.buforder)/2048)
+	if(state->dmabuf.pringbuf >= (PAGE_SIZE<<state->dmabuf.buforder)/2048)
 		state->dmabuf.pringbuf=0;
 	cs_update_ptr(state);
 }
@@ -927,6 +928,7 @@
 {
 	struct cs_state *state = (struct cs_state *)file->private_data;
 	struct dmabuf *dmabuf = &state->dmabuf;
+	DECLARE_WAITQUEUE(wait, current);
 	ssize_t ret;
 	unsigned long flags;
 	unsigned swptr;
@@ -946,6 +948,7 @@
 		return -EFAULT;
 	ret = 0;
 
+	add_wait_queue(&state->dmabuf.wait, &wait);
 	while (count > 0) {
 		spin_lock_irqsave(&state->card->lock, flags);
 		if (dmabuf->count > (signed) dmabuf->dmasize) {
@@ -958,49 +961,34 @@
 		cnt = dmabuf->dmasize - swptr;
 		if (dmabuf->count < cnt)
 			cnt = dmabuf->count;
+		if (cnt <= 0)
+			__set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 		if (cnt > count)
 			cnt = count;
 		if (cnt <= 0) {
-			unsigned long tmo;
 			/* buffer is empty, start the dma machine and wait for data to be
 			   recorded */
 			start_adc(state);
 			if (file->f_flags & O_NONBLOCK) {
-				if (!ret) ret = -EAGAIN;
-				return ret;
-			}
-			/* This isnt strictly right for the 810  but it'll do */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
-			tmo >>= sample_shift[dmabuf->fmt];
-			/* There are two situations when sleep_on_timeout returns, one is when
-			   the interrupt is serviced correctly and the process is waked up by
-			   ISR ON TIME. Another is when timeout is expired, which means that
-			   either interrupt is NOT serviced correctly (pending interrupt) or it
-			   is TOO LATE for the process to be scheduled to run (scheduler latency)
-			   which results in a (potential) buffer overrun. And worse, there is
-			   NOTHING we can do to prevent it. */
-			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-#ifdef DEBUG
-				printk(KERN_ERR "cs461x: recording schedule timeout, "
-				       "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
-				       dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
-				       dmabuf->hwptr, dmabuf->swptr);
-#endif
-				/* a buffer overrun, we delay the recovery untill next time the
-				   while loop begin and we REALLY have space to record */
+				if (!ret)
+					ret = -EAGAIN;
+				remove_wait_queue(&state->dmabuf.wait, &wait);
+				break;
 			}
+			schedule();
 			if (signal_pending(current)) {
 				ret = ret ? ret : -ERESTARTSYS;
-				return ret;
+				break;
 			}
 			continue;
 		}
 
 		if (copy_to_user(buffer, dmabuf->rawbuf + swptr, cnt)) {
-			if (!ret) ret = -EFAULT;
-			return ret;
+			if (!ret)
+				ret = -EFAULT;
+			break;
 		}
 
 		swptr = (swptr + cnt) % dmabuf->dmasize;
@@ -1015,6 +1003,8 @@
 		ret += cnt;
 		start_adc(state);
 	}
+	remove_wait_queue(&state->dmabuf.wait, &wait);
+	set_current_state(TASK_RUNNING);
 	return ret;
 }
 
@@ -1024,7 +1014,8 @@
 {
 	struct cs_state *state = (struct cs_state *)file->private_data;
 	struct dmabuf *dmabuf = &state->dmabuf;
-	ssize_t ret;
+	DECLARE_WAITQUEUE(wait, current);
+	ssize_t ret = 0;
 	unsigned long flags;
 	unsigned swptr;
 	int cnt;
@@ -1041,8 +1032,8 @@
 		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
-	ret = 0;
 
+	add_wait_queue(&state->dmabuf.wait, &wait);
 	while (count > 0) {
 		spin_lock_irqsave(&state->card->lock, flags);
 		if (dmabuf->count < 0) {
@@ -1055,48 +1046,34 @@
 		cnt = dmabuf->dmasize - swptr;
 		if (dmabuf->count + cnt > dmabuf->dmasize)
 			cnt = dmabuf->dmasize - dmabuf->count;
+		if (cnt <= 0)
+			__set_current_state(TASK_INTERRUPTIBLE);
 		spin_unlock_irqrestore(&state->card->lock, flags);
 
 		if (cnt > count)
 			cnt = count;
 		if (cnt <= 0) {
-			unsigned long tmo;
 			/* buffer is full, start the dma machine and wait for data to be
 			   played */
 			start_dac(state);
 			if (file->f_flags & O_NONBLOCK) {
-				if (!ret) ret = -EAGAIN;
-				return ret;
-			}
-			/* Not strictly correct but works */
-			tmo = (dmabuf->dmasize * HZ) / (dmabuf->rate * 2);
-			tmo >>= sample_shift[dmabuf->fmt];
-			/* There are two situations when sleep_on_timeout returns, one is when
-			   the interrupt is serviced correctly and the process is waked up by
-			   ISR ON TIME. Another is when timeout is expired, which means that
-			   either interrupt is NOT serviced correctly (pending interrupt) or it
-			   is TOO LATE for the process to be scheduled to run (scheduler latency)
-			   which results in a (potential) buffer underrun. And worse, there is
-			   NOTHING we can do to prevent it. */
-			if (!interruptible_sleep_on_timeout(&dmabuf->wait, tmo)) {
-#ifdef DEBUG
-				printk(KERN_ERR "cs461x: playback schedule timeout, "
-				       "dmasz %u fragsz %u count %i hwptr %u swptr %u\n",
-				       dmabuf->dmasize, dmabuf->fragsize, dmabuf->count,
-				       dmabuf->hwptr, dmabuf->swptr);
-#endif
-				/* a buffer underrun, we delay the recovery untill next time the
-				   while loop begin and we REALLY have data to play */
+				if (!ret)
+					ret = -EAGAIN;
+				remove_wait_queue(&state->dmabuf.wait, &wait);
+				break;
 			}
+			schedule();
 			if (signal_pending(current)) {
-				if (!ret) ret = -ERESTARTSYS;
-				return ret;
+				if (!ret)
+					ret = -ERESTARTSYS;
+				break;
 			}
 			continue;
 		}
 		if (copy_from_user(dmabuf->rawbuf + swptr, buffer, cnt)) {
-			if (!ret) ret = -EFAULT;
-			return ret;
+			if (!ret)
+				ret = -EFAULT;
+			break;
 		}
 
 		swptr = (swptr + cnt) % dmabuf->dmasize;
@@ -1147,10 +1124,17 @@
 	return mask;
 }
 
+
+/*
+ * We let users mmap the ring buffer. Its not the real DMA buffer but
+ * that side of the code is hidden in the IRQ handling. We do a software
+ * emulation of DMA from a 64K or so buffer into a 2K FIFO.
+ * (the hardware probably deserves a moan here but Crystal send me nice
+ * toys ;)).
+ */
+
 static int cs_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return -EINVAL;
-#if 0	
 	struct cs_state *state = (struct cs_state *)file->private_data;
 	struct dmabuf *dmabuf = &state->dmabuf;
 	int ret;
@@ -1166,8 +1150,6 @@
 	} else 
 		return -EINVAL;
 
-	if (vma->vm_offset != 0)
-		return -EINVAL;
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << dmabuf->buforder))
 		return -EINVAL;
@@ -1177,7 +1159,6 @@
 	dmabuf->mapped = 1;
 
 	return 0;
-#endif	
 }
 
 static int cs_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -1501,7 +1482,7 @@
 
 static void amp_voyetra(struct cs_card *card, int change)
 {
-	/* Manage the EAPD bit on the Crystal 4297 */
+	/* Manage the EAPD bit on the Crystal 4297 and the Analog AD1885 */
 	int old=card->amplifier;
 
 	card->amplifier+=change;
@@ -1522,7 +1503,6 @@
 }
 
 
-
 /*
  *	Untested
  */
@@ -1530,7 +1510,6 @@
 static void amp_voyetra_4294(struct cs_card *card, int change)
 {
 	struct ac97_codec *c=card->ac97_codec[0];
-	int old = card->amplifier;
 
 	card->amplifier+=change;
 
@@ -1591,17 +1570,20 @@
 static int cs_open(struct inode *inode, struct file *file)
 {
 	int i = 0;
-	struct cs_card *card = devs;
+	struct cs_card *card;
 	struct cs_state *state = NULL;
 	struct dmabuf *dmabuf = NULL;
+	struct list_head *list;
 
 #ifndef CS46XX_ENABLE_RECORD
 	if (file->f_mode & FMODE_READ)
 		return -ENODEV;
 #endif
 
-	/* find an avaiable virtual channel (instance of /dev/dsp) */
-	while (card != NULL) {
+	for (list = devs.next; ; list = list->next) {
+		if (list == &devs)
+			return -ENODEV;
+		card = list_entry(list, struct cs_card, devs);
 		for (i = 0; i < NR_HW_CH; i++) {
 			if (card->states[i] == NULL) {
 				state = card->states[i] = (struct cs_state *)
@@ -1620,7 +1602,6 @@
 				goto found_virt;
 			}
 		}
-		card = card->next;
 	}
 	/* no more virtual channel avaiable */
 	if (!state)
@@ -1839,7 +1820,11 @@
 {
 	struct cs_card *card = dev->private_data;
 	int count;
+	int val2;
 	
+	if (reg == AC97_CD_VOL)
+		val2 = cs_ac97_get(dev, AC97_CD_VOL);
+
 	/*
 	 *  1. Write ACCAD = Command Address Register = 46Ch for AC97 register address
 	 *  2. Write ACCDA = Command Data Register = 470h    for data to write to AC97
@@ -1881,6 +1866,44 @@
 	 */
 	if (cs461x_peekBA0(card, BA0_ACCTL) & ACCTL_DCV)
 		printk(KERN_WARNING "cs461x: AC'97 write problem, reg = 0x%x, val = 0x%x\n", reg, val);
+
+	/*
+	 *	Adjust power if the mixer is selected/deselected according
+	 *	to the CD.
+	 *
+	 *	IF the CD is a valid input source (mixer or direct) AND
+	 *		the CD is not muted THEN power is needed
+	 *
+	 *	We do two things. When record select changes the input to
+	 *	add/remove the CD we adjust the power count if the CD is
+	 *	unmuted.
+	 *
+	 *	When the CD mute changes we adjust the power level if the
+	 *	CD was a valid input.
+	 *
+	 *	We also check for CD volume != 0, as the CD mute isn't
+	 *	normally tweaked from userspace.
+	 */
+
+	/* CD mute change ? */
+	if (reg == AC97_CD_VOL) {
+		/* Mute bit change ? */
+		if ((val2^val) & 0x8000 || ((val2 == 0x1f1f || val == 0x1f1f) && val2 != val)) {
+			/* This is a hack but its cleaner than the alternatives.
+			   Right now card->ac97_codec[0] might be NULL as we are
+			   still doing codec setup. This does an early assignment
+			   to avoid the problem if it occurs */
+
+			if (card->ac97_codec[0] == NULL)
+				card->ac97_codec[0] = dev;
+
+			/* Mute on */
+			if(val & 0x8000 || val == 0x1f1f)
+				card->amplifier_ctrl(card, -1);
+			else /* Mute off power on */
+				card->amplifier_ctrl(card, 1);
+		}
+	}
 }
 
 
@@ -1890,13 +1913,19 @@
 {
 	int i;
 	int minor = MINOR(inode->i_rdev);
-	struct cs_card *card = devs;
+	struct cs_card *card;
+	struct list_head *list;
 
-	for (card = devs; card != NULL; card = card->next)
+	for (list = devs.next; ; list = list->next) {
+		if (list == &devs)
+			return -ENODEV;
+		card = list_entry(list, struct cs_card, devs);
 		for (i = 0; i < NR_AC97; i++)
 			if (card->ac97_codec[i] != NULL &&
 			    card->ac97_codec[i]->dev_mixer == minor)
 				goto match;
+	}
+
 
 	if (!card)
 		return -ENODEV;
@@ -1905,28 +1934,31 @@
 	file->private_data = card->ac97_codec[i];
 
 	card->active_ctrl(card,1);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
 static int cs_release_mixdev(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
-	struct cs_card *card = devs;
+	struct cs_card *card;
+	struct list_head *list;
 	int i;
-
-	for (card = devs; card != NULL; card = card->next)
+	
+	for (list = devs.next; ; list = list->next) {
+		if (list == &devs)
+			return -ENODEV;
+		card = list_entry(list, struct cs_card, devs);
 		for (i = 0; i < NR_AC97; i++)
 			if (card->ac97_codec[i] != NULL &&
 			    card->ac97_codec[i]->dev_mixer == minor)
 				goto match;
+	}
 
 	if (!card)
 		return -ENODEV;
 match:
 	card->active_ctrl(card, -1);
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -2267,7 +2299,7 @@
          *  for a reset.
          */
         cs461x_pokeBA0(card, BA0_ACCTL, 0);
-        udelay(500);
+        udelay(50);
         cs461x_pokeBA0(card, BA0_ACCTL, ACCTL_RSTN);
 
 	/*
@@ -2282,7 +2314,7 @@
 	 *  generating bit clock (so we don't try to start the PLL without an
 	 *  input clock).
 	 */
-	mdelay(10);		/* 1 should be enough ?? */
+	mdelay(5);		/* 1 should be enough ?? */
 
 	/*
 	 *  Set the serial port timing configuration, so that
@@ -2307,7 +2339,7 @@
 	/*
          *  Wait until the PLL has stabilized.
 	 */
-	mdelay(100);		/* Again 1 should be enough ?? */
+	mdelay(5);		/* Again 1 should be enough ?? */
 
 	/*
 	 *  Turn on clocking of the core so that we can setup the serial ports.
@@ -2488,18 +2520,14 @@
 	{PCI_VENDOR_ID_IBM, 0x0132, "Thinkpad 570", amp_none, clkrun_hack},
 	{PCI_VENDOR_ID_IBM, 0x0153, "Thinkpad 600X/A20/T20", amp_none, clkrun_hack},
 	{PCI_VENDOR_ID_IBM, 0x1010, "Thinkpad 600E (unsupported)", NULL, NULL},
+	{0, 0, "Card without SSID set", NULL, NULL },
 	{0, 0, NULL, NULL, NULL}
 };
 
-static int __init cs_install(struct pci_dev *pci_dev)
+static int __init cs_probe(struct pci_dev * pci_dev, const struct pci_device_id * id)
 {
 	struct cs_card *card;
 	struct cs_card_type *cp = &cards[0];
-	u16 ss_card, ss_vendor;
-
-
-	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_VENDOR_ID, &ss_vendor);
-	pci_read_config_word(pci_dev, PCI_SUBSYSTEM_ID, &ss_card);
 
 	if ((card = kmalloc(sizeof(struct cs_card), GFP_KERNEL)) == NULL) {
 		printk(KERN_ERR "cs461x: out of memory\n");
@@ -2507,8 +2535,8 @@
 	}
 	memset(card, 0, sizeof(*card));
 
-	card->ba0_addr = pci_dev->resource[0].start&PCI_BASE_ADDRESS_MEM_MASK;
-	card->ba1_addr = pci_dev->resource[1].start&PCI_BASE_ADDRESS_MEM_MASK;
+	card->ba0_addr = pci_resource_start(pci_dev, 0);
+	card->ba1_addr = pci_resource_start(pci_dev, 1);
 	card->pci_dev = pci_dev;
 	card->irq = pci_dev->irq;
 	card->magic = CS_CARD_MAGIC;
@@ -2527,7 +2555,7 @@
 
 	while(cp->name)
 	{
-		if(cp->vendor == ss_vendor && cp->id == ss_card)
+		if(cp->vendor == id->subvendor && cp->id == id->subdevice)
 		{
 			card->amplifier_ctrl = cp->amp;
 			if(cp->active)
@@ -2539,7 +2567,7 @@
 	if(cp->name==NULL)
 	{
 	printk(KERN_INFO "cs461x: Unknown card (%04X:%04X) at 0x%08lx/0x%08lx, IRQ %d\n",
-		ss_vendor, ss_card, card->ba0_addr, card->ba1_addr,  card->irq);
+		id->subvendor, id->subdevice, card->ba0_addr, card->ba1_addr,  card->irq);
 	}
 	else
 	{
@@ -2596,9 +2624,11 @@
 		unregister_sound_dsp(card->dev_audio);
 		goto fail;
 	}
-	card->next = devs;
-	devs = card;
-	
+
+	pci_set_drvdata (pci_dev, card);
+
+	list_add_tail(&card->devs, &devs);
+
 	card->active_ctrl(card, -1);
 	return 0;
 	
@@ -2620,11 +2650,13 @@
 
 }
 
-static void cs_remove(struct cs_card *card)
+static void __devexit cs_remove(struct pci_dev * pci_dev)
 {
+	struct cs_card * card = pci_get_drvdata (pci_dev);
 	int i;
 	unsigned int tmp;
-	
+
+	list_del(&card->devs);
 	card->active_ctrl(card,1);
 
 	tmp = cs461x_peek(card, BA1_PFIE);
@@ -2696,10 +2728,28 @@
 
 MODULE_AUTHOR("Alan Cox <alan@redhat.com>, Jaroslav Kysela");
 MODULE_DESCRIPTION("Crystal SoundFusion Audio Support");
+MODULE_PARM(external_amp, "i");
+MODULE_PARM(thinkpad, "i");
+
+static struct pci_device_id cs_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_CIRRUS, 0x6001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_CIRRUS, 0x6003, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_CIRRUS, 0x6004, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE (pci, cs_pci_tbl);
 
-int __init cs_probe(void)
+#define CS_MODULE_NAME	"cs46xx"
+
+static struct pci_driver cs_pci_driver = {
+	name:		CS_MODULE_NAME,
+	id_table:	cs_pci_tbl,
+	probe:		cs_probe,
+	remove:		cs_remove,
+};
+
+static int __init cs_init(void)
 {
-	struct pci_dev *pcidev = NULL;
 	int foundone=0;
 	
 	if (!pci_present())   /* No PCI bus in this machine! */
@@ -2708,45 +2758,17 @@
 	printk(KERN_INFO "Crystal 4280/461x + AC97 Audio, version "
 	       DRIVER_VERSION ", " __TIME__ " " __DATE__ "\n");
 
-	while( (pcidev = pci_find_device(PCI_VENDOR_ID_CIRRUS, 0x6001 , pcidev))!=NULL ) {
-		if (cs_install(pcidev)==0)
-			foundone++;
-	}
-	while( (pcidev = pci_find_device(PCI_VENDOR_ID_CIRRUS, 0x6003 , pcidev))!=NULL ) {
-		if (cs_install(pcidev)==0)
-			foundone++;
-	}
-	while( (pcidev = pci_find_device(PCI_VENDOR_ID_CIRRUS, 0x6004 , pcidev))!=NULL ) {
-		if (cs_install(pcidev)==0)
-			foundone++;
-	}
+	foundone = pci_register_driver(&cs_pci_driver);
 
 	printk(KERN_INFO "cs461x: Found %d audio device(s).\n",
 		foundone);
-	return foundone;
-}
-
-#ifdef MODULE
-
-int init_module(void)
-{
-	if(cs_probe()==0)
-		printk(KERN_ERR "cs461x: No devices found.\n");
-	return 0;
+	return foundone ? 0 : -ENODEV;
 }
 
-void cleanup_module (void)
+static void __exit cs_exit(void)
 {
-	struct cs_card *next;
-	while(devs)
-	{
-		next=devs->next;
-		cs_remove(devs);
-		devs=next;
-	}
+	pci_unregister_driver(&cs_pci_driver);
 }
 
-MODULE_PARM(external_amp, "i");
-MODULE_PARM(thinkpad, "i");
-
-#endif
+module_init(cs_init);
+module_exit(cs_exit);
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
