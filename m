Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbTFJKKt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 06:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbTFJKJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 06:09:22 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:12428 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261411AbTFJKIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 06:08:19 -0400
Date: Tue, 10 Jun 2003 15:55:00 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Misc 2.5 Fixes: resrc-leak-i810
Message-ID: <20030610102500.GO2194@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030610100950.GE2194@in.ibm.com> <20030610101035.GF2194@in.ibm.com> <20030610101121.GG2194@in.ibm.com> <20030610101318.GH2194@in.ibm.com> <20030610101503.GI2194@in.ibm.com> <20030610101801.GJ2194@in.ibm.com> <20030610102024.GK2194@in.ibm.com> <20030610102255.GL2194@in.ibm.com> <20030610102336.GM2194@in.ibm.com> <20030610102405.GN2194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610102405.GN2194@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Free any read channel allocated earlier if allocation of write channel
fails.


 sound/oss/i810_audio.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN sound/oss/i810_audio.c~resrc-leak-i810 sound/oss/i810_audio.c
--- linux-2.5.70-ds/sound/oss/i810_audio.c~resrc-leak-i810	2003-06-09 22:10:21.000000000 +0530
+++ linux-2.5.70-ds-dipankar/sound/oss/i810_audio.c	2003-06-09 22:16:04.000000000 +0530
@@ -2493,6 +2493,11 @@ found_virt:
 	}
 	if(file->f_mode & FMODE_WRITE) {
 		if((dmabuf->write_channel = card->alloc_pcm_channel(card)) == NULL) {
+			/* free any read channel allocated earlier */
+			if(file->f_mode & FMODE_READ)
+				card->free_pcm_channel(card,
+						dmabuf->read_channel->num);
+
 			kfree (card->states[i]);
 			card->states[i] = NULL;;
 			return -EBUSY;

_
