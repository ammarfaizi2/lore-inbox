Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262529AbVCaHAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbVCaHAe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:00:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCaHAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:00:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:26501 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262530AbVCaHAF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:00:05 -0500
Date: Thu, 31 Mar 2005 08:59:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS client latencies
Message-ID: <20050331065942.GA14952@elte.hu>
References: <1112137487.5386.33.camel@mindpipe> <1112138283.11346.2.camel@lade.trondhjem.org> <1112192778.17365.2.camel@mindpipe> <1112194256.10634.35.camel@lade.trondhjem.org> <20050330115640.0bc38d01.akpm@osdl.org> <1112217299.10771.3.camel@lade.trondhjem.org> <1112236017.26732.4.camel@mindpipe> <20050330183957.2468dc21.akpm@osdl.org> <1112237239.26732.8.camel@mindpipe> <1112240918.10975.4.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112240918.10975.4.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> > The 7 ms are spent in this loop:
>
> Which is basically confirming what the guys from Bull already told me, 
> namely that the radix tree tag stuff is much less efficient that what 
> we've got now. I never saw their patches, though, so I was curious to 
> try it for myself.

i think the numbers are being misinterpreted. I believe this patch is a 
big step forward. The big thing is that nfs_list_add_request() is O(1) 
now - while _a single request addition to the sorted list_ triggered the 
1+ msec latency in Lee's previous trace. I.e. the previous trace showed 
a 1+ msec latency for a single page IO submission, while his new trace 
shows _thousands_ of pages submitted for NFS IO - which is a very 
different beast!

i think all it needs now is a lock-breaker in the main radix-lookup loop 
in nfs_scan_lock_dirty(), or a latency-oriented reduction in the npages 
argument, to make the loop bounded. The nfs_list_add_request() code 
unbreakable from a latency POV. The patch looks really great to me, 
kudos for pulling it off that fast.

(Also, i'd not declare this variant _slower_ based on latencies, unless 
proven in real benchmarks. A faster implementation can easily have 
higher latencies, if some detail changed - and lots of details changed 
due to your patch. And i'd not even declare latency that much worse, 
unless it's been measured with the tracer turned off. (Lee, could you 
try such a comparison, worst-case latency with and without the patch, 
with LATENCY_TRACE turned off in the .config but latency timing still 
enabled?) The latency tracer itself can baloon the latency.)

	Ingo
