Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVDXSXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVDXSXz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 14:23:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVDXSXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 14:23:02 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:21648 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S262362AbVDXSWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 14:22:07 -0400
Subject: [patch 6/6] uml: move va_copy conditional def
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it
From: blaisorblade@yahoo.it
Date: Sun, 24 Apr 2005 20:10:10 +0200
Message-Id: <20050424181010.78C2D55D03@zion>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


GCC 2.95 uses __va_copy instead of va_copy. Handle it inside compiler.h
instead of in a casual file, and avoid the risk that this breaks with a
newer compiler (which it could do).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/kernel/skas/uaccess.c |    4 ++--
 linux-2.6.12-paolo/include/linux/compiler-gcc2.h |    5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff -puN arch/um/kernel/skas/uaccess.c~uml-move-va-copy-conditional arch/um/kernel/skas/uaccess.c
--- linux-2.6.12/arch/um/kernel/skas/uaccess.c~uml-move-va-copy-conditional	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/kernel/skas/uaccess.c	2005-04-24 19:32:18.000000000 +0200
@@ -3,6 +3,7 @@
  * Licensed under the GPL
  */
 
+#include "linux/compiler.h"
 #include "linux/stddef.h"
 #include "linux/kernel.h"
 #include "linux/string.h"
@@ -61,8 +62,7 @@ static void do_buffer_op(void *jmpbuf, v
 	void *arg;
 	int *res;
 
-	/* Some old gccs recognize __va_copy, but not va_copy */
-	__va_copy(args, *(va_list *)arg_ptr);
+	va_copy(args, *(va_list *)arg_ptr);
 	addr = va_arg(args, unsigned long);
 	len = va_arg(args, int);
 	is_write = va_arg(args, int);
diff -puN include/linux/compiler-gcc2.h~uml-move-va-copy-conditional include/linux/compiler-gcc2.h
--- linux-2.6.12/include/linux/compiler-gcc2.h~uml-move-va-copy-conditional	2005-04-24 19:32:18.000000000 +0200
+++ linux-2.6.12-paolo/include/linux/compiler-gcc2.h	2005-04-24 19:32:18.000000000 +0200
@@ -22,3 +22,8 @@
 # define __attribute_pure__	__attribute__((pure))
 # define __attribute_const__	__attribute__((__const__))
 #endif
+
+/* GCC 2.95.x/2.96 recognize __va_copy, but not va_copy. Actually later GCC's
+ * define both va_copy and __va_copy, but the latter may go away, so limit this
+ * to this header */
+#define va_copy			__va_copy
_
