Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWD2BVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWD2BVy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 21:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWD2BVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 21:21:52 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:3531 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751466AbWD2BVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 21:21:33 -0400
Message-Id: <20060429011908.390998000@localhost.localdomain>
References: <20060429011827.502138000@localhost.localdomain>
Date: Sat, 29 Apr 2006 03:18:29 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Mike Kravetz <kravetz@us.ibm.com>, Joel Schopp <jschopp@austin.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 2/4] sparsemem interaction with memory add bug fixes
Content-Disposition: inline; filename=sparsemem-interaction-with-memory-add-bug-fixes.patch
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Kravetz <mjkravetz@verizon.net>

This patch fixes two bugs with the way sparsemem interacts with memory add.
They are:

- memory leak if memmap for section already exists

- calling alloc_bootmem_node() after boot

These bugs were discovered and a first cut at the fixes were provided by
Arnd Bergmann <arnd@arndb.de> and Joel Schopp <jschopp@us.ibm.com>.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
---

 mm/sparse.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff -puN mm/sparse.c~sparsemem-interaction-with-memory-add-bug-fixes mm/sparse.c
--- 25/mm/sparse.c~sparsemem-interaction-with-memory-add-bug-fixes	Wed Apr 12 14:38:04 2006
+++ 25-akpm/mm/sparse.c	Wed Apr 12 14:38:04 2006
@@ -32,7 +32,10 @@ static struct mem_section *sparse_index_
 	unsigned long array_size = SECTIONS_PER_ROOT *
 				   sizeof(struct mem_section);
 
-	section = alloc_bootmem_node(NODE_DATA(nid), array_size);
+	if (system_state == SYSTEM_RUNNING)
+		section = kmalloc_node(array_size, GFP_KERNEL, nid);
+	else
+		section = alloc_bootmem_node(NODE_DATA(nid), array_size);
 
 	if (section)
 		memset(section, 0, array_size);
@@ -281,9 +284,9 @@ int sparse_add_one_section(struct zone *
 
 	ret = sparse_init_one_section(ms, section_nr, memmap);
 
-	if (ret <= 0)
-		__kfree_section_memmap(memmap, nr_pages);
 out:
 	pgdat_resize_unlock(pgdat, &flags);
+	if (ret <= 0)
+		__kfree_section_memmap(memmap, nr_pages);
 	return ret;
 }
_

--

