Return-Path: <linux-kernel-owner+w=401wt.eu-S1751287AbWLOIRf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWLOIRf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 03:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWLOIRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 03:17:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43637 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbWLOIRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 03:17:35 -0500
Date: Fri, 15 Dec 2006 00:17:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jaroslav Kysela <perex@suse.cz>, Linus Torvalds <torvalds@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [ALSA PATCH] alsa-git merge request
Message-Id: <20061215001722.616ea1a8.akpm@osdl.org>
In-Reply-To: <20061215001319.b6dd7198.akpm@osdl.org>
References: <Pine.LNX.4.61.0612150849410.13335@tm8103.perex-int.cz>
	<20061215001319.b6dd7198.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Dec 2006 00:13:19 -0800
Andrew Morton <akpm@osdl.org> wrote:

> It's going to need this fix

And this one, which was sent and ignored a week ago.

Consideration of the below review comments would be useful, too.




From: Andrew Morton <akpm@osdl.org>

Fix the soc code after dhowells workqueue changes.

I converted the workqueues to per-device while I was there.  It seems strange
to create a new kernel thread (on each CPU!) and to then only have a single
global work to ever be queued upon it.

Plus without this, I'd have to use the _NAR stuff, gawd help me.

Does that workqueue really need to be per-cpu?

Does that workqueue really need to exist?  Why not use keventd?

Cc: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/sound/soc.h  |    2 ++
 sound/soc/soc-core.c |   12 ++++++------
 2 files changed, 8 insertions(+), 6 deletions(-)

diff -puN sound/soc/soc-core.c~alsa-workqueue-fixes sound/soc/soc-core.c
--- a/sound/soc/soc-core.c~alsa-workqueue-fixes
+++ a/sound/soc/soc-core.c
@@ -56,7 +56,6 @@
 static DEFINE_MUTEX(pcm_mutex);
 static DEFINE_MUTEX(io_mutex);
 static struct workqueue_struct *soc_workq;
-static struct work_struct soc_stream_work;
 static DECLARE_WAIT_QUEUE_HEAD(soc_pm_waitq);
 
 /* supported sample rates */
@@ -728,9 +727,10 @@ out:
  * This is to ensure there are no pops or clicks in between any music tracks
  * due to DAPM power cycling.
  */
-static void close_delayed_work(void *data)
+static void close_delayed_work(struct work_struct *work)
 {
-	struct snd_soc_device *socdev = data;
+	struct snd_soc_device *socdev =
+		container_of(work, struct snd_soc_device, delayed_work.work);
 	struct snd_soc_codec *codec = socdev->codec;
 	struct snd_soc_codec_dai *codec_dai;
 	int i;
@@ -805,7 +805,7 @@ static int soc_codec_close(struct snd_pc
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* start delayed pop wq here for playback streams */
 		rtd->codec_dai->pop_wait = 1;
-		queue_delayed_work(soc_workq, &soc_stream_work,
+		queue_delayed_work(soc_workq, &socdev->delayed_work,
 			msecs_to_jiffies(pmdown_time));
 	} else {
 		/* capture streams can be powered down now */
@@ -865,7 +865,7 @@ static int soc_pcm_prepare(struct snd_pc
 					SND_SOC_DAPM_STREAM_START);
 		else {
 			rtd->codec_dai->pop_wait = 0;
-			cancel_delayed_work(&soc_stream_work);
+			cancel_delayed_work(&socdev->delayed_work);
 			if (rtd->codec_dai->digital_mute)
 				rtd->codec_dai->digital_mute(codec, rtd->codec_dai, 0);
 		}
@@ -1225,7 +1225,7 @@ static int soc_probe(struct platform_dev
 	soc_workq = create_workqueue("kdapm");
 	if (soc_workq == NULL)
 		goto work_err;
-	INIT_WORK(&soc_stream_work, close_delayed_work, socdev);
+	INIT_DELAYED_WORK(&socdev->delayed_work, close_delayed_work);
 	return 0;
 
 work_err:
diff -puN include/sound/soc.h~alsa-workqueue-fixes include/sound/soc.h
--- a/include/sound/soc.h~alsa-workqueue-fixes
+++ a/include/sound/soc.h
@@ -15,6 +15,7 @@
 
 #include <linux/platform_device.h>
 #include <linux/types.h>
+#include <linux/workqueue.h>
 #include <sound/driver.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -454,6 +455,7 @@ struct snd_soc_device {
 	struct snd_soc_platform *platform;
 	struct snd_soc_codec *codec;
 	struct snd_soc_codec_device *codec_dev;
+	struct delayed_work delayed_work;
 	void *codec_data;
 };
 
_

