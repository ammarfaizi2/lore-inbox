Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUGZVXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUGZVXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265777AbUGZVXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:23:32 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61620 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S265305AbUGZU5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 16:57:23 -0400
Date: Mon, 26 Jul 2004 22:57:41 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rudo Thomas <rudo@matfyz.cz>
Cc: Lee Revell <rlrevell@joe-job.com>, Jens Axboe <axboe@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       Lenar L?hmus <lenar@vision.ee>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: no luck with max_sectors_kb (Re: voluntary-preempt-2.6.8-rc2-J4)
Message-ID: <20040726205741.GA27527@elte.hu>
References: <40F3F0A0.9080100@vision.ee> <20040713143947.GG21066@holomorphy.com> <1090732537.738.2.camel@mindpipe> <1090795742.719.4.camel@mindpipe> <20040726082330.GA22764@elte.hu> <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu> <20040726100103.GA29072@elte.hu> <20040726101536.GA29408@elte.hu> <20040726204228.GA1231@ss1000.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040726204228.GA1231@ss1000.ms.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Rudo Thomas <rudo@matfyz.cz> wrote:

> After setting it to 32 (the hw max is 128), userland programs fail
> with I/O errors. Setting it back to 128 gets it back to working, sort
> of. The errors probably get bufferred somewhere.
> 
> During the "bad" setting (32), messages like this one show up in kernel log.
> 
> bio too big device hda3 (104 > 64)

does the patch below, ontop of -J7, help?

	Ingo

--- drivers/block/ll_rw_blk.c.orig
+++ drivers/block/ll_rw_blk.c
@@ -2447,11 +2447,11 @@ end_io:
 			break;
 		}
 
-		if (unlikely(bio_sectors(bio) > q->max_sectors)) {
+		if (unlikely(bio_sectors(bio) > q->max_hw_sectors)) {
 			printk("bio too big device %s (%u > %u)\n", 
 				bdevname(bio->bi_bdev, b),
 				bio_sectors(bio),
-				q->max_sectors);
+				q->max_hw_sectors);
 			goto end_io;
 		}
 
