Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262986AbUJ1MQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbUJ1MQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 08:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbUJ1MQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 08:16:05 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:46722
	"EHLO ladymac.shadowen.org") by vger.kernel.org with ESMTP
	id S262992AbUJ1MMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 08:12:20 -0400
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bootmem use NODE_DATA
Cc: apw@shadowen.org
Message-Id: <E1CN98F-0006Ri-5p@ladymac.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Thu, 28 Oct 2004 13:11:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whilst looking at simplifying the implmentation of i386 initialisation
code I noticed the following.  This change allows these routines to be
used in both node based and flat memory models which allows more of the
init code to be common in these models.

-apw

=== 8< ===
Convert the default non-node based bootmem routines to use
NODE_DATA(0).  This is semantically and functionally identical in
any non-node configuration as NODE_DATA(x) is defined as below.

#define NODE_DATA(nid)          (&contig_page_data)

For the node cases (CONFIG_NUMA and CONFIG_DISCONTIG_MEM) we can
use these non-node forms where all boot memory is defined on node 0.

Revision: $Rev: 732 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat 050-bootmem-use-NODE_DATA
---
 bootmem.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff -upN reference/mm/bootmem.c current/mm/bootmem.c
--- reference/mm/bootmem.c
+++ current/mm/bootmem.c
@@ -343,31 +343,29 @@ unsigned long __init free_all_bootmem_no
 	return(free_all_bootmem_core(pgdat));
 }
 
-#ifndef CONFIG_DISCONTIGMEM
 unsigned long __init init_bootmem (unsigned long start, unsigned long pages)
 {
 	max_low_pfn = pages;
 	min_low_pfn = start;
-	return(init_bootmem_core(&contig_page_data, start, 0, pages));
+	return(init_bootmem_core(NODE_DATA(0), start, 0, pages));
 }
 
 #ifndef CONFIG_HAVE_ARCH_BOOTMEM_NODE
 void __init reserve_bootmem (unsigned long addr, unsigned long size)
 {
-	reserve_bootmem_core(contig_page_data.bdata, addr, size);
+	reserve_bootmem_core(NODE_DATA(0)->bdata, addr, size);
 }
 #endif /* !CONFIG_HAVE_ARCH_BOOTMEM_NODE */
 
 void __init free_bootmem (unsigned long addr, unsigned long size)
 {
-	free_bootmem_core(contig_page_data.bdata, addr, size);
+	free_bootmem_core(NODE_DATA(0)->bdata, addr, size);
 }
 
 unsigned long __init free_all_bootmem (void)
 {
-	return(free_all_bootmem_core(&contig_page_data));
+	return(free_all_bootmem_core(NODE_DATA(0)));
 }
-#endif /* !CONFIG_DISCONTIGMEM */
 
 void * __init __alloc_bootmem (unsigned long size, unsigned long align, unsigned long goal)
 {
