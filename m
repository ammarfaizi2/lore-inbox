Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133079AbQLJVze>; Sun, 10 Dec 2000 16:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133100AbQLJVzY>; Sun, 10 Dec 2000 16:55:24 -0500
Received: from webmail.metabyte.com ([216.218.208.53]:22396 "EHLO
	webmail.metabyte.com") by vger.kernel.org with ESMTP
	id <S133079AbQLJVzQ>; Sun, 10 Dec 2000 16:55:16 -0500
Message-ID: <3A33F479.6E7B0C50@metabyte.com>
Date: Sun, 10 Dec 2000 13:24:09 -0800
From: Pete Zaitcev <zaitcev@metabyte.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com
CC: zaitcev@metabyte.com, perex@suze.cz, linux-kernel@vger.kernel.org
Subject: Patch for ymfpci in test12-pre7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Dec 2000 21:24:48.0970 (UTC) FILETIME=[A02292A0:01C062EF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus:

The attached patch fixes the following problems with ymfpci in 2.4 tree:

1. Enumeration was wrong, this bit people with several soundcards
   (Abhijit Menon-Sen).
2. Must use semaphore to guard open/close.
3. Old ymfpci locks up if compiled with CONFIG_SMP due to
   recursive calls to spin_lock_irqsave().
4. Endianness buglet with ''rev'' (same as in ALSA).

Also, The patch removes P3 tagged messages that I do not
anticipate to use soon.

More improvements are in my queue (bugs from Pavel Roskin,
Simon Higgins, etc.), which I would like to put in later.

Thanks in advance,
--Pete

--- linux-2.4.0-pre12-test7/drivers/sound/ymfpci.h	Fri Dec  8 22:45:29 2000
+++ linux-2.4.0-test12-pre7-p3/drivers/sound/ymfpci.h	Sat Dec  9 23:36:14 2000
@@ -247,7 +247,7 @@
 };
 
 struct ymf_unit {
-	unsigned int rev;	/* PCI revision */
+	u8 rev;				/* PCI revision */
 	void *reg_area_virt;
 	void *work_ptr;				// +
 
@@ -275,13 +275,13 @@
 	u16 ac97_features;
 
 	struct pci_dev *pci;
-	int inst;		/* Unit number (instance) */
 
 	spinlock_t reg_lock;
 	spinlock_t voice_lock;
 
 	/* soundcore stuff */
 	int dev_audio;
+	struct semaphore open_sem;
 
 	struct list_head ymf_devs;
 	struct ymf_state *states[1];			// *
@@ -331,10 +331,6 @@
 
 struct ymf_state {
 	struct ymf_unit *unit;			/* backpointer */
-
-	/* single open lock mechanism, only used for recording */
-	struct semaphore open_sem;
-	wait_queue_head_t open_wait;
 
 	/* virtual channel number */
 	int virt;				// * unused a.t.m.
--- linux-2.4.0-pre12-test7/drivers/sound/ymfpci.c	Fri Dec  8 22:45:29 2000
+++ linux-2.4.0-test12-pre7-p3/drivers/sound/ymfpci.c	Sun Dec 10 12:55:35 2000
@@ -32,6 +32,9 @@
  *      ? merge ymf_pcm and state
  *      ? pcm interrupt no pointer
  *      ? underused structure members
+ *      - Remove remaining P3 tags (debug messages).
+ *  - Resolve XXX tagged questions.
+ *  - Cannot play 5133Hz.
  */
 
 #include <linux/module.h>
@@ -59,7 +62,7 @@
     int pair, ymfpci_voice_t **rvoice);
 static int ymfpci_voice_free(ymfpci_t *codec, ymfpci_voice_t *pvoice);
 static int ymf_playback_prepare(ymfpci_t *codec, struct ymf_state *state);
-static int ymf_state_alloc(ymfpci_t *unit, int nvirt, int instance);
+static int ymf_state_alloc(ymfpci_t *unit, int nvirt);
 
 static LIST_HEAD(ymf_devs);
 
@@ -602,11 +605,9 @@
 	char silence;
 
 	if ((ypcm = voice->ypcm) == NULL) {
-/* P3 */ printk("ymf_pcm_interrupt: voice %d: no ypcm\n", voice->number);
 		return;
 	}
 	if ((state = ypcm->state) == NULL) {
-/* P3 */ printk("ymf_pcm_interrupt: voice %d: no state\n", voice->number);
 		ypcm->running = 0;	// lock it
 		return;
 	}
@@ -628,7 +629,7 @@
 		if (pos < 0 || pos >= dmabuf->dmasize) {	/* ucode bug */
 			printk(KERN_ERR
 			    "ymfpci%d: %d: runaway: hwptr %d dmasize %d\n",
-			    codec->inst, voice->number,
+			    codec->dev_audio, voice->number,
 			    dmabuf->hwptr, dmabuf->dmasize);
 			pos = 0;
 		}
@@ -645,7 +646,7 @@
 
 		if (dmabuf->count == 0) {
 			printk("ymfpci%d: %d: strain: hwptr %d\n",
-			    codec->inst, voice->number, dmabuf->hwptr);
+			    codec->dev_audio, voice->number, dmabuf->hwptr);
 			ymf_playback_trigger(codec, ypcm, 0);
 		}
 
@@ -664,7 +665,7 @@
 				 */
 				printk("ymfpci%d: %d: lost: delta %d"
 				    " hwptr %d swptr %d distance %d count %d\n",
-				    codec->inst, voice->number, delta,
+				    codec->dev_audio, voice->number, delta,
 				    dmabuf->hwptr, swptr, distance, dmabuf->count);
 			} else {
 				/*
@@ -672,7 +673,7 @@
 				 */
 //				printk("ymfpci%d: %d: done: delta %d"
 //				    " hwptr %d swptr %d distance %d count %d\n",
-//				    codec->inst, voice->number, delta,
+//				    codec->dev_audio, voice->number, delta,
 //				    dmabuf->hwptr, swptr, distance, dmabuf->count);
 			}
 			played = dmabuf->count;
@@ -738,7 +739,6 @@
 {
 
 	if (ypcm->voices[0] == NULL) {
-/* P3 */ printk("ymfpci: trigger %d no voice\n", cmd);
 		return -EINVAL;
 	}
 	if (cmd != 0) {
@@ -911,7 +911,7 @@
 	if ((err = ymfpci_pcm_voice_alloc(ypcm, state->format.voices)) < 0) {
 		/* Cannot be unless we leak voices in ymf_release! */
 		printk(KERN_ERR "ymfpci%d: cannot allocate voice!\n",
-		    codec->inst);
+		    codec->dev_audio);
 		return err;
 	}
 
@@ -1052,7 +1052,7 @@
 	}
 }
 
-static int ymf_state_alloc(ymfpci_t *unit, int nvirt, int instance)
+static int ymf_state_alloc(ymfpci_t *unit, int nvirt)
 {
 	ymfpci_pcm_t *ypcm;
 	struct ymf_state *state;
@@ -1062,7 +1062,6 @@
 	}
 	memset(state, 0, sizeof(struct ymf_state));
 
-	init_waitqueue_head(&state->open_wait);
 	init_waitqueue_head(&state->dmabuf.wait);
 
 	ypcm = &state->ypcm;
@@ -1541,12 +1540,13 @@
 		return put_user(SOUND_VERSION, (int *)arg);
 
 	case SNDCTL_DSP_RESET:
-		/* FIXME: spin_lock ? */
 		if (file->f_mode & FMODE_WRITE) {
 			ymf_wait_dac(state);
+			spin_lock_irqsave(&state->unit->reg_lock, flags);
 			dmabuf->ready = 0;
 			dmabuf->swptr = dmabuf->hwptr = 0;
 			dmabuf->count = dmabuf->total_bytes = 0;
+			spin_unlock_irqrestore(&state->unit->reg_lock, flags);
 		}
 #if HAVE_RECORD
 		if (file->f_mode & FMODE_READ) {
@@ -1576,9 +1576,7 @@
 	case SNDCTL_DSP_SPEED: /* set smaple rate */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_SPEED %d\n", val); */
 		if (val >= 8000 && val <= 48000) {
-			spin_lock_irqsave(&state->unit->reg_lock, flags);
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
 			}
@@ -1587,6 +1585,7 @@
 				stop_adc(state);
 			}
 #endif
+			spin_lock_irqsave(&state->unit->reg_lock, flags);
 			dmabuf->ready = 0;
 			state->format.rate = val;
 			ymf_pcm_update_shift(&state->format);
@@ -1603,7 +1602,6 @@
 	case SNDCTL_DSP_STEREO: /* set stereo or mono channel */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_STEREO %d\n", val); */
 		if (file->f_mode & FMODE_WRITE) {
 			ymf_wait_dac(state); 
 			spin_lock_irqsave(&state->unit->reg_lock, flags);
@@ -1625,7 +1623,6 @@
 		return 0;
 
 	case SNDCTL_DSP_GETBLKSIZE:
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_GETBLKSIZE\n"); */
 		if (file->f_mode & FMODE_WRITE) {
 			if ((val = prog_dmabuf(state, 0)))
 				return val;
@@ -1639,15 +1636,12 @@
 		return -EINVAL;
 
 	case SNDCTL_DSP_GETFMTS: /* Returns a mask of supported sample format*/
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_GETFMTS\n"); */
 		return put_user(AFMT_S16_LE|AFMT_U8, (int *)arg);
 
 	case SNDCTL_DSP_SETFMT: /* Select sample format */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_SETFMT 0x%x\n", val); */
 		if (val == AFMT_S16_LE || val == AFMT_U8) {
-			spin_lock_irqsave(&state->unit->reg_lock, flags);
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
 			}
@@ -1656,6 +1650,7 @@
 				stop_adc(state);
 			}
 #endif
+			spin_lock_irqsave(&state->unit->reg_lock, flags);
 			dmabuf->ready = 0;
 			state->format.format = val;
 			ymf_pcm_update_shift(&state->format);
@@ -1668,22 +1663,24 @@
 			return -EFAULT;
 	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_CHANNELS 0x%x\n", val); */
 		if (val != 0) {
-			spin_lock_irqsave(&state->unit->reg_lock, flags);
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
 				if (val == 1 || val == 2) {
+					spin_lock_irqsave(&state->unit->reg_lock, flags);
 					dmabuf->ready = 0;
 					state->format.voices = val;
 					ymf_pcm_update_shift(&state->format);
+					spin_unlock_irqrestore(&state->unit->reg_lock, flags);
 				}
 			}
 #if HAVE_RECORD
 			if (file->f_mode & FMODE_READ) {
+				spin_lock_irqsave(&state->unit->reg_lock, flags);
 				stop_adc(state);
 				dmabuf->ready = 0;
+				spin_unlock_irqrestore(&state->unit->reg_lock, flags);
 			}
 #endif
-			spin_unlock_irqrestore(&state->unit->reg_lock, flags);
 		}
 		return put_user(state->format.voices, (int *)arg);
 
@@ -1737,7 +1734,6 @@
 		return 0;
 
 	case SNDCTL_DSP_GETOSPACE:
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_GETOSPACE\n"); */
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
 		if (!dmabuf->ready && (val = prog_dmabuf(state, 0)) != 0)
@@ -1768,12 +1764,10 @@
 #endif
 
 	case SNDCTL_DSP_NONBLOCK:
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_NONBLOCK\n"); */
 		file->f_flags |= O_NONBLOCK;
 		return 0;
 
 	case SNDCTL_DSP_GETCAPS:
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_GETCAPS\n"); */
 		/* return put_user(DSP_CAP_REALTIME|DSP_CAP_TRIGGER|DSP_CAP_MMAP,
 			    (int *)arg); */
 		return put_user(0, (int *)arg);
@@ -1826,7 +1820,6 @@
 #endif
 
 	case SNDCTL_DSP_GETOPTR:
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_GETOPTR\n"); */
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
 		spin_lock_irqsave(&state->unit->reg_lock, flags);
@@ -1840,7 +1833,6 @@
 		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo));
 
 	case SNDCTL_DSP_SETDUPLEX:	/* XXX TODO */
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_SETDUPLEX\n"); */
 		return -EINVAL;
 
 #if 0 /* old */
@@ -1871,7 +1863,6 @@
 		return -ENOTTY;
 
 	default:
-	/* P3 */ printk(KERN_WARNING "ymfpci: unknown ioctl cmd 0x%x\n", cmd);
 		/*
 		 * Some programs mix up audio devices and ioctls
 		 * or perhaps they expect "universal" ioctls,
@@ -1886,7 +1877,7 @@
 {
 	struct list_head *list;
 	ymfpci_t *unit;
-	int minor, instance;
+	int minor;
 	struct ymf_state *state;
 	int nvirt;
 	int err;
@@ -1903,24 +1894,24 @@
 	} else {
 		return -ENXIO;
 	}
-	instance = (minor >> 4) & 0x0F;
 	nvirt = 0;			/* Such is the partitioning of minor */
 
-	/* XXX Semaphore here! */
 	for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
 		unit = list_entry(list, ymfpci_t, ymf_devs);
-		if (unit->inst == instance)
+		if (((unit->dev_audio ^ minor) & ~0x0F) == 0)
 			break;
 	}
 	if (list == &ymf_devs)
 		return -ENODEV;
 
+	down(&unit->open_sem);
 	if (unit->states[nvirt] != NULL) {
-		/* P3 */ printk("ymfpci%d: busy\n", unit->inst);
+		up(&unit->open_sem);
 		return -EBUSY;
 	}
 
-	if ((err = ymf_state_alloc(unit, nvirt, instance)) != 0) {
+	if ((err = ymf_state_alloc(unit, nvirt)) != 0) {
+		up(&unit->open_sem);
 		return err;
 	}
 	state = unit->states[nvirt];
@@ -1940,6 +1931,7 @@
 		unit->states[state->virt] = NULL;
 		kfree(state);
 
+		up(&unit->open_sem);
 		return err;
 	}
 
@@ -1948,6 +1940,8 @@
 	ymfpci_writeb(codec, YDSXGR_TIMERCTRL,
 	    (YDSXGR_TIMERCTRL_TEN|YDSXGR_TIMERCTRL_TIEN));
 #endif
+	up(&unit->open_sem);
+	/* XXX Is it correct to have MOD_INC_USE_COUNT outside of sem.? */
 
 	MOD_INC_USE_COUNT;
 	return 0;
@@ -1962,14 +1956,14 @@
 	ymfpci_writeb(codec, YDSXGR_TIMERCTRL, 0);
 #endif
 
-	/* XXX Use the semaphore to unrace us with opens */
-
 	if (state != codec->states[state->virt]) {
 		printk(KERN_ERR "ymfpci%d.%d: state mismatch\n",
-		    state->unit->inst, state->virt);
+		    state->unit->dev_audio, state->virt);
 		return -EIO;
 	}
 
+	down(&codec->open_sem);
+
 	/*
 	 * XXX Solve the case of O_NONBLOCK close - don't deallocate here.
 	 * Deallocate when unloading the driver and we can wait.
@@ -1981,6 +1975,8 @@
 	codec->states[state->virt] = NULL;
 	kfree(state);
 
+	up(&codec->open_sem);
+
 	MOD_DEC_USE_COUNT;
 	return 0;
 }
@@ -2235,7 +2231,6 @@
 	codec->codec_write = ymfpci_codec_write;
 
 	if (ac97_probe_codec(codec) == 0) {
-		/* Alan does not have this printout. P3 */
 		printk("ymfpci: ac97_probe_codec failed\n");
 		goto out_kfree;
 	}
@@ -2264,7 +2259,6 @@
 static int __devinit ymf_probe_one(struct pci_dev *pcidev, const struct pci_device_id *ent)
 {
 	u16 ctrl;
-	static int ymf_instance; /* = 0 */
 	ymfpci_t *codec;
 
 	int err;
@@ -2282,13 +2276,13 @@
 
 	spin_lock_init(&codec->reg_lock);
 	spin_lock_init(&codec->voice_lock);
+	init_MUTEX(&codec->open_sem);
 	codec->pci = pcidev;
-	codec->inst = ymf_instance;
 
-	pci_read_config_byte(pcidev, PCI_REVISION_ID, (u8 *)&codec->rev);
+	pci_read_config_byte(pcidev, PCI_REVISION_ID, &codec->rev);
 	codec->reg_area_virt = ioremap(pci_resource_start(pcidev, 0), 0x8000);
 
-	printk(KERN_INFO "ymfpci%d: %s at 0x%lx IRQ %d\n", ymf_instance,
+	printk(KERN_INFO "ymfpci: %s at 0x%lx IRQ %d\n",
 	    (char *)ent->driver_data, pci_resource_start(pcidev, 0), pcidev->irq);
 
 	ymfpci_aclink_reset(pcidev);
@@ -2306,13 +2300,14 @@
 
 	if (request_irq(pcidev->irq, ymf_interrupt, SA_SHIRQ, "ymfpci", codec) != 0) {
 		printk(KERN_ERR "ymfpci%d: unable to request IRQ %d\n",
-		       codec->inst, pcidev->irq);
+		       codec->dev_audio, pcidev->irq);
 		goto out_memfree;
 	}
 
 	/* register /dev/dsp */
 	if ((codec->dev_audio = register_sound_dsp(&ymf_fops, -1)) < 0) {
-		printk(KERN_ERR "ymfpci%d: unable to register dsp\n", codec->inst);
+		printk(KERN_ERR "ymfpci%d: unable to register dsp\n",
+		    codec->dev_audio);
 		goto out_free_irq;
 	}
 
@@ -2325,7 +2320,6 @@
 	/* put it into driver list */
 	list_add_tail(&codec->ymf_devs, &ymf_devs);
 	pci_set_drvdata(pcidev, codec);
-	ymf_instance++;
 
 	return 0;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
