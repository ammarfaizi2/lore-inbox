Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263618AbTIHUd5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 16:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTIHUd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 16:33:57 -0400
Received: from palrel11.hp.com ([156.153.255.246]:63176 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S263618AbTIHUcr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 16:32:47 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16220.59240.88906.573561@napali.hpl.hp.com>
Date: Mon, 8 Sep 2003 13:32:40 -0700
To: torvalds@transmeta.com
Cc: Jan Hubicka <jh@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
In-Reply-To: <ugbrty49ri.fsf@panda.mostang.com>
References: <sqnW.3zE.13@gated-at.bofh.it>
	<sqHd.3Yj.1@gated-at.bofh.it>
	<srtA.53H.1@gated-at.bofh.it>
	<sFmW.78P.13@gated-at.bofh.it>
	<ugbrty49ri.fsf@panda.mostang.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a minimal platform-independent patch which lets me build the
ia64 kernel with the current gcc-pre3.4 snapshot (which optimizes away
static variables which have no compiler-visible references).  All it
does is mark the init-call macros with "__attribute_unused__" (plus a
minor whitespace fix).

I did have to add an include of <linux/compiler.h> to <linux/init.h>.
That ought to be safe, because the only other include file used by
these files is <linux/config.h>.

Please apply, if there are no objections.

Thanks,

	--david

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1305  -> 1.1306 
#	include/linux/init.h	1.26    -> 1.27   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/08	davidm@tiger.hpl.hp.com	1.1306
# Mark initcall macros with __attribute_used__ so the definitions do not
# get optimized away by the compiler (such as the latest GCC pre-3.4).
# --------------------------------------------
#
diff -Nru a/include/linux/init.h b/include/linux/init.h
--- a/include/linux/init.h	Mon Sep  8 13:28:21 2003
+++ b/include/linux/init.h	Mon Sep  8 13:28:21 2003
@@ -2,6 +2,7 @@
 #define _LINUX_INIT_H
 
 #include <linux/config.h>
+#include <linux/compiler.h>
 
 /* These macros are used to mark some functions or 
  * initialized data (doesn't apply to uninitialized data)
@@ -71,15 +72,16 @@
 
 #ifndef __ASSEMBLY__
 
-/* initcalls are now grouped by functionality into separate 
+/* initcalls are now grouped by functionality into separate
  * subsections. Ordering inside the subsections is determined
- * by link order. 
- * For backwards compatibility, initcall() puts the call in 
+ * by link order.
+ * For backwards compatibility, initcall() puts the call in
  * the device init subsection.
  */
 
-#define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".initcall" level ".init"))) = fn
+#define __define_initcall(level,fn)								\
+	static initcall_t __initcall_##fn							\
+	  __attribute_used__ __attribute__ ((__section__ (".initcall" level ".init"))) = fn
 
 #define core_initcall(fn)		__define_initcall("1",fn)
 #define postcore_initcall(fn)		__define_initcall("2",fn)
@@ -95,10 +97,12 @@
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
 #define console_initcall(fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".con_initcall.init")))=fn
+	static initcall_t __initcall_##fn \
+	  __attribute_used__ __attribute__ ((__section__ (".con_initcall.init"))) = fn
 
 #define security_initcall(fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".security_initcall.init"))) = fn
+	static initcall_t __initcall_##fn \
+	  __attribute_used__ __attribute__ ((__section__ (".security_initcall.init"))) = fn
 
 struct obs_kernel_param {
 	const char *str;
@@ -106,10 +110,10 @@
 };
 
 /* OBSOLETE: see moduleparam.h for the right way. */
-#define __setup(str, fn)						\
-	static char __setup_str_##fn[] __initdata = str;		\
-	static struct obs_kernel_param __setup_##fn			\
-		 __attribute__((unused,__section__ (".init.setup")))	\
+#define __setup(str, fn)							\
+	static char __setup_str_##fn[] __initdata = str;			\
+	static struct obs_kernel_param __setup_##fn				\
+		__attribute_used__ __attribute__((__section__ (".init.setup")))	\
 		= { __setup_str_##fn, fn }
 
 #endif /* __ASSEMBLY__ */
