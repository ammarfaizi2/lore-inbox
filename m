Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262339AbVCBQf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262339AbVCBQf2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 11:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVCBQf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 11:35:27 -0500
Received: from fire.osdl.org ([65.172.181.4]:20147 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262339AbVCBQdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 11:33:37 -0500
Date: Wed, 2 Mar 2005 08:32:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: justin@expertron.co.za, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: Tracing memory leaks (slabs) in 2.6.9+ kernels?
Message-Id: <20050302083222.058ce1b9.akpm@osdl.org>
In-Reply-To: <87ekeyb2bn.fsf@devron.myhome.or.jp>
References: <4225768B.3010005@expertron.co.za>
	<20050302012444.4ed05c23.akpm@osdl.org>
	<87ekeyb2bn.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
>  > +		slab_bufctl(slabp)[objnr] = (unsigned long)caller;
> 
>  Umm... this patch looks strange..
> 
>  slab_bufctl() returns "kmem_bufctl_t *", but kmem_bufctl_t is
>  "unsigned short".

Good point.   This seems to work.


From: Manfred Spraul <manfred@colorfullife.com>

With the patch applied,

	echo "size-4096 0 0 0" > /proc/slabinfo

walks the objects in the size-4096 slab, printing out the calling address
of whoever allocated that object.

It is for leak detection.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-alpha/types.h   |    2 -
 25-akpm/include/asm-arm/types.h     |    2 -
 25-akpm/include/asm-arm26/types.h   |    2 -
 25-akpm/include/asm-cris/types.h    |    2 -
 25-akpm/include/asm-frv/types.h     |    2 -
 25-akpm/include/asm-h8300/types.h   |    2 -
 25-akpm/include/asm-i386/types.h    |    2 -
 25-akpm/include/asm-ia64/types.h    |    2 -
 25-akpm/include/asm-m32r/types.h    |    2 -
 25-akpm/include/asm-m68k/types.h    |    2 -
 25-akpm/include/asm-mips/types.h    |    2 -
 25-akpm/include/asm-parisc/types.h  |    2 -
 25-akpm/include/asm-ppc/types.h     |    2 -
 25-akpm/include/asm-ppc64/types.h   |    2 -
 25-akpm/include/asm-s390/types.h    |    2 -
 25-akpm/include/asm-sh/types.h      |    2 -
 25-akpm/include/asm-sh64/types.h    |    2 -
 25-akpm/include/asm-sparc/types.h   |    2 -
 25-akpm/include/asm-sparc64/types.h |    2 -
 25-akpm/include/asm-v850/types.h    |    2 -
 25-akpm/include/asm-x86_64/types.h  |    2 -
 25-akpm/mm/slab.c                   |   40 ++++++++++++++++++++++++++++++++++--
 22 files changed, 59 insertions(+), 23 deletions(-)

diff -puN include/asm-alpha/types.h~slab-leak-detector include/asm-alpha/types.h
--- 25/include/asm-alpha/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-alpha/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -56,7 +56,7 @@ typedef unsigned long u64;
 typedef u64 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
diff -puN include/asm-arm26/types.h~slab-leak-detector include/asm-arm26/types.h
--- 25/include/asm-arm26/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-arm26/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -52,7 +52,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-arm/types.h~slab-leak-detector include/asm-arm/types.h
--- 25/include/asm-arm/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-arm/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -52,7 +52,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-cris/types.h~slab-leak-detector include/asm-cris/types.h
--- 25/include/asm-cris/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-cris/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -52,7 +52,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-frv/types.h~slab-leak-detector include/asm-frv/types.h
--- 25/include/asm-frv/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-frv/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -65,7 +65,7 @@ typedef u64 u_quad_t;
 
 typedef u32 dma_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-h8300/types.h~slab-leak-detector include/asm-h8300/types.h
--- 25/include/asm-h8300/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-h8300/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -58,7 +58,7 @@ typedef u32 dma_addr_t;
 #define HAVE_SECTOR_T
 typedef u64 sector_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __KERNEL__ */
 
diff -puN include/asm-i386/types.h~slab-leak-detector include/asm-i386/types.h
--- 25/include/asm-i386/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-i386/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -63,7 +63,7 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-ia64/types.h~slab-leak-detector include/asm-ia64/types.h
--- 25/include/asm-ia64/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-ia64/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -67,7 +67,7 @@ typedef __u64 u64;
 
 typedef u64 dma_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 # endif /* __KERNEL__ */
 #endif /* !__ASSEMBLY__ */
diff -puN include/asm-m32r/types.h~slab-leak-detector include/asm-m32r/types.h
--- 25/include/asm-m32r/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-m32r/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -55,7 +55,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-m68k/types.h~slab-leak-detector include/asm-m68k/types.h
--- 25/include/asm-m68k/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-m68k/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -60,7 +60,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-mips/types.h~slab-leak-detector include/asm-mips/types.h
--- 25/include/asm-mips/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-mips/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -99,7 +99,7 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-parisc/types.h~slab-leak-detector include/asm-parisc/types.h
--- 25/include/asm-parisc/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-parisc/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -56,7 +56,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-ppc64/types.h~slab-leak-detector include/asm-ppc64/types.h
--- 25/include/asm-ppc64/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-ppc64/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -72,7 +72,7 @@ typedef struct {
 	unsigned long env;
 } func_descr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff -puN include/asm-ppc/types.h~slab-leak-detector include/asm-ppc/types.h
--- 25/include/asm-ppc/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-ppc/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -62,7 +62,7 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-s390/types.h~slab-leak-detector include/asm-s390/types.h
--- 25/include/asm-s390/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-s390/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -79,7 +79,7 @@ typedef unsigned  long u64;
 
 typedef u32 dma_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #ifndef __s390x__
 typedef union {
diff -puN include/asm-sh64/types.h~slab-leak-detector include/asm-sh64/types.h
--- 25/include/asm-sh64/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-sh64/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -65,7 +65,7 @@ typedef u32 dma_addr_t;
 #endif
 typedef u64 dma64_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-sh/types.h~slab-leak-detector include/asm-sh/types.h
--- 25/include/asm-sh/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-sh/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -58,7 +58,7 @@ typedef u64 sector_t;
 #define HAVE_SECTOR_T
 #endif
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-sparc64/types.h~slab-leak-detector include/asm-sparc64/types.h
--- 25/include/asm-sparc64/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-sparc64/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -56,7 +56,7 @@ typedef unsigned long u64;
 typedef u32 dma_addr_t;
 typedef u64 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-sparc/types.h~slab-leak-detector include/asm-sparc/types.h
--- 25/include/asm-sparc/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-sparc/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -54,7 +54,7 @@ typedef unsigned long long u64;
 typedef u32 dma_addr_t;
 typedef u32 dma64_addr_t;
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN include/asm-v850/types.h~slab-leak-detector include/asm-v850/types.h
--- 25/include/asm-v850/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-v850/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -59,7 +59,7 @@ typedef unsigned long long u64;
 
 typedef u32 dma_addr_t;
 
-typedef unsigned int kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* !__ASSEMBLY__ */
 
diff -puN include/asm-x86_64/types.h~slab-leak-detector include/asm-x86_64/types.h
--- 25/include/asm-x86_64/types.h~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/include/asm-x86_64/types.h	2005-03-02 08:30:59.000000000 -0800
@@ -51,7 +51,7 @@ typedef u64 dma_addr_t;
 typedef u64 sector_t;
 #define HAVE_SECTOR_T
 
-typedef unsigned short kmem_bufctl_t;
+typedef unsigned long kmem_bufctl_t;
 
 #endif /* __ASSEMBLY__ */
 
diff -puN mm/slab.c~slab-leak-detector mm/slab.c
--- 25/mm/slab.c~slab-leak-detector	2005-03-02 08:30:59.000000000 -0800
+++ 25-akpm/mm/slab.c	2005-03-02 08:30:59.000000000 -0800
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

