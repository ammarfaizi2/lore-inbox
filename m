Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283459AbRK3A7b>; Thu, 29 Nov 2001 19:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283458AbRK3A7X>; Thu, 29 Nov 2001 19:59:23 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:26856 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S283457AbRK3A7P>; Thu, 29 Nov 2001 19:59:15 -0500
Date: Thu, 29 Nov 2001 19:59:12 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, kai@tp1.ruhr-uni-bochum.de,
        zaitcev@redhat.com
Subject: Cleanup for ymfpci
Message-ID: <20011129195912.A19697@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Marcelo,

I held off some of this stuff for the transition, so here it is now.

* Bitrot fix for test interrupts.
* Replace Kai's ideas about proper C style. I'm not one to moan about
  it on IRC. Instead, I abuse my maintainer powers to override it  :)
* Printouts for ioctls.
* Comments (mostly about ac97_save_state).
* Kill MOD_DEC_USE_COUNT, MOD_INC_USE_COUNT. Stolen from cs46xx.
* Move ac97_restore_state after reset. I am not 100% comfortable
  about it being click-free, but Kai's and my hardware do not care,
  users asked to move it.

Greetings,
-- Pete

--- linux-2.4.16/drivers/sound/ymfpci.c	Mon Nov 19 14:53:19 2001
+++ linux-2.4.16-niph/drivers/sound/ymfpci.c	Thu Nov 29 16:02:37 2001
@@ -39,6 +39,9 @@
  *    native synthesizer through a playback slot.
  *  - Use new 2.3.x cache coherent PCI DMA routines instead of virt_to_bus.
  *  - Make the thing big endian compatible. ALSA has it done.
+ *  - 2001/10/25 Since Civ:CTP forced redzone outside of pre-set fragments,
+ *    all ioctls that report free space lie a little. Adjust their returns.
+ *  - 2001/11/29 ac97_save_state
  */
 
 #include <linux/config.h>
@@ -173,19 +176,19 @@
 
 static u16 ymfpci_codec_read(struct ac97_codec *dev, u8 reg)
 {
-	ymfpci_t *codec = dev->private_data;
+	ymfpci_t *unit = dev->private_data;
+	int i;
 
-	if (ymfpci_codec_ready(codec, 0, 0))
+	if (ymfpci_codec_ready(unit, 0, 0))
 		return ~0;
-	ymfpci_writew(codec, YDSXGR_AC97CMDADR, YDSXG_AC97READCMD | reg);
-	if (ymfpci_codec_ready(codec, 0, 0))
+	ymfpci_writew(unit, YDSXGR_AC97CMDADR, YDSXG_AC97READCMD | reg);
+	if (ymfpci_codec_ready(unit, 0, 0))
 		return ~0;
-	if (codec->pci->device == PCI_DEVICE_ID_YAMAHA_744 && codec->rev < 2) {
-		int i;
+	if (unit->pci->device == PCI_DEVICE_ID_YAMAHA_744 && unit->rev < 2) {
 		for (i = 0; i < 600; i++)
-			ymfpci_readw(codec, YDSXGR_PRISTATUSDATA);
+			ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 	}
-	return ymfpci_readw(codec, YDSXGR_PRISTATUSDATA);
+	return ymfpci_readw(unit, YDSXGR_PRISTATUSDATA);
 }
 
 /*
@@ -1512,9 +1515,11 @@
 
 	switch (cmd) {
 	case OSS_GETVERSION:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETVER) arg 0x%lx\n", cmd, arg);
 		return put_user(SOUND_VERSION, (int *)arg);
 
 	case SNDCTL_DSP_RESET:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(RESET)\n", cmd);
 		if (file->f_mode & FMODE_WRITE) {
 			ymf_wait_dac(state);
 			dmabuf = &state->wpcm.dmabuf;
@@ -1536,6 +1541,7 @@
 		return 0;
 
 	case SNDCTL_DSP_SYNC:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SYNC)\n", cmd);
 		if (file->f_mode & FMODE_WRITE) {
 			dmabuf = &state->wpcm.dmabuf;
 			if (file->f_flags & O_NONBLOCK) {
@@ -1554,6 +1560,7 @@
 	case SNDCTL_DSP_SPEED: /* set smaple rate */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SPEED) sp %d\n", cmd, val);
 		if (val >= 8000 && val <= 48000) {
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
@@ -1585,6 +1592,7 @@
 	case SNDCTL_DSP_STEREO: /* set stereo or mono channel */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(STEREO) st %d\n", cmd, val);
 		if (file->f_mode & FMODE_WRITE) {
 			ymf_wait_dac(state); 
 			dmabuf = &state->wpcm.dmabuf;
@@ -1606,24 +1614,31 @@
 		return 0;
 
 	case SNDCTL_DSP_GETBLKSIZE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETBLK)\n", cmd);
 		if (file->f_mode & FMODE_WRITE) {
 			if ((val = prog_dmabuf(state, 0)))
 				return val;
-			return put_user(state->wpcm.dmabuf.fragsize, (int *)arg);
+			val = state->wpcm.dmabuf.fragsize;
+			YMFDBGX("ymf_ioctl: GETBLK w %d\n", val);
+			return put_user(val, (int *)arg);
 		}
 		if (file->f_mode & FMODE_READ) {
 			if ((val = prog_dmabuf(state, 1)))
 				return val;
-			return put_user(state->rpcm.dmabuf.fragsize, (int *)arg);
+			val = state->rpcm.dmabuf.fragsize;
+			YMFDBGX("ymf_ioctl: GETBLK r %d\n", val);
+			return put_user(val, (int *)arg);
 		}
 		return -EINVAL;
 
 	case SNDCTL_DSP_GETFMTS: /* Returns a mask of supported sample format*/
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETFMTS)\n", cmd);
 		return put_user(AFMT_S16_LE|AFMT_U8, (int *)arg);
 
 	case SNDCTL_DSP_SETFMT: /* Select sample format */
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SETFMT) fmt %d\n", cmd, val);
 		if (val == AFMT_S16_LE || val == AFMT_U8) {
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
@@ -1649,6 +1664,7 @@
 	case SNDCTL_DSP_CHANNELS:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(CHAN) ch %d\n", cmd, val);
 		if (val != 0) {
 			if (file->f_mode & FMODE_WRITE) {
 				ymf_wait_dac(state);
@@ -1676,6 +1692,7 @@
 		return put_user(state->format.voices, (int *)arg);
 
 	case SNDCTL_DSP_POST:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(POST)\n", cmd);
 		/*
 		 * Quoting OSS PG:
 		 *    The ioctl SNDCTL_DSP_POST is a lightweight version of
@@ -1697,6 +1714,10 @@
 	case SNDCTL_DSP_SETFRAGMENT:
 		if (get_user(val, (int *)arg))
 			return -EFAULT;
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SETFRAG) fr 0x%04x:%04x(%d:%d)\n",
+		    cmd,
+		    (val >> 16) & 0xFFFF, val & 0xFFFF,
+		    (val >> 16) & 0xFFFF, val & 0xFFFF);
 		dmabuf = &state->wpcm.dmabuf;
 		dmabuf->ossfragshift = val & 0xffff;
 		dmabuf->ossmaxfrags = (val >> 16) & 0xffff;
@@ -1707,6 +1728,7 @@
 		return 0;
 
 	case SNDCTL_DSP_GETOSPACE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETOSPACE)\n", cmd);
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
 		dmabuf = &state->wpcm.dmabuf;
@@ -1721,6 +1743,7 @@
 		return copy_to_user((void *)arg, &abinfo, sizeof(abinfo)) ? -EFAULT : 0;
 
 	case SNDCTL_DSP_GETISPACE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETISPACE)\n", cmd);
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
 		dmabuf = &state->rpcm.dmabuf;
@@ -1735,15 +1758,18 @@
 		return copy_to_user((void *)arg, &abinfo, sizeof(abinfo)) ? -EFAULT : 0;
 
 	case SNDCTL_DSP_NONBLOCK:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(NONBLOCK)\n", cmd);
 		file->f_flags |= O_NONBLOCK;
 		return 0;
 
 	case SNDCTL_DSP_GETCAPS:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETCAPS)\n", cmd);
 		/* return put_user(DSP_CAP_REALTIME|DSP_CAP_TRIGGER|DSP_CAP_MMAP,
 			    (int *)arg); */
 		return put_user(0, (int *)arg);
 
 	case SNDCTL_DSP_GETIPTR:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETIPTR)\n", cmd);
 		if (!(file->f_mode & FMODE_READ))
 			return -EINVAL;
 		dmabuf = &state->rpcm.dmabuf;
@@ -1755,9 +1781,12 @@
 		if (dmabuf->mapped)
 			dmabuf->count &= dmabuf->fragsize-1;
 		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		YMFDBGX("ymf_ioctl: GETIPTR ptr %d bytes %d\n",
+		    cinfo.ptr, cinfo.bytes);
 		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ? -EFAULT : 0;
 
 	case SNDCTL_DSP_GETOPTR:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(GETOPTR)\n", cmd);
 		if (!(file->f_mode & FMODE_WRITE))
 			return -EINVAL;
 		dmabuf = &state->wpcm.dmabuf;
@@ -1769,18 +1798,24 @@
 		if (dmabuf->mapped)
 			dmabuf->count &= dmabuf->fragsize-1;
 		spin_unlock_irqrestore(&state->unit->reg_lock, flags);
+		YMFDBGX("ymf_ioctl: GETOPTR ptr %d bytes %d\n",
+		    cinfo.ptr, cinfo.bytes);
 		return copy_to_user((void *)arg, &cinfo, sizeof(cinfo)) ? -EFAULT : 0;
 
 	case SNDCTL_DSP_SETDUPLEX:	/* XXX TODO */
+		YMFDBGX("ymf_ioctl: cmd 0x%x(SETDUPLEX)\n", cmd);
 		return -EINVAL;
 
 	case SOUND_PCM_READ_RATE:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(READ_RATE)\n", cmd);
 		return put_user(state->format.rate, (int *)arg);
 
 	case SOUND_PCM_READ_CHANNELS:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(READ_CH)\n", cmd);
 		return put_user(state->format.voices, (int *)arg);
 
 	case SOUND_PCM_READ_BITS:
+		YMFDBGX("ymf_ioctl: cmd 0x%x(READ_BITS)\n", cmd);
 		return put_user(AFMT_S16_LE, (int *)arg);
 
 	case SNDCTL_DSP_MAPINBUF:
@@ -1866,13 +1901,12 @@
 	}
 
 #if 0 /* test if interrupts work */
-	ymfpci_writew(codec, YDSXGR_TIMERCOUNT, 0xfffe);	/* ~ 680ms */
-	ymfpci_writeb(codec, YDSXGR_TIMERCTRL,
+	ymfpci_writew(unit, YDSXGR_TIMERCOUNT, 0xfffe);	/* ~ 680ms */
+	ymfpci_writeb(unit, YDSXGR_TIMERCTRL,
 	    (YDSXGR_TIMERCTRL_TEN|YDSXGR_TIMERCTRL_TIEN));
 #endif
 	up(&unit->open_sem);
 
-	MOD_INC_USE_COUNT;
 	return 0;
 
 out_nodma:
@@ -1896,13 +1930,13 @@
 static int ymf_release(struct inode *inode, struct file *file)
 {
 	struct ymf_state *state = (struct ymf_state *)file->private_data;
-	ymfpci_t *codec = state->unit;
+	ymfpci_t *unit = state->unit;
 
 #if 0 /* test if interrupts work */
-	ymfpci_writeb(codec, YDSXGR_TIMERCTRL, 0);
+	ymfpci_writeb(unit, YDSXGR_TIMERCTRL, 0);
 #endif
 
-	down(&codec->open_sem);
+	down(&unit->open_sem);
 
 	/*
 	 * XXX Solve the case of O_NONBLOCK close - don't deallocate here.
@@ -1919,9 +1953,8 @@
 	file->private_data = NULL;	/* Can you tell I programmed Solaris */
 	kfree(state);
 
-	up(&codec->open_sem);
+	up(&unit->open_sem);
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1930,10 +1963,10 @@
  */
 static int ymf_open_mixdev(struct inode *inode, struct file *file)
 {
-	int i;
 	int minor = MINOR(inode->i_rdev);
 	struct list_head *list;
 	ymfpci_t *unit;
+	int i;
 
 	list_for_each(list, &ymf_devs) {
 		unit = list_entry(list, ymfpci_t, ymf_devs);
@@ -1949,7 +1982,6 @@
  match:
 	file->private_data = unit->ac97_codec[i];
 
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -1963,11 +1995,11 @@
 
 static int ymf_release_mixdev(struct inode *inode, struct file *file)
 {
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
 static /*const*/ struct file_operations ymf_fops = {
+	owner:		THIS_MODULE,
 	llseek:		no_llseek,
 	read:		ymf_read,
 	write:		ymf_write,
@@ -1979,6 +2011,7 @@
 };
 
 static /*const*/ struct file_operations ymf_mixer_fops = {
+	owner:		THIS_MODULE,
 	llseek:		no_llseek,
 	ioctl:		ymf_ioctl_mixdev,
 	open:		ymf_open_mixdev,
@@ -1990,23 +2023,26 @@
 
 static int ymf_suspend(struct pci_dev *pcidev, u32 unused)
 {
-	int i;
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
 	struct ymf_dmabuf *dmabuf;
 	struct list_head *p;
 	struct ymf_state *state;
 	struct ac97_codec *codec;
+	int i;
 
 	spin_lock_irqsave(&unit->reg_lock, flags);
 
 	unit->suspended = 1;
 
+	/*
+	 * XXX Talk to Kai to remove ac97_save_state before it's too late!
+	 * Other drivers call ac97_reset, which does not have
+	 * a save counterpart. Current ac97_save_state is empty.
+	 */
 	for (i = 0; i < NR_AC97; i++) {
-		codec = unit->ac97_codec[i];
-		if (!codec)
-			continue;
-		ac97_save_state(codec);
+		if ((codec = unit->ac97_codec[i]) != NULL)
+			ac97_save_state(codec);
 	}
 
 	list_for_each(p, &unit->states) {
@@ -2033,23 +2069,16 @@
 
 static int ymf_resume(struct pci_dev *pcidev)
 {
-	int i;
 	struct ymf_unit *unit = pci_get_drvdata(pcidev);
 	unsigned long flags;
 	struct list_head *p;
 	struct ymf_state *state;
 	struct ac97_codec *codec;
+	int i;
 
 	ymfpci_aclink_reset(unit->pci);
 	ymfpci_codec_ready(unit, 0, 1);		/* prints diag if not ready. */
 
-	for (i = 0; i < NR_AC97; i++) {
-		codec = unit->ac97_codec[i];
-		if (!codec)
-			continue;
-		ac97_restore_state(codec);
-	}
-
 #ifdef CONFIG_SOUND_YMFPCI_LEGACY
 	/* XXX At this time the legacy registers are probably deprogrammed. */
 #endif
@@ -2063,6 +2092,11 @@
 	if (unit->start_count) {
 		ymfpci_writel(unit, YDSXGR_MODE, 3);
 		unit->active_bank = ymfpci_readl(unit, YDSXGR_CTRLSELECT) & 1;
+	}
+
+	for (i = 0; i < NR_AC97; i++) {
+		if ((codec = unit->ac97_codec[i]) != NULL)
+			ac97_restore_state(codec);
 	}
 
 	unit->suspended = 0;
