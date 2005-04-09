Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVDIJPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVDIJPv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 05:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVDIJPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 05:15:51 -0400
Received: from alephnull.demon.nl ([212.238.201.82]:50827 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S261216AbVDIJPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 05:15:45 -0400
Date: Sat, 9 Apr 2005 11:15:43 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: mj@ucw.cz, linux-kernel@vger.kernel.org
Cc: dsaxena@plexity.net
Subject: [PATCH] pci enumeration on ixp2000: overflow in kernel/resource.c
Message-ID: <20050409091543.GC13695@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please CC, not on the list)

Hi all,

IXP2000 (ARM-based) platforms use a separate 'struct resource' for PCI
MEM space.  Resource allocation for PCI BARs always fails because the
'root' resource (the IXP2000 PCI MEM resource) always has the entire
address space (00000000-ffffffff) free, and find_resource() calculates
the size of that range as ffffffff-00000000+1=0, so all allocations
fail because it thinks there is no space.

Comments?  Can find_resource ever be called with size=0?


cheers,
Lennert


diff -urN linux-2.6.11.orig/kernel/resource.c linux-2.6.11/kernel/resource.c
--- linux-2.6.11.orig/kernel/resource.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11/kernel/resource.c	2005-04-07 11:58:26.000000000 +0200
@@ -266,7 +266,7 @@
 		new->start = (new->start + align - 1) & ~(align - 1);
 		if (alignf)
 			alignf(alignf_data, new, size, align);
-		if (new->start < new->end && new->end - new->start + 1 >= size) {
+		if (new->start < new->end && new->end - new->start >= size - 1) {
 			new->end = new->start + size - 1;
 			return 0;
 		}


