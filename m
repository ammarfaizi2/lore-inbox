Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263523AbREYEaG>; Fri, 25 May 2001 00:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263524AbREYE3r>; Fri, 25 May 2001 00:29:47 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:19719 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263523AbREYE3g>; Fri, 25 May 2001 00:29:36 -0400
Date: Fri, 25 May 2001 00:29:36 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Patch for PM in ymfpci (against 2.4.5-pre3)
Message-ID: <20010525002936.A27051@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry to be a poor maintainer, people were sending me patches
to enable PM support for a long time. I took most of this from
Paul Stewart, fixed a buglet, and factored common parts into
a function.

-- Pete

* PM support for suspend/resume (without pm_register, proper PCI API);
* Killed some P3's;
* Removed unused unit.error;
* Removed access_ok (we do copy_[to|from]_user);

diff -ur -X dontdiff linux-2.4.5-pre3/drivers/sound/ymfpci.c linux-2.4.5-pre3-p3/drivers/sound/ymfpci.c
--- linux-2.4.5-pre3/drivers/sound/ymfpci.c	Fri May 18 14:09:46 2001
+++ linux-2.4.5-pre3-p3/drivers/sound/ymfpci.c	Thu May 24 20:58:27 2001
@@ -23,10 +23,8 @@
  *   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  *
  * TODO:
- *  - Use P44Slot for 44.1 playback.
+ *  - Use P44Slot for 44.1 playback (beware of idle buzzing in P44Slot).
  *  - 96KHz playback for DVD - use pitch of 2.0.
- *  - uLaw for Sun apps.
- *     : Alan says firmly "no software format conversion in kernel".
  *  - Retain DMA buffer on close, do not wait the end of frame.
  *  - Cleanup
  *      ? underused structure members
@@ -55,6 +53,7 @@
 #include <linux/soundcard.h>
 #include <linux/ac97_codec.h>
 #include <linux/sound.h>
+#include <linux/pm.h>
 
 #include <asm/io.h>
 #include <asm/dma.h>
@@ -66,14 +65,19 @@
 #endif
 #include "ymfpci.h"
 
-static int ymf_playback_trigger(ymfpci_t *codec, struct ymf_pcm *ypcm, int cmd);
+static int ymf_playback_trigger(ymfpci_t *unit, struct ymf_pcm *ypcm, int cmd);
 static void ymf_capture_trigger(ymfpci_t *unit, struct ymf_pcm *ypcm, int cmd);
-static void ymfpci_voice_free(ymfpci_t *codec, ymfpci_voice_t *pvoice);
+static void ymfpci_voice_free(ymfpci_t *unit, ymfpci_voice_t *pvoice);
 static int ymf_capture_alloc(struct ymf_unit *unit, int *pbank);
 static int ymf_playback_prepare(struct ymf_state *state);
 static int ymf_capture_prepare(struct ymf_state *state);
 static struct ymf_state *ymf_state_alloc(ymfpci_t *unit);
 
+static void ymfpci_aclink_reset(struct pci_dev * pci);
+static void ymfpci_disable_dsp(ymfpci_t *unit);
+static void ymfpci_download_image(ymfpci_t *codec);
+static void ymf_memload(ymfpci_t *unit);
+
 static LIST_HEAD(ymf_devs);
 
 /*
@@ -330,7 +334,7 @@
 	spin_lock_irqsave(&state->unit->reg_lock, flags);
 	dmabuf->hwptr = dmabuf->swptr = 0;
 	dmabuf->total_bytes = 0;
-	dmabuf->count = dmabuf->error = 0;
+	dmabuf->count = 0;
 	spin_unlock_irqrestore(&state->unit->reg_lock, flags);
 
 	/* allocate DMA buffer if not allocated yet */
@@ -810,8 +814,6 @@
 		end >>= 1;
 	if (w_16)
 		end >>= 1;
-/* P3 */ // printk("ymf_pcm_init_voice: %d: Rate %d Format 0x%08x Delta 0x%x End 0x%x\n",
-//  voice->number, rate, format, delta, end);
 	for (nbank = 0; nbank < 2; nbank++) {
 		bank = &voice->bank[nbank];
 		bank->format = format;
@@ -907,7 +909,7 @@
 
 	if ((err = ymfpci_pcm_voice_alloc(ypcm, state->format.voices)) < 0) {
 		/* Somebody started 32 mpg123's in parallel? */
-		/* P3 */ printk("ymfpci%d: cannot allocate voice\n",
+		printk(KERN_INFO "ymfpci%d: cannot allocate voice\n",
 		    state->unit->dev_audio);
 		return err;
 	}
@@ -1178,6 +1180,7 @@
 {
 	struct ymf_state *state = (struct ymf_state *)file->private_data;
 	struct ymf_dmabuf *dmabuf = &state->rpcm.dmabuf;
+	struct ymf_unit *unit = state->unit;
 	DECLARE_WAITQUEUE(waita, current);
 	ssize_t ret;
 	unsigned long flags;
@@ -1190,18 +1193,26 @@
 		return -ENXIO;
 	if (!dmabuf->ready && (ret = prog_dmabuf(state, 1)))
 		return ret;
-	if (!access_ok(VERIFY_WRITE, buffer, count))
-		return -EFAULT;
 	ret = 0;
 
 	add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
-		spin_lock_irqsave(&state->unit->reg_lock, flags);
+		spin_lock_irqsave(&unit->reg_lock, flags);
+		if (unit->suspended) {
+			spin_unlock_irqrestore(&unit->reg_lock, flags);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+			if (signal_pending(current)) {
+				if (!ret) ret = -EAGAIN;
+				break;
+			}
+			continue;
+		}
 		swptr = dmabuf->swptr;
 		cnt = dmabuf->dmasize - swptr;
 		if (dmabuf->count < cnt)
 			cnt = dmabuf->count;
-		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		spin_unlock_irqrestore(&unit->reg_lock, flags);
 
 		if (cnt > count)
 			cnt = count;
@@ -1240,7 +1254,7 @@
 			}
 			spin_unlock_irqrestore(&state->unit->reg_lock, flags);
 			if (signal_pending(current)) {
-				ret = ret ? ret : -ERESTARTSYS;
+				if (!ret) ret = -ERESTARTSYS;
 				break;
 			}
 			continue;
@@ -1253,19 +1267,24 @@
 
 		swptr = (swptr + cnt) % dmabuf->dmasize;
 
-		spin_lock_irqsave(&state->unit->reg_lock, flags);
+		spin_lock_irqsave(&unit->reg_lock, flags);
+		if (unit->suspended) {
+			spin_unlock_irqrestore(&unit->reg_lock, flags);
+			continue;
+		}
+
 		dmabuf->swptr = swptr;
 		dmabuf->count -= cnt;
-		// spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		// spin_unlock_irqrestore(&unit->reg_lock, flags);
 
 		count -= cnt;
 		buffer += cnt;
 		ret += cnt;
-		// spin_lock_irqsave(&state->unit->reg_lock, flags);
+		// spin_lock_irqsave(&unit->reg_lock, flags);
 		if (!state->rpcm.running) {
-			ymf_capture_trigger(state->unit, &state->rpcm, 1);
+			ymf_capture_trigger(unit, &state->rpcm, 1);
 		}
-		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		spin_unlock_irqrestore(&unit->reg_lock, flags);
 	}
 	set_current_state(TASK_RUNNING);
 	remove_wait_queue(&dmabuf->wait, &waita);
@@ -1278,6 +1297,7 @@
 {
 	struct ymf_state *state = (struct ymf_state *)file->private_data;
 	struct ymf_dmabuf *dmabuf = &state->wpcm.dmabuf;
+	struct ymf_unit *unit = state->unit;
 	DECLARE_WAITQUEUE(waita, current);
 	ssize_t ret;
 	unsigned long flags;
@@ -1294,8 +1314,6 @@
 		return -ENXIO;
 	if (!dmabuf->ready && (ret = prog_dmabuf(state, 0)))
 		return ret;
-	if (!access_ok(VERIFY_READ, buffer, count))
-		return -EFAULT;
 	ret = 0;
 
 	/*
@@ -1310,7 +1328,17 @@
 
 	add_wait_queue(&dmabuf->wait, &waita);
 	while (count > 0) {
-		spin_lock_irqsave(&state->unit->reg_lock, flags);
+		spin_lock_irqsave(&unit->reg_lock, flags);
+		if (unit->suspended) {
+			spin_unlock_irqrestore(&unit->reg_lock, flags);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule();
+			if (signal_pending(current)) {
+				if (!ret) ret = -EAGAIN;
+				break;
+			}
+			continue;
+		}
 		if (dmabuf->count < 0) {
 			printk(KERN_ERR
 			   "ymf_write: count %d, was legal in cs46xx\n",
@@ -1342,7 +1370,7 @@
 		cnt = dmabuf->dmasize - swptr;
 		if (dmabuf->count + cnt > dmabuf->dmasize - redzone)
 			cnt = (dmabuf->dmasize - redzone) - dmabuf->count;
-		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		spin_unlock_irqrestore(&unit->reg_lock, flags);
 
 		if (cnt > count)
 			cnt = count;
@@ -1353,11 +1381,11 @@
 			 * buffer is full, start the dma machine and
 			 * wait for data to be played
 			 */
-			spin_lock_irqsave(&state->unit->reg_lock, flags);
+			spin_lock_irqsave(&unit->reg_lock, flags);
 			if (!state->wpcm.running) {
-				ymf_playback_trigger(state->unit, &state->wpcm, 1);
+				ymf_playback_trigger(unit, &state->wpcm, 1);
 			}
-			spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+			spin_unlock_irqrestore(&unit->reg_lock, flags);
 			if (file->f_flags & O_NONBLOCK) {
 				if (!ret) ret = -EAGAIN;
 				break;
@@ -1379,7 +1407,11 @@
 			swptr -= dmabuf->dmasize;
 		}
 
-		spin_lock_irqsave(&state->unit->reg_lock, flags);
+		spin_lock_irqsave(&unit->reg_lock, flags);
+		if (unit->suspended) {
+			spin_unlock_irqrestore(&unit->reg_lock, flags);
+			continue;
+		}
 		dmabuf->swptr = swptr;
 		dmabuf->count += cnt;
 
@@ -1393,10 +1425,10 @@
 		delay = state->format.rate / 20;	/* 50ms */
 		delay <<= state->format.shift;
 		if (dmabuf->count >= delay && !state->wpcm.running) {
-			ymf_playback_trigger(state->unit, &state->wpcm, 1);
+			ymf_playback_trigger(unit, &state->wpcm, 1);
 		}
 
-		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		spin_unlock_irqrestore(&unit->reg_lock, flags);
 
 		count -= cnt;
 		buffer += cnt;
@@ -1621,7 +1653,6 @@
 	case SNDCTL_DSP_CHANNELS:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
-	/* P3 */ /* printk("ymfpci: ioctl SNDCTL_DSP_CHANNELS 0x%x\n", val); */
 		if (val != 0) {
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
@@ -2016,6 +2047,77 @@
 };
 
 /*
+ */
+
+static void ymf_suspend(struct pci_dev *pcidev)
+{
+	struct ymf_unit *unit = pci_get_drvdata(pcidev);
+	unsigned long flags;
+	struct ymf_dmabuf *dmabuf;
+	struct list_head *p;
+	struct ymf_state *state;
+
+	spin_lock_irqsave(&unit->reg_lock, flags);
+
+	unit->suspended = 1;
+
+	list_for_each(p, &unit->states) {
+		state = list_entry(p, struct ymf_state, chain);
+
+		dmabuf = &state->wpcm.dmabuf;
+		dmabuf->hwptr = dmabuf->swptr = 0;
+		dmabuf->total_bytes = 0;
+		dmabuf->count = 0;
+
+		dmabuf = &state->rpcm.dmabuf;
+		dmabuf->hwptr = dmabuf->swptr = 0;
+		dmabuf->total_bytes = 0;
+		dmabuf->count = 0;
+	}
+
+	ymfpci_writel(unit, YDSXGR_NATIVEDACOUTVOL, 0);
+	ymfpci_disable_dsp(unit);
+
+	spin_unlock_irqrestore(&unit->reg_lock, flags);
+}
+
+static void ymf_resume(struct pci_dev *pcidev)
+{
+	struct ymf_unit *unit = pci_get_drvdata(pcidev);
+	unsigned long flags;
+	struct list_head *p;
+	struct ymf_state *state;
+
+	ymfpci_aclink_reset(unit->pci);
+	ymfpci_codec_ready(unit, 0, 1);		/* prints diag if not ready. */
+
+#ifdef CONFIG_SOUND_YMFPCI_LEGACY
+	/* XXX At this time the legacy registers are probably deprogrammed. */
+#endif
+
+	ymfpci_download_image(unit);
+	udelay(100);
+
+	ymf_memload(unit);
+
+	spin_lock_irqsave(&unit->reg_lock, flags);
+
+	if (unit->start_count) {
+		ymfpci_writel(unit, YDSXGR_MODE, 3);
+		unit->active_bank = ymfpci_readl(unit, YDSXGR_CTRLSELECT) & 1;
+	}
+
+	unit->suspended = 0;
+	list_for_each(p, &unit->states) {
+		state = list_entry(p, struct ymf_state, chain);
+		wake_up(&state->wpcm.dmabuf.wait);
+		wake_up(&state->rpcm.dmabuf.wait);
+	}
+
+	spin_unlock_irqrestore(&unit->reg_lock, flags);
+}
+
+/*
  *  initialization routines
  */
 
@@ -2237,28 +2340,6 @@
 	ptr += (codec->bank_size_effect + 0x00ff) & ~0x00ff;
 	codec->work_base = ptr;
 
-	ymfpci_writel(codec, YDSXGR_PLAYCTRLBASE, virt_to_bus(codec->bank_base_playback));
-	ymfpci_writel(codec, YDSXGR_RECCTRLBASE, virt_to_bus(codec->bank_base_capture));
-	ymfpci_writel(codec, YDSXGR_EFFCTRLBASE, virt_to_bus(codec->bank_base_effect));
-	ymfpci_writel(codec, YDSXGR_WORKBASE, virt_to_bus(codec->work_base));
-	ymfpci_writel(codec, YDSXGR_WORKSIZE, codec->work_size >> 2);
-
-	/* S/PDIF output initialization */
-	ymfpci_writew(codec, YDSXGR_SPDIFOUTCTRL, 0);
-	ymfpci_writew(codec, YDSXGR_SPDIFOUTSTATUS,
-		SND_PCM_AES0_CON_EMPHASIS_NONE |
-		(SND_PCM_AES1_CON_ORIGINAL << 8) |
-		(SND_PCM_AES1_CON_PCM_CODER << 8));
-
-	/* S/PDIF input initialization */
-	ymfpci_writew(codec, YDSXGR_SPDIFINCTRL, 0);
-
-	/* move this volume setup to mixer */
-	ymfpci_writel(codec, YDSXGR_NATIVEDACOUTVOL, 0x3fff3fff);
-	ymfpci_writel(codec, YDSXGR_BUF441OUTVOL, 0);
-	ymfpci_writel(codec, YDSXGR_NATIVEADCINVOL, 0x3fff3fff);
-	ymfpci_writel(codec, YDSXGR_NATIVEDACINVOL, 0x3fff3fff);
-
 	return 0;
 }
 
@@ -2272,6 +2353,32 @@
 	kfree(codec->work_ptr);
 }
 
+static void ymf_memload(ymfpci_t *unit)
+{
+
+	ymfpci_writel(unit, YDSXGR_PLAYCTRLBASE, virt_to_bus(unit->bank_base_playback));
+	ymfpci_writel(unit, YDSXGR_RECCTRLBASE, virt_to_bus(unit->bank_base_capture));
+	ymfpci_writel(unit, YDSXGR_EFFCTRLBASE, virt_to_bus(unit->bank_base_effect));
+	ymfpci_writel(unit, YDSXGR_WORKBASE, virt_to_bus(unit->work_base));
+	ymfpci_writel(unit, YDSXGR_WORKSIZE, unit->work_size >> 2);
+
+	/* S/PDIF output initialization */
+	ymfpci_writew(unit, YDSXGR_SPDIFOUTCTRL, 0);
+	ymfpci_writew(unit, YDSXGR_SPDIFOUTSTATUS,
+		SND_PCM_AES0_CON_EMPHASIS_NONE |
+		(SND_PCM_AES1_CON_ORIGINAL << 8) |
+		(SND_PCM_AES1_CON_PCM_CODER << 8));
+
+	/* S/PDIF input initialization */
+	ymfpci_writew(unit, YDSXGR_SPDIFINCTRL, 0);
+
+	/* move this volume setup to mixer */
+	ymfpci_writel(unit, YDSXGR_NATIVEDACOUTVOL, 0x3fff3fff);
+	ymfpci_writel(unit, YDSXGR_BUF441OUTVOL, 0);
+	ymfpci_writel(unit, YDSXGR_NATIVEADCINVOL, 0x3fff3fff);
+	ymfpci_writel(unit, YDSXGR_NATIVEDACINVOL, 0x3fff3fff);
+}
+
 static int ymf_ac97_init(ymfpci_t *unit, int num_ac97)
 {
 	struct ac97_codec *codec;
@@ -2382,8 +2489,7 @@
 
 	if (ymfpci_memalloc(codec) < 0)
 		goto out_disable_dsp;
-
-	/* ymfpci_proc_init(unit, codec); */
+	ymf_memload(codec);
 
 	if (request_irq(pcidev->irq, ymf_interrupt, SA_SHIRQ, "ymfpci", codec) != 0) {
 		printk(KERN_ERR "ymfpci: unable to request IRQ %d\n",
@@ -2479,6 +2585,8 @@
 	id_table:	ymf_id_tbl,
 	probe:		ymf_probe_one,
 	remove:         ymf_remove_one,
+	suspend:	ymf_suspend,
+	resume:		ymf_resume
 };
 
 static int __init ymf_init_module(void)
diff -ur -X dontdiff linux-2.4.5-pre3/drivers/sound/ymfpci.h linux-2.4.5-pre3-p3/drivers/sound/ymfpci.h
--- linux-2.4.5-pre3/drivers/sound/ymfpci.h	Fri May 18 14:09:46 2001
+++ linux-2.4.5-pre3-p3/drivers/sound/ymfpci.h	Thu May 24 14:54:02 2001
@@ -257,6 +257,7 @@
 	ymfpci_effect_bank_t *bank_effect[YDSXG_EFFECT_VOICES][2];
 
 	int start_count;
+	int suspended;
 
 	u32 active_bank;
 	struct ymf_voice voices[64];
@@ -266,6 +267,7 @@
 	u16 ac97_features;
 
 	struct pci_dev *pci;
+	struct pm_dev *pmdev;
 
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	/* legacy hardware resources */
@@ -282,8 +284,6 @@
 
 	struct list_head ymf_devs;
 	struct list_head states;	/* List of states for this unit */
-	/* For the moment we do not traverse list of states so it is
-	 * entirely useless. Will be used (PM) or killed. XXX */
 };
 
 struct ymf_dmabuf {
@@ -300,7 +300,6 @@
 	int count;		/* fill count */
 	unsigned total_bytes;	/* total bytes dmaed by hardware */
 
-	unsigned error;		/* number of over/underruns */
 	wait_queue_head_t wait;	/* put process on wait queue when no more space in buffer */
 
 	/* redundant, but makes calculations easier */
