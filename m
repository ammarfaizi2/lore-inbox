Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVBPFNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVBPFNO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 00:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbVBPFM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 00:12:57 -0500
Received: from fire.osdl.org ([65.172.181.4]:53197 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261984AbVBPFMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 00:12:34 -0500
Date: Tue, 15 Feb 2005 21:12:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: noel@zhtwn.com, torvalds@osdl.org, kas@fi.muni.cz, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Message-Id: <20050215211210.1ea2d342.akpm@osdl.org>
In-Reply-To: <200502152300.15063.kernel-stuff@comcast.net>
References: <20050121161959.GO3922@fi.muni.cz>
	<Pine.LNX.4.58.0502070728280.2165@ppc970.osdl.org>
	<20050208024714.GA16808@uglybox.localnet>
	<200502152300.15063.kernel-stuff@comcast.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
>
> I am running -rc3 on my AMD64 laptop and I noticed it becomes sluggish after 
> use mainly due to growing swap use.  It has 768M of RAM and a Gig of swap. 
> After following this thread, I started monitoring /proc/slabinfo. It seems 
> size-64 is continuously growing and doing a compile run seem to make it grow 
> noticeably faster. After a day's uptime size-64 line in /proc/slabinfo looks 
> like 
> 
> size-64           7216543 7216544     64   61    1 : tunables  120   60    0 : 
> slabdata 118304 118304      0

Plenty of moisture there.

Could you please use this patch?  Make sure that you enable
CONFIG_FRAME_POINTER (might not be needed for __builtin_return_address(0),
but let's be sure).  Also enable CONFIG_DEBUG_SLAB.



From: Manfred Spraul <manfred@colorfullife.com>

With the patch applied,

	echo "size-4096 0 0 0" > /proc/slabinfo

walks the objects in the size-4096 slab, printing out the calling address
of whoever allocated that object.

It is for leak detection.


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

