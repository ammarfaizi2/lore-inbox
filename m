Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbTFOMpY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 08:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbTFOMpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 08:45:24 -0400
Received: from zero.aec.at ([193.170.194.10]:53776 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262179AbTFOMpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 08:45:20 -0400
Date: Sun, 15 Jun 2003 14:58:54 +0200
From: Andi Kleen <ak@muc.de>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: [PATCH] Fix undefined/miscompiled construct in kernel parameters
Message-ID: <20030615125854.GA29458@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The parse_args call in init/main.c does pointer arithmetic between two 
different external symbols. This is undefined in C (only pointer arthmetic
in the same symbol is defined) and gets miscompiled on AMD64 with gcc 3.2,
resulting in a triple fault at boot when an driver with new style
parameters is compiled in. In my case it was triggered by oprofile.

This patch works around this by passing the end pointer directly
to the low level function and comparing it there. Strictly this
is still undefined, but should be ok because gcc has to handle these
pointers in another function correctly.

It is also possible to use an empty asm() with dummy input/out to work 
around this, but I didn't do that for now.

The construct may appear in other cases too, but I didn't see any
miscompilation so far.

Please apply,

-Andi

diff -burpN -X ../KDIFX linux/include/linux/moduleparam.h linux-2.5.71-amd64/include/linux/moduleparam.h
--- linux/include/linux/moduleparam.h	2003-05-27 03:00:39.000000000 +0200
+++ linux-2.5.71-amd64/include/linux/moduleparam.h	2003-06-15 14:49:45.000000000 +0200
@@ -67,7 +67,7 @@ struct kparam_string {
 extern int parse_args(const char *name,
 		      char *args,
 		      struct kernel_param *params,
-		      unsigned num,
+		      struct kernel_param *end,
 		      int (*unknown)(char *param, char *val));
 
 /* All the helper functions */
diff -burpN -X ../KDIFX linux/init/main.c linux-2.5.71-amd64/init/main.c
--- linux/init/main.c	2003-06-14 23:43:06.000000000 +0200
+++ linux-2.5.71-amd64/init/main.c	2003-06-15 13:16:41.000000000 +0200
@@ -404,7 +404,7 @@ asmlinkage void __init start_kernel(void
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_args("Booting kernel", command_line, &__start___param,
-		   &__stop___param - &__start___param,
+		   &__stop___param,
 		   &unknown_bootoption);
 	trap_init();
 	rcu_init();
diff -burpN -X ../KDIFX linux/kernel/module.c linux-2.5.71-amd64/kernel/module.c
--- linux/kernel/module.c	2003-06-14 23:43:06.000000000 +0200
+++ linux-2.5.71-amd64/kernel/module.c	2003-06-15 13:18:49.000000000 +0200
@@ -929,7 +929,7 @@ static int obsolete_params(const char *n
 		kp[i].arg = &obsparm[i];
 	}
 
-	ret = parse_args(name, args, kp, num, NULL);
+	ret = parse_args(name, args, kp, &kp[num], NULL);
  out:
 	kfree(kp);
 	return ret;
@@ -1622,11 +1622,11 @@ static struct module *load_module(void _
 				      (char *)sechdrs[strindex].sh_addr);
 	} else {
 		/* Size of section 0 is 0, so this works well if no params */
-		err = parse_args(mod->name, mod->args,
-				 (struct kernel_param *)
-				 sechdrs[setupindex].sh_addr,
-				 sechdrs[setupindex].sh_size
-				 / sizeof(struct kernel_param),
+		struct kernel_param *parm = (struct kernel_param *)
+					 sechdrs[setupindex].sh_addr;	
+		err = parse_args(mod->name, mod->args, parm,
+				&parm[sechdrs[setupindex].sh_size
+				 / sizeof(struct kernel_param)],
 				 NULL);
 	}
 	if (err < 0)
diff -burpN -X ../KDIFX linux/kernel/params.c linux-2.5.71-amd64/kernel/params.c
--- linux/kernel/params.c	2003-05-27 03:00:46.000000000 +0200
+++ linux-2.5.71-amd64/kernel/params.c	2003-06-15 13:39:16.000000000 +0200
@@ -46,13 +46,13 @@ static inline int parameq(const char *in
 static int parse_one(char *param,
 		     char *val,
 		     struct kernel_param *params, 
-		     unsigned num_params,
+		     struct kernel_param *end,
 		     int (*handle_unknown)(char *param, char *val))
 {
 	unsigned int i;
 
 	/* Find parameter */
-	for (i = 0; i < num_params; i++) {
+	for (i = 0; &params[i] < end; i++) {
 		if (parameq(param, params[i].name)) {
 			DEBUGP("They are equal!  Calling %p\n",
 			       params[i].set);
@@ -109,7 +109,7 @@ static char *next_arg(char *args, char *
 int parse_args(const char *name,
 	       char *args,
 	       struct kernel_param *params,
-	       unsigned num,
+	       struct kernel_param *end,
 	       int (*unknown)(char *param, char *val))
 {
 	char *param, *val;
@@ -120,7 +120,7 @@ int parse_args(const char *name,
 		int ret;
 
 		args = next_arg(args, &param, &val);
-		ret = parse_one(param, val, params, num, unknown);
+		ret = parse_one(param, val, params, end, unknown);
 		switch (ret) {
 		case -ENOENT:
 			printk(KERN_ERR "%s: Unknown parameter `%s'\n",


