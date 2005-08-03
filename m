Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbVHCN4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbVHCN4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 09:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVHCN4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 09:56:47 -0400
Received: from galileo.bork.org ([134.117.69.57]:5849 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S262055AbVHCN4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 09:56:46 -0400
Date: Wed, 3 Aug 2005 09:56:46 -0400
From: Martin Hicks <mort@sgi.com>
To: Ingo Molnar <mingo@elte.hu>, Linux MM <linux-mm@kvack.org>
Cc: Martin Hicks <mort@sgi.com>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de
Subject: [PATCH] VM: add vm.free_node_memory sysctl
Message-ID: <20050803135646.GO26803@localhost>
References: <20050801113913.GA7000@elte.hu> <20050801102903.378da54f.akpm@osdl.org> <20050801195426.GA17548@elte.hu> <20050802171050.GG26803@localhost> <20050802210746.GA26494@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050802210746.GA26494@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Aug 02, 2005 at 11:07:46PM +0200, Ingo Molnar wrote:
> 
> * Martin Hicks <mort@sgi.com> wrote:
> 
> > On Mon, Aug 01, 2005 at 09:54:26PM +0200, Ingo Molnar wrote:
> > > 
> > > * Andrew Morton <akpm@osdl.org> wrote:
> > > 
> > > > >  We could perhaps add a CAP_SYS_ADMIN-only sysctl for this hack,
> > > > 
> > > > That would be more appropriate.
> > > > 
> > > > (I'm still not sure what happened to the idea of adding a call to 
> > > > "clear out this node+zone's pagecache now" rather than "set this 
> > > > noed+zone's policy")
> > > 
> > > lets do that as a sysctl hack. It would be useful for debugging purposes 
> > > anyway. But i'm not sure whether it's the same issue - Martin?
> > 
> > (Sorry..I was on vacation yesterday)
> > 
> > Yes, this is the same issue with a different way of making it happen. 
> > Setting a zone's policy allows reclaim to happen automatically.
> > 
> > I'll send in a patch to add a sysctl to do the manual dumping of 
> > pagecache really soon.
> 
> cool! [ Incidentally, when i found this problem i was looking for 
> existing bits in the kernel to write such a patch myself (which i wanted 
> to use on non-NUMA to create more reproducable workloads for 
> performance-testing) - now i'll wait for your patch. ]

Here's the promised sysctl to dump a node's pagecache.  Please review!

This patch depends on the zone reclaim atomic ops cleanup:
http://marc.theaimsgroup.com/?l=linux-mm&m=112307646306476&w=2


I split up zone_reclaim():

- __zone_reclaim() does the Real Work

- zone_reclaim() checks the rate-limiting stuff.

For the sysctl we don't want to be rate limited.  We always want to scan
the LRU lists looking for tossable pages.

Thanks,
mh

-- 
Martin Hicks   ||   Silicon Graphics Inc.   ||   mort@sgi.com



This patch adds the vm.free_node_memory sysctl.  This allows a root user
to ask the kernel to drop as many pages as possible out of the specified
node's pagecache.

Takes a single integer nodeID.  e.g.,

echo 14 > /proc/sys/vm/free_zone_memory

will clear pagecache on node 14.

Signed-off-by:  Martin Hicks <mort@sgi.com>

---
commit 9b0a83e09e4fea07cf877dc7f6ff8b38c0f48d61
tree 58d5467efa7f3bf103203e25c95c6f0936ed653f
parent 414acb15f0f237cbf560bfa56c74ca9d19c5cd5a
author Martin Hicks,,,,,,,engr <mort@tomahawk.engr.sgi.com> Wed, 03 Aug 2005 06:53:33 -0700
committer Martin Hicks,,,,,,,engr <mort@tomahawk.engr.sgi.com> Wed, 03 Aug 2005 06:53:33 -0700

 include/linux/mmzone.h |    3 ++
 include/linux/sysctl.h |    1 +
 kernel/sysctl.c        |   10 +++++++
 mm/vmscan.c            |   66 +++++++++++++++++++++++++++++++++++++++---------
 4 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -403,6 +403,9 @@ int min_free_kbytes_sysctl_handler(struc
 extern int sysctl_lowmem_reserve_ratio[MAX_NR_ZONES-1];
 int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *, int, struct file *,
 					void __user *, size_t *, loff_t *);
+extern int sysctl_free_node_memory;
+int free_node_memory_sysctl_handler(struct ctl_table *, int, struct file *,
+				    void __user *, size_t *, loff_t *);
 
 #include <linux/topology.h>
 /* Returns the number of the current Node. */
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -180,6 +180,7 @@ enum
 	VM_VFS_CACHE_PRESSURE=26, /* dcache/icache reclaim pressure */
 	VM_LEGACY_VA_LAYOUT=27, /* legacy/compatibility virtual address space layout */
 	VM_SWAP_TOKEN_TIMEOUT=28, /* default time for token time out */
+	VM_FREE_NODE_MEMORY=29, /* free page cache from specified node */
 };
 
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -851,6 +851,16 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+	{
+		.ctl_name	= VM_FREE_NODE_MEMORY,
+		.procname	= "free_node_memory",
+		.data		= &sysctl_free_node_memory,
+		.maxlen		= sizeof(sysctl_free_node_memory),
+		.mode		= 0644,
+		.proc_handler	= &free_node_memory_sysctl_handler,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
 	{ .ctl_name = 0 }
 };
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -33,6 +33,7 @@
 #include <linux/cpuset.h>
 #include <linux/notifier.h>
 #include <linux/rwsem.h>
+#include <linux/sysctl.h>
 
 #include <asm/tlbflush.h>
 #include <asm/div64.h>
@@ -1329,21 +1330,17 @@ static int __init kswapd_init(void)
 
 module_init(kswapd_init)
 
-
 /*
- * Try to free up some pages from this zone through reclaim.
+ * Try to free up pages from the zone through reclaim.
  */
-int zone_reclaim(struct zone *zone, unsigned int gfp_mask, unsigned int order)
+int __zone_reclaim(struct zone *zone, unsigned int gfp_mask, unsigned int order)
 {
 	struct scan_control sc;
 	int nr_pages = 1 << order;
-	int total_reclaimed = 0;
 
 	/* The reclaim may sleep, so don't do it if sleep isn't allowed */
 	if (!(gfp_mask & __GFP_WAIT))
 		return 0;
-	if (zone->all_unreclaimable)
-		return 0;
 
 	sc.gfp_mask = gfp_mask;
 	sc.may_writepage = 0;
@@ -1359,15 +1356,22 @@ int zone_reclaim(struct zone *zone, unsi
 	else
 		sc.swap_cluster_max = SWAP_CLUSTER_MAX;
 
+	shrink_zone(zone, &sc);
+	return sc.nr_reclaimed;
+}
+
+/*
+ * Checks to make sure that reclaim isn't active on the zone already
+ */
+int zone_reclaim(struct zone *zone, unsigned int gfp_mask, unsigned int order)
+{
+	if (zone->all_unreclaimable)
+		return 0;
 	/* Don't reclaim the zone if there are other reclaimers active */
 	if (atomic_read(&zone->reclaim_in_progress) > 0)
-		goto out;
-
-	shrink_zone(zone, &sc);
-	total_reclaimed = sc.nr_reclaimed;
+		return 0;
 
- out:
-	return total_reclaimed;
+	return __zone_reclaim(zone, gfp_mask, order);
 }
 
 asmlinkage long sys_set_zone_reclaim(unsigned int node, unsigned int zone,
@@ -1393,6 +1397,44 @@ asmlinkage long sys_set_zone_reclaim(uns
 			z->reclaim_pages = 1;
 		else
 			z->reclaim_pages = 0;
+	}
+
+	return 0;
+}
+
+int sysctl_free_node_memory;
+static DECLARE_MUTEX(free_node_memory_lock);
+
+int free_node_memory_sysctl_handler(ctl_table *table, int write,
+				    struct file *file, void __user *buffer,
+				    size_t *length, loff_t *ppos)
+{
+	struct zone *z;
+	int node;
+	int gfp_mask = __GFP_WAIT;
+	int i;
+
+	if (!write)
+		return 0;
+
+	down_interruptible(&free_node_memory_lock);
+	proc_dointvec(table, write, file, buffer, length, ppos);
+
+	node = sysctl_free_node_memory;
+	up(&free_node_memory_lock);
+
+	if (node >= MAX_NUMNODES || !node_online(node))
+		return -EINVAL;
+
+	for (i = 0; i < MAX_NR_ZONES; i++) {
+		z = &NODE_DATA(node)->node_zones[i];
+
+		if (!z->present_pages)
+			continue;
+
+		/* Reclaim pages from the zone */
+		while (__zone_reclaim(z, gfp_mask, SWAP_CLUSTER_MAX) != 0)
+			;
 	}
 
 	return 0;
