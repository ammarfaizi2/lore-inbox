Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTFPALQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 20:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFPALQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 20:11:16 -0400
Received: from dp.samba.org ([66.70.73.150]:28093 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263103AbTFPALB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 20:11:01 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, rth@twiddle.net, ak@muc.de,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] Fix undefined/miscompiled construct in kernel parameters 
In-reply-to: Your message of "Sun, 15 Jun 2003 09:52:47 MST."
             <Pine.LNX.4.44.0306150951060.8088-100000@home.transmeta.com> 
Date: Mon, 16 Jun 2003 10:23:41 +1000
Message-Id: <20030616002453.8A9B72C078@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0306150951060.8088-100000@home.transmeta.com> you wri
te:
> 
> On Sun, 15 Jun 2003, Andi Kleen wrote:
> > 
> > The parse_args call in init/main.c does pointer arithmetic between two 
> > different external symbols. This is undefined in C (only pointer arthmetic
> > in the same symbol is defined) and gets miscompiled on AMD64 with gcc 3.2,
> 
> That's silly. You're making the code less readable, with some silly 
> parameters. Why does it get miscompiled on amd64, and let's just fix that 
> one.

AFAICT, Roman's fix is correct; Richard admonished me in the past for
such code, IIRC, but this one slipped through.

Since Andi reports that even that doesn't work for x86-64, I'd say
apply this patch based on his: it's an arbitrary change anyway.

The compiler should be fixed, too, but if this is the only compiler
bug which effects the kernel, we should consider ourselves lucky.

(Andi: your module.c patch was a little convoluted).
Cheers,
Rusty.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.71-bk1/include/linux/moduleparam.h working-2.5.71-bk1-param/include/linux/moduleparam.h
--- linux-2.5.71-bk1/include/linux/moduleparam.h	2003-02-07 19:20:01.000000000 +1100
+++ working-2.5.71-bk1-param/include/linux/moduleparam.h	2003-06-16 10:18:25.000000000 +1000
@@ -67,7 +67,7 @@ struct kparam_string {
 extern int parse_args(const char *name,
 		      char *args,
 		      struct kernel_param *params,
-		      unsigned num,
+		      struct kernel_param *end,
 		      int (*unknown)(char *param, char *val));
 
 /* All the helper functions */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.71-bk1/init/main.c working-2.5.71-bk1-param/init/main.c
--- linux-2.5.71-bk1/init/main.c	2003-06-15 11:30:10.000000000 +1000
+++ working-2.5.71-bk1-param/init/main.c	2003-06-16 10:18:25.000000000 +1000
@@ -404,7 +404,7 @@ asmlinkage void __init start_kernel(void
 	page_alloc_init();
 	printk("Kernel command line: %s\n", saved_command_line);
 	parse_args("Booting kernel", command_line, &__start___param,
-		   &__stop___param - &__start___param,
+		   &__stop___param,
 		   &unknown_bootoption);
 	trap_init();
 	rcu_init();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.71-bk1/kernel/module.c working-2.5.71-bk1-param/kernel/module.c
--- linux-2.5.71-bk1/kernel/module.c	2003-06-15 11:30:11.000000000 +1000
+++ working-2.5.71-bk1-param/kernel/module.c	2003-06-16 10:19:53.000000000 +1000
@@ -929,7 +929,7 @@ static int obsolete_params(const char *n
 		kp[i].arg = &obsparm[i];
 	}
 
-	ret = parse_args(name, args, kp, num, NULL);
+	ret = parse_args(name, args, kp, kp + num, NULL);
  out:
 	kfree(kp);
 	return ret;
@@ -1623,10 +1623,9 @@ static struct module *load_module(void _
 	} else {
 		/* Size of section 0 is 0, so this works well if no params */
 		err = parse_args(mod->name, mod->args,
-				 (struct kernel_param *)
-				 sechdrs[setupindex].sh_addr,
-				 sechdrs[setupindex].sh_size
-				 / sizeof(struct kernel_param),
+				 (void *)sechdrs[setupindex].sh_addr,
+				 (void *)sechdrs[setupindex].sh_addr
+				 + sechdrs[setupindex].sh_size,
 				 NULL);
 	}
 	if (err < 0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.71-bk1/kernel/params.c working-2.5.71-bk1-param/kernel/params.c
--- linux-2.5.71-bk1/kernel/params.c	2003-02-11 14:26:20.000000000 +1100
+++ working-2.5.71-bk1-param/kernel/params.c	2003-06-16 10:18:25.000000000 +1000
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


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
