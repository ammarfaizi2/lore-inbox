Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268471AbTBZBMu>; Tue, 25 Feb 2003 20:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268532AbTBZBMu>; Tue, 25 Feb 2003 20:12:50 -0500
Received: from dp.samba.org ([66.70.73.150]:11945 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268471AbTBZBMt>;
	Tue, 25 Feb 2003 20:12:49 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-reply-to: Your message of "Tue, 25 Feb 2003 15:47:59 -0800."
             <Pine.LNX.4.44.0302251546590.2185-100000@home.transmeta.com> 
Date: Wed, 26 Feb 2003 12:22:26 +1100
Message-Id: <20030226012305.A31342C158@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0302251546590.2185-100000@home.transmeta.com> you wri
te:
> 
> On Tue, 25 Feb 2003, Rusty Russell wrote:
> > 
> > __optional should always be __attribute__((__unused__)), and
> > __required should be your __attribute_used__.
> 
> But I think rth's point was that "__module_depends" should definitely 
> _not_ be "optional", since that just means that the compiler can (and 
> will) optimize away the whole thing.
> 
> So marking it optional is definitely the wrong thing to do.

This time for sure!

Name: __optional attribute
Author: Rusty Russell
Status: Trivial

D: Renames __attribute_used to __required, and introduces __optional.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .25651-linux-2.5.63/include/linux/compiler.h .25651-linux-2.5.63.updated/include/linux/compiler.h
--- .25651-linux-2.5.63/include/linux/compiler.h	2003-02-25 10:11:08.000000000 +1100
+++ .25651-linux-2.5.63.updated/include/linux/compiler.h	2003-02-25 22:34:49.000000000 +1100
@@ -37,10 +37,11 @@
  * would be warned about except with attribute((unused)).
  */
 #if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
-#define __attribute_used__	__attribute__((__used__))
+#define __required	__attribute__((__used__))
 #else
-#define __attribute_used__	__attribute__((__unused__))
+#define __required	__attribute__((__unused__))
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
+	buf_printf(b, "__required\n");
 	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
 	buf_printf(b, "\"depends=");
 	for (s = mod->unres; s; s = s->next) {
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
