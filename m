Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269233AbUJWEjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269233AbUJWEjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 00:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbUJWEdH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 00:33:07 -0400
Received: from [211.58.254.17] ([211.58.254.17]:29073 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S269233AbUJWEar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:30:47 -0400
Date: Sat, 23 Oct 2004 13:30:40 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (11/16)
Message-ID: <20041023043040.GL3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_11_module_param_arr.diff

 This is the 11st patch of 16 patches for devparam.

 The unsigned int * @nump of module_param_array is changed back to
unsigned int @num, and new sets of macros named module_param_arr*()
are added.  These new macros don't take the num argument.  This change
is made for two reasons

 1. To be consistent with devparam macros.  In devparam, we'll be
    using field name of struct elements, so we won't be able to use
    pointer argument.
 2. It's more consistent with other moduleparam macros.

 This patch only modifies moduleparam.h and doesn't modify the users
of the modified macros.  The next patch takes care of that.  This and
the next patch (dp_12_module_param_arr_apply.diff) are optional.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:30.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:30.000000000 +0900
@@ -157,22 +157,39 @@ extern int param_set_invbool(const char 
 extern int param_get_invbool(char *buffer, struct kernel_param *kp);
 #define param_check_invbool(name, p) __param_check(name, p, int)
 
-/* Comma-separated array: *nump is set to number they actually specified. */
-#define module_param_array_named_ranged(name, array, type, nump, min, max, perm)\
+/* Array fundamental function */
+#define __module_param_array(name, array, type, nump, min, max, perm)	\
 	static struct kparam_array __param_arr_##name			\
 	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
 	    sizeof(array[0]), array };					\
 	module_param_call_ranged(name, param_array_set, param_array_get,\
 				 &__param_arr_##name, min, max, perm)
 
-#define module_param_array_ranged(name, type, nump, min, max, perm)	\
-	module_param_array_named_ranged(name, name, type, nump, min, max, perm)
+/* Comma-separated array: num is set to number they actually specified. */
+#define module_param_array_named_ranged(name, array, type, num, min, max, perm)\
+	__module_param_array(name, array, type, &(num), min, max, perm)
 
-#define module_param_array_named(name, array, type, nump, perm)		\
-	module_param_array_named_ranged(name, array, type, nump, 1, 0, perm)
+#define module_param_array_ranged(name, type, num, min, max, perm)	\
+	module_param_array_named_ranged(name, name, type, num, min, max, perm)
 
-#define module_param_array(name, type, nump, perm)			\
-	module_param_array_named(name, name, type, nump, perm)
+#define module_param_array_named(name, array, type, num, perm)		\
+	module_param_array_named_ranged(name, array, type, num, 1, 0, perm)
+
+#define module_param_array(name, type, num, perm)			\
+	module_param_array_named(name, name, type, num, perm)
+
+/* Comma-separated array without len. */
+#define module_param_arr_named_ranged(name, array, type, min, max, perm)\
+	__module_param_array(name, array, type, NULL, min, max, perm)
+
+#define module_param_arr_ranged(name, type, min, max, perm)		\
+	module_param_arr_named_ranged(name, name, type, min, max, perm)
+
+#define module_param_arr_named(name, array, type, perm)			\
+	module_param_arr_named_ranged(name, array, type, 1, 0, perm)
+
+#define module_param_arr(name, type, perm)				\
+	module_param_arr_named(name, name, type, perm)
 
 extern int param_array_set(const char *val, struct kernel_param *kp);
 extern int param_array_get(char *buffer, struct kernel_param *kp);
