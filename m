Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbUCJXid (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbUCJXid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:38:33 -0500
Received: from ozlabs.org ([203.10.76.45]:44165 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262565AbUCJXiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:38:24 -0500
Subject: [PATCH] module.h unused or used?
From: Rusty Russell <rusty@rustcorp.com.au>
To: ak@suse.de
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1078961842.23891.94.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 11 Mar 2004 10:37:22 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Name: EXPORT_SYMBOL declares something used and unused
Author: Rusty Russell
Status: Trival

Someone added __attribute_used__ throughout module.h, but didn't
remove the ", unused".  Looks like some arch/gcc combos still consider
it unused, and discard the fn.

Rant: GCC should have introduced "needed" and "unneeded" attributed,
rather than dick around with the established behaviour of "unused",
which could then be a (deprecated) synonym for "needed".  The user
then gets an unused warning and inserts attribute "needed" or
"unneeded": both suppress the warning, but say explicitly whether it
can be discarded or not.

But now we have "used" meaning it's unused (as the compiler will tell
you), BUT I need it anyway.  And every time I use them I have to check
which is which.  Even better, used defines to unused for backwards
compatibility.  Um, yeah.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .11285-linux-2.6.4-rc3-bk1/include/linux/module.h .11285-linux-2.6.4-rc3-bk1.updated/include/linux/module.h
--- .11285-linux-2.6.4-rc3-bk1/include/linux/module.h	2004-03-10 12:12:05.000000000 +1100
+++ .11285-linux-2.6.4-rc3-bk1.updated/include/linux/module.h	2004-03-11 10:32:50.000000000 +1100
@@ -64,11 +64,12 @@ void sort_main_extable(void);
 #define __MODULE_INFO(tag, name, info)					  \
 static const char __module_cat(name,__LINE__)[]				  \
   __attribute_used__							  \
-  __attribute__((section(".modinfo"),unused)) = __stringify(tag) "=" info
+  __attribute__((section(".modinfo"))) = __stringify(tag) "=" info
 
 #define MODULE_GENERIC_TABLE(gtype,name)			\
 extern const struct gtype##_id __mod_##gtype##_table		\
-  __attribute__ ((unused, alias(__stringify(name))))
+  __attribute_used__						\
+  __attribute__ ((alias(__stringify(name))))
 
 #define THIS_MODULE (&__this_module)
 
@@ -165,7 +166,7 @@ void *__symbol_get_gpl(const char *symbo
 	extern void *__crc_##sym __attribute__((weak));		\
 	static const unsigned long __kcrctab_##sym		\
 	__attribute_used__					\
-	__attribute__((section("__kcrctab" sec), unused))	\
+	__attribute__((section("__kcrctab" sec)))		\
 	= (unsigned long) &__crc_##sym;
 #else
 #define __CRC_SYMBOL(sym, sec)
@@ -179,7 +180,7 @@ void *__symbol_get_gpl(const char *symbo
 	= MODULE_SYMBOL_PREFIX #sym;                    	\
 	static const struct kernel_symbol __ksymtab_##sym	\
 	__attribute_used__					\
-	__attribute__((section("__ksymtab" sec), unused))	\
+	__attribute__((section("__ksymtab" sec)))		\
 	= { (unsigned long)&sym, __kstrtab_##sym }
 
 #define EXPORT_SYMBOL(sym)					\

-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

