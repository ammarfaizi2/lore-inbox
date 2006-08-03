Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWHCD3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWHCD3S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWHCD3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:29:18 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:14513 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932147AbWHCD3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:29:17 -0400
Date: Thu, 3 Aug 2006 12:30:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>,
       "kmannth@us.ibm.com" <kmannth@us.ibm.com>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memory hotadd fixes [1/5] not-aligned memory hotadd
 handling fix
Message-Id: <20060803123039.c50feb85.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After Keith's report of memory hotadd failure, I increased test patterns.
These patches are a result of new patterns. But I cannot cover all existing
memory layout in the world, more tests are needed.
Now, I think my patch can make things better and want this codes to be tested
in -mm.patche series is consitsts of 5 patches.
 
Thanks,
-Kame

==
ioresouce handling code in memory hotplug allows not-aligned memory hot add.
But when memmap and other memory structures are initialized, parameters
should be aligned. (if not aligned, initialization of mem_map will do wrong,
it assumes parameters are aligned.) This patch fix it.

And this patch allows ioresource collision check to handle -EEXIST.

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


 mm/memory_hotplug.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

Index: linux-2.6.18-rc3/mm/memory_hotplug.c
===================================================================
--- linux-2.6.18-rc3.orig/mm/memory_hotplug.c	2006-08-01 16:11:56.000000000 +0900
+++ linux-2.6.18-rc3/mm/memory_hotplug.c	2006-08-01 16:38:19.000000000 +0900
@@ -76,15 +76,22 @@
 {
 	unsigned long i;
 	int err = 0;
+	int start_sec, end_sec;
+	/* during initialize mem_map, align hot-added range to section */
+	start_sec = pfn_to_section_nr(phys_start_pfn);
+	end_sec = pfn_to_section_nr(phys_start_pfn + nr_pages - 1);
 
-	for (i = 0; i < nr_pages; i += PAGES_PER_SECTION) {
-		err = __add_section(zone, phys_start_pfn + i);
+	for (i = start_sec; i <= end_sec; i++) {
+		err = __add_section(zone, i << PFN_SECTION_SHIFT);
 
-		/* We want to keep adding the rest of the
-		 * sections if the first ones already exist
+		/*
+		 * EEXIST is finally dealed with by ioresource collision
+		 * check. see add_memory() => register_memory_resource()
+		 * Warning will be printed if there is collision.
 		 */
 		if (err && (err != -EEXIST))
 			break;
+		err = 0;
 	}
 
 	return err;
@@ -213,10 +220,10 @@
 }
 
 /* add this memory to iomem resource */
-static void register_memory_resource(u64 start, u64 size)
+static int register_memory_resource(u64 start, u64 size)
 {
 	struct resource *res;
-
+	int ret = 0;
 	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 	BUG_ON(!res);
 
@@ -228,7 +235,9 @@
 		printk("System RAM resource %llx - %llx cannot be added\n",
 		(unsigned long long)res->start, (unsigned long long)res->end);
 		kfree(res);
+		ret = -EEXIST;
 	}
+	return ret;
 }
 
 
@@ -269,7 +278,7 @@
 	}
 
 	/* register this memory as resource */
-	register_memory_resource(start, size);
+	ret = register_memory_resource(start, size);
 
 	return ret;
 error:

