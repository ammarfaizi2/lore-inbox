Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbTJPFlT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 01:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTJPFlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 01:41:19 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:20681 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262725AbTJPFlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 01:41:16 -0400
Message-ID: <3F8E2F68.7010007@colorfullife.com>
Date: Thu, 16 Oct 2003 07:40:56 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: William Lee Irwin III <wli@holomorphy.com>, albertogli@telpin.com.ar,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5/6 (and probably 7 too) size-4096 memory leak
References: <20031016025554.GH4292@telpin.com.ar>	<20031015211918.1a70c4d2.akpm@osdl.org>	<20031016044334.GE4461@holomorphy.com> <20031015215824.165dc4c7.akpm@osdl.org>
In-Reply-To: <20031015215824.165dc4c7.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------060109060908060804080900"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060109060908060804080900
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:

>I'm thinking we need to stuff builtin_return_address(0) into the object and
>write a dumper, but I haven't looked into that.  Maybe I can persuade
>Manfred to cook up a custom patch to do that?  Just for size-4096?  Something
>really crude will be fine.
>  
>
I've attached something: with the patch applied, `echo "size-4096 0 0 0" 
 > /proc/slabinfo` dumps all caller addresses.

It works fine and dumps all 25 outstanding objects of my bochs setup - 
you might have to limit the dumps if you have 100k objects.

--
    Manfred

--------------060109060908060804080900
Content-Type: text/plain;
 name="patch-slab-extended-last-user"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-extended-last-user"

--- 2.6/mm/slab.c	2003-10-09 21:23:19.000000000 +0200
+++ build-2.6/mm/slab.c	2003-10-16 07:32:06.000000000 +0200
@@ -1891,6 +1891,15 @@
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
+		slab_bufctl(slabp)[objnr] = (int)caller;
+	}
 	objp += obj_dbghead(cachep);
 	if (cachep->ctor && cachep->flags & SLAB_POISON) {
 		unsigned long	ctor_flags = SLAB_CTOR_CONSTRUCTOR;
@@ -1952,12 +1961,14 @@
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
@@ -2694,6 +2705,22 @@
 	.show	= s_show,
 };
 
+static void do_dump_slabp(kmem_cache_t *cachep)
+{
+	struct list_head *q;
+
+	check_irq_on();
+	spin_lock_irq(&cachep->spinlock);
+	list_for_each(q,&cachep->lists.slabs_full) {
+		struct slab *slabp;
+		int i;
+		slabp = list_entry(q, struct slab, list);
+		for (i=0;i<cachep->num;i++)
+			printk(KERN_DEBUG "obj %p/%d: %p\n", slabp, i, (void*)(slab_bufctl(slabp)[i]));
+	}
+	spin_unlock_irq(&cachep->spinlock);
+}
+
 #define MAX_SLABINFO_WRITE 128
 /**
  * slabinfo_write - Tuning for the slab allocator
@@ -2734,6 +2761,7 @@
 			    batchcount < 1 ||
 			    batchcount > limit ||
 			    shared < 0) {
+				do_dump_slabp(cachep);
 				res = -EINVAL;
 			} else {
 				res = do_tune_cpucache(cachep, limit, batchcount, shared);

--------------060109060908060804080900--

