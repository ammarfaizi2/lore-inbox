Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262111AbUKDGzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262111AbUKDGzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbUKDGxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:53:32 -0500
Received: from [211.58.254.17] ([211.58.254.17]:41374 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262110AbUKDGuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:50:19 -0500
Date: Thu, 4 Nov 2004 15:50:16 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 9/15] driver-model: parse_args()'s @unknown function modified to take void *arg
Message-ID: <20041104065016.GI24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_09_module_param_unknown_arg.patch

 This is the 9th patch of 15 patches for devparam.

 The @unknown function of parse_args() is changed to take a void *arg.
This is used by devparam.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 14:25:59.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 14:25:59.000000000 +0900
@@ -114,7 +114,8 @@ extern int parse_args(const char *name,
 		      char *args,
 		      struct kernel_param *params,
 		      unsigned num,
-		      int (*unknown)(char *param, char *val));
+		      int (*unknown)(char *param, char *val, void *arg),
+		      void *uarg);
 
 /* All the helper functions */
 /* The macros to do compile-time type checking stolen from Jakub
Index: linux-export/init/main.c
===================================================================
--- linux-export.orig/init/main.c	2004-11-04 10:25:56.000000000 +0900
+++ linux-export/init/main.c	2004-11-04 14:25:59.000000000 +0900
@@ -284,7 +284,7 @@ __setup("quiet", quiet_kernel);
  * Unknown boot options get handed to init, unless they look like
  * failed parameters
  */
-static int __init unknown_bootoption(char *param, char *val)
+static int __init unknown_bootoption(char *param, char *val, void *arg)
 {
 	/* Change NUL term back to "=", to make "param" the whole string. */
 	if (val) {
@@ -450,7 +450,7 @@ static void noinline rest_init(void)
 } 
 
 /* Check for early params. */
-static int __init do_early_param(char *param, char *val)
+static int __init do_early_param(char *param, char *val, void *arg)
 {
 	struct obs_kernel_param *p;
 	extern struct obs_kernel_param __setup_start, __setup_end;
@@ -477,7 +477,7 @@ void __init parse_early_param(void)
 
 	/* All fall through to do_early_param. */
 	strlcpy(tmp_cmdline, saved_command_line, COMMAND_LINE_SIZE);
-	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param);
+	parse_args("early options", tmp_cmdline, NULL, 0, do_early_param, NULL);
 	done = 1;
 }
 
@@ -517,7 +517,7 @@ asmlinkage void __init start_kernel(void
 	parse_early_param();
 	parse_args("Booting kernel", command_line, __start___param,
 		   __stop___param - __start___param,
-		   &unknown_bootoption);
+		   &unknown_bootoption, NULL);
 	sort_main_extable();
 	trap_init();
 	rcu_init();
Index: linux-export/kernel/module.c
===================================================================
--- linux-export.orig/kernel/module.c	2004-11-04 14:25:58.000000000 +0900
+++ linux-export/kernel/module.c	2004-11-04 14:25:59.000000000 +0900
@@ -807,7 +807,7 @@ static int obsolete_params(const char *n
 		kp[i].arg = &obsparm[i];
 	}
 
-	ret = parse_args(name, args, kp, num, NULL);
+	ret = parse_args(name, args, kp, num, NULL, NULL);
  out:
 	kfree(kp);
 	return ret;
@@ -1716,7 +1716,7 @@ static struct module *load_module(void _
 				 sechdrs[setupindex].sh_addr,
 				 sechdrs[setupindex].sh_size
 				 / sizeof(struct kernel_param),
-				 NULL);
+				 NULL, NULL);
 	}
 	err = mod_sysfs_setup(mod, 
 			      (struct kernel_param *)
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-04 14:25:59.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-04 14:25:59.000000000 +0900
@@ -50,7 +50,8 @@ static int parse_one(char *param,
 		     char *val,
 		     struct kernel_param *params, 
 		     unsigned num_params,
-		     int (*handle_unknown)(char *param, char *val))
+		     int (*handle_unknown)(char *param, char *val, void *arg),
+		     void *uarg)
 {
 	unsigned int i;
 
@@ -65,7 +66,7 @@ static int parse_one(char *param,
 
 	if (handle_unknown) {
 		DEBUGP("Unknown argument: calling %p\n", handle_unknown);
-		return handle_unknown(param, val);
+		return handle_unknown(param, val, uarg);
 	}
 
 	DEBUGP("Unknown argument `%s'\n", param);
@@ -120,7 +121,7 @@ int parse_args(const char *name,
 	       char *args,
 	       struct kernel_param *params,
 	       unsigned num,
-	       int (*unknown)(char *param, char *val))
+	       int (*unknown)(char *param, char *val, void *arg), void *uarg)
 {
 	char *param, *val;
 
@@ -130,7 +131,7 @@ int parse_args(const char *name,
 		int ret;
 
 		args = param_next_arg(args, &param, &val);
-		ret = parse_one(param, val, params, num, unknown);
+		ret = parse_one(param, val, params, num, unknown, uarg);
 		switch (ret) {
 		case -ENOENT:
 			printk(KERN_ERR "%s: Unknown parameter `%s'\n",
