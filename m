Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTAKFAg>; Sat, 11 Jan 2003 00:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267081AbTAKFAg>; Sat, 11 Jan 2003 00:00:36 -0500
Received: from dp.samba.org ([66.70.73.150]:5336 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267163AbTAKFAc>;
	Sat, 11 Jan 2003 00:00:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Richard Henderson <rth@twiddle.net>, Miles Bader <miles@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PREFIX is non-empty 
In-reply-to: Your message of "Fri, 10 Jan 2003 09:03:41 -0800."
             <Pine.LNX.4.44.0301100902380.12833-100000@home.transmeta.com> 
Date: Sat, 11 Jan 2003 15:20:47 +1100
Message-Id: <20030111050918.99C762C04F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0301100902380.12833-100000@home.transmeta.com> you wr
ite:
> 
> On Fri, 10 Jan 2003, Rusty Russell wrote:
> > 
> > Yep.  Maximum length of obsolete parameter name in current kernel:
> > seq_default_timer_resolution (28 chars).
> 
> Don't do this. Make the limit fixed, and check it.

Just in case someone names a variable over 2000 chars, and uses it as
an old-style module parameter?

Done, with protest.  Please apply.

Rusty.
(Miles, your sizeof also merged).
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Make obsolete module parameters work with MODULE_SYMBOL_PREFIX
Author: Miles Bader
Status: Trivial

D: Since these are just symbols in the module object, they need symbol name
D: munging to find the symbol from the parameter name.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .15543-linux-2.5-bk/kernel/module.c .15543-linux-2.5-bk.updated/kernel/module.c
--- .15543-linux-2.5-bk/kernel/module.c	2003-01-10 10:55:43.000000000 +1100
+++ .15543-linux-2.5-bk.updated/kernel/module.c	2003-01-11 15:15:59.000000000 +1100
@@ -680,18 +680,31 @@ static int obsolete_params(const char *n
 		return -ENOMEM;
 
 	DEBUGP("Module %s has %u obsolete params\n", name, num);
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
+		if (strlen(obsparm[i].name) > 1024) {
+			printk("%s: Huge parameter.  Linus 1, Rusty 0.\n",
+			       name);
+			ret = -EINVAL;
+			goto out;
+		}
 		DEBUGP("Param %i: %s type %s\n",
 		       num, obsparm[i].name, obsparm[i].type);
+	}
 
 	for (i = 0; i < num; i++) {
+		char sym_name[strlen(obsparm[i].name)
+			     + sizeof(MODULE_SYMBOL_PREFIX)];
+
+		strcpy(sym_name, MODULE_SYMBOL_PREFIX);
+		strcat(sym_name, obsparm[i].name);
+
 		kp[i].name = obsparm[i].name;
 		kp[i].perm = 000;
 		kp[i].set = set_obsolete;
 		kp[i].get = NULL;
 		obsparm[i].addr
 			= (void *)find_local_symbol(sechdrs, symindex, strtab,
-						    obsparm[i].name);
+						    sym_name);
 		if (!obsparm[i].addr) {
 			printk("%s: falsely claims to have parameter %s\n",
 			       name, obsparm[i].name);
