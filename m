Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129250AbQKRSi6>; Sat, 18 Nov 2000 13:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129385AbQKRSiv>; Sat, 18 Nov 2000 13:38:51 -0500
Received: from ns.caldera.de ([212.34.180.1]:35336 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129250AbQKRSii>;
	Sat, 18 Nov 2000 13:38:38 -0500
Date: Sat, 18 Nov 2000 19:07:43 +0100
Message-Id: <200011181807.TAA27511@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: adam@yggdrasil.com ("Adam J. Richter")
Cc: linux-kernel@vger.kernel.org
Subject: Re: sound and scsi pci MODULE_DEVICE_TABLE entries? (primary for Alan Cox)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <200011180601.WAA01562@adam.yggdrasil.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200011180601.WAA01562@adam.yggdrasil.com> you wrote:


>         Jeff Garzik tells me that you, with some help from some other
> kernel developers, are hacking on the sound drivers right now.  I
> would like to add PCI MODULE_DEVICE_TABLE entries to three of
> the four PCI sound drivers: cmpci, cs46xx and nm256_audio.

I have a patch for cs46xx that does not only add MODULE_DEVICE_TABLE,
but does also adapt it to the 2.4 PCI interface and forward-ports
bug-fixes and other changes from 2.2.  If someone could _please_ test
it, I would like to send it to Linux. (there are people that have cs46xx
problems ..)

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.


diff -uNr linux-2.4.0-test11-pre7/drivers/sound/cs46xx.c linux/drivers/sound/cs46xx.c
--- linux-2.4.0-test11-pre7/drivers/sound/cs46xx.c	Sat Nov 18 13:10:19 2000
+++ linux/drivers/sound/cs46xx.c	Sat Nov 18 13:34:28 2000
@@ -25,9 +25,17 @@
  * Changes:
  *	20000815	Updated driver to kernel 2.4, some cleanups/fixes
  *			Nils Faerber <nils@kernelconcepts.de>
+ *
+ *	20000909	Changed cs_read, cs_write and drain_dac
+ *			Nils Faerber <nils@kernelconcepts.de>
+ *
  *	20001110	Added __initdata to BA1Struct in cs461x_image.h
  *			and three more __init here
  *			Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
+ *
+ *	20001023	Ported to Linux 2.4 PCI interface, some cleanups
+ *			Christoph Hellwig <hch@caldera.de>
+ *
  */
  
 #include <linux/module.h>
@@ -72,18 +80,11 @@
 
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
@@ -92,7 +93,7 @@
 	void *state;
 };
 
-#define DRIVER_VERSION "0.09"
+#define DRIVER_VERSION "0.14"
 
 /* magic numbers to protect our data structures */
 #define CS_CARD_MAGIC		0x46524F4D /* "FROM" */
@@ -169,7 +170,7 @@
 	unsigned int magic;
 
 	/* We keep cs461x cards in a linked list */
-	struct cs_card *next;
+	struct list_head devs;
 
 	/* The cs461x has a certain amount of cross channel interaction
 	   so we use a single per card lock */
@@ -220,7 +221,7 @@
 	void (*free_pcm_channel)(struct cs_card *, int chan);
 };
 
-static struct cs_card *devs = NULL;
+static LIST_HEAD(devs);
 
 static int cs_open_mixdev(struct inode *inode, struct file *file);
 static int cs_release_mixdev(struct inode *inode, struct file *file);
@@ -787,7 +788,7 @@
 
 		tmo = (dmabuf->dmasize * HZ) / dmabuf->rate;
 		tmo >>= sample_shift[dmabuf->fmt];
-		tmo += (4096*HZ)/dmabuf->rate;
+		tmo += (2048*HZ)/dmabuf->rate;
 
 		if (!schedule_timeout(tmo ? tmo : 1) && tmo){
 			printk(KERN_ERR "cs461x: drain_dac, dma timeout? %d\n", count);
@@ -844,8 +845,9 @@
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
@@ -864,7 +866,8 @@
 				__stop_dac(state);
 				dmabuf->error++;
 			}
-			wake_up(&dmabuf->wait);
+			if (dmabuf->count < (signed)dmabuf->dmasize/2)
+				wake_up(&dmabuf->wait);
 		}
 	}
 }
@@ -874,7 +877,7 @@
 	memcpy(state->dmabuf.rawbuf + (2048*state->dmabuf.pringbuf++),
 		state->dmabuf.pbuf+2048*state->dmabuf.ppingbuf++, 2048);
 	state->dmabuf.ppingbuf&=1;
-	if(state->dmabuf.pringbuf > (PAGE_SIZE<<state->dmabuf.buforder)/2048)
+	if(state->dmabuf.pringbuf >= (PAGE_SIZE<<state->dmabuf.buforder)/2048)
 		state->dmabuf.pringbuf=0;
 	cs_update_ptr(state);
 }
@@ -929,6 +932,7 @@
 {
 	struct cs_state *state = (struct cs_state *)file->private_data;
 	struct dmabuf *dmabuf = &state->dmabuf;
+	DECLARE_WAITQUEUE(wait, current);
 	ssize_t ret;
 	unsigned long flags;
 	unsigned swptr;
@@ -948,6 +952,7 @@
 		return -EFAULT;
 	ret = 0;
 
+	add_wait_queue(&state->dmabuf.wait, &wait);
 	while (count > 0) {
 		spin_lock_irqsave(&state->card->lock, flags);
 		if (dmabuf->count > (signed) dmabuf->dmasize) {
@@ -960,49 +965,34 @@
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
@@ -1017,6 +1007,8 @@
 		ret += cnt;
 		start_adc(state);
 	}
+	remove_wait_queue(&state->dmabuf.wait, &wait);
+	set_current_state(TASK_RUNNING);
 	return ret;
 }
 
@@ -1026,7 +1018,8 @@
 {
 	struct cs_state *state = (struct cs_state *)file->private_data;
 	struct dmabuf *dmabuf = &state->dmabuf;
-	ssize_t ret;
+	DECLARE_WAITQUEUE(wait, current);
+	ssize_t ret = 0;
 	unsigned long flags;
 	unsigned swptr;
 	int cnt;
@@ -1043,8 +1036,8 @@
 		return ret;
 	if (!access_ok(VERIFY_READ, buffer, count))
 		return -EFAULT;
-	ret = 0;
 
+	add_wait_queue(&state->dmabuf.wait, &wait);
 	while (count > 0) {
 		spin_lock_irqsave(&state->card->lock, flags);
 		if (dmabuf->count < 0) {
@@ -1057,48 +1050,34 @@
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
@@ -1149,10 +1128,17 @@
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
@@ -1168,7 +1154,7 @@
 	} else 
 		return -EINVAL;
 
-	if (vma->vm_offset != 0)
+	if (vma->vm_pgoff != 0)
 		return -EINVAL;
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << dmabuf->buforder))
@@ -1179,7 +1165,6 @@
 	dmabuf->mapped = 1;
 
 	return 0;
-#endif	
 }
 
 static int cs_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
@@ -1503,7 +1488,7 @@
 
 static void amp_voyetra(struct cs_card *card, int change)
 {
-	/* Manage the EAPD bit on the Crystal 4297 */
+	/* Manage the EAPD bit on the Crystal 4297 and the Analog AD1885 */
 	int old=card->amplifier;
 
 	card->amplifier+=change;
@@ -1524,7 +1509,6 @@
 }
 
 
-
 /*
  *	Untested
  */
@@ -1532,7 +1516,6 @@
 static void amp_voyetra_4294(struct cs_card *card, int change)
 {
 	struct ac97_codec *c=card->ac97_codec[0];
-	int old = card->amplifier;
 
 	card->amplifier+=change;
 
@@ -1593,17 +1576,20 @@
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
@@ -1622,7 +1608,6 @@
 				goto found_virt;
 			}
 		}
-		card = card->next;
 	}
 	/* no more virtual channel avaiable */
 	if (!state)
@@ -1841,7 +1826,11 @@
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
@@ -1883,6 +1872,44 @@
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
 
 
@@ -1892,13 +1919,19 @@
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
@@ -1907,28 +1940,31 @@
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
 
@@ -2269,7 +2305,7 @@
          *  for a reset.
          */
         cs461x_pokeBA0(card, BA0_ACCTL, 0);
-        udelay(500);
+        udelay(50);
         cs461x_pokeBA0(card, BA0_ACCTL, ACCTL_RSTN);
 
 	/*
@@ -2284,7 +2320,7 @@
 	 *  generating bit clock (so we don't try to start the PLL without an
 	 *  input clock).
 	 */
-	mdelay(10);		/* 1 should be enough ?? */
+	mdelay(5);		/* 1 should be enough ?? */
 
 	/*
 	 *  Set the serial port timing configuration, so that
@@ -2309,7 +2345,7 @@
 	/*
          *  Wait until the PLL has stabilized.
 	 */
-	mdelay(100);		/* Again 1 should be enough ?? */
+	mdelay(5);		/* Again 1 should be enough ?? */
 
 	/*
 	 *  Turn on clocking of the core so that we can setup the serial ports.
@@ -2472,8 +2508,7 @@
  *	Card subid table
  */
 
-struct cs_card_type
-{
+struct cs_card_type {
 	u16 vendor;
 	u16 id;
 	char *name;
@@ -2481,7 +2516,7 @@
 	void (*active)(struct cs_card *, int);
 };
 
-static struct cs_card_type __initdata cards[]={
+static struct cs_card_type __devinitdata cards[]={
 	{0x1489, 0x7001, "Genius Soundmaker 128 value", amp_none, NULL},
 	{0x5053, 0x3357, "Voyetra", amp_voyetra, NULL},
 	/* MI6020/21 use the same chipset as the Thinkpads, maybe needed */
@@ -2490,18 +2525,14 @@
 	{PCI_VENDOR_ID_IBM, 0x0132, "Thinkpad 570", amp_none, clkrun_hack},
 	{PCI_VENDOR_ID_IBM, 0x0153, "Thinkpad 600X/A20/T20", amp_none, clkrun_hack},
 	{PCI_VENDOR_ID_IBM, 0x1010, "Thinkpad 600E (unsupported)", NULL, NULL},
+	{0, 0, "Card without SSID set", NULL, NULL },
 	{0, 0, NULL, NULL, NULL}
 };
 
-static int __init cs_install(struct pci_dev *pci_dev)
+static int __devinit cs_probe(struct pci_dev * pci_dev, const struct pci_device_id * id)
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
@@ -2509,8 +2540,8 @@
 	}
 	memset(card, 0, sizeof(*card));
 
-	card->ba0_addr = pci_dev->resource[0].start&PCI_BASE_ADDRESS_MEM_MASK;
-	card->ba1_addr = pci_dev->resource[1].start&PCI_BASE_ADDRESS_MEM_MASK;
+	card->ba0_addr = pci_resource_start(pci_dev, 0);
+	card->ba1_addr = pci_resource_start(pci_dev, 1);
 	card->pci_dev = pci_dev;
 	card->irq = pci_dev->irq;
 	card->magic = CS_CARD_MAGIC;
@@ -2529,7 +2560,7 @@
 
 	while(cp->name)
 	{
-		if(cp->vendor == ss_vendor && cp->id == ss_card)
+		if(cp->vendor == id->subvendor && cp->id == id->subdevice)
 		{
 			card->amplifier_ctrl = cp->amp;
 			if(cp->active)
@@ -2541,7 +2572,7 @@
 	if(cp->name==NULL)
 	{
 	printk(KERN_INFO "cs461x: Unknown card (%04X:%04X) at 0x%08lx/0x%08lx, IRQ %d\n",
-		ss_vendor, ss_card, card->ba0_addr, card->ba1_addr,  card->irq);
+		id->subvendor, id->subdevice, card->ba0_addr, card->ba1_addr,  card->irq);
 	}
 	else
 	{
@@ -2598,9 +2629,11 @@
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
 	
@@ -2622,11 +2655,13 @@
 
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
@@ -2698,57 +2733,38 @@
 
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
+static struct pci_driver cs_pci_driver = {
+	name:		"cs46xx",
+	id_table:	cs_pci_tbl,
+	probe:		cs_probe,
+	remove:		cs_remove,
+};
+
+static int __init cs_init(void)
 {
-	struct pci_dev *pcidev = NULL;
 	int foundone=0;
 	
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
-		
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
-
-	printk(KERN_INFO "cs461x: Found %d audio device(s).\n",
-		foundone);
-	return foundone;
+	return pci_module_init(&cs_pci_driver);
 }
 
-#ifdef MODULE
-
-int init_module(void)
+static void __exit cs_exit(void)
 {
-	if(cs_probe()==0)
-		printk(KERN_ERR "cs461x: No devices found.\n");
-	return 0;
+	pci_unregister_driver(&cs_pci_driver);
 }
 
-void cleanup_module (void)
-{
-	struct cs_card *next;
-	while(devs)
-	{
-		next=devs->next;
-		cs_remove(devs);
-		devs=next;
-	}
-}
-
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
