Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUDRFcv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbUDRFcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:32:51 -0400
Received: from ozlabs.org ([203.10.76.45]:39892 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264129AbUDRFcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:32:48 -0400
Subject: [PATCH] Fix unix module
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082266361.14879.27.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 18 Apr 2004 15:32:42 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply.  I should never have accepted that damn "make
modpost create the struct module" patch during the stable series: this
is at least the third fix which had to go on top of it...

Name: Fix name of unix domain sockets module
Status: Tested on 2.6.6-rc1-bk2

# lsmod
Module                  Size  Used by
1                      26060  6 
#

The compiler #define's unix to 1: we use -DKBUILD_MODNAME=unix.  We
used to #undef unix at the top of af_unix.c, but now the name is
inserted by modpost, that doesn't help.

#undef unix in modpost.c's generated C file.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.6-rc1-bk2/net/unix/af_unix.c working-2.6.6-rc1-bk2-usermodehelper-thread/net/unix/af_unix.c
--- linux-2.6.6-rc1-bk2/net/unix/af_unix.c	2004-04-05 09:04:50.000000000 +1000
+++ working-2.6.6-rc1-bk2-usermodehelper-thread/net/unix/af_unix.c	2004-04-18 15:22:23.000000000 +1000
@@ -82,8 +82,6 @@
  *		  with BSD names.
  */
 
-#undef unix	/* KBUILD_MODNAME */
-
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/kernel.h>
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.6-rc1-bk2/scripts/modpost.c working-2.6.6-rc1-bk2-usermodehelper-thread/scripts/modpost.c
--- linux-2.6.6-rc1-bk2/scripts/modpost.c	2004-04-15 16:06:55.000000000 +1000
+++ working-2.6.6-rc1-bk2-usermodehelper-thread/scripts/modpost.c	2004-04-18 15:22:07.000000000 +1000
@@ -487,6 +487,7 @@ add_header(struct buffer *b)
 	buf_printf(b, "\n");
 	buf_printf(b, "MODULE_INFO(vermagic, VERMAGIC_STRING);\n");
 	buf_printf(b, "\n");
+	buf_printf(b, "#undef unix\n"); /* We have a module called "unix" */
 	buf_printf(b, "struct module __this_module\n");
 	buf_printf(b, "__attribute__((section(\".gnu.linkonce.this_module\"))) = {\n");
 	buf_printf(b, " .name = __stringify(KBUILD_MODNAME),\n");


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

