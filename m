Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261510AbVFGHHt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261510AbVFGHHt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 03:07:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVFGHHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 03:07:49 -0400
Received: from fmr20.intel.com ([134.134.136.19]:53418 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261510AbVFGHHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 03:07:09 -0400
Subject: Re: [patch 4/5] try2: x86_64: Dont use broadcast shortcut to make
	it cpu hotplug safe.
From: Shaohua Li <shaohua.li@intel.com>
To: Ashok Raj <ashok.raj@intel.com>
Cc: akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>, x86-64 <discuss@x86-64.org>,
       Rusty Russell <rusty@rustycorp.com.au>, ak <ak@muc.de>
In-Reply-To: <20050606192113.307745000@araj-em64t>
References: <20050606191433.104273000@araj-em64t>
	 <20050606192113.307745000@araj-em64t>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 15:13:30 +0800
Message-Id: <1118128410.3949.3.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-06 at 12:14 -0700, Ashok Raj wrote:
> plain text document attachment (no_broadcast_ipi.patch)
> Broadcast IPI's provide un-expected behaviour for cpu hotplug. CPU's in offline
> state also end up receiving the IPI. Once the cpus become online
> they receive these stale IPI's which are bad and introduce unexpected
> behaviour. 
> 
> This is easily avoided by not sending a broadcast and addressing just the 
> CPU's in online map.  Doing prelim cycle counts it appears there is no big 
> overhead and numbers seem around 0x3000-0x3900 on an average on x86 and x86_64 
> systems with CPUS running 3G, both for broadcast and mask version of the API's. 
> 
> The shortcuts are useful only for flat mode (where the perf shows no 
> degradation), and in cluster mode, its unicast anyway. Its simpler 
> to just not use broadcast anymore.
With the patch. smp_call_function still has race. It accesses
cpu_online_map twice. First calculate online cpu counter and second,
send the ipi, so it's not atomic. We should do something like this:

Thanks,
Shaohua

--- a/arch/i386/kernel/smp.c	2005-04-26 08:47:08.000000000 +0800
+++ b/arch/i386/kernel/smp.c	2005-05-31 16:37:10.565141944 +0800
@@ -527,10 +527,13 @@ int smp_call_function (void (*func) (voi
 {
 	struct call_data_struct data;
 	int cpus;
+	cpumask_t mask;
 
 	/* Holding any lock stops cpus from going down. */
 	spin_lock(&call_lock);
-	cpus = num_online_cpus()-1;
+	mask = cpu_online_map;
+	cpu_clear(smp_processor_id(), mask);
+	cpus = cpus_weight(mask);
 
 	if (!cpus) {
 		spin_unlock(&call_lock);
@@ -551,7 +554,7 @@ int smp_call_function (void (*func) (voi
 	mb();
 	
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)
--- a/arch/x86_64/kernel/smp.c	2005-04-12 10:12:16.000000000 +0800
+++ b/arch/x86_64/kernel/smp.c	2005-05-31 16:38:07.613469280 +0800
@@ -303,8 +303,11 @@ static void __smp_call_function (void (*
 				int nonatomic, int wait)
 {
 	struct call_data_struct data;
-	int cpus = num_online_cpus()-1;
+	int cpus;
+	cpumask_t mask = cpu_online_map;
 
+	cpu_clear(smp_processor_id(), mask);
+	cpus = cpus_weight(mask);
 	if (!cpus)
 		return;
 
@@ -318,7 +321,7 @@ static void __smp_call_function (void (*
 	call_data = &data;
 	wmb();
 	/* Send a message to all other CPUs and wait for them to respond */
-	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
+	send_IPI_mask(mask, CALL_FUNCTION_VECTOR);
 
 	/* Wait for response */
 	while (atomic_read(&data.started) != cpus)


