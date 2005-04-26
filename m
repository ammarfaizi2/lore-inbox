Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVDZFVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVDZFVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 01:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVDZFVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 01:21:16 -0400
Received: from fmr18.intel.com ([134.134.136.17]:61315 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S261324AbVDZFUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 01:20:47 -0400
Subject: Re: [PATCH]broadcast IPI race condition on CPU hotplug
From: Li Shaohua <shaohua.li@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>
In-Reply-To: <Pine.LNX.4.61.0504252245530.26521@montezuma.fsmlabs.com>
References: <1114482044.7068.17.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.61.0504252222230.26521@montezuma.fsmlabs.com>
	 <1114489490.7416.2.camel@sli10-desk.sh.intel.com>
	 <Pine.LNX.4.61.0504252245530.26521@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1114492665.7416.10.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 26 Apr 2005 13:17:45 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Tue, 2005-04-26 at 12:47, Zwane Mwaikambo wrote:
> > > > After a CPU is booted but before it's officially up (set online map, and
> > > > enable interrupt), the CPU possibly will receive a broadcast IPI. After
> > > > it's up, it will handle the stale interrupt soon and maybe cause oops if
> > > > it's a smp-call-function-interrupt. This is quite possible in CPU
> > > > hotplug case, but nearly can't occur at boot time. Below patch replaces
> > > > broadcast IPI with send_ipi_mask just like the cluster mode.
> > > 
> > > Ok, but isn't it sufficient to use send_ipi_mask in smp_call_function 
> > > instead?
> > I'm not sure if other routines using broadcast IPI have this bug. Fixing
> > the send_ipi_all API looks more generic. Is there any reason we should
> > use broadcast IPI?
> 
> I'd prefer only touching smp_call_function because the others are 
> primitives, we should only be fixing the users of the primitives, 
> otherwise we'll end up with code which won't be as versatile.
Ok, here it it. It's against -mm tree.

Thanks,
Shaohua

Signed-off-by: Li Shaohua<shaohua.li@intel.com>

--- a/arch/i386/kernel/smp.c	2005-04-26 08:47:08.762344760 +0800
+++ b/arch/i386/kernel/smp.c	2005-04-26 13:05:44.558585200 +0800
@@ -527,6 +527,7 @@ int smp_call_function (void (*func) (voi
 {
 	struct call_data_struct data;
 	int cpus;
+	cpumask_t mask;
 
 	/* Holding any lock stops cpus from going down. */
 	spin_lock(&call_lock);
@@ -536,6 +537,8 @@ int smp_call_function (void (*func) (voi
 		spin_unlock(&call_lock);
 		return 0;
 	}
+	mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
 
 	/* Can deadlock when called with interrupts disabled */
 	WARN_ON(irqs_disabled());
@@ -551,7 +554,7 @@ int smp_call_function (void (*func) (voi
 	mb();
 	
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)
--- a/arch/x86_64/kernel/smp.c	2005-04-12 10:12:16.000000000 +0800
+++ b/arch/x86_64/kernel/smp.c	2005-04-26 13:07:26.715055056 +0800
@@ -304,10 +304,12 @@ static void __smp_call_function (void (*
 {
 	struct call_data_struct data;
 	int cpus = num_online_cpus()-1;
+	cpumask_t mask = cpu_online_map;
 
 	if (!cpus)
 		return;
 
+	cpu_clear(smp_processor_id(), mask);
 	data.func = func;
 	data.info = info;
 	atomic_set(&data.started, 0);
@@ -318,7 +320,7 @@ static void __smp_call_function (void (*
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)


