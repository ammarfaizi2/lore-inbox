Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265437AbSL1DpB>; Fri, 27 Dec 2002 22:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSL1DpB>; Fri, 27 Dec 2002 22:45:01 -0500
Received: from dp.samba.org ([66.70.73.150]:64447 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265437AbSL1DpA>;
	Fri, 27 Dec 2002 22:45:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, william stinson <wstinson@wanadoo.fr>,
       trivial@rustcorp.com.au
Subject: [PATCH] Mark deprecated functions so they give a warning on use
Date: Sat, 28 Dec 2002 11:57:10 +1100
Message-Id: <20021228035319.903502C04B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If anyone can think of a better way, please share.  This should speed
up the removal of functions like check_region() (which, despite
William's janitorial efforts, is still not at the stage where it can
be removed).

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Mark deprecated functions so they give a warning on use
Author: Rusty Russell
Status: Trivial

D: Should speed elimination of deprecated functions (eg. check_region,
D: deprecated since 2.3, still used in about 120 files).
D:
D: This patch causes an "unused label" warning: hopefully unusual
D: enough to make people look twice. eg:
D:  drivers/net/depca.c: In function `isa_probe':
D:  drivers/net/depca.c:1413: warning: label `DEPRECATED_use_request_region_return_value' defined but not used

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.53/include/linux/compiler.h working-2.5.53-deprecated/include/linux/compiler.h
--- linux-2.5.53/include/linux/compiler.h	2002-12-28 11:12:34.000000000 +1100
+++ working-2.5.53-deprecated/include/linux/compiler.h	2002-12-28 11:51:08.000000000 +1100
@@ -19,4 +19,10 @@
   ({ unsigned long __ptr;					\
     __asm__ ("" : "=g"(__ptr) : "0"(ptr));		\
     (typeof(ptr)) (__ptr + (off)); })
+
+/* Used to give a warning on use of deprecated functions.  eg:
+   #define some_old_function(arg) \
+	__DEPRECATED(use_newfunction_instead), __some_old_function(arg)
+*/
+#define __DEPRECATED(msg) ({DEPRECATED_##msg: 1; })
 #endif /* __LINUX_COMPILER_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.53/include/linux/ioport.h working-2.5.53-deprecated/include/linux/ioport.h
--- linux-2.5.53/include/linux/ioport.h	2002-10-31 12:37:01.000000000 +1100
+++ working-2.5.53-deprecated/include/linux/ioport.h	2002-12-28 11:51:46.000000000 +1100
@@ -7,6 +7,7 @@
 
 #ifndef _LINUX_IOPORT_H
 #define _LINUX_IOPORT_H
+#include <linux/compiler.h>
 
 /*
  * Resources are tree-like, allowing
@@ -102,7 +103,7 @@ extern int allocate_resource(struct reso
 extern struct resource * __request_region(struct resource *, unsigned long start, unsigned long n, const char *name);
 
 /* Compatibility cruft */
-#define check_region(start,n)	__check_region(&ioport_resource, (start), (n))
+#define check_region(start,n)	__DEPRECATED(use_request_region_return_value), __check_region(&ioport_resource, (start), (n))
 #define release_region(start,n)	__release_region(&ioport_resource, (start), (n))
 #define check_mem_region(start,n)	__check_region(&iomem_resource, (start), (n))
 #define release_mem_region(start,n)	__release_region(&iomem_resource, (start), (n))
