Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVCBBrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVCBBrQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 20:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVCBBrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 20:47:16 -0500
Received: from orb.pobox.com ([207.8.226.5]:50320 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262007AbVCBBrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 20:47:08 -0500
Date: Tue, 1 Mar 2005 19:47:01 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org, zwane@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH] explicitly bind idle tasks
Message-ID: <20050302014701.GA5897@otto>
References: <Pine.LNX.4.61.0502010009010.3010@montezuma.fsmlabs.com> <20050227031655.67233bb5.akpm@osdl.org> <1109542971.14993.217.camel@gaston> <20050227144928.6c71adaf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050227144928.6c71adaf.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2005 at 02:49:28PM -0800, Andrew Morton wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >
> > > -		if (cpu_is_offline(smp_processor_id()) &&
> >  > +		if (cpu_is_offline(_smp_processor_id()) &&
> >  >  		    system_state == SYSTEM_RUNNING)
> >  >  			cpu_die();
> >  >  	}
> >  > _
> > 
> >  This is the idle loop. Is that ever supposed to be preempted ?
> 
> Nope, it's a false positive.  We had to do the same in x86's idle loop and
> probably others will hit it.

Perhaps I'm missing something, but is there any reason we can't do
the following?  I've tested it on ppc64, doesn't seem to break anything.

With hotplug cpu and preempt, we tend to see smp_processor_id warnings
from idle loop code because it's always checking whether its cpu has
gone offline.  Replacing every use of smp_processor_id with
_smp_processor_id in all idle loop code is one solution; another way
is explicitly binding idle threads to their cpus (the smp_processor_id
warning does not fire if the caller is bound only to the calling cpu).
This has the (admittedly slight) advantage of letting us know if an
idle thread ever runs on the wrong cpu.


Signed-off-by: Nathan Lynch <ntl@pobox.com>

Index: linux-2.6.11-rc5-mm1/init/main.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/init/main.c	2005-03-02 00:12:07.000000000 +0000
+++ linux-2.6.11-rc5-mm1/init/main.c	2005-03-02 00:53:04.000000000 +0000
@@ -638,6 +638,10 @@
 {
 	lock_kernel();
 	/*
+	 * init can run on any cpu.
+	 */
+	set_cpus_allowed(current, CPU_MASK_ALL);
+	/*
 	 * Tell the world that we're going to be the grim
 	 * reaper of innocent orphaned children.
 	 *
Index: linux-2.6.11-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.11-rc5-mm1.orig/kernel/sched.c	2005-03-02 00:12:07.000000000 +0000
+++ linux-2.6.11-rc5-mm1/kernel/sched.c	2005-03-02 00:47:14.000000000 +0000
@@ -4092,6 +4092,7 @@
 	idle->array = NULL;
 	idle->prio = MAX_PRIO;
 	idle->state = TASK_RUNNING;
+	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
 
 	spin_lock_irqsave(&rq->lock, flags);
