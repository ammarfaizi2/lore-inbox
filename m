Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWCDW24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWCDW24 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 17:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWCDW24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 17:28:56 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:11218 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932078AbWCDW2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 17:28:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=e1FlKJluzYHDE+N/m/SdZ5B6mg57K2S03DhYYbavrs34hbsIlKVzS/uNlKniWoW/ol3oQAUNkzFIzAPxpO3nM+n+M5wBIDClUxeWNc2TG3/PSQVHBYpGeDNYSlioW/+ipV1P4vBsDXzD9S5TVdQnmSL4+XjV+h9raoCA7+wP8RI=
Date: Sun, 5 Mar 2006 01:28:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Eric Sesterhenn <snakebyte@gmx.de>
Subject: [PATCH] vx: fix memory leak on error path
Message-ID: <20060304222850.GD8332@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed by Eric Sesterhenn on kernel-janitors@

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 sound/drivers/vx/vx_pcm.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/sound/drivers/vx/vx_pcm.c
+++ b/sound/drivers/vx/vx_pcm.c
@@ -1254,9 +1254,13 @@ static int vx_init_audio_io(struct vx_co
 
 	/* allocate pipes */
 	chip->playback_pipes = kmalloc(sizeof(struct vx_pipe *) * chip->audio_outs, GFP_KERNEL);
+	if (! chip->playback_pipes)
+		return -ENOMEM;
 	chip->capture_pipes = kmalloc(sizeof(struct vx_pipe *) * chip->audio_ins, GFP_KERNEL);
-	if (! chip->playback_pipes || ! chip->capture_pipes)
+	if (! chip->capture_pipes) {
+		kfree(chip->playback_pipes);
 		return -ENOMEM;
+	}
 
 	memset(chip->playback_pipes, 0, sizeof(struct vx_pipe *) * chip->audio_outs);
 	memset(chip->capture_pipes, 0, sizeof(struct vx_pipe *) * chip->audio_ins);

