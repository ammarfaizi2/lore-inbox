Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267618AbUJWF6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267618AbUJWF6M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267612AbUJWF4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:56:51 -0400
Received: from [211.58.254.17] ([211.58.254.17]:45968 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S267595AbUJWEZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:25:07 -0400
Date: Sat, 23 Oct 2004 13:25:02 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (3/16)
Message-ID: <20041023042502.GD3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_03_module_param_flag.diff

 This is the 3rd patch of 16 patches for devparam.

 This patch implements module_param_flag() and module_param_invflag().
They appear as boolean parameter to the outside, and bitwise OR the
specified flag to flags when the specified boolean value is 1 and 0
respectively.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-22 17:13:33.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:28.000000000 +0900
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
Index: linux-devparam-export/kernel/params.c
===================================================================
--- linux-devparam-export.orig/kernel/params.c	2004-10-23 11:09:28.000000000 +0900
+++ linux-devparam-export/kernel/params.c	2004-10-23 11:09:28.000000000 +0900
@@ -347,6 +347,32 @@ int param_get_string(char *buffer, struc
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
 EXPORT_SYMBOL(param_set_byte);
 EXPORT_SYMBOL(param_get_byte);
 EXPORT_SYMBOL(param_set_short);
@@ -371,3 +397,5 @@ EXPORT_SYMBOL(param_array_set);
 EXPORT_SYMBOL(param_array_get);
 EXPORT_SYMBOL(param_set_copystring);
 EXPORT_SYMBOL(param_get_string);
+EXPORT_SYMBOL(param_set_flag);
+EXPORT_SYMBOL(param_get_flag);
