Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262239AbVCBJ0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262239AbVCBJ0S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 04:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262238AbVCBJ0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 04:26:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:49077 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262239AbVCBJZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 04:25:39 -0500
Date: Wed, 2 Mar 2005 01:24:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Justin Schoeman <justin@expertron.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tracing memory leaks (slabs) in 2.6.9+ kernels?
Message-Id: <20050302012444.4ed05c23.akpm@osdl.org>
In-Reply-To: <4225768B.3010005@expertron.co.za>
References: <4225768B.3010005@expertron.co.za>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Schoeman <justin@expertron.co.za> wrote:
>
> I am having a problem with memory leaking on a patched kernel.  In order 
>  to pinpoint the leak, I would like to try to trace the allocation points 
>  for the memory.
> 
>  I have found some vague references to patches that allow the user to 
>  dump the caller address for slab allocations, but I cannot find the 
>  patch itself.
> 
>  Can anybody please point me in the right direction - either for that 
>  patch, or any other way to track down leaking slabs?


From: Manfred Spraul <manfred@colorfullife.com>

With the patch applied,

	echo "size-4096 0 0 0" > /proc/slabinfo

walks the objects in the size-4096 slab, printing out the calling address
of whoever allocated that object.

It is for leak detection.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/mm/slab.c |   40 ++++++++++++++++++++++++++++++++++++++--
 1 files changed, 38 insertions(+), 2 deletions(-)

diff -puN mm/slab.c~slab-leak-detector mm/slab.c
--- 25/mm/slab.c~slab-leak-detector	2005-02-15 21:06:44.000000000 -0800
+++ 25-akpm/mm/slab.c	2005-02-15 21:06:44.000000000 -0800
@@ -2116,6 +2116,15 @@ cache_alloc_debugcheck_after(kmem_cache_
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
@@ -2179,12 +2188,14 @@ static void free_block(kmem_cache_t *cac
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
@@ -2998,6 +3009,29 @@ struct seq_operations slabinfo_op = {
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
@@ -3038,9 +3072,11 @@ ssize_t slabinfo_write(struct file *file
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

