Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751377AbVIZTeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbVIZTeM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbVIZTeM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 15:34:12 -0400
Received: from fmr24.intel.com ([143.183.121.16]:33683 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751377AbVIZTeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 15:34:11 -0400
Date: Mon, 26 Sep 2005 12:33:57 -0700
From: "Seth, Rohit" <rohit.seth@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, linux-kernel@vger.kernel.org,
       "Seth, Rohit" <rohit.seth@intel.com>
Subject: Re: 2.6.14-rc2-mm1
Message-ID: <20050926123357.A4892@unix-os.sc.intel.com>
References: <20050921222839.76c53ba1.akpm@osdl.org> <20050924175848.GD3586@inferi.kami.home> <20050924112339.342b82e1.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050924112339.342b82e1.akpm@osdl.org>; from akpm@osdl.org on Sat, Sep 24, 2005 at 11:23:39AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 11:23:39AM -0700, Andrew Morton wrote:
> > 
> > ...
> >  exim4: page allocation failure. order:1, mode:0x80000020
> 
> Yes, it's expected that
> mm-try-to-allocate-higher-order-pages-in-rmqueue_bulk.patch will cause more
> fragmentation and will hence cause higher-order allocation attempts to
> fail.
> 
> I think I'll drop that one.

Seems like from the log messages that quite a few pages are hanging in the cpu's cold pcp list even with the low memory conditions.  Below is the patch to reduce the higher bound in cold pcp list (...this got increased with my previous change).  

I think we should also drain the CPU's hot and cold pcps for the GFP_KERNEL page requests (in the event the higher order request is not able to get serviced otherwise).  This will still only drains the current CPUs pcps in an MP environment (leaving the other CPUs with their lists intact).  I will send this patch later today.

	[PATCH]: Reduce the high mark in cpu's cold pcp list.

	Signed-off-by: Rohit Seth <rohit.seth@intel.com>


--- linux-2.6.13.old/mm/page_alloc.c	2005-09-26 10:57:07.000000000 -0700
+++ linux-2.6.13.work/mm/page_alloc.c	2005-09-26 10:47:57.000000000 -0700
@@ -1749,7 +1749,7 @@
 	pcp = &p->pcp[1];		/* cold*/
 	pcp->count = 0;
 	pcp->low = 0;
-	pcp->high = 2 * batch;
+	pcp->high = batch / 2;
 	pcp->batch = max(1UL, batch/2);
 	INIT_LIST_HEAD(&pcp->list);
 }
