Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964982AbWAXOq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbWAXOq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 09:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWAXOq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 09:46:57 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:48358 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S964982AbWAXOq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 09:46:56 -0500
Message-ID: <43D63DB5.3010601@cosmosbay.com>
Date: Tue, 24 Jan 2006 15:46:13 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jan Beulich <JBeulich@novell.com>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, shai@scalex86.org, kiran@scalex86.org,
       pravins@calsoftinc.com
Subject: [PATCH] [SMP] reduce size of percpudata, and make sure per_cpu(object,
 not_possible_cpu) cause an invalid memory reference
References: <43CE4C98.76F0.0078.0@novell.com>	<20060120232500.07f0803a.akpm@osdl.org>	<43D4BE7F.76F0.0078.0@novell.com>	<20060123025702.1f116e70.akpm@osdl.org>	<43D5F44C.76F0.0078.0@novell.com> <20060124005806.7e9ab02e.akpm@osdl.org>
In-Reply-To: <20060124005806.7e9ab02e.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------040605090304060803060001"
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Tue, 24 Jan 2006 15:46:15 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040605090304060803060001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

percpu_data blindly allocates bootmem memory to store NR_CPUS instances of 
cpudata, instead of allocating memory only for possible cpus.

This patch saves ram, allocating num_possible_cpus() (instead of NR_CPUS) 
instances.

This patch also makes sure a reference to  per_cpu(object, not_possible_cpu) 
does a reference to invalid memory (NULL+small_offset).

As some architectures (x86_64) are now allocating cpudata only on possible 
cpus, we (kernel developers on x86 machines) should make sure that x86 does a 
similar thing to find bugs. This is important that this patch has some 
exposure in -mm for some time, some places must now use :

for_each_cpu(i) {
	... per_cpu(xxx,i) ...

instead of the traditional

for (i = 0 ; i < NR_CPUS ; i++)


Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--------------040605090304060803060001
Content-Type: text/plain;
 name="setup_per_cpu_areas.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setup_per_cpu_areas.patch"

--- linux-2.6.16-rc1-mm2/init/main.c	2006-01-24 15:45:28.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/init/main.c	2006-01-24 16:31:53.000000000 +0100
@@ -334,6 +334,7 @@
 {
 	unsigned long size, i;
 	char *ptr;
+	unsigned long nr_possible_cpus = num_possible_cpus();
 
 	/* Copy section for each CPU (we discard the original) */
 	size = ALIGN(__per_cpu_end - __per_cpu_start, SMP_CACHE_BYTES);
@@ -341,12 +342,16 @@
 	if (size < PERCPU_ENOUGH_ROOM)
 		size = PERCPU_ENOUGH_ROOM;
 #endif
+	ptr = alloc_bootmem(size * nr_possible_cpus);
 
-	ptr = alloc_bootmem(size * NR_CPUS);
-
-	for (i = 0; i < NR_CPUS; i++, ptr += size) {
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_possible(i)) {
+			__per_cpu_offset[i] = (char*)0 - __per_cpu_start;
+			continue;
+		}
 		__per_cpu_offset[i] = ptr - __per_cpu_start;
 		memcpy(ptr, __per_cpu_start, __per_cpu_end - __per_cpu_start);
+		ptr += size;
 	}
 }
 #endif /* !__GENERIC_PER_CPU */
--- linux-2.6.16-rc1-mm2/block/ll_rw_blk.c	2006-01-24 15:57:29.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/block/ll_rw_blk.c	2006-01-24 15:57:40.000000000 +0100
@@ -3536,7 +3536,7 @@
 	iocontext_cachep = kmem_cache_create("blkdev_ioc",
 			sizeof(struct io_context), 0, SLAB_PANIC, NULL, NULL);
 
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		INIT_LIST_HEAD(&per_cpu(blk_cpu_done, i));
 
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq, NULL);
--- linux-2.6.16-rc1-mm2/drivers/scsi/scsi.c	2006-01-24 16:04:28.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/drivers/scsi/scsi.c	2006-01-24 16:04:40.000000000 +0100
@@ -1245,7 +1245,7 @@
 	if (error)
 		goto cleanup_sysctl;
 
-	for (i = 0; i < NR_CPUS; i++)
+	for_each_cpu(i)
 		INIT_LIST_HEAD(&per_cpu(scsi_done_q, i));
 
 	devfs_mk_dir("scsi");
--- linux-2.6.16-rc1-mm2/net/core/utils.c	2006-01-24 16:14:40.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/net/core/utils.c	2006-01-24 16:16:37.000000000 +0100
@@ -121,7 +121,7 @@
 {
 	int i;
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
 		__net_srandom(state, i+jiffies);
 	}
@@ -133,7 +133,7 @@
 	unsigned long seed[NR_CPUS];
 
 	get_random_bytes(seed, sizeof(seed));
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct nrnd_state *state = &per_cpu(net_rand_state,i);
 		__net_srandom(state, seed[i]);
 	}
--- linux-2.6.16-rc1-mm2/net/core/dev.c	2006-01-24 16:24:24.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/net/core/dev.c	2006-01-24 16:24:46.000000000 +0100
@@ -3240,7 +3240,7 @@
 	 *	Initialise the packet receive queues.
 	 */
 
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_cpu(i) {
 		struct softnet_data *queue;
 
 		queue = &per_cpu(softnet_data, i);
--- linux-2.6.16-rc1-mm2/net/ipv4/proc.c	2006-01-24 16:18:13.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/net/ipv4/proc.c	2006-01-24 16:19:10.000000000 +0100
@@ -49,7 +49,7 @@
 	int res = 0;
 	int cpu;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		res += proto->stats[cpu].inuse;
 
 	return res;
--- linux-2.6.16-rc1-mm2/net/ipv6/proc.c	2006-01-24 16:18:40.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/net/ipv6/proc.c	2006-01-24 16:19:10.000000000 +0100
@@ -38,7 +38,7 @@
 	int res = 0;
 	int cpu;
 
-	for (cpu=0; cpu<NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		res += proto->stats[cpu].inuse;
 
 	return res;
--- linux-2.6.16-rc1-mm2/net/socket.c	2006-01-24 16:19:01.000000000 +0100
+++ linux-2.6.16-rc1-mm2-ed/net/socket.c	2006-01-24 16:19:10.000000000 +0100
@@ -2079,7 +2079,7 @@
 	int cpu;
 	int counter = 0;
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	for_each_cpu(cpu)
 		counter += per_cpu(sockets_in_use, cpu);
 
 	/* It can be negative, by the way. 8) */

--------------040605090304060803060001--
