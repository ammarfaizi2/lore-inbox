Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264994AbTFWI4p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 04:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264995AbTFWI4p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 04:56:45 -0400
Received: from dp.samba.org ([66.70.73.150]:11677 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264994AbTFWI4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 04:56:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au, davem@redhat.com
Cc: linux-kernel@vger.kernel.org, mochel@osdl.org
Subject: [PATCH 1/3] Move unique identifier to header.
Date: Mon, 23 Jun 2003 19:09:04 +1000
Message-Id: <20030623091050.9C9BB2C25A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial patch required for part III.

Name: Centralize token pasting and generation of unique IDs
Author: Rusty Russell
Status: Tested on 2.5.70-bk13

D: Add __cat(a,b) to implement token pasting to stringify.h.  To
D: generate unique names, __unique_id(stem) is implemented (it'd be
D: nice to have a gcc extension to give a unique identifier).  Change
D: module.h to use them.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26569-linux-2.5.70-bk16/include/linux/module.h .26569-linux-2.5.70-bk16.updated/include/linux/module.h
--- .26569-linux-2.5.70-bk16/include/linux/module.h	2003-06-12 09:58:02.000000000 +1000
+++ .26569-linux-2.5.70-bk16.updated/include/linux/module.h	2003-06-12 16:19:16.000000000 +1000
@@ -55,10 +55,8 @@ search_extable(const struct exception_ta
 	       unsigned long value);
 
 #ifdef MODULE
-#define ___module_cat(a,b) __mod_ ## a ## b
-#define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)					  \
-static const char __module_cat(name,__LINE__)[]				  \
+static const char __unique_id(name)[]					  \
   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .26569-linux-2.5.70-bk16/include/linux/stringify.h .26569-linux-2.5.70-bk16.updated/include/linux/stringify.h
--- .26569-linux-2.5.70-bk16/include/linux/stringify.h	2003-01-02 12:25:36.000000000 +1100
+++ .26569-linux-2.5.70-bk16.updated/include/linux/stringify.h	2003-06-12 16:32:17.000000000 +1000
@@ -9,4 +9,11 @@
 #define __stringify_1(x)	#x
 #define __stringify(x)		__stringify_1(x)
 
+/* Paste two tokens together. */
+#define ___cat(a,b) a ## b
+#define __cat(a,b) ___cat(a,b)
+
+/* Try to give a unique identifier: this comes close, iff used as static. */
+#define __unique_id(stem) \
+	__cat(__cat(__uniq,stem),__cat(__LINE__,KBUILD_BASENAME))
 #endif	/* !__LINUX_STRINGIFY_H */

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
