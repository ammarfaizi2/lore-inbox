Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTL1AgV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 19:36:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264899AbTL1AgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 19:36:21 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:461 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S264898AbTL1AgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 19:36:19 -0500
Date: Sat, 27 Dec 2003 16:27:11 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: azarah@nosferatu.za.org
cc: Edward Tandi <ed@efix.biz>, perex@suse.cz,
       alsa-devel@lists.sourceforge.net,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Rob Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       Stan Bubrouski <stan@ccs.neu.edu>,
       Henrik Storner <henrik-kernel@hswn.dk>
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
Message-ID: <3160000.1072571230@[10.10.2.4]>
In-Reply-To: <1072557893.6994.5.camel@nosferatu.lan>
References: <1080000.1072475704@[10.10.2.4]> <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]> <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]> <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]> <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]> <1072523478.12308.52.camel@nosferatu.lan> <1072525450.3794.8.camel@wires.home.biz>  <1960000.1072550125@[10.10.2.4]> <1072555431.12308.471.camel@nosferatu.lan> <1072557893.6994.5.camel@nosferatu.lan>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I chose to just back out the wholefrag stuff - it doesn't seem to
work. Presumably someone from the ALSA project will come up with a
better fix than this, if not, I'll send this upstream. This should
just fix it, without the need to do other stuff in userspace to work
around it ... at least it does for me. 

This is the way the world was in -test2, and maybe it should have stayed 
like that - the new feature seems to me to default wholefrag off, where
it was on before. Patch is also in 2.6.0-mjb2, which I'll release in a bit.

M.

diff -urpN -X /home/fletch/.diff.exclude 610-alsa_100rc2/include/sound/pcm_oss.h 620-force_wholefrag/include/sound/pcm_oss.h
--- 610-alsa_100rc2/include/sound/pcm_oss.h	Mon Nov 17 18:29:43 2003
+++ 620-force_wholefrag/include/sound/pcm_oss.h	Sat Dec 27 14:50:15 2003
@@ -31,7 +31,6 @@ struct _snd_pcm_oss_setup {
 		     direct:1,
 		     block:1,
 		     nonblock:1,
-		     wholefrag:1,
 		     nosilence:1;
 	unsigned int periods;
 	unsigned int period_size;
diff -urpN -X /home/fletch/.diff.exclude 610-alsa_100rc2/sound/core/oss/pcm_oss.c 620-force_wholefrag/sound/core/oss/pcm_oss.c
--- 610-alsa_100rc2/sound/core/oss/pcm_oss.c	Sat Dec 27 14:50:08 2003
+++ 620-force_wholefrag/sound/core/oss/pcm_oss.c	Sat Dec 27 14:50:15 2003
@@ -814,9 +814,8 @@ static ssize_t snd_pcm_oss_write1(snd_pc
 			buf += tmp;
 			bytes -= tmp;
 			xfer += tmp;
-			if (substream->oss.setup == NULL || !substream->oss.setup->wholefrag ||
-			    runtime->oss.buffer_used == runtime->oss.period_bytes) {
-				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.buffer_used, 1);
+			if (runtime->oss.buffer_used == runtime->oss.period_bytes) {
+				tmp = snd_pcm_oss_write2(substream, runtime->oss.buffer, runtime->oss.period_bytes, 1);
 				if (tmp <= 0)
 					return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
 				runtime->oss.bytes += tmp;
@@ -2195,7 +2194,7 @@ static void snd_pcm_oss_proc_read(snd_in
 	snd_pcm_oss_setup_t *setup = pstr->oss.setup_list;
 	down(&pstr->oss.setup_mutex);
 	while (setup) {
-		snd_iprintf(buffer, "%s %u %u%s%s%s%s%s%s\n",
+		snd_iprintf(buffer, "%s %u %u%s%s%s%s%s\n",
 			    setup->task_name,
 			    setup->periods,
 			    setup->period_size,
@@ -2203,7 +2202,6 @@ static void snd_pcm_oss_proc_read(snd_in
 			    setup->direct ? " direct" : "",
 			    setup->block ? " block" : "",
 			    setup->nonblock ? " non-block" : "",
-			    setup->wholefrag ? " whole-frag" : "",
 			    setup->nosilence ? " no-silence" : "");
 		setup = setup->next;
 	}
@@ -2270,8 +2268,6 @@ static void snd_pcm_oss_proc_write(snd_i
 				template.block = 1;
 			} else if (!strcmp(str, "non-block")) {
 				template.nonblock = 1;
-			} else if (!strcmp(str, "whole-frag")) {
-				template.wholefrag = 1;
 			} else if (!strcmp(str, "no-silence")) {
 				template.nosilence = 1;
 			}





