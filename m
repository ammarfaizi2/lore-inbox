Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTI0Arl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 20:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbTI0Arl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 20:47:41 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:42927 "HELO
	develer.com") by vger.kernel.org with SMTP id S261753AbTI0Ari (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 20:47:38 -0400
Message-ID: <3F74DE22.60105@develer.com>
Date: Sat, 27 Sep 2003 02:47:30 +0200
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer S.r.l.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030918
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] GCC 3.3.x/3.4 compatiblity fix in include/linux/init.h
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

GCC 3.4 miscompiles the kernel because it silently optimizes away
data placed in the .init.setup section by the __setup() macro.

I've initially reported it as a 3.4 regression, but it turned
out to be correct behavior:

 http://gcc.gnu.org/bugzilla/show_bug.cgi?id=12324


__attribute__((unused)) does only avoid the warning, but doesn't
mark the data as being used.

Since GCC 3.3, __attribute__((used)) can also be applied to
variables. The __attribute_used__ macro from linux/compiler.h
already takes care of compiler differences for us.

In this patch, I've gone a step further and proactively fixed
that in all places.

Please apply.


--- linux-2.6.0-test5-bk9/include/linux/init.h.orig	2003-09-27 02:15:54.000000000 +0200
+++ linux-2.6.0-test5-bk9/include/linux/init.h	2003-09-27 02:18:25.000000000 +0200
@@ -43,12 +43,12 @@
 #define __init		__attribute__ ((__section__ (".init.text")))
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
-#define __exit_call	__attribute__ ((unused,__section__ (".exitcall.exit")))
+#define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
 #ifdef MODULE
 #define __exit		__attribute__ ((__section__(".exit.text")))
 #else
-#define __exit		__attribute__ ((unused,__section__(".exit.text")))
+#define __exit		__attribute_used__ __attribute__ ((__section__(".exit.text")))
 #endif
 
 /* For assembly routines */
@@ -79,7 +79,8 @@ extern initcall_t __security_initcall_st
  */
 
 #define __define_initcall(level,fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".initcall" level ".init"))) = fn
+	static initcall_t __initcall_##fn __attribute_used__ \
+	__attribute__((__section__(".initcall" level ".init"))) = fn
 
 #define core_initcall(fn)		__define_initcall("1",fn)
 #define postcore_initcall(fn)		__define_initcall("2",fn)
@@ -91,14 +92,16 @@ extern initcall_t __security_initcall_st
 
 #define __initcall(fn) device_initcall(fn)
 
-#define __exitcall(fn)							\
+#define __exitcall(fn) \
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
 #define console_initcall(fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".con_initcall.init")))=fn
+	static initcall_t __initcall_##fn \
+	__attribute_used__ __attribute__((__section__(".con_initcall.init")))=fn
 
 #define security_initcall(fn) \
-	static initcall_t __initcall_##fn __attribute__ ((unused,__section__ (".security_initcall.init"))) = fn
+	static initcall_t __initcall_##fn \
+	__attribute_used__ __attribute__((__section__(".security_initcall.init"))) = fn
 
 struct obs_kernel_param {
 	const char *str;
@@ -106,10 +109,11 @@ struct obs_kernel_param {
 };
 
 /* OBSOLETE: see moduleparam.h for the right way. */
-#define __setup(str, fn)						\
-	static char __setup_str_##fn[] __initdata = str;		\
-	static struct obs_kernel_param __setup_##fn			\
-		 __attribute__((unused,__section__ (".init.setup")))	\
+#define __setup(str, fn)					\
+	static char __setup_str_##fn[] __initdata = str;	\
+	static struct obs_kernel_param __setup_##fn		\
+		 __attribute_used__				\
+		 __attribute__((__section__(".init.setup")))	\
 		= { __setup_str_##fn, fn }
 
 #endif /* __ASSEMBLY__ */


-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html



