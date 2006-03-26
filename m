Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932065AbWCZMZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932065AbWCZMZI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:25:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWCZMZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:25:07 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59652 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751293AbWCZMZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:25:06 -0500
Date: Sun, 26 Mar 2006 14:25:04 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
Subject: [2.6 patch] drivers/mtd/mtdcore.c: less PROC_FS=n #ifdef's
Message-ID: <20060326122504.GI4053@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm surprised that kill-ifdefs-in-mtdcorec.patch in -mm that removes
#ifdef's for the PROC_FS=n case wasn't tested with PROC_FS=n...

<--  snip  -->

...
  CC      drivers/mtd/mtdcore.o
drivers/mtd/mtdcore.c: In function 'init_mtd':
drivers/mtd/mtdcore.c:352: error: 'proc_mtd' undeclared (first use in this function)
drivers/mtd/mtdcore.c:352: error: (Each undeclared identifier is reported only once
drivers/mtd/mtdcore.c:352: error: for each function it appears in.)
drivers/mtd/mtdcore.c:353: error: 'mtd_read_proc' undeclared (first use in this function)
drivers/mtd/mtdcore.c: In function 'cleanup_mtd':
drivers/mtd/mtdcore.c:359: error: 'proc_mtd' undeclared (first use in this function)
make[2]: *** [drivers/mtd/mtdcore.o] Error 1

<--  snip  -->


The patch below tries to do it in a correct way.

cu
Adrian


<--  snip  -->


This patch reduces the number of #ifdef's for CONFIG_PROC_FS=n.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/mtd/mtdcore.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

--- linux-2.6.16-mm1-full/drivers/mtd/mtdcore.c.old	2006-03-25 23:22:06.000000000 +0100
+++ linux-2.6.16-mm1-full/drivers/mtd/mtdcore.c	2006-03-25 23:23:03.000000000 +0100
@@ -19,9 +19,7 @@
 #include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/mtd/compatmac.h>
-#ifdef CONFIG_PROC_FS
 #include <linux/proc_fs.h>
-#endif
 
 #include <linux/mtd/mtd.h>
 
@@ -296,10 +294,11 @@
 EXPORT_SYMBOL(default_mtd_writev);
 EXPORT_SYMBOL(default_mtd_readv);
 
+#ifdef CONFIG_PROC_FS
+
 /*====================================================================*/
 /* Support for /proc/mtd */
 
-#ifdef CONFIG_PROC_FS
 static struct proc_dir_entry *proc_mtd;
 
 static inline int mtd_proc_info (char *buf, int i)
@@ -344,31 +343,27 @@
         return ((count < begin+len-off) ? count : begin+len-off);
 }
 
-#endif /* CONFIG_PROC_FS */
-
 /*====================================================================*/
 /* Init code */
 
 static int __init init_mtd(void)
 {
-#ifdef CONFIG_PROC_FS
 	if ((proc_mtd = create_proc_entry( "mtd", 0, NULL )))
 		proc_mtd->read_proc = mtd_read_proc;
-#endif
 	return 0;
 }
 
 static void __exit cleanup_mtd(void)
 {
-#ifdef CONFIG_PROC_FS
         if (proc_mtd)
 		remove_proc_entry( "mtd", NULL);
-#endif
 }
 
 module_init(init_mtd);
 module_exit(cleanup_mtd);
 
+#endif /* CONFIG_PROC_FS */
+
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("David Woodhouse <dwmw2@infradead.org>");

