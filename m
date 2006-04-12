Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWDLRTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWDLRTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932265AbWDLRTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:19:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:34471 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932263AbWDLRTQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:19:16 -0400
Date: Wed, 12 Apr 2006 10:19:28 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Joel H Schopp <jschopp@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] sparsemem interaction with memory add bug fixes
Message-ID: <20060412171928.GA9111@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated version of patch with Andy's suggestion.

Fix two bugs with the way sparsemem interacts with memory add:
- memory leak if memmap for section already exists
- calling alloc_bootmem_node() after boot

Signed-off-by: Joel Schopp <jschopp@austin.ibm.com>
Signed-off-by: Andy Whitcroft <apw@shadowen.org>
Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.17-rc1-mm2/mm/sparse.c linux-2.6.17-rc1-mm2.work/mm/sparse.c
--- linux-2.6.17-rc1-mm2/mm/sparse.c	2006-04-03 03:22:10.000000000 +0000
+++ linux-2.6.17-rc1-mm2.work/mm/sparse.c	2006-04-12 17:21:11.000000000 +0000
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
