Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWIUR2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWIUR2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWIUR2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 13:28:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33494 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751368AbWIUR2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 13:28:30 -0400
Date: Thu, 21 Sep 2006 10:28:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: Re: 2.6.18-rc7-mm1 -- ppc64 crash in slab_node ??
Message-Id: <20060921102823.628a2a74.akpm@osdl.org>
In-Reply-To: <45128F94.1080502@shadowen.org>
References: <20060919012848.4482666d.akpm@osdl.org>
	<45128F94.1080502@shadowen.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2006 14:11:48 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> Hmmm seeing this on a ppc64 lpar.
> 
> PID hash table entries: 4096 (order: 12, 32768 bytes)
> Console: colour dummy device 80x25
> Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
> Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
> freeing bootmem node 0
> freeing bootmem node 1
> Memory: 2042288k/2097152k available (5752k kernel code, 55392k reserved,
> 1456k data, 875k bss, 252k init)
> Unable to handle kernel paging request for data at address 0x00000004
> Faulting instruction address: 0xc0000000000bc830
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=128 NUMA
> Modules linked in:
> NIP: C0000000000BC830 LR: C0000000000C7DF4 CTR: 0000000000000000
> REGS: c00000000070f990 TRAP: 0300   Not tainted  (2.6.18-rc7-mm1-autokern1)
> MSR: 8000000000001032 <ME,IR,DR>  CR: 24004022  XER: 0000000B
> DAR: 0000000000000004, DSISR: 0000000040000000
> TASK = c0000000005c0900[0] 'swapper' THREAD: c00000000070c000 CPU: 0
> GPR00: C0000000000C80DC C00000000070FC10 C00000000070B1A0 0000000000000000
> GPR04: 00000000000000D0 0000000000000000 0000000000000000 0000000000000042
> GPR08: 0000000000000000 C0000000005C0900 0000000000000000 C00000007FFF3800
> GPR12: 0000000024004022 C0000000005C1480 0000000000000000 0000000000000000
> GPR16: 0000000000000000 0000000000000000 0000000000000000 4000000001C00000
> GPR20: 0000000000000000 0000000000000000 0000000000141000 C0000000004DA2D0
> GPR24: 000000000199FB40 0000000000000000 0000000000042000 C0000000005F31A8
> GPR28: C0000000005F31A8 C0000000007416E8 C0000000005FCC60 00000000000000D0
> NIP [C0000000000BC830] .slab_node+0x10/0x78
> LR [C0000000000C7DF4] .fallback_alloc+0x3c/0x100
> Call Trace:
> [C00000000070FC10] [8000000000001032] 0x8000000000001032 (unreliable)
> [C00000000070FCB0] [C0000000000C80DC] .kmem_cache_zalloc+0x128/0x150
> [C00000000070FD50] [C0000000000C90BC] .kmem_cache_create+0x2a0/0x6ac
> [C00000000070FE30] [C00000000057BF90] .kmem_cache_init+0x1b4/0x4f8
> [C00000000070FEF0] [C00000000055F7BC] .start_kernel+0x214/0x33c
> [C00000000070FF90] [C0000000000084F4] .start_here_common+0x50/0x5c
> Instruction dump:
> 7fc3f378 60000000 e8010010 eba1ffe8 ebc1fff0 ebe1fff8 7c0803a6 4e800020
> fbc1fff0 ebc2ce20 60000000 60000000 <a8030004> 2f800002 419e0038 2c800001
>  <0>Kernel panic - not syncing: Attempted to kill the idle task!
> 
> Given all the problems with -mm1 I'm not sure how hard to search for this.
> 

I guess the below will fix it.  But Christoph's machine would have oopsed
too, if it had called fallback_alloc() this early.  So presumably it did
not.  But yours does.  I wonder why?


diff -puN mm/slab.c~gfp_thisnode-for-the-slab-allocator-v2-fix-2 mm/slab.c
--- a/mm/slab.c~gfp_thisnode-for-the-slab-allocator-v2-fix-2
+++ a/mm/slab.c
@@ -3103,17 +3103,21 @@ static void *alternate_node_alloc(struct
 
 /*
  * Fallback function if there was no memory available and no objects on a
- * certain node and we are allowed to fall back. We mimick the behavior of
+ * certain node and we are allowed to fall back. We mimic the behavior of
  * the page allocator. We fall back according to a zonelist determined by
  * the policy layer while obeying cpuset constraints.
  */
 void *fallback_alloc(struct kmem_cache *cache, gfp_t flags)
 {
-	struct zonelist *zonelist = &NODE_DATA(slab_node(current->mempolicy))
-					->node_zonelists[gfp_zone(flags)];
+	struct zonelist *zonelist;
 	struct zone **z;
 	void *obj = NULL;
 
+	if (!current->mempolicy)
+		return NULL;
+
+	zonelist = &NODE_DATA(slab_node(current->mempolicy))
+					->node_zonelists[gfp_zone(flags)];
 	for (z = zonelist->zones; *z && !obj; z++)
 		if (zone_idx(*z) <= ZONE_NORMAL &&
 				cpuset_zone_allowed(*z, flags))
_

