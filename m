Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266247AbUF0FcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUF0FcM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 01:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUF0FcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 01:32:12 -0400
Received: from ozlabs.org ([203.10.76.45]:62658 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266247AbUF0Fbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 01:31:35 -0400
Date: Sun, 27 Jun 2004 15:27:47 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: [PATCH] __alloc_bootmem_node should not panic when it fails
Message-ID: <20040627052747.GG23589@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


__alloc_bootmem_node currently panics if it cant satisfy an allocation
for a particular node. Thats rather antisocial, we should at the very
least return NULL and allow the caller to proceed (eg try another node).

A quick look at alloc_bootmem_node usage suggests we should fall back to
allocating from other nodes if it fails (as arch/alpha/kernel/pci_iommu.c
and arch/x86_64/kernel/setup64.c do).

The following patch does that. We fall back to the regular
__alloc_bootmem when __alloc_bootmem_node fails, which means all other
nodes are checked for available memory.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN mm/bootmem.c~debugit mm/bootmem.c
--- gr_work/mm/bootmem.c~debugit	2004-06-06 21:49:20.729826223 -0500
+++ gr_work-anton/mm/bootmem.c	2004-06-06 22:07:16.840243987 -0500
@@ -371,11 +371,6 @@ void * __init __alloc_bootmem_node (pg_d
 	if (ptr)
 		return (ptr);
 
-	/*
-	 * Whoops, we cannot satisfy the allocation request.
-	 */
-	printk(KERN_ALERT "bootmem alloc of %lu bytes failed!\n", size);
-	panic("Out of memory");
-	return NULL;
+	return __alloc_bootmem(size, align, goal);
 }
 

_
