Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbTAWG1y>; Thu, 23 Jan 2003 01:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbTAWG1y>; Thu, 23 Jan 2003 01:27:54 -0500
Received: from dp.samba.org ([66.70.73.150]:3244 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264919AbTAWG1v>;
	Thu, 23 Jan 2003 01:27:51 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess 
In-reply-to: Your message of "Mon, 20 Jan 2003 14:41:03 BST."
             <200301201341.OAA23795@harpo.it.uu.se> 
Date: Tue, 21 Jan 2003 18:23:38 +1100
Message-Id: <20030123063701.4A4CD2C57C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200301201341.OAA23795@harpo.it.uu.se> you write:
> Booting kernel 2.5.59 with the "-s" kernel boot parameter
> doesn't get you into single-user mode like it should.
> 
> One part of the problem is Rusty's new module option and
> kernel boot parameter parsing code, which changes '-' to
> '_' in every string. This change is not reverted when the
> string is found NOT to be a kernel option, with the result
> that "_s" is passed to init instead of "-s".

That's a bug.  Good catch.  Fix below.

> Why is this s/-/_/ stuff done at all?
> I suppose it's because the string is compared with
> MODULE_PARAM_PREFIX, which is __stringify(KBUILD_MODNAME) ".",
> and KBUILD_MODNAME is the module name after s/-/_/.

Basically because making - and _ equal is the only sane way to unify
parameter names without pissing off users, and life for coders is much
nicer when KBUILD_MODNAME is a unique valid C prefix for that module.

Thanks for the report!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Avoid mangling - in parameters
Author: Rusty Russell
Status: Trivial (tested in userspace framework)

D: Mikael Pettersson points out that "-s" gets mangled to "_s" on the
D: kernel command line, even though it turns out not to be a
D: parameter.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.59/kernel/params.c working-2.5.59-underscore/kernel/params.c
--- linux-2.5.59/kernel/params.c	2003-01-02 14:48:01.000000000 +1100
+++ working-2.5.59-underscore/kernel/params.c	2003-01-21 18:16:05.000000000 +1100
@@ -27,6 +27,22 @@
 #define DEBUGP(fmt, a...)
 #endif
 
+static inline int dash2underscore(char c)
+{
+	if (c == '-')
+		return '_';
+	return c;
+}
+
+static inline int parameq(const char *input, const char *paramname)
+{
+	unsigned int i;
+	for (i = 0; dash2underscore(input[i]) == paramname[i]; i++)
+		if (input[i] == '\0')
+			return 1;
+	return 0;
+}
+
 static int parse_one(char *param,
 		     char *val,
 		     struct kernel_param *params, 
@@ -37,7 +53,7 @@ static int parse_one(char *param,
 
 	/* Find parameter */
 	for (i = 0; i < num_params; i++) {
-		if (strcmp(param, params[i].name) == 0) {
+		if (parameq(param, params[i].name)) {
 			DEBUGP("They are equal!  Calling %p\n",
 			       params[i].set);
 			return params[i].set(val, &params[i]);
@@ -69,8 +85,6 @@ static char *next_arg(char *args, char *
 		if (equals == 0) {
 			if (args[i] == '=')
 				equals = i;
-			else if (args[i] == '-')
-				args[i] = '_';
 		}
 		if (args[i] == '"')
 			in_quote = !in_quote;
