Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265721AbSJaXNd>; Thu, 31 Oct 2002 18:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbSJaXN3>; Thu, 31 Oct 2002 18:13:29 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:33739 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265611AbSJaXL3>;
	Thu, 31 Oct 2002 18:11:29 -0500
Message-ID: <3DC1BA20.4050403@colorfullife.com>
Date: Fri, 01 Nov 2002 00:17:52 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] slab ctor prototype change
Content-Type: multipart/mixed;
 boundary="------------050900020002010500030604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050900020002010500030604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The patch adds a return value to the ctor callback for custom slab 
caches: this is needed for complex constructors, for example for
constructors that internally allocate further memory.

This was always the intention of the constructors - the GFP_ATOMIC flag 
is forwarded to the constructor, but without the ability to fail
it was useless.
The patch is quite large because it changes the prototype of the slab 
constructor, and every filesystem has a custom slab with a constructor.

Sent to Linus a few minutes ago.

--
    Manfred

--------------050900020002010500030604
Content-Type: text/plain;
 name="patch-slab-fail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-fail"

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 5
//  SUBLEVEL = 45
//  EXTRAVERSION =
--- 2.5/include/linux/slab.h	Sat Oct 26 21:02:12 2002
+++ build-2.5/include/linux/slab.h	Thu Oct 31 19:18:00 2002
@@ -50,8 +50,8 @@
 
 extern kmem_cache_t *kmem_find_general_cachep(size_t, int gfpflags);
 extern kmem_cache_t *kmem_cache_create(const char *, size_t, size_t, unsigned long,
-				       void (*)(void *, kmem_cache_t *, unsigned long),
-				       void (*)(void *, kmem_cache_t *, unsigned long));
+				       int (*ctor)(void *, kmem_cache_t *, unsigned long),
+				       void (*dtor)(void *, kmem_cache_t *, unsigned long));
 extern int kmem_cache_destroy(kmem_cache_t *);
 extern int kmem_cache_shrink(kmem_cache_t *);
 extern void *kmem_cache_alloc(kmem_cache_t *, int);
--- 2.5/mm/slab.c	Thu Oct 31 18:48:19 2002
+++ build-2.5/mm/slab.c	Thu Oct 31 19:15:23 2002
@@ -255,7 +255,7 @@
 	unsigned int		dflags;		/* dynamic flags */
 
 	/* constructor func */
-	void (*ctor)(void *, kmem_cache_t *, unsigned long);
+	int (*ctor)(void *, kmem_cache_t *, unsigned long);
 
 	/* de-constructor func */
 	void (*dtor)(void *, kmem_cache_t *, unsigned long);
@@ -822,6 +822,7 @@
  * Cannot be called within a int, but can be interrupted.
  * The @ctor is run when new pages are allocated by the cache
  * and the @dtor is run before the pages are handed back.
+ * The @ctor must return 0 to indicate a successful initialization.
  *
  * @name must be valid until the cache is destroyed. This implies that
  * the module calling this has to destroy the cache before getting 
@@ -844,7 +845,7 @@
  */
 kmem_cache_t *
 kmem_cache_create (const char *name, size_t size, size_t offset,
-	unsigned long flags, void (*ctor)(void*, kmem_cache_t *, unsigned long),
+	unsigned long flags, int (*ctor)(void*, kmem_cache_t *, unsigned long),
 	void (*dtor)(void*, kmem_cache_t *, unsigned long))
 {
 	const char *func_nm = KERN_ERR "kmem_create: ";
@@ -1254,7 +1255,7 @@
 	return (kmem_bufctl_t *)(slabp+1);
 }
 
-static void cache_init_objs (kmem_cache_t * cachep,
+static int cache_init_objs (kmem_cache_t * cachep,
 			struct slab * slabp, unsigned long ctor_flags)
 {
 	int i;
@@ -1277,8 +1278,10 @@
 		 * the same cache which they are a constructor for.
 		 * Otherwise, deadlock. They must also be threaded.
 		 */
-		if (cachep->ctor && !(cachep->flags & SLAB_POISON))
-			cachep->ctor(objp, cachep, ctor_flags);
+		if (cachep->ctor && !(cachep->flags & SLAB_POISON)) {
+			if (cachep->ctor(objp, cachep, ctor_flags) != 0)
+				goto failed;
+		}
 
 		if (cachep->flags & SLAB_RED_ZONE) {
 			objp -= BYTES_PER_WORD;
@@ -1289,13 +1292,29 @@
 				BUG();
 		}
 #else
-		if (cachep->ctor)
-			cachep->ctor(objp, cachep, ctor_flags);
+		if (cachep->ctor) {
+			if (cachep->ctor(objp, cachep, ctor_flags) != 0)
+				goto failed;
+		}
 #endif
 		slab_bufctl(slabp)[i] = i+1;
 	}
 	slab_bufctl(slabp)[i-1] = BUFCTL_END;
 	slabp->free = 0;
+	return 0;
+failed:
+	if (cachep->dtor) {
+		i--;
+		for (;i >= 0;i--) {
+			void* objp = slabp->s_mem+cachep->objsize*i;
+#if DEBUG
+			if (cachep->flags & SLAB_RED_ZONE)
+				objp += BYTES_PER_WORD;
+#endif
+			cachep->dtor(objp, cachep, 0);
+		}
+	}
+	return -1;
 }
 
 static void kmem_flagcheck(kmem_cache_t *cachep, int flags)
@@ -1386,7 +1405,8 @@
 		page++;
 	} while (--i);
 
-	cache_init_objs(cachep, slabp, ctor_flags);
+	if (cache_init_objs(cachep, slabp, ctor_flags) < 0)
+		goto opps2;
 
 	if (local_flags & __GFP_WAIT)
 		local_irq_disable();
@@ -1399,6 +1419,9 @@
 	list3_data(cachep)->free_objects += cachep->num;
 	spin_unlock(&cachep->spinlock);
 	return 1;
+opps2:
+	if (OFF_SLAB(cachep))
+		kmem_cache_free(cachep->slabp_cache, slabp);
 opps1:
 	kmem_freepages(cachep, objp);
 failed:
@@ -1600,6 +1623,30 @@
 #endif
 }
 
+#if DEBUG
+/*
+ * Return an object to the slab lists if the ctor failed.
+ * Debug only, doesn't have to be efficient.
+ */
+static void cache_return_obj (kmem_cache_t *cachep, void *objp)
+{
+	unsigned long flags;
+	if (cachep->flags & SLAB_RED_ZONE) {
+		objp -= BYTES_PER_WORD;
+		/* Set alloc red-zone, and check old one. */
+		if (xchg((unsigned long *)objp, RED_MAGIC1) !=
+							 RED_MAGIC2)
+			BUG();
+		if (xchg((unsigned long *)(objp+cachep->objsize -
+			  BYTES_PER_WORD), RED_MAGIC1) != RED_MAGIC2)
+			BUG();
+	}
+	local_irq_save(flags);
+	free_block(cachep, &objp, 1);
+	local_irq_restore(flags);
+}
+#endif
+
 static inline void *cache_alloc_debugcheck_after (kmem_cache_t *cachep, unsigned long flags, void *objp)
 {
 #if DEBUG
@@ -1624,7 +1671,10 @@
 		if (!flags & __GFP_WAIT)
 			ctor_flags |= SLAB_CTOR_ATOMIC;
 
-		cachep->ctor(objp, cachep, ctor_flags);
+		if (cachep->ctor(objp, cachep, ctor_flags) != 0) {
+			cache_return_obj(cachep, objp);
+			objp = NULL;
+		}
 	}	
 #endif
 	return objp;
--- 2.5/./fs/xfs/linux/xfs_super.c	Sat Oct 26 21:11:33 2002
+++ build-2.5/./fs/xfs/linux/xfs_super.c	Thu Oct 31 19:33:24 2002
@@ -362,7 +362,7 @@
 	kmem_cache_free(linvfs_inode_cachep, LINVFS_GET_VP(inode));
 }
 
-STATIC void
+STATIC int 
 init_once(
 	void			*data,
 	kmem_cache_t		*cachep,
@@ -373,6 +373,7 @@
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(LINVFS_GET_IP(vp));
+	return 0;
 }
 
 STATIC int
--- 2.5/./fs/jfs/super.c	Sat Oct 26 21:04:38 2002
+++ build-2.5/./fs/jfs/super.c	Thu Oct 31 19:23:56 2002
@@ -395,7 +395,7 @@
 extern void txExit(void);
 extern void metapage_exit(void);
 
-static void init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void *foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct jfs_inode_info *jfs_ip = (struct jfs_inode_info *) foo;
 
@@ -409,6 +409,7 @@
 		jfs_ip->active_ag = -1;
 		inode_init_once(&jfs_ip->vfs_inode);
 	}
+	return 0;
 }
 
 static int __init init_jfs_fs(void)
--- 2.5/./fs/jfs/jfs_metapage.c	Sun Sep 22 06:25:04 2002
+++ build-2.5/./fs/jfs/jfs_metapage.c	Thu Oct 31 19:28:32 2002
@@ -90,7 +90,7 @@
 static kmem_cache_t *metapage_cache;
 static mempool_t *metapage_mempool;
 
-static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+static int init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
 {
 	struct metapage *mp = (struct metapage *)foo;
 
@@ -105,6 +105,7 @@
 		set_bit(META_free, &mp->flag);
 		init_waitqueue_head(&mp->wait);
 	}
+	return 0;
 }
 
 static inline struct metapage *alloc_metapage(int no_wait)
--- 2.5/./fs/nfs/inode.c	Sat Oct 26 21:12:08 2002
+++ build-2.5/./fs/nfs/inode.c	Thu Oct 31 19:22:14 2002
@@ -1548,7 +1548,7 @@
 	kmem_cache_free(nfs_inode_cachep, NFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct nfs_inode *nfsi = (struct nfs_inode *) foo;
 
@@ -1565,6 +1565,7 @@
 		nfsi->npages = 0;
 		init_waitqueue_head(&nfsi->nfs_i_wait);
 	}
+	return 0;
 }
  
 int nfs_init_inodecache(void)
--- 2.5/./fs/hfs/super.c	Sat Oct 26 21:04:37 2002
+++ build-2.5/./fs/hfs/super.c	Thu Oct 31 19:23:26 2002
@@ -58,13 +58,14 @@
 	kmem_cache_free(hfs_inode_cachep, HFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct hfs_inode_info *ei = (struct hfs_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/ufs/super.c	Sat Oct 26 21:04:41 2002
+++ build-2.5/./fs/ufs/super.c	Thu Oct 31 19:24:49 2002
@@ -1014,13 +1014,14 @@
 	kmem_cache_free(ufs_inode_cachep, UFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct ufs_inode_info *ei = (struct ufs_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/jffs2/super.c	Sat Oct 26 21:04:38 2002
+++ build-2.5/./fs/jffs2/super.c	Thu Oct 31 19:23:46 2002
@@ -46,7 +46,7 @@
 	kmem_cache_free(jffs2_inode_cachep, JFFS2_INODE_INFO(inode));
 }
 
-static void jffs2_i_init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int jffs2_i_init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct jffs2_inode_info *ei = (struct jffs2_inode_info *) foo;
 
@@ -55,6 +55,7 @@
 		init_MUTEX(&ei->sem);
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
 
 static struct super_operations jffs2_super_operations =
--- 2.5/./fs/coda/inode.c	Sat Oct 26 21:04:35 2002
+++ build-2.5/./fs/coda/inode.c	Thu Oct 31 19:27:54 2002
@@ -56,13 +56,14 @@
 	kmem_cache_free(coda_inode_cachep, ITOC(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct coda_inode_info *ei = (struct coda_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 int coda_init_inodecache(void)
--- 2.5/./fs/ext2/super.c	Thu Oct 31 18:37:21 2002
+++ build-2.5/./fs/ext2/super.c	Thu Oct 31 19:21:45 2002
@@ -165,7 +165,7 @@
 	kmem_cache_free(ext2_inode_cachep, EXT2_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct ext2_inode_info *ei = (struct ext2_inode_info *) foo;
 
@@ -174,6 +174,7 @@
 		rwlock_init(&ei->i_meta_lock);
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/adfs/super.c	Sat Oct 26 21:04:33 2002
+++ build-2.5/./fs/adfs/super.c	Thu Oct 31 19:22:31 2002
@@ -220,13 +220,14 @@
 	kmem_cache_free(adfs_inode_cachep, ADFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct adfs_inode_info *ei = (struct adfs_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/udf/super.c	Sat Oct 26 21:04:41 2002
+++ build-2.5/./fs/udf/super.c	Thu Oct 31 19:24:39 2002
@@ -127,13 +127,14 @@
 	kmem_cache_free(udf_inode_cachep, UDF_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct udf_inode_info *ei = (struct udf_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/proc/inode.c	Sat Oct 26 21:02:10 2002
+++ build-2.5/./fs/proc/inode.c	Thu Oct 31 19:30:55 2002
@@ -109,13 +109,14 @@
 	kmem_cache_free(proc_inode_cachep, PROC_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct proc_inode *ei = (struct proc_inode *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 int __init proc_init_inodecache(void)
--- 2.5/./fs/bfs/inode.c	Sat Oct 26 21:04:34 2002
+++ build-2.5/./fs/bfs/inode.c	Thu Oct 31 19:26:58 2002
@@ -226,13 +226,14 @@
 	kmem_cache_free(bfs_inode_cachep, BFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct bfs_inode_info *bi = foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&bi->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/reiserfs/super.c	Sat Oct 26 21:04:40 2002
+++ build-2.5/./fs/reiserfs/super.c	Thu Oct 31 19:24:27 2002
@@ -424,7 +424,7 @@
 	kmem_cache_free(reiserfs_inode_cachep, REISERFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct reiserfs_inode_info *ei = (struct reiserfs_inode_info *) foo;
 
@@ -433,6 +433,7 @@
 		INIT_LIST_HEAD(&ei->i_prealloc_list) ;
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/ncpfs/inode.c	Sat Oct 26 21:04:38 2002
+++ build-2.5/./fs/ncpfs/inode.c	Thu Oct 31 19:34:02 2002
@@ -56,7 +56,7 @@
 	kmem_cache_free(ncp_inode_cachep, NCP_FINFO(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct ncp_inode_info *ei = (struct ncp_inode_info *) foo;
 
@@ -65,6 +65,7 @@
 		init_MUTEX(&ei->open_sem);
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/ntfs/super.c	Sat Oct 26 21:04:39 2002
+++ build-2.5/./fs/ntfs/super.c	Thu Oct 31 19:24:16 2002
@@ -1598,7 +1598,7 @@
 kmem_cache_t *ntfs_big_inode_cache;
 
 /* Init once constructor for the inode slab cache. */
-static void ntfs_big_inode_init_once(void *foo, kmem_cache_t *cachep,
+static int ntfs_big_inode_init_once(void *foo, kmem_cache_t *cachep,
 		unsigned long flags)
 {
 	ntfs_inode *ni = (ntfs_inode *)foo;
@@ -1606,6 +1606,7 @@
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 			SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(VFS_I(ni));
+	return 0;
 }
 
 /*
--- 2.5/./fs/sysv/inode.c	Sat Oct 26 21:04:40 2002
+++ build-2.5/./fs/sysv/inode.c	Thu Oct 31 19:34:13 2002
@@ -301,13 +301,14 @@
 	kmem_cache_free(sysv_inode_cachep, SYSV_I(inode));
 }
 
-static void init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
+static int init_once(void *p, kmem_cache_t *cachep, unsigned long flags)
 {
 	struct sysv_inode_info *si = (struct sysv_inode_info *)p;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 			SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&si->vfs_inode);
+	return 0;
 }
 
 struct super_operations sysv_sops = {
--- 2.5/./fs/hpfs/super.c	Sat Oct 26 21:04:37 2002
+++ build-2.5/./fs/hpfs/super.c	Thu Oct 31 19:23:33 2002
@@ -174,7 +174,7 @@
 	kmem_cache_free(hpfs_inode_cachep, hpfs_i(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct hpfs_inode_info *ei = (struct hpfs_inode_info *) foo;
 
@@ -183,6 +183,7 @@
 		init_MUTEX(&ei->i_sem);
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/fat/inode.c	Thu Oct 31 18:48:07 2002
+++ build-2.5/./fs/fat/inode.c	Thu Oct 31 19:26:41 2002
@@ -672,7 +672,7 @@
 	kmem_cache_free(fat_inode_cachep, MSDOS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct msdos_inode_info *ei = (struct msdos_inode_info *) foo;
 
@@ -681,6 +681,7 @@
 		INIT_LIST_HEAD(&ei->i_fat_hash);
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
  
 int __init fat_init_inodecache(void)
--- 2.5/./fs/ext3/super.c	Thu Oct 31 18:48:06 2002
+++ build-2.5/./fs/ext3/super.c	Thu Oct 31 19:23:16 2002
@@ -464,7 +464,7 @@
 	kmem_cache_free(ext3_inode_cachep, EXT3_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct ext3_inode_info *ei = (struct ext3_inode_info *) foo;
 
@@ -474,6 +474,7 @@
 		init_rwsem(&ei->truncate_sem);
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/smbfs/inode.c	Sat Oct 26 21:04:40 2002
+++ build-2.5/./fs/smbfs/inode.c	Thu Oct 31 19:34:28 2002
@@ -64,13 +64,14 @@
 	kmem_cache_free(smb_inode_cachep, SMB_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct smb_inode_info *ei = (struct smb_inode_info *) foo;
 	unsigned long flagmask = SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR;
 
 	if ((flags & flagmask) == SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/isofs/inode.c	Sat Oct 26 21:04:37 2002
+++ build-2.5/./fs/isofs/inode.c	Thu Oct 31 19:28:09 2002
@@ -92,13 +92,14 @@
 	kmem_cache_free(isofs_inode_cachep, ISOFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct iso_inode_info *ei = (struct iso_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/efs/super.c	Sat Oct 26 21:04:35 2002
+++ build-2.5/./fs/efs/super.c	Thu Oct 31 19:23:03 2002
@@ -44,13 +44,14 @@
 	kmem_cache_free(efs_inode_cachep, INODE_INFO(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct efs_inode_info *ei = (struct efs_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/affs/super.c	Sat Oct 26 21:04:33 2002
+++ build-2.5/./fs/affs/super.c	Thu Oct 31 19:22:41 2002
@@ -100,7 +100,7 @@
 	kmem_cache_free(affs_inode_cachep, AFFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct affs_inode_info *ei = (struct affs_inode_info *) foo;
 
@@ -110,6 +110,7 @@
 		init_MUTEX(&ei->i_ext_lock);
 		inode_init_once(&ei->vfs_inode);
 	}
+	return 0;
 }
 
 static int init_inodecache(void)
--- 2.5/./fs/romfs/inode.c	Sat Oct 26 21:04:40 2002
+++ build-2.5/./fs/romfs/inode.c	Thu Oct 31 19:34:42 2002
@@ -563,13 +563,14 @@
 	kmem_cache_free(romfs_inode_cachep, ROMFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct romfs_inode_info *ei = (struct romfs_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/minix/inode.c	Sat Oct 26 21:04:38 2002
+++ build-2.5/./fs/minix/inode.c	Thu Oct 31 19:28:56 2002
@@ -65,13 +65,14 @@
 	kmem_cache_free(minix_inode_cachep, minix_i(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct minix_inode_info *ei = (struct minix_inode_info *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)
--- 2.5/./fs/qnx4/inode.c	Sat Oct 26 21:11:32 2002
+++ build-2.5/./fs/qnx4/inode.c	Thu Oct 31 19:31:26 2002
@@ -520,7 +520,7 @@
 	kmem_cache_free(qnx4_inode_cachep, qnx4_i(inode));
 }
 
-static void init_once(void *foo, kmem_cache_t * cachep,
+static int init_once(void *foo, kmem_cache_t * cachep,
 		      unsigned long flags)
 {
 	struct qnx4_inode_info *ei = (struct qnx4_inode_info *) foo;
@@ -528,6 +528,7 @@
 	if ((flags & (SLAB_CTOR_VERIFY | SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
 
 static int init_inodecache(void)
--- 2.5/./fs/befs/linuxvfs.c	Thu Oct 31 18:48:05 2002
+++ build-2.5/./fs/befs/linuxvfs.c	Thu Oct 31 19:26:12 2002
@@ -293,7 +293,7 @@
         kmem_cache_free(befs_inode_cachep, BEFS_I(inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
         struct befs_inode_info *bi = (struct befs_inode_info *) foo;
 	
@@ -301,6 +301,7 @@
 		            SLAB_CTOR_CONSTRUCTOR) {
 			inode_init_once(&bi->vfs_inode);
 		}
+	return 0;
 }
 
 static void
--- 2.5/./fs/cifs/cifsfs.c	Sat Oct 26 21:04:34 2002
+++ build-2.5/./fs/cifs/cifsfs.c	Thu Oct 31 19:27:30 2002
@@ -296,7 +296,7 @@
 	.release = cifs_closedir,
 };
 
-static void
+static int 
 cifs_init_once(void *inode, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct cifsInodeInfo *cifsi = (struct cifsInodeInfo *) inode;
@@ -306,6 +306,7 @@
 		inode_init_once(&cifsi->vfs_inode);
 		INIT_LIST_HEAD(&cifsi->lockList);
 	}
+	return 0;
 }
 
 int
--- 2.5/./fs/afs/super.c	Sat Oct 26 21:11:31 2002
+++ build-2.5/./fs/afs/super.c	Thu Oct 31 19:22:51 2002
@@ -541,7 +541,7 @@
  * initialise an inode cache slab element prior to any use
  */
 #if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,0)
-static void afs_i_init_once(void *_vnode, kmem_cache_t *cachep, unsigned long flags)
+static int afs_i_init_once(void *_vnode, kmem_cache_t *cachep, unsigned long flags)
 {
 	afs_vnode_t *vnode = (afs_vnode_t *) _vnode;
 
@@ -554,6 +554,7 @@
 		INIT_LIST_HEAD(&vnode->cb_hash_link);
 		afs_timer_init(&vnode->cb_timeout,&afs_vnode_cb_timed_out_ops);
 	}
+	return 0;
 
 } /* end afs_i_init_once() */
 #endif
--- 2.5/./fs/buffer.c	Thu Oct 31 18:48:06 2002
+++ build-2.5/./fs/buffer.c	Thu Oct 31 19:19:33 2002
@@ -2609,7 +2609,7 @@
 }
 EXPORT_SYMBOL(free_buffer_head);
 
-static void init_buffer_head(void *data, kmem_cache_t *cachep, unsigned long flags)
+static int init_buffer_head(void *data, kmem_cache_t *cachep, unsigned long flags)
 {
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 			    SLAB_CTOR_CONSTRUCTOR) {
@@ -2618,6 +2618,7 @@
 		memset(bh, 0, sizeof(*bh));
 		INIT_LIST_HEAD(&bh->b_assoc_buffers);
 	}
+	return 0;
 }
 
 static void *bh_mempool_alloc(int gfp_mask, void *pool_data)
--- 2.5/./fs/block_dev.c	Thu Oct 31 18:48:05 2002
+++ build-2.5/./fs/block_dev.c	Thu Oct 31 19:19:59 2002
@@ -223,7 +223,7 @@
 	 ((struct block_device *) kmem_cache_alloc(bdev_cachep, SLAB_KERNEL))
 #define destroy_bdev(bdev) kmem_cache_free(bdev_cachep, (bdev))
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct block_device * bdev = (struct block_device *) foo;
 
@@ -234,6 +234,7 @@
 		sema_init(&bdev->bd_sem, 1);
 		INIT_LIST_HEAD(&bdev->bd_inodes);
 	}
+	return 0;
 }
 
 void __init bdev_cache_init(void)
--- 2.5/./fs/char_dev.c	Sun Sep 22 06:25:06 2002
+++ build-2.5/./fs/char_dev.c	Thu Oct 31 19:20:18 2002
@@ -20,7 +20,7 @@
 	 ((struct char_device *) kmem_cache_alloc(cdev_cachep, SLAB_KERNEL))
 #define destroy_cdev(cdev) kmem_cache_free(cdev_cachep, (cdev))
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct char_device * cdev = (struct char_device *) foo;
 
@@ -30,6 +30,7 @@
 		memset(cdev, 0, sizeof(*cdev));
 		sema_init(&cdev->sem, 1);
 	}
+	return 0;
 }
 
 void __init cdev_cache_init(void)
--- 2.5/./fs/inode.c	Thu Oct 31 18:37:22 2002
+++ build-2.5/./fs/inode.c	Thu Oct 31 19:20:40 2002
@@ -181,13 +181,14 @@
 	INIT_LIST_HEAD(&inode->i_data.i_mmap_shared);
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct inode * inode = (struct inode *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(inode);
+	return 0;
 }
 
 /*
--- 2.5/./fs/locks.c	Sat Oct 26 21:12:08 2002
+++ build-2.5/./fs/locks.c	Thu Oct 31 23:17:18 2002
@@ -195,15 +195,16 @@
  * Initialises the fields of the file lock which are invariant for
  * free file_locks.
  */
-static void init_once(void *foo, kmem_cache_t *cache, unsigned long flags)
+static int init_once(void *foo, kmem_cache_t *cache, unsigned long flags)
 {
 	struct file_lock *lock = (struct file_lock *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) !=
 					SLAB_CTOR_CONSTRUCTOR)
-		return;
+		return 0;
 
 	locks_init_lock(lock);
+	return 0;
 }
 
 /*
--- 2.5/./lib/radix-tree.c	Thu Oct 31 18:48:18 2002
+++ build-2.5/./lib/radix-tree.c	Thu Oct 31 19:47:57 2002
@@ -338,9 +338,10 @@
 }
 EXPORT_SYMBOL(radix_tree_delete);
 
-static void radix_tree_node_ctor(void *node, kmem_cache_t *cachep, unsigned long flags)
+static int radix_tree_node_ctor(void *node, kmem_cache_t *cachep, unsigned long flags)
 {
 	memset(node, 0, sizeof(struct radix_tree_node));
+	return 0;
 }
 
 static void *radix_tree_node_pool_alloc(int gfp_mask, void *data)
--- 2.5/./mm/rmap.c	Thu Oct 31 18:37:25 2002
+++ build-2.5/./mm/rmap.c	Thu Oct 31 19:17:53 2002
@@ -514,11 +514,12 @@
  ** functions.
  **/
 
-static void pte_chain_ctor(void *p, kmem_cache_t *cachep, unsigned long flags)
+static int pte_chain_ctor(void *p, kmem_cache_t *cachep, unsigned long flags)
 {
 	struct pte_chain *pc = p;
 
 	memset(pc, 0, sizeof(*pc));
+	return 0;
 }
 
 void __init pte_chain_init(void)
--- 2.5/./mm/shmem.c	Thu Oct 31 18:48:19 2002
+++ build-2.5/./mm/shmem.c	Thu Oct 31 19:35:35 2002
@@ -1739,7 +1739,7 @@
 	kmem_cache_free(shmem_inode_cachep, SHMEM_I(inode));
 }
 
-static void init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
+static int init_once(void *foo, kmem_cache_t *cachep, unsigned long flags)
 {
 	struct shmem_inode_info *p = (struct shmem_inode_info *) foo;
 
@@ -1747,6 +1747,7 @@
 	    SLAB_CTOR_CONSTRUCTOR) {
 		inode_init_once(&p->vfs_inode);
 	}
+	return 0;
 }
 
 static int init_inodecache(void)
--- 2.5/./net/core/skbuff.c	Thu Oct 31 18:48:20 2002
+++ build-2.5/./net/core/skbuff.c	Thu Oct 31 19:47:19 2002
@@ -225,7 +225,7 @@
 /*
  *	Slab constructor for a skb head.
  */
-static inline void skb_headerinit(void *p, kmem_cache_t *cache,
+static inline int skb_headerinit(void *p, kmem_cache_t *cache,
 				  unsigned long flags)
 {
 	struct sk_buff *skb = p;
@@ -257,6 +257,7 @@
 #ifdef CONFIG_NET_SCHED
 	skb->tc_index	  = 0;
 #endif
+	return 0;
 }
 
 static void skb_drop_fraglist(struct sk_buff *skb)
--- 2.5/./net/socket.c	Thu Oct 31 18:48:24 2002
+++ build-2.5/./net/socket.c	Thu Oct 31 19:35:58 2002
@@ -297,13 +297,14 @@
 			container_of(inode, struct socket_alloc, vfs_inode));
 }
 
-static void init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
+static int init_once(void * foo, kmem_cache_t * cachep, unsigned long flags)
 {
 	struct socket_alloc *ei = (struct socket_alloc *) foo;
 
 	if ((flags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR)
 		inode_init_once(&ei->vfs_inode);
+	return 0;
 }
  
 static int init_inodecache(void)

--------------050900020002010500030604--

