Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUJWEaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUJWEaJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268435AbUJWE1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:27:45 -0400
Received: from [211.58.254.17] ([211.58.254.17]:56720 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S267624AbUJWE0k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:26:40 -0400
Date: Sat, 23 Oct 2004 13:26:32 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (5/16)
Message-ID: <20041023042632.GF3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_05_module_param_ranged.diff

 This is the 5th patch of 16 patches for devparam.

 This patch removes the const qualifier from @val of param_array().
param_array() does modify @val and I think it's clearer this way.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:28.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
@@ -179,7 +179,7 @@ extern int param_get_string(char *buffer
 extern int param_set_flag(const char *val, struct kernel_param *kp);
 extern int param_get_flag(char *buffer, struct kernel_param *kp);
 
-int param_array(const char *name, const char *val,
+int param_array(const char *name, char *val,
 		long min_val, long max_val, unsigned int min, unsigned int max,
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
Index: linux-devparam-export/kernel/module.c
===================================================================
--- linux-devparam-export.orig/kernel/module.c	2004-10-23 11:09:28.000000000 +0900
+++ linux-devparam-export/kernel/module.c	2004-10-23 11:09:29.000000000 +0900
@@ -729,6 +729,7 @@ int set_obsolete(const char *val, struct
 	int dummy;
 	char *endp;
 	const char *p;
+	char *v = (char *)val;
 	struct obsolete_modparm *obsparm = kp->arg;
 
 	if (!val) {
@@ -748,19 +749,19 @@ int set_obsolete(const char *val, struct
 		max = min;
 	switch (*endp) {
 	case 'b':
-		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
+		return param_array(kp->name, v, 1, 0, min, max, obsparm->addr,
 				   1, param_set_byte, &dummy);
 	case 'h':
-		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
+		return param_array(kp->name, v, 1, 0, min, max, obsparm->addr,
 				   sizeof(short), param_set_short, &dummy);
 	case 'i':
-		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
+		return param_array(kp->name, v, 1, 0, min, max, obsparm->addr,
 				   sizeof(int), param_set_int, &dummy);
 	case 'l':
-		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
+		return param_array(kp->name, v, 1, 0, min, max, obsparm->addr,
 				   sizeof(long), param_set_long, &dummy);
 	case 's':
-		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
+		return param_array(kp->name, v, 1, 0, min, max, obsparm->addr,
 				   sizeof(char *), param_set_charp, &dummy);
 
 	case 'c':
@@ -777,7 +778,7 @@ int set_obsolete(const char *val, struct
 		}
 		if (size >= maxsize) 
 			goto oversize;
-		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
+		return param_array(kp->name, v, 1, 0, min, max, obsparm->addr,
 				   maxsize, obsparm_copy_string, &dummy);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
Index: linux-devparam-export/kernel/params.c
===================================================================
--- linux-devparam-export.orig/kernel/params.c	2004-10-23 11:09:28.000000000 +0900
+++ linux-devparam-export/kernel/params.c	2004-10-23 11:09:29.000000000 +0900
@@ -265,7 +265,7 @@ int param_get_invbool(char *buffer, stru
 }
 
 /* We cheat here and temporarily mangle the string. */
-int param_array(const char *name, const char *val,
+int param_array(const char *name, char *val,
 		long min_val, long max_val, unsigned int min, unsigned int max,
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
@@ -301,7 +301,7 @@ int param_array(const char *name, const 
 
 		/* nul-terminate and parse */
 		save = val[len];
-		((char *)val)[len] = '\0';
+		val[len] = '\0';
 		ret = set(val, &kp);
 
 		if (ret != 0)
@@ -324,7 +324,7 @@ int param_array_set(const char *val, str
 	struct kparam_array *arr = kp->arg;
 	unsigned int t;
 
-	return param_array(kp->name, val, kp->min, kp->max,
+	return param_array(kp->name, (char *)val, kp->min, kp->max,
 			   1, arr->max, arr->elem, arr->elemsize,
 			   arr->set, arr->num ?: &t);
 }
