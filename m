Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262675AbTCJACh>; Sun, 9 Mar 2003 19:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262677AbTCJACh>; Sun, 9 Mar 2003 19:02:37 -0500
Received: from pasky.ji.cz ([62.44.12.54]:13298 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id <S262675AbTCJACf>;
	Sun, 9 Mar 2003 19:02:35 -0500
Date: Mon, 10 Mar 2003 01:13:10 +0100
From: Petr Baudis <pasky@ucw.cz>
To: linux-kernel@vger.kernel.org, linux-security-module@mail.wirex.com
Cc: greg@kroah.com
Subject: [PATCH] kobject support for LSM core
Message-ID: <20030310001310.GU3917@pasky.ji.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-security-module@mail.wirex.com, greg@kroah.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  the following patch (against 2.5.64) introduces kobject infrastructure
scaffolding to the LSM framework. It does nothing but allocating security root
subsystem for the LSMs, so that they are tied to one specific point in the
kobject hierarchy. They are suggested to create own subsystems under the
security subsystem, however such things are completely up to the individual
LSMs and not regulated by core in any way (it's not that I would so much like
such an approach, but I was advised so by GregKH and it makes sense in its own
way as well).

  A lot of LSMs use various ad hoc methods for communication with the userspace
and using the sysfs framework could be very convient for them, and there is at
least one real-world (altough yet a bit primitive) LSM which already uses the
security subsystem: http://pasky.ji.cz/securitylevels/.

  It works fine for me and it should be pretty trivial. Please consider
applying.

 security/security.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+)

  Kind regards,
				Petr Baudis

--- linux/security/security.c	Sun Mar  9 00:40:32 2003
+++ linux+pasky/security/security.c	Thu Mar  6 23:33:49 2003
@@ -9,11 +9,15 @@
  *	it under the terms of the GNU General Public License as published by
  *	the Free Software Foundation; either version 2 of the License, or
  *	(at your option) any later version.
+ *
+ * Introduced kobject infrastructure.
+ * 2003-02-27 Petr Baudis <pasky@ucw.cz>
  */
 
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/security.h>
@@ -38,6 +42,7 @@
 	return 0;
 }
 
+
 /**
  * security_scaffolding_startup - initialzes the security scaffolding framework
  *
@@ -59,6 +64,30 @@
 	return 0;
 }
 
+
+/* kobject stuff */
+
+/* We define only the base subsystem here and leave everything to a LSM. It is
+ * heavily recommended that the LSM should create own subsystem under this one,
+ * so that it can be easily made stackable and it doesn't confuse userland by
+ * exporting its stuff directly to /sys/security/. */
+decl_subsys(security,NULL);
+
+/**
+ * security_kobj_init - initializes the security kobject subsystem
+ *
+ * This is called after security_scaffolding_startup as a regular initcall,
+ * since we need sysfs mounted already.
+ */
+static int __init security_kobj_init (void)
+{
+	subsystem_register (&security_subsys);
+	return 0;
+}
+
+subsys_initcall(security_kobj_init);
+
+
 /**
  * register_security - registers a security framework with the kernel
  * @ops: a pointer to the struct security_options that is to be registered
@@ -197,3 +226,4 @@
 EXPORT_SYMBOL_GPL(mod_unreg_security);
 EXPORT_SYMBOL(capable);
 EXPORT_SYMBOL(security_ops);
+EXPORT_SYMBOL(security_subsys);
