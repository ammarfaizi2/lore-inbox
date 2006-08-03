Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWHCDdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWHCDdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWHCDdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:33:10 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:18149 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932150AbWHCDdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:33:09 -0400
Date: Thu, 3 Aug 2006 12:34:41 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: LHMS <lhms-devel@lists.sourceforge.net>,
       "kmannth@us.ibm.com" <kmannth@us.ibm.com>,
       "y-goto@jp.fujitsu.com" <y-goto@jp.fujitsu.com>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] memory hotadd fixes [3/5] find_next_system_ram catch range
 fix
Message-Id: <20060803123441.92e4ddfb.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
find_next_system_ram() is used to find available memory resource
at onlining newly added memory.
This patch fixes following problem.

find_next_system_ram() cannot catch this case.

Resource:      (start)-------------(end)
Section :                (start)-------------(end)


Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 kernel/resource.c   |    3 ++-
 mm/memory_hotplug.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rc3/kernel/resource.c
===================================================================
--- linux-2.6.18-rc3.orig/kernel/resource.c	2006-08-01 16:38:45.000000000 +0900
+++ linux-2.6.18-rc3/kernel/resource.c	2006-08-01 16:38:56.000000000 +0900
@@ -244,6 +244,7 @@
 
 	start = res->start;
 	end = res->end;
+	BUG_ON(start >= end);
 
 	read_lock(&resource_lock);
 	for (p = iomem_resource.child; p ; p = p->sibling) {
@@ -254,7 +255,7 @@
 			p = NULL;
 			break;
 		}
-		if (p->start >= start)
+		if ((p->end >= start) && (p->start < end))
 			break;
 	}
 	read_unlock(&resource_lock);
Index: linux-2.6.18-rc3/mm/memory_hotplug.c
===================================================================
--- linux-2.6.18-rc3.orig/mm/memory_hotplug.c	2006-08-01 16:38:19.000000000 +0900
+++ linux-2.6.18-rc3/mm/memory_hotplug.c	2006-08-01 16:38:56.000000000 +0900
@@ -163,7 +163,7 @@
 	res.flags = IORESOURCE_MEM; /* we just need system ram */
 	section_end = res.end;
 
-	while (find_next_system_ram(&res) >= 0) {
+	while ((res.start < res.end) && (find_next_system_ram(&res) >= 0)) {
 		start_pfn = (unsigned long)(res.start >> PAGE_SHIFT);
 		nr_pages = (unsigned long)
                            ((res.end + 1 - res.start) >> PAGE_SHIFT);

