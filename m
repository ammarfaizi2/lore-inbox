Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268622AbTBZEDt>; Tue, 25 Feb 2003 23:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268625AbTBZEDs>; Tue, 25 Feb 2003 23:03:48 -0500
Received: from dp.samba.org ([66.70.73.150]:59837 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268622AbTBZEDp>;
	Tue, 25 Feb 2003 23:03:45 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: torvalds@transmeta.com, rth@twiddle.net, linux-kernel@vger.kernel.org,
       kai@tp1.ruhr-uni-bochum.de,
       "Milton D. Miller II" <miltonm@realtime.net>
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-reply-to: Your message of "Tue, 25 Feb 2003 19:35:58 -0800."
             <1707.4.64.238.61.1046230558.squirrel@www.osdl.org> 
Date: Wed, 26 Feb 2003 15:08:26 +1100
Message-Id: <20030226041359.C92F52C05D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1707.4.64.238.61.1046230558.squirrel@www.osdl.org> you write:
> I have to agree with Kai and Milton Miller on this (bad) naming.
> __required and __optional don't generate the corrent connotations
> of what is being attempted here.

The problem with "used" is that you're saying "compiler, treat this as
used, so you don't discard it".

The level of indirection seems completely natural to compiler people,
but as a coder I just want to say "don't discard this", hence "__keep"
is good.

OTOH, __optional is fairly clearly "you can drop it".  "Unused" is
clearly a lie for some configurations.

Here's Take III:

Name: __keep and __optional attributes
Author: Rusty Russell
Status: Trivial

D: Renames __attribute_used to __keep, and introduces __optional.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25651-linux-2.5.63/include/linux/compiler.h .25651-linux-2.5.63.updated/include/linux/compiler.h
--- .25651-linux-2.5.63/include/linux/compiler.h	2003-02-25 10:11:08.000000000 +1100
+++ .25651-linux-2.5.63.updated/include/linux/compiler.h	2003-02-25 22:34:49.000000000 +1100
@@ -37,10 +37,11 @@
  * would be warned about except with attribute((unused)).
  */
 #if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
-#define __attribute_used__	__attribute__((__used__))
+#define __keep		__attribute__((__used__))
 #else
-#define __attribute_used__	__attribute__((__unused__))
+#define __keep		__attribute__((__unused__))
 #endif
+#define __optional	__attribute__((__unused__))
 
 /* This macro obfuscates arithmetic on a variable address so that gcc
    shouldn't recognize the original var, and make assumptions about it */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25651-linux-2.5.63/scripts/modpost.c .25651-linux-2.5.63.updated/scripts/modpost.c
--- .25651-linux-2.5.63/scripts/modpost.c	2003-02-25 10:11:14.000000000 +1100
+++ .25651-linux-2.5.63.updated/scripts/modpost.c	2003-02-25 22:34:10.000000000 +1100
@@ -450,7 +450,7 @@ add_depends(struct buffer *b, struct mod
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const char __module_depends[]\n");
-	buf_printf(b, "__attribute_used__\n");
+	buf_printf(b, "__keep\n");
 	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
 	buf_printf(b, "\"depends=");
 	for (s = mod->unres; s; s = s->next) {
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
