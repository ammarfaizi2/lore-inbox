Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWAaVdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWAaVdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWAaVdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 16:33:39 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20751 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751509AbWAaVdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 16:33:09 -0500
Date: Tue, 31 Jan 2006 22:33:06 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] ISDN_CAPI_CAPIFS related cleanups
Message-ID: <20060131213306.GG3986@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- move the help text to the right option
- replace some #ifdef's in capi.c with dummy functions in capifs.h
- use CONFIG_ISDN_CAPI_CAPIFS_BOOL in one place in capi.c


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/capi/Kconfig  |   10 +++++-----
 drivers/isdn/capi/capi.c   |    9 ++-------
 drivers/isdn/capi/capifs.h |    9 +++++++++
 3 files changed, 16 insertions(+), 12 deletions(-)

--- linux-2.6.16-rc1-mm4-full/drivers/isdn/capi/Kconfig.old	2006-01-31 20:36:44.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/isdn/capi/Kconfig	2006-01-31 20:38:10.000000000 +0100
@@ -31,17 +31,17 @@
 config ISDN_CAPI_CAPIFS_BOOL
 	bool "CAPI2.0 filesystem support"
 	depends on ISDN_CAPI_MIDDLEWARE && ISDN_CAPI_CAPI20
-
-config ISDN_CAPI_CAPIFS
-	tristate
-	depends on ISDN_CAPI_CAPIFS_BOOL
-	default ISDN_CAPI_CAPI20
 	help
 	  This option provides a special file system, similar to /dev/pts with
 	  device nodes for the special ttys established by using the
 	  middleware extension above. If you want to use pppd with
 	  pppdcapiplugin to dial up to your ISP, say Y here.
 
+config ISDN_CAPI_CAPIFS
+	tristate
+	depends on ISDN_CAPI_CAPIFS_BOOL
+	default ISDN_CAPI_CAPI20
+
 config ISDN_CAPI_CAPIDRV
 	tristate "CAPI2.0 capidrv interface support"
 	depends on ISDN_CAPI && ISDN_I4L
--- linux-2.6.16-rc1-mm4-full/drivers/isdn/capi/capifs.h.old	2006-01-31 20:40:36.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/isdn/capi/capifs.h	2006-01-31 20:41:44.000000000 +0100
@@ -7,5 +7,14 @@
  *
  */
 
+#ifdef CONFIG_ISDN_CAPI_CAPIFS_BOOL
+
 void capifs_new_ncci(unsigned int num, dev_t device);
 void capifs_free_ncci(unsigned int num);
+
+#else  /*  CONFIG_ISDN_CAPI_CAPIFS_BOOL  */
+
+static inline void capifs_new_ncci(unsigned int num, dev_t device) {}
+static inline void capifs_free_ncci(unsigned int num) {}
+
+#endif  /*  CONFIG_ISDN_CAPI_CAPIFS_BOOL  */
--- linux-2.6.16-rc1-mm4-full/drivers/isdn/capi/capi.c.old	2006-01-31 20:38:53.000000000 +0100
+++ linux-2.6.16-rc1-mm4-full/drivers/isdn/capi/capi.c	2006-01-31 20:40:24.000000000 +0100
@@ -42,9 +42,8 @@
 #include <linux/devfs_fs_kernel.h>
 #include <linux/isdn/capiutil.h>
 #include <linux/isdn/capicmd.h>
-#if defined(CONFIG_ISDN_CAPI_CAPIFS) || defined(CONFIG_ISDN_CAPI_CAPIFS_MODULE)
+
 #include "capifs.h"
-#endif
 
 static char *revision = "$Revision: 1.1.2.7 $";
 
@@ -311,9 +310,7 @@
 #ifdef _DEBUG_REFCOUNT
 		printk(KERN_DEBUG "set mp->nccip\n");
 #endif
-#if defined(CONFIG_ISDN_CAPI_CAPIFS) || defined(CONFIG_ISDN_CAPI_CAPIFS_MODULE)
 		capifs_new_ncci(mp->minor, MKDEV(capi_ttymajor, mp->minor));
-#endif
 	}
 #endif /* CONFIG_ISDN_CAPI_MIDDLEWARE */
 	for (pp=&cdev->nccis; *pp; pp = &(*pp)->next)
@@ -336,9 +333,7 @@
 			*pp = (*pp)->next;
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 			if ((mp = np->minorp) != 0) {
-#if defined(CONFIG_ISDN_CAPI_CAPIFS) || defined(CONFIG_ISDN_CAPI_CAPIFS_MODULE)
 				capifs_free_ncci(mp->minor);
-#endif
 				if (mp->tty) {
 					mp->nccip = NULL;
 #ifdef _DEBUG_REFCOUNT
@@ -1520,7 +1515,7 @@
 	proc_init();
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
-#if defined(CONFIG_ISDN_CAPI_CAPIFS) || defined(CONFIG_ISDN_CAPI_CAPIFS_MODULE)
+#ifdef CONFIG_ISDN_CAPI_CAPIFS_BOOL
         compileinfo = " (middleware+capifs)";
 #else
         compileinfo = " (no capifs)";

