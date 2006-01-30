Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWA3WbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWA3WbH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWA3WbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:31:07 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:52715 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932393AbWA3WbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:31:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm] swsusp: do not change log level during suspend/resume
Date: Mon, 30 Jan 2006 23:31:48 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601302331.49297.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch prevents the kernel from setting the log level to 10 unconditionally
during suspend/resume which was needed in the past for debugging, but
generally is undesirable.

Please apply.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>

 kernel/power/console.c |   12 +-----------
 kernel/power/power.h   |    5 +++++
 2 files changed, 6 insertions(+), 11 deletions(-)

Index: linux-2.6.16-rc1-mm4/kernel/power/console.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/console.c	2006-01-30 21:17:53.000000000 +0100
+++ linux-2.6.16-rc1-mm4/kernel/power/console.c	2006-01-30 21:32:24.000000000 +0100
@@ -9,18 +9,11 @@
 #include <linux/console.h>
 #include "power.h"
 
-static int new_loglevel = 10;
-static int orig_loglevel;
 #ifdef SUSPEND_CONSOLE
 static int orig_fgconsole, orig_kmsg;
-#endif
 
 int pm_prepare_console(void)
 {
-	orig_loglevel = console_loglevel;
-	console_loglevel = new_loglevel;
-
-#ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
 
 	orig_fgconsole = fg_console;
@@ -41,18 +34,15 @@ int pm_prepare_console(void)
 	}
 	orig_kmsg = kmsg_redirect;
 	kmsg_redirect = SUSPEND_CONSOLE;
-#endif
 	return 0;
 }
 
 void pm_restore_console(void)
 {
-	console_loglevel = orig_loglevel;
-#ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
 	set_console(orig_fgconsole);
 	release_console_sem();
 	kmsg_redirect = orig_kmsg;
-#endif
 	return;
 }
+#endif
Index: linux-2.6.16-rc1-mm4/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/power.h	2006-01-30 21:19:43.000000000 +0100
+++ linux-2.6.16-rc1-mm4/kernel/power/power.h	2006-01-30 21:33:19.000000000 +0100
@@ -43,8 +43,13 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
+#ifdef SUSPEND_CONSOLE
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
+#else
+static int pm_prepare_console(void) { return 0; }
+static void pm_restore_console(void) {}
+#endif
 
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
