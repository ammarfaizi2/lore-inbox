Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285850AbSBKBIB>; Sun, 10 Feb 2002 20:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285935AbSBKBHw>; Sun, 10 Feb 2002 20:07:52 -0500
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:47365 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S285850AbSBKBHi>;
	Sun, 10 Feb 2002 20:07:38 -0500
Date: Sun, 10 Feb 2002 20:07:33 -0500 (EST)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH-2.4] drivers/char/pcwd.c
Message-ID: <Pine.LNX.4.33.0202101956510.26027-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried sending to maintainer khollis@bitgate.com and kenji@bitgate.com both
bounced, so I'm sending it here instead so that perhaps someone else can
comment on my changes.  Attached below is a patch against 2.4.18-pre9
that does two things:
a) backports a 2.5 fix that closes what looks like a very small/minor
race opportunity
b) gets rid of an unneeded variable

If nobody has any objections, and if the maintainer isn't around anymore,
I've got a couple other things I'd like to do with this driver, namely:
a) run Lindent.  ugh, this code is just plain ugly
b) get rid of check_region()
c) get rid of panic()
d) general code cleanup

However, I don't have this hardware so I can't test it.  If someone else
does have this hardware and is already hacking on the code, great. I'm
hoping that by airing this out I can avoid pissing off a maintainer and
duplicating someone else's work at the same time.

Regards,
Rob Radez

diff -ruN linux-2.4.18-pre9-old/drivers/char/pcwd.c linux-2.4.18-pre9-new/drivers/char/pcwd.c
--- linux-2.4.18-pre9-old/drivers/char/pcwd.c	Sun Feb 10 18:44:53 2002
+++ linux-2.4.18-pre9-new/drivers/char/pcwd.c	Sun Feb 10 20:03:35 2002
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
@@ -250,8 +253,7 @@
 		return -ENOTTY;

 	case WDIOC_GETSUPPORT:
-		i = copy_to_user((void*)arg, &ident, sizeof(ident));
-		return i ? -EFAULT : 0;
+		return copy_to_user((void*)arg, &ident, sizeof(ident)) ? -EFAULT : 0;

 	case WDIOC_GETSTATUS:
 		spin_lock(&io_lock);
@@ -402,8 +404,10 @@
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
@@ -412,7 +416,6 @@
                     	outb_p(0x00, current_readport + 3);
                     	spin_unlock(&io_lock);
                     }
-                    is_open = 1;
                     return(0);
                 case TEMP_MINOR:
                     return(0);
@@ -452,8 +455,6 @@
 {
 	if (MINOR(ino->i_rdev)==WATCHDOG_MINOR)
 	{
-		lock_kernel();
-	        is_open = 0;
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 		/*  Disable the board  */
 		if (revision == PCWD_REVISION_C) {
@@ -463,7 +464,7 @@
 			spin_unlock(&io_lock);
 		}
 #endif
-		unlock_kernel();
+		atomic_inc(&open_allowed);
 	}
 	return 0;
 }
@@ -574,7 +575,7 @@
 	printk("pcwd: v%s Ken Hollis (kenji@bitgate.com)\n", WD_VER);

 	/* Initial variables */
-	is_open = 0;
+	set_bit(0, &open_allowed);
 	supports_temp = 0;
 	mode_debug = 0;
 	temp_panic = 0;

