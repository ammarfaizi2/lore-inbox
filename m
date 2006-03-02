Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752114AbWCCBQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752114AbWCCBQI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbWCCBQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:16:08 -0500
Received: from fmr22.intel.com ([143.183.121.14]:4577 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752114AbWCCBQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:16:06 -0500
Subject: RE: [Patch] Move swiotlb_init early on X86_64
From: Zou Nan hai <nanhai.zou@intel.com>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Andi Kleen <ak@suse.de>, "Luck, Tony" <tony.luck@intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A441C94D@pdsmsx404>
References: <117E3EB5059E4E48ADFF2822933287A441C94D@pdsmsx404>
Content-Type: text/plain; charset=UTF-8
Organization: 
Message-Id: <1141342529.2537.11.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 03 Mar 2006 07:35:29 +0800
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-02 at 17:09, Zhang, Yanmin wrote:
> >>-----Original Message-----
> >>From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Zou Nan hai
> >>Sent: 2006年3月2日 12:33
> >>
> >>Really, then how about the following patch?
> >>
> >>Let normal bootmem allocator go above 4G first.
> >>This will save more memory with address less than 4G.
> >>
> >>Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>
> >>
> >>--- linux-2.6.16-rc5/mm/bootmem.c	2006-03-03 08:31:52.000000000 +0800
> >>+++ b/mm/bootmem.c	2006-03-03 09:05:17.000000000 +0800
> >>@@ -381,16 +381,24 @@ unsigned long __init free_all_bootmem (v
> >> 	return(free_all_bootmem_core(NODE_DATA(0)));
> >> }
> >>
> >>+#define LOW32LIMIT 0xffffffff
> >>+
> >> void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
> >> {
> >> 	pg_data_t *pgdat = pgdat_list;
> >> 	void *ptr;
> >>
> >>+	if (goal < LOW32LIMIT) {
> On i386, above is always true.
> 
> 

Ok, I modified the patch.

On single node SMP System with large physical memory, 
allocation from bootmem allocator like memmap and vfs_cache 
may eat up usable memory under 4G, then software I/O TLB will not be able to allocate bounce buffer.

This patch modify the bootmem allocator,
let normal bootmem allocation on 64 bit system first go above 4G
address.

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

--- linux-2.6.16-rc5/mm/bootmem.c	2006-03-03 08:31:52.000000000 +0800
+++ b/mm/bootmem.c	2006-03-04 03:48:55.000000000 +0800
@@ -381,16 +381,25 @@ unsigned long __init free_all_bootmem (v
 	return(free_all_bootmem_core(NODE_DATA(0)));
 }
 
+#define LOW32LIMIT 0xffffffff
+
 void * __init __alloc_bootmem(unsigned long size, unsigned long align, unsigned long goal)
 {
 	pg_data_t *pgdat = pgdat_list;
 	void *ptr;
 
+#if (BITS_PER_LONG == 64)
+	if (goal < LOW32LIMIT) {
+		for_each_pgdat(pgdat)
+			if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
+						 align, LOW32LIMIT, 0)))
+			return(ptr);
+	}
+#endif
 	for_each_pgdat(pgdat)
 		if ((ptr = __alloc_bootmem_core(pgdat->bdata, size,
 						 align, goal, 0)))
 			return(ptr);
-
 	/*
 	 * Whoops, we cannot satisfy the allocation request.
 	 */
@@ -404,6 +413,14 @@ void * __init __alloc_bootmem_node(pg_da
 				   unsigned long goal)
 {
 	void *ptr;
+#if (BITS_PER_LONG == 64)
+	if (goal < LOW32LIMIT) {
+		ptr = __alloc_bootmem_core(pgdat->bdata, size, align,
+				LOW32LIMIT, 0);
+		if (ptr)
+			return (ptr);
+	}
+#endif
 
 	ptr = __alloc_bootmem_core(pgdat->bdata, size, align, goal, 0);
 	if (ptr)
@@ -412,7 +429,6 @@ void * __init __alloc_bootmem_node(pg_da
 	return __alloc_bootmem(size, align, goal);
 }
 
-#define LOW32LIMIT 0xffffffff
 
 void * __init __alloc_bootmem_low(unsigned long size, unsigned long align, unsigned long goal)
 {






 

