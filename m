Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423086AbWBBHLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423086AbWBBHLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 02:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423085AbWBBHLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 02:11:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47853 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932420AbWBBHLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 02:11:04 -0500
Date: Wed, 1 Feb 2006 23:10:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Kevin O'Connor" <kevin@koconnor.net>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: Size-128 slab leak
Message-Id: <20060201231001.0ca96bf0.akpm@osdl.org>
In-Reply-To: <20060131024928.GA11395@double.lan>
References: <20060131024928.GA11395@double.lan>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Kevin O'Connor" <kevin@koconnor.net> wrote:
>
> I have an annoying slab leak on my kernel.  Every day, I lose about
>  50Megs of memory to the leak.  It seems to be related to disk
>  accesses, because the count only goes up noticeable around 4:00am when
>  the system locate utility runs.
> 
>  I can tell there is a leak because /proc/slabinfo shows "size-128"
>  growing continuously.  For example, it currently reads:
> 
>  size-128          4086041 4106550    128   30    1 : tunables  120   60    8 : slabdata 136885 136885      0
> 
>  The machine is a vanilla lkml kernel:
> 
>  Linux double 2.6.15 #1 SMP Wed Jan 4 23:13:51 EST 2006 x86_64 x86_64 x86_64 GNU/Linux
> 
>  I've noticed this bug on a 2.6.14 kernel also.  This machine is using
>  libata (sata_uli) along with reiserfs, ext3, and lvm.  I'm interested
>  in finding ways of diagnosing this problem.

-mm kernels have a patch (slab-leak-detector.patch) which will help. 
Here's a version for 2.6.16-rc1.  It requires CONFIG_DEBUG_SLAB.  Thanks.


From: Manfred Spraul <manfred@colorfullife.com>

Maintenance work from Alexander Nyberg <alexn@telia.com>

With the patch applied,

	echo "size-4096 0 0 0" > /proc/slabinfo

walks the objects in the size-4096 slab, printing out the calling address
of whoever allocated that object.

It is for leak detection.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 mm/slab.c |   46 +++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 43 insertions(+), 3 deletions(-)

diff -puN mm/slab.c~slab-leak-detector mm/slab.c
--- devel/mm/slab.c~slab-leak-detector	2006-02-01 23:05:08.000000000 -0800
+++ devel-akpm/mm/slab.c	2006-02-01 23:07:43.000000000 -0800
@@ -198,7 +198,7 @@
  * is less than 512 (PAGE_SIZE<<3), but greater than 256.
  */
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 #define BUFCTL_END	(((kmem_bufctl_t)(~0U))-0)
 #define BUFCTL_FREE	(((kmem_bufctl_t)(~0U))-1)
 #define	SLAB_LIMIT	(((kmem_bufctl_t)(~0U))-2)
@@ -2393,7 +2393,7 @@ static void check_slabp(kmem_cache_t *ca
 		     i < sizeof(slabp) + cachep->num * sizeof(kmem_bufctl_t);
 		     i++) {
 			if ((i % 16) == 0)
-				printk("\n%03x:", i);
+				printk("\n%04lx:", i);
 			printk(" %02x", ((unsigned char *)slabp)[i]);
 		}
 		printk("\n");
@@ -2550,6 +2550,15 @@ static void *cache_alloc_debugcheck_afte
 		*dbg_redzone1(cachep, objp) = RED_ACTIVE;
 		*dbg_redzone2(cachep, objp) = RED_ACTIVE;
 	}
+	{
+		int objnr;
+		struct slab *slabp;
+
+		slabp = page_get_slab(virt_to_page(objp));
+
+		objnr = (objp - slabp->s_mem) / cachep->objsize;
+		slab_bufctl(slabp)[objnr] = (unsigned long)caller;
+	}
 	objp += obj_dbghead(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
 		unsigned long ctor_flags = SLAB_CTOR_CONSTRUCTOR;
@@ -2691,7 +2700,7 @@ static void free_block(kmem_cache_t *cac
 		check_spinlock_acquired_node(cachep, node);
 		check_slabp(cachep, slabp);
 
-#if DEBUG
+#if 0
 		/* Verify that the slab belongs to the intended node */
 		WARN_ON(slabp->nodeid != node);
 
@@ -3573,6 +3582,36 @@ struct seq_operations slabinfo_op = {
 	.show = s_show,
 };
 
+static void do_dump_slabp(kmem_cache_t *cachep)
+{
+#if DEBUG
+	struct list_head *q;
+	int node;
+
+	check_irq_on();
+	spin_lock_irq(&cachep->spinlock);
+	for_each_online_node(node) {
+		struct kmem_list3 *rl3 = cachep->nodelists[node];
+		spin_lock(&rl3->list_lock);
+
+		list_for_each(q, &rl3->slabs_full) {
+			int i;
+			struct slab *slabp = list_entry(q, struct slab, list);
+
+			for (i = 0; i < cachep->num; i++) {
+				unsigned long sym = slab_bufctl(slabp)[i];
+
+				printk("obj %p/%d: %p", slabp, i, (void *)sym);
+				print_symbol(" <%s>", sym);
+				printk("\n");
+			}
+		}
+		spin_unlock(&rl3->list_lock);
+	}
+	spin_unlock_irq(&cachep->spinlock);
+#endif
+}
+
 #define MAX_SLABINFO_WRITE 128
 /**
  * slabinfo_write - Tuning for the slab allocator
@@ -3612,6 +3651,7 @@ ssize_t slabinfo_write(struct file *file
 			if (limit < 1 ||
 			    batchcount < 1 ||
 			    batchcount > limit || shared < 0) {
+				do_dump_slabp(cachep);
 				res = 0;
 			} else {
 				res = do_tune_cpucache(cachep, limit,
_

