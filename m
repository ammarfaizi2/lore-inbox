Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267303AbUJWFpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbUJWFpH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267195AbUJWFnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:43:10 -0400
Received: from [211.58.254.17] ([211.58.254.17]:18065 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269311AbUJWEaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:30:05 -0400
Date: Sat, 23 Oct 2004 13:30:01 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (10/16)
Message-ID: <20041023043001.GK3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_10_module_param_unknown_arg.diff

 This is the 10th patch of 16 patches for devparam.

 The @unknown function of parse_args() is changed to take a void *arg.
This is used by devparam.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:30.000000000 +0900
@@ -108,7 +108,8 @@ extern int parse_args(const char *name,
 		      char *args,
 		      struct kernel_param *params,
 		      unsigned num,
-		      int (*unknown)(char *param, char *val));
+		      int (*unknown)(char *param, char *val, void *arg),
+		      void *uarg);
 
 /* All the helper functions */
 /* The macros to do compile-time type checking stolen from Jakub
Index: linux-devparam-export/init/main.c
===================================================================
--- linux-devparam-export.orig/init/main.c	2004-10-23 02:00:42.000000000 +0900
+++ linux-devparam-export/init/main.c	2004-10-23 11:09:30.000000000 +0900
@@ -283,7 +283,7 @@ __setup("quiet", quiet_kernel);
  * Unknown boot options get handed to init, unless they look like
  * failed parameters
  */
-static int __init unknown_bootoption(char *param, char *val)
+static int __init unknown_bootoption(char *param, char *val, void *arg)
 {
 	/* Change NUL term back to "=", to make "param" the whole string. */
 	if (val) {
@@ -441,7 +441,7 @@ static void noinline rest_init(void)
 } 
 
 /* Check for early params. */
-static int __init do_early_param(char *param, char *val)
+static int __init do_early_param(char *param, char *val, void *arg)
 {
 	struct obs_kernel_param *p;
 	extern struct obs_kernel_param __setup_start, __setup_end;
@@ -468,7 +468,7 @@ void __init parse_early_param(void)
 
 	/* All fall through to do_early_param. */
 	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
-	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param);
+	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param, NULL);
 	done = 1;
 }
 
@@ -508,7 +508,7 @@ asmlinkage void __init start_kernel(void
 	parse_early_param();
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
-		   &unknown_bootoption);
+		   &unknown_bootoption, NULL);
 	sort_main_extable();
 	trap_init();
 	rcu_init();
Index: linux-devparam-export/kernel/module.c
===================================================================
--- linux-devparam-export.orig/kernel/module.c	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/kernel/module.c	2004-10-23 11:09:30.000000000 +0900
@@ -827,7 +827,7 @@ static int obsolete_params(const char *n
 		kp[i].arg = &obsparm[i];
 	}
 
-	ret = parse_args(name, args, kp, num, NULL);
+	ret = parse_args(name, args, kp, num, NULL, NULL);
  out:
 	kfree(kp);
 	return ret;
@@ -1780,7 +1780,7 @@ static struct module *load_module(void _
 				 sechdrs[setupindex].sh_addr,
 				 sechdrs[setupindex].sh_size
 				 / sizeof(struct kernel_param),
-				 NULL);
+				 NULL, NULL);
 	}
 	err = mod_sysfs_setup(mod, 
 			      (struct kernel_param *)
Index: linux-devparam-export/kernel/params.c
===================================================================
--- linux-devparam-export.orig/kernel/params.c	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/kernel/params.c	2004-10-23 11:09:30.000000000 +0900
@@ -47,7 +47,8 @@ static int parse_one(char *param,
 		     char *val,
 		     struct kernel_param *params, 
 		     unsigned num_params,
-		     int (*handle_unknown)(char *param, char *val))
+		     int (*handle_unknown)(char *param, char *val, void *arg),
+		     void *uarg)
 {
 	unsigned int i;
 
@@ -62,7 +63,7 @@ static int parse_one(char *param,
 
 	if (handle_unknown) {
 		DEBUGP("Unknown argument: calling %p\n", handle_unknown);
-		return handle_unknown(param, val);
+		return handle_unknown(param, val, uarg);
 	}
 
 	DEBUGP("Unknown argument `%s'\n", param);
@@ -117,7 +118,7 @@ int parse_args(const char *name,
 	       char *args,
 	       struct kernel_param *params,
 	       unsigned num,
-	       int (*unknown)(char *param, char *val))
+	       int (*unknown)(char *param, char *val, void *arg), void *uarg)
 {
 	char *param, *val;
 
@@ -127,7 +128,7 @@ int parse_args(const char *name,
 		int ret;
 
 		args = param_next_arg(args, &param, &val);
-		ret = parse_one(param, val, params, num, unknown);
+		ret = parse_one(param, val, params, num, unknown, uarg);
 		switch (ret) {
 		case -ENOENT:
 			printk(KERN_ERR "%s: Unknown parameter `%s'\n",
