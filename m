Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVEPXsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVEPXsd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 19:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVEPXsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 19:48:33 -0400
Received: from waste.org ([216.27.176.166]:60886 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262001AbVEPXsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 19:48:04 -0400
Date: Mon, 16 May 2005 16:47:57 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: YhLu@tyan.com, linux-tiny@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: serial console
Message-ID: <20050516234757.GG5914@waste.org>
References: <3174569B9743D511922F00A0C943142309F80D9F@TYANWEB> <20050516205731.GA5914@waste.org> <20050516231508.GD5914@waste.org> <20050516163712.66a1a058.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050516163712.66a1a058.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2005 at 04:37:12PM -0700, Andrew Morton wrote:
> 
> It would be nicer if this was a static inline, so all the function call
> code at the callsites is removed by the compiler.

Better yet, a patch that's actually right. add_preferred_console is
setting the console used by init and so on, so it's still relevant
with CONFIG_PRINTK off. So I just move it out of the ifdef. Obviously
more correct(tm).


Move add_preferred_console out of CONFIG_PRINTK so serial console does
the right thing.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: l-p/kernel/printk.c
===================================================================
--- l-p.orig/kernel/printk.c	2005-05-16 16:37:15.000000000 -0700
+++ l-p/kernel/printk.c	2005-05-16 16:40:31.000000000 -0700
@@ -160,42 +160,6 @@ static int __init console_setup(char *st
 
 __setup("console=", console_setup);
 
-/**
- * add_preferred_console - add a device to the list of preferred consoles.
- *
- * The last preferred console added will be used for kernel messages
- * and stdin/out/err for init.  Normally this is used by console_setup
- * above to handle user-supplied console arguments; however it can also
- * be used by arch-specific code either to override the user or more
- * commonly to provide a default console (ie from PROM variables) when
- * the user has not supplied one.
- */
-int __init add_preferred_console(char *name, int idx, char *options)
-{
-	struct console_cmdline *c;
-	int i;
-
-	/*
-	 *	See if this tty is not yet registered, and
-	 *	if we have a slot free.
-	 */
-	for(i = 0; i < MAX_CMDLINECONSOLES && console_cmdline[i].name[0]; i++)
-		if (strcmp(console_cmdline[i].name, name) == 0 &&
-			  console_cmdline[i].index == idx) {
-				selected_console = i;
-				return 0;
-		}
-	if (i == MAX_CMDLINECONSOLES)
-		return -E2BIG;
-	selected_console = i;
-	c = &console_cmdline[i];
-	memcpy(c->name, name, sizeof(c->name));
-	c->name[sizeof(c->name) - 1] = 0;
-	c->options = options;
-	c->index = idx;
-	return 0;
-}
-
 static int __init log_buf_len_setup(char *str)
 {
 	unsigned long size = memparse(str, &str);
@@ -671,6 +635,42 @@ static void call_console_drivers(unsigne
 #endif
 
 /**
+ * add_preferred_console - add a device to the list of preferred consoles.
+ *
+ * The last preferred console added will be used for kernel messages
+ * and stdin/out/err for init.  Normally this is used by console_setup
+ * above to handle user-supplied console arguments; however it can also
+ * be used by arch-specific code either to override the user or more
+ * commonly to provide a default console (ie from PROM variables) when
+ * the user has not supplied one.
+ */
+int __init add_preferred_console(char *name, int idx, char *options)
+{
+	struct console_cmdline *c;
+	int i;
+
+	/*
+	 *	See if this tty is not yet registered, and
+	 *	if we have a slot free.
+	 */
+	for(i = 0; i < MAX_CMDLINECONSOLES && console_cmdline[i].name[0]; i++)
+		if (strcmp(console_cmdline[i].name, name) == 0 &&
+			  console_cmdline[i].index == idx) {
+				selected_console = i;
+				return 0;
+		}
+	if (i == MAX_CMDLINECONSOLES)
+		return -E2BIG;
+	selected_console = i;
+	c = &console_cmdline[i];
+	memcpy(c->name, name, sizeof(c->name));
+	c->name[sizeof(c->name) - 1] = 0;
+	c->options = options;
+	c->index = idx;
+	return 0;
+}
+
+/**
  * acquire_console_sem - lock the console system for exclusive use.
  *
  * Acquires a semaphore which guarantees that the caller has


-- 
Mathematics is the supreme nostalgia of our time.
