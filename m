Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbUC1SXS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 13:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbUC1SXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 13:23:18 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:22736 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262322AbUC1SXM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 13:23:12 -0500
Date: Sun, 28 Mar 2004 12:22:23 -0600 (CST)
From: Olof Johansson <olof@austin.ibm.com>
To: akpm@osdl.org, <torvalds@osdl.org>
cc: benh@kernel.crashing.org, <gallatin@cs.duke.edu>,
       <linux-kernel@vger.kernel.org>, <linuxppc64-dev@lists.linuxppc.org>
Subject: [PATCH] ppc64: Fix thinko in iommu allocator
Message-ID: <Pine.A41.4.44.0403271906560.29488-100000@forte.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below patch fixes a bug in the iommu allocator that causes it to behave
strangely when a fair size of the table is allocated.

Thanks to Andrew Gallatin for finding this.


-Olof

===== arch/ppc64/kernel/iommu.c 1.4 vs edited =====
--- 1.4/arch/ppc64/kernel/iommu.c	Wed Mar 24 19:22:21 2004
+++ edited/arch/ppc64/kernel/iommu.c	Thu Mar 25 17:37:04 2004
@@ -100,12 +100,13 @@
 	end = n + npages;

 	if (unlikely(end >= limit)) {
-		if (likely(pass++ < 2)) {
+		if (likely(pass < 2)) {
 			/* First failure, just rescan the half of the table.
 			 * Second failure, rescan the other half of the table.
 			 */
 			start = (largealloc ^ pass) ? tbl->it_halfpoint : 0;
 			limit = pass ? tbl->it_mapsize : limit;
+			pass++;
 			goto again;
 		} else {
 			/* Third failure, give up */


