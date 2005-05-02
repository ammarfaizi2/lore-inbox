Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVEBRGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVEBRGd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 13:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVEBRGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 13:06:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:54720 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261598AbVEBRFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 13:05:17 -0400
Date: Mon, 2 May 2005 22:46:19 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Matthew Dobson <colpatch@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC PATCH] Dynamic sched domains (v0.5)
Message-ID: <20050502171619.GA4418@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20050501190947.GA5204@in.ibm.com> <4275F665.1010101@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4275F665.1010101@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 07:44:05PM +1000, Nick Piggin wrote:
> Dinakar Guniguntala wrote:
> 
> >+void rebuild_sched_domains(cpumask_t span1, cpumask_t span2)
> >+{
> >+	cpumask_t change_map;
> >+
> >+	cpus_or(change_map, span1, span2);
> >+
> >+	preempt_disable();
> 
> Oh, you can't do this here, attach_domains does a synchronize_kernel.
> So take it out, it doesn't do anything anyway, does it?

I put that in to prevent hangs with CONFIG_PREEMPT turned on, but
clearly didn't test it with preempt turned on. Looks like all I need to 
do here is a local_irq_disable

> 
> I suggest you also use some sort of locking to prevent concurrent rebuilds
> and rebuilds racing with cpu hotplug. You could probably have a static
> semaphore around rebuild_sched_domains, and take lock_cpu_hotplug here too.

I already do a lock_cpu_hotplug() in cpuset.c before calling 
rebuild_sched_domains and also am holding cpuset_sem, so that should take
care of both hotplug and concurrent rebuilds

	-Dinakar
