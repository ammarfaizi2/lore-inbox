Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266560AbUHINSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266560AbUHINSx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 09:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266555AbUHINSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 09:18:53 -0400
Received: from [213.146.154.40] ([213.146.154.40]:60622 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S266561AbUHINSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 09:18:12 -0400
Subject: Re: [BUG] 2.6.8-rc3 slab corruption (jffs2?)
From: David Woodhouse <dwmw2@infradead.org>
To: Wu Jian Feng <jianfengw@mobilesoft.com.cn>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-mtd@lists.infradead.org,
       Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040809015950.GA20408@mobilesoft.com.cn>
References: <20040807150458.E2805@flint.arm.linux.org.uk>
	 <20040808061206.GA5417@mobilesoft.com.cn>
	 <1091962414.1438.977.camel@imladris.demon.co.uk>
	 <20040809015950.GA20408@mobilesoft.com.cn>
Content-Type: text/plain
Message-Id: <1092057472.4383.5155.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Mon, 09 Aug 2004 14:17:53 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 09:59 +0800, Wu Jian Feng wrote:
> I see the same thing as rmk, used both gcc-3.3.2 and 3.4.0,
> on a OMAP730 (arm926ejs).

Please could you test this....

Index: drivers/mtd/Kconfig
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/Kconfig,v
retrieving revision 1.5
diff -u -p -r1.5 Kconfig
--- drivers/mtd/Kconfig	4 Jun 2004 15:59:32 -0000	1.5
+++ drivers/mtd/Kconfig	9 Aug 2004 13:15:27 -0000
@@ -28,7 +28,7 @@ config MTD_DEBUG_VERBOSE
 	  Determines the verbosity level of the MTD debugging messages.
 
 config MTD_PARTITIONS
-	tristate "MTD partitioning support"
+	bool "MTD partitioning support"
 	depends on MTD
 	help
 	  If you have a device which needs to divide its flash chip(s) up
Index: drivers/mtd/Makefile.common
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/Makefile.common,v
retrieving revision 1.3
diff -u -p -r1.3 Makefile.common
--- drivers/mtd/Makefile.common	12 Jul 2004 16:07:30 -0000	1.3
+++ drivers/mtd/Makefile.common	9 Aug 2004 13:15:27 -0000
@@ -4,7 +4,10 @@
 # $Id: Makefile.common,v 1.3 2004/07/12 16:07:30 dwmw2 Exp $
 
 # Core functionality.
-obj-$(CONFIG_MTD)		+= mtdcore.o
+mtd-y				:= mtdcore.o
+mtd-$(CONFIG_MTD_PARTITIONS)	+= mtdpart.o
+obj-$(CONFIG_MTD)		+= $(mtd-y)
+
 obj-$(CONFIG_MTD_CONCAT)	+= mtdconcat.o
 obj-$(CONFIG_MTD_PARTITIONS)	+= mtdpart.o
 obj-$(CONFIG_MTD_REDBOOT_PARTS) += redboot.o
Index: drivers/mtd/mtdchar.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/mtdchar.c,v
retrieving revision 1.62
diff -u -p -r1.62 mtdchar.c
--- drivers/mtd/mtdchar.c	14 Jul 2004 13:20:42 -0000	1.62
+++ drivers/mtd/mtdchar.c	9 Aug 2004 13:15:27 -0000
@@ -262,7 +262,7 @@ static ssize_t mtd_write(struct file *fi
     IOCTL calls for getting device parameters.
 
 ======================================================================*/
-static void mtd_erase_callback (struct erase_info *instr)
+static void mtdchar_erase_callback (struct erase_info *instr)
 {
 	wake_up((wait_queue_head_t *)instr->priv);
 }
@@ -336,7 +336,7 @@ static int mtd_ioctl(struct inode *inode
 				return -EFAULT;
 			}
 			erase->mtd = mtd;
-			erase->callback = mtd_erase_callback;
+			erase->callback = mtdchar_erase_callback;
 			erase->priv = (unsigned long)&waitq;
 			
 			/*
Index: drivers/mtd/mtdpart.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/mtdpart.c,v
retrieving revision 1.46
diff -u -p -r1.46 mtdpart.c
--- drivers/mtd/mtdpart.c	12 Jul 2004 13:28:07 -0000	1.46
+++ drivers/mtd/mtdpart.c	9 Aug 2004 13:15:30 -0000
@@ -246,11 +246,21 @@ static int part_erase (struct mtd_info *
 		return -EINVAL;
 	instr->addr += part->offset;
 	ret = part->master->erase(part->master, instr);
-	if (instr->fail_addr != 0xffffffff)
-		instr->fail_addr -= part->offset;
 	return ret;
 }
 
+void mtd_erase_callback(struct erase_info *instr)
+{
+	if (instr->mtd->erase == part_erase) {
+		struct mtd_part *part = PART(mtd);
+
+		if (instr->fail_addr != 0xffffffff)
+			instr->fail_addr -= part->offset;
+	}
+	if (instr->callback)
+		instr->callback(instr);
+}
+
 static int part_lock (struct mtd_info *mtd, loff_t ofs, size_t len)
 {
 	struct mtd_part *part = PART(mtd);
Index: drivers/mtd/chips/amd_flash.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/amd_flash.c,v
retrieving revision 1.24
diff -u -p -r1.24 amd_flash.c
--- drivers/mtd/chips/amd_flash.c	12 Jul 2004 13:34:30 -0000	1.24
+++ drivers/mtd/chips/amd_flash.c	9 Aug 2004 13:15:32 -0000
@@ -1307,9 +1307,7 @@ static int amd_flash_erase(struct mtd_in
 	}
 		
 	instr->state = MTD_ERASE_DONE;
-	if (instr->callback) {
-		instr->callback(instr);
-	}
+	mtd_erase_callback(instr);
 	
 	return 0;
 }
Index: drivers/mtd/chips/cfi_cmdset_0001.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/cfi_cmdset_0001.c,v
retrieving revision 1.153
diff -u -p -r1.153 cfi_cmdset_0001.c
--- drivers/mtd/chips/cfi_cmdset_0001.c	12 Jul 2004 21:52:20 -0000	1.153
+++ drivers/mtd/chips/cfi_cmdset_0001.c	9 Aug 2004 13:15:33 -0000
@@ -1554,8 +1554,7 @@ int cfi_intelext_erase_varsize(struct mt
 		return ret;
 
 	instr->state = MTD_ERASE_DONE;
-	if (instr->callback)
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 	
 	return 0;
 }
Index: drivers/mtd/chips/cfi_cmdset_0002.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/cfi_cmdset_0002.c,v
retrieving revision 1.104
diff -u -p -r1.104 cfi_cmdset_0002.c
--- drivers/mtd/chips/cfi_cmdset_0002.c	16 Jul 2004 17:42:35 -0000	1.104
+++ drivers/mtd/chips/cfi_cmdset_0002.c	9 Aug 2004 13:15:40 -0000
@@ -1420,8 +1420,7 @@ int cfi_amdstd_erase_varsize(struct mtd_
 		return ret;
 
 	instr->state = MTD_ERASE_DONE;
-	if (instr->callback)
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 	
 	return 0;
 }
@@ -1444,8 +1443,7 @@ static int cfi_amdstd_erase_chip(struct 
 		return ret;
 
 	instr->state = MTD_ERASE_DONE;
-	if (instr->callback)
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 	
 	return 0;
 }
Index: drivers/mtd/chips/cfi_cmdset_0020.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/cfi_cmdset_0020.c,v
retrieving revision 1.14
diff -u -p -r1.14 cfi_cmdset_0020.c
--- drivers/mtd/chips/cfi_cmdset_0020.c	20 Jul 2004 02:44:25 -0000	1.14
+++ drivers/mtd/chips/cfi_cmdset_0020.c	9 Aug 2004 13:15:40 -0000
@@ -966,8 +966,7 @@ int cfi_staa_erase_varsize(struct mtd_in
 	}
 		
 	instr->state = MTD_ERASE_DONE;
-	if (instr->callback)
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 	
 	return 0;
 }
Index: drivers/mtd/chips/jedec.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/jedec.c,v
retrieving revision 1.20
diff -u -p -r1.20 jedec.c
--- drivers/mtd/chips/jedec.c	12 Jul 2004 14:03:01 -0000	1.20
+++ drivers/mtd/chips/jedec.c	9 Aug 2004 13:15:40 -0000
@@ -780,8 +780,7 @@ static int flash_erase(struct mtd_info *
        	    
    //printk("done\n");
    instr->state = MTD_ERASE_DONE;
-   if (instr->callback)
-	instr->callback(instr);
+   mtd_erase_callback(instr);
    return 0;
    
    #undef flread
Index: drivers/mtd/chips/map_ram.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/map_ram.c,v
retrieving revision 1.19
diff -u -p -r1.19 map_ram.c
--- drivers/mtd/chips/map_ram.c	12 Jul 2004 21:58:44 -0000	1.19
+++ drivers/mtd/chips/map_ram.c	9 Aug 2004 13:15:40 -0000
@@ -114,8 +114,7 @@ static int mapram_erase (struct mtd_info
 
 	instr->state = MTD_ERASE_DONE;
 
-	if (instr->callback)
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 
 	return 0;
 }
Index: drivers/mtd/chips/sharp.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/chips/sharp.c,v
retrieving revision 1.13
diff -u -p -r1.13 sharp.c
--- drivers/mtd/chips/sharp.c	12 Jul 2004 14:06:34 -0000	1.13
+++ drivers/mtd/chips/sharp.c	9 Aug 2004 13:15:40 -0000
@@ -425,8 +425,7 @@ static int sharp_erase(struct mtd_info *
 	}
 
 	instr->state = MTD_ERASE_DONE;
-	if(instr->callback)
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 
 	return 0;
 }
Index: drivers/mtd/devices/blkmtd-24.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/blkmtd-24.c,v
retrieving revision 1.21
diff -u -p -r1.21 blkmtd-24.c
--- drivers/mtd/devices/blkmtd-24.c	2 Aug 2004 09:46:15 -0000	1.21
+++ drivers/mtd/devices/blkmtd-24.c	9 Aug 2004 13:15:40 -0000
@@ -466,9 +466,7 @@ static int blkmtd_erase(struct mtd_info 
 
 	DEBUG(3, "blkmtd: erase: checking callback\n");
  erase_callback:
-	if (instr->callback) {
-		(*(instr->callback))(instr);
-	}
+	mtd_erase_callback(instr);
 	DEBUG(2, "blkmtd: erase: finished (err = %d)\n", err);
 	return err;
 }
Index: drivers/mtd/devices/blkmtd.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/blkmtd.c,v
retrieving revision 1.21
diff -u -p -r1.21 blkmtd.c
--- drivers/mtd/devices/blkmtd.c	2 Aug 2004 09:51:25 -0000	1.21
+++ drivers/mtd/devices/blkmtd.c	9 Aug 2004 13:15:40 -0000
@@ -435,9 +435,7 @@ static int blkmtd_erase(struct mtd_info 
 	}
 
 	DEBUG(3, "blkmtd: erase: checking callback\n");
-	if (instr->callback) {
-		(*(instr->callback))(instr);
-	}
+	mtd_erase_callback(instr);
 	DEBUG(2, "blkmtd: erase: finished (err = %d)\n", err);
 	return err;
 }
Index: drivers/mtd/devices/doc2000.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/doc2000.c,v
retrieving revision 1.60
diff -u -p -r1.60 doc2000.c
--- drivers/mtd/devices/doc2000.c	7 Apr 2004 08:30:04 -0000	1.60
+++ drivers/mtd/devices/doc2000.c	9 Aug 2004 13:15:41 -0000
@@ -1277,8 +1277,7 @@ static int doc_erase(struct mtd_info *mt
 	instr->state = MTD_ERASE_DONE;
 
  callback:
-	if (instr->callback)
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 
 	up(&this->lock);
 	return 0;
Index: drivers/mtd/devices/doc2001.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/doc2001.c,v
retrieving revision 1.42
diff -u -p -r1.42 doc2001.c
--- drivers/mtd/devices/doc2001.c	4 Apr 2004 12:36:45 -0000	1.42
+++ drivers/mtd/devices/doc2001.c	9 Aug 2004 13:15:42 -0000
@@ -841,8 +841,7 @@ int doc_erase (struct mtd_info *mtd, str
 		instr->state = MTD_ERASE_DONE;
 	dummy = ReadDOC(docptr, LastDataRead);
 
-	if (instr->callback) 
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 
 	return 0;
 }
Index: drivers/mtd/devices/doc2001plus.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/doc2001plus.c,v
retrieving revision 1.8
diff -u -p -r1.8 doc2001plus.c
--- drivers/mtd/devices/doc2001plus.c	4 Apr 2004 12:36:45 -0000	1.8
+++ drivers/mtd/devices/doc2001plus.c	9 Aug 2004 13:15:44 -0000
@@ -1111,8 +1111,7 @@ int doc_erase(struct mtd_info *mtd, stru
 	/* Disable flash internally */
 	WriteDOC(0, docptr, Mplus_FlashSelect);
 
-	if (instr->callback) 
-		instr->callback(instr);
+	mtd_erase_callback(instr);
 
 	return 0;
 }
Index: drivers/mtd/devices/lart.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/lart.c,v
retrieving revision 1.6
diff -u -p -r1.6 lart.c
--- drivers/mtd/devices/lart.c	14 Jul 2004 17:21:38 -0000	1.6
+++ drivers/mtd/devices/lart.c	9 Aug 2004 13:15:44 -0000
@@ -433,7 +433,7 @@ static int flash_erase (struct mtd_info 
 	 }
 
    instr->state = MTD_ERASE_DONE;
-   if (instr->callback) instr->callback (instr);
+   mtd_erase_callback(instr);
 
    return (0);
 }
Index: drivers/mtd/devices/mtdram.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/mtdram.c,v
retrieving revision 1.32
diff -u -p -r1.32 mtdram.c
--- drivers/mtd/devices/mtdram.c	21 May 2003 15:15:07 -0000	1.32
+++ drivers/mtd/devices/mtdram.c	9 Aug 2004 13:15:44 -0000
@@ -57,9 +57,8 @@ ram_erase(struct mtd_info *mtd, struct e
   memset((char *)mtd->priv + instr->addr, 0xff, instr->len);
 	
   instr->state = MTD_ERASE_DONE;
+  mtd_erase_callback(instr);
 
-  if (instr->callback)
-    (*(instr->callback))(instr);
   return 0;
 }
 
Index: drivers/mtd/devices/phram.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/phram.c,v
retrieving revision 1.1
diff -u -p -r1.1 phram.c
--- drivers/mtd/devices/phram.c	21 Aug 2003 17:52:30 -0000	1.1
+++ drivers/mtd/devices/phram.c	9 Aug 2004 13:15:44 -0000
@@ -55,10 +55,7 @@ int phram_erase(struct mtd_info *mtd, st
 
 	instr->state = MTD_ERASE_DONE;
 
-	if (instr->callback)
-		(*(instr->callback))(instr);
-	else
-		kfree(instr);
+	mtd_erase_callback(instr);
 
 	return 0;
 }
Index: drivers/mtd/devices/pmc551.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/pmc551.c,v
retrieving revision 1.27
diff -u -p -r1.27 pmc551.c
--- drivers/mtd/devices/pmc551.c	20 Jul 2004 02:44:26 -0000	1.27
+++ drivers/mtd/devices/pmc551.c	9 Aug 2004 13:15:44 -0000
@@ -169,9 +169,7 @@ out:
 	printk(KERN_DEBUG "pmc551_erase() done\n");
 #endif
 
-        if (instr->callback) {
-                (*(instr->callback))(instr);
-	}
+        mtd_erase_callback(instr);
         return 0;
 }
 
Index: drivers/mtd/devices/slram.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/devices/slram.c,v
retrieving revision 1.30
diff -u -p -r1.30 slram.c
--- drivers/mtd/devices/slram.c	20 May 2003 21:03:08 -0000	1.30
+++ drivers/mtd/devices/slram.c	9 Aug 2004 13:15:46 -0000
@@ -98,12 +98,7 @@ int slram_erase(struct mtd_info *mtd, st
 
 	instr->state = MTD_ERASE_DONE;
 
-	if (instr->callback) {
-		(*(instr->callback))(instr);
-	}
-	else {
-		kfree(instr);
-	}
+	mtd_erase_callback(instr);
 
 	return(0);
 }
Index: drivers/mtd/nand/diskonchip.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/nand/diskonchip.c,v
retrieving revision 1.31
diff -u -p -r1.31 diskonchip.c
--- drivers/mtd/nand/diskonchip.c	9 Aug 2004 07:20:53 -0000	1.31
+++ drivers/mtd/nand/diskonchip.c	9 Aug 2004 13:15:47 -0000
@@ -1239,8 +1239,9 @@ static int __init nftl_scan_bbt(struct m
 	if ((ret = nand_scan_bbt(mtd, NULL)))
 		return ret;
 	add_mtd_device(mtd);
-#if defined(CONFIG_MTD_PARTITIONS) || defined(CONFIG_MTD_PARTITIONS_MODULE)
-	if (!no_autopart) add_mtd_partitions(mtd, parts, numparts);
+#ifdef CONFIG_MTD_PARTITIONS
+	if (!no_autopart)
+		add_mtd_partitions(mtd, parts, numparts);
 #endif
 	return 0;
 }
@@ -1298,8 +1299,9 @@ static int __init inftl_scan_bbt(struct 
 	   autopartitioning, but I want to give it more thought. */
 	if (!numparts) return -EIO;
 	add_mtd_device(mtd);
-#if defined(CONFIG_MTD_PARTITIONS) || defined(CONFIG_MTD_PARTITIONS_MODULE)
-	if (!no_autopart) add_mtd_partitions(mtd, parts, numparts);
+#ifdefined CONFIG_MTD_PARTITIONS
+	if (!no_autopart)
+		add_mtd_partitions(mtd, parts, numparts);
 #endif
 	return 0;
 }
Index: drivers/mtd/nand/nand_base.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/nand/nand_base.c,v
retrieving revision 1.114
diff -u -p -r1.114 nand_base.c
--- drivers/mtd/nand/nand_base.c	26 Jul 2004 16:07:48 -0000	1.114
+++ drivers/mtd/nand/nand_base.c	9 Aug 2004 13:15:50 -0000
@@ -58,7 +58,7 @@
 #include <linux/bitops.h>
 #include <asm/io.h>
 
-#if defined(CONFIG_MTD_PARTITIONS) || defined(CONFIG_MTD_PARTITIONS_MODULE)
+#ifdef CONFIG_MTD_PARTITIONS
 #include <linux/mtd/partitions.h>
 #endif
 
@@ -2108,8 +2108,8 @@ erase_exit:
 
 	ret = instr->state == MTD_ERASE_DONE ? 0 : -EIO;
 	/* Do call back function */
-	if (!ret && instr->callback)
-		instr->callback (instr);
+	if (!ret)
+		mtd_erase_callback(instr);
 
 	/* Deselect and wake up anyone waiting on the device */
 	nand_release_chip(mtd);
@@ -2555,11 +2555,11 @@ void nand_release (struct mtd_info *mtd)
 {
 	struct nand_chip *this = mtd->priv;
 
-#if defined(CONFIG_MTD_PARTITIONS) || defined(CONFIG_MTD_PARTITIONS_MODULE)
-	/* Unregister partitions */
+#ifdef CONFIG_MTD_PARTITIONS
+	/* Deregister partitions */
 	del_mtd_partitions (mtd);
 #endif
-	/* Unregister the device */
+	/* Deregister the device */
 	del_mtd_device (mtd);
 
 	/* Free bad block table memory, if allocated */
Index: include/linux/mtd/mtd.h
===================================================================
RCS file: /home/cvs/mtd/include/linux/mtd/mtd.h,v
retrieving revision 1.54
diff -u -p -r1.54 mtd.h
--- include/linux/mtd/mtd.h	15 Jul 2004 01:13:12 -0000	1.54
+++ include/linux/mtd/mtd.h	9 Aug 2004 13:15:51 -0000
@@ -192,6 +192,17 @@ int default_mtd_readv(struct mtd_info *m
 #define MTD_WRITEOOB(mtd, args...) (*(mtd->write_oob))(mtd, args)
 #define MTD_SYNC(mtd) do { if (mtd->sync) (*(mtd->sync))(mtd);  } while (0) 
 
+
+#ifdef CONFIG_MTD_PARTITIONS
+void mtd_erase_callback(struct erase_info *instr);
+#else
+static inline void mtd_erase_callback(struct erase_info *instr)
+{
+	if (instr->callback)
+		instr->callback(instr);
+}
+#endif
+
 /*
  * Debugging macro and defines
  */


-- 
dwmw2

