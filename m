Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVJDMn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVJDMn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 08:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVJDMnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 08:43:10 -0400
Received: from mailgate2.urz.uni-halle.de ([141.48.3.8]:26595 "EHLO
	mailgate2.uni-halle.de") by vger.kernel.org with ESMTP
	id S932414AbVJDMm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 08:42:59 -0400
Date: Tue, 04 Oct 2005 14:41:32 +0200 (MEST)
From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH 1/7] HPET: Fix mmap() of /dev/hpet
In-reply-to: <20051004124126.23057.75614.schnuffi@turing>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Bob Picco <bob.picco@hp.com>,
       Clemens Ladisch <clemens@ladisch.de>
Message-id: <20051004124132.23057.29853.schnuffi@turing>
Content-transfer-encoding: 7BIT
References: <20051004124126.23057.75614.schnuffi@turing>
X-Scan-Signature: ddcb1167275539a271faf4605d0b8e77
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keir Fraser <keir@xensource.com>

The address passed to io_remap_pfn_range() in hpet_mmap() does not
need to be converted using __pa(): it is already a physical
address. This bug was found and the patch suggested by Clay Harris.

I introduced this particular bug when making io_remap_pfn_range
changes a few months ago. In fact mmap()ing /dev/hpet has *never*
previously worked: before my changes __pa() was being executed on an
ioremap()ed virtual address, which is also invalid.

Signed-off-by: Keir Fraser <keir@xensource.com>

Index: linux-2.6.13/drivers/char/hpet.c
===================================================================
--- linux-2.6.13.orig/drivers/char/hpet.c	2005-10-03 22:52:30.000000000 +0200
+++ linux-2.6.13/drivers/char/hpet.c	2005-10-03 22:53:09.000000000 +0200
@@ -279,7 +279,6 @@ static int hpet_mmap(struct file *file, 
 
 	vma->vm_flags |= VM_IO;
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	addr = __pa(addr);
 
 	if (io_remap_pfn_range(vma, vma->vm_start, addr >> PAGE_SHIFT,
 					PAGE_SIZE, vma->vm_page_prot)) {
