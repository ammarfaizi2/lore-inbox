Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267889AbUHWWzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267889AbUHWWzw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUHWWzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:55:50 -0400
Received: from mx1.elte.hu ([157.181.1.137]:27576 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S268024AbUHWWvf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:51:35 -0400
Date: Tue, 24 Aug 2004 00:52:55 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
Message-ID: <20040823225255.GA16820@elte.hu>
References: <20040816113131.GA30527@elte.hu> <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net> <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu> <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu> <20040821140501.GA4189@elte.hu> <20040823210151.GA10949@elte.hu> <1093300882.826.28.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093300882.826.28.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> On Mon, 2004-08-23 at 17:01, Ingo Molnar wrote:
> > i've uploaded the -P8 patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8.1-P8
> > 
> > Changes since -P8:
> > 
> >  - fixes the DRI/DRM latency in radeon (and other drivers). The concept 
> >    was investigated/tested by Dave Airlie.
> > 
> >  - reduce netdev_max_backlog to 8 (Mark H Johnson)
> > 
> 
> Should this fix the 500+ usec latency I saw in rt_garbage_collect? 
> This one took a while to occur (overnight).

i dont think it will. Does the patch below help?

	Ingo

--- net/ipv4/route.c.orig
+++ net/ipv4/route.c
@@ -738,7 +738,7 @@ static int rt_garbage_collect(void)
 
 		if (atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
 			goto out;
-	} while (!in_softirq() && time_before_eq(jiffies, now));
+	} while (!in_softirq() && time_before_eq(jiffies, now) && !need_resched());
 
 	if (atomic_read(&ipv4_dst_ops.entries) < ip_rt_max_size)
 		goto out;
