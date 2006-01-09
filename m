Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWAIUyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWAIUyx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbWAIUyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:54:53 -0500
Received: from ns1.siteground.net ([207.218.208.2]:14776 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751363AbWAIUyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:54:52 -0500
Date: Mon, 9 Jan 2006 12:54:42 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Shai Fultheim <shai@scalex86.org>, Nippun Goel <nippung@calsoftinc.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [rfc][patch] Avoid taking global tasklist_lock for single threadedprocess at getrusage()
Message-ID: <20060109205442.GB3691@localhost.localdomain>
References: <43B2874F.F41A9299@tv-sign.ru> <20051228183345.GA3755@localhost.localdomain> <20051228225752.GB3755@localhost.localdomain> <43B57515.967F53E3@tv-sign.ru> <20060104231600.GA3664@localhost.localdomain> <43BD70AD.21FC6862@tv-sign.ru> <20060106094627.GA4272@localhost.localdomain> <43C0FC4B.567D18DC@tv-sign.ru> <20060108195848.GA4124@localhost.localdomain> <43C2B1B7.635DDF0B@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43C2B1B7.635DDF0B@tv-sign.ru>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 09:55:51PM +0300, Oleg Nesterov wrote:
> Ravikiran G Thirumalai wrote:
> >
> >
> > Don't we still need rmb for the RUSAGE_SELF case? we do not take the
> > siglock for rusage self and the non c* signal fields are written to
> > at __exit_signal...
> 
> I think it is unneeded because RUSAGE_SELF case is "racy" anyway even
> if we held both locks, task_struct->xxx counters can change at any
> moment.
> 
> But may be you are right.

Hmm...access to task_struct->xxx has been racy, but accessing the 
signal->* counters were not.  What if read of the signal->utime  was  a 
hoisted read and signal->stime was a read after the counter is updated?  
This was not a possibility earlier no? 
 
> 
> > What is wrong with optimizing by not taking the siglock in RUSAGE_BOTH
> > and RUSAGE_CHILDREN?  I would like to add that in too unless  I am
> > missing something and the optimization is incorrect.
> 
> We can't have contention on ->siglock when need_lock == 0, so why should
> we optimize this case?

We would be saving 1 buslocked operation in that case (on some arches), a 
cacheline fetch for exclusive (since signal and sighand are on different memory
locations), and disabling/enabling onchip interrupts.  But yes, this would be a 
smaller optimization....Unless you have strong objections this can also 
go in?

Thanks,
Kiran

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.15-mm2/kernel/sys.c
===================================================================
--- linux-2.6.15-mm2.orig/kernel/sys.c	2006-01-09 12:44:30.000000000 -0800
+++ linux-2.6.15-mm2/kernel/sys.c	2006-01-09 12:45:07.000000000 -0800
@@ -1730,14 +1730,16 @@ static void k_getrusage(struct task_stru
 	switch (who) {
 		case RUSAGE_BOTH:
 		case RUSAGE_CHILDREN:
-			spin_lock_irqsave(&p->sighand->siglock, flags);
+			if (need_lock)
+				spin_lock_irqsave(&p->sighand->siglock, flags);
 			utime = p->signal->cutime;
 			stime = p->signal->cstime;
 			r->ru_nvcsw = p->signal->cnvcsw;
 			r->ru_nivcsw = p->signal->cnivcsw;
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
-			spin_unlock_irqrestore(&p->sighand->siglock, flags);
+			if (need_lock)
+				spin_unlock_irqrestore(&p->sighand->siglock, flags);
 
 			if (who == RUSAGE_CHILDREN)
 				break;

