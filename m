Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUJLMTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUJLMTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 08:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUJLMTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 08:19:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:34538 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264726AbUJLMTS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 08:19:18 -0400
Date: Tue, 12 Oct 2004 14:12:28 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: "Ronny V. Vindenes" <s864@ii.uib.no>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: CFQ v2 high cpu load fix(?)
Message-ID: <20041012121227.GA1754@suse.de>
References: <1097579760.4086.27.camel@tentacle125.gozu.lan> <416BBF48.4070102@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416BBF48.4070102@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12 2004, Nick Piggin wrote:
> Ronny V. Vindenes wrote:
> >CFQ v2 is much better in a lot of cases, but certain situations trigger
> >a cpu load so high it starves the rest of the system thus completely
> >ruining the interactive experience. While casually looking at the
> >problem, I stumbled upon a patch by Arjan van de Ven sent to lkml on
> >sept. 1 (Subject: block fixes). Part of it is already included in the
> >CFQ v2 patches and after applying the rest[1] I'm no longer able to
> >trigger the problem.
> >
> >[1] Patch attached against 2.6.9-rc4-ck1 but applies to rc4-mm1 with
> >some minor fuzz.
> >
> >
> >
> >------------------------------------------------------------------------
> >
> >--- patches/linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c	2004-10-12 
> >12:25:09.798003278 +0200
> >+++ linux-2.6.9-rc4-ck1/drivers/block/ll_rw_blk.c	2004-10-12 
> >12:25:42.959479479 +0200
> >@@ -100,7 +100,7 @@
> > 		nr = q->nr_requests;
> > 	q->nr_congestion_on = nr;
> > 
> >-	nr = q->nr_requests - (q->nr_requests / 8) - 1;
> >+	nr = q->nr_requests - (q->nr_requests / 8) - (q->nr_requests/16)- 1;
> > 	if (nr < 1)
> > 		nr = 1;
> > 	q->nr_congestion_off = nr;
> 
> 
> I thought this first hunk looked like a good idea when Arjan sent the
> patch. Can you check if it alone helps your problem?

Yeah agree, it's a good idea to leave a bit of air between congestion on
and off. Fully explains the cfq v2 excessive sys time for some
workloads, which is extra nice.

> The second hunk should be basically a noop.

I don't see what it is trying to achieve, I like the current code
better.

-- 
Jens Axboe

