Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUJWFCI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUJWFCI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 01:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUJWFA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 01:00:27 -0400
Received: from [211.58.254.17] ([211.58.254.17]:38033 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268435AbUJWEbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 00:31:48 -0400
Date: Sat, 23 Oct 2004 13:31:38 +0900
From: Tejun Heo <tj@home-tj.org>
To: rusty@rustcorp.com.au, mochel@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH] Per-device parameter support (13/16)
Message-ID: <20041023043138.GN3456@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 dp_13_devparam.diff

 This is the 13rd patch of 16 patches for devparam.

 This patch adds needed data fields to module and device structures
and actually implements devparam.  This patch doesn't hook devparam
into the driver model it's done in the next patch.

 Currently, set_devparams_by_args() path isn't used as all parameters
are specified either as boot options or module parameters.
set_devparams_by_args() is there to be used when the hotplug facility
is expanded to deal driver-device association.  However, feel free to
#if 0 or cut the code out.


Signed-off-by: Tejun Heo <tj@home-tj.org>


Index: linux-devparam-export/drivers/base/Makefile
===================================================================
--- linux-devparam-export.orig/drivers/base/Makefile	2004-10-22 21:23:35.000000000 +0900
+++ linux-devparam-export/drivers/base/Makefile	2004-10-23 11:09:33.000000000 +0900
@@ -2,7 +2,8 @@
 
 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
-			   cpu.o firmware.o init.o map.o dmapool.o
+			   cpu.o firmware.o init.o map.o dmapool.o \
+			   deviceparam.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
Index: linux-devparam-export/drivers/base/deviceparam.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-devparam-export/drivers/base/deviceparam.c	2004-10-23 11:09:33.000000000 +0900
@@ -0,0 +1,980 @@
+/*
+ * deviceparam.c - per-device bus/driver parameter
+ *
+ * Copyright (C) 2004 Tejun Heo <tj@home-tj.org>
+ *
+ * This file is released under the GPLv2.
+ */
+
+#include <linux/deviceparam.h>
+#include <linux/bitmap.h>
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
+enum {
+	PARAMSET_WHICH_INIT = -1,
+	DEV_PARAMSET,
+	BUS_PARAMSET,
+	AUX_PARAMSET_BASE
+};
+
+#define for_each_setdef(which, setdef, drv) \
+	for ((which) = PARAMSET_WHICH_INIT; \
+	     ((setdef) = get_next_setdef(&(which), (drv))) != NULL; )
+
+static int devparam_parse_modparams(struct device_driver *drv);
+
+/*
+ * Utility routines
+ */
+static struct device_paramset_def * get_setdef(int which,
+					       struct device_driver *drv)
+{
+	BUG_ON(which < DEV_PARAMSET);
+
+	switch (which) {
+	case DEV_PARAMSET:
+		return drv->dev_paramset_def;
+	case BUS_PARAMSET:
+		return drv->bus ? drv->bus->bus_paramset_def : NULL;
+	default:
+		which -= AUX_PARAMSET_BASE;
+		if (which >= drv->nr_aux_paramsets)
+			return NULL;
+		return drv->aux_paramset_defs[which];
+	}
+}
+
+static struct device_paramset_def * get_next_setdef(int *pwhich,
+						    struct device_driver *drv)
+{
+	(*pwhich)++;
+	while (*pwhich < AUX_PARAMSET_BASE) {
+		struct device_paramset_def *setdef;
+		if ((setdef = get_setdef(*pwhich, drv)))
+			return setdef;
+		(*pwhich)++;
+	}
+
+	return get_setdef(*pwhich, drv);
+}
+
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
+static struct vector * get_drv_paramset_vec(int which,
+					    struct device_driver *drv)
+{
+	BUG_ON(which < DEV_PARAMSET);
+
+	switch (which) {
+	case DEV_PARAMSET:
+		return &drv->dev_paramset_vec;
+		break;
+	case BUS_PARAMSET:
+		return &drv->bus_paramset_vec;
+		break;
+	default:
+		which -= AUX_PARAMSET_BASE;
+		if (which >= drv->nr_aux_paramsets)
+			return NULL;
+		return &drv->aux_paramset_vecs[which];
+		break;
+	}
+}
+
+static void ** get_dev_p_paramset(int which, struct device *dev)
+{
+	struct device_params *dp = &dev->params;
+
+	switch (which) {
+	case DEV_PARAMSET:
+		return &dp->dev;
+	case BUS_PARAMSET:
+		return &dp->bus;
+	default:
+		which -= AUX_PARAMSET_BASE;
+		if (which >= dev->driver->nr_aux_paramsets)
+			return NULL;
+		return &dp->aux[which];
+	}
+}
+
+static inline void * get_dev_paramset(int which, struct device *dev)
+{
+	void **pps;
+	if ((pps = get_dev_p_paramset(which, dev)) == NULL)
+		return NULL;
+	return *pps;
+}
+
+static inline void set_dev_paramset(int which, struct device *dev, void *ps)
+{
+	*get_dev_p_paramset(which, dev) = ps;
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
+	int is_dfl, ret;
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
+	if ((ret = prepare_kparam(&kparam, def, paramset)) == 0) {
+		ret = kparam.set(val, &kparam);
+		pdebug("n=\"%s\" v=\"%s\" arg=%p set=%p is_dfl=%d ret=%d\n",
+		       kparam.name, val, kparam.arg, kparam.set, is_dfl, ret);
+	}
+	release_kparam(&kparam, def);
+
+	if (is_dfl && def->copy_dfl)
+		kfree(val);
+
+	return ret;
+}
+
+static int parse_one_devparam(const char *full_param,
+			      const char *param, char *val,
+			      struct device_driver *drv, int **cursors,
+			      struct device *dev, long **bitmaps)
+{
+	int which;
+	struct device_paramset_def *setdef;
+
+	for_each_setdef(which, setdef, drv) {
+		struct device_param_def *def = NULL; /* shut up, gcc */
+		void *ps;
+		int idx, ret;
+
+		for (idx = 0; idx < setdef->nr_defs; idx++) {
+			def = &setdef->defs[idx];
+			if (strcmp(def->kparam.name, param) == 0)
+				break;
+		}
+		if (idx == setdef->nr_defs)
+			continue;
+
+		if (dev == NULL) {
+			/* We're storing into one of driver paramset
+			   storage vectors. */
+			ps = vector_elem(get_drv_paramset_vec(which, drv),
+					 cursors[which][idx], GFP_KERNEL);
+			if (ps == NULL) {
+				printk(KERN_ERR
+				       "Device params: Insufficient memory "
+				       "for parameter `%s'\n", full_param);
+				return -ENOMEM;
+			}
+			pdebug("setting drv_vec, which=%d idx=%d cursor=%d\n",
+			       which, idx, cursors[which][idx]);
+		} else {
+			/* Set device paramsets directly. */
+			ps = get_dev_paramset(which, dev);
+			pdebug("setting directly, which=%d\n", which);
+		}
+
+		ret = call_set(def, val, ps);
+
+		switch (ret) {
+		case 0:
+			if (dev == NULL)
+				cursors[which][idx]++;
+			else
+				set_bit(idx, bitmaps[which]);
+			return ret;
+		case -ENOSPC:
+			printk(KERN_ERR
+			       "Device params: `%s' too large for parameter "
+			       "`%s'\n", val ?: "", full_param);
+			return ret;
+		case -ERANGE:
+			printk(KERN_ERR
+			       "Device params: `%s' out of range for parameter "
+			       "`%s'\n", val ?: "", full_param);
+			return ret;
+		default:
+			printk(KERN_ERR
+			       "Device params: `%s' invalid for parameter "
+			       "`%s'\n", val ?: "", full_param);
+			return ret;
+		}
+	}
+
+	return -ENOENT;
+}
+
+
+/*
+ * device paramset initialization
+ */
+int devparam_setdef_init(struct device_paramset_def *setdef)
+{
+	int i, nr_defs, ret;
+	void *ps;
+
+	BUG_ON(setdef->nr_defs != -1);
+
+	for (nr_defs = 0; setdef->defs[nr_defs].kparam.name != NULL; nr_defs++)
+		;
+
+	if ((ps = kmalloc(setdef->size, GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+	memset(ps, 0, setdef->size);
+
+	for (i = 0; i < nr_defs; i++)
+		if ((ret = call_set(&setdef->defs[i], NULL, ps)) < 0) {
+			kfree(ps);
+			printk(KERN_ERR "Device params: Failed to initialize "
+			       "paramset definition %p, error=%d\n",
+			       setdef, ret);
+			return ret;
+		}
+
+	setdef->dfl_paramset = ps;
+	setdef->nr_defs = nr_defs;
+
+	return 0;
+}
+
+void devparam_setdef_release(struct device_paramset_def *setdef)
+{
+	kfree(setdef->dfl_paramset);
+	setdef->nr_defs = -1;
+}
+
+int devparam_bus_init(struct bus_type *bus)
+{
+	return bus->bus_paramset_def
+		? devparam_setdef_init(bus->bus_paramset_def) : 0;
+}
+
+void devparam_bus_release(struct bus_type *bus)
+{
+	if (bus->bus_paramset_def)
+		devparam_setdef_release(bus->bus_paramset_def);
+}
+
+int devparam_driver_init(struct device_driver *drv)
+{
+	int ret;
+
+	drv->nr_aux_paramsets = 0;
+	drv->aux_paramset_vecs = NULL;
+
+	vector_init(&drv->paramset_used_vec, sizeof(char), VECTOR_CLEAR,
+		    NULL, NULL, NULL);
+
+	if (drv->bus && drv->bus->bus_paramset_def)
+		vector_init(&drv->bus_paramset_vec,
+			    drv->bus->bus_paramset_def->size,
+			    VECTOR_ALLOCATE|VECTOR_CLEAR, NULL, NULL, NULL);
+
+	if (drv->dev_paramset_def) {
+		struct device_paramset_def *setdef = drv->dev_paramset_def;
+		vector_init(&drv->dev_paramset_vec, setdef->size,
+			    VECTOR_ALLOCATE|VECTOR_CLEAR, NULL, NULL, NULL);
+		if ((ret = devparam_setdef_init(setdef) < 0))
+			goto out;
+	}
+
+	if (drv->aux_paramset_defs) {
+		struct vector *vecs;
+		int i;
+
+		for (i = 0; drv->aux_paramset_defs[i]; i++)
+			;
+		drv->nr_aux_paramsets = i;
+
+		vecs = kmalloc(i * sizeof(struct vector), GFP_KERNEL);
+		if (vecs == NULL) {
+			printk(KERN_ERR "Failed to allocate aux paramset "
+			       "vectors for driver `%s'\n", drv->name);
+			return -ENOMEM;
+		}
+
+		for (i = 0; i < drv->nr_aux_paramsets; i++)
+			vector_init(&vecs[i], drv->aux_paramset_defs[i]->size,
+				    VECTOR_ALLOCATE|VECTOR_CLEAR,
+				    NULL, NULL, NULL);
+
+		drv->aux_paramset_vecs = vecs;
+	}
+
+	/* Parse device parameters passed as boot options or module
+	 * parameters */
+	ret = devparam_parse_modparams(drv);
+
+ out:
+	if (ret < 0)
+		devparam_driver_release(drv);
+	return ret;
+}
+
+void devparam_driver_release(struct device_driver *drv)
+{
+	int i;
+
+	vector_destroy(&drv->paramset_used_vec);
+
+	if (drv->bus && drv->bus->bus_paramset_def)
+		vector_destroy(&drv->bus_paramset_vec);
+
+	if (drv->dev_paramset_def) {
+		vector_destroy(&drv->dev_paramset_vec);
+		devparam_setdef_release(drv->dev_paramset_def);
+	}
+
+	if (drv->aux_paramset_vecs) {
+		for (i = 0; i < drv->nr_aux_paramsets; i++)
+			vector_destroy(&drv->aux_paramset_vecs[i]);
+		kfree(drv->aux_paramset_vecs);
+	}
+}
+
+extern void devparam_params_init(struct device_params *dp)
+{
+	memset(dp, 0, sizeof(*dp));
+	dp->paramset_idx = -1;
+	dp->nr_attrs = -1;
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
+	vector_init(&mod->param_vec, 2 * sizeof(char *), 0, NULL, NULL, NULL);
+	return 0;
+}
+
+int devparam_unknown_modparam(char *name, char *val, void *arg)
+{
+	struct module *mod = arg;
+	char **param;
+
+	param = vector_elem(&mod->param_vec, vector_len(&mod->param_vec),
+			    GFP_KERNEL);
+
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
+	struct vector *vec = &mod->param_vec;
+	int i;
+
+	for (i = 0; i < vector_len(vec); i++) {
+		char **param = vector_elem(vec, i, 0);
+		if (param[0])
+			printk(KERN_ERR
+			       "Device params: Unknown parameter `%s'\n",
+			       param[0]);
+	}
+	
+	vector_destroy(vec);
+}
+
+#endif /* CONFIG_MODULES */
+
+struct modparams_set_arg {
+	const char *param;
+	struct device_driver *drv;
+	int **cursors;
+};
+
+static int
+#ifndef CONFIG_MODULES
+__init
+#endif
+modparams_set(const char *val, struct kernel_param *kp)
+{
+	struct modparams_set_arg *arg = kp->arg;
+
+	return parse_one_devparam(kp->name, arg->param, (char *)val,
+				  arg->drv, arg->cursors, NULL, NULL);
+}
+
+static int
+#ifndef CONFIG_MODULES
+__init
+#endif
+parse_modparams_ar(void *params, int nr_params,
+		   char **(*read_fn)(void *params, int idx),
+		   struct device_driver *drv)
+{
+	struct device_paramset_def *setdef;
+	int which, nr_setdefs, **cursors, i, j, len, max_len, ret, err;
+	size_t size;
+
+	/* Allocate cursors */
+	err = -ENOMEM;
+
+	nr_setdefs = AUX_PARAMSET_BASE + drv->nr_aux_paramsets;
+	size = nr_setdefs * sizeof(cursors[0]);
+	if (!(cursors = kmalloc(size, GFP_KERNEL)))
+		goto out;
+	memset(cursors, 0, size);
+
+	for_each_setdef(which, setdef, drv) {
+		BUG_ON(setdef->nr_defs < 0);
+
+		size = setdef->nr_defs * sizeof(cursors[0][0]);
+		if ((cursors[which] = kmalloc(size, GFP_KERNEL)) == NULL)
+			goto out;
+
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
+		if ((p = strchr(param[0], '.')) != NULL) {
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
+		ret = param_array_delims(param[0], param[1], 1, 0, 0, INT_MAX,
+					 &arg, 0, modparams_set, &nr, ",");
+		if (ret != -ENOENT)
+			param[0] = NULL;
+	}
+
+	/* Finalize partial paramsets */
+	pdebug("Finalizing...\n");
+	max_len = 0;
+	for_each_setdef(which, setdef, drv) {
+		struct vector *vec = get_drv_paramset_vec(which, drv);
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
+				ps = vector_elem(vec, j, GFP_KERNEL);
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
+		vector_shrink(vec, len, vector_len(vec) - len);
+	}
+
+	/* Expand used_vec. */
+	pdebug("Expanding used_vec, max_len=%d\n", max_len);
+	ret = vector_expand(&drv->paramset_used_vec, 0, max_len, GFP_KERNEL);
+	if (ret < 0) {
+		err = ret;
+		goto out;
+	}
+
+	err = 0;
+
+ out:
+	if (cursors) {
+		for (i = 0; i < nr_setdefs; i++)
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
+	return vector_elem(arg, idx, 0);
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
+		len = vector_len(params);
+	}
+
+	return parse_modparams_ar(params, len, read_fn, drv);
+}
+
+/*
+ * release/sysfs stuff
+ */
+#define kobj_to_dp(k)	container_of((k), struct device_params, kobj)
+#define dp_to_dev(d)	container_of((d), struct device, params)
+#define kobj_to_dev(k)	dp_to_dev(kobj_to_dp(k))
+
+static void release_devparams(struct device *dev)
+{
+	struct device_params *dp = &dev->params;
+	struct device_driver *drv = dev->driver;
+	int i;
+
+	if (dp->paramset_idx >= 0) {
+		char *p_used;
+		p_used = vector_elem(&drv->paramset_used_vec,
+				     dp->paramset_idx, 0);
+		*p_used = 0;
+	}
+
+	kfree(dp->dev);
+	kfree(dp->bus);
+	if (dp->aux) {
+		for (i = 0; i < drv->nr_aux_paramsets; i++)
+			kfree(dp->aux[i]);
+		kfree(dp->aux);
+	}
+	kfree(dp->attrs);
+
+	devparam_params_init(dp);
+}
+
+static void dp_release(struct kobject *kobj)
+{
+	release_devparams(kobj_to_dev(kobj));
+}
+
+static ssize_t dp_show(struct kobject *kobj, struct attribute *attr, char *buf)
+{
+	struct device_params *dp = kobj_to_dp(kobj);
+	struct device *dev = dp_to_dev(dp);
+	struct device_paramset_def *setdef;
+	int idx, which, ret;
+
+	idx = attr - dp->attrs;
+	setdef = get_setdef_by_idx(&idx, &which, dev->driver);
+
+	ret = call_get(&setdef->defs[idx], buf, get_dev_paramset(which, dev));
+	if (ret > 0)
+		buf[ret++] = '\n';
+	return ret;
+}
+
+static ssize_t dp_store(struct kobject *kobj, struct attribute *attr,
+			const char *val, size_t len)
+{
+	struct device_params *dp = kobj_to_dp(kobj);
+	struct device *dev = dp_to_dev(dp);
+	struct device_paramset_def *setdef;
+	int idx, which, ret;
+
+	idx = attr - dp->attrs;
+	setdef = get_setdef_by_idx(&idx, &which, dev->driver);
+
+	ret = call_set(&setdef->defs[idx], (char *)val,
+		       get_dev_paramset(which, dev));
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
+static int register_devparams(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	struct device_params *dp = &dev->params;
+	struct device_paramset_def *setdef;
+	int nr_attrs, idx, which, ret;
+	size_t size;
+
+	nr_attrs = INT_MAX;
+	get_setdef_by_idx(&nr_attrs, &which, drv);
+	nr_attrs = INT_MAX - nr_attrs;
+
+	size = nr_attrs * sizeof(dp->attrs[0]);
+	ret = -ENOMEM;
+	if ((dp->attrs = kmalloc(size, GFP_KERNEL)) == NULL)
+		goto release_out;
+	memset(dp->attrs, 0, size);
+
+	if ((ret = kobject_set_name(&dp->kobj, "params")))
+		goto release_out;
+	dp->kobj.parent = &dev->kobj;
+	dp->kobj.ktype = &dp_ktype;
+	dp->nr_attrs = nr_attrs;
+
+	if ((ret = kobject_register(&dp->kobj)))
+		goto release_out;
+
+	idx = 0;
+	for_each_setdef(which, setdef, drv) {
+		int i;
+		for (i = 0; i < setdef->nr_defs; i++) {
+			struct device_param_def *def = &setdef->defs[i];
+			struct attribute *attr = &dp->attrs[idx];
+
+			if (def->kparam.perm == 0)
+				continue;
+
+			attr->name = (char *)def->kparam.name;
+			attr->owner = dev->driver->owner;
+			attr->mode = def->kparam.perm;
+			
+			if ((ret = sysfs_create_file(&dp->kobj, attr)))
+				goto unregister_out;
+			idx++;
+		}
+	}
+
+	return 0;
+
+ release_out:
+	release_devparams(dev);
+	return ret;
+
+ unregister_out:
+	while (--idx >= 0)
+		if (dp->attrs[idx].name)
+			sysfs_remove_file(&dp->kobj, &dp->attrs[idx]);
+	kobject_unregister(&dp->kobj);
+	return ret;
+}
+
+static void unregister_devparams(struct device *dev)
+{
+	struct device_params *dp = &dev->params;
+	int i;
+
+	for (i = 0; i < dp->nr_attrs; i++)
+		if (dp->attrs[i].name)
+			sysfs_remove_file(&dp->kobj, &dp->attrs[i]);
+	kobject_unregister(&dp->kobj);
+}
+
+/*
+ * devparam_set_params()
+ */
+static int set_devparams_by_storedparams(struct device *dev)
+{
+	struct device_driver *drv = dev->driver;
+	int which, idx, len;
+	char *p_used = NULL;	/* shut up, gcc */
+	struct device_paramset_def *setdef;
+
+	/* Determine device bootopt index */
+	len = vector_len(&drv->paramset_used_vec);
+	for (idx = 0; idx < len; idx++) {
+		p_used = vector_elem(&drv->paramset_used_vec, idx, 0);
+		if (*p_used == 0)
+			break;
+	}
+
+	/* Allocate & copy paramsets */
+	for_each_setdef(which, setdef, drv) {
+		struct vector *vec;
+		void *ps, *ops;
+
+		if ((ps = kmalloc(setdef->size, GFP_KERNEL)) == NULL)
+			return -ENOMEM;
+
+		vec = get_drv_paramset_vec(which, drv);
+		ops = idx < vector_len(vec)
+			? vector_elem(vec, idx, 0) : setdef->dfl_paramset;
+
+		memcpy(ps, ops, setdef->size);
+
+		set_dev_paramset(which, dev, ps);
+	}
+
+	if (idx < len) {
+		dev->params.paramset_idx = idx;
+		*p_used = 1;
+	}
+
+	pdebug("using param @ idx=%d (len=%d)\n", idx, len);
+
+	return 0;
+}
+
+static int set_devparams_by_args(struct device *dev, char *args)
+{
+	struct device_driver *drv = dev->driver;
+	int which, i, cnt, err;
+	long **bitmaps;
+	struct device_paramset_def *setdef;
+
+	/* Allocate stuff */
+	cnt = AUX_PARAMSET_BASE + drv->nr_aux_paramsets;
+	err = -ENOMEM;
+
+	if (!(bitmaps = kmalloc(cnt * sizeof(bitmaps[0]), GFP_KERNEL)))
+		goto out;
+	memset(bitmaps, 0, cnt * sizeof(bitmaps[0]));
+
+	for_each_setdef(which, setdef, drv) {
+		void *ps;
+
+		BUG_ON(setdef->nr_defs < 0);
+
+		if (!(ps = kmalloc(setdef->size, GFP_KERNEL)))
+			goto out;
+
+		memset(ps, 0, setdef->size);
+		set_dev_paramset(which, dev, ps);
+
+		if (!(bitmaps[which] = kmalloc(ALIGN(setdef->nr_defs, 8) / 8,
+					       GFP_KERNEL)))
+			goto out;
+
+		bitmap_zero(bitmaps[which], setdef->nr_defs);
+	}
+
+	/* Okay, parse */
+	while (*args) {
+		char *param, *val;
+		int ret;
+
+		args = param_next_arg(args, &param, &val);
+		pdebug("param=\"%s\" val=\"%s\"\n", param, val);
+		ret = parse_one_devparam(param, param, val,
+					 drv, NULL, dev, bitmaps);
+		if (ret == -ENOENT)
+			printk(KERN_ERR
+			       "Device params: Unknown parameter `%s'\n",
+			       param);
+	}
+
+	/* Finalize */
+	for_each_setdef(which, setdef, drv) {
+		for (i = 0; i < setdef->nr_defs; i++) {
+			struct device_param_def *def = &setdef->defs[i];
+
+			if (test_bit(i, bitmaps[which]) || def->dfl == NULL)
+				continue;
+
+			err = call_set(def, NULL, get_dev_paramset(which, dev));
+			if (err < 0)
+				goto out;
+		}
+	}
+
+	err = 0;
+
+ out:
+	if (bitmaps) {
+		for (i = 0; i < cnt; i++)
+			kfree(bitmaps[i]);
+		kfree(bitmaps);
+	}
+	return err;
+}
+
+int devparam_set_params(struct device *dev, char *args)
+{
+	struct device_driver *drv = dev->driver;
+	struct device_params *dp = &dev->params;
+	int ret;
+
+	if (dp->nr_attrs >= 0)
+		return -EBUSY;
+
+	if (drv->nr_aux_paramsets) {
+		size_t size = drv->nr_aux_paramsets * sizeof(void *);
+		if ((dp->aux = kmalloc(size, GFP_KERNEL)) == NULL)
+			return -ENOMEM;
+		memset(dp->aux, 0, size);
+	}
+
+	if (args == NULL)
+		ret = set_devparams_by_storedparams(dev);
+	else
+		ret = set_devparams_by_args(dev, args);
+
+	if (ret)
+		goto release_out;
+
+	return register_devparams(dev);
+
+ release_out:
+	release_devparams(dev);
+	return ret;
+}
+
+void devparam_release_params(struct device *dev)
+{
+	unregister_devparams(dev);
+}
+
+EXPORT_SYMBOL(devparam_setdef_init);
+EXPORT_SYMBOL(devparam_setdef_release);
Index: linux-devparam-export/include/linux/device.h
===================================================================
--- linux-devparam-export.orig/include/linux/device.h	2004-10-22 17:13:32.000000000 +0900
+++ linux-devparam-export/include/linux/device.h	2004-10-23 11:09:33.000000000 +0900
@@ -19,6 +19,8 @@
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/pm.h>
+#include <linux/deviceparam.h>
+#include <linux/vector.h>
 #include <asm/semaphore.h>
 #include <asm/atomic.h>
 
@@ -57,6 +59,7 @@ struct bus_type {
 	struct bus_attribute	* bus_attrs;
 	struct device_attribute	* dev_attrs;
 	struct driver_attribute	* drv_attrs;
+	struct device_paramset_def * bus_paramset_def;
 
 	int		(*match)(struct device * dev, struct device_driver * drv);
 	int		(*hotplug) (struct device *dev, char **envp, 
@@ -105,6 +108,15 @@ struct device_driver {
 	struct semaphore	unload_sem;
 	struct kobject		kobj;
 	struct list_head	devices;
+	struct device_paramset_def * dev_paramset_def;
+	struct device_paramset_def ** aux_paramset_defs;
+
+	/* The following fields are initialized automatically by
+	   devparam_driver_init() when registering the driver */
+	int			nr_aux_paramsets;
+	struct vector		paramset_used_vec;
+	struct vector		bus_paramset_vec, dev_paramset_vec;
+	struct vector		* aux_paramset_vecs;
 
 	struct module 		* owner;
 
@@ -267,6 +279,9 @@ struct device {
 	void		*driver_data;	/* data private to the driver */
 	void		*platform_data;	/* Platform specific data (e.g. ACPI,
 					   BIOS data relevant to device) */
+
+	struct device_params	params;	/* Device params, see deviceparam.h */
+
 	struct dev_pm_info	power;
 	u32		power_state;	/* Current operating state. In
 					   ACPI-speak, this is D0-D3, D0
Index: linux-devparam-export/include/linux/deviceparam.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-devparam-export/include/linux/deviceparam.h	2004-10-23 11:09:33.000000000 +0900
@@ -0,0 +1,219 @@
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
+	int nr_defs;
+	void *dfl_paramset;
+	struct device_param_def defs[];
+};
+
+struct device_params {
+	struct kobject kobj;
+	void *dev, *bus, **aux;
+	int paramset_idx, nr_attrs;
+	struct attribute *attrs;
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
+	__attribute__((unused, aligned(__alignof__(struct device_param_def))))
+
+#define DEFINE_DEVICE_PARAMSET(Name, Type, Defs)			\
+	struct device_paramset_def Name	__devparam_section = {		\
+		.size		= sizeof(Type),				\
+		.nr_defs	= -1					\
+	};								\
+	typedef Type __devparam_type;					\
+	Defs								\
+	__devparam_decl(__devparam_dataend) = {				\
+		.dfl		= "end"					\
+	}
+
+/* DEVICE_PARAM_CALL's */
+#define __DEVICE_PARAM_CALL_RANGED(Name, Set, Get, Arg, Argcopysize,	\
+		Min, Max, Dfl, Copydfl, Perm, Desc, Fixups...)		\
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
+	__DEVICE_PARAM_CALL_RANGED(Name, Set, Get, NULL, 0, Min, Max, Dfl, 0,\
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
+	__DEVICE_PARAM_CALL_RANGED(Name, param_set_flag, param_get_flag,\
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
+	__DEVICE_PARAM_CALL_RANGED(Name, param_array_set, param_array_get,\
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
+int devparam_setdef_init(struct device_paramset_def *setdef);
+void devparam_setdef_release(struct device_paramset_def *setdef);
+
+int devparam_bus_init(struct bus_type *bus);
+void devparam_bus_release(struct bus_type *bus);
+int devparam_driver_init(struct device_driver *drv);
+void devparam_driver_release(struct device_driver *drv);
+void devparam_params_init(struct device_params *dp);
+
+int devparam_maybe_bootopt(char *param, char *val);
+void devparam_finish_bootopts(void);
+
+int devparam_module_init(struct module *module);
+int devparam_unknown_modparam(char *name, char *val, void *arg);
+void devparam_module_done(struct module *module);
+
+int devparam_set_params(struct device *dev, char *args);
+void devparam_release_params(struct device *dev);
+
+#endif /*__LINUX_DEVICEPARAM_H*/
Index: linux-devparam-export/include/linux/module.h
===================================================================
--- linux-devparam-export.orig/include/linux/module.h	2004-10-22 17:13:33.000000000 +0900
+++ linux-devparam-export/include/linux/module.h	2004-10-23 11:09:33.000000000 +0900
@@ -18,6 +18,7 @@
 #include <linux/stringify.h>
 #include <linux/kobject.h>
 #include <linux/moduleparam.h>
+#include <linux/vector.h>
 #include <asm/local.h>
 
 #include <asm/module.h>
@@ -126,6 +127,9 @@ extern struct module __this_module;
 #define MODULE_PARM_DESC(_parm, desc) \
 	__MODULE_INFO(parm, _parm, #_parm ":" desc)
 
+#define MODULE_DEVPARM_DESC(_parm, desc) \
+	__MODULE_INFO(devparm, _parm, #_parm ":" desc)
+
 #define MODULE_DEVICE_TABLE(type,name)		\
   MODULE_GENERIC_TABLE(type##_device,name)
 
@@ -323,6 +327,9 @@ struct module
 	/* The command line arguments (may be mangled).  People like
 	   keeping pointers to this stuff */
 	char *args;
+
+	/* Module parameter vector, used by deviceparam */
+	struct vector param_vec;
 };
 
 /* FIXME: It'd be nice to isolate modules during init, too, so they
