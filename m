Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbWCBGN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWCBGN6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 01:13:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWCBGN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 01:13:58 -0500
Received: from fmr20.intel.com ([134.134.136.19]:36522 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751362AbWCBGN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 01:13:57 -0500
Subject: Re: [Patch] Move swiotlb_init early on X86_64
From: Zou Nan hai <nanhai.zou@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Tony Luck <tony.luck@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
In-Reply-To: <200603020530.09552.ak@suse.de>
References: <1141175458.2642.78.camel@linux-znh>
	 <12c511ca0603012015g7a5bfa8dw4295c59f5dace4f9@mail.gmail.com>
	 <200603020530.09552.ak@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1141274003.2642.1400.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 Mar 2006 12:33:23 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 12:30, Andi Kleen wrote:
> On Thursday 02 March 2006 05:15, Tony Luck wrote:
> > On 01 Mar 2006 09:10:58 +0800, Zou Nan hai <nanhai.zou@intel.com> wrote:
> > > on X86_64, swiotlb buffer is allocated in mem_init, after memmap and vfs cache allocation.
> > >
> > > On platforms with huge physical memory,
> > > large memmap and vfs cache may eat up all usable system memory
> > > under 4G.
> > >
> > > Move swiotlb_init early before memmap is allocated can
> > > solve this issue.
> > 
> > Shouldn't memmap be allocated from memory above 4G (if available)? Using
> > up lots of <4G memory on something that doesn't need to be below 4G
> > sounds like a poor use of resources.
> 
> On the really large machines it will be distributed over the nodes anyways.
> But yes the single node SMP case should probably allocate it higher.
> 
> -Andi

Really, then how about the following patch?

Let normal bootmem allocator go above 4G first.
This will save more memory with address less than 4G.

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

--- linux-2.6.16-rc5/mm/bootmem.c	2006-03-03 08:31:52.000000000 +0800
+++ b/mm/bootmem.c	2006-03-03 09:05:17.000000000 +0800
@@ -381,16 +381,24 @@ unsigned long __init free_all_bootmem (v
 	return(free_all_bootmem_core(NODE_DATA(0)));
 }
 
+#define LOW32LIMIT 0xffffffff
+
 void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
 {
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
 
+	if (goal < LOW32LIMIT) {
+		for_each_pgdat(pgdat)
+			if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
+						 align, LOW32LIMIT, 0)))
+			return(ptr);
+	}
+
 	for_each_pgdat(pgdat)
 		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
 						 align, goal, 0)))
 			return(ptr);
-
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
 	 */
@@ -405,6 +413,13 @@ void * __init __alloc_bootmem_node(pg_da
 {
 	void *ptr;
 
+	if (goal < LOW32LIMIT) {
+		ptr = __alloc_bootmem_core(pgdat->bdata, size, align,
+				LOW32LIMIT, 0);
+		if (ptr)
+			return (ptr);
+	}
+
 	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0);
 	if (ptr)
 		return (ptr);
@@ -412,7 +427,6 @@ void * __init __alloc_bootmem_node(pg_da
 	return __alloc_bootmem(size, align, goal);
 }
 
-#define LOW32LIMIT 0xffffffff
 
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
 {





