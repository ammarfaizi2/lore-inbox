Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUJXSYC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUJXSYC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 14:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbUJXSYC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 14:24:02 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:59986 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261576AbUJXSX6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 14:23:58 -0400
Date: Sun, 24 Oct 2004 11:18:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, karim@opersys.com,
       Dimitri Sivanich <sivanich@sgi.com>
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041024181842.GB1262@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041023194721.GB1268@us.ibm.com> <20041023201724.GA23936@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041023201724.GA23936@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 23, 2004 at 10:17:24PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> 
> > +	bool "Reserve a CPU for hard realtime processes"
> 
> this has been implemented in a clean way already: check out the
> "isolcpus=" boot option & scheduler feature (implemented by Dimitri
> Sivanich) which isolates a set of CPUs via sched-domains for precisely
> such purposes. The way to enter such a domain is via the affinity
> syscall - and balancing will leave such domains isolated.

Thanks again for the pointer, am slowly getting my head around this.
I haven't proven to myself that the isolcpus code gets rid of all of the
cross-runqueue lock acquisitions, but it certainly gets rid of a large
number of them.  It doesn't seem to do system-call or exception-handler
offload, but it does help me see how to do this sort of thing cleanly.

Dimitri, one nit so far...   Why is sched_domain_dummy under two
layers of #ifdef CONFIG_SMP?  Any reason why the attached patch
would not be in order?

						Thanx, Paul

diff -urpN -X ../dontdiff linux-2.5-2004.10.23/kernel/sched.c linux-2.5-2004.10.23-LBinf/kernel/sched.c
--- linux-2.5-2004.10.23/kernel/sched.c	Sat Oct 23 13:23:31 2004
+++ linux-2.5-2004.10.23-LBinf/kernel/sched.c	Sun Oct 24 10:50:12 2004
@@ -4437,14 +4437,12 @@ static void sched_domain_debug(void)
 #define sched_domain_debug() {}
 #endif
 
-#ifdef CONFIG_SMP
 /*
  * Initial dummy domain for early boot and for hotplug cpu. Being static,
  * it is initialized to zero, so all balancing flags are cleared which is
  * what we want.
  */
 static struct sched_domain sched_domain_dummy;
-#endif
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
