Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVCXWWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVCXWWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 17:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVCXWWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 17:22:50 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63671 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261176AbVCXWWp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 17:22:45 -0500
Date: Thu, 24 Mar 2005 23:22:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: re-inline sched functions
Message-ID: <20050324222215.GA30864@elte.hu>
References: <200503242116.j2OLGwg07920@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503242116.j2OLGwg07920@unix-os.sc.intel.com>
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


* Chen, Kenneth W <kenneth.w.chen@intel.com> wrote:

> Ingo Molnar wrote on Friday, March 11, 2005 1:32 AM
> > > -static unsigned int task_timeslice(task_t *p)
> > > +static inline unsigned int task_timeslice(task_t *p)
> >
> > the patch looks good except this one - could you try to undo it and
> > re-measure? task_timeslice() is not used in any true fastpath, if it
> > makes any difference then the performance difference must be some other
> > artifact.
> 
> Chen, Kenneth W wrote on Friday, March 11, 2005 10:40 AM
> > OK, I'll re-measure. Yeah, I agree that this function is not in the fastpath.
> 
> Ingo is right, re-measured on our benchmark setup and did not see any 
> difference whether task_timeslice is inlined or not.  So if people 
> want to take inline keyword out for that function, we won't complain 
> :-)

Signed-off-by: Ingo Molnar <mingo@elte.hu>

uninline task_timeslice() - reduces code footprint noticeably, and it's 
slowpath code.

--- kernel/sched.c.orig
+++ kernel/sched.c
@@ -166,7 +166,7 @@
 #define SCALE_PRIO(x, prio) \
 	max(x * (MAX_PRIO - prio) / (MAX_USER_PRIO/2), MIN_TIMESLICE)
 
-static inline unsigned int task_timeslice(task_t *p)
+static unsigned int task_timeslice(task_t *p)
 {
 	if (p->static_prio < NICE_TO_PRIO(0))
 		return SCALE_PRIO(DEF_TIMESLICE*4, p->static_prio);
