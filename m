Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSHDLFV>; Sun, 4 Aug 2002 07:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSHDLFU>; Sun, 4 Aug 2002 07:05:20 -0400
Received: from ns.suse.de ([213.95.15.193]:61961 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318148AbSHDLFS>;
	Sun, 4 Aug 2002 07:05:18 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] Caches that shrink automatically
Date: Sun, 4 Aug 2002 13:08:51 +0200
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_RAGBBEO7HW8ODLW861OH"
Message-Id: <200208041308.51638.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_RAGBBEO7HW8ODLW861OH
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

Currently there is no way for modules to define dynamically sized caches =
that=20
shrink upon memory pressure. We need this for implementing Extended Attri=
bute=20
caches on ext2, ext3, and ReiserFS. Other caches could also make use of t=
he=20
same mechanism (e.g., nfsd's permission cache, dcache, icache, dqache).

I propose this patch, which adds the register_cache() and unregister_cach=
e()=20
functions. They allow to register a callback which is invoked on memory=20
pressure. This callback shall then try to free some memory; the parameter=
s=20
and semantics are similar to the other shrink functions in mm/vmscan.c.


Regards,
Andreas.

------------------------------------------------------------------
 Andreas Gruenbacher                                SuSE Linux AG
 mailto:agruen@suse.de                     Deutschherrnstr. 15-19
 http://www.suse.de/                   D-90429 Nuernberg, Germany
--------------Boundary-00=_RAGBBEO7HW8ODLW861OH
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-2.5.30-cache_definition-0.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.5.30-cache_definition-0.diff"

Modular caches that shrink automatically

This patch adds the register_cache() and unregister_cache() functions which
register a callback that is invoked on memory pressure to free some memory. The
parameters and semantics to the callback are similar to the other shrink
functions.

diff -Nur linux-2.5.30/include/linux/cache_def.h linux-2.5.30.patch/include/linux/cache_def.h
--- linux-2.5.30/include/linux/cache_def.h	Thu Jan  1 01:00:00 1970
+++ linux-2.5.30.patch/include/linux/cache_def.h	Sat Aug  3 13:58:07 2002
@@ -0,0 +1,15 @@
+/*
+ * linux/cache_def.h
+ * Modular caches that shrink automatically
+ *
+ * Copyright (C) 2002 by Andreas Gruenbacher, <a.gruenbacher@computer.org>
+ */
+
+struct cache_definition {
+	const char *name;
+	void (*shrink)(int, unsigned int);
+	struct list_head link;
+};
+
+extern void register_cache(struct cache_definition *);
+extern void unregister_cache(struct cache_definition *);
diff -Nur linux-2.5.30/kernel/ksyms.c linux-2.5.30.patch/kernel/ksyms.c
--- linux-2.5.30/kernel/ksyms.c	Thu Aug  1 23:16:02 2002
+++ linux-2.5.30.patch/kernel/ksyms.c	Fri Aug  2 15:57:42 2002
@@ -31,6 +31,7 @@
 #include <linux/genhd.h>
 #include <linux/blkpg.h>
 #include <linux/swap.h>
+#include <linux/cache_def.h>
 #include <linux/ctype.h>
 #include <linux/file.h>
 #include <linux/iobuf.h>
@@ -106,6 +107,8 @@
 EXPORT_SYMBOL(kmem_cache_alloc);
 EXPORT_SYMBOL(kmem_cache_free);
 EXPORT_SYMBOL(kmem_cache_size);
+EXPORT_SYMBOL(register_cache);
+EXPORT_SYMBOL(unregister_cache);
 EXPORT_SYMBOL(kmalloc);
 EXPORT_SYMBOL(kfree);
 EXPORT_SYMBOL(vfree);
Binary files linux-2.5.30/mm/.vmscan.c.swp and linux-2.5.30.patch/mm/.vmscan.c.swp differ
diff -Nur linux-2.5.30/mm/vmscan.c linux-2.5.30.patch/mm/vmscan.c
--- linux-2.5.30/mm/vmscan.c	Thu Aug  1 23:16:08 2002
+++ linux-2.5.30.patch/mm/vmscan.c	Sat Aug  3 13:56:55 2002
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 #include <linux/kernel_stat.h>
 #include <linux/swap.h>
+#include <linux/cache_def.h>
 #include <linux/smp_lock.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
@@ -61,6 +62,39 @@
 	return 0;
 }
 
+static DECLARE_MUTEX(other_caches_lock);
+static LIST_HEAD(other_caches);
+
+void register_cache(struct cache_definition *cache)
+{
+	down(&other_caches_lock);
+	list_add(&cache->link, &other_caches);
+	up(&other_caches_lock);
+}
+
+void unregister_cache(struct cache_definition *cache)
+{
+	down(&other_caches_lock);
+	list_del(&cache->link);
+	up(&other_caches_lock);
+}
+
+static void shrink_other_caches(unsigned int priority, int gfp_mask)
+{
+	struct list_head *p = other_caches.prev;
+
+	down(&other_caches_lock);
+	while (p != &other_caches) {
+		struct cache_definition *cache =
+			list_entry(p, struct cache_definition, link);
+
+		cache->shrink(priority, gfp_mask);
+		p = p->prev;
+	}
+	up(&other_caches_lock);
+}
+
+
 static int
 shrink_cache(int nr_pages, zone_t *classzone,
 		unsigned int gfp_mask, int priority, int max_scan)
@@ -395,6 +429,7 @@
 #ifdef CONFIG_QUOTA
 	shrink_dqcache_memory(DEF_PRIORITY, gfp_mask);
 #endif
+	shrink_other_caches(priority, gfp_mask);
 
 	return nr_pages;
 }

--------------Boundary-00=_RAGBBEO7HW8ODLW861OH--

