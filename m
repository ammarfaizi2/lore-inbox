Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269672AbUJWEpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbUJWEpP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269200AbUJWEce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:32:34 -0400
Received: from [211.58.254.17] ([211.58.254.17]:60048 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S267939AbUJWE1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:27:14 -0400
Date: Sat, 23 Oct 2004 13:27:08 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (6/16)
Message-ID: <20041023042708.GG3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_06_param_array_delims.diff

 This is the 6th patch of 16 patches for devparam.

 This patch reimplements param_array().  New param_array_delims()
accepts a string parameter @delims which specify delimeters.
param_array_delims() also supports backslash escaping of delimeters.
param_array() now just calls param_array() with @delims set to ",".


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:29.000000000 +0900
@@ -179,9 +179,21 @@ extern int param_get_string(char *buffer
 extern int param_set_flag(const char *val, struct kernel_param *kp);
 extern int param_get_flag(char *buffer, struct kernel_param *kp);
 
-int param_array(const char *name, char *val,
-		long min_val, long max_val, unsigned int min, unsigned int max,
-		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp),
-		int *num);
+int param_array_delims(const char *name, char *val,
+		       unsigned long min_val, unsigned long max_val,
+		       unsigned int min_elems, unsigned int max_elems,
+		       void *elem, int elemsize,
+		       param_set_fn set, int *num, const char *delims);
+
+static inline int param_array(const char *name, char *val,
+			      unsigned long min_val, unsigned long max_val,
+			      unsigned int min_elems, unsigned int max_elems,
+			      void *elem, int elemsize,
+			      param_set_fn set, int *num)
+{
+	return param_array_delims(name, val, min_val, max_val,
+				  min_elems, max_elems, elem, elemsize,
+				  set, num, ",");
+}
+
 #endif /* _LINUX_MODULE_PARAMS_H */
Index: linux-devparam-export/kernel/params.c
===================================================================
--- linux-devparam-export.orig/kernel/params.c	2004-10-23 11:09:29.000000000 +0900
+++ linux-devparam-export/kernel/params.c	2004-10-23 11:09:29.000000000 +0900
@@ -264,16 +264,16 @@ int param_get_invbool(char *buffer, stru
 	return param_get_bool(buffer, &dummy);
 }
 
-/* We cheat here and temporarily mangle the string. */
-int param_array(const char *name, char *val,
-		long min_val, long max_val, unsigned int min, unsigned int max,
-		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp),
-		int *num)
+/* We cheat here and mangle the string. */
+int param_array_delims(const char *name, char *val,
+		       unsigned long min_val, unsigned long max_val,
+		       unsigned int min_elems, unsigned int max_elems,
+		       void *elem, int elemsize,
+		       param_set_fn set, int *num, const char *delims)
 {
 	int ret;
 	struct kernel_param kp;
-	char save;
+	char save, *sp, *dp;
 
 	/* Get the name right for errors. */
 	kp.name = name;
@@ -287,33 +287,53 @@ int param_array(const char *name, char *
 		return -EINVAL;
 	}
 
+	sp = val;
+	dp = val;
 	*num = 0;
-	/* We expect a comma-separated list of values. */
-	do {
-		int len;
+	save = *val;
+	/* We expect a list of values which are separated by any of
+	   delimiters in @delims.  Escaping using backslash is supported. */
+	while (save != '\0') {
+		val = dp;
 
-		if (*num == max) {
+		if (*num == max_elems) {
 			printk(KERN_ERR "%s: can only take %i arguments\n",
-			       name, max);
+			       name, max_elems);
 			return -EINVAL;
 		}
-		len = strcspn(val, ",");
 
-		/* nul-terminate and parse */
-		save = val[len];
-		val[len] = '\0';
-		ret = set(val, &kp);
+	next:
+		if (*sp == '\0' || strchr(delims, *sp))
+			goto end_token;
+		else if (*sp == '\\') {
+			sp++;
+			goto escape;
+		} else {
+			*dp++ = *sp++;
+			goto next;
+		}
 
-		if (ret != 0)
+	escape:
+		if (*sp != '\0') {
+			*dp++ = *sp++;
+			goto next;
+		} else
+			goto end_token;
+
+	end_token:
+		save = *sp;
+		*dp = '\0';
+		if ((ret = set(val, &kp)) != 0)
 			return ret;
 		kp.arg += elemsize;
-		val += len+1;
+		sp++;
+		*dp++ = save;
 		(*num)++;
-	} while (save == ',');
+	}
 
-	if (*num < min) {
+	if (*num < min_elems) {
 		printk(KERN_ERR "%s: needs at least %i arguments\n",
-		       name, min);
+		       name, min_elems);
 		return -EINVAL;
 	}
 	return 0;
