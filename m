Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbTIWI2R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 04:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbTIWI2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 04:28:17 -0400
Received: from dp.samba.org ([66.70.73.150]:47525 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261289AbTIWI2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 04:28:08 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com, akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org, Marc Zyngier <maz@wild-wind.fr.eu.org>
Subject: [PATCH] module_param_array()
Date: Tue, 23 Sep 2003 18:23:41 +1000
Message-Id: <20030923082808.4B97D2C014@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Found this while converting netfilter modules to use the new
parameters.  Also fixes an out-by-one error in maximum elements you
can put in array.

The current "intarray" module params were never tested, and um, suck.
Only one person uses them, and it looks painful.

Marc, does look better to you, too?  (Your code compile tested only).
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Module Array Parameters
Author: Rusty Russell
Status: Booted on 2.6.0-test5-bk9

D: The current int-array module params were never tested, and um,
D: suck.  Since noone uses them, replace them with tested versions,
D: which don't.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31726-linux-2.6.0-test5-bk9/include/linux/moduleparam.h .31726-linux-2.6.0-test5-bk9.updated/include/linux/moduleparam.h
--- .31726-linux-2.6.0-test5-bk9/include/linux/moduleparam.h	2003-09-22 10:09:22.000000000 +1000
+++ .31726-linux-2.6.0-test5-bk9.updated/include/linux/moduleparam.h	2003-09-23 18:14:36.000000000 +1000
@@ -3,6 +3,7 @@
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
 #include <linux/init.h>
 #include <linux/stringify.h>
+#include <linux/kernel.h>
 
 /* You can override this manually, but generally this should match the
    module name. */
@@ -33,6 +34,17 @@ struct kparam_string {
 	char *string;
 };
 
+/* Special one for arrays */
+struct kparam_array
+{
+	unsigned int max;
+	unsigned int *num;
+	param_set_fn set;
+	param_get_fn get;
+	unsigned int elemsize;
+	void *elem;
+};
+
 /* This is the fundamental function for registering boot/module
    parameters.  perm sets the visibility in driverfs: 000 means it's
    not there, read bits mean it's readable, write bits mean it's
@@ -112,10 +124,16 @@ extern int param_set_invbool(const char 
 extern int param_get_invbool(char *buffer, struct kernel_param *kp);
 #define param_check_invbool(name, p) __param_check(name, p, int)
 
-/* First two elements are the max and min array length (which don't change) */
-extern int param_set_intarray(const char *val, struct kernel_param *kp);
-extern int param_get_intarray(char *buffer, struct kernel_param *kp);
-#define param_check_intarray(name, p) __param_check(name, p, int *)
+/* Comma-separated array: num is set to number they actually specified. */
+#define module_param_array(name, type, num, perm)			\
+	static struct kparam_array __param_arr_##name			\
+	= { ARRAY_SIZE(name), &num, param_set_##type, param_get_##type,	\
+	    sizeof(name[0]), name };					\
+	module_param_call(name, param_array_set, param_array_get, 	\
+			  &__param_arr_##name, perm)
+
+extern int param_array_set(const char *val, struct kernel_param *kp);
+extern int param_array_get(char *buffer, struct kernel_param *kp);
 
 extern int param_set_copystring(const char *val, struct kernel_param *kp);
 
@@ -123,5 +141,6 @@ int param_array(const char *name,
 		const char *val,
 		unsigned int min, unsigned int max,
 		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp));
+		int (*set)(const char *, struct kernel_param *kp),
+		int *num);
 #endif /* _LINUX_MODULE_PARAM_TYPES_H */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31726-linux-2.6.0-test5-bk9/kernel/module.c .31726-linux-2.6.0-test5-bk9.updated/kernel/module.c
--- .31726-linux-2.6.0-test5-bk9/kernel/module.c	2003-09-22 10:28:13.000000000 +1000
+++ .31726-linux-2.6.0-test5-bk9.updated/kernel/module.c	2003-09-23 18:14:36.000000000 +1000
@@ -844,6 +844,7 @@ int set_obsolete(const char *val, struct
 {
 	unsigned int min, max;
 	unsigned int size, maxsize;
+	int dummy;
 	char *endp;
 	const char *p;
 	struct obsolete_modparm *obsparm = kp->arg;
@@ -866,19 +867,19 @@ int set_obsolete(const char *val, struct
 	switch (*endp) {
 	case 'b':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   1, param_set_byte);
+				   1, param_set_byte, &dummy);
 	case 'h':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(short), param_set_short);
+				   sizeof(short), param_set_short, &dummy);
 	case 'i':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(int), param_set_int);
+				   sizeof(int), param_set_int, &dummy);
 	case 'l':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(long), param_set_long);
+				   sizeof(long), param_set_long, &dummy);
 	case 's':
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   sizeof(char *), param_set_charp);
+				   sizeof(char *), param_set_charp, &dummy);
 
 	case 'c':
 		/* Undocumented: 1-5c50 means 1-5 strings of up to 49 chars,
@@ -895,7 +896,7 @@ int set_obsolete(const char *val, struct
 		if (size >= maxsize) 
 			goto oversize;
 		return param_array(kp->name, val, min, max, obsparm->addr,
-				   maxsize, obsparm_copy_string);
+				   maxsize, obsparm_copy_string, &dummy);
 	}
 	printk(KERN_ERR "Unknown obsolete parameter type %s\n", obsparm->type);
 	return -EINVAL;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31726-linux-2.6.0-test5-bk9/kernel/params.c .31726-linux-2.6.0-test5-bk9.updated/kernel/params.c
--- .31726-linux-2.6.0-test5-bk9/kernel/params.c	2003-09-22 10:27:38.000000000 +1000
+++ .31726-linux-2.6.0-test5-bk9.updated/kernel/params.c	2003-09-23 18:14:36.000000000 +1000
@@ -242,10 +242,10 @@ int param_array(const char *name,
 		const char *val,
 		unsigned int min, unsigned int max,
 		void *elem, int elemsize,
-		int (*set)(const char *, struct kernel_param *kp))
+		int (*set)(const char *, struct kernel_param *kp),
+		int *num)
 {
 	int ret;
-	unsigned int count = 0;
 	struct kernel_param kp;
 	char save;
 
@@ -259,11 +259,12 @@ int param_array(const char *name,
 		return -EINVAL;
 	}
 
+	*num = 0;
 	/* We expect a comma-separated list of values. */
 	do {
 		int len;
 
-		if (count > max) {
+		if (*num == max) {
 			printk(KERN_ERR "%s: can only take %i arguments\n",
 			       name, max);
 			return -EINVAL;
@@ -279,10 +280,10 @@ int param_array(const char *name,
 			return ret;
 		kp.arg += elemsize;
 		val += len+1;
-		count++;
+		(*num)++;
 	} while (save == ',');
 
-	if (count < min) {
+	if (*num < min) {
 		printk(KERN_ERR "%s: needs at least %i arguments\n",
 		       name, min);
 		return -EINVAL;
@@ -290,29 +291,32 @@ int param_array(const char *name,
 	return 0;
 }
 
-/* First two elements are the max and min array length (which don't change) */
-int param_set_intarray(const char *val, struct kernel_param *kp)
+int param_array_set(const char *val, struct kernel_param *kp)
 {
-	int *array;
+	struct kparam_array *arr = kp->arg;
 
-	/* Grab min and max as first two elements */
-	array = kp->arg;
-	return param_array(kp->name, val, array[0], array[1], &array[2],
-			   sizeof(int), param_set_int);
+	return param_array(kp->name, val, 1, arr->max, arr->elem,
+			   arr->elemsize, arr->set, arr->num);
 }
 
-int param_get_intarray(char *buffer, struct kernel_param *kp)
+int param_array_get(char *buffer, struct kernel_param *kp)
 {
-	int max;
-	int *array;
-	unsigned int i;
-
-	array = kp->arg;
-	max = array[1];
+	int i, off, ret;
+	struct kparam_array *arr = kp->arg;
+	struct kernel_param p;
 
-	for (i = 2; i < max + 2; i++)
-		sprintf(buffer, "%s%i", i > 2 ? "," : "", array[i]);
-	return strlen(buffer);
+	p = *kp;
+	for (i = off = 0; i < *arr->num; i++) {
+		if (i)
+			buffer[off++] = ',';
+		p.arg = arr->elem + arr->elemsize * i;
+		ret = arr->get(buffer + off, &p);
+		if (ret < 0)
+			return ret;
+		off += ret;
+	}
+	buffer[off] = '\0';
+	return off;
 }
 
 int param_set_copystring(const char *val, struct kernel_param *kp)
@@ -346,6 +350,6 @@ EXPORT_SYMBOL(param_set_bool);
 EXPORT_SYMBOL(param_get_bool);
 EXPORT_SYMBOL(param_set_invbool);
 EXPORT_SYMBOL(param_get_invbool);
-EXPORT_SYMBOL(param_set_intarray);
-EXPORT_SYMBOL(param_get_intarray);
+EXPORT_SYMBOL(param_array_set);
+EXPORT_SYMBOL(param_array_get);
 EXPORT_SYMBOL(param_set_copystring);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .31726-linux-2.6.0-test5-bk9/drivers/eisa/eisa-bus.c .31726-linux-2.6.0-test5-bk9.updated/drivers/eisa/eisa-bus.c
--- .31726-linux-2.6.0-test5-bk9/drivers/eisa/eisa-bus.c	2003-09-23 00:39:36.000000000 +1000
+++ .31726-linux-2.6.0-test5-bk9.updated/drivers/eisa/eisa-bus.c	2003-09-23 18:18:22.000000000 +1000
@@ -33,23 +33,22 @@ static struct eisa_device_info __initdat
 #endif
 
 #define EISA_MAX_FORCED_DEV 16
-#define EISA_FORCED_OFFSET  2
 
-static int enable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET]  = { 1, EISA_MAX_FORCED_DEV, };
-static int disable_dev[EISA_MAX_FORCED_DEV + EISA_FORCED_OFFSET] = { 1, EISA_MAX_FORCED_DEV, };
+static int enable_dev[EISA_MAX_FORCED_DEV];
+static int enable_dev_count;
+static int disable_dev[EISA_MAX_FORCED_DEV];
+static int disable_dev_count;
 
 static int is_forced_dev (int *forced_tab,
+			  int forced_count,
 			  struct eisa_root_device *root,
 			  struct eisa_device *edev)
 {
 	int i, x;
 
-	for (i = 0; i < EISA_MAX_FORCED_DEV; i++) {
-		if (!forced_tab[EISA_FORCED_OFFSET + i])
-			return 0;
-
+	for (i = 0; i < forced_count; i++) {
 		x = (root->bus_nr << 8) | edev->slot;
-		if (forced_tab[EISA_FORCED_OFFSET + i] == x)
+		if (forced_tab[i] == x)
 			return 1;
 	}
 
@@ -198,10 +197,10 @@ static int __init eisa_init_device (stru
 #endif
 	}
 
-	if (is_forced_dev (enable_dev, root, edev))
+	if (is_forced_dev (enable_dev, enable_dev_count, root, edev))
 		edev->state = EISA_CONFIG_ENABLED | EISA_CONFIG_FORCED;
 	
-	if (is_forced_dev (disable_dev, root, edev))
+	if (is_forced_dev (disable_dev, disable_dev_count, root, edev))
 		edev->state = EISA_CONFIG_FORCED;
 
 	return 0;
@@ -418,12 +417,8 @@ static int __init eisa_init (void)
 	return 0;
 }
 
-/* Couldn't use intarray with checking on... :-( */
-#undef  param_check_intarray
-#define param_check_intarray(name, p)
-
-module_param(enable_dev,  intarray, 0444);
-module_param(disable_dev, intarray, 0444);
+module_param_array(enable_dev, int, enable_dev_count, 0444);
+module_param_array(disable_dev, int, disable_dev_count, 0444);
 
 postcore_initcall (eisa_init);
 
