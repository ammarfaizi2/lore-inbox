Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbUKDHi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbUKDHi3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUKDHOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:14:08 -0500
Received: from [211.58.254.17] ([211.58.254.17]:55198 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262113AbUKDGvw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:51:52 -0500
Date: Thu, 4 Nov 2004 15:51:44 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 10/15] driver-model: module_param_array() changed back to accept variable name directly for @num and module_param_arr() added
Message-ID: <20041104065144.GJ24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_10_module_param_arr.patch

 This is the 10th patch of 15 patches for devparam.

 The unsigned int * @nump of module_param_array is changed back to
unsigned int @num, and new sets of macros named module_param_arr*()
are added.  These new macros don't take the num argument.  This change
is made for two reasons

 1. To be consistent with devparam macros.  In devparam, we'll be
    using field name of struct elements, so we won't be able to use
    pointer argument.
 2. It's more consistent with other moduleparam macros.

 This patch only modifies moduleparam.h and doesn't modify the users
of the modified macros.  The next patch takes care of that.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/include/linux/moduleparam.h
===================================================================
--- linux-export.orig/include/linux/moduleparam.h	2004-11-04 14:25:59.000000000 +0900
+++ linux-export/include/linux/moduleparam.h	2004-11-04 14:25:59.000000000 +0900
@@ -163,22 +163,39 @@ extern int param_set_invbool(const char 
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
