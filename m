Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932902AbWJIOrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932902AbWJIOrz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 10:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751885AbWJIOrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 10:47:55 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:54242 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751880AbWJIOry (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 10:47:54 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Try to avoid a pessimistic vmalloc() recursion
Date: Mon, 9 Oct 2006 16:47:55 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <20061006114947.GC14533@atrey.karlin.mff.cuni.cz> <20061006230609.c04e78bc.akpm@osdl.org>
In-Reply-To: <20061006230609.c04e78bc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bEmKFdQVyb6wnS/"
Message-Id: <200610091647.55184.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_bEmKFdQVyb6wnS/
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

__vmalloc_area_node() is a litle bit pessimist when allocating space for=20
storing struct page pointers.

When allocating more than 4 MB on ia32, or 2 MB on x86_64, =A0
__vmalloc_area_node() has to allocate more than PAGE_SIZE bytes to store=20
pointers to =A0page structs. This means that two TLB translations are neede=
d to=20
access data.

This patch tries a kmalloc() call, then only if this first attempt failed, =
a=20
vmalloc() is performed. (Later, at vfree() time we chose kfree() or vfree()=
=20
with a test on flags & VM_VPAGES : no change is needed)=20

Most of the time, the first kmalloc() should be OK, so we reduce TLB usage.

Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>

--Boundary-00=_bEmKFdQVyb6wnS/
Content-Type: text/plain;
  charset="iso-8859-1";
  name="vmalloc.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
	filename="vmalloc.patch"

--- linux-2.6.18/mm/vmalloc.c	2006-10-09 13:58:13.000000000 +0200
+++ linux-2.6.18-ed/mm/vmalloc.c	2006-10-09 14:04:11.000000000 +0200
@@ -426,12 +426,12 @@
 	array_size = (nr_pages * sizeof(struct page *));
 
 	area->nr_pages = nr_pages;
+	pages = kmalloc_node(array_size, (gfp_mask & ~__GFP_HIGHMEM), node);
 	/* Please note that the recursion is strictly bounded. */
-	if (array_size > PAGE_SIZE) {
+	if (!pages && array_size > PAGE_SIZE) {
 		pages = __vmalloc_node(array_size, gfp_mask, PAGE_KERNEL, node);
 		area->flags |= VM_VPAGES;
-	} else
-		pages = kmalloc_node(array_size, (gfp_mask & ~__GFP_HIGHMEM), node);
+	}
 	area->pages = pages;
 	if (!area->pages) {
 		remove_vm_area(area->addr);

--Boundary-00=_bEmKFdQVyb6wnS/--
