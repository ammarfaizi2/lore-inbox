Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262092AbUKDHNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbUKDHNp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbUKDHNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:13:45 -0500
Received: from [211.58.254.17] ([211.58.254.17]:25760 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S262092AbUKDGxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 01:53:34 -0500
Date: Thu, 4 Nov 2004 15:53:30 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.10-rc1 12/15] driver-model: devparam implemented
Message-ID: <20041104065330.GL24890@home-tj.org>
References: <20041104063532.GA24566@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104063532.GA24566@home-tj.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_12_devparam.patch

 This is the 12th patch of 15 patches for devparam.

 This patch adds needed data fields to module and device structures
and actually implements devparam.  This patch doesn't hook devparam
into the driver model it's done in the next patch.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-export/drivers/base/Makefile
===================================================================
--- linux-export.orig/drivers/base/Makefile	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/drivers/base/Makefile	2004-11-04 14:48:43.000000000 +0900
@@ -2,7 +2,8 @@
 
 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
-			   cpu.o firmware.o init.o map.o dmapool.o
+			   cpu.o firmware.o init.o map.o dmapool.o \
+			   deviceparam.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
Index: linux-export/drivers/base/deviceparam.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/drivers/base/deviceparam.c	2004-11-04 14:48:43.000000000 +0900
@@ -0,0 +1,858 @@
+/*
+ * deviceparam.c - per-device bus/driver parameter
+ *
+ * Copyright (C) 2004 Tejun Heo <tj@home-tj.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/deviceparam.h>
+#include <linux/device.h>
+#include <linux/module.h>
+
+#if 0
+#define pdebug(fmt, args...) printk("[%-25s] " fmt, __FUNCTION__ , ##args)
+#else
+#define pdebug(fmt, args...)
+#endif
+
+#define MAX_DEVICE_BOOTOPTS	64
+
+static int nr_bootopts = 0;
+static __initdata char *bootopts[MAX_DEVICE_BOOTOPTS][2];
+
+#define for_each_setdef(which, setdef, drv) \
+	for ((which) = 0; \
+	     ((which) < (drv)->nr_paramsets || ((setdef) = NULL, 0)) && \
+	     ((setdef) = (drv)->paramset_defs[(which)], 1); (which)++)
+
+static int devparam_parse_modparams(struct device_driver *drv);
+
+/*
+ * devparam_vec
+ */
+static void vec_init(struct devparam_vec *vec, int elem_size)
+{
+	vec->ar = NULL;
+	vec->ar_len = 0;
+	vec->len = 0;
+	vec->elem_size = elem_size;
+}
+
+static int vec_set_len(struct devparam_vec *vec, int nlen)
+{
+	int i;
+
+	if (nlen <= vec->len) {
+		/* Shrink */
+		for (i = nlen; i < vec->len; i++) {
+			kfree(vec->ar[i]);
+			vec->ar[i] = NULL;
+		}
+		vec->len = nlen;
+		return 0;
+	}
+
+	/* Expand */
+	if (nlen > vec->ar_len) {
+		int ar_len = vec->ar_len ?: 16;
+		void **ar;
+		do {
+			ar_len *= 2;
+			BUG_ON(ar_len < 0);
+		} while (ar_len < nlen);
+
+		if ((ar = kmalloc(ar_len * sizeof(ar[0]), GFP_KERNEL)) == NULL)
+			return -ENOMEM;
+
+		memcpy(ar, vec->ar, vec->ar_len * sizeof(ar[0]));
+		memset(ar + vec->ar_len, 0,
+		       (ar_len - vec->ar_len) * sizeof(ar[0]));
+
+		kfree(vec->ar);
+		vec->ar = ar;
+		vec->ar_len = ar_len;
+	}
+
+	for (i = vec->len; i < nlen; i++) {
+		if ((vec->ar[i] = kmalloc(vec->elem_size, GFP_KERNEL)) == NULL)
+			goto unroll_out;
+		memset(vec->ar[i], 0, vec->elem_size);
+	}
+
+	vec->len = nlen;
+	return 0;
+
+ unroll_out:
+	while (--i >= vec->len)
+		kfree(vec->ar[i]);
+	return -ENOMEM;
+}
+
+static void * vec_elem(struct devparam_vec *vec, int idx)
+{
+	if (idx >= vec->len && vec_set_len(vec, idx + 1) < 0)
+		return NULL;
+	return vec->ar[idx];
+}
+
+static void vec_destroy(struct devparam_vec *vec)
+{
+	int i;
+	for (i = 0; i < vec->len; i++)
+		kfree(vec->ar[i]);
+	kfree(vec->ar);
+}
+
+
+/*
+ * Utility routines
+ */
+static struct device_paramset_def *
+get_setdef_by_idx(int *pidx, int *pwhich, struct device_driver *drv)
+{
+	int which, idx = *pidx;
+	struct device_paramset_def *setdef;
+
+	for_each_setdef(which, setdef, drv) {
+		if (idx >= setdef->nr_defs)
+			idx -= setdef->nr_defs;
+		else
+			break;
+	}
+
+	*pidx = idx;
+	*pwhich = which;
+	return setdef;
+}
+
+static int prepare_kparam(struct kernel_param *kparam,
+			  struct device_param_def *def, void *paramset)
+{
+	const int *fixups;
+
+	*kparam = def->kparam;
+
+	if (def->arg_copy_size) {
+		if (!(kparam->arg = kmalloc(def->arg_copy_size, GFP_KERNEL)))
+			return -ENOMEM;
+		memcpy(kparam->arg, def->kparam.arg, def->arg_copy_size);
+	}
+
+	for (fixups = def->arg_fixups; fixups[1] != -1; fixups += 2) {
+		void *p = paramset + fixups[1];
+		if (fixups[0] != -1)
+			*(void **)(kparam->arg + fixups[0]) = p;
+		else
+			kparam->arg = p;
+	}
+
+	return 0;
+}
+
+static void release_kparam(struct kernel_param *kparam,
+			   struct device_param_def *def)
+{
+	if (def->arg_copy_size)
+		kfree(kparam->arg);
+}
+
+static int call_get(struct device_param_def *def, char *buf, void *paramset)
+{
+	struct kernel_param kparam;
+	int ret;
+
+	if ((ret = prepare_kparam(&kparam, def, paramset)) == 0) {
+		ret = kparam.get(buf, &kparam);
+		pdebug("n=\"%s\" b=\"%s\" arg=%p set=%p ret=%d\n",
+		       kparam.name, buf, kparam.arg, kparam.set, ret);
+	}
+	release_kparam(&kparam, def);
+
+	return ret;
+}
+
+static int call_set(struct device_param_def *def, char *val, void *paramset)
+{
+	struct kernel_param kparam;
+	int is_dfl, ret, set_ret;
+
+	is_dfl = val == NULL;
+
+	if (is_dfl) {
+		size_t size;
+		if (def->dfl == NULL)
+			return 0;
+		if (def->copy_dfl) {
+			size = strlen(def->dfl) + 1;
+			if ((val = kmalloc(size, GFP_KERNEL)) == NULL)
+				return -ENOMEM;
+			memcpy(val, def->dfl, size);
+		} else
+			val = (char *)def->dfl;
+	}
+
+	set_ret = 0;
+	if ((ret = prepare_kparam(&kparam, def, paramset)) == 0) {
+		ret = set_ret = kparam.set(val, &kparam);
+		pdebug("n=\"%s\" v=\"%s\" arg=%p set=%p is_dfl=%d ret=%d\n",
+		       kparam.name, val, kparam.arg, kparam.set, is_dfl, ret);
+	}
+	release_kparam(&kparam, def);
+
+	if (is_dfl) {
+		if (set_ret < 0)
+			printk(KERN_ERR "Device params: default parameter `%s' "
+			       "failed for parameter `%s' with error code %d, "
+			       "please report to the maintainer\n",
+			       def->dfl, kparam.name, set_ret);
+		if (def->copy_dfl)
+			kfree(val);
+	}
+
+	return ret;
+}
+
+static int parse_one_devparam(const char *full_param, char *param, char *val,
+			      struct device_driver *drv, int **cursors,
+			      struct device *dev, long **bitmaps)
+{
+	char *p, *ns, *no_ns = "";
+	struct device_paramset_def *setdef;
+	struct device_param_def *def;
+	int which, idx, ret;
+	void *ps;
+
+	ns = no_ns;
+	if ((p = strchr(param, '.')) != NULL) {
+		*p++ = '\0';
+		ns = param;
+		param = p;
+	}
+
+	idx = 0; def = NULL;	/* to make gcc shut up */
+	for_each_setdef(which, setdef, drv) {
+		if (strcmp(setdef->namespace, ns))
+			continue;
+		for (idx = 0; idx < setdef->nr_defs; idx++) {
+			def = &setdef->defs[idx];
+			if (strcmp(def->kparam.name, param) == 0)
+				goto exit_loop;
+		}
+	}
+ exit_loop:
+	if (ns != no_ns)
+		*--param = '.';
+	if (setdef == NULL)
+		return -ENOENT;
+
+	/* Okay, we have a match */
+	if (dev == NULL) {
+		/* We're storing into one of the driver paramset
+		   storage vectors. */
+		ps = vec_elem(&drv->paramset_vecs[which], cursors[which][idx]);
+		if (ps == NULL) {
+			printk(KERN_ERR
+			       "Device params: Insufficient memory for "
+			       "parameter `%s'\n", full_param);
+			return -ENOMEM;
+		}
+		pdebug("setting drv_vec, which=%d idx=%d cursor=%d\n",
+		       which, idx, cursors[which][idx]);
+	} else {
+		/* Set device paramsets directly. */
+		ps = dev->paramsets[which];
+		pdebug("setting directly, which=%d\n", which);
+	}
+
+	ret = call_set(def, val, ps);
+
+	switch (ret) {
+	case 0:
+		if (dev == NULL)
+			cursors[which][idx]++;
+		else
+			set_bit(idx, bitmaps[which]);
+		break;
+	case -ENOSPC:
+		printk(KERN_ERR
+		       "Device params: `%s' too large for parameter `%s'\n",
+		       val ?: "", full_param);
+		break;
+	case -ERANGE:
+		printk(KERN_ERR
+		       "Device params: `%s' out of range for parameter `%s'\n",
+		       val ?: "", full_param);
+		break;
+	default:
+		printk(KERN_ERR
+		       "Device params: `%s' invalid for parameter `%s'\n",
+		       val ?: "", full_param);
+		break;
+	}
+
+	return ret;
+}
+
+/*
+ * Initialization routines
+ */
+int devparam_driver_init(struct device_driver *drv)
+{
+	int nr_paramsets, i, ret;
+	struct devparam_vec *vecs;
+
+	drv->nr_paramsets = nr_paramsets = 0;
+	drv->paramset_bitmap_len = 0;
+	drv->paramset_bitmap = NULL;
+	drv->paramset_vecs = vecs = NULL;
+
+	if (drv->paramset_defs)
+		while (drv->paramset_defs[nr_paramsets])
+			nr_paramsets++;
+	nr_paramsets += drv->bus && drv->bus->paramset_def;
+
+	if (nr_paramsets == 0)
+		return 0;
+
+	vecs = kmalloc(nr_paramsets * sizeof(vecs[0]), GFP_KERNEL);
+	if (vecs == NULL) {
+		printk(KERN_ERR "Failed to allocate paramset vectors "
+		       "for driver `%s'\n", drv->name);
+		return -ENOMEM;
+	}
+
+	drv->nr_paramsets = nr_paramsets;
+	drv->paramset_vecs = vecs;
+
+	if (drv->bus && drv->bus->paramset_def) {
+		/* We cheat here and use the terminating NULL element
+		   of the driver's paramset_defs if available or make
+		   paramset_defs directly point to bus_paramset_def. */
+		if (nr_paramsets == 1)
+			drv->paramset_defs = &drv->bus->paramset_def;
+		else
+			drv->paramset_defs[nr_paramsets - 1] =
+				drv->bus->paramset_def;
+	}
+
+	for (i = 0; i < nr_paramsets; i++) {
+		struct device_paramset_def *setdef = drv->paramset_defs[i];
+
+		/* Theoretically, the setdef could be being used on
+		   other processors while we're counting nr_defs, so
+		   we cannot directly ++ setdef->nr_defs. */
+		if (setdef->nr_defs == -1) {
+			int nr_defs = 0;
+			while (setdef->defs[nr_defs].kparam.name)
+				nr_defs++;
+			setdef->nr_defs = nr_defs;
+		}
+
+		vec_init(&vecs[i], setdef->size);
+	}
+
+	/* Parse device parameters passed as boot options or module
+	   parameters */
+	if ((ret = devparam_parse_modparams(drv)) < 0)
+		devparam_driver_release(drv);
+	return ret;
+}
+
+void devparam_driver_release(struct device_driver *drv)
+{
+	int i;
+
+	kfree(drv->paramset_bitmap);
+
+	for (i = 0; i < drv->nr_paramsets; i++)
+		vec_destroy(&drv->paramset_vecs[i]);
+	kfree(drv->paramset_vecs);
+
+	/* Be nice and restore drv->paramset_defs. */
+	if (drv->bus && drv->bus->paramset_def) {
+		if (drv->nr_paramsets == 1)
+			drv->paramset_defs = NULL;
+		else
+			drv->paramset_defs[drv->nr_paramsets - 1] = NULL;
+	}
+}
+
+/*
+ * Device bootopts
+ */
+int __init devparam_maybe_bootopt(char *param, char *val)
+{
+	if (nr_bootopts >= MAX_DEVICE_BOOTOPTS) {
+		printk(KERN_ERR
+		       "Too many device bootopts `%s': ignoring\n", param);
+		return -ENOSPC;
+	}
+
+	bootopts[nr_bootopts][0] = param;
+	bootopts[nr_bootopts][1] = val;
+	nr_bootopts++;
+
+	return 0;
+}
+
+void __init devparam_finish_bootopts(void)
+{
+	int i;
+	for (i = 0; i < nr_bootopts; i++)
+		if (bootopts[i][0])
+			printk(KERN_ERR "Unknown boot option `%s': ignoring\n",
+			       bootopts[i][0]);
+	nr_bootopts = 0;
+}
+
+/*
+ * Module parameters
+ */
+#ifdef CONFIG_MODULES
+
+int devparam_module_init(struct module *mod)
+{
+	vec_init(&mod->param_vec, 2 * sizeof(char *));
+	return 0;
+}
+
+int devparam_unknown_modparam(char *name, char *val, void *arg)
+{
+	struct module *mod = arg;
+	char **param;
+
+	param = vec_elem(&mod->param_vec, mod->param_vec.len);
+	if (param == NULL) {
+		printk(KERN_ERR
+		       "Device params: Insufficient memory for `%s'\n", name);
+		return -ENOMEM;
+	}
+
+	param[0] = name;
+	param[1] = val;
+
+	return 0;
+}
+
+void devparam_module_done(struct module *mod)
+{
+	struct devparam_vec *vec = &mod->param_vec;
+	int i;
+
+	for (i = 0; i < vec->len; i++) {
+		char **param = vec_elem(vec, i);
+		if (param[0])
+			printk(KERN_ERR
+			       "Device params: Unknown parameter `%s'\n",
+			       param[0]);
+	}
+	
+	vec_destroy(vec);
+}
+
+#endif /* CONFIG_MODULES */
+
+struct modparams_set_arg {
+	char *param;
+	struct device_driver *drv;
+	int **cursors;
+};
+
+static int __init_or_module
+modparams_set(const char *val, struct kernel_param *kp)
+{
+	struct modparams_set_arg *arg = kp->arg;
+
+	return parse_one_devparam(kp->name, arg->param, (char *)val,
+				  arg->drv, arg->cursors, NULL, NULL);
+}
+
+static int __init_or_module
+parse_modparams_ar(void *params, int nr_params,
+		   char **(*read_fn)(void *params, int idx),
+		   struct device_driver *drv)
+{
+	struct device_paramset_def *setdef;
+	int which, **cursors, i, j, len, max_len, ret, err;
+	size_t size;
+
+	/* Allocate cursors */
+	err = -ENOMEM;
+
+	size = drv->nr_paramsets * sizeof(cursors[0]);
+	if (!(cursors = kmalloc(size, GFP_KERNEL)))
+		goto out;
+	memset(cursors, 0, size);
+
+	for_each_setdef(which, setdef, drv) {
+		size = setdef->nr_defs * sizeof(cursors[0][0]);
+		if ((cursors[which] = kmalloc(size, GFP_KERNEL)) == NULL)
+			goto out;
+		memset(cursors[which], 0, size);
+	}
+
+	/* Parse */
+	for (i = 0; i < nr_params; i++) {
+		char **param, *p;
+		struct modparams_set_arg arg;
+		int nr;
+
+		param = read_fn(params, i);
+		if (param[0] == NULL)
+			continue;
+
+		pdebug("parsing %s=\"%s\"\n", param[0], param[1]);
+
+		if (drv->owner == NULL) {
+			if ((p = strchr(param[0], '.')) == NULL)
+				continue;
+			*p = '\0';
+			if (strcmp(param[0], drv->name) != 0) {
+				*p = '.';
+				continue;
+			}
+			*p++ = '.';
+		} else
+			p = param[0];
+		
+		arg.param = p;
+		arg.drv = drv;
+		arg.cursors = cursors;
+
+		ret = param_array_delims(param[0], param[1], KPARAM_NO_RANGE,
+					 0, INT_MAX, &arg, 0,
+					 modparams_set, &nr, ",");
+		if (ret != -ENOENT)
+			param[0] = NULL;
+	}
+
+	/* Finalize partial paramsets */
+	pdebug("Finalizing...\n");
+	max_len = 0;
+	for_each_setdef(which, setdef, drv) {
+		struct devparam_vec *vec = &drv->paramset_vecs[which];
+
+		for (len = 0, i = 0; i < setdef->nr_defs; i++)
+			len = max(len, cursors[which][i]);
+		max_len = max(len, max_len);
+
+		for (i = 0; i < setdef->nr_defs; i++) {
+			struct device_param_def *def = &setdef->defs[i];
+
+			if (def->dfl == NULL)
+				continue;
+
+			for (j = cursors[which][i]; j < len; j++) {
+				void *ps;
+
+				ps = vec_elem(vec, j);
+				if (ps == NULL)
+					goto out;
+
+				pdebug("setting which=%d idx=%d cursor=%d\n",
+				       which, i, j);
+
+				if ((ret = call_set(def, NULL, ps)) < 0) {
+					err = ret;
+					goto out;
+				}
+			}
+		}
+
+		/* Trim vector */
+		vec_set_len(vec, len);
+	}
+
+	/* Create paramset bitmap */
+	pdebug("Creating paramset bitmap, max_len=%d\n", max_len);
+	if (max_len) {
+		unsigned long *bitmap;
+		int nbits = (max_len + BITS_PER_LONG-1) & ~(BITS_PER_LONG-1);
+
+		if ((bitmap = kmalloc(nbits / 8, GFP_KERNEL)) == NULL)
+			goto out;
+		memset(bitmap, 0, nbits / 8);
+
+		drv->paramset_bitmap = bitmap;
+		drv->paramset_bitmap_len = max_len;
+	}
+
+	err = 0;
+
+ out:
+	if (cursors) {
+		for (i = 0; i < drv->nr_paramsets; i++)
+			kfree(cursors[i]);
+		kfree(cursors);
+	}
+
+	return err;
+}
+
+static char ** __init read_bootopt(void *arg, int idx)
+{
+	char *(*params)[2] = arg;
+	return params[idx];
+}
+
+static char ** read_modparam(void *arg, int idx)
+{
+	return vec_elem(arg, idx);
+}
+
+static int devparam_parse_modparams(struct device_driver *drv)
+{
+	char **(*read_fn)(void *, int) = NULL;
+	void *params;
+	int len;
+
+	pdebug("parsing parameters for driver \"%s\", mod=%p\n",
+	       drv->name, drv->owner);
+
+	if (drv->owner == NULL) {
+		read_fn = read_bootopt;
+		params = bootopts;
+		len = nr_bootopts;
+	} else {
+		read_fn = read_modparam;
+		params = &drv->owner->param_vec;
+		len = drv->owner->param_vec.len;
+	}
+
+	return parse_modparams_ar(params, len, read_fn, drv);
+}
+
+/*
+ * release/sysfs stuff
+ */
+#define kobj_to_dp(k)	container_of((k), struct devparam_params, kobj)
+
+static void free_paramsets(void **paramsets, int nr)
+{
+	if (paramsets) {
+		int i;
+		for (i = 0; i < nr; i++)
+			kfree(paramsets[i]);
+		kfree(paramsets);
+	}
+}
+
+static void dp_release(struct kobject *kobj)
+{
+	struct devparam_params *dp = kobj_to_dp(kobj);
+
+	free_paramsets(dp->paramsets, dp->drv->nr_paramsets);
+	kfree(dp);
+}
+
+static ssize_t dp_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct devparam_params *dp = kobj_to_dp(kobj);
+	struct device_paramset_def *setdef;
+	int idx, which, ret;
+
+	idx = attr - dp->attrs;
+	setdef = get_setdef_by_idx(&idx, &which, dp->drv);
+
+	ret = call_get(&setdef->defs[idx], buf, dp->paramsets[which]);
+	if (ret > 0)
+		buf[ret++] = '\n';
+	return ret;
+}
+
+static ssize_t dp_store(struct kobject *kobj, struct attribute *attr,
+			const char *val, size_t len)
+{
+	struct devparam_params *dp = kobj_to_dp(kobj);
+	struct device_paramset_def *setdef;
+	int idx, which, ret;
+
+	idx = attr - dp->attrs;
+	setdef = get_setdef_by_idx(&idx, &which, dp->drv);
+
+	ret = call_set(&setdef->defs[idx], (char *)val, dp->paramsets[which]);
+	return ret == 0 ? len : ret;
+}
+
+static struct sysfs_ops dp_sysfs_ops = {
+	.show		= dp_show,
+	.store		= dp_store
+};
+
+static struct kobj_type dp_ktype = {
+	.release	= dp_release,
+	.sysfs_ops	= &dp_sysfs_ops
+};
+
+static void unregister_devparams(struct device *dev)
+{
+	struct devparam_params *dp = dev->params;
+	int i;
+
+	for (i = 0; i < dp->nr_attrs; i++)
+		if (dp->attrs[i].name)
+			sysfs_remove_file(&dp->kobj, &dp->attrs[i]);
+	kobject_unregister(&dp->kobj);
+}
+
+static int register_devparams(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	struct devparam_params *dp;
+	struct device_paramset_def *setdef;
+	int nr_attrs, idx, which, ret;
+	size_t size;
+
+	nr_attrs = INT_MAX;
+	get_setdef_by_idx(&nr_attrs, &which, drv);
+	nr_attrs = INT_MAX - nr_attrs;
+
+	size = sizeof(*dp) + nr_attrs * sizeof(dp->attrs[0]);
+	ret = -ENOMEM;
+	if ((dp = kmalloc(size, GFP_KERNEL)) == NULL)
+		goto free_out;
+	memset(dp, 0, size);
+
+	dev->params = dp;
+
+	if ((ret = kobject_set_name(&dp->kobj, "parameters")))
+		goto free_out;
+	dp->kobj.parent = &dev->kobj;
+	dp->kobj.ktype = &dp_ktype;
+	dp->drv = drv;
+	dp->paramsets = dev->paramsets;
+	dp->nr_attrs = nr_attrs;
+
+	if ((ret = kobject_register(&dp->kobj)))
+		goto free_out;
+
+	idx = 0;
+	for_each_setdef(which, setdef, drv) {
+		int i;
+		for (i = 0; i < setdef->nr_defs; i++) {
+			struct device_param_def *def = &setdef->defs[i];
+			struct attribute *attr = &dp->attrs[idx++];
+
+			if (def->kparam.perm == 0)
+				continue;
+
+			attr->name = (char *)def->kparam.name;
+			attr->owner = dev->driver->owner;
+			attr->mode = def->kparam.perm;
+			
+			if ((ret = sysfs_create_file(&dp->kobj, attr))) {
+				attr->name = NULL;
+				goto unregister_out;
+			}
+		}
+	}
+
+	return 0;
+
+ free_out:
+	kfree(dp);
+	free_paramsets(dev->paramsets, drv->nr_paramsets);
+	return ret;
+
+ unregister_out:
+	unregister_devparams(dev);
+	return ret;
+}
+
+/*
+ * devparam_set_params()
+ */
+static int set_devparams_by_storedparams(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int which, idx, len;
+	struct device_paramset_def *setdef;
+
+	/* Determine device bootopt index */
+	len = drv->paramset_bitmap_len;
+	idx = find_first_zero_bit(drv->paramset_bitmap, len);
+
+	/* Allocate & copy paramsets */
+	for_each_setdef(which, setdef, drv) {
+		struct devparam_vec *vec = &drv->paramset_vecs[which];
+		void *ps = dev->paramsets[which];
+
+		if (idx < vec->len)
+			memcpy(ps, vec_elem(vec, idx), setdef->size);
+		else {
+			int i, ret;
+			for (i = 0; i < setdef->nr_defs; i++) {
+				ret = call_set(&setdef->defs[i], NULL, ps);
+				if (ret < 0)
+					return ret;
+			}
+		}
+	}
+
+	if (idx < len) {
+		dev->paramset_idx = idx;
+		set_bit(idx, drv->paramset_bitmap);
+	}
+
+	pdebug("using param @ idx=%d (len=%d)\n", idx, len);
+
+	return 0;
+}
+
+int devparam_set_params(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	size_t size;
+	int which, ret;
+	struct device_paramset_def *setdef;
+
+	pdebug("invoked for %s\n", drv->name);
+
+	dev->paramsets = NULL;
+	dev->bus_paramset = NULL;
+	dev->paramset_idx = -1;
+
+	if (drv->nr_paramsets == 0)
+		return 0;
+
+	size = drv->nr_paramsets * sizeof(void *);
+	if ((dev->paramsets = kmalloc(size, GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+	memset(dev->paramsets, 0, size);
+
+	for_each_setdef(which, setdef, drv) {
+		void *ps;
+		if ((ps = kmalloc(setdef->size, GFP_KERNEL)) == NULL) {
+			ret = -ENOMEM;
+			goto free_out;
+		}
+		memset(ps, 0, setdef->size);
+		dev->paramsets[which] = ps;
+	}
+
+	if ((ret = set_devparams_by_storedparams(dev)) < 0)
+		goto free_out;
+	
+	if (drv->bus && drv->bus->paramset_def)
+		dev->bus_paramset = dev->paramsets[drv->nr_paramsets-1];
+
+	return register_devparams(dev);
+
+ free_out:
+	free_paramsets(dev->paramsets, drv->nr_paramsets);
+	return ret;
+}
+
+void devparam_release_params(struct device *dev)
+{
+	pdebug("%s: dev->params=%p paramset_idx=%d\n",
+	       dev->driver->name, dev->params, dev->paramset_idx);
+
+	if (dev->driver->nr_paramsets && dev->params) {
+		if (dev->paramset_idx >= 0)
+			clear_bit(dev->paramset_idx,
+				  dev->driver->paramset_bitmap);
+		unregister_devparams(dev);
+	}
+}
Index: linux-export/include/linux/device.h
===================================================================
--- linux-export.orig/include/linux/device.h	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/include/linux/device.h	2004-11-04 14:48:43.000000000 +0900
@@ -19,6 +19,7 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <linux/deviceparam.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -57,6 +58,7 @@ struct bus_type {
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
 	struct driver_attribute	* drv_attrs;
+	struct device_paramset_def * paramset_def;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*hotplug) (struct device *dev, char **envp, 
@@ -105,6 +107,13 @@ struct device_driver {
 	struct semaphore	unload_sem;
 	struct kobject		kobj;
 	struct list_head	devices;
+	struct device_paramset_def ** paramset_defs;
+
+	/* The following fields are initialized automatically by
+	   devparam_driver_init() when registering the driver */
+	int			nr_paramsets, paramset_bitmap_len;
+	unsigned long		* paramset_bitmap;
+	struct devparam_vec	* paramset_vecs;
 
 	struct module 		* owner;
 
@@ -267,6 +276,12 @@ struct device {
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
+
+	void		**paramsets;	/* device paramsets */
+	void		*bus_paramset;	/* bus paramset */
+	int		paramset_idx;	/* devparam bookkeeping */
+	struct devparam_params *params;	/* devparam sysfs subdirectory */
+
 	struct dev_pm_info	power;
 	u32		power_state;	/* Current operating state. In
 					   ACPI-speak, this is D0-D3, D0
Index: linux-export/include/linux/deviceparam.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-export/include/linux/deviceparam.h	2004-11-04 14:48:43.000000000 +0900
@@ -0,0 +1,226 @@
+/*
+ * deviceparam.h - per-device bus/driver parameter
+ *
+ * Copyright (C) 2004 Tejun Heo <tj@home-tj.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Read Documentation/driver-model/devparam.txt for details.
+ */
+
+#ifndef __LINUX_DEVICEPARAM_H
+#define __LINUX_DEVICEPARAM_H
+
+#include <linux/moduleparam.h>
+#include <linux/kobject.h>
+
+/* Vector type used by devparam, exported due to its usage in struct module */
+struct devparam_vec {
+	void **ar;
+	int ar_len, len, elem_size;
+};
+
+/* Parameters structure for struct device */
+struct devparam_params {
+	struct kobject kobj;	/* kobject for parameters subdir */
+	struct device_driver *drv;
+	void **paramsets;
+	int nr_attrs;
+	struct attribute attrs[];
+};
+
+/* Paramset definition related */
+struct device_paramset_def;
+
+struct device_param_def {
+	const struct kernel_param kparam;
+	const char *dfl;
+	const int copy_dfl, arg_copy_size;
+	const int arg_fixups[3 * 2];	/* enough for now */
+};
+
+struct device_paramset_def {
+	size_t size;
+	const char *namespace;
+	int nr_defs;
+	struct device_param_def defs[];
+};
+
+#define __devparam_cat1(a, b)	a##b
+#define __devparam_cat(a, b)	__devparam_cat1(a, b)
+#define __devparam_type		__devparam_cat(__DEVPARAM_TYPE_, __LINE__)
+#define __devparam_data(n)	__devparam_cat(__DEVPARAM_DATA_##n##_, __LINE__)
+#define __devparam_dataend	__devparam_cat(__DEVPARAM_DATAEND_, __LINE__)
+
+/* For some reason, gcc aligns structures which contain other
+   structures to 32-byte boundary even when __alignof__() the strucure
+   is smaller than that.  As we're gonna assemble paramset array
+   manually, we need to set alignment explicitly.  Also, we put all
+   paramset array elements into .data.1 to avoid intervening variables
+   of different types (kparam_string, kparam_array for now). */
+#define __devparam_section	__attribute__((section(".data.1")))
+#define __devparam_extra_section	/* empty */
+#define __devparam_decl(n)						\
+	static struct device_param_def n __devparam_section		\
+	__attribute__((unused, aligned(__alignof__(sizeof(void *)))))
+
+#define DEFINE_DEVICE_PARAMSET_NS(Name, Type, Namespace, Defs...)	\
+	struct device_paramset_def Name	__devparam_section = {		\
+		.size		= sizeof(Type),				\
+		.namespace	= Namespace,				\
+		.nr_defs	= -1					\
+	};								\
+	typedef Type __devparam_type;					\
+	Defs								\
+	__devparam_decl(__devparam_dataend) = {				\
+		.dfl		= "end"					\
+	}
+
+#define DEFINE_DEVICE_PARAMSET(Name, Type, Defs...)			\
+	DEFINE_DEVICE_PARAMSET_NS(Name, Type, "", Defs)
+
+/* DEVICE_PARAM_CALL's */
+#define __DEVICE_PARAM_CALL(Name, Set, Get, Arg, Argcopysize, Min, Max,	\
+			    Dfl, Copydfl, Perm, Desc, Fixups...)	\
+	__devparam_decl(__devparam_data(Name)) = {			\
+		.kparam	= {						\
+			.name		= #Name,			\
+			.perm		= Perm,				\
+			.set		= Set,				\
+			.get		= Get,				\
+			.arg		= Arg,				\
+			.min		= Min,				\
+			.max		= Max				\
+		},							\
+		.dfl		= Dfl,					\
+		.copy_dfl	= Copydfl,				\
+		.arg_copy_size	= Argcopysize,				\
+		.arg_fixups	= { Fixups }				\
+	};								\
+	MODULE_DEVPARM_DESC(Name, Desc);
+
+#define DEVICE_PARAM_CALL_RANGED(Name, Set, Get, Field, Min, Max, Dfl,	\
+				 Perm, Desc) \
+	__DEVICE_PARAM_CALL(Name, Set, Get, NULL, 0, Min, Max, Dfl, 0,	\
+		Perm, Desc, -1, offsetof(__devparam_type, Field), -1, -1)
+
+#define DEVICE_PARAM_CALL(Name, Set, Get, Field, Dfl, Perm, Desc)	\
+	DEVICE_PARAM_CALL_RANGED(Name, Set, Get, Field, 1, 0, Dfl, Perm, Desc)
+
+/* Standard params */
+#define DEVICE_PARAM_NAMED_RANGED(Name, Field, Type, Min, Max, Dfl, Perm, Desc)\
+	param_check_##Type(__devparam_data(Name),			\
+			   &(((__devparam_type *)0)->Field));		\
+	DEVICE_PARAM_CALL_RANGED(Name, param_set_##Type, param_get_##Type,\
+				 Field, Min, Max, Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_RANGED(Name, Type, Min, Max, Dfl, Perm, Desc)	\
+	DEVICE_PARAM_NAMED_RANGED(Name, Name, Type, Min, Max, Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_NAMED(Name, Field, Type, Dfl, Perm, Desc)		\
+	DEVICE_PARAM_NAMED_RANGED(Name, Field, Type, 1, 0, Dfl, Perm, Desc)
+
+#define DEVICE_PARAM(Name, Type, Dfl, Perm, Desc)			\
+	DEVICE_PARAM_NAMED(Name, Name, Type, Dfl, Perm, Desc)
+
+/* String */
+#define DEVICE_PARAM_STRING_NAMED(Name, Field, Len, Dfl, Perm, Desc)	\
+	DEVICE_PARAM_CALL_RANGED(Name, param_set_copystring, param_get_string,\
+				 Field, 0, Len, Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_STRING(Name, Dfl, Perm, Desc)			\
+	DEVICE_PARAM_STRING_NAMED(Name, Name,				\
+				  sizeof(((__devparam_type *)0)->Name), \
+				  Dfl, Perm, Desc)
+
+/* Bit flag */
+#define __DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, Inv, Perm, Desc)	\
+	param_check_uint(__devparam_data(Name),				\
+			 &(((__devparam_type *)0)->Field));		\
+	static struct kparam_flag __devparam_data(__param_flag_##Name)	\
+	__devparam_extra_section = { 0, Flag, Inv };			\
+	__DEVICE_PARAM_CALL(Name, param_set_flag, param_get_flag,	\
+		&__devparam_data(__param_flag_##Name),			\
+		sizeof(struct kparam_flag), 1, 0, Dfl, 0, Perm, Desc,	\
+		offsetof(struct kparam_flag, pflags),			\
+		offsetof(__devparam_type, Field), -1, -1)
+
+#define DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, Perm, Desc)		\
+	__DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, 0, Perm, Desc)
+
+#define DEVICE_PARAM_INVFLAG(Name, Field, Flag, Dfl, Perm, Desc)	\
+	__DEVICE_PARAM_FLAG(Name, Field, Flag, Dfl, 1, Perm, Desc)
+
+/* Array */
+#define __DEVICE_PARAM_ARRAY(Name, ArrField, Type, NumOffset, Min, Max,	\
+			     Dfl, Perm, Desc)				\
+	static struct kparam_array __devparam_data(__param_arr_##Name)	\
+	__devparam_extra_section = {					\
+		ARRAY_SIZE(((__devparam_type *)0)->ArrField), 0,	\
+		param_set_##Type, param_get_##Type,			\
+		sizeof(((__devparam_type *)0)->ArrField[0]), 0		\
+	};								\
+	__DEVICE_PARAM_CALL(Name, param_array_set, param_array_get,	\
+		&__devparam_data(__param_arr_##Name),			\
+		sizeof(struct kparam_array), Min, Max, Dfl, 1, Perm, Desc,\
+		offsetof(struct kparam_array, elem),			\
+		offsetof(__devparam_type, ArrField),			\
+		offsetof(struct kparam_array, num),			\
+		NumOffset, -1, -1)
+
+#define DEVICE_PARAM_ARRAY_NAMED_RANGED(Name, ArrField, Type, NumField,	\
+					Min, Max, Dfl, Perm, Desc)	\
+	__DEVICE_PARAM_ARRAY(Name, ArrField, Type,			\
+			     offsetof(__devparam_type, NumField),	\
+			     Min, Max, Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_ARRAY_RANGED(Name, Type, NumField, Min, Max, Dfl,	\
+				  Perm, Desc)				\
+	DEVICE_PARAM_ARRAY_NAMED_RANGED(Name, Name, Type, NumField,	\
+					Min, Max, Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_ARRAY_NAMED(Name, ArrField, Type, NumField, Dfl,	\
+				 Perm, Desc)				\
+	DEVICE_PARAM_ARRAY_NAMED_RANGED(Name, ArrField, Type, NumField,	\
+					1, 0, Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_ARRAY(Name, Type, NumField, Dfl, Perm, Desc)	\
+	DEVICE_PARAM_ARRAY_NAMED(Name, Name, Type, NumField, Dfl, Perm, Desc)
+
+/* Array without len */
+
+#define DEVICE_PARAM_ARR_NAMED_RANGED(Name, ArrField, Type, Min, Max,	\
+				      Dfl, Perm, Desc)			\
+	__DEVICE_PARAM_ARRAY(Name, ArrField, Type, -1, Min, Max,	\
+			     Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_ARR_RANGED(Name, Type, Min, Max, Dfl, Perm, Desc)	\
+	DEVICE_PARAM_ARR_NAMED_RANGED(Name, Name, Type, Min, Max,	\
+				      Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_ARR_NAMED(Name, ArrField, Type, Dfl, Perm, Desc)	\
+	DEVICE_PARAM_ARR_NAMED_RANGED(Name, ArrField, Type, 1, 0,	\
+				      Dfl, Perm, Desc)
+
+#define DEVICE_PARAM_ARR(Name, Type, Dfl, Perm, Desc)			\
+	DEVICE_PARAM_ARR_NAMED(Name, Name, Type, Dfl, Perm, Desc)
+
+struct bus_type;
+struct device_driver;
+struct device;
+struct module;
+
+int devparam_driver_init(struct device_driver *drv);
+void devparam_driver_release(struct device_driver *drv);
+
+int devparam_maybe_bootopt(char *param, char *val);
+void devparam_finish_bootopts(void);
+
+int devparam_module_init(struct module *module);
+int devparam_unknown_modparam(char *name, char *val, void *arg);
+void devparam_module_done(struct module *module);
+
+int devparam_set_params(struct device *dev);
+void devparam_release_params(struct device *dev);
+
+#endif /*__LINUX_DEVICEPARAM_H*/
Index: linux-export/include/linux/module.h
===================================================================
--- linux-export.orig/include/linux/module.h	2004-11-04 10:25:58.000000000 +0900
+++ linux-export/include/linux/module.h	2004-11-04 14:48:43.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
+#include <linux/deviceparam.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -142,6 +143,9 @@ extern struct module __this_module;
 #define MODULE_PARM_DESC(_parm, desc) \
 	__MODULE_INFO(parm, _parm, #_parm ":" desc)
 
+#define MODULE_DEVPARM_DESC(_parm, desc) \
+	__MODULE_INFO(devparm, _parm, #_parm ":" desc)
+
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
 
@@ -321,6 +325,9 @@ struct module
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
+
+	/* Module parameter vector, used by deviceparam */
+	struct devparam_vec param_vec;
 };
 
 /* FIXME: It'd be nice to isolate modules during init, too, so they
