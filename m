Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbVJaI3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbVJaI3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 03:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbVJaI3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 03:29:35 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:23428 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932151AbVJaI3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 03:29:34 -0500
Date: Mon, 31 Oct 2005 10:29:30 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: rename kmem_cache_s to kmem_cache
In-Reply-To: <20051031011501.3caeba18.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0510311024340.11869@sbz-30.cs.Helsinki.FI>
References: <ip33z2.vtcnft.4nw33ugftrecz8r4nb1via846.beaver@cs.helsinki.fi>
 <20051031011501.3caeba18.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 31 Oct 2005, Andrew Morton wrote:
> Well I stared at these diffs for a long time.  They don't really add a lot
> of value to the kernel and they do risk breaking other people's patches. 
> Generally they have a high hassle/value ratio.

I would sort of disagree with this. The slab allocator wants cleaning up 
badly and while killing a typedef is not a lot, it's a start...

On Mon, 31 Oct 2005, Andrew Morton wrote: 
> I could merge them up and see how it goes, but given that there are many
> more kmem_cache_t->struct kmem_cache conversions to go, and that I hit
> seven rejects in mm/slab.c, I think I'll duck the patches, sorry.

Please consider merging this patch that just renames kmem_cache_s to 
kmem_cache. I can kill try to kill kmem_cache_t incrementally over time.

On Mon, 31 Oct 2005, Andrew Morton wrote: 
> > -void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags)
> > +void filp_ctor(void * objp, struct kmem_cache *cachep, unsigned long cflags)
> 
> See the inconsistent coding style there?  This would have been a zero-cost
> opportunity to fix that up.  (Nuke the space after the asterisk).

As an added bonus, the following patch does that. :-)

				Pekka

[PATCH] mm: rename kmem_cache_s to kmem_cache

This patch renames struct kmem_cache_s to kmem_cache so we can start using it
instead of kmem_cache_t typedef.

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 Documentation/magic-number.txt |    2 +-
 fs/file_table.c                |    4 ++--
 fs/freevxfs/vxfs_extern.h      |    4 ++--
 fs/xfs/linux-2.6/kmem.h        |    4 ++--
 include/linux/file.h           |    6 +++---
 include/linux/slab.h           |    2 +-
 mm/slab.c                      |    2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)


Index: 2.6/Documentation/magic-number.txt
===================================================================
--- 2.6.orig/Documentation/magic-number.txt
+++ 2.6/Documentation/magic-number.txt
@@ -120,7 +120,7 @@ ISDN_NET_MAGIC        0x49344C02  isdn_n
 SAVEKMSG_MAGIC2       0x4B4D5347  savekmsg          arch/*/amiga/config.c
 STLI_BOARDMAGIC       0x4bc6c825  stlibrd           include/linux/istallion.h
 CS_STATE_MAGIC        0x4c4f4749  cs_state          sound/oss/cs46xx.c
-SLAB_C_MAGIC          0x4f17a36d  kmem_cache_s      mm/slab.c
+SLAB_C_MAGIC          0x4f17a36d  kmem_cache        mm/slab.c
 COW_MAGIC             0x4f4f4f4d  cow_header_v1     arch/um/drivers/ubd_user.c
 I810_CARD_MAGIC       0x5072696E  i810_card         sound/oss/i810_audio.c
 TRIDENT_CARD_MAGIC    0x5072696E  trident_card      sound/oss/trident.c
Index: 2.6/fs/file_table.c
===================================================================
--- 2.6.orig/fs/file_table.c
+++ 2.6/fs/file_table.c
@@ -35,7 +35,7 @@ static DEFINE_SPINLOCK(filp_count_lock);
  * context and must be fully threaded - use a local spinlock
  * to protect files_stat.nr_files
  */
-void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags)
+void filp_ctor(void *objp, struct kmem_cache *cachep, unsigned long cflags)
 {
 	if ((cflags & (SLAB_CTOR_VERIFY|SLAB_CTOR_CONSTRUCTOR)) ==
 	    SLAB_CTOR_CONSTRUCTOR) {
@@ -46,7 +46,7 @@ void filp_ctor(void * objp, struct kmem_
 	}
 }
 
-void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags)
+void filp_dtor(void *objp, struct kmem_cache *cachep, unsigned long dflags)
 {
 	unsigned long flags;
 	spin_lock_irqsave(&filp_count_lock, flags);
Index: 2.6/fs/freevxfs/vxfs_extern.h
===================================================================
--- 2.6.orig/fs/freevxfs/vxfs_extern.h
+++ 2.6/fs/freevxfs/vxfs_extern.h
@@ -38,7 +38,7 @@
  */
 
 
-struct kmem_cache_s;
+struct kmem_cache;
 struct super_block;
 struct vxfs_inode_info;
 struct inode;
@@ -51,7 +51,7 @@ extern daddr_t			vxfs_bmap1(struct inode
 extern int			vxfs_read_fshead(struct super_block *);
 
 /* vxfs_inode.c */
-extern struct kmem_cache_s	*vxfs_inode_cachep;
+extern struct kmem_cache	*vxfs_inode_cachep;
 extern void			vxfs_dumpi(struct vxfs_inode_info *, ino_t);
 extern struct inode *		vxfs_get_fake_inode(struct super_block *,
 					struct vxfs_inode_info *);
Index: 2.6/fs/xfs/linux-2.6/kmem.h
===================================================================
--- 2.6.orig/fs/xfs/linux-2.6/kmem.h
+++ 2.6/fs/xfs/linux-2.6/kmem.h
@@ -44,8 +44,8 @@
 #define KM_NOFS		0x0004u
 #define KM_MAYFAIL	0x0008u
 
-#define	kmem_zone	kmem_cache_s
-#define kmem_zone_t	kmem_cache_t
+#define	kmem_zone	kmem_cache
+#define kmem_zone_t	struct kmem_cache
 
 typedef unsigned long xfs_pflags_t;
 
Index: 2.6/include/linux/file.h
===================================================================
--- 2.6.orig/include/linux/file.h
+++ 2.6/include/linux/file.h
@@ -59,9 +59,9 @@ extern void FASTCALL(set_close_on_exec(u
 extern void put_filp(struct file *);
 extern int get_unused_fd(void);
 extern void FASTCALL(put_unused_fd(unsigned int fd));
-struct kmem_cache_s;
-extern void filp_ctor(void * objp, struct kmem_cache_s *cachep, unsigned long cflags);
-extern void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags);
+struct kmem_cache;
+extern void filp_ctor(void * objp, struct kmem_cache *cachep, unsigned long cflags);
+extern void filp_dtor(void * objp, struct kmem_cache *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
 extern void free_fd_array(struct file **, int);
Index: 2.6/include/linux/slab.h
===================================================================
--- 2.6.orig/include/linux/slab.h
+++ 2.6/include/linux/slab.h
@@ -9,7 +9,7 @@
 
 #if	defined(__KERNEL__)
 
-typedef struct kmem_cache_s kmem_cache_t;
+typedef struct kmem_cache kmem_cache_t;
 
 #include	<linux/config.h>	/* kmalloc_sizes.h needs CONFIG_ options */
 #include	<linux/gfp.h>
Index: 2.6/mm/slab.c
===================================================================
--- 2.6.orig/mm/slab.c
+++ 2.6/mm/slab.c
@@ -368,7 +368,7 @@ static inline void kmem_list3_init(struc
  * manages a cache.
  */
 	
-struct kmem_cache_s {
+struct kmem_cache {
 /* 1) per-cpu data, touched during every alloc/free */
 	struct array_cache	*array[NR_CPUS];
 	unsigned int		batchcount;
