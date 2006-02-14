Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422633AbWBNVFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422633AbWBNVFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422648AbWBNVFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:05:40 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:65449 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422633AbWBNVFj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:05:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NoFcFV/QHEqVcsYb7R3xPfSODaiFqZTZ+skpnq+ohNEFthCGtuaaStbKwivHQPRCuCJ5XUc2xj1p5OI6zNPydEvjuMWxW80Zrl7EQQIU7NZkzjdQpDaTI3iTGrIov8gj0FXLzbgcQONhPYk8t9AoqsUjvIWtTAgA/fPLjyQQxLE=
Message-ID: <ff1cadb20602141305o5fa0acebn@mail.gmail.com>
Date: Tue, 14 Feb 2006 22:05:37 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] CONSOLE_LP_STRICT Kconfig option
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, built against kernel version 2.6.16-rc3, provides a Kconfig
option in order to easily enable or disable CONSOLE_LP_STRICT variable
in drivers/char/lp.c without modifying it directly.



Signed-off-by: Luca Falavigna <dktrkranz@gmail.com>

--- linux-2.6.16-rc3/drivers/char/lp.c.orig    2006-01-08
16:48:14.000000000 +0100
+++ linux-2.6.16-rc3/drivers/char/lp.c    2006-02-14 13:43:41.000000000
+0100
@@ -686,9 +686,13 @@ static struct file_operations lp_fops =
 #define CONSOLE_LP 0

 /* If the printer is out of paper, we can either lose the messages or
- * stall until the printer is happy again.  Define CONSOLE_LP_STRICT
- * non-zero to get the latter behaviour. */
-#define CONSOLE_LP_STRICT 1
+ * stall until the printer is happy again. If CONSOLE_LP_STRICT is
+ * non-zero to, we get the latter behaviour. */
+#ifdef CONFIG_LP_CONSOLE_STRICT
+# define CONSOLE_LP_STRICT 1
+#else
+# define CONSOLE_LP_STRICT 0
+#endif

 /* The console must be locked when we get here. */

@@ -697,7 +701,7 @@ static void lp_console_write (struct con
 {
     struct pardevice *dev = lp_table[CONSOLE_LP].dev;
     struct parport *port = dev->port;
-    ssize_t written;
+    ssize_t written = 0;

     if (parport_claim (dev))
         /* Nothing we can do. */
--- linux-2.6.16-rc3/drivers/char/Kconfig.orig    2006-02-14
00:14:08.000000000 +0100
+++ linux-2.6.16-rc3/drivers/char/Kconfig    2006-02-14
13:47:33.000000000 +0100
@@ -512,14 +512,21 @@ config LP_CONSOLE
       doing that; to actually get it to happen you need to pass the
       option "console=lp0" to the kernel at boot time.

-      If the printer is out of paper (or off, or unplugged, or too
-      busy..) the kernel will stall until the printer is ready again.
-      By defining CONSOLE_LP_STRICT to 0 (at your own risk) you
-      can make the kernel continue when this happens,
-      but it'll lose the kernel messages.
-
       If unsure, say N.

+config LP_CONSOLE_STRICT
+    bool "Wait for a ready printer"
+    depends on LP_CONSOLE
+    default y
+    ---help---
+      With this option enabled, if the printer is out of paper (or off,
+      or unplugged, or too busy..) the kernel will stall until the printer
+      is ready again. By turning this option off (at your own risk), you
+      can make the kernel continue when this happens, but it will lose
+      some kernel messages.
+
+      If unsure, say Y
+
 config PPDEV
     tristate "Support for user-space parallel port device drivers"
     depends on PARPORT



Regards,

--
Luca
