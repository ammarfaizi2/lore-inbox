Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268013AbTBYXd2>; Tue, 25 Feb 2003 18:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268375AbTBYXd2>; Tue, 25 Feb 2003 18:33:28 -0500
Received: from dp.samba.org ([66.70.73.150]:59266 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268013AbTBYXd0>;
	Tue, 25 Feb 2003 18:33:26 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Subject: Re: [PATCH] eliminate warnings in generated module files 
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In-reply-to: Your message of "Mon, 24 Feb 2003 23:58:29 -0800."
             <20030224235829.A12782@twiddle.net> 
Date: Tue, 25 Feb 2003 22:39:59 +1100
Message-Id: <20030225234343.1109E2C05E@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030224235829.A12782@twiddle.net> you write:
> On Tue, Feb 25, 2003 at 03:32:21PM +1100, Rusty Russell wrote:
> > After some thought, I prefer __optional.
> 
> Um, "optional" does not in any way accurately describe attribute used.
> In fact, it means almost exactly the opposite.

Yep.

__optional should always be __attribute__((__unused__)), and
__required should be your __attribute_used__.

This one makes more sense to the user, I think:

/* May not be used depending on config options */
static ctl_table ip_conntrack_table[] __optional = { ...

/* Must be in binary for strings to find */
static char version_string[] = "Version foo.c 1.2.3" __required;

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

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
+	buf_printf(b, "__optional\n");
 	buf_printf(b, "__attribute__((section(\".modinfo\"))) =\n");
 	buf_printf(b, "\"depends=");
 	for (s = mod->unres; s; s = s->next) {
