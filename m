Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTBYEwz>; Mon, 24 Feb 2003 23:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTBYEwz>; Mon, 24 Feb 2003 23:52:55 -0500
Received: from dp.samba.org ([66.70.73.150]:30364 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267048AbTBYEww>;
	Mon, 24 Feb 2003 23:52:52 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Subject: Re: [PATCH] eliminate warnings in generated module files 
In-reply-to: Your message of "Tue, 18 Feb 2003 18:43:17 -0800."
             <20030218184317.A20436@twiddle.net> 
Date: Tue, 25 Feb 2003 15:32:21 +1100
Message-Id: <20030225050306.F0BF82C19D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030218184317.A20436@twiddle.net> you write:
> +#if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
> +#define __attribute_used__	__attribute__((__used__))
> +#else
> +#define __attribute_used__	__attribute__((__unused__))
> +#endif
> +

After some thought, I prefer __optional.  The unused attribute has
muddied the waters too badly for "used" or "unused" to be clear.

We could debate this for days.  Linus, apply or don't.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: __optional attribute
Author: Rusty Russell
Status: Trivial

D: Renames __attribute_used to __optional.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21098-linux-2.5.63/include/linux/compiler.h .21098-linux-2.5.63.updated/include/linux/compiler.h
--- .21098-linux-2.5.63/include/linux/compiler.h	2003-02-25 10:11:08.000000000 +1100
+++ .21098-linux-2.5.63.updated/include/linux/compiler.h	2003-02-25 15:28:39.000000000 +1100
@@ -37,9 +37,9 @@
  * would be warned about except with attribute((unused)).
  */
 #if __GNUC__ == 3 && __GNUC_MINOR__ >= 3 || __GNUC__ > 3
-#define __attribute_used__	__attribute__((__used__))
+#define __optional	__attribute__((__used__))
 #else
-#define __attribute_used__	__attribute__((__unused__))
+#define __optional	__attribute__((__unused__))
 #endif
 
 /* This macro obfuscates arithmetic on a variable address so that gcc
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .21098-linux-2.5.63/scripts/modpost.c .21098-linux-2.5.63.updated/scripts/modpost.c
--- .21098-linux-2.5.63/scripts/modpost.c	2003-02-25 10:11:14.000000000 +1100
+++ .21098-linux-2.5.63.updated/scripts/modpost.c	2003-02-25 15:30:37.000000000 +1100
@@ -450,7 +450,7 @@ add_depends(struct buffer *b, struct mod
 
 	buf_printf(b, "\n");
 	buf_printf(b, "static const char __module_depends[]\n");
-	buf_printf(b, "__attribute_used__\n");
+	buf_printf(b, "__optional\n");
 	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
 	buf_printf(b, "\"depends=");
 	for (s = mod->unres; s; s = s->next) {
