Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTIHCnG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbTIHCnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:43:06 -0400
Received: from dp.samba.org ([66.70.73.150]:51625 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261329AbTIHCnD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:43:03 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] modprobe -q: quieter when modules missing
Date: Mon, 08 Sep 2003 12:42:27 +1000
Message-Id: <20030908024303.36AF72C186@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  modprobe -q currently suppresses only "module
already loaded" messages, but in next release it also suppresses "no
such module" messages.

Name: Modprobe should be invoked with -q
Status: Tested on 2.6.0-test4-bk9

D: The kernel invokes "modprobe" on modules which might not exist:
D: rightfully, modprobe complains by default when this happens.  So
D: the correct response is to invoke "modprobe -q", which is silent on
D: such errors (but still reports other errors such as config errors).
D: Also, use MODULE_NAME_LEN from module.h instead of inventing our own.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .24247-linux-2.6.0-test4-bk9/kernel/kmod.c .24247-linux-2.6.0-test4-bk9.updated/kernel/kmod.c
--- .24247-linux-2.6.0-test4-bk9/kernel/kmod.c	2003-06-23 10:52:59.000000000 +1000
+++ .24247-linux-2.6.0-test4-bk9.updated/kernel/kmod.c	2003-09-08 12:27:34.000000000 +1000
@@ -60,12 +60,11 @@ char modprobe_path[256] = "/sbin/modprob
  */
 int request_module(const char *fmt, ...)
 {
-#define MODULENAME_SIZE 32
 	va_list args;
-	char module_name[MODULENAME_SIZE];
+	char module_name[MODULE_NAME_LEN];
 	unsigned int max_modprobes;
 	int ret;
-	char *argv[] = { modprobe_path, "--", module_name, NULL };
+	char *argv[] = { modprobe_path, "-q", "--", module_name, NULL };
 	static char *envp[] = { "HOME=/",
 				"TERM=linux",
 				"PATH=/sbin:/usr/sbin:/bin:/usr/bin",
@@ -75,9 +74,9 @@ int request_module(const char *fmt, ...)
 	static int kmod_loop_msg;
 
 	va_start(args, fmt);
-	ret = vsnprintf(module_name, MODULENAME_SIZE, fmt, args);
+	ret = vsnprintf(module_name, MODULE_NAME_LEN, fmt, args);
 	va_end(args);
-	if (ret >= MODULENAME_SIZE)
+	if (ret >= MODULE_NAME_LEN)
 		return -ENAMETOOLONG;
 
 	/* If modprobe needs a service that is in a module, we get a recursive

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

