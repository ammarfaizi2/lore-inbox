Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264147AbUBHWHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 17:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUBHWHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 17:07:38 -0500
Received: from almesberger.net ([63.105.73.238]:21510 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S264147AbUBHWHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 17:07:36 -0500
Date: Sun, 8 Feb 2004 19:07:32 -0300
From: Werner Almesberger <werner@almesberger.net>
To: linux-kernel@vger.kernel.org
Subject: [patch] defer panic for too many items in boot parameter line
Message-ID: <20040208190732.H1325@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When passing too many unrecognized boot command line options (which
become arguments or environment variables), the 2.6 kernel panics
(unlike 2.4, which just ignores the extra items). Unfortunately,
this happens before the console is initialized, so all you get is a
kernel that dies quickly, for no apparent reason.

This is particularly irritating if using UML with
init=something wi th a lot of ar gu men t s

The patch below delays the panic until after console_init.
It's for 2.6.2 and also works for 2.6.1. Tested on i386 and um.

- Werner

--- linux-2.6.2/init/main.c.orig	2004-02-08 17:13:20.000000000 -0300
+++ linux-2.6.2/init/main.c	2004-02-08 18:06:49.000000000 -0300
@@ -141,6 +141,7 @@
 
 static char * argv_init[MAX_INIT_ARGS+2] = { "init", NULL, };
 char * envp_init[MAX_INIT_ENVS+2] = { "HOME=/", "TERM=linux", NULL, };
+static const char *panic_later, *panic_param;
 
 __setup("profile=", profile_setup);
 
@@ -253,20 +254,27 @@
 		return 0;
 	}
 
+	if (panic_later)
+		return 0;
+
 	if (val) {
 		/* Environment option */
 		unsigned int i;
 		for (i = 0; envp_init[i]; i++) {
-			if (i == MAX_INIT_ENVS)
-				panic("Too many boot env vars at `%s'", param);
+			if (i == MAX_INIT_ENVS) {
+				panic_later = "Too many boot env vars at `%s'";
+				panic_param = param;
+			}
 		}
 		envp_init[i] = param;
 	} else {
 		/* Command line option */
 		unsigned int i;
 		for (i = 0; argv_init[i]; i++) {
-			if (i == MAX_INIT_ARGS)
-				panic("Too many boot init vars at `%s'",param);
+			if (i == MAX_INIT_ARGS) {
+				panic_later = "Too many boot init vars at `%s'";
+				panic_param = param;
+			}
 		}
 		argv_init[i] = param;
 	}
@@ -424,6 +432,8 @@
 	 * this. But we do want output early, in case something goes wrong.
 	 */
 	console_init();
+	if (panic_later)
+		panic(panic_later, panic_param);
 	profile_init();
 	local_irq_enable();
 #ifdef CONFIG_BLK_DEV_INITRD

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
