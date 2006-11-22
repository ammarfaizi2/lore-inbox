Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756531AbWKVS4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756531AbWKVS4u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756508AbWKVS4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:56:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:36569 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756531AbWKVS4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:56:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=mEAf0oeiizprj5Fyt/diovlD6dOCUu49Qki1QTH3EICcyRRhTak51fNzPDWfVfL9rCM2G9mLqcQCHpbOLTBET1GJCmDma4s8E0HiQLJLGFDDk0GGMzMUnN4XbVOtEjLcRxOswxVHGvAr53w8StExxyAd7mmy9CRFeLzDQyyyToE=
Date: Thu, 23 Nov 2006 03:50:45 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] sound: initialize rawmidi substream list
Message-ID: <20061122185045.GE2985@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If snd_rawmidi_new() failed to allocate substreams for input
(snd_rawmidi_alloc_substreams() failed to populate a 
&rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT]), it will try to
free rawmidi instance by snd_rawmidi_free().

But it will cause oops because snd_rawmidi_free() tries to free
both of substreams list but list for output
(&rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT]) is not initialized yet.

Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 sound/core/rawmidi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: work-fault-inject/sound/core/rawmidi.c
===================================================================
--- work-fault-inject.orig/sound/core/rawmidi.c
+++ work-fault-inject/sound/core/rawmidi.c
@@ -1379,7 +1379,6 @@ static int snd_rawmidi_alloc_substreams(
 	struct snd_rawmidi_substream *substream;
 	int idx;
 
-	INIT_LIST_HEAD(&stream->substreams);
 	for (idx = 0; idx < count; idx++) {
 		substream = kzalloc(sizeof(*substream), GFP_KERNEL);
 		if (substream == NULL) {
@@ -1434,6 +1433,9 @@ int snd_rawmidi_new(struct snd_card *car
 	rmidi->device = device;
 	mutex_init(&rmidi->open_mutex);
 	init_waitqueue_head(&rmidi->open_wait);
+	INIT_LIST_HEAD(&rmidi->streams[SNDRV_RAWMIDI_STREAM_INPUT].substreams);
+	INIT_LIST_HEAD(&rmidi->streams[SNDRV_RAWMIDI_STREAM_OUTPUT].substreams);
+
 	if (id != NULL)
 		strlcpy(rmidi->id, id, sizeof(rmidi->id));
 	if ((err = snd_rawmidi_alloc_substreams(rmidi,
