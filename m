Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbUKDGkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbUKDGkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 01:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbUKDGkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 01:40:24 -0500
Received: from [211.58.254.17] ([211.58.254.17]:43165 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262093AbUKDGjp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:39:45 -0500
Date: Thu, 4 Nov 2004 15:39:42 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 2/15] driver-model: flag type helpers added to moduleparam
Message-ID: <20041104063942.GB24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_02_module_param_flag.patch

 This is the 2nd patch of 15 patches for devparam.

 This patch implements module_param_flag() and module_param_invflag().
They appear as boolean parameter to the outside, and bitwise OR the
specified flag to flags when the specified boolean value is 1 and 0
respectively.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 10:25:53.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 11:04:07.000000000 +0900
@@ -45,6 +45,12 @@ struct kparam_array
 	void *elem;
 };
 
+/* Special one for flags */
+struct kparam_flag
+{
+	unsigned int *pflags, flag, inv;
+};
+
 /* This is the fundamental function for registering boot/module
    parameters.  perm sets the visibility in driverfs: 000 means it's
    not there, read bits mean it's readable, write bits mean it's
@@ -76,6 +82,20 @@ struct kparam_array
 	module_param_call(name, param_set_copystring, param_get_string,	\
 		   &__param_string_##name, perm)
 
+/* Bit flag */
+#define __module_param_flag(name, flags, flag, inv, perm)		\
+	param_check_uint(name, &(flags));				\
+	static struct kparam_flag __param_flag_##name			\
+	= { &(flags), flag, inv };					\
+	module_param_call(name, param_set_flag, param_get_flag,		\
+			  &__param_flag_##name, perm)
+
+#define module_param_flag(name, flags, flag, perm)			\
+	__module_param_flag(name, flags, flag, 0, perm)
+
+#define module_param_invflag(name, flags, flag, perm)			\
+	__module_param_flag(name, flags, flag, 1, perm)
+
 /* Called on module insert or kernel boot */
 extern int parse_args(const char *name,
 		      char *args,
@@ -146,6 +166,9 @@ extern int param_array_get(char *buffer,
 extern int param_set_copystring(const char *val, struct kernel_param *kp);
 extern int param_get_string(char *buffer, struct kernel_param *kp);
 
+extern int param_set_flag(const char *val, struct kernel_param *kp);
+extern int param_get_flag(char *buffer, struct kernel_param *kp);
+
 int param_array(const char *name,
 		const char *val,
 		unsigned int min, unsigned int max,
Index: linux-export/kernel/params.c
===================================================================
--- linux-export.orig/kernel/params.c	2004-11-04 11:04:07.000000000 +0900
+++ linux-export/kernel/params.c	2004-11-04 11:04:07.000000000 +0900
@@ -350,6 +350,32 @@ int param_get_string(char *buffer, struc
 	return strlcpy(buffer, kps->string, kps->maxlen);
 }
 
+int param_set_flag(const char *val, struct kernel_param *kp)
+{
+	struct kparam_flag *kflag = kp->arg;
+	int boolval, ret;
+	struct kernel_param dummy = { .arg = &boolval };
+
+	ret = param_set_bool(val, &dummy);
+	if (ret == 0) {
+		if (boolval ^ kflag->inv)
+			*kflag->pflags |= kflag->flag;
+		else
+			*kflag->pflags &= ~kflag->flag;
+	}
+	return ret;
+}
+
+int param_get_flag(char *buffer, struct kernel_param *kp)
+{
+	struct kparam_flag *kflag = kp->arg;
+	int val;
+	struct kernel_param dummy = { .arg = &val };
+
+	val = (!!(*kflag->pflags & kflag->flag)) ^ kflag->inv;
+	return param_get_bool(buffer, &dummy);
+}
+
 /* sysfs output in /sys/modules/XYZ/parameters/ */
 
 extern struct kernel_param __start___param[], __stop___param[];
@@ -762,3 +788,5 @@ EXPORT_SYMBOL(param_array_set);
 EXPORT_SYMBOL(param_array_get);
 EXPORT_SYMBOL(param_set_copystring);
 EXPORT_SYMBOL(param_get_string);
+EXPORT_SYMBOL(param_set_flag);
+EXPORT_SYMBOL(param_get_flag);
