Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267367AbUJWGCW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267367AbUJWGCW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 02:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUJWF40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:56:26 -0400
Received: from [211.58.254.17] ([211.58.254.17]:52368 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S267633AbUJWEZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:25:56 -0400
Date: Sat, 23 Oct 2004 13:25:51 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (4/16)
Message-ID: <20041023042550.GE3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_04_module_param_ranged.diff

 This is the 4th patch of 16 patches for devparam.

 This patch implements module_param_flag() and module_param_invflag().
They appear as boolean parameter to the outside, and bitwise OR the
specified flag to flags when the specified boolean value is 1 and 0
respectively.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/include/linux/moduleparam.h
===================================================================
--- linux-devparam-export.orig/include/linux/moduleparam.h	2004-10-23 11:09:28.000000000 +0900
+++ linux-devparam-export/include/linux/moduleparam.h	2004-10-23 11:09:28.000000000 +0900
@@ -26,12 +26,7 @@ struct kernel_param {
 	param_set_fn set;
 	param_get_fn get;
 	void *arg;
-};
-
-/* Special one for strings we want to copy into */
-struct kparam_string {
-	unsigned int maxlen;
-	char *string;
+	long min, max;
 };
 
 /* Special one for arrays */
@@ -55,32 +50,41 @@ struct kparam_flag
    parameters.  perm sets the visibility in driverfs: 000 means it's
    not there, read bits mean it's readable, write bits mean it's
    writable. */
-#define __module_param_call(prefix, name, set, get, arg, perm)		\
+#define __module_param_call(prefix, name, set, get, arg, min, max, perm) \
 	static char __param_str_##name[] = prefix #name;		\
 	static struct kernel_param const __param_##name			\
 	__attribute_used__						\
     __attribute__ ((unused,__section__ ("__param"),aligned(sizeof(void *)))) \
-	= { __param_str_##name, perm, set, get, arg }
+	= { __param_str_##name, perm, set, get, arg, min, max }
+
+#define module_param_call_ranged(name, set, get, arg, min, max, perm)	\
+	__module_param_call(MODULE_PARAM_PREFIX, name, set, get, arg,	\
+			    min, max, perm)
 
-#define module_param_call(name, set, get, arg, perm)			      \
-	__module_param_call(MODULE_PARAM_PREFIX, name, set, get, arg, perm)
+#define module_param_call(name, set, get, arg, perm)			\
+	module_param_call_ranged(name, set, get, arg, 1, 0, perm)
 
 /* Helper functions: type is byte, short, ushort, int, uint, long,
    ulong, charp, bool or invbool, or XXX if you define param_get_XXX,
    param_set_XXX and param_check_XXX. */
-#define module_param_named(name, value, type, perm)			   \
-	param_check_##type(name, &(value));				   \
-	module_param_call(name, param_set_##type, param_get_##type, &value, perm)
+#define module_param_named_ranged(name, value, type, min, max, perm)	\
+	param_check_##type(name, &(value));				\
+	module_param_call_ranged(name, param_set_##type, param_get_##type, \
+				 &value, min, max, perm)
+
+#define module_param_ranged(name, type, min, max, perm)			\
+	module_param_named_ranged(name, name, type, min, max, perm)	\
+
+#define module_param_named(name, value, type, perm)			\
+	module_param_named_ranged(name, value, type, 1, 0, perm)
 
-#define module_param(name, type, perm)				\
+#define module_param(name, type, perm)					\
 	module_param_named(name, name, type, perm)
 
 /* Actually copy string: maxlen param is usually sizeof(string). */
 #define module_param_string(name, string, len, perm)			\
-	static struct kparam_string __param_string_##name		\
-		= { len, string };					\
-	module_param_call(name, param_set_copystring, param_get_string,	\
-		   &__param_string_##name, perm)
+	module_param_call_ranged(name, param_set_copystring,		\
+				 param_get_string, string, 0, len, perm)
 
 /* Bit flag */
 #define __module_param_flag(name, flags, flag, inv, perm)		\
@@ -150,14 +154,20 @@ extern int param_get_invbool(char *buffe
 #define param_check_invbool(name, p) __param_check(name, p, int)
 
 /* Comma-separated array: *nump is set to number they actually specified. */
-#define module_param_array_named(name, array, type, nump, perm)		\
+#define module_param_array_named_ranged(name, array, type, nump, min, max, perm)\
 	static struct kparam_array __param_arr_##name			\
 	= { ARRAY_SIZE(array), nump, param_set_##type, param_get_##type,\
 	    sizeof(array[0]), array };					\
-	module_param_call(name, param_array_set, param_array_get, 	\
-			  &__param_arr_##name, perm)
+	module_param_call_ranged(name, param_array_set, param_array_get,\
+				 &__param_arr_##name, min, max, perm)
+
+#define module_param_array_ranged(name, type, nump, min, max, perm)	\
+	module_param_array_named_ranged(name, name, type, nump, min, max, perm)
+
+#define module_param_array_named(name, array, type, nump, perm)		\
+	module_param_array_named_ranged(name, array, type, nump, 1, 0, perm)
 
-#define module_param_array(name, type, nump, perm)		\
+#define module_param_array(name, type, nump, perm)			\
 	module_param_array_named(name, name, type, nump, perm)
 
 extern int param_array_set(const char *val, struct kernel_param *kp);
@@ -169,9 +179,8 @@ extern int param_get_string(char *buffer
 extern int param_set_flag(const char *val, struct kernel_param *kp);
 extern int param_get_flag(char *buffer, struct kernel_param *kp);
 
-int param_array(const char *name,
-		const char *val,
-		unsigned int min, unsigned int max,
+int param_array(const char *name, const char *val,
+		long min_val, long max_val, unsigned int min, unsigned int max,
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
 		int *num);
Index: linux-devparam-export/kernel/module.c
===================================================================
--- linux-devparam-export.orig/kernel/module.c	2004-10-22 17:13:33.000000000 +0900
+++ linux-devparam-export/kernel/module.c	2004-10-23 11:09:28.000000000 +0900
@@ -748,19 +748,19 @@ int set_obsolete(const char *val, struct
 		max = min;
 	switch (*endp) {
 	case 'b':
-		return param_array(kp->name, val, min, max, obsparm->addr,
+		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
 				   1, param_set_byte, &dummy);
 	case 'h':
-		return param_array(kp->name, val, min, max, obsparm->addr,
+		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
 				   sizeof(short), param_set_short, &dummy);
 	case 'i':
-		return param_array(kp->name, val, min, max, obsparm->addr,
+		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
 				   sizeof(int), param_set_int, &dummy);
 	case 'l':
-		return param_array(kp->name, val, min, max, obsparm->addr,
+		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
 				   sizeof(long), param_set_long, &dummy);
 	case 's':
-		return param_array(kp->name, val, min, max, obsparm->addr,
+		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
 				   sizeof(char *), param_set_charp, &dummy);
 
 	case 'c':
@@ -777,7 +777,7 @@ int set_obsolete(const char *val, struct
 		}
 		if (size >= maxsize) 
 			goto oversize;
-		return param_array(kp->name, val, min, max, obsparm->addr,
+		return param_array(kp->name, val, 1, 0, min, max, obsparm->addr,
 				   maxsize, obsparm_copy_string, &dummy);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
Index: linux-devparam-export/kernel/params.c
===================================================================
--- linux-devparam-export.orig/kernel/params.c	2004-10-23 11:09:28.000000000 +0900
+++ linux-devparam-export/kernel/params.c	2004-10-23 11:09:28.000000000 +0900
@@ -138,6 +138,11 @@ int parse_args(const char *name,
 			       "%s: `%s' too large for parameter `%s'\n",
 			       name, val ?: "", param);
 			return ret;
+		case -ERANGE:
+			printk(KERN_ERR
+			       "%s: `%s' out of range for parameter `%s'\n",
+			       name, val ?: "", param);
+			return ret;
 		case 0:
 			break;
 		default:
@@ -163,6 +168,9 @@ int parse_args(const char *name,
 		l = strtolfn(val, &endp, 0);				\
 		if (endp == val || ((type)l != l))			\
 			return -EINVAL;					\
+		if (!(kp->min == 1 && kp->max == 0) &&			\
+		    (l < (type)kp->min || l > (type)kp->max))		\
+			return -ERANGE;					\
 		*((type *)kp->arg) = l;					\
 		return 0;						\
 	}								\
@@ -181,15 +189,26 @@ STANDARD_PARAM_DEF(ulong, unsigned long,
 
 int param_set_charp(const char *val, struct kernel_param *kp)
 {
+	size_t min, max, len;
+
 	if (!val) {
 		printk(KERN_ERR "%s: string parameter expected\n",
 		       kp->name);
 		return -EINVAL;
 	}
 
-	if (strlen(val) > 1024) {
-		printk(KERN_ERR "%s: string parameter too long\n",
-		       kp->name);
+	if (kp->min == 1 && kp->max == 0) {
+		min = 0;
+		max = 1024;
+	} else {
+		min = kp->min;
+		max = kp->max;
+	}
+
+	len = strlen(val);
+	if (len < min || len > max) {
+		printk(KERN_ERR "%s: string parameter too %s\n",
+		       kp->name, len < min ? "short" : "long");
 		return -ENOSPC;
 	}
 
@@ -246,9 +265,8 @@ int param_get_invbool(char *buffer, stru
 }
 
 /* We cheat here and temporarily mangle the string. */
-int param_array(const char *name,
-		const char *val,
-		unsigned int min, unsigned int max,
+int param_array(const char *name, const char *val,
+		long min_val, long max_val, unsigned int min, unsigned int max,
 		void *elem, int elemsize,
 		int (*set)(const char *, struct kernel_param *kp),
 		int *num)
@@ -260,6 +278,8 @@ int param_array(const char *name,
 	/* Get the name right for errors. */
 	kp.name = name;
 	kp.arg = elem;
+	kp.min = min_val;
+	kp.max = max_val;
 
 	/* No equals sign? */
 	if (!val) {
@@ -304,8 +324,9 @@ int param_array_set(const char *val, str
 	struct kparam_array *arr = kp->arg;
 	unsigned int t;
 
-	return param_array(kp->name, val, 1, arr->max, arr->elem,
-			   arr->elemsize, arr->set, arr->num ?: &t);
+	return param_array(kp->name, val, kp->min, kp->max,
+			   1, arr->max, arr->elem, arr->elemsize,
+			   arr->set, arr->num ?: &t);
 }
 
 int param_array_get(char *buffer, struct kernel_param *kp)
@@ -330,21 +351,18 @@ int param_array_get(char *buffer, struct
 
 int param_set_copystring(const char *val, struct kernel_param *kp)
 {
-	struct kparam_string *kps = kp->arg;
-
-	if (strlen(val)+1 > kps->maxlen) {
-		printk(KERN_ERR "%s: string doesn't fit in %u chars.\n",
-		       kp->name, kps->maxlen-1);
+	if (strlen(val)+1 > kp->max) {
+		printk(KERN_ERR "%s: string doesn't fit in %lu chars.\n",
+		       kp->name, kp->max - 1);
 		return -ENOSPC;
 	}
-	strcpy(kps->string, val);
+	strcpy(kp->arg, val);
 	return 0;
 }
 
 int param_get_string(char *buffer, struct kernel_param *kp)
 {
-	struct kparam_string *kps = kp->arg;
-	return strlcpy(buffer, kps->string, kps->maxlen);
+	return strlcpy(buffer, kp->arg, kp->max);
 }
 
 int param_set_flag(const char *val, struct kernel_param *kp)
