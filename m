Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030284AbWHDCbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030284AbWHDCbX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 22:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbWHDCbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 22:31:23 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:53934 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030284AbWHDCbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 22:31:22 -0400
Date: Fri, 4 Aug 2006 11:32:45 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: kmannth@us.ibm.com, akpm@osdl.org, y-goto@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: [PATCH] memory hotadd fixes [6/5] enhance collistion check
Message-Id: <20060804113245.30487789.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060803123604.0f909208.kamezawa.hiroyu@jp.fujitsu.com>
	<1154650396.5925.49.camel@keithlap>
	<20060804094443.c6f09de6.kamezawa.hiroyu@jp.fujitsu.com>
	<1154656472.5925.71.camel@keithlap>
	<20060804111550.ab30fc15.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay... here is 6/5 patch..

On Fri, 4 Aug 2006 11:15:50 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote: 
> > > Maybe moving ioresouce collision check in early stage of add_memory() is good ?
> >   Yea.  I am working a a full patch set for but my sparsemem and reserve
> > add-based paths.  It creates a valid_memory_add_range call at the start
> > of add_memory. I should be posting the set in the next few hours.
> > 
> Ah..ok. but I wrote my own patch...and testing it now..
> 

This patch passed test with ia64. based on 5 patches already sent.
plz check. 

Andrew, should I re-organize all patches if this is ok ?

-Kame
==

This patch is for collision check enhancement for memory hot add.

It's better to do resouce collision check before doing memory hot add,
which will touch memory management structures.

And add_section() should check section exists or not before calling
sparse_add_one_section(). (sparse_add_one_section() will do another
check anyway. but checking in memory_hotplug.c will be easy to understand.)

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

 mm/memory_hotplug.c |   29 ++++++++++++++++++++++-------
 1 files changed, 22 insertions(+), 7 deletions(-)

Index: linux-2.6.18-rc3/mm/memory_hotplug.c
===================================================================
--- linux-2.6.18-rc3.orig/mm/memory_hotplug.c	2006-08-02 15:30:53.000000000 +0900
+++ linux-2.6.18-rc3/mm/memory_hotplug.c	2006-08-04 10:19:20.000000000 +0900
@@ -52,6 +52,9 @@
 	int nr_pages = PAGES_PER_SECTION;
 	int ret;
 
+	if (pfn_valid(phys_start_pfn))
+		return -EEXIST;
+
 	ret = sparse_add_one_section(zone, phys_start_pfn, nr_pages);
 
 	if (ret < 0)
@@ -220,10 +223,9 @@
 }
 
 /* add this memory to iomem resource */
-static int register_memory_resource(u64 start, u64 size)
+static struct resource *register_memory_resource(u64 start, u64 size)
 {
 	struct resource *res;
-	int ret = 0;
 	res = kzalloc(sizeof(struct resource), GFP_KERNEL);
 	BUG_ON(!res);
 
@@ -235,9 +237,18 @@
 		printk("System RAM resource %llx - %llx cannot be added\n",
 		(unsigned long long)res->start, (unsigned long long)res->end);
 		kfree(res);
-		ret = -EEXIST;
+		res = NULL;
 	}
-	return ret;
+	return res;
+}
+
+static void release_memory_resource(struct resource *res)
+{
+	if (!res)
+		return;
+	release_resource(res);
+	kfree(res);
+	return;
 }
 
 
@@ -246,8 +257,13 @@
 {
 	pg_data_t *pgdat = NULL;
 	int new_pgdat = 0;
+	struct resource *res;
 	int ret;
 
+	res = register_memory_resource(start, size);
+	if (!res)
+		return -EEXIST;
+
 	if (!node_online(nid)) {
 		pgdat = hotadd_new_pgdat(nid, start);
 		if (!pgdat)
@@ -277,14 +293,13 @@
 		BUG_ON(ret);
 	}
 
-	/* register this memory as resource */
-	ret = register_memory_resource(start, size);
-
 	return ret;
 error:
 	/* rollback pgdat allocation and others */
 	if (new_pgdat)
 		rollback_node_hotadd(nid, pgdat);
+	if (res)
+		release_memory_resource(res);
 
 	return ret;
 }

