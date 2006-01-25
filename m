Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWAYNbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWAYNbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 08:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWAYNbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 08:31:52 -0500
Received: from ns1.suse.de ([195.135.220.2]:1442 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750929AbWAYNbw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 08:31:52 -0500
From: Andi Kleen <ak@suse.de>
To: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
Date: Wed, 25 Jan 2006 14:31:15 +0100
User-Agent: KMail/1.8.2
Cc: pravin shelar <pravins@calsoftinc.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s> <43D50445.1080208@cosmosbay.com> <43D50880.605@cosmosbay.com>
In-Reply-To: <43D50880.605@cosmosbay.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_k231D2GDh1JFmkA"
Message-Id: <200601251431.16513.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_k231D2GDh1JFmkA
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 23 January 2006 17:46, Eric Dumazet wrote:
> 
> Sorry for the first version of he patch. I did one change, in order to do the 
> initialization only for !possible cpu
> 
> [PATCH] x86_64 : Use a special CPUDATA_RED_ZONE to catch accesses to 
> per_cpu(some_object, some_not_possible_cpu)
> 
> Because cpu_data(cpu)->data_offset may contain garbage, some buggy code may do 
> random things without notice. If we initialize data_offset so that the 
> per_cpu() data sits in an unmapped memory area, we should get page faults and 
> stack traces should help us find the bugs.
> 
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

With that patch sched_init gives an early exception. I don't think
we can fix up all cases before 2.6.16, but it's dangerous
to let it reference freed memory.

I think the best course of action for this now for 2.6.16 is:

- mark percpu init data not __init
(this way it will still reference valid memory, although shared between
all impossible CPUs)
- keep the impossible CPUs per cpu data to point to the original reference  
version (== offset 0)

For 2.6.17 all the occurrences of NR_CPUS should be audited
and fixed up like you started in your earlier patch.

Like the attached patch.

-Andi


--Boundary-00=_k231D2GDh1JFmkA
Content-Type: text/x-diff;
  charset="utf-8";
  name="impossible-per-cpu-data-workaround"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="impossible-per-cpu-data-workaround"

Let impossible CPUs point to reference per cpu data

Hack for 2.6.16. In 2.6.17 all code that uses NR_CPUs should
be audited and changed to only touch possible CPUs.

Don't mark the reference per cpu data init data (so it stays
around after boot) and point all impossible CPUs to it. This way
they reference some valid - although shared memory. Usually
this is only initialization like INIT_LIST_HEADs and there
won't be races because these CPUs never run. Still somewhat hackish.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/x86_64/kernel/setup64.c
===================================================================
--- linux.orig/arch/x86_64/kernel/setup64.c
+++ linux/arch/x86_64/kernel/setup64.c
@@ -99,8 +99,15 @@ void __init setup_per_cpu_areas(void)
 		size = PERCPU_ENOUGH_ROOM;
 #endif
 
-	for_each_cpu_mask (i, cpu_possible_map) {
+	for (i = 0; i < NR_CPUS; i++) { 
 		char *ptr;
+		
+		/* Later set this to a unmapped area, but first 
+		   need to clean up NR_CPUS usage everywhere */
+		if (!cpu_possible(i)) {	
+			/* Point the the original reference data */
+			cpu_pda(i)->data_offset = 0;
+		}
 
 		if (!NODE_DATA(cpu_to_node(i))) {
 			printk("cpu with no node %d, num_online_nodes %d\n",
Index: linux/arch/x86_64/kernel/vmlinux.lds.S
===================================================================
--- linux.orig/arch/x86_64/kernel/vmlinux.lds.S
+++ linux/arch/x86_64/kernel/vmlinux.lds.S
@@ -172,13 +172,16 @@ SECTIONS
   . = ALIGN(4096);
   __initramfs_start = .;
   .init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) { *(.init.ramfs) }
-  __initramfs_end = .;	
+ /* temporary here to work around NR_CPUS. If you see this comment in 2.6.17+
+   complain */ 
+ __initramfs_end = .;	
+  . = ALIGN(4096);
+  __init_end = .;	
   . = ALIGN(32);
   __per_cpu_start = .;
   .data.percpu  : AT(ADDR(.data.percpu) - LOAD_OFFSET) { *(.data.percpu) }
   __per_cpu_end = .;
-  . = ALIGN(4096);
-  __init_end = .;
+  /* __init_end / ALIGN(4096) should be here */
 
   . = ALIGN(4096);
   __nosave_begin = .;

--Boundary-00=_k231D2GDh1JFmkA--
