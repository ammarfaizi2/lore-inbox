Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263633AbUJ3IRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbUJ3IRA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 04:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUJ3IQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 04:16:59 -0400
Received: from zeus.kernel.org ([204.152.189.113]:7360 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263633AbUJ3IPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 04:15:21 -0400
Date: Sat, 30 Oct 2004 10:13:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] some cdrom/mcdx.c cleanups
Message-ID: <20041030081347.GJ4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below does some cleanups in cdrom/mcdx.c

The main changes are:
- make some constants and functions static
- remove some ancient version tags
- merge the two init functions into one


diffstat output:
 drivers/cdrom/mcdx.c |  114 ++++++++++++-------------------------------
 1 files changed, 34 insertions(+), 80 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/drivers/cdrom/mcdx.c.old	2004-10-30 09:30:21.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/drivers/cdrom/mcdx.c	2004-10-30 09:49:27.000000000 +0200
@@ -51,11 +51,6 @@
  */
 
 
-#if RCS
-static const char *mcdx_c_version
-    = "$Id: mcdx.c,v 1.21 1997/01/26 07:12:59 davem Exp $";
-#endif
-
 #include <linux/version.h>
 #include <linux/module.h>
 
@@ -108,20 +103,20 @@
    The _direct_ size is the number of sectors we're allowed to skip
    directly (performing a read instead of requesting the new sector
    needed */
-const int REQUEST_SIZE = 800;	/* should be less then 255 * 4 */
-const int DIRECT_SIZE = 400;	/* should be less then REQUEST_SIZE */
+static const int REQUEST_SIZE = 800;	/* should be less then 255 * 4 */
+static const int DIRECT_SIZE = 400;	/* should be less then REQUEST_SIZE */
 
 enum drivemodes { TOC, DATA, RAW, COOKED };
 enum datamodes { MODE0, MODE1, MODE2 };
 enum resetmodes { SOFT, HARD };
 
-const int SINGLE = 0x01;	/* single speed drive (FX001S, LU) */
-const int DOUBLE = 0x02;	/* double speed drive (FX001D, ..? */
-const int DOOR = 0x04;		/* door locking capability */
-const int MULTI = 0x08;		/* multi session capability */
+static const int SINGLE = 0x01;		/* single speed drive (FX001S, LU) */
+static const int DOUBLE = 0x02;		/* double speed drive (FX001D, ..? */
+static const int DOOR = 0x04;		/* door locking capability */
+static const int MULTI = 0x08;		/* multi session capability */
 
-const unsigned char READ1X = 0xc0;
-const unsigned char READ2X = 0xc1;
+static const unsigned char READ1X = 0xc0;
+static const unsigned char READ2X = 0xc1;
 
 
 /* DECLARATIONS ****************************************************/
@@ -205,16 +200,6 @@
 };
 
 
-/* Prototypes ******************************************************/
-
-/*	The following prototypes are already declared elsewhere.  They are
- 	repeated here to show what's going on.  And to sense, if they're
-	changed elsewhere. */
-
-/* declared in blk.h */
-int mcdx_init(void);
-void do_mcdx_request(request_queue_t * q);
-
 static int mcdx_block_open(struct inode *inode, struct file *file)
 {
 	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
@@ -570,7 +555,7 @@
 	}
 }
 
-void do_mcdx_request(request_queue_t * q)
+static void do_mcdx_request(request_queue_t * q)
 {
 	struct s_drive_stuff *stuffp;
 	struct request *req;
@@ -1007,29 +992,7 @@
 	return st;
 }
 
-/* MODULE STUFF ***********************************************************/
-
-int __mcdx_init(void)
-{
-	int i;
-	int drives = 0;
-
-	mcdx_init();
-	for (i = 0; i < MCDX_NDRIVES; i++) {
-		if (mcdx_stuffp[i]) {
-			xtrace(INIT, "init_module() drive %d stuff @ %p\n",
-			       i, mcdx_stuffp[i]);
-			drives++;
-		}
-	}
-
-	if (!drives)
-		return -EIO;
-
-	return 0;
-}
-
-void __exit mcdx_exit(void)
+static void __exit mcdx_exit(void)
 {
 	int i;
 
@@ -1062,21 +1025,9 @@
 		xwarn("cleanup() unregister_blkdev() failed\n");
 	}
 	blk_cleanup_queue(mcdx_queue);
-#if !MCDX_QUIET
-	else
-	xinfo("cleanup() succeeded\n");
-#endif
 }
 
-#ifdef MODULE
-module_init(__mcdx_init);
-#endif
-module_exit(mcdx_exit);
-
-
-/* Support functions ************************************************/
-
-int __init mcdx_init_drive(int drive)
+static int __init mcdx_init_drive(int drive)
 {
 	struct s_version version;
 	struct gendisk *disk;
@@ -1262,30 +1213,30 @@
 	return 0;
 }
 
-int __init mcdx_init(void)
-{
-	int drive;
-#ifdef MODULE
-	xwarn("Version 2.14(hs) for " UTS_RELEASE "\n");
-#else
-	xwarn("Version 2.14(hs) \n");
-#endif
 
-	xwarn("$Id: mcdx.c,v 1.21 1997/01/26 07:12:59 davem Exp $\n");
+static int mcdx_init(void)
+{
+	int i;
+	int drives = 0;
 
-	/* zero the pointer array */
-	for (drive = 0; drive < MCDX_NDRIVES; drive++)
-		mcdx_stuffp[drive] = NULL;
-
-	/* do the initialisation */
-	for (drive = 0; drive < MCDX_NDRIVES; drive++) {
-		switch (mcdx_init_drive(drive)) {
-		case 2:
-			return -EIO;
-		case 1:
-			break;
+	for (i = 0; i < MCDX_NDRIVES; i++) {
+		mcdx_stuffp[i] = NULL;
+		switch (mcdx_init_drive(i)) {
+			case 2:
+				return -EIO;
+			case 1:
+				break;
+			}
+		if (mcdx_stuffp[i]) {
+			xtrace(INIT, "init_module() drive %d stuff @ %p\n",
+			       i, mcdx_stuffp[i]);
+			drives++;
 		}
 	}
+
+	if (!drives)
+		return -EIO;
+
 	return 0;
 }
 
@@ -1955,3 +1906,6 @@
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(MITSUMI_X_CDROM_MAJOR);
+
+module_init(mcdx_init);
+module_exit(mcdx_exit);

