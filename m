Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbQKMBVd>; Sun, 12 Nov 2000 20:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129165AbQKMBVY>; Sun, 12 Nov 2000 20:21:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:54162 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S129040AbQKMBVF>; Sun, 12 Nov 2000 20:21:05 -0500
Importance: Normal
Subject: [patch] nfsd optimizations for test10 (recoded to use list_head)
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net,
        torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OFEBB493A2.95975790-ON88256996.0006B37E@LocalDomain>
From: "Ying Chen/Almaden/IBM" <ying@almaden.ibm.com>
Date: Sun, 12 Nov 2000 17:23:23 -0800
X-MIMETrack: Serialize by Router on D03NM042/03/M/IBM(Release 5.0.5 |September 22, 2000) at
 11/12/2000 05:20:58 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is the recoded racache that uses list_head for several lists, e.g.,
lru and free lists. I have tested it under SPEC SFS runs, and several other
NFS loads myself.

Here is the whole patch against test10.
=====================================================
diff -ruN nfsd.orig/nfsd.h nfsd.opt/nfsd.h
--- nfsd.orig/nfsd.h     Fri Nov 10 15:27:37 2000
+++ nfsd.opt/nfsd.h Fri Nov 10 16:03:43 2000
@@ -76,7 +76,7 @@

 /* nfsd/vfs.c */
 int      fh_lock_parent(struct svc_fh *, struct dentry *);
-int      nfsd_racache_init(int);
+int      nfsd_racache_init(void);
 void          nfsd_racache_shutdown(void);
 int      nfsd_lookup(struct svc_rqst *, struct svc_fh *,
                    const char *, int, struct svc_fh *);
diff -ruN nfsd.orig/racache.h nfsd.opt/racache.h
--- nfsd.orig/racache.h  Fri Nov 10 16:10:23 2000
+++ nfsd.opt/racache.h   Fri Nov 10 15:50:49 2000
@@ -0,0 +1,42 @@
+/*
+ * include/linux/nfsd/racache.h
+ *
+ * Read ahead racache.
+ */
+
+#ifndef NFSRACACHE_H
+#define NFSRACACHE_H
+
+#ifdef __KERNEL__
+#include <linux/sched.h>
+
+/*
+ * This is a cache of readahead params that help us choose the proper
+ * readahead strategy. Initially, we set all readahead parameters to 0
+ * and let the VFS handle things.
+ * If you increase the number of cached files very much, you'll need to
+ * add a hash table here.
+ */
+/*
+ * Representation of an racache entry. The first two members *must*
+ * be hash_next and hash_prev.
+ */
+struct raparms {
+    struct raparms      *p_hash_next;
+    struct raparms      *p_hash_prev;
+    struct list_head         p_lru;
+    ino_t               p_ino;
+    dev_t               p_dev;
+    unsigned long       p_reada,
+                   p_ramax,
+                   p_raend,
+                   p_ralen,
+                   p_rawin;
+};
+
+int nfsd_racache_init(void);
+void     nfsd_racache_shutdown(void);
+struct raparms *nfsd_get_raparms(dev_t , ino_t );
+
+#endif /* __KERNEL__ */
+#endif /* NFSRACACHE_H */
diff -ruN nfsd.orig/stats.h nfsd.opt/stats.h
--- nfsd.orig/stats.h    Tue Jul 18 23:04:06 2000
+++ nfsd.opt/stats.h     Fri Nov 10 15:51:52 2000
@@ -25,8 +25,8 @@
                          * of available threads were in use */
     unsigned int   th_fullcnt;    /* number of times last free thread was used */
     unsigned int   ra_size;  /* size of ra cache */
-    unsigned int   ra_depth[11];  /* number of times ra entry was found that deep
-                         * in the cache (10percentiles). [10] = not found */
+    unsigned int   ra_hits;  /* ra cache hits */
+    unsigned int   ra_misses;     /* ra cache misses */
 };

 /* thread usage wraps very million seconds (approx one fortnight) */
diff -ruN nfsd.orig/Makefile nfsd.opt/Makefile
--- nfsd.orig/Makefile   Wed Dec  8 15:17:55 1999
+++ nfsd.opt/Makefile    Fri Nov 10 17:10:56 2000
@@ -9,7 +9,7 @@

 O_TARGET := nfsd.o
 O_OBJS   := nfssvc.o nfsctl.o nfsproc.o nfsfh.o vfs.o \
-        export.o auth.o lockd.o nfscache.o nfsxdr.o \
+        export.o auth.o lockd.o nfscache.o nfsracache.o nfsxdr.o \
         stats.o
 ifdef CONFIG_NFSD_V3
   O_OBJS += nfs3proc.o nfs3xdr.o
diff -ruN nfsd.orig/nfssvc.c nfsd.opt/nfssvc.c
--- nfsd.orig/nfssvc.c   Sun Oct  1 20:35:16 2000
+++ nfsd.opt/nfssvc.c    Fri Nov 10 17:03:09 2000
@@ -43,7 +43,7 @@
 static void             nfsd(struct svc_rqst *rqstp);
 struct timeval               nfssvc_boot;
 static struct svc_serv       *nfsd_serv;
-static int              nfsd_busy;
+static atomic_t              nfsd_busy;
 static unsigned long         nfsd_last_call;

 struct nfsd_list {
@@ -72,7 +72,7 @@
          nrservs = NFSD_MAXSERVS;

     /* Readahead param cache - will no-op if it already exists */
-    error =   nfsd_racache_init(2*nrservs);
+    error =   nfsd_racache_init();
     if (error<0)
          goto out;
     if (!nfsd_serv) {
@@ -185,8 +185,8 @@
              ;
          if (err < 0)
               break;
-         update_thread_usage(nfsd_busy);
-         nfsd_busy++;
+         update_thread_usage(atomic_read(&nfsd_busy));
+         atomic_inc(&nfsd_busy);

          /* Lock the export hash tables for reading. */
          exp_readlock();
@@ -205,8 +205,8 @@

          /* Unlock export hash tables */
          exp_unlock();
-         update_thread_usage(nfsd_busy);
-         nfsd_busy--;
+         update_thread_usage(atomic_read(&nfsd_busy));
+         atomic_dec(&nfsd_busy);
     }

     if (err != -EINTR) {
diff -ruN nfsd.orig/stats.c nfsd.opt/stats.c
--- nfsd.orig/stats.c    Tue Jul 18 23:04:06 2000
+++ nfsd.opt/stats.c     Fri Nov 10 17:04:52 2000
@@ -15,9 +15,8 @@
  *  th <threads> <fullcnt> <10%-20%> <20%-30%> ... <90%-100%> <100%>
  *            time (seconds) when nfsd thread usage above thresholds
  *            and number of times that all threads were in use
- *  ra cache-size  <10%  <20%  <30% ... <100% not-found
- *            number of times that read-ahead entry was found that deep in
- *            the cache.
+ *  ra cache-size  <racache-size> <hits> <misses>
+              racache size, hits, and misses
  *  plus generic RPC stats (see net/sunrpc/stats.c)
  *
  * Copyright (C) 1995, 1996, 1997 Olaf Kirch <okir@monad.swb.de>
@@ -65,11 +64,8 @@
     }

     /* newline and ra-cache */
-    len += sprintf(buffer+len, "\nra %u", nfsdstats.ra_size);
-    for (i=0; i<11; i++)
-         len += sprintf(buffer+len, " %u", nfsdstats.ra_depth[i]);
-    len += sprintf(buffer+len, "\n");
-
+    len += sprintf(buffer+len, "\nra %u %u %u\n", nfsdstats.ra_size,
+              nfsdstats.ra_hits, nfsdstats.ra_misses);

     /* Assume we haven't hit EOF yet. Will be set by svc_proc_read. */
     *eof = 0;
diff -ruN nfsd.orig/vfs.c nfsd.opt/vfs.c
--- nfsd.orig/vfs.c Mon Oct 16 12:58:51 2000
+++ nfsd.opt/vfs.c  Fri Nov 10 17:09:23 2000
@@ -36,6 +36,7 @@

 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
+#include <linux/nfsd/racache.h>
 #ifdef CONFIG_NFSD_V3
 #include <linux/nfs3.h>
 #include <linux/nfsd/xdr3.h>
@@ -56,28 +57,6 @@
 #define IS_ISMNDLK(i)   (S_ISREG((i)->i_mode) && MANDATORY_LOCK(i))

 /*
- * This is a cache of readahead params that help us choose the proper
- * readahead strategy. Initially, we set all readahead parameters to 0
- * and let the VFS handle things.
- * If you increase the number of cached files very much, you'll need to
- * add a hash table here.
- */
-struct raparms {
-    struct raparms      *p_next;
-    unsigned int        p_count;
-    ino_t               p_ino;
-    dev_t               p_dev;
-    unsigned long       p_reada,
-                   p_ramax,
-                   p_raend,
-                   p_ralen,
-                   p_rawin;
-};
-
-static struct raparms *      raparml;
-static struct raparms *      raparm_cache;
-
-/*
  * Look up one component of a pathname.
  * N.B. After this call _both_ fhp and resfh need an fh_put
  *
@@ -540,42 +519,6 @@
 }

 /*
- * Obtain the readahead parameters for the file
- * specified by (dev, ino).
- */
-static inline struct raparms *
-nfsd_get_raparms(dev_t dev, ino_t ino)
-{
-    struct raparms *ra, **rap, **frap = NULL;
-    int depth = 0;
-
-    for (rap = &raparm_cache; (ra = *rap); rap = &ra->p_next) {
-         if (ra->p_ino == ino && ra->p_dev == dev)
-              goto found;
-         depth++;
-         if (ra->p_count == 0)
-              frap = rap;
-    }
-    depth = nfsdstats.ra_size*11/10;
-    if (!frap)
-         return NULL;
-    rap = frap;
-    ra = *frap;
-    memset(ra, 0, sizeof(*ra));
-    ra->p_dev = dev;
-    ra->p_ino = ino;
-found:
-    if (rap != &raparm_cache) {
-         *rap = ra->p_next;
-         ra->p_next   = raparm_cache;
-         raparm_cache = ra;
-    }
-    ra->p_count++;
-    nfsdstats.ra_depth[depth*10/nfsdstats.ra_size]++;
-    return ra;
-}
-
-/*
  * Read data from a file. count must contain the requested read count
  * on entry. On return, *count contains the number of bytes actually read.
  * N.B. After this call fhp needs an fh_put
@@ -626,7 +569,6 @@
          ra->p_raend = file.f_raend;
          ra->p_ralen = file.f_ralen;
          ra->p_rawin = file.f_rawin;
-         ra->p_count -= 1;
     }

     if (err >= 0) {
@@ -1546,42 +1488,4 @@
          err = permission(inode, MAY_EXEC);

     return err? nfserrno(err) : 0;
-}
-
-void
-nfsd_racache_shutdown(void)
-{
-    if (!raparm_cache)
-         return;
-    dprintk("nfsd: freeing readahead buffers.\n");
-    kfree(raparml);
-    raparm_cache = raparml = NULL;
-}
-/*
- * Initialize readahead param cache
- */
-int
-nfsd_racache_init(int cache_size)
-{
-    int  i;
-
-    if (raparm_cache)
-         return 0;
-    raparml = kmalloc(sizeof(struct raparms) * cache_size, GFP_KERNEL);
-
-    if (raparml != NULL) {
-         dprintk("nfsd: allocating %d readahead buffers.\n",
-              cache_size);
-         memset(raparml, 0, sizeof(struct raparms) * cache_size);
-         for (i = 0; i < cache_size - 1; i++) {
-              raparml[i].p_next = raparml + i + 1;
-         }
-         raparm_cache = raparml;
-    } else {
-         printk(KERN_WARNING
-                "nfsd: Could not allocate memory read-ahead cache.\n");
-         return -ENOMEM;
-    }
-    nfsdstats.ra_size = cache_size;
-    return 0;
 }
diff -ruN nfsd.orig/nfsracache.c nfsd.opt/nfsracache.c
--- nfsd.orig/nfsracache.c    Fri Nov 10 16:10:23 2000
+++ nfsd.opt/nfsracache.c     Fri Nov 10 15:50:49 2000
@@ -0,0 +1,160 @@
+/*
+ * linux/fs/nfsd/nfsracache.c
+ *
+ * NFSD racache.
+ */
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/malloc.h>
+#include <linux/string.h>
+
+#include <linux/sunrpc/svc.h>
+#include <linux/nfsd/nfsd.h>
+#include <linux/nfsd/racache.h>
+
+#define CACHESIZE       2048
+#define HASHSIZE        512
+#define REQHASH(ino, dev)    ((((ino) >> 24) ^ (ino) ^ (dev)) & (HASHSIZE-1))
+
+spinlock_t racache_lock = SPIN_LOCK_UNLOCKED;
+
+
+/*
+ * The position of the pointers in the list_head are important.
+ * Don't change it without knowing what
+ * you are doing.
+ */
+static struct raparms *      raparm_cache = NULL;
+static struct list_head *    hash_list;
+static struct list_head lru_head;
+static struct list_head free_head;
+
+int
+nfsd_racache_init(void)
+{
+    struct raparms *rp;
+    struct list_head    *rahead;
+    size_t              i;
+    unsigned long       order;
+
+    i = CACHESIZE * sizeof (struct raparms);
+    for (order = 0; (PAGE_SIZE << order) < i; order++)
+         ;
+    raparm_cache = (struct raparms *)
+         __get_free_pages(GFP_KERNEL, order);
+    if (!raparm_cache) {
+         printk (KERN_ERR "nfsd: cannot allocate %Zd bytes for racache\n", i);
+         return -1;
+    }
+    memset(raparm_cache, 0, i);
+
+    i = HASHSIZE * sizeof (struct list_head);
+    hash_list = kmalloc (i, GFP_KERNEL);
+    if (!hash_list) {
+         free_pages ((unsigned long)raparm_cache, order);
+         raparm_cache = NULL;
+         printk (KERN_ERR "nfsd: cannot allocate %Zd bytes for hash list in racache\n", i);
+         return -1;
+    }
+
+    spin_lock(&racache_lock);
+    for (i = 0, rahead = hash_list; i < HASHSIZE; i++, rahead++)
+         INIT_LIST_HEAD(rahead);
+
+    INIT_LIST_HEAD(&free_head);
+    for (i = 0, rp = raparm_cache; i < CACHESIZE; i++, rp++) {
+         rp->p_hash_next = rp->p_hash_prev = rp;
+         list_add(&rp->p_lru, &free_head);
+    }
+    INIT_LIST_HEAD(&lru_head);
+    spin_unlock(&racache_lock);
+
+    nfsdstats.ra_size = CACHESIZE;
+    return 0;
+}
+
+void
+nfsd_racache_shutdown(void)
+{
+    size_t              i;
+    unsigned long       order;
+
+    i = CACHESIZE * sizeof (struct raparms);
+    for (order = 0; (PAGE_SIZE << order) < i; order++)
+         ;
+    spin_lock(&racache_lock);
+    free_pages ((unsigned long)raparm_cache, order);
+    raparm_cache = NULL;
+    kfree (hash_list);
+    hash_list = NULL;
+    spin_unlock(&racache_lock);
+}
+
+/* Insert a new entry into the hash table. */
+static inline struct raparms *
+nfsd_racache_insert(ino_t ino, dev_t dev)
+{
+    struct raparms *ra = NULL;
+    struct list_head *rap;
+
+    if (list_empty(&free_head)) {
+         /* Replace with LRU. */
+         struct raparms *prev, *next;
+         ra = list_entry(lru_head.prev, struct raparms, p_lru);
+         prev = ra->p_hash_prev,
+         next = ra->p_hash_next;
+         prev->p_hash_next = next;
+         next->p_hash_prev = prev;
+         ra->p_hash_next = NULL;
+         ra->p_hash_prev = NULL;
+         list_del(lru_head.prev);
+    } else {
+         ra = list_entry(free_head.next, struct raparms, p_lru);
+         list_del(free_head.next);
+    }
+
+    memset(ra, 0, sizeof(*ra));
+    ra->p_dev = dev;
+    ra->p_ino = ino;
+    rap = (struct list_head *) &hash_list[REQHASH(ino, dev)];
+    ra->p_hash_next = (struct raparms *)(rap->next);
+    ra->p_hash_prev = (struct raparms *) rap;
+    ((struct raparms *)(rap->next))->p_hash_prev = ra;
+    rap->next = (struct list_head *)ra;
+
+    list_add(&ra->p_lru, &lru_head);
+    return ra;
+}
+
+/*
+ * Try to find an entry matching the current call in the cache. When none
+ * is found, we grab the oldest unlocked entry off the LRU list.
+ * Note that no operation within the loop may sleep.
+ */
+struct raparms *
+nfsd_get_raparms(dev_t dev, ino_t ino)
+{
+    struct raparms *rahead;
+    struct raparms *ra = NULL;
+
+    spin_lock(&racache_lock);
+
+    ra = rahead = (struct raparms *) &hash_list[REQHASH(ino, dev)];
+    while ((ra = ra->p_hash_next) != rahead) {
+              if ((ra->p_ino == ino) && (ra->p_dev == dev)) {
+              /* Do LRU reordering */
+              list_del(&ra->p_lru);
+              list_add(&ra->p_lru, &lru_head);
+              nfsdstats.ra_hits++;
+              goto found;
+         }
+    }
+
+    /* Did not find one. Get a new item and insert it into the hash table. */
+    ra = nfsd_racache_insert(ino, dev);
+    nfsdstats.ra_misses++;
+found:
+    spin_unlock(&racache_lock);
+    return ra;
+}

Ying Chen

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
