Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTA1JHK>; Tue, 28 Jan 2003 04:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbTA1JHI>; Tue, 28 Jan 2003 04:07:08 -0500
Received: from dp.samba.org ([66.70.73.150]:35563 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261645AbTA1JHF>;
	Tue, 28 Jan 2003 04:07:05 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: kernel param and KBUILD_MODNAME name-munging mess 
In-reply-to: Your message of "Wed, 22 Jan 2003 11:20:01 BST."
             <15918.28753.632988.981832@harpo.it.uu.se> 
Date: Tue, 28 Jan 2003 20:15:09 +1100
Message-Id: <20030128091625.553DF2C2B6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <15918.28753.632988.981832@harpo.it.uu.se> you write:
> That's a workaround for this particular case, but the name-munging
> is still wrong and broken.

Absolutely agreed.  Patch re-xmitted below.

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
