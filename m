Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317084AbSEXFVd>; Fri, 24 May 2002 01:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317086AbSEXFVc>; Fri, 24 May 2002 01:21:32 -0400
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:23943 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317084AbSEXFV3>; Fri, 24 May 2002 01:21:29 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: [PATCH] XBUG(comment) BUG enhancement
Date: Fri, 24 May 2002 15:24:30 +1000
Message-Id: <E17B7Z0-0003cP-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces XBUG("This is a test!") which causes output like:

	kernel BUG in sched:This is a test!

vs BUG() which causes output like:

	kernel BUG in sched.c:1768!

The important difference is in headers, where the module/objectfile
name is used instead of __FILENAME__, so this patch also replaces all
the BUG occurrances in headers.

================
Name: XBUG macro
Author: Rusty Russell
Status: Tested in 2.5.17

D: Introduces XBUG(comment) and XBUG_ON(comment) macros to PPC and
D: i386.  XBUG prints out module (usually same as objfile without the
D: .o) and the comment.
D: 
D: It also changes every BUG() in the headers files to XBUG(), so that
D: the headers don't include absolute filenames, which allows the
D: kernel compile to use ccache much better.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/asm-i386/page.h working-2.5.17-bug/include/asm-i386/page.h
--- linux-2.5.17/include/asm-i386/page.h	Mon May  6 16:00:10 2002
+++ working-2.5.17-bug/include/asm-i386/page.h	Fri May 24 11:51:23 2002
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 #ifdef CONFIG_X86_USE_3DNOW
 
@@ -98,11 +99,18 @@
 #if 1	/* Set to zero for a slightly smaller kernel */
 #define BUG()				\
  __asm__ __volatile__(	"ud2\n"		\
-			"\t.word %c0\n"	\
+			"\t.long %c0\n"	\
 			"\t.long %c1\n"	\
-			 : : "i" (__LINE__), "i" (__FILE__))
+			 : : "i" (__stringify(__LINE__)), "i" (__FILE__))
+#define XBUG(comment)			\
+ __asm__ __volatile__(	"ud2\n"		\
+			"\t.long %c0\n"	\
+			"\t.long %c1\n"	\
+			: : "i" (comment), "i" (__stringify(KBUILD_BASENAME)))
+
 #else
 #define BUG() __asm__ __volatile__("ud2\n")
+#define XBUG(comment) __asm__ __volatile__("ud2\n")
 #endif
 
 #define PAGE_BUG(page) do { \
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/asm-ppc/page.h working-2.5.17-bug/include/asm-ppc/page.h
--- linux-2.5.17/include/asm-ppc/page.h	Sat May 18 15:53:43 2002
+++ working-2.5.17-bug/include/asm-ppc/page.h	Fri May 24 11:21:40 2002
@@ -11,6 +11,7 @@
 
 #ifdef __KERNEL__
 #include <linux/config.h>
+#include <linux/stringify.h>
 
 /* Be sure to change arch/ppc/Makefile to match */
 #ifdef CONFIG_KERNEL_START_BOOL
@@ -28,9 +29,17 @@
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
 	xmon(0); \
 } while (0)
+#define XBUG(str) do { \
+	printk("kernel BUG %s in %s!\n", str, __stringify(KBUILD_BASENAME)); \
+	xmon(0); \
+} while (0)
 #else
 #define BUG() do { \
 	printk("kernel BUG at %s:%d!\n", __FILE__, __LINE__); \
+	__asm__ __volatile__(".long 0x0"); \
+} while (0)
+#define XBUG(str) do { \
+	printk("kernel BUG %s in %s!\n", str, __stringify(KBUILD_BASENAME)); \
 	__asm__ __volatile__(".long 0x0"); \
 } while (0)
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/arch/i386/kernel/traps.c working-2.5.17-bug/arch/i386/kernel/traps.c
--- linux-2.5.17/arch/i386/kernel/traps.c	Tue Apr 23 11:39:32 2002
+++ working-2.5.17-bug/arch/i386/kernel/traps.c	Fri May 24 12:41:18 2002
@@ -241,11 +241,11 @@
 	printk("\n");
 }	
 
+/* For BUG(), comment is line number. */
 static void handle_BUG(struct pt_regs *regs)
 {
 	unsigned short ud2;
-	unsigned short line;
-	char *file;
+	char *file, *comment;
 	char c;
 	unsigned long eip;
 
@@ -260,20 +260,17 @@
 		goto no_bug;
 	if (ud2 != 0x0b0f)
 		goto no_bug;
-	if (__get_user(line, (unsigned short *)(eip + 2)))
-		goto bug;
-	if (__get_user(file, (char **)(eip + 4)) ||
+	if (__get_user(comment, (char **)(eip + 2)) ||
+		(unsigned long)comment < PAGE_OFFSET || __get_user(c, comment))
+		comment = "<bad comment>";
+	if (__get_user(file, (char **)(eip + 6)) ||
 		(unsigned long)file < PAGE_OFFSET || __get_user(c, file))
 		file = "<bad filename>";
 
-	printk("kernel BUG at %s:%d!\n", file, line);
+	printk("kernel BUG in %s:%s!\n", file, comment);
 
 no_bug:
 	return;
-
-	/* Here we know it was a BUG but file-n-line is unavailable */
-bug:
-	printk("Kernel BUG\n");
 }
 
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/blk.h working-2.5.17-bug/include/linux/blk.h
--- linux-2.5.17/include/linux/blk.h	Thu May 23 18:29:03 2002
+++ working-2.5.17-bug/include/linux/blk.h	Fri May 24 11:58:12 2002
@@ -73,7 +73,7 @@
 		 */
 		blkdev_dequeue_request(rq);
 		if (end_that_request_first(rq, 0, rq->nr_sectors))
-			BUG();
+			XBUG("!end_that_request_first");
 
 		end_that_request_last(rq);
 	}
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/dcache.h working-2.5.17-bug/include/linux/dcache.h
--- linux-2.5.17/include/linux/dcache.h	Thu May 23 18:29:02 2002
+++ working-2.5.17-bug/include/linux/dcache.h	Fri May 24 11:56:12 2002
@@ -256,7 +256,7 @@
 {
 	if (dentry) {
 		if (!atomic_read(&dentry->d_count))
-			BUG();
+			XBUG("zero d_count in dget");
 		atomic_inc(&dentry->d_count);
 	}
 	return dentry;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/device.h working-2.5.17-bug/include/linux/device.h
--- linux-2.5.17/include/linux/device.h	Thu May 23 18:29:36 2002
+++ working-2.5.17-bug/include/linux/device.h	Fri May 24 11:56:16 2002
@@ -144,7 +144,7 @@
  */
 static inline void get_device(struct device * dev)
 {
-	BUG_ON(!atomic_read(&dev->refcount));
+	XBUG_ON(!atomic_read(&dev->refcount), "get_device on zero refnct");
 	atomic_inc(&dev->refcount);
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/highmem.h working-2.5.17-bug/include/linux/highmem.h
--- linux-2.5.17/include/linux/highmem.h	Thu May 23 18:29:03 2002
+++ working-2.5.17-bug/include/linux/highmem.h	Fri May 24 11:56:32 2002
@@ -51,7 +51,7 @@
 	addr = (unsigned long) kmap_atomic(bio_page(bio), KM_BIO_IRQ);
 
 	if (addr & ~PAGE_MASK)
-		BUG();
+		XBUG("bio_kmap_irq on non-page");
 
 	return (char *) addr + bio_offset(bio);
 }
@@ -106,7 +106,7 @@
 	void *kaddr;
 
 	if (offset + size > PAGE_SIZE)
-		BUG();
+		XBUG("memclear_highpage_flush over page");
 
 	kaddr = kmap_atomic(page, KM_USER0);
 	memset((char *)kaddr + offset, 0, size);
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/jbd.h working-2.5.17-bug/include/linux/jbd.h
--- linux-2.5.17/include/linux/jbd.h	Tue May 21 16:33:38 2002
+++ working-2.5.17-bug/include/linux/jbd.h	Fri May 24 11:21:40 2002
@@ -199,10 +199,9 @@
 #define J_ASSERT(assert)						\
 do {									\
 	if (!(assert)) {						\
-		printk (KERN_EMERG					\
-			"Assertion failure in %s() at %s:%d: \"%s\"\n",	\
-			__FUNCTION__, __FILE__, __LINE__, # assert);	\
-		BUG();							\
+		XBUG("Assertion failure in " __FUNCTION__		\
+		     "() at " __FILE__ ":" __stringize(__LINE__)	\
+		     ": " #assert);					\
 	}								\
 } while (0)
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/kernel.h working-2.5.17-bug/include/linux/kernel.h
--- linux-2.5.17/include/linux/kernel.h	Thu May 23 18:29:02 2002
+++ working-2.5.17-bug/include/linux/kernel.h	Fri May 24 11:24:39 2002
@@ -171,4 +171,5 @@
 };
 
 #define BUG_ON(condition) do { if (unlikely((condition)!=0)) BUG(); } while(0)
+#define XBUG_ON(condition, comment) do { if (unlikely((condition)!=0)) XBUG(comment); } while(0)
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/nfs_fs.h working-2.5.17-bug/include/linux/nfs_fs.h
--- linux-2.5.17/include/linux/nfs_fs.h	Thu May 23 18:29:07 2002
+++ working-2.5.17-bug/include/linux/nfs_fs.h	Fri May 24 11:57:52 2002
@@ -256,7 +256,7 @@
 		cred = (struct rpc_cred *)file->private_data;
 #ifdef RPC_DEBUG
 	if (cred && cred->cr_magic != RPCAUTH_CRED_MAGIC)
-		BUG();
+		XBUG("Bad nfs_file_cred magic");
 #endif
 	return cred;
 }
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/nfs_page.h working-2.5.17-bug/include/linux/nfs_page.h
--- linux-2.5.17/include/linux/nfs_page.h	Sat May 18 17:23:39 2002
+++ working-2.5.17-bug/include/linux/nfs_page.h	Fri May 24 11:21:40 2002
@@ -88,8 +88,7 @@
 nfs_unlock_request(struct nfs_page *req)
 {
 	if (!NFS_WBACK_BUSY(req)) {
-		printk(KERN_ERR "NFS: Invalid unlock attempted\n");
-		BUG();
+		XBUG("NFS: Invalid unlock attempted");
 	}
 	smp_mb__before_clear_bit();
 	clear_bit(PG_BUSY, &req->wb_flags);
@@ -109,8 +108,7 @@
 	if (list_empty(&req->wb_list))
 		return;
 	if (!NFS_WBACK_BUSY(req)) {
-		printk(KERN_ERR "NFS: unlocked request attempted removed from list!\n");
-		BUG();
+		XBUG("NFS: unlocked request attempted removed from list!");
 	}
 	list_del_init(&req->wb_list);
 	req->wb_list_head = NULL;
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/quotaops.h working-2.5.17-bug/include/linux/quotaops.h
--- linux-2.5.17/include/linux/quotaops.h	Thu May 23 18:30:40 2002
+++ working-2.5.17-bug/include/linux/quotaops.h	Fri May 24 11:59:33 2002
@@ -45,7 +45,7 @@
 static __inline__ void DQUOT_INIT(struct inode *inode)
 {
 	if (!inode->i_sb)
-		BUG();
+		XBUG("No i_sb in DQUOT_INIT");
 	lock_kernel();
 	if (sb_any_quota_enabled(inode->i_sb) && !IS_NOQUOTA(inode))
 		inode->i_sb->dq_op->initialize(inode, -1);
@@ -57,7 +57,7 @@
 	lock_kernel();
 	if (IS_QUOTAINIT(inode)) {
 		if (!inode->i_sb)
-			BUG();
+			XBUG("No i_sb in DQUOT_DROP");
 		inode->i_sb->dq_op->drop(inode);	/* Ops must be set when there's any quota... */
 	}
 	unlock_kernel();
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/raid/md_k.h working-2.5.17-bug/include/linux/raid/md_k.h
--- linux-2.5.17/include/linux/raid/md_k.h	Tue May 21 16:33:39 2002
+++ working-2.5.17-bug/include/linux/raid/md_k.h	Fri May 24 11:21:40 2002
@@ -36,7 +36,7 @@
 		case RAID1:		return 1;
 		case RAID5:		return 5;
 	}
-	BUG();
+	XBUG("bad pers_to_level");
 	return MD_RESERVED;
 }
 
@@ -78,7 +78,7 @@
 static inline mddev_t * kdev_to_mddev (kdev_t dev)
 {
 	if (major(dev) != MD_MAJOR)
-		BUG();
+		XBUG("kdev_to_mddev not MD");
         return mddev_map[minor(dev)].mddev;
 }
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/skbuff.h working-2.5.17-bug/include/linux/skbuff.h
--- linux-2.5.17/include/linux/skbuff.h	Thu May 23 18:29:44 2002
+++ working-2.5.17-bug/include/linux/skbuff.h	Fri May 24 11:57:04 2002
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/cache.h>
+#include <linux/stringify.h>
 
 #include <asm/atomic.h>
 #include <asm/types.h>
@@ -757,9 +758,9 @@
 	return skb->len - skb->data_len;
 }
 
-#define SKB_PAGE_ASSERT(skb) do { if (skb_shinfo(skb)->nr_frags) BUG(); } while (0)
-#define SKB_FRAG_ASSERT(skb) do { if (skb_shinfo(skb)->frag_list) BUG(); } while (0)
-#define SKB_LINEAR_ASSERT(skb) do { if (skb_is_nonlinear(skb)) BUG(); } while (0)
+#define SKB_PAGE_ASSERT(skb) do { if (skb_shinfo(skb)->nr_frags) XBUG("SKB_PAGE:" __stringify(__LINE__)); } while (0)
+#define SKB_FRAG_ASSERT(skb) do { if (skb_shinfo(skb)->frag_list) XBUG("SKB_FRAG:" __stringify(__LINE__)); } while (0)
+#define SKB_LINEAR_ASSERT(skb) do { if (skb_is_nonlinear(skb)) XBUG("SKB_LINEAR:" __stringify(__LINE__)); } while (0)
 
 /*
  *	Add data to an sk_buff
@@ -827,7 +828,7 @@
 {
 	skb->len-=len;
 	if (skb->len < skb->data_len)
-		BUG();
+		XBUG("skb_pull too hard");
 	return 	skb->data+=len;
 }
 
@@ -1095,7 +1096,7 @@
 {
 #ifdef CONFIG_HIGHMEM
 	if (in_irq())
-		BUG();
+		XBUG("kmap_skb_frag in irq");
 
 	local_bh_disable();
 #endif
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/current-dontdiff --minimal linux-2.5.17/include/linux/swap.h working-2.5.17-bug/include/linux/swap.h
--- linux-2.5.17/include/linux/swap.h	Thu May 23 18:29:03 2002
+++ working-2.5.17-bug/include/linux/swap.h	Fri May 24 11:56:25 2002
@@ -185,9 +185,9 @@
 #define DEBUG_LRU_PAGE(page)			\
 do {						\
 	if (!PageLRU(page))			\
-		BUG();				\
+		XBUG("!PageLRU");		\
 	if (PageActive(page))			\
-		BUG();				\
+		XBUG("PageActive");		\
 } while (0)
 
 #define add_page_to_active_list(page)		\




--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
