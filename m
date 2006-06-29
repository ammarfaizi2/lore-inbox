Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932786AbWF2VjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932786AbWF2VjM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbWF2Vim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:38:42 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:20960 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932667AbWF2Vga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:36:30 -0400
Message-Id: <200606292136.k5TLaVWf010807@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 4/9] UML - unregister useless console when it's not needed
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 29 Jun 2006 17:36:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-mm in combination with an FC5 init started dying with 'stderr=1'
because init didn't like the lack of /dev/console and exited.  The
problem was that the stderr console, which is intended to dump printk
output to the terminal before the regular console is initialized,
isn't a tty, and so can't make /dev/console operational.

However, since it is registered first, the normal console, when it is
registered, doesn't become the preferred console, and isn't attached
to /dev/console.  Thus, /dev/console is never operational.

This patch makes the stderr console unregister itself in an initcall,
which is late enough that the normal console is registered.  When that
happens, the normal console will become the preferred console and will
be able to run /dev/console.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17-mm/arch/um/drivers/stderr_console.c
===================================================================
--- linux-2.6.17-mm.orig/arch/um/drivers/stderr_console.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.17-mm/arch/um/drivers/stderr_console.c	2006-06-28 22:59:46.000000000 -0400
@@ -8,10 +8,7 @@
 
 /*
  * Don't register by default -- as this registeres very early in the
- * boot process it becomes the default console.  And as this isn't a
- * real tty driver init isn't able to open /dev/console then.
- *
- * In most cases this isn't what you want ...
+ * boot process it becomes the default console.
  */
 static int use_stderr_console = 0;
 
@@ -43,3 +40,20 @@ static int stderr_setup(char *str)
 	return 1;
 }
 __setup("stderr=", stderr_setup);
+
+/* The previous behavior of not unregistering led to /dev/console being
+ * impossible to open.  My FC5 filesystem started having init die, and the
+ * system panicing because of this.  Unregistering causes the real
+ * console to become the default console, and /dev/console can then be
+ * opened.  Making this an initcall makes this happen late enough that
+ * there is no added value in dumping everything to stderr, and the
+ * normal console is good enough to show you all available output.
+ */
+static int __init unregister_stderr(void)
+{
+	unregister_console(&stderr_console);
+
+	return 0;
+}
+
+__initcall(unregister_stderr);

