Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266853AbTGGHq3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 03:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266841AbTGGHqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 03:46:23 -0400
Received: from dp.samba.org ([66.70.73.150]:27827 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266832AbTGGHqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 03:46:17 -0400
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL] __cat and __unique_id in stringify.h
Date: Mon, 07 Jul 2003 17:57:03 +1000
Message-Id: <20030707080051.E23832C35F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Rusty Russell <rusty@rustcorp.com.au>

  __cat() to paste tokens could be used in a few places, and
  __unique_id() is useful for module.h.
  
  Linus, please apply,
  Rusty.
  --
    Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
  
  Name: Centralize token pasting and generation of unique IDs
  Author: Rusty Russell
  Status: Tested on 2.5.70-bk13
  
  D: Add __cat(a,b) to implement token pasting to stringify.h.  To
  D: generate unique names, __unique_id(stem) is implemented (it'd be
  D: nice to have a gcc extension to give a unique identifier).  Change
  D: module.h to use them.
  

--- trivial-2.5.74-bk4/include/linux/module.h.orig	2003-07-07 17:36:52.000000000 +1000
+++ trivial-2.5.74-bk4/include/linux/module.h	2003-07-07 17:36:52.000000000 +1000
@@ -55,10 +55,8 @@
 	       unsigned long value);
 
 #ifdef MODULE
-#define ___module_cat(a,b) __mod_ ## a ## b
-#define __module_cat(a,b) ___module_cat(a,b)
 #define __MODULE_INFO(tag, name, info)					  \
-static const char __module_cat(name,__LINE__)[]				  \
+static const char __unique_id(name)[]					  \
   __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
--- trivial-2.5.74-bk4/include/linux/stringify.h.orig	2003-07-07 17:36:52.000000000 +1000
+++ trivial-2.5.74-bk4/include/linux/stringify.h	2003-07-07 17:36:52.000000000 +1000
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
  What is this? http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
  Don't blame me: the Monkey is driving
  File: Rusty Russell <rusty@rustcorp.com.au>: [PATCH] __cat and __unique_id in stringify.h
