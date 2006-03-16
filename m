Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752038AbWCPCBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752038AbWCPCBK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 21:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbWCPCBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 21:01:10 -0500
Received: from kbsmtao2.starhub.net.sg ([203.116.2.167]:37942 "EHLO
	kbsmtao2.starhub.net.sg") by vger.kernel.org with ESMTP
	id S1752038AbWCPCBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 21:01:09 -0500
Date: Thu, 16 Mar 2006 10:00:07 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
Subject: Fix gus_pcm dereference before NULL
To: linux-kernel@vger.kernel.org
Cc: Jaroslav Kysela <perex@suse.cz>
Reply-to: Eugene Teo <eugene.teo@eugeneteo.net>
Message-id: <20060316020007.GA20734@eugeneteo.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-PGP-Key: http://www.honeynet.org/misc/pgp/eugene-teo.pgp
X-Operating-System: Debian GNU/Linux 2.6.16-rc6
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

substream is dereferenced before checking for NULL.

Coverity bug #861

Signed-off-by: Eugene Teo <eugene.teo@eugeneteo.net>

--- linux-2.6/sound/isa/gus/gus_pcm.c~	2006-03-15 10:05:45.000000000 +0800
+++ linux-2.6/sound/isa/gus/gus_pcm.c	2006-03-16 09:51:43.000000000 +0800
@@ -103,8 +103,8 @@
 
 static void snd_gf1_pcm_trigger_up(struct snd_pcm_substream *substream)
 {
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct gus_pcm_private *pcmp = runtime->private_data;
+	struct snd_pcm_runtime *runtime;
+	struct gus_pcm_private *pcmp;
 	struct snd_gus_card * gus = pcmp->gus;
 	unsigned long flags;
 	unsigned char voice_ctrl, ramp_ctrl;
@@ -114,8 +114,10 @@
 	unsigned char pan;
 	unsigned int voice;
 
-	if (substream == NULL)
+	if (substream == NULL || substream->runtime == NULL)
 		return;
+	runtime = substream->runtime;
+	pcmp = runtime->private_data;
 	spin_lock_irqsave(&pcmp->lock, flags);
 	if (pcmp->flags & SNDRV_GF1_PCM_PFLG_ACTIVE) {
 		spin_unlock_irqrestore(&pcmp->lock, flags);

-- 
1024D/A6D12F80 print D51D 2633 8DAC 04DB 7265  9BB8 5883 6DAA A6D1 2F80
main(i) { putchar(182623909 >> (i-1) * 5&31|!!(i<7)<<6) && main(++i); }

