Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266976AbUAXRnM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 12:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266977AbUAXRnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 12:43:12 -0500
Received: from mail.timesys.com ([65.117.135.102]:26390 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S266976AbUAXRnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 12:43:07 -0500
Subject: gcc 3.4 and __attribute__ used/unused in module.h [PATCH]
From: Pragnesh Sampat <pragnesh.sampat@timesys.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1074966119.32374.22.camel@mail.sampatonline.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 24 Jan 2004 12:41:59 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Jan 2004 17:37:22.0890 (UTC) FILETIME=[B95B02A0:01C3E2A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Note: as I was writing this, came across a reference to a similar
problem in the archives with Subject -- Fix compilation on gcc 3.4 ]

Using gcc 3.4 on ppc/ep8260, I ran into a problem where the kernel
symbols were removed (gcc 3.4 was used to get nptl support with latest
glibc for ppc).  The symptom was that modules would not load and
would fail with unresolved symbols (recent module-init-tools and all).

It appears that the "unused" attribute to gcc was causing it to remove
these.  It also looks like something that was introduced explicitly
rather than a bug.  See the "Caveats" on

       http://gcc.gnu.org/gcc-3.4/changes.html

I used the following patch to get past the issue.  I am somewhat
reluctant to use compiler versions, but the other option I could think
of was to change _EXPORT_SYMBOL and related macros (not sure how
exactly I would change them, though).  Any thoughts or comments on the
patch?

-Pragnesh

--- linux-2.6.1/include/linux/compiler.h	2004-01-09 01:59:45.000000000
-0500
+++ kernel/include/linux/compiler.h	2004-01-19 21:02:57.000000000 -0500
@@ -21,6 +21,12 @@
 #endif
 #endif
 
+#if (__GNUC__ >= 3) && (__GNUC_MINOR__ >= 4)
+#define ATTRIBUTE_FOR_SYMBOLS used
+#else
+#define  ATTRIBUTE_FOR_SYMBOLS unused
+#endif
+
 /* Intel compiler defines __GNUC__. So we will overwrite
implementations
  * coming from above header files here
  */
--- linux-2.6.1/include/linux/module.h	2004-01-09 01:59:55.000000000
-0500
+++ kernel/include/linux/module.h	2004-01-19 20:51:50.000000000 -0500
@@ -60,11 +60,11 @@
 #define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)					  \
 static const char __module_cat(name,__LINE__)[]				  \
-  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "="
info
+  __attribute__((section(".modinfo"),ATTRIBUTE_FOR_SYMBOLS)) =
__stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
 extern const struct gtype##_id __mod_##gtype##_table		\
-  __attribute__ ((unused, alias(__stringify(name))))
+  __attribute__ ((ATTRIBUTE_FOR_SYMBOLS, alias(__stringify(name))))
 
 #define THIS_MODULE (&__this_module)
 
@@ -142,7 +142,7 @@
 #define __CRC_SYMBOL(sym, sec)					\
 	extern void *__crc_##sym __attribute__((weak));		\
 	static const unsigned long __kcrctab_##sym		\
-	__attribute__((section("__kcrctab" sec), unused))	\
+	__attribute__((section("__kcrctab" sec), ATTRIBUTE_FOR_SYMBOLS))	\
 	= (unsigned long) &__crc_##sym;
 #else
 #define __CRC_SYMBOL(sym, sec)
@@ -155,7 +155,7 @@
 	__attribute__((section("__ksymtab_strings")))		\
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
-	__attribute__((section("__ksymtab" sec), unused))	\
+	__attribute__((section("__ksymtab" sec), ATTRIBUTE_FOR_SYMBOLS))	\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #define EXPORT_SYMBOL(sym)					\



