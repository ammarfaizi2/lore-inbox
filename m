Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbUKDGsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbUKDGsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbUKDGqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:46:18 -0500
Received: from [211.58.254.17] ([211.58.254.17]:9886 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262105AbUKDGoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:44:44 -0500
Date: Thu, 4 Nov 2004 15:44:41 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 4/15] driver-model: const qualifier removed from @val of param_array()
Message-ID: <20041104064440.GD24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_04_param_array_val_noconst.patch

 This is the 4th patch of 15 patches for devparam.

 This patch removes the const qualifier from @val of param_array().
param_array() does modify @val and I think it's clearer this way.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 14:48:38.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 14:48:38.000000000 +0900
@@ -185,7 +185,7 @@ extern int param_get_string(char *buffer
 extern int param_set_flag(const char *val, struct kernel_param *kp);
 extern int param_get_flag(char *buffer, struct kernel_param *kp);
 
-int param_array(const char *name, const char *val,
+int param_array(const char *name, char *val,
 		long min_val, long max_val, unsigned int min, unsigned int max,
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
Index: linux-export/kernel/module.c
===================================================================
--- linux-export.orig/kernel/module.c	2004-11-04 14:48:38.000000000 +0900
+++ linux-export/kernel/module.c	2004-11-04 14:48:38.000000000 +0900
@@ -703,6 +703,7 @@ int set_obsolete(const char *val, struct
 	int dummy;
 	char *endp;
 	const char *p;
+	char *v = (char *)val;
 	struct obsolete_modparm *obsparm = kp->arg;
 
 	if (!val) {
@@ -722,23 +723,23 @@ int set_obsolete(const char *val, struct
 		max = min;
 	switch (*endp) {
 	case 'b':
-		return param_array(kp->name, val, KPARAM_NO_RANGE, min, max,
+		return param_array(kp->name, v, KPARAM_NO_RANGE, min, max,
 				   obsparm->addr, 1,
 				   param_set_byte, &dummy);
 	case 'h':
-		return param_array(kp->name, val, KPARAM_NO_RANGE, min, max,
+		return param_array(kp->name, v, KPARAM_NO_RANGE, min, max,
 				   obsparm->addr, sizeof(short),
 				   param_set_short, &dummy);
 	case 'i':
-		return param_array(kp->name, val, KPARAM_NO_RANGE, min, max,
+		return param_array(kp->name, v, KPARAM_NO_RANGE, min, max,
 				   obsparm->addr, sizeof(int),
 				   param_set_int, &dummy);
 	case 'l':
-		return param_array(kp->name, val, KPARAM_NO_RANGE, min, max,
+		return param_array(kp->name, v, KPARAM_NO_RANGE, min, max,
 				   obsparm->addr, sizeof(long),
 				   param_set_long, &dummy);
 	case 's':
-		return param_array(kp->name, val, KPARAM_NO_RANGE, min, max,
+		return param_array(kp->name, v, KPARAM_NO_RANGE, min, max,
 				   obsparm->addr, sizeof(char *),
 				   param_set_charp, &dummy);
 
@@ -756,7 +757,7 @@ int set_obsolete(const char *val, struct
 		}
 		if (size >= maxsize) 
 			goto oversize;
-		return param_array(kp->name, val, KPARAM_NO_RANGE, min, max,
+		return param_array(kp->name, v, KPARAM_NO_RANGE, min, max,
 				   obsparm->addr, maxsize,
 				   obsparm_copy_string, &dummy);
 	}
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-04 14:48:38.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-04 14:48:38.000000000 +0900
@@ -268,7 +268,7 @@ int param_get_invbool(char *buffer, stru
 }
 
 /* We cheat here and temporarily mangle the string. */
-int param_array(const char *name, const char *val,
+int param_array(const char *name, char *val,
 		long min_val, long max_val, unsigned int min, unsigned int max,
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
@@ -304,7 +304,7 @@ int param_array(const char *name, const 
 
 		/* nul-terminate and parse */
 		save = val[len];
-		((char *)val)[len] = '\0';
+		val[len] = '\0';
 		ret = set(val, &kp);
 
 		if (ret != 0)
@@ -327,7 +327,7 @@ int param_array_set(const char *val, str
 	struct kparam_array *arr = kp->arg;
 	unsigned int t;
 
-	return param_array(kp->name, val, kp->min, kp->max,
+	return param_array(kp->name, (char *)val, kp->min, kp->max,
 			   1, arr->max, arr->elem, arr->elemsize,
 			   arr->set, arr->num ?: &t);
 }
