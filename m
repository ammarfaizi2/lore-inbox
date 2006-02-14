Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbWBNOsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbWBNOsQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 09:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161045AbWBNOsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 09:48:16 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:16918 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161005AbWBNOsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 09:48:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=NJChejortokwIgiF/QWLCEqh3DHYXMggy5pW3FwW2ZwLpLyeW3zDei9UvdEJcbbrTAmdC9rLQJfiC1638fEao16+s6IT2LEByXY1Rre7cTl9PWUeT6e/KdsE4HlU6GsCqrbUZV/zsvLvzLIgo8GiQ93Z6/tbNpCQWpv6ROs2Y2c=
Message-ID: <43F1ED62.4050609@gmail.com>
Date: Tue, 14 Feb 2006 15:46:58 +0100
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] CONSOLE_LP_STRICT Kconfig option
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
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
