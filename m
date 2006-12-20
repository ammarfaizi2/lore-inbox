Return-Path: <linux-kernel-owner+w=401wt.eu-S965151AbWLTRUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965151AbWLTRUs (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965152AbWLTRUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:20:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:32460 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965151AbWLTRUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:20:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=XM9/yf4czHyqqsQDwIVyNcJYCiPr6saEts+ImxV+y3fu1A4v/vfFa6e1neNpeaV6ys4y26UCgqEsjNq/Ti06Sv0sdqIBMP547bRx9dW24AzFyMCDVGMKTtZLHqW3VXeXaOQWi9+0Aaj50syHQ0Tewm5z2HKRDrQR4RRRpeIPSZg=
Message-ID: <e13597370612200920k5d593863o6ba8580cf3e3c72e@mail.gmail.com>
Date: Wed, 20 Dec 2006 20:20:45 +0300
From: "Eugene Ilkov" <e.ilkov@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] alsa soc wm8750 fix 2.6.20-rc1-mm1
Cc: akpm@osdl.org, perex@suse.cz
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_32030_21379289.1166635245397"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_32030_21379289.1166635245397
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

 There was some INIT_WORK related changes, here is patch against
wm8750 codec driver. Tested on sharp sl-c1000


--- linux-2.6.20-rc1-mm1/sound/soc/codecs/wm8750.c	2006-12-20
19:23:27.000000000 +0300
+++ linux-2.6.20-rc1-mm.z1/sound/soc/codecs/wm8750.c	2006-12-20
19:27:28.000000000 +0300
@@ -52,7 +52,6 @@
 	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
  static struct workqueue_struct *wm8750_workq = NULL;
-static struct work_struct wm8750_dapm_work;
  /*
  * wm8750 register cache
@@ -1001,9 +1000,11 @@
 };
 EXPORT_SYMBOL_GPL(wm8750_dai);
 -static void wm8750_work(void *data)
+static void wm8750_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec = (struct snd_soc_codec *)data;
+	struct snd_soc_device *socdev =
+		container_of(work, struct snd_soc_device, delayed_work.work);
+	struct snd_soc_codec *codec = socdev->codec;
 	wm8750_dapm_event(codec, codec->dapm_state);
 }
 @@ -1039,7 +1040,7 @@
 	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0) {
 		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
 		codec->dapm_state = SNDRV_CTL_POWER_D0;
-		queue_delayed_work(wm8750_workq, &wm8750_dapm_work,
+		queue_delayed_work(wm8750_workq, &socdev->delayed_work,
 			 msecs_to_jiffies(1000));
 	}
 @@ -1084,7 +1085,7 @@
 	/* charge output caps */
 	wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
 	codec->dapm_state = SNDRV_CTL_POWER_D3hot;
-	queue_delayed_work(wm8750_workq, &wm8750_dapm_work,
+	queue_delayed_work(wm8750_workq, &socdev->delayed_work,
 		msecs_to_jiffies(1000));
  	/* set the update bits */
@@ -1227,7 +1228,7 @@
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 	wm8750_socdev = socdev;
-	INIT_WORK(&wm8750_dapm_work, wm8750_work, codec);
+	INIT_DELAYED_WORK(&socdev->delayed_work, wm8750_work);
 	wm8750_workq = create_workqueue("wm8750");
 	if (wm8750_workq == NULL) {
 		kfree(codec);

------=_Part_32030_21379289.1166635245397
Content-Type: message/rfc822; name="wm8750-2.6.20-rc1-mm1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="wm8750-2.6.20-rc1-mm1.patch"
X-Attachment-Id: f_evxznoiz


+++ linux-2.6.20-rc1-mm.z1/sound/soc/codecs/wm8750.c	2006-12-20 19:27:28.000000000 +0300
@@ -52,7 +52,6 @@
 	printk(KERN_WARNING AUDIO_NAME ": " format "\n" , ## arg)
 
 static struct workqueue_struct *wm8750_workq = NULL;
-static struct work_struct wm8750_dapm_work;
 
 /*
  * wm8750 register cache
@@ -1001,9 +1000,11 @@
 };
 EXPORT_SYMBOL_GPL(wm8750_dai);
 
-static void wm8750_work(void *data)
+static void wm8750_work(struct work_struct *work)
 {
-	struct snd_soc_codec *codec = (struct snd_soc_codec *)data;
+	struct snd_soc_device *socdev = 
+		container_of(work, struct snd_soc_device, delayed_work.work);
+	struct snd_soc_codec *codec = socdev->codec;
 	wm8750_dapm_event(codec, codec->dapm_state);
 }
 
@@ -1039,7 +1040,7 @@
 	if (codec->suspend_dapm_state == SNDRV_CTL_POWER_D0) {
 		wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
 		codec->dapm_state = SNDRV_CTL_POWER_D0;
-		queue_delayed_work(wm8750_workq, &wm8750_dapm_work,
+		queue_delayed_work(wm8750_workq, &socdev->delayed_work,
 			 msecs_to_jiffies(1000));
 	}
 
@@ -1084,7 +1085,7 @@
 	/* charge output caps */
 	wm8750_dapm_event(codec, SNDRV_CTL_POWER_D2);
 	codec->dapm_state = SNDRV_CTL_POWER_D3hot;
-	queue_delayed_work(wm8750_workq, &wm8750_dapm_work,
+	queue_delayed_work(wm8750_workq, &socdev->delayed_work,
 		msecs_to_jiffies(1000));
 
 	/* set the update bits */
@@ -1227,7 +1228,7 @@
 	INIT_LIST_HEAD(&codec->dapm_widgets);
 	INIT_LIST_HEAD(&codec->dapm_paths);
 	wm8750_socdev = socdev;
-	INIT_WORK(&wm8750_dapm_work, wm8750_work, codec);
+	INIT_DELAYED_WORK(&socdev->delayed_work, wm8750_work);
 	wm8750_workq = create_workqueue("wm8750");
 	if (wm8750_workq == NULL) {
 		kfree(codec);

------=_Part_32030_21379289.1166635245397--
