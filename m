Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132736AbRC2OWK>; Thu, 29 Mar 2001 09:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRC2OWA>; Thu, 29 Mar 2001 09:22:00 -0500
Received: from bacchus.veritas.com ([204.177.156.37]:43685 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132733AbRC2OVp>; Thu, 29 Mar 2001 09:21:45 -0500
Date: Thu, 29 Mar 2001 15:20:45 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
   "David S. Miller" <davem@redhat.com>,
   Jakub Jellinek <jj@sunsite.ms.mff.cuni.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc64 module_map dont vfree
In-Reply-To: <Pine.LNX.4.21.0103022135140.1440-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0103291510060.1167-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sparc64 has a module_map() modelled on vmalloc(), but using a separate
modvmlist of areas.  After allocating an area, if the call to allocate
the pages and map them in fails, it needs to free that area: which at
present it's trying to do by calling vfree() - but that searches vmlist
not modvmlist.  It should be calling its own module_unmap() instead.
Patch below against 2.4.2-ac28 or 2.4.3-pre8.

Hugh

--- 2.4.2-ac28/arch/sparc64/mm/modutil.c	Mon Feb 19 03:49:54 2001
+++ linux/arch/sparc64/mm/modutil.c	Wed Mar 28 14:31:49 2001
@@ -59,7 +59,7 @@
 	*p = area;
 
 	if (vmalloc_area_pages(VMALLOC_VMADDR(addr), size, GFP_KERNEL, PAGE_KERNEL)) {
-		vfree(addr);
+		module_unmap(addr);
 		return NULL;
 	}
 	return addr;

