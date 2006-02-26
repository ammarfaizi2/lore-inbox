Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWBZVjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWBZVjC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWBZVjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:39:02 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19644 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750748AbWBZVjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:39:00 -0500
Date: Sun, 26 Feb 2006 13:31:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: largret@gmail.com
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       ak@muc.de
Subject: Re: OOM-killer too aggressive?
Message-Id: <20060226133140.4cf05ea5.akpm@osdl.org>
In-Reply-To: <1140988015.5178.15.camel@shogun.daga.dyndns.org>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	<20060226102152.69728696.akpm@osdl.org>
	<1140988015.5178.15.camel@shogun.daga.dyndns.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Largret <largret@gmail.com> wrote:
>
> On Sun, 2006-02-26 at 10:21 -0800, Andrew Morton wrote: 
> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > >
> > > Chris Largret is getting repeated OOM kills because of DMA memory
> > > exhaustion:
> > > 
> > > oom-killer: gfp_mask=0xd1, order=3
> > > 
> > 
> > This could be related to the known GFP_DMA oom on some x86_64 machines.
> 
> I'm not sure if this has any bearing on it, but the OOM Killer only does
> this when I compile the kernel with SMP support.

I doubt if that's related.

> > > Or should floppy.c be fixed so it doesn't ask for so much?
> > 
> > The page allocator uses 32k as the threshold for when-to-try-like-crazy.
> > 
> > x86_64 should probably be defining its own fd_dma_mem_alloc() which doesn't
> > use GFP_DMA.
> > 
> > --- devel/drivers/block/floppy.c~floppy-false-oom-fix	2006-02-26 10:14:38.000000000 -0800
> > +++ devel-akpm/drivers/block/floppy.c	2006-02-26 10:15:04.000000000 -0800
> > @@ -278,7 +278,8 @@ static void do_fd_request(request_queue_
> 
> Sorry, this didn't help on my machine. I am running that latest kernel
> pre-patch (2.6.16-rc4) for testing right now and had to modify the
> offsets a little. If there's any output that would help, please let me
> know.
> 

hm, OK.  I suppose we can hit it with the big hammer, but I'd be reluctant
to merge this patch because it has the potential to hide problems, such as
the as-yet-unfixed bio-uses-ZONE_DMA one.

--- devel/mm/page_alloc.c~a	2006-02-26 13:26:56.000000000 -0800
+++ devel-akpm/mm/page_alloc.c	2006-02-26 13:28:58.000000000 -0800
@@ -1003,7 +1003,8 @@ rebalance:
 						zonelist, alloc_flags);
 		if (page)
 			goto got_pg;
-	} else if ((gfp_mask & __GFP_FS) && !(gfp_mask & __GFP_NORETRY)) {
+	} else if ((gfp_mask & __GFP_FS) &&
+			!(gfp_mask & (__GFP_NORETRY|__GFP_DMA))) {
 		/*
 		 * Go through the zonelist yet one more time, keep
 		 * very high watermark here, this is only to catch
@@ -1027,7 +1028,7 @@ rebalance:
 	 * <= 3, but that may not be true in other implementations.
 	 */
 	do_retry = 0;
-	if (!(gfp_mask & __GFP_NORETRY)) {
+	if (!(gfp_mask & (__GFP_NORETRY|__GFP_DMA))) {
 		if ((order <= 3) || (gfp_mask & __GFP_REPEAT))
 			do_retry = 1;
 		if (gfp_mask & __GFP_NOFAIL)
_

