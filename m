Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286462AbSBKChX>; Sun, 10 Feb 2002 21:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286447AbSBKChO>; Sun, 10 Feb 2002 21:37:14 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:48901 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S286411AbSBKChG>;
	Sun, 10 Feb 2002 21:37:06 -0500
Date: Sun, 10 Feb 2002 21:37:02 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.4] 2nd try, drivers/char/pcwd.c
Message-ID: <Pine.LNX.4.33.0202102135540.26027-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, after screwing up the first time, and corresponding with Alan, here's
a version of the patch that should actually do something (thanks, Alan!).

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre9-old/drivers/char/pcwd.c linux-2.4.18-pre9-new/drivers/char/pcwd.c
--- linux-2.4.18-pre9-old/drivers/char/pcwd.c	Sun Feb 10 18:44:53 2002
+++ linux-2.4.18-pre9-new/drivers/char/pcwd.c	Sun Feb 10 20:53:49 2002
@@ -40,6 +40,8 @@
  *		fairly useless proc entry.
  * 990610	removed said useless proc code for the merge <alan>
  * 000403	Removed last traces of proc code. <davej>
+ * 020210	Backported 2.5 open_allowed changes, and got rid of a useless
+ *		variable <rob@osinvestor.com>
  */

 #include <linux/module.h>
@@ -100,7 +102,8 @@
 #define WD_SRLY2                0x80	/* Software external relay triggered */

 static int current_readport, revision, temp_panic;
-static int is_open, initial_status, supports_temp, mode_debug;
+static atomic_t open_allowed = ATOMIC_INIT(1);
+static int initial_status, supports_temp, mode_debug;
 static spinlock_t io_lock;

 /*
@@ -237,7 +240,7 @@
 static int pcwd_ioctl(struct inode *inode, struct file *file,
 		      unsigned int cmd, unsigned long arg)
 {
-	int i, cdat, rv;
+	int cdat, rv;
 	static struct watchdog_info ident=
 	{
 		WDIOF_OVERHEAT|WDIOF_CARDRESET,
@@ -250,8 +253,9 @@
 		return -ENOTTY;

 	case WDIOC_GETSUPPORT:
-		i = copy_to_user((void*)arg, &ident, sizeof(ident));
-		return i ? -EFAULT : 0;
+		if(copy_to_user((void*)arg, &ident, sizeof(ident)))
+			return -EFAULT;
+		return 0;

 	case WDIOC_GETSTATUS:
 		spin_lock(&io_lock);
@@ -402,8 +406,10 @@
         switch (MINOR(ino->i_rdev))
         {
                 case WATCHDOG_MINOR:
-                    if (is_open)
+                    if (!atomic_dec_and_test(&open_allowed)){
+                        atomic_inc(&open_allowed);
                         return -EBUSY;
+                    }
                     MOD_INC_USE_COUNT;
                     /*  Enable the port  */
                     if (revision == PCWD_REVISION_C)
@@ -412,7 +418,6 @@
                     	outb_p(0x00, current_readport + 3);
                     	spin_unlock(&io_lock);
                     }
-                    is_open = 1;
                     return(0);
                 case TEMP_MINOR:
                     return(0);
@@ -452,8 +457,6 @@
 {
 	if (MINOR(ino->i_rdev)==WATCHDOG_MINOR)
 	{
-		lock_kernel();
-	        is_open = 0;
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 		/*  Disable the board  */
 		if (revision == PCWD_REVISION_C) {
@@ -463,7 +466,7 @@
 			spin_unlock(&io_lock);
 		}
 #endif
-		unlock_kernel();
+		atomic_inc(&open_allowed);
 	}
 	return 0;
 }
@@ -574,7 +577,6 @@
 	printk("pcwd: v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);

 	/* Initial variables */
-	is_open = 0;
 	supports_temp = 0;
 	mode_debug = 0;
 	temp_panic = 0;

