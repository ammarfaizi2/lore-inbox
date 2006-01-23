Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWAWQ3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWAWQ3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 11:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWAWQ3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 11:29:44 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:45499 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S1751491AbWAWQ3n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 11:29:43 -0500
Message-ID: <43D50445.1080208@cosmosbay.com>
Date: Mon, 23 Jan 2006 17:28:53 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: pravin shelar <pravins@calsoftinc.com>,
       Ravikiran G Thirumalai <kiran@scalex86.org>,
       Shai Fultheim <shai@scalex86.org>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] garbage values in file /proc/net/sockstat
References: <Pine.LNX.4.63.0601231206270.2192@pravin.s> <200601231224.16196.ak@suse.de> <43D4DA15.4010009@cosmosbay.com> <200601231611.51326.ak@suse.de>
In-Reply-To: <200601231611.51326.ak@suse.de>
Content-Type: multipart/mixed;
 boundary="------------060106070403080906010605"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 23 Jan 2006 17:28:53 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060106070403080906010605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Andi Kleen a écrit :
> On Monday 23 January 2006 14:28, Eric Dumazet wrote:
> 
>> Shouldnt we force a page fault for not possible cpus in cpu_data
>> to catch all access to per_cpu(some_object, some_not_possible_cpu) ?
>>
>> We can use a red zone big enough to hold the whole per_cpu data.
> 
> Good idea. Can you please send me a tested patch?
> 

I did a patch (on top of 2.6.16-rc1-mm2) , but the kernel crashes in 
sched_init(void)

for (i = 0; i < NR_CPUS; i++) {
	prio_array_t *array;
	rq = cpu_rq(i);
	spin_lock_init(&rq->lock);  <<-CRASH


In my config, NR_CPUS = 8, and I have one only one CPU inside my test box.

So should I send only the patch or all the corrections I have to do to avoid 
all possible crashes in my config ?

Thank you
Eric Dumazet

[PATCH] x86_64 : Use a special CPUDATA_RED_ZONE to catch accesses to 
per_cpu(some_object, some_not_possible_cpu)

Because cpu_data(cpu)->data_offset may contain garbage, some buggy code may do 
random things without notice. If we initialize data_offset so that the 
per_cpu() data sits in an unmapped memory area, we should get page faults and 
stack traces should help us find the bugs.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>



--------------060106070403080906010605
Content-Type: text/plain;
 name="cpudata_red_zone.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpudata_red_zone.patch"

--- linux-2.6.16-rc1/Documentation/x86_64/mm.txt	2006-01-17 08:44:47.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/Documentation/x86_64/mm.txt	2006-01-23 16:54:46.000000000 +0100
@@ -5,7 +5,8 @@
 
 0000000000000000 - 00007fffffffffff (=47bits) user space, different per mm
 hole caused by [48:63] sign extension
-ffff800000000000 - ffff80ffffffffff (=40bits) guard hole
+ffff800000000000 - ffff807fffffffff (=39bits) guard hole
+ffff808000000000 - ffff80ffffffffff (=39bits) not possible cpus percpudata hole
 ffff810000000000 - ffffc0ffffffffff (=46bits) direct mapping of all phys. memory
 ffffc10000000000 - ffffc1ffffffffff (=40bits) hole
 ffffc20000000000 - ffffe1ffffffffff (=45bits) vmalloc/ioremap space
--- linux-2.6.16-rc1/include/asm-x86_64/pgtable.h	2006-01-17 08:44:47.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/include/asm-x86_64/pgtable.h	2006-01-23 16:54:46.000000000 +0100
@@ -136,6 +136,7 @@
 
 #ifndef __ASSEMBLY__
 #define MAXMEM		 0x3fffffffffffUL
+#define CPUDATA_RED_ZONE 0xffff808000000000UL
 #define VMALLOC_START    0xffffc20000000000UL
 #define VMALLOC_END      0xffffe1ffffffffffUL
 #define MODULES_VADDR    0xffffffff88000000UL
--- linux-2.6.16-rc1/arch/x86_64/kernel/setup64.c	2006-01-23 16:36:38.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/arch/x86_64/kernel/setup64.c	2006-01-23 16:58:30.000000000 +0100
@@ -99,9 +99,13 @@
 		size = PERCPU_ENOUGH_ROOM;
 #endif
 
-	for_each_cpu_mask (i, cpu_possible_map) {
+	for (i = 0 ; i < NR_CPUS ; i++) {
 		char *ptr;
 
+		cpu_pda(i)->data_offset = (char *)CPUDATA_RED_ZONE - __per_cpu_start;
+		if (!cpu_possible(i))
+			continue;
+
 		if (!NODE_DATA(cpu_to_node(i))) {
 			printk("cpu with no node %d, num_online_nodes %d\n",
 			       i, num_online_nodes());

--------------060106070403080906010605--
