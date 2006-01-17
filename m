Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWAQO6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWAQO6v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbWAQOud
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:33 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:60560 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750915AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143325.907546000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:09 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 11/34] PID Virtualization Change pid accesses: sound/
Content-Disposition: inline; filename=BA-change-pid-tgid-references-sound
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change pid accesses for sound drivers.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 core/control.c          |    4 ++--
 core/pcm.c              |    2 +-
 core/rawmidi.c          |    2 +-
 core/timer.c            |    4 ++--
 oss/forte.c             |    2 +-
 pci/korg1212/korg1212.c |    4 ++--
 pci/rme9652/hdsp.c      |    4 ++--
 pci/rme9652/hdspm.c     |    4 ++--
 pci/rme9652/rme9652.c   |    4 ++--
 9 files changed, 15 insertions(+), 15 deletions(-)

Index: linux-2.6.15/sound/core/control.c
===================================================================
--- linux-2.6.15.orig/sound/core/control.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/core/control.c	2006-01-17 08:37:02.000000000 -0500
@@ -78,7 +78,7 @@
 	init_waitqueue_head(&ctl->change_sleep);
 	spin_lock_init(&ctl->read_lock);
 	ctl->card = card;
-	ctl->pid = current->pid;
+	ctl->pid = task_pid(current);
 	file->private_data = ctl;
 	write_lock_irqsave(&card->ctl_files_rwlock, flags);
 	list_add_tail(&ctl->list, &card->ctl_files);
@@ -781,7 +781,7 @@
 			result = -EBUSY;
 		else {
 			vd->owner = file;
-			vd->owner_pid = current->pid;
+			vd->owner_pid = task_pid(current);
 			result = 0;
 		}
 	}
Index: linux-2.6.15/sound/core/pcm.c
===================================================================
--- linux-2.6.15.orig/sound/core/pcm.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/core/pcm.c	2006-01-17 08:37:02.000000000 -0500
@@ -754,7 +754,7 @@
 	down_read(&card->controls_rwsem);
 	list_for_each(list, &card->ctl_files) {
 		kctl = snd_ctl_file(list);
-		if (kctl->pid == current->pid) {
+		if (kctl->pid == task_pid(current)) {
 			prefer_subdevice = kctl->prefer_pcm_subdevice;
 			break;
 		}
Index: linux-2.6.15/sound/core/rawmidi.c
===================================================================
--- linux-2.6.15.orig/sound/core/rawmidi.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/core/rawmidi.c	2006-01-17 08:37:02.000000000 -0500
@@ -423,7 +423,7 @@
 		down_read(&card->controls_rwsem);
 		list_for_each(list, &card->ctl_files) {
 			kctl = snd_ctl_file(list);
-			if (kctl->pid == current->pid) {
+			if (kctl->pid == task_pid(current)) {
 				subdevice = kctl->prefer_rawmidi_subdevice;
 				break;
 			}
Index: linux-2.6.15/sound/core/timer.c
===================================================================
--- linux-2.6.15.orig/sound/core/timer.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/core/timer.c	2006-01-17 08:37:02.000000000 -0500
@@ -1512,10 +1512,10 @@
 		err = -EFAULT;
 		goto __err;
 	}
-	sprintf(str, "application %i", current->pid);
+	sprintf(str, "application %i", task_pid(current));
 	if (tselect.id.dev_class != SNDRV_TIMER_CLASS_SLAVE)
 		tselect.id.dev_sclass = SNDRV_TIMER_SCLASS_APPLICATION;
-	err = snd_timer_open(&tu->timeri, str, &tselect.id, current->pid);
+	err = snd_timer_open(&tu->timeri, str, &tselect.id, task_pid(current));
 	if (err < 0)
 		goto __err;
 
Index: linux-2.6.15/sound/oss/forte.c
===================================================================
--- linux-2.6.15.orig/sound/oss/forte.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/oss/forte.c	2006-01-17 08:37:02.000000000 -0500
@@ -1256,7 +1256,7 @@
 
 	file->private_data = forte;
 
-	DPRINTK ("%s: dsp opened by %d\n", __FUNCTION__, current->pid);
+	DPRINTK ("%s: dsp opened by %d\n", __FUNCTION__, task_pid(current));
 
 	if (file->f_mode & FMODE_WRITE)
 		forte_channel_init (forte, &forte->play);
Index: linux-2.6.15/sound/pci/korg1212/korg1212.c
===================================================================
--- linux-2.6.15.orig/sound/pci/korg1212/korg1212.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/pci/korg1212/korg1212.c	2006-01-17 08:37:02.000000000 -0500
@@ -1443,7 +1443,7 @@
         spin_lock_irqsave(&korg1212->lock, flags);
 
         korg1212->playback_substream = substream;
-	korg1212->playback_pid = current->pid;
+	korg1212->playback_pid = task_pid(current);
         korg1212->periodsize = K1212_PERIODS;
 	korg1212->channels = K1212_CHANNELS;
 	korg1212->errorcnt = 0;
@@ -1475,7 +1475,7 @@
         spin_lock_irqsave(&korg1212->lock, flags);
 
         korg1212->capture_substream = substream;
-	korg1212->capture_pid = current->pid;
+	korg1212->capture_pid = task_pid(current);
         korg1212->periodsize = K1212_PERIODS;
 	korg1212->channels = K1212_CHANNELS;
 
Index: linux-2.6.15/sound/pci/rme9652/hdsp.c
===================================================================
--- linux-2.6.15.orig/sound/pci/rme9652/hdsp.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/pci/rme9652/hdsp.c	2006-01-17 08:37:02.000000000 -0500
@@ -4188,7 +4188,7 @@
 	runtime->dma_area = hdsp->playback_buffer;
 	runtime->dma_bytes = HDSP_DMA_AREA_BYTES;
 
-	hdsp->playback_pid = current->pid;
+	hdsp->playback_pid = task_pid(current);
 	hdsp->playback_substream = substream;
 
 	spin_unlock_irq(&hdsp->lock);
@@ -4261,7 +4261,7 @@
 	runtime->dma_area = hdsp->capture_buffer;
 	runtime->dma_bytes = HDSP_DMA_AREA_BYTES;
 
-	hdsp->capture_pid = current->pid;
+	hdsp->capture_pid = task_pid(current);
 	hdsp->capture_substream = substream;
 
 	spin_unlock_irq(&hdsp->lock);
Index: linux-2.6.15/sound/pci/rme9652/hdspm.c
===================================================================
--- linux-2.6.15.orig/sound/pci/rme9652/hdspm.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/pci/rme9652/hdspm.c	2006-01-17 08:37:02.000000000 -0500
@@ -3102,7 +3102,7 @@
 	if (hdspm->capture_substream == NULL)
 		hdspm_stop_audio(hdspm);
 
-	hdspm->playback_pid = current->pid;
+	hdspm->playback_pid = task_pid(current);
 	hdspm->playback_substream = substream;
 
 	spin_unlock_irq(&hdspm->lock);
@@ -3151,7 +3151,7 @@
 	if (hdspm->playback_substream == NULL)
 		hdspm_stop_audio(hdspm);
 
-	hdspm->capture_pid = current->pid;
+	hdspm->capture_pid = task_pid(current);
 	hdspm->capture_substream = substream;
 
 	spin_unlock_irq(&hdspm->lock);
Index: linux-2.6.15/sound/pci/rme9652/rme9652.c
===================================================================
--- linux-2.6.15.orig/sound/pci/rme9652/rme9652.c	2006-01-17 08:36:28.000000000 -0500
+++ linux-2.6.15/sound/pci/rme9652/rme9652.c	2006-01-17 08:37:02.000000000 -0500
@@ -2321,7 +2321,7 @@
 		rme9652_set_thru(rme9652, -1, 0);
 	}
 
-	rme9652->playback_pid = current->pid;
+	rme9652->playback_pid = task_pid(current);
 	rme9652->playback_substream = substream;
 
 	spin_unlock_irq(&rme9652->lock);
@@ -2381,7 +2381,7 @@
 		rme9652_set_thru(rme9652, -1, 0);
 	}
 
-	rme9652->capture_pid = current->pid;
+	rme9652->capture_pid = task_pid(current);
 	rme9652->capture_substream = substream;
 
 	spin_unlock_irq(&rme9652->lock);

--

