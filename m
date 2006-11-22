Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756495AbWKVS5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756495AbWKVS5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 13:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756535AbWKVS5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 13:57:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:46051 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1756508AbWKVS5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 13:57:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=F6OWmNwE229yIUDuQILhxFBoiIqQXRB3irdN0rUKPdbDqIKY31AFFhxNhdfDaC9ZOXS8cpymcB/K5+RUYki9L/CX93755jWg9cKBsvsLWilECJUocaOR49qo1q1I3cqImMSDzYhb/4t6IUwSJD5wjEZiPXJzXb/twuQ9wqEhBSs=
Date: Thu, 23 Nov 2006 03:51:45 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>
Subject: [PATCH] sound: fix PCM substream list
Message-ID: <20061122185145.GF2985@APFDCB5C>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
	Jaroslav Kysela <perex@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If snd_pcm_new_stream() fails to initalize a substream (if
snd_pcm_substream_proc_init() returns error), snd_pcm_new_stream()
immediately return without unlinking that kfree()d substram.

It causes oops when snd_pcm_free() iterates the list of substream to
free them by invalid reference.

Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

---
 sound/core/pcm.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: work-fault-inject/sound/core/pcm.c
===================================================================
--- work-fault-inject.orig/sound/core/pcm.c
+++ work-fault-inject/sound/core/pcm.c
@@ -638,6 +638,10 @@ int snd_pcm_new_stream(struct snd_pcm *p
 		err = snd_pcm_substream_proc_init(substream);
 		if (err < 0) {
 			snd_printk(KERN_ERR "Error in snd_pcm_stream_proc_init\n");
+			if (prev == NULL)
+				pstr->substream = NULL;
+			else
+				prev->next = NULL;
 			kfree(substream);
 			return err;
 		}
