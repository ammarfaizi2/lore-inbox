Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262100AbUKDGvx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUKDGvx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbUKDGti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:49:38 -0500
Received: from [211.58.254.17] ([211.58.254.17]:16542 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262100AbUKDGpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:45:46 -0500
Date: Thu, 4 Nov 2004 15:45:43 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 5/15] driver-model: param_array_delims() implemented
Message-ID: <20041104064543.GE24890@home-tj.org>
Reply-To: tj@home-tj.org
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_05_param_array_delims.patch

 This is the 5th patch of 15 patches for devparam.

 This patch reimplements param_array().  New param_array_delims()
accepts a string parameter @delims which specify delimeters.
param_array_delims() also supports backslash escaping of delimeters.
param_array() now just calls param_array() with @delims set to ",".


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 14:25:58.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 14:25:58.000000000 +0900
@@ -185,11 +185,23 @@ extern int param_get_string(char *buffer
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
 
 /* for exporting parameters in /sys/parameters */
 
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-04 14:25:58.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-04 14:25:58.000000000 +0900
@@ -267,16 +267,16 @@ int param_get_invbool(char *buffer, stru
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
@@ -290,33 +290,53 @@ int param_array(const char *name, char *
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
