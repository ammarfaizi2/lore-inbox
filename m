Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424387AbWLHEyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424387AbWLHEyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 23:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424381AbWLHEyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 23:54:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48822 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424392AbWLHEye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 23:54:34 -0500
Date: Thu, 7 Dec 2006 20:54:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Myron Stowe <myron.stowe@hp.com>,
       Jens Axboe <axboe@kernel.dk>, Dipankar <dipankar@in.ibm.com>,
       Gautham shenoy <ego@in.ibm.com>
Subject: Re: workqueue deadlock
Message-Id: <20061207205407.b4e356aa.akpm@osdl.org>
In-Reply-To: <20061208025301.GA11663@in.ibm.com>
References: <200612061726.14587.bjorn.helgaas@hp.com>
	<20061207105148.20410b83.akpm@osdl.org>
	<20061207113700.dc925068.akpm@osdl.org>
	<20061208025301.GA11663@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2006 08:23:01 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> On Thu, Dec 07, 2006 at 11:37:00AM -0800, Andrew Morton wrote:
> > -static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq)
> > +/*
> > + * If cpu == -1 it's a single-threaded workqueue and the caller does not hold
> > + * workqueue_mutex
> > + */
> > +static void flush_cpu_workqueue(struct cpu_workqueue_struct *cwq, int cpu)
> 
> Lets say @cpu = 4
> 
> >  {
> >  	if (cwq->thread == current) {
> >  		/*
> >  		 * Probably keventd trying to flush its own queue. So simply run
> >  		 * it by hand rather than deadlocking.
> >  		 */
> > +		if (cpu != -1)
> > +			mutex_unlock(&workqueue_mutex);
> 
> Lets say we release the workqueue mutex here (events/4 is trying to
> flush its own workqueue). Immediately another CPU takes this mutex 
> (in CPU_DOWN_PREPARE) and brings down CPU4. In CPU_DEAD handling we now wait 
> on events/4 thread to exit (cleanup_workqueue_thread).
> 
> Couldnt this wait deadlock on :
> 
> >  		run_workqueue(cwq);
> 
> > +		if (cpu != -1)
> > +			mutex_lock(&workqueue_mutex);
> 
> events/4 thread itself wanting the same mutex above?
> 

Could do, not sure.  I'm planning on converting all the locking around here
to preempt_disable() though.

