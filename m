Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTASBUw>; Sat, 18 Jan 2003 20:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265277AbTASBUw>; Sat, 18 Jan 2003 20:20:52 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:8419 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S265255AbTASBUk>; Sat, 18 Jan 2003 20:20:40 -0500
Date: Sun, 19 Jan 2003 02:29:39 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: dwmw2@infradead.org
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] mics cleanups for mtd
Message-ID: <20030119012938.GY10647@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a cleanup for mtd:

I started with removing all #if'd code for kernels < 2.4.4.

After this cleanup linux/mtd/compatmac.h contained only #include's so I 
completely removed this file, removed all #include's of it in both the 
mtd and jffs2 (sic) code and added the few needed #include's in the .c 
files.

Besides this I removed a few #include <stdarg.h>.

I've tested the compilation with 2.5.59.

diffstat output:
 drivers/mtd/chips/cfi_cmdset_0001.c |    1 
 drivers/mtd/chips/chipreg.c         |    1 
 drivers/mtd/chips/jedec.c           |    1 
 drivers/mtd/chips/map_absent.c      |    1 
 drivers/mtd/chips/map_ram.c         |    1 
 drivers/mtd/chips/map_rom.c         |    1 
 drivers/mtd/devices/blkmtd.c        |   41 -------
 drivers/mtd/devices/doc1000.c       |    1 
 drivers/mtd/devices/docecc.c        |    1 
 drivers/mtd/devices/mtdram.c        |    3 
 drivers/mtd/devices/pmc551.c        |    6 -
 drivers/mtd/devices/slram.c         |    1 
 drivers/mtd/ftl.c                   |    8 -
 drivers/mtd/maps/l440gx.c           |    1 
 drivers/mtd/maps/netsc520.c         |    1 
 drivers/mtd/maps/pcmciamtd.c        |    1 
 drivers/mtd/maps/physmap.c          |    1 
 drivers/mtd/maps/pnc2000.c          |    1 
 drivers/mtd/maps/sc520cdp.c         |    1 
 drivers/mtd/maps/scx200_docflash.c  |    1 
 drivers/mtd/mtdblock.c              |    8 -
 drivers/mtd/mtdblock_ro.c           |    1 
 drivers/mtd/mtdchar.c               |    1 
 drivers/mtd/mtdcore.c               |   35 ------
 drivers/mtd/nftlcore.c              |    1 
 drivers/mtd/nftlmount.c             |    1 
 fs/jffs2/background.c               |    1 
 fs/jffs2/build.c                    |    1 
 fs/jffs2/compr_zlib.c               |    3 
 fs/jffs2/dir.c                      |    1 
 fs/jffs2/file.c                     |    1 
 fs/jffs2/nodelist.h                 |    1 
 include/linux/mtd/cfi.h             |    2 
 include/linux/mtd/compatmac.h       |  203 ------------------------------------
 include/linux/mtd/mtd.h             |    1 
 35 files changed, 25 insertions(+), 310 deletions(-)


cu
Adrian


--- linux-2.5.59-full/include/linux/mtd/compatmac.h	2003-01-19 01:07:07.000000000 +0100
+++ /dev/null	2003-01-09 00:39:47.000000000 +0100
@@ -1,203 +0,0 @@
-
-/*
- * mtd/include/compatmac.h
- *
- * $Id: compatmac.h,v 1.4 2000/07/03 10:01:38 dwmw2 Exp $
- *
- * Extensions and omissions from the normal 'linux/compatmac.h'
- * files. hopefully this will end up empty as the 'real' one 
- * becomes fully-featured.
- */
-
-
-/* First, include the parts which the kernel is good enough to provide 
- * to us 
- */
-   
-#ifndef __LINUX_MTD_COMPATMAC_H__
-#define __LINUX_MTD_COMPATMAC_H__
-
-#include <linux/compatmac.h>
-#include <linux/types.h> /* used later in this header */
-#include <linux/module.h>
-#ifndef LINUX_VERSION_CODE
-#include <linux/version.h>
-#endif
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
-#include <linux/vmalloc.h>
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,0,0)
-#  error "This kernel is too old: not supported by this file"
-#endif
-
-/* Modularization issues */
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,18)
-#  define __USE_OLD_SYMTAB__
-#  define EXPORT_NO_SYMBOLS register_symtab(NULL);
-#  define REGISTER_SYMTAB(tab) register_symtab(tab)
-#else
-#  define REGISTER_SYMTAB(tab) /* nothing */
-#endif
-
-#ifdef __USE_OLD_SYMTAB__
-#  define __MODULE_STRING(s)         /* nothing */
-#  define MODULE_PARM(v,t)           /* nothing */
-#  define MODULE_PARM_DESC(v,t)      /* nothing */
-#  define MODULE_AUTHOR(n)           /* nothing */
-#  define MODULE_DESCRIPTION(d)      /* nothing */
-#  define MODULE_SUPPORTED_DEVICE(n) /* nothing */
-#endif
-
-/*
- * "select" changed in 2.1.23. The implementation is twin, but this
- * header is new
- */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,1,22)
-#  include <linux/poll.h>
-#else
-#  define __USE_OLD_SELECT__
-#endif
-
-/* Other change in the fops are solved using pseudo-types */
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0)
-#  define lseek_t      long long
-#  define lseek_off_t  long long
-#else
-#  define lseek_t      int
-#  define lseek_off_t  off_t
-#endif
-
-/* changed the prototype of read/write */
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,0) || defined(__alpha__)
-# define count_t unsigned long
-# define read_write_t long
-#else
-# define count_t int
-# define read_write_t int
-#endif
-
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,1,31)
-# define release_t void
-#  define release_return(x) return
-#else
-#  define release_t int
-#  define release_return(x) return (x)
-#endif
-
-#if LINUX_VERSION_CODE < 0x20300
-#define __exit
-#endif
-#if LINUX_VERSION_CODE < 0x20200
-#define __init
-#else
-#include <linux/init.h>
-#endif
-
-#if LINUX_VERSION_CODE < 0x20300
-#define init_MUTEX(x) do {*(x) = MUTEX;} while (0)
-#define RQFUNC_ARG void
-#define blkdev_dequeue_request(req) do {CURRENT = req->next;} while (0)
-#else
-#define RQFUNC_ARG request_queue_t *q
-#endif
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,0)
-#define __MOD_INC_USE_COUNT(mod)                                        \
-        (atomic_inc(&(mod)->uc.usecount), (mod)->flags |= MOD_VISITED|MOD_USED_ONCE)
-#define __MOD_DEC_USE_COUNT(mod)                                        \
-        (atomic_dec(&(mod)->uc.usecount), (mod)->flags |= MOD_VISITED)
-#endif
-
-
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-
-#define DECLARE_WAIT_QUEUE_HEAD(x) struct wait_queue *x = NULL
-#define init_waitqueue_head init_waitqueue
-
-static inline int try_inc_mod_count(struct module *mod)
-{
-	if (mod)
-		__MOD_INC_USE_COUNT(mod);
-	return 1;
-}
-#endif
-
-
-/* Yes, I'm aware that it's a fairly ugly hack.
-   Until the __constant_* macros appear in Linus' own kernels, this is
-   the way it has to be done.
- DW 19/1/00
- */
-
-#include <asm/byteorder.h>
-
-#ifndef __constant_cpu_to_le16
-
-#ifdef __BIG_ENDIAN
-#define __constant_cpu_to_le64(x) ___swab64((x))
-#define __constant_le64_to_cpu(x) ___swab64((x))
-#define __constant_cpu_to_le32(x) ___swab32((x))
-#define __constant_le32_to_cpu(x) ___swab32((x))
-#define __constant_cpu_to_le16(x) ___swab16((x))
-#define __constant_le16_to_cpu(x) ___swab16((x))
-#define __constant_cpu_to_be64(x) ((__u64)(x))
-#define __constant_be64_to_cpu(x) ((__u64)(x))
-#define __constant_cpu_to_be32(x) ((__u32)(x))
-#define __constant_be32_to_cpu(x) ((__u32)(x))
-#define __constant_cpu_to_be16(x) ((__u16)(x))
-#define __constant_be16_to_cpu(x) ((__u16)(x))
-#else
-#ifdef __LITTLE_ENDIAN
-#define __constant_cpu_to_le64(x) ((__u64)(x))
-#define __constant_le64_to_cpu(x) ((__u64)(x))
-#define __constant_cpu_to_le32(x) ((__u32)(x))
-#define __constant_le32_to_cpu(x) ((__u32)(x))
-#define __constant_cpu_to_le16(x) ((__u16)(x))
-#define __constant_le16_to_cpu(x) ((__u16)(x))
-#define __constant_cpu_to_be64(x) ___swab64((x))
-#define __constant_be64_to_cpu(x) ___swab64((x))
-#define __constant_cpu_to_be32(x) ___swab32((x))
-#define __constant_be32_to_cpu(x) ___swab32((x))
-#define __constant_cpu_to_be16(x) ___swab16((x))
-#define __constant_be16_to_cpu(x) ___swab16((x))
-#else
-#error No (recognised) endianness defined (unless it,s PDP)
-#endif /* __LITTLE_ENDIAN */
-#endif /* __BIG_ENDIAN */
-
-#endif /* ifndef __constant_cpu_to_le16 */
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-  #define mod_init_t int  __init
-  #define mod_exit_t void  
-#else
-  #define mod_init_t static int __init
-  #define mod_exit_t static void __exit
-#endif
-
-#ifndef THIS_MODULE
-#ifdef MODULE
-#define THIS_MODULE (&__this_module)
-#else
-#define THIS_MODULE (NULL)
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < 0x20300
-#include <linux/interrupt.h>
-#define spin_lock_bh(lock) do {start_bh_atomic();spin_lock(lock);} while(0)
-#define spin_unlock_bh(lock) do {spin_unlock(lock);end_bh_atomic();} while(0)
-#else
-#include <linux/interrupt.h>
-#include <asm/softirq.h>
-#include <linux/spinlock.h>
-#endif
-
-#endif /* __LINUX_MTD_COMPATMAC_H__ */
-
-
--- linux-2.5.59-full/include/linux/mtd/mtd.h.old	2003-01-19 01:15:41.000000000 +0100
+++ linux-2.5.59-full/include/linux/mtd/mtd.h	2003-01-19 01:15:59.000000000 +0100
@@ -9,7 +9,6 @@
 #include <linux/config.h>
 #include <linux/version.h>
 #include <linux/types.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/module.h>
 #include <linux/uio.h>
 
--- linux-2.5.59-full/include/linux/mtd/cfi.h.old	2003-01-19 01:08:42.000000000 +0100
+++ linux-2.5.59-full/include/linux/mtd/cfi.h	2003-01-19 01:17:31.000000000 +0100
@@ -367,7 +367,6 @@
 
 static inline void cfi_udelay(int us)
 {
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 	if (need_resched()) {
 		unsigned long t = us * HZ / 1000000;
 		if (t < 1)
@@ -376,7 +375,6 @@
 		schedule_timeout(t);
 	}
 	else
-#endif
 		udelay(us);
 }
 static inline void cfi_spin_lock(spinlock_t *mutex)
--- linux-2.5.59-full/drivers/mtd/devices/docecc.c.old	2003-01-19 01:11:10.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/devices/docecc.c	2003-01-19 01:11:22.000000000 +0100
@@ -36,7 +36,6 @@
 #include <linux/init.h>
 #include <linux/types.h>
 
-#include <linux/mtd/compatmac.h> /* for min() in older kernels */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/doc2000.h>
 
--- linux-2.5.59-full/drivers/mtd/devices/blkmtd.c.old	2003-01-19 01:10:05.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/devices/blkmtd.c	2003-01-19 01:24:38.000000000 +0100
@@ -51,7 +51,6 @@
 #include <linux/pagemap.h>
 #include <linux/iobuf.h>
 #include <linux/slab.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/mtd.h>
 
 #ifdef CONFIG_MTD_DEBUG
@@ -110,15 +109,9 @@
 static volatile int write_task_finish;
 
 /* ipc with the write thread */
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,3,0)
 static DECLARE_MUTEX_LOCKED(thread_sem);
 static DECLARE_WAIT_QUEUE_HEAD(thr_wq);
 static DECLARE_WAIT_QUEUE_HEAD(mtbd_sync_wq);
-#else
-static struct semaphore thread_sem = MUTEX_LOCKED;
-DECLARE_WAIT_QUEUE_HEAD(thr_wq);
-DECLARE_WAIT_QUEUE_HEAD(mtbd_sync_wq);
-#endif
 
 
 /* Module parameters passed by insmod/modprobe */
@@ -130,7 +123,6 @@
 int wqs;         /* optionally set the write queue size */
 
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Simon Evans <spse@secret.org.uk>");
 MODULE_DESCRIPTION("Emulate an MTD using a block device");
@@ -145,7 +137,6 @@
 MODULE_PARM(count, "i");
 MODULE_PARM_DESC(count, "force the block count");
 MODULE_PARM(wqs, "i");
-#endif
 
 
 /* Page cache stuff */
@@ -222,18 +213,7 @@
     return err;
   }
 
-  /* Pre 2.4.4 doesn't have space for the block list in the kiobuf */ 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(*blocks));
-  if(blocks == NULL) {
-    printk("blkmtd: cant allocate iobuf blocks\n");
-    free_kiovec(1, &iobuf);
-    SetPageError(page);
-    return -ENOMEM;
-  }
-#else 
   blocks = iobuf->blocks;
-#endif
 
   iobuf->offset = 0;
   iobuf->nr_pages = 1;
@@ -266,10 +246,6 @@
   iobuf->locked = 0;
   free_kiovec(1, &iobuf);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-  kfree(blocks);
-#endif
-
   if(err != PAGE_SIZE) {
     printk("blkmtd: readpage: error reading page %ld\n", page->index);
     memset(page_address(page), 0, PAGE_SIZE);
@@ -315,17 +291,7 @@
     return 0;
   }
 
-  /* Pre 2.4.4 doesn't have space for the block list in the kiobuf */ 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-  blocks = kmalloc(KIO_MAX_SECTORS * sizeof(unsigned long));
-  if(blocks == NULL) {
-    printk("blkmtd: write_queue_task cant allocate iobuf blocks\n");
-    free_kiovec(1, &iobuf);
-    return 0;
-  }
-#else 
   blocks = iobuf->blocks;
-#endif
 
   DEBUG(2, "blkmtd: writetask: entering main loop\n");
   add_wait_queue(&thr_wq, &wait);
@@ -431,10 +397,6 @@
   DEBUG(1, "blkmtd: writetask: exiting\n");
   free_kiovec(1, &iobuf);
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,4,4)
-  kfree(blocks);
-#endif
-
   /* Tell people we have exitd */
   up(&thread_sem);
   return 0;
@@ -1225,10 +1187,7 @@
   INIT_LIST_HEAD(&mtd_rawdevice->as.i_mmap);
   INIT_LIST_HEAD(&mtd_rawdevice->as.i_mmap_shared);
   mtd_rawdevice->as.gfp_mask = GFP_KERNEL;
-
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
   mtd_rawdevice->mtd_info.module = THIS_MODULE;			
-#endif
   if (add_mtd_device(&mtd_rawdevice->mtd_info)) {
     err = -EIO;
     goto init_err;
--- linux-2.5.59-full/drivers/mtd/nftlcore.c.old	2003-01-19 01:28:35.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/nftlcore.c	2003-01-19 01:28:47.000000000 +0100
@@ -31,7 +31,6 @@
 #endif
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nftl.h>
-#include <linux/mtd/compatmac.h>
 
 /* maximum number of loops while examining next block, to have a
    chance to detect consistency problems (they should never happen
--- linux-2.5.59-full/drivers/mtd/nftlmount.c.old	2003-01-19 01:29:18.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/nftlmount.c	2003-01-19 01:29:28.000000000 +0100
@@ -35,7 +35,6 @@
 #include <linux/init.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nftl.h>
-#include <linux/mtd/compatmac.h>
 
 #define SECTORSIZE 512
 
--- linux-2.5.59-full/drivers/mtd/chips/cfi_cmdset_0001.c.old	2003-01-19 01:29:54.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/chips/cfi_cmdset_0001.c	2003-01-19 01:30:04.000000000 +0100
@@ -28,7 +28,6 @@
 #include <linux/interrupt.h>
 #include <linux/mtd/map.h>
 #include <linux/mtd/cfi.h>
-#include <linux/mtd/compatmac.h>
 
 static int cfi_intelext_read (struct mtd_info *, loff_t, size_t, size_t *, u_char *);
 static int cfi_intelext_write_words(struct mtd_info *, loff_t, size_t, size_t *, const u_char *);
--- linux-2.5.59-full/drivers/mtd/chips/chipreg.c.old	2003-01-19 01:30:27.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/chips/chipreg.c	2003-01-19 01:30:37.000000000 +0100
@@ -9,7 +9,6 @@
 #include <linux/config.h>
 #include <linux/kmod.h>
 #include <linux/spinlock.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/map.h>
 
 spinlock_t chip_drvs_lock = SPIN_LOCK_UNLOCKED;
--- linux-2.5.59-full/drivers/mtd/mtdblock_ro.c.old	2003-01-19 01:31:01.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/mtdblock_ro.c	2003-01-19 01:31:11.000000000 +0100
@@ -14,7 +14,6 @@
 #include <linux/types.h>
 
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/buffer_head.h>
 #include <linux/genhd.h>
 
--- linux-2.5.59-full/fs/jffs2/background.c.old	2003-01-19 01:32:00.000000000 +0100
+++ linux-2.5.59-full/fs/jffs2/background.c	2003-01-19 01:32:10.000000000 +0100
@@ -18,7 +18,6 @@
 #include <linux/mtd/mtd.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
-#include <linux/mtd/compatmac.h> /* recalc_sigpending() */
 #include <linux/unistd.h>
 #include "nodelist.h"
 
--- linux-2.5.59-full/fs/jffs2/dir.c.old	2003-01-19 01:32:35.000000000 +0100
+++ linux-2.5.59-full/fs/jffs2/dir.c	2003-01-19 01:32:43.000000000 +0100
@@ -16,7 +16,6 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/crc32.h>
-#include <linux/mtd/compatmac.h> /* For completion */
 #include <linux/jffs2.h>
 #include <linux/jffs2_fs_i.h>
 #include <linux/jffs2_fs_sb.h>
--- linux-2.5.59-full/fs/jffs2/file.c.old	2003-01-19 01:33:02.000000000 +0100
+++ linux-2.5.59-full/fs/jffs2/file.c	2003-01-19 01:33:11.000000000 +0100
@@ -12,7 +12,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/mtd/compatmac.h> /* for min() */
 #include <linux/slab.h>
 #include <linux/fs.h>
 #include <linux/time.h>
--- linux-2.5.59-full/fs/jffs2/nodelist.h.old	2003-01-19 01:33:30.000000000 +0100
+++ linux-2.5.59-full/fs/jffs2/nodelist.h	2003-01-19 01:33:43.000000000 +0100
@@ -17,7 +17,6 @@
 #include <linux/config.h>
 #include <linux/fs.h>
 
-#include <linux/mtd/compatmac.h> /* For min/max in older kernels */
 #include <linux/jffs2.h>
 #include <linux/jffs2_fs_sb.h>
 #include <linux/jffs2_fs_i.h>
--- linux-2.5.59-full/fs/jffs2/compr_zlib.c.old	2003-01-19 01:31:28.000000000 +0100
+++ linux-2.5.59-full/fs/jffs2/compr_zlib.c	2003-01-19 01:36:46.000000000 +0100
@@ -17,10 +17,11 @@
 
 #include <linux/config.h>
 #include <linux/kernel.h>
-#include <linux/mtd/compatmac.h> /* for min() */
 #include <linux/slab.h>
 #include <linux/jffs2.h>
 #include <linux/zlib.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
 #include "nodelist.h"
 
 	/* Plan: call deflate() with avail_in == *sourcelen, 
--- linux-2.5.59-full/fs/jffs2/build.c.old	2003-01-19 01:39:06.000000000 +0100
+++ linux-2.5.59-full/fs/jffs2/build.c	2003-01-19 01:39:23.000000000 +0100
@@ -13,6 +13,7 @@
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/sched.h>
 #include "nodelist.h"
 
 int jffs2_build_inode_pass1(struct jffs2_sb_info *, struct jffs2_inode_cache *);
--- linux-2.5.59-full/drivers/mtd/chips/jedec.c.old	2003-01-19 01:41:34.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/chips/jedec.c	2003-01-19 01:42:17.000000000 +0100
@@ -15,6 +15,7 @@
  */
 
 #include <linux/mtd/jedec.h>
+#include <linux/init.h>
 
 static struct mtd_info *jedec_probe(struct map_info *);
 static int jedec_probe8(struct map_info *map,unsigned long base,
--- linux-2.5.59-full/drivers/mtd/chips/map_ram.c.old	2003-01-19 01:43:54.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/chips/map_ram.c	2003-01-19 01:44:16.000000000 +0100
@@ -11,6 +11,7 @@
 #include <asm/byteorder.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 
 #include <linux/mtd/map.h>
 
--- linux-2.5.59-full/drivers/mtd/chips/map_rom.c.old	2003-01-19 01:45:37.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/chips/map_rom.c	2003-01-19 01:45:58.000000000 +0100
@@ -12,6 +12,7 @@
 #include <asm/byteorder.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 
 #include <linux/mtd/map.h>
 
--- linux-2.5.59-full/drivers/mtd/chips/map_absent.c.old	2003-01-19 01:47:33.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/chips/map_absent.c	2003-01-19 01:47:58.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 
 #include <linux/mtd/map.h>
 
--- linux-2.5.59-full/drivers/mtd/devices/mtdram.c.old	2003-01-19 01:53:42.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/devices/mtdram.c	2003-01-19 01:51:39.000000000 +0100
@@ -13,7 +13,8 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
-#include <linux/mtd/compatmac.h>
+#include <linux/init.h>
+#include <linux/vmalloc.h>
 #include <linux/mtd/mtd.h>
 
 #ifndef CONFIG_MTDRAM_ABS_POS
--- linux-2.5.59-full/drivers/mtd/maps/l440gx.c.old	2003-01-19 01:54:53.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/maps/l440gx.c	2003-01-19 01:55:21.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/config.h>
+#include <linux/init.h>
 
 
 #define WINDOW_ADDR 0xfff00000
--- linux-2.5.59-full/drivers/mtd/maps/physmap.c.old	2003-01-19 01:56:36.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/maps/physmap.c	2003-01-19 01:56:57.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
 #include <linux/config.h>
+#include <linux/init.h>
 
 
 #define WINDOW_ADDR CONFIG_MTD_PHYSMAP_START
--- linux-2.5.59-full/drivers/mtd/maps/pnc2000.c.old	2003-01-19 01:58:14.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/maps/pnc2000.c	2003-01-19 01:58:34.000000000 +0100
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
--- linux-2.5.59-full/drivers/mtd/maps/pcmciamtd.c.old	2003-01-19 01:59:42.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/maps/pcmciamtd.c	2003-01-19 01:59:59.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <asm/system.h>
 
--- linux-2.5.59-full/drivers/mtd/maps/sc520cdp.c.old	2003-01-19 02:01:20.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/maps/sc520cdp.c	2003-01-19 02:01:39.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
--- linux-2.5.59-full/drivers/mtd/maps/netsc520.c.old	2003-01-19 02:02:25.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/maps/netsc520.c	2003-01-19 02:02:41.000000000 +0100
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
--- linux-2.5.59-full/drivers/mtd/maps/scx200_docflash.c.old	2003-01-19 02:03:34.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/maps/scx200_docflash.c	2003-01-19 02:03:50.000000000 +0100
@@ -9,6 +9,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <asm/io.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/map.h>
--- linux-2.5.59-full/drivers/mtd/mtdcore.c.old	2003-01-19 01:27:02.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/mtdcore.c	2003-01-19 02:05:04.000000000 +0100
@@ -17,8 +17,7 @@
 #include <linux/major.h>
 #include <linux/fs.h>
 #include <linux/ioctl.h>
-#include <stdarg.h>
-#include <linux/mtd/compatmac.h>
+#include <linux/init.h>
 #ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
 #endif
@@ -247,9 +246,7 @@
 
 #ifdef CONFIG_PROC_FS
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 static struct proc_dir_entry *proc_mtd;
-#endif
 
 static inline int mtd_proc_info (char *buf, int i)
 {
@@ -263,11 +260,7 @@
 }
 
 static int mtd_read_proc ( char *page, char **start, off_t off,int count
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
                        ,int *eof, void *data_unused
-#else
-                        ,int unused
-#endif
 			)
 {
 	int len, l, i;
@@ -288,9 +281,7 @@
                 }
         }
 
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
         *eof = 1;
-#endif
 
 done:
 	up(&mtd_table_mutex);
@@ -300,18 +291,6 @@
         return ((count < begin+len-off) ? count : begin+len-off);
 }
 
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,2,0)
-struct proc_dir_entry mtd_proc_entry = {
-        0,                 /* low_ino: the inode -- dynamic */
-        3, "mtd",     /* len of name and name */
-        S_IFREG | S_IRUGO, /* mode */
-        1, 0, 0,           /* nlinks, owner, group */
-        0, NULL,           /* size - unused; operations -- use default */
-        &mtd_read_proc,   /* function used to read data */
-        /* nothing more */
-    };
-#endif
-
 #endif /* CONFIG_PROC_FS */
 
 /*====================================================================*/
@@ -320,16 +299,8 @@
 int __init init_mtd(void)
 {
 #ifdef CONFIG_PROC_FS
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
 	if ((proc_mtd = create_proc_entry( "mtd", 0, 0 )))
 	  proc_mtd->read_proc = mtd_read_proc;
-#else
-        proc_register_dynamic(&proc_root,&mtd_proc_entry);
-#endif
-#endif
-
-#if LINUX_VERSION_CODE < 0x20212
-	init_mtd_devices();
 #endif
 
 #ifdef CONFIG_PM
@@ -348,12 +319,8 @@
 #endif
 
 #ifdef CONFIG_PROC_FS
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,2,0)
         if (proc_mtd)
           remove_proc_entry( "mtd", 0);
-#else
-        proc_unregister(&proc_root,mtd_proc_entry.low_ino);
-#endif
 #endif
 }
 
--- linux-2.5.59-full/drivers/mtd/mtdchar.c.old	2003-01-19 02:07:42.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/mtdchar.c	2003-01-19 02:08:16.000000000 +0100
@@ -12,6 +12,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/smp_lock.h>
 #include <linux/slab.h>
+#include <linux/init.h>
 
 #ifdef CONFIG_DEVFS_FS
 #include <linux/devfs_fs_kernel.h>
--- linux-2.5.59-full/drivers/mtd/devices/slram.c.old	2003-01-19 02:10:53.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/devices/slram.c	2003-01-19 02:11:22.000000000 +0100
@@ -20,7 +20,6 @@
 #include <linux/init.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <stdarg.h>
 
 #include <linux/mtd/mtd.h>
 
--- linux-2.5.59-full/drivers/mtd/devices/doc1000.c.old	2003-01-19 02:12:00.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/devices/doc1000.c	2003-01-19 02:12:26.000000000 +0100
@@ -20,7 +20,6 @@
 #include <linux/ioctl.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <stdarg.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 
--- linux-2.5.59-full/drivers/mtd/devices/pmc551.c.old	2003-01-19 01:11:35.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/devices/pmc551.c	2003-01-19 02:13:23.000000000 +0100
@@ -98,7 +98,6 @@
 #include <linux/ioctl.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <stdarg.h>
 #include <linux/pci.h>
 
 #ifndef CONFIG_PCI
@@ -107,13 +106,8 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/pmc551.h>
-#include <linux/mtd/compatmac.h>
 
-#if LINUX_VERSION_CODE > 0x20300
 #define PCI_BASE_ADDRESS(dev) (dev->resource[0].start)
-#else
-#define PCI_BASE_ADDRESS(dev) (dev->base_address[0])
-#endif
 
 static struct mtd_info *pmc551list;
 
--- linux-2.5.59-full/drivers/mtd/ftl.c.old	2003-01-19 01:00:53.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/ftl.c	2003-01-19 02:14:29.000000000 +0100
@@ -56,7 +56,6 @@
       
 ======================================================================*/
 #include <linux/module.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/mtd/mtd.h>
 /*#define PSYCHO_DEBUG */
 
@@ -70,7 +69,6 @@
 #include <linux/fs.h>
 #include <linux/ioctl.h>
 #include <linux/hdreg.h>
-#include <stdarg.h>
 
 #include <linux/vmalloc.h>
 #include <linux/blkpg.h>
@@ -174,7 +172,7 @@
 static int ftl_ioctl(struct inode *inode, struct file *file,
 		     u_int cmd, u_long arg);
 static int ftl_open(struct inode *inode, struct file *file);
-static release_t ftl_close(struct inode *inode, struct file *file);
+static int ftl_close(struct inode *inode, struct file *file);
 static int ftl_revalidate(struct gendisk *disk);
 
 static void ftl_erase_callback(struct erase_info *done);
@@ -850,7 +848,7 @@
 
 /*====================================================================*/
 
-static release_t ftl_close(struct inode *inode, struct file *file)
+static int ftl_close(struct inode *inode, struct file *file)
 {
 	partition_t *part = inode->i_bdev->bd_disk->private_data;
 	int i;
@@ -869,7 +867,7 @@
 	atomic_dec(&part->open);
 
 	put_mtd_device(part->mtd);
-	release_return(0);
+	return(0);
 } /* ftl_close */
 
 
--- linux-2.5.59-full/drivers/mtd/mtdblock.c.old	2003-01-19 01:01:47.000000000 +0100
+++ linux-2.5.59-full/drivers/mtd/mtdblock.c	2003-01-19 02:16:28.000000000 +0100
@@ -13,8 +13,8 @@
 #include <linux/slab.h>
 #include <linux/buffer_head.h>
 #include <linux/mtd/mtd.h>
-#include <linux/mtd/compatmac.h>
 #include <linux/buffer_head.h>
+#include <linux/vmalloc.h>
 
 #define MAJOR_NR MTD_BLOCK_MAJOR
 #define DEVICE_NAME "mtdblock"
@@ -338,14 +338,14 @@
 	return -ENOMEM;
 }
 
-static release_t mtdblock_release(struct inode *inode, struct file *file)
+static int mtdblock_release(struct inode *inode, struct file *file)
 {
 	int dev;
 	struct mtdblk_dev *mtdblk;
    	DEBUG(MTD_DEBUG_LEVEL1, "mtdblock_release\n");
 
 	if (inode == NULL)
-		release_return(-ENODEV);
+		return(-ENODEV);
 
 	dev = minor(inode->i_rdev);
 	mtdblk = mtdblks[dev];
@@ -370,7 +370,7 @@
 
 	DEBUG(MTD_DEBUG_LEVEL1, "ok\n");
 
-	release_return(0);
+	return(0);
 }  
 
 
