Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbTJOS1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263942AbTJOS1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:27:19 -0400
Received: from mail.kroah.org ([65.200.24.183]:53425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263929AbTJOS0L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:11 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1066242290976@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test7
In-Reply-To: <1066242290297@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 15 Oct 2003 11:24:51 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347.1.5, 2003/10/13 11:42:19-07:00, greg@kroah.com

OSS: fix up MOD_INC and MOD_DEC usages to remove compiler warnings.


 sound/oss/ad1889.c         |    6 ++----
 sound/oss/cs4281/cs4281m.c |   11 +++--------
 sound/oss/cs46xx.c         |    6 ------
 sound/oss/swarm_cs4297a.c  |    8 ++------
 4 files changed, 7 insertions(+), 24 deletions(-)


diff -Nru a/sound/oss/ad1889.c b/sound/oss/ad1889.c
--- a/sound/oss/ad1889.c	Wed Oct 15 11:18:31 2003
+++ b/sound/oss/ad1889.c	Wed Oct 15 11:18:31 2003
@@ -763,18 +763,17 @@
 	ad1889_set_wav_rate(ad1889_dev, 44100);
 	ad1889_set_wav_fmt(ad1889_dev, AFMT_S16_LE);
 	AD1889_WRITEW(ad1889_dev, AD_DSWADA, 0x0404); /* attenuation */
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
 static int ad1889_release(struct inode *inode, struct file *file)
 {
 	/* if we have state free it here */
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
 static struct file_operations ad1889_fops = {
+	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.read		= ad1889_read,
 	.write		= ad1889_write,
@@ -792,13 +791,11 @@
 		return -ENODEV;
 
 	file->private_data = ad1889_dev->ac97_codec;
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
 static int ad1889_mixer_release(struct inode *inode, struct file *file)
 {
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -810,6 +807,7 @@
 }
 
 static struct file_operations ad1889_mixer_fops = {
+	.owner		= THIS_MODULE,
 	.llseek		= no_llseek,
 	.ioctl		= ad1889_mixer_ioctl,
 	.open		= ad1889_mixer_open,
diff -Nru a/sound/oss/cs4281/cs4281m.c b/sound/oss/cs4281/cs4281m.c
--- a/sound/oss/cs4281/cs4281m.c	Wed Oct 15 11:18:31 2003
+++ b/sound/oss/cs4281/cs4281m.c	Wed Oct 15 11:18:31 2003
@@ -2588,7 +2588,6 @@
 	}
 	VALIDATE_STATE(s);
 	file->private_data = s;
-	MOD_INC_USE_COUNT;
 
 	CS_DBGOUT(CS_FUNCTION | CS_OPEN, 4,
 		  printk(KERN_INFO "cs4281: cs4281_open_mixdev()- 0\n"));
@@ -2603,7 +2602,6 @@
 	    (struct cs4281_state *) file->private_data;
 
 	VALIDATE_STATE(s);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -2620,6 +2618,7 @@
 //   Mixer file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_mixer_fops = {
+	.owner	 = THIS_MODULE,
 	.llseek	 = no_llseek,
 	.ioctl	 = cs4281_ioctl_mixdev,
 	.open	 = cs4281_open_mixdev,
@@ -3607,7 +3606,6 @@
 		s->open_mode &= ~FMODE_WRITE;
 		up(&s->open_sem_dac);
 		wake_up(&s->open_wait_dac);
-		MOD_DEC_USE_COUNT;
 	}
 	if (file->f_mode & FMODE_READ) {
 		drain_adc(s, file->f_flags & O_NONBLOCK);
@@ -3617,7 +3615,6 @@
 		s->open_mode &= ~FMODE_READ;
 		up(&s->open_sem_adc);
 		wake_up(&s->open_wait_adc);
-		MOD_DEC_USE_COUNT;
 	}
 	return 0;
 }
@@ -3697,7 +3694,6 @@
 		s->dma_adc.ossfragshift = s->dma_adc.ossmaxfrags =
 		    s->dma_adc.subdivision = 0;
 		up(&s->open_sem_adc);
-		MOD_INC_USE_COUNT;
 
 		if (prog_dmabuf_adc(s)) {
 			CS_DBGOUT(CS_OPEN | CS_ERROR, 2, printk(KERN_ERR
@@ -3718,7 +3714,6 @@
 		s->dma_dac.ossfragshift = s->dma_dac.ossmaxfrags =
 		    s->dma_dac.subdivision = 0;
 		up(&s->open_sem_dac);
-		MOD_INC_USE_COUNT;
 
 		if (prog_dmabuf_dac(s)) {
 			CS_DBGOUT(CS_OPEN | CS_ERROR, 2, printk(KERN_ERR
@@ -3738,6 +3733,7 @@
 //   Wave (audio) file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_audio_fops = {
+	.owner	 = THIS_MODULE,
 	.llseek	 = no_llseek,
 	.read	 = cs4281_read,
 	.write	 = cs4281_write,
@@ -4029,7 +4025,6 @@
 	     f_mode << FMODE_MIDI_SHIFT) & (FMODE_MIDI_READ |
 					    FMODE_MIDI_WRITE);
 	up(&s->open_sem);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -4080,7 +4075,6 @@
 	spin_unlock_irqrestore(&s->lock, flags);
 	up(&s->open_sem);
 	wake_up(&s->open_wait);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -4088,6 +4082,7 @@
 //   Midi file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4281_midi_fops = {
+	.owner	 = THIS_MODULE,
 	.llseek	 = no_llseek,
 	.read	 = cs4281_midi_read,
 	.write	 = cs4281_midi_write,
diff -Nru a/sound/oss/cs46xx.c b/sound/oss/cs46xx.c
--- a/sound/oss/cs46xx.c	Wed Oct 15 11:18:31 2003
+++ b/sound/oss/cs46xx.c	Wed Oct 15 11:18:31 2003
@@ -1890,7 +1890,6 @@
         spin_unlock_irqrestore(&card->midi.lock, flags);
         card->midi.open_mode |= (file->f_mode & (FMODE_READ | FMODE_WRITE));
         up(&card->midi.open_sem);
-        MOD_INC_USE_COUNT; /* for 2.2 */
         return 0;
 }
 
@@ -1926,7 +1925,6 @@
         card->midi.open_mode &= (~(file->f_mode & (FMODE_READ | FMODE_WRITE)));
         up(&card->midi.open_sem);
         wake_up(&card->midi.open_wait);
-        MOD_DEC_USE_COUNT; /* for 2.2 */
         return 0;
 }
 
@@ -3370,7 +3368,6 @@
 		if((ret = prog_dmabuf(state)))
 			return ret;
 	}
-	MOD_INC_USE_COUNT;	/* for 2.2 */
 	CS_DBGOUT(CS_OPEN | CS_FUNCTION, 2, printk("cs46xx: cs_open()- 0\n") );
 	return 0;
 }
@@ -3457,7 +3454,6 @@
 	}
 
 	CS_DBGOUT(CS_FUNCTION | CS_RELEASE, 2, printk("cs46xx: cs_release()- 0\n") );
-	MOD_DEC_USE_COUNT;	/* For 2.2 */
 	return 0;
 }
 
@@ -4105,7 +4101,6 @@
 	}
 	card->amplifier_ctrl(card, 1);
 	CS_INC_USE_COUNT(&card->mixer_use_cnt);
-	MOD_INC_USE_COUNT; /* for 2.2 */
 	CS_DBGOUT(CS_FUNCTION | CS_OPEN, 4,
 		  printk(KERN_INFO "cs46xx: cs_open_mixdev()- 0\n"));
 	return 0;
@@ -4136,7 +4131,6 @@
 		return -ENODEV;
 	}
 match:
-	MOD_DEC_USE_COUNT; /* for 2.2 */
 	if(!CS_DEC_AND_TEST(&card->mixer_use_cnt))
 	{
 		CS_DBGOUT(CS_FUNCTION | CS_RELEASE, 4,
diff -Nru a/sound/oss/swarm_cs4297a.c b/sound/oss/swarm_cs4297a.c
--- a/sound/oss/swarm_cs4297a.c	Wed Oct 15 11:18:31 2003
+++ b/sound/oss/swarm_cs4297a.c	Wed Oct 15 11:18:31 2003
@@ -1557,7 +1557,6 @@
 	}
 	VALIDATE_STATE(s);
 	file->private_data = s;
-	MOD_INC_USE_COUNT;
 
 	CS_DBGOUT(CS_FUNCTION | CS_OPEN, 4,
 		  printk(KERN_INFO "cs4297a: cs4297a_open_mixdev()- 0\n"));
@@ -1572,7 +1571,6 @@
 	    (struct cs4297a_state *) file->private_data;
 
 	VALIDATE_STATE(s);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -1589,6 +1587,7 @@
 //   Mixer file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4297a_mixer_fops = {
+	.owner		= THIS_MODULE,
 	.llseek		= cs4297a_llseek,
 	.ioctl		= cs4297a_ioctl_mixdev,
 	.open		= cs4297a_open_mixdev,
@@ -2368,7 +2367,6 @@
 		s->open_mode &= ~FMODE_WRITE;
 		up(&s->open_sem_dac);
 		wake_up(&s->open_wait_dac);
-		MOD_DEC_USE_COUNT;
 	}
 	if (file->f_mode & FMODE_READ) {
 		drain_adc(s, file->f_flags & O_NONBLOCK);
@@ -2378,7 +2376,6 @@
 		s->open_mode &= ~FMODE_READ;
 		up(&s->open_sem_adc);
 		wake_up(&s->open_wait_adc);
-		MOD_DEC_USE_COUNT;
 	}
 	return 0;
 }
@@ -2469,7 +2466,6 @@
 		s->dma_adc.ossfragshift = s->dma_adc.ossmaxfrags =
 		    s->dma_adc.subdivision = 0;
 		up(&s->open_sem_adc);
-		MOD_INC_USE_COUNT;
 
 		if (prog_dmabuf_adc(s)) {
 			CS_DBGOUT(CS_OPEN | CS_ERROR, 2, printk(KERN_ERR
@@ -2488,7 +2484,6 @@
 		s->dma_dac.ossfragshift = s->dma_dac.ossmaxfrags =
 		    s->dma_dac.subdivision = 0;
 		up(&s->open_sem_dac);
-		MOD_INC_USE_COUNT;
 
 		if (prog_dmabuf_dac(s)) {
 			CS_DBGOUT(CS_OPEN | CS_ERROR, 2, printk(KERN_ERR
@@ -2507,6 +2502,7 @@
 //   Wave (audio) file operations struct.
 // ******************************************************************************************
 static /*const */ struct file_operations cs4297a_audio_fops = {
+	.owner		= THIS_MODULE,
 	.llseek		= cs4297a_llseek,
 	.read		= cs4297a_read,
 	.write		= cs4297a_write,

