Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261949AbSJITfd>; Wed, 9 Oct 2002 15:35:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261951AbSJITfd>; Wed, 9 Oct 2002 15:35:33 -0400
Received: from packet.digeo.com ([12.110.80.53]:32657 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261949AbSJITfc>;
	Wed, 9 Oct 2002 15:35:32 -0400
Message-ID: <3DA48655.82A5E044@digeo.com>
Date: Wed, 09 Oct 2002 12:41:09 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] CONFIG_DEBUG_SLAB broken on SMP
References: <20021009191335.GB3045@clusterfs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Oct 2002 19:41:09.0159 (UTC) FILETIME=[D0C7BB70:01C26FCB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> 
> We were tracking down a strange bug in our code that only appeared on
> SMP and not UP, and we thought that CONFIG_DEBUG_SLAB (and the ensuing
> FORCED_DEBUG which enables SLAB_POISON and SLAB_REDZONE) was going to
> catch problems with slab objects, so we were very very confused when a
> test like:
> 
>         struct foo *obj;
> 
>         cache = kmem_cache_create("test_cache", sizeof(struct foo))
>         obj = kmem_cache_alloc(cache, GFP_KERNEL);
>         kmem_cache_free(cache, obj);
>         // print out contents of obj
> 
> was not poisoning obj, or setting the redzone fields on obj to "free".
> 

Linus recently changed the 2.5 slab allocator to stamp that out.

--- mm/slab.c	18 Sep 2002 03:48:34 -0000	1.28
+++ mm/slab.c	20 Sep 2002 16:22:53 -0000	1.29
@@ -1727,8 +1728,13 @@
 	return 0;
 }
 
+/* 
+ * If slab debugging is enabled, don't batch slabs
+ * on the per-cpu lists by defaults.
+ */
 static void enable_cpucache (kmem_cache_t *cachep)
 {
+#ifndef CONFIG_DEBUG_SLAB
 	int err;
 	int limit;
 
@@ -1746,6 +1752,7 @@
 	if (err)
 		printk(KERN_ERR "enable_cpucache failed for %s, error %d.\n",
 					cachep->name, -err);
+#endif
 }
 
 static void enable_all_cpucaches (void)
