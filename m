Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266692AbUHTQUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266692AbUHTQUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 12:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268310AbUHTQUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 12:20:14 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:55472 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S266692AbUHTQT4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 12:19:56 -0400
To: linux-kernel@vger.kernel.org
Cc: Lee Revell <rlrevell@joe-job.com>
Subject: [patch] intel8x0 latency fix
References: <20040816033623.GA12157@elte.hu>
	<1092627691.867.150.camel@krustophenia.net>
	<20040816034618.GA13063@elte.hu>
	<1092628493.810.3.camel@krustophenia.net>
	<20040816040515.GA13665@elte.hu> <1092654819.5057.18.camel@localhost>
	<20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu>
	<1092716644.876.1.camel@krustophenia.net>
	<20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	<m31xi3j901.fsf@seagha.com> <m3brh6g8yi.fsf@seagha.com>
From: karl.vogel@seagha.com
Date: Fri, 20 Aug 2004 18:19:12 +0200
In-Reply-To: <m3brh6g8yi.fsf@seagha.com> (karl vogel's message of "Thu, 19
 Aug 2004 22:37:57 +0200")
Message-ID: <m3smahwznj.fsf_-_@seagha.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

karl.vogel@seagha.com writes:

> # lspci -s 00:06.0
> 00:06.0 Multimedia audio controller: nVidia Corporation nForce3 Audio (rev a2)
>
>  latency: 50752 us, entries: 267 (267)


Following patch fixes it for 2 channel devices (like my notebook). Although I'm
not sure if this is all that useful... if there are workloads other than audio
work that need low latency, then this might be useful.

Without this patch, my machine was generating the latency each time artsd (KDE)
re-opened the audio device.


--- a/sound/pci/intel8x0.c	2004-08-20 18:05:46.006717144 +0200
+++ b/sound/pci/intel8x0.c	2004-08-20 17:52:02.759869688 +0200
@@ -1021,8 +1021,10 @@
 			/* reset to 2ch once to keep the 6 channel data in alignment,
 			 * to start from Front Left always
 			 */
-			iputdword(chip, ICHREG(GLOB_CNT), (cnt & 0xcfffff));
-			mdelay(50); /* grrr... */
+			if (chip->multi4 || chip->multi6) {
+				iputdword(chip, ICHREG(GLOB_CNT), (cnt & 0xcfffff));
+				mdelay(50); /* grrr... */
+			}
 		} else if (chip->device_type == DEVICE_INTEL_ICH4) {
 			if (sample_bits > 16)
 				cnt |= ICH_PCM_20BIT;
