Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315943AbSGLKwQ>; Fri, 12 Jul 2002 06:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSGLKwP>; Fri, 12 Jul 2002 06:52:15 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20123 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315943AbSGLKwO>;
	Fri, 12 Jul 2002 06:52:14 -0400
Date: Fri, 12 Jul 2002 16:27:09 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, "David S. Miller " <davem@redhat.com>,
       Patch Monkey <trivial@rustcorp.com.au>
Subject: [patch trivial 2.5.25] dst.c cleanup -- dst_total
Message-ID: <20020712162709.B988@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dst_total  is read only #if RT_CACHE_DEBUG >=2 , but is incremented and
decremented during dst_alloc and dst_destroy.  Following patch conditions
the atomic_inc and atomic_decs to dst_total with RT_CACHE_DEBUG >= 2 

dst_alloc routine (which incements dst_total) shows up with the tests 
suggested by Dave Miller for measuring RCU route cache changes. 
Profile ticks reduce by 15 % for dst_alloc on a 4 way with  the foll
patch (with the default -- RT_CACHE_DEBUG = 0 ).

-Kiran


--- linux-2.5.25-pure/net/core/dst.c	Sat Jul  6 05:12:31 2002
+++ linux-2.5.25/net/core/dst.c	Fri Jul 12 13:23:09 2002
@@ -29,7 +29,9 @@
  * 4) All operations modify state, so a spinlock is used.
  */
 static struct dst_entry 	*dst_garbage_list;
+#if RT_CACHE_DEBUG >= 2 
 static atomic_t			 dst_total = ATOMIC_INIT(0);
+#endif
 static spinlock_t		 dst_lock = SPIN_LOCK_UNLOCKED;
 
 static unsigned long dst_gc_timer_expires;
@@ -108,7 +110,9 @@
 	dst->lastuse = jiffies;
 	dst->input = dst_discard;
 	dst->output = dst_blackhole;
+#if RT_CACHE_DEBUG >= 2 
 	atomic_inc(&dst_total);
+#endif
 	atomic_inc(&ops->entries);
 	return dst;
 }
@@ -158,7 +162,9 @@
 		dst->ops->destroy(dst);
 	if (dst->dev)
 		dev_put(dst->dev);
+#if RT_CACHE_DEBUG >= 2 
 	atomic_dec(&dst_total);
+#endif
 	kmem_cache_free(dst->ops->kmem_cachep, dst);
 }
 
