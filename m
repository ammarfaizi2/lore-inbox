Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270368AbUJUHrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270368AbUJUHrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 03:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270361AbUJUHjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 03:39:44 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:51867 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S270398AbUJUHaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 03:30:13 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/7] Input: i8042 runtime debug switch
Date: Thu, 21 Oct 2004 02:28:01 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200410210223.45498.dtor_core@ameritech.net> <200410210225.24364.dtor_core@ameritech.net> <200410210226.12239.dtor_core@ameritech.net>
In-Reply-To: <200410210226.12239.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410210228.03038.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1964, 2004-10-19 00:49:51-05:00, dtor_core@ameritech.net
  Input: i8042 - allow turning debugging on and off "on-fly"
         so people do not have to recompile their kernels to
         provide debug info.
  
         Adds new parameter i8042.debug also accessible through
         sysfs. 
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 i8042.c |    8 +++++++-
 i8042.h |    8 ++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	2004-10-21 02:10:38 -05:00
+++ b/drivers/input/serio/i8042.c	2004-10-21 02:10:38 -05:00
@@ -63,6 +63,13 @@
 MODULE_PARM_DESC(noacpi, "Do not use ACPI to detect controller settings");
 #endif
 
+#define DEBUG
+#ifdef DEBUG
+static int i8042_debug;
+module_param_named(debug, i8042_debug, bool, 600);
+MODULE_PARM_DESC(debug, "Turn i8042 debugging mode on and off");
+#endif
+
 __obsolete_setup("i8042_noaux");
 __obsolete_setup("i8042_nomux");
 __obsolete_setup("i8042_unlock");
@@ -70,7 +77,6 @@
 __obsolete_setup("i8042_direct");
 __obsolete_setup("i8042_dumbkbd");
 
-#undef DEBUG
 #include "i8042.h"
 
 spinlock_t i8042_lock = SPIN_LOCK_UNLOCKED;
diff -Nru a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
--- a/drivers/input/serio/i8042.h	2004-10-21 02:10:38 -05:00
+++ b/drivers/input/serio/i8042.h	2004-10-21 02:10:38 -05:00
@@ -119,8 +119,12 @@
 #ifdef DEBUG
 static unsigned long i8042_start;
 #define dbg_init() do { i8042_start = jiffies; } while (0)
-#define dbg(format, arg...) printk(KERN_DEBUG __FILE__ ": " format " [%d]\n" ,\
-	 ## arg, (int) (jiffies - i8042_start))
+#define dbg(format, arg...) 							\
+	do { 									\
+		if (i8042_debug)						\
+			printk(KERN_DEBUG __FILE__ ": " format " [%d]\n" ,	\
+	 			## arg, (int) (jiffies - i8042_start));		\
+	} while (0)
 #else
 #define dbg_init() do { } while (0)
 #define dbg(format, arg...) do {} while (0)
