Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261657AbUKWXiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUKWXiV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbUKWXgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:36:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:39402 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261190AbUKWXeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:34:44 -0500
Date: Tue, 23 Nov 2004 15:38:58 -0800
From: Andrew Morton <akpm@osdl.org>
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Debugging a memory leak in the 2.6.X kernel - how-to?
Message-Id: <20041123153858.6df49fde.akpm@osdl.org>
In-Reply-To: <200411231929.iANJTe4w031449@turing-police.cc.vt.edu>
References: <200411231929.iANJTe4w031449@turing-police.cc.vt.edu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>
> Any advice how to shoot this one?

Manfred's slab leak detector:


From: Manfred Spraul <manfred@colorfullife.com>

With the patch applied,

	echo "size-4096 0 0 0" > /proc/slabinfo

walks the objects in the size-4096 slab, printing out the calling address
of whoever allocated that object.

It is for leak detection.

 25-akpm/mm/slab.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff -puN mm/slab.c~slab-leak-detector mm/slab.c
--- 25/mm/slab.c~slab-leak-detector	2004-06-02 18:02:11.923825992 -0700
+++ 25-akpm/mm/slab.c	2004-06-02 18:02:11.934824320 -0700
@@ -2030,6 +2030,15 @@ cache_alloc_debugcheck_after(kmem_cache_
 		*dbg_redzone1(cachep, objp) = RED_ACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_ACTIVE;
 	}
+	{
+		int objnr;
+		struct slab *slabp;
+
+		slabp = GET_PAGE_SLAB(virt_to_page(objp));
+
+		objnr = (objp - slabp->s_mem) / cachep->objsize;
+		slab_bufctl(slabp)[objnr] = (unsigned long)caller;
+	}
 	objp += obj_dbghead(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
 		unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
@@ -2091,12 +2100,14 @@ static void free_block(kmem_cache_t *cac
 		objnr = (objp - slabp->s_mem) / cachep->objsize;
 		check_slabp(cachep, slabp);
 #if DEBUG
+#if 0
 		if (slab_bufctl(slabp)[objnr] != BUFCTL_FREE) {
 			printk(KERN_ERR "slab: double free detected in cache '%s', objp %p.\n",
 						cachep->name, objp);
 			BUG();
 		}
 #endif
+#endif
 		slab_bufctl(slabp)[objnr] = slabp->free;
 		slabp->free = objnr;
 		STATS_DEC_ACTIVE(cachep);
@@ -2946,6 +2957,29 @@ struct seq_operations slabinfo_op = {
 	.show	= s_show,
 };
 
+static void do_dump_slabp(kmem_cache_t *cachep)
+{
+#if DEBUG
+	struct list_head *q;
+
+	check_irq_on();
+	spin_lock_irq(&cachep->spinlock);
+	list_for_each(q,&cachep->lists.slabs_full) {
+		struct slab *slabp;
+		int i;
+		slabp = list_entry(q, struct slab, list);
+		for (i = 0; i < cachep->num; i++) {
+			unsigned long sym = slab_bufctl(slabp)[i];
+
+			printk("obj %p/%d: %p", slabp, i, (void *)sym);
+			print_symbol(" <%s>", sym);
+			printk("\n");
+		}
+	}
+	spin_unlock_irq(&cachep->spinlock);
+#endif
+}
+
 #define MAX_SLABINFO_WRITE 128
 /**
  * slabinfo_write - Tuning for the slab allocator
@@ -2986,9 +3020,11 @@ ssize_t slabinfo_write(struct file *file
 			    batchcount < 1 ||
 			    batchcount > limit ||
 			    shared < 0) {
-				res = -EINVAL;
+				do_dump_slabp(cachep);
+				res = 0;
 			} else {
-				res = do_tune_cpucache(cachep, limit, batchcount, shared);
+				res = do_tune_cpucache(cachep, limit,
+							batchcount, shared);
 			}
 			break;
 		}
_

