Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWDLCdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWDLCdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 22:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWDLCdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 22:33:35 -0400
Received: from vms044pub.verizon.net ([206.46.252.44]:10987 "EHLO
	vms044pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751316AbWDLCde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 22:33:34 -0400
Date: Tue, 11 Apr 2006 19:33:47 -0700
From: Mike Kravetz <mjkravetz@verizon.net>
Subject: [PATCH] sparsemem interaction with memory add bug fixes
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Joel H Schopp <jschopp@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <apw@shadowen.org>,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Message-id: <20060412023347.GA9343@w-mikek2.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes two bugs with the way sparsemem interacts with memory
add.  They are:
- memory leak if memmap for section already exists
- calling alloc_bootmem_node() after boot
These bugs were discovered and a first cut at the fixes were provided by
Arnd Bergmann <arnd@arndb.de> and Joel Schopp <jschopp@us.ibm.com>.

Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>

diff -Naupr linux-2.6.17-rc1-mm2/mm/sparse.c linux-2.6.17-rc1-mm2.work/mm/sparse.c
--- linux-2.6.17-rc1-mm2/mm/sparse.c	2006-04-03 03:22:10.000000000 +0000
+++ linux-2.6.17-rc1-mm2.work/mm/sparse.c	2006-04-11 23:32:10.000000000 +0000
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
 
+out:
 	if (ret <= 0)
 		__kfree_section_memmap(memmap, nr_pages);
-out:
 	pgdat_resize_unlock(pgdat, &flags);
 	return ret;
 }
