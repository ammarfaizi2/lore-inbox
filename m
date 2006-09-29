Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161506AbWI2Vmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161506AbWI2Vmc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 17:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161517AbWI2Vmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 17:42:32 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:52675 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161506AbWI2Vm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 17:42:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=gK5oOpn1+OOZjYvDxbg4XjEDLvy8enmZlBBfa7OVOLbW/pwzD7m4yOVaYTjKNDNs4HQTtxw3K78A6/0mKMPC9qYdiDDPyaiTW7a7rYm9r8itm2eCRvqAYPdaoqap9eqaOyCNBBU2RQC3/PqY7LanohkPG7y3LeteDU9xkQLpAV8=
Date: Sat, 30 Sep 2006 01:44:03 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@lists.osdl.org, matt@nomadgs.com, amit.kucheria@nokia.com,
       igor.stoppa@nokia.com, ext-Tuukka.Tikkanen@nokia.com
Subject: [PATCH] PowerOP, PowerOP Core, 1/2
Message-Id: <20060930014403.ecda5dd9.eugeny.mints@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.15; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The PowerOP Core provides completely arch independent interface
to create and control operating points which consist of arbitrary
subset of power parameters available on a certain platform.
Also, PowerOP Core provides optional SysFS interface to access
operating point from userspace.

diff --git a/Documentation/powerop.txt b/Documentation/powerop.txt
new file mode 100644
index 0000000..a34b28f
--- /dev/null
+++ b/Documentation/powerop.txt
@@ -0,0 +1,62 @@
+Introduction
+
+The PowerOP Core provides completely arch independent interface
+to create and control operating points which consist of arbitrary
+subset of power parameters available on a certain platform.
+
+PowerOP Core upper layer interface provides the following capabilities:
+- to register an operating point by passing an identifier of the point
+represented by a string and arbitrary subset of power parameters available on a
+certain platform by a string (parameter name) and value pairs.
+- to unregister operating point by name
+- to set operating point by name
+- to get and set values of arbitrary subset of platform power parameters
+  associated this a point (point is passed by name or NULL to get current
+  parameter values from hw)
+
+SysFS Interface
+
+- _optional_ SysFS interface. If SysFs interface is enabled each operating point
+registered with PowerOP core appears under /sys/power/. /sys/power/<op>/ will
+contain an attribute for each power parameter. Power parameters are rw. An
+operating point may be activated by writing its name to /sys/power/active. The
+hardware power parameters currently set may be read via /sys/power/hw/, a
+special operating point that reads parameter attribute values from hardware, for
+diagnostic purposes.
+Operating points creation with help of SysFS interface is _optional_
+_configurable_ feature. Operating points are created by writing the name of the
+operating point to /sys/power/new.  This may be a job for configfs.
+
+NOTE: PowerOP cpufreq integration does _not_ change cpufreq user interface - 
+it remains _exactly_ the same. Please see PowerOP cpufreq integration patch
+set. 
+
+Overview
+
+PowerOP get and register point APIs use name/value pairs for the power
+parameters which eliminate the need for data structure sharing between
+the PM core and consumers of the PowerOP API.
+
+This also enables a variable argument list for the registration and get
+APIs.  Some operating points may only need to work with a subset of the
+power parameters.  In this case the creator of the operating point only
+needs to provide the name/value pair for the parameters required for
+that point.  The rest are set to a don't care value by the internals.
+
+PowerOP is a building block for power management on systems that have a
+large set of power parameter that can adjusted to maximize power and
+operational efficiency.   Mobile consumer devices are examples of these
+systems that require the PowerOP features.   However, PowerOP works
+just as well on systems with one or two parameters.  The API allows the
+h/w layer to define what parameters are available on that platform.
+
+Operating points can be registered at anytime.  Registration can occur
+from a architecture init-call, loadable kernel module or some other
+layer.  Operating point registration notifiers are provided for layers,
+such as cpufreq, that could take advantage of new operating
+points that become available or just need to know when operating points
+are loaded.
+
+PowerOP continues to support in kernel governor concepts from cpufreq as well
+as userspace policy managers. 
+
diff --git a/include/linux/powerop.h b/include/linux/powerop.h
new file mode 100644
index 0000000..9793540
--- /dev/null
+++ b/include/linux/powerop.h
@@ -0,0 +1,58 @@
+/*
+ * PowerOP core definitions
+ *
+ * Author: Eugeny S. Mints <eugeny.@nomadgs.com>
+ *
+ * 2006 (C) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Based on ideas and code by Todd Poynor <tpoynor@mvista.com>
+ */
+#ifndef __POWEROP_H__
+#define __POWEROP_H__
+
+struct powerop_pwr_param {
+	struct attribute *attr;
+	int               value;
+};
+
+#define POWEROP_MAX_OPT_NAME_LENGTH 32
+
+#define POWEROP_REGISTER_EVENT    1
+#define POWEROP_UNREGISTER_EVENT  2
+
+/* operations for access_point */
+#define POWEROP_GET_PARAMS    1
+#define POWEROP_SET_PARAMS    2
+
+/* Interface to an arch PM Core layer */
+struct powerop_driver {
+	struct module *owner;
+	char *name;
+	void *(*create_point)(struct powerop_pwr_param *pwr_params, int size);
+	int (*set_point)(void *md_opt);
+	int (*access_point)(void *md_opt, struct powerop_pwr_param *pwr_params,
+			    int size, int op);
+};
+
+int powerop_driver_register(struct powerop_driver *p);
+void powerop_driver_unregister(struct powerop_driver *p);
+
+/* Main PowerOP Core interface */
+int powerop_register_point(const char *id, 
+			   struct powerop_pwr_param *pwr_params,
+			   int size);
+int powerop_unregister_point(const char *id);
+int powerop_set_point(const char *id);
+int powerop_get_point(const char *id, struct powerop_pwr_param *pwr_params,
+		      int size);
+int powerop_set_pwr_params(const char *id, struct powerop_pwr_param *pwr_param,
+			   int size);
+int powerop_get_registered_opt_names(char *opt_names_list[], int *length);
+void powerop_put_registered_opt_names(char *opt_names_list[]);
+int powerop_register_notifier(struct notifier_block *nb);
+int powerop_unregister_notifier(struct notifier_block *nb);
+
+#endif /* __POWEROP_H__ */
diff --git a/include/linux/powerop_sysfs.h b/include/linux/powerop_sysfs.h
new file mode 100644
index 0000000..5231dd0
--- /dev/null
+++ b/include/linux/powerop_sysfs.h
@@ -0,0 +1,35 @@
+/*
+ * PowerOP SysFS interface to register power parameter names available on 
+ * a platform
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * 2006 (C) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __POWEROP_SYSFS_H__
+#define __POWEROP_SYSFS_H__
+
+#ifdef CONFIG_POWEROP_SYSFS
+
+#include <linux/sysfs.h>
+
+int powerop_sysfs_register_pwr_params(struct attribute **param_attrs);
+void powerop_sysfs_unregister_pwr_params(struct attribute **param_attrs);
+#else
+static inline int
+powerop_sysfs_register_pwr_params(struct attribute **param_attrs)
+{
+	return 0;
+}
+
+static inline void
+powerop_sysfs_unregister_pwr_params(struct attribute **param_attrs) 
+{
+}
+#endif /* CONFIG_POWEROP_SYSFS */
+
+#endif /*__POWEROP_SYSFS_H__*/
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 825068c..86b27c9 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -130,3 +130,31 @@ config SUSPEND_SMP
 	bool
 	depends on HOTPLUG_CPU && X86 && PM
 	default y
+
+#
+# powerop
+#
+
+menu "PowerOP (Power Management)"
+
+config POWEROP
+	tristate "PowerOP Core"
+	help
+
+config POWEROP_SYSFS
+	bool "Enable PowerOP sysfs interface"
+	depends on PM && POWEROP && SYSFS
+	help
+
+config POWEROP_SYSFS_OP_CREATE
+	bool "Enable creation of operating point via sysfs interface"
+	depends on POWEROP_SYSFS
+	help
+
+config POWEROP_SYSFS_OP_DEBUG_IF
+	bool "Enable special hw operating point"
+	depends on POWEROP_SYSFS
+	help 
+	"hw point(ro) is used to get snapshots of power parameter values"
+
+endmenu
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 38725f5..f3b0483 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -8,3 +8,12 @@ obj-$(CONFIG_PM_LEGACY)		+= pm.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o user.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
+
+# PowerOP
+
+powerop-pm-objs := powerop.o
+ifeq ($(CONFIG_POWEROP_SYSFS),y)
+  powerop-pm-objs += powerop_sysfs.o
+endif
+
+obj-$(CONFIG_POWEROP)           += powerop-pm.o
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 873228c..7bb3a12 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -18,7 +18,7 @@ #include <linux/pm.h>
 #include <linux/console.h>
 #include <linux/cpu.h>
 #include <linux/resume-trace.h>
-
+#include <linux/module.h>
 #include "power.h"
 
 /*This is just an arbitrary number */
@@ -232,7 +232,7 @@ int pm_suspend(suspend_state_t state)
 
 
 decl_subsys(power,NULL,NULL);
-
+EXPORT_SYMBOL_GPL(power_subsys);
 
 /**
  *	state - control system power state.
diff --git a/kernel/power/powerop.c b/kernel/power/powerop.c
new file mode 100644
index 0000000..ae0e7b5
--- /dev/null
+++ b/kernel/power/powerop.c
@@ -0,0 +1,439 @@
+/*
+ * PowerOP Core routines
+ *
+ * Author: Eugeny S. Mints <eugeny@nomadgs.com>
+ * 2006 (C) Nomad Global Solutions, Inc. 
+ *
+ * Original Author: Todd Poynor <tpoynor@mvista.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/notifier.h>
+#include <linux/powerop.h>
+
+#include "powerop_point.h"
+#include "powerop_sysfs_point.h"
+
+/* 
+ * FIXME: temporary limit. next implementation will handle unlimited number 
+ * of operating point
+ */
+#define POWEROP_MAX_OPT_NUMBER      20
+/* current number of registered operating points */
+static int registered_opt_number;
+
+/* array of registered opereting point names */
+static char *registered_names[POWEROP_MAX_OPT_NUMBER];
+
+/* notifications about an operating point registration/deregistration */
+static BLOCKING_NOTIFIER_HEAD(powerop_notifier_list);
+
+static struct powerop_driver *powerop_driver;
+
+/* list of named operating points maintained by PowerOP Core layer */
+static struct list_head named_opt_list;
+static DECLARE_MUTEX(named_opt_list_mutex);
+static int powerop_initialized;
+
+/* hw access serialization */
+static DECLARE_MUTEX(powerop_mutex);
+
+/* Auxiliary PowerOP Core internal routines */
+
+static void *create_point(struct powerop_pwr_param *pwr_params, int size)
+{
+	void *res;
+
+	down(&powerop_mutex);
+	res = powerop_driver && powerop_driver->create_point ?
+	    powerop_driver->create_point(pwr_params, size) : NULL;
+	up(&powerop_mutex);
+
+	return res;
+}
+
+static int set_point(void *md_opt)
+{
+	int rc;
+
+	down(&powerop_mutex);
+	rc = md_opt && powerop_driver && powerop_driver->set_point ?
+	    powerop_driver->set_point(md_opt) : -EINVAL;
+	up(&powerop_mutex);
+
+	return rc;
+}
+
+/**
+ * access_point - get/set value of specified power paramenters
+ * @md_opt: pointer to operating point to be processed or NULL to get
+ * values of currently active operating point
+ * @pwr_params: pairs of {power parameter name, value}. in case of a set
+ * operation 'value' is result placeholder
+ * @size: size of 'pwr+params' array
+ * @op: type of operation: get/set 
+ *
+ * Get value of specified power paramenters of operating
+ * point pointed by 'md_opt'. Returns 0 on success, error code otherwise
+ */
+static int access_point(void *md_opt, struct powerop_pwr_param *pwr_params,
+			int size, int op)
+{
+	int rc;
+
+	down(&powerop_mutex);
+	rc = powerop_driver && powerop_driver->access_point ?
+		powerop_driver->access_point(md_opt, pwr_params, size, op) : 
+		-EINVAL;
+	up(&powerop_mutex);
+
+	return rc;
+}
+
+/* PowerOP Core public interface */
+
+int powerop_driver_register(struct powerop_driver *p)
+{
+	if (powerop_driver != NULL)
+		return -EBUSY;
+
+	if (p == NULL)
+		return -EINVAL;
+
+	if (!try_module_get(p->owner))
+		return -EINVAL;
+
+	printk(KERN_INFO "PowerOP registering driver %s.\n", p->name);
+	powerop_driver = p;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(powerop_driver_register);
+
+void powerop_driver_unregister(struct powerop_driver *p)
+{
+	if (powerop_driver == p) {
+		printk(KERN_INFO "PowerOP unregistering driver %s\n", p->name);
+		powerop_driver = NULL;
+	}
+	module_put(p->owner);
+}
+EXPORT_SYMBOL_GPL(powerop_driver_unregister);
+
+/**
+ * powerop_register_point - register an operating point
+ * @id: operating point name
+ * @pwr_params: array of {power parameter name, value} pairs
+ * @size: size of 'pwr_params' array
+ *
+ * Add new operating point with a given name to
+ * operating points list. A caller passes power parameters for new operating
+ * points as pairs of name/value and passes only those parameter names the
+ * caller is interested in. PowerOP Core calls powerop driver to initialize
+ * arch dependent part of new operating point and links new named operating 
+ * point to the list maintained by PowerOP Core. Returns zero on success,
+ * -EEXIST or error code otherwise
+ */
+int powerop_register_point(const char *id, 
+			   struct powerop_pwr_param *pwr_params,
+			   int size)
+{
+	int err = 0;
+	struct powerop_point *opt, *tmpopt;
+
+	if ((!powerop_initialized) || (id == NULL) ||
+	    (strlen(id) > POWEROP_MAX_OPT_NAME_LENGTH) ||
+	    (registered_opt_number >= POWEROP_MAX_OPT_NUMBER))
+		return -EINVAL;
+
+	/* check whether operating point with specified name already exists */
+	down(&named_opt_list_mutex);
+	list_for_each_entry_safe(opt, tmpopt, &named_opt_list, node) {
+		if (strcmp(kobject_name(&opt->kobj), id) == 0) {
+			err = -EEXIST;
+			break;
+		}
+	}
+	up(&named_opt_list_mutex);
+
+	if (err == -EEXIST)
+		return err;
+
+	if ((opt = kzalloc(sizeof(struct powerop_point), GFP_KERNEL)) == NULL)
+		return -ENOMEM;
+
+	if ((registered_names[registered_opt_number] =
+	     kzalloc(sizeof(char) * POWEROP_MAX_OPT_NAME_LENGTH,
+		     GFP_KERNEL)) == NULL) {
+		err = -ENOMEM;
+		goto fail_name_nomem;
+	}
+
+	opt->md_opt = create_point(pwr_params, size);
+
+	if (opt->md_opt == NULL) {
+		err = -EINVAL;
+		goto fail_opt_create;
+	}
+
+	err = kobject_set_name(&opt->kobj, id);
+	if (err != 0)
+		goto fail_set_name;
+
+	down(&named_opt_list_mutex);
+	err = powerop_sysfs_register_point(opt);
+	if (err != 0) {
+		up(&named_opt_list_mutex);
+		goto fail_set_name;
+	}
+
+	list_add_tail(&opt->node, &named_opt_list);
+	strcpy(registered_names[registered_opt_number], id);
+	registered_opt_number++;
+	up(&named_opt_list_mutex);
+
+	blocking_notifier_call_chain(&powerop_notifier_list,
+				     POWEROP_REGISTER_EVENT, id);
+	return 0;
+
+      fail_set_name:
+	kfree(opt->md_opt);
+
+      fail_opt_create:
+	kfree(registered_names[registered_opt_number]);
+
+      fail_name_nomem:
+	kfree(opt);
+	return err;
+}
+EXPORT_SYMBOL_GPL(powerop_register_point);
+
+/** 
+ * powerop_unregister_point - unregister am operating point
+ * @id: name of operating point
+ *
+ * Search for operating point with specified name and remove it from 
+ * operating points list. Returns zero on success, -EINVAL if no operating
+ * point with specified name is found
+ */
+int powerop_unregister_point(const char *id)
+{
+	struct powerop_point *opt, *tmpopt;
+	int i = 0, ret = -EINVAL;
+
+	if ((!powerop_initialized) || (id == NULL))
+		return ret;
+
+	down(&named_opt_list_mutex);
+
+	list_for_each_entry_safe(opt, tmpopt, &named_opt_list, node) {
+		if (strcmp(kobject_name(&opt->kobj), id) == 0) {
+			/* FIXME: can't remove a point if it's the active */
+			list_del(&opt->node);
+			powerop_sysfs_unregister_point(opt);
+			kfree(opt->md_opt);
+			kfree(opt);
+			ret = 0;
+			break;
+		}
+	}
+
+	for (i = 0; i < registered_opt_number; i++) {
+		if (strcmp(registered_names[registered_opt_number], id) == 0) {
+			kfree(registered_names[i]);
+			registered_names[i] =
+			    registered_names[registered_opt_number];
+			break;
+		}
+	}
+	registered_opt_number++;
+	up(&named_opt_list_mutex);
+
+	blocking_notifier_call_chain(&powerop_notifier_list,
+				     POWEROP_UNREGISTER_EVENT, id);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(powerop_unregister_point);
+
+
+static inline int find_point(const char *id, struct powerop_point **opt)
+{
+	int rc = -EINVAL;
+	struct powerop_point *tmp;
+
+	list_for_each_entry(tmp, &named_opt_list, node) {
+		if (strcmp(kobject_name(&tmp->kobj), id) == 0) {
+			rc = 0;
+			*opt = tmp;
+			break;
+		}
+	}
+
+	return rc;
+}
+
+/** 
+ * powerop_set_point - set systems to the operating point
+ * @id: name of operating point
+ *
+ * Search for operating point with specified name and switch the system to the
+ * specified operating point. Returns zero on success, -EINVAL if no operating
+ * point with specified name is found or error code otherwise
+ */
+int powerop_set_point(const char *id)
+{
+	struct powerop_point *selected_opt;
+	int rc;
+
+	if ((!powerop_initialized) || (id == NULL))
+		return -EINVAL;
+
+	down(&named_opt_list_mutex);
+
+	rc = find_point(id, &selected_opt);
+	if (rc == 0) {
+		rc = set_point(selected_opt->md_opt);
+		if (rc == 0)
+			powerop_sysfs_set_activeop(id);
+	}
+		
+	up(&named_opt_list_mutex);
+
+	return rc;
+}
+EXPORT_SYMBOL_GPL(powerop_set_point);
+
+/** 
+ * powerop_get_point - get operating point power parameter values
+ * @id: name of operating point or NULL to get values for current active
+ * operating point
+ * @pwr_params: array of {power parameter name, result placeholder} pairs
+ * @size: size od 'pwr_params' array
+ *
+ * Search for operating point with specified name 
+ * and return value of power parameters corresponding to the operating point.
+ * NULL name is reserved to get power parameter values of current active
+ * operating point (from hardware). Returns zero on success, -EINVAL if no
+ * operating point with specified name is found
+ */
+int powerop_get_point(const char *id, struct powerop_pwr_param *pwr_params,
+		      int size)
+{
+	int rc = -EINVAL;
+	struct powerop_point *opt;
+	void *md_opt = NULL;
+
+	if (!powerop_initialized)
+		return rc;
+
+	down(&named_opt_list_mutex);
+
+	/* FIXME: get rid of sema for NULL case */
+	if (id != NULL) {
+		rc = find_point(id, &opt);
+		if (rc != 0)
+			goto out;
+		md_opt = opt->md_opt;
+	}
+
+	rc = access_point(md_opt, pwr_params, size, POWEROP_GET_PARAMS);
+
+out:
+	up(&named_opt_list_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(powerop_get_point);
+
+int powerop_set_pwr_params(const char *id,
+			   struct powerop_pwr_param *pwr_params,
+			   int size)
+{
+	int rc = -EINVAL;
+	struct powerop_point *opt;
+
+	down(&named_opt_list_mutex);
+
+	rc = find_point(id, &opt);
+	if (rc == 0)
+		rc = access_point(opt->md_opt, pwr_params, size,
+				  POWEROP_SET_PARAMS);
+
+	up(&named_opt_list_mutex);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(powerop_set_pwr_params);
+
+/** 
+ * powerop_get_registered_opt_names - get registered operating point names list
+ * @opt_names_list: array of pointers to name strings
+ * @num: array size
+ *
+ */
+int powerop_get_registered_opt_names(char *opt_names_list[], int *num)
+{
+	down(&named_opt_list_mutex);
+	opt_names_list = registered_names;
+	*num = registered_opt_number;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(powerop_get_registered_opt_names);
+
+void powerop_put_registered_opt_names(char *opt_names_list[])
+{
+	up(&named_opt_list_mutex);
+}
+EXPORT_SYMBOL_GPL(powerop_put_registered_opt_names);
+
+int powerop_register_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&powerop_notifier_list, nb);
+}
+EXPORT_SYMBOL(powerop_register_notifier);
+
+int powerop_unregister_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_unregister(&powerop_notifier_list, nb);
+}
+EXPORT_SYMBOL(powerop_unregister_notifier);
+
+static int __init powerop_init(void)
+{
+	int rc = 0;
+
+	INIT_LIST_HEAD(&named_opt_list);
+	rc = powerop_sysfs_init();
+	if (rc == 0)
+		powerop_initialized = 1;
+
+	return rc;
+}
+
+static void __exit powerop_exit(void)
+{
+	struct powerop_point *opt, *tmp_opt;
+
+	down(&named_opt_list_mutex);
+
+	list_for_each_entry_safe(opt, tmp_opt, &named_opt_list, node) {
+		list_del(&opt->node);
+		powerop_sysfs_unregister_point(opt);
+		kfree(opt->md_opt);
+		kfree(opt);
+	}
+
+	up(&named_opt_list_mutex);
+	powerop_sysfs_exit();
+}
+
+module_init(powerop_init);
+module_exit(powerop_exit);
+
+MODULE_DESCRIPTION("PowerOP Core");
+MODULE_LICENSE("GPL");
diff --git a/kernel/power/powerop_point.h b/kernel/power/powerop_point.h
new file mode 100644
index 0000000..64b5591
--- /dev/null
+++ b/kernel/power/powerop_point.h
@@ -0,0 +1,36 @@
+/*
+ * PowerOP core non-public header
+ *
+ * Author: Eugeny S. Mints <eugeny.@nomadgs.com>
+ *
+ * 2006 (C) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Based on ideas and code by Todd Poynor <tpoynor@mvista.com>
+ */
+#ifndef __POWEROP_INT_H__
+#define __POWEROP_INT_H__
+
+#define POWEROP_MAX_OPT_NAME_LENGTH 32
+
+/**
+ * struct powerop_point - PowerOP Core representation of operating point
+ * @kobj: hook to reference an operating point in some arch independent way
+ * (for ex. sysfs)
+ * @md_opt: pointer to opaque arch dependent set of power parameters
+ *
+ */
+struct powerop_point {
+	struct kobject kobj;
+	void *md_opt;
+	struct list_head node;
+#ifdef CONFIG_POWEROP_SYSFS
+	struct completion released;
+#endif
+};
+
+#define to_namedop(_kobj) container_of(_kobj, struct powerop_point, kobj)
+
+#endif /* __POWEROP_INT_H__ */
diff --git a/kernel/power/powerop_sysfs.c b/kernel/power/powerop_sysfs.c
new file mode 100644
index 0000000..7770563
--- /dev/null
+++ b/kernel/power/powerop_sysfs.c
@@ -0,0 +1,255 @@
+/*
+ * PowerOP sysfs UI
+ *
+ * Author: Todd Poynor <tpoynor@mvista.com>
+ *
+ * Integration with updated PowerOP interface by 
+ * Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/powerop.h>
+#include <linux/powerop_sysfs.h>
+
+#include "powerop_sysfs_point.h"
+
+#define POWEROP_SYSFS_HW_OPT "hw"
+
+extern struct subsystem power_subsys;
+
+static DECLARE_MUTEX(activeop_mutex);
+static char activeop[POWEROP_MAX_OPT_NAME_LENGTH];
+
+#define powerop_attr(_name) \
+static struct subsys_attribute _name##_attr = { \
+	.attr   = {				\
+		.name = __stringify(_name),	\
+		.mode = 0644,			\
+		.owner = THIS_MODULE,		\
+	},					\
+	.show   = _name##_show,                 \
+	.store  = _name##_store,                \
+}
+
+static struct attribute_group platform_param_attr_group;
+
+static void powerop_sysfs_point_release(struct kobject *kobj)
+{
+	struct powerop_point *op = to_namedop(kobj);
+
+	complete(&op->released);
+	return;
+}
+
+static ssize_t
+powerop_sysfs_pwr_param_attr_show(struct kobject *kobj, struct attribute *attr,
+				  char *buf)
+{
+	struct powerop_point *opt = to_namedop(kobj);
+	struct powerop_pwr_param pwr_param;
+	ssize_t ret = 0;
+
+	pwr_param.attr = attr;
+#ifdef CONFIG_POWEROP_SYSFS_OP_DEBUG_IF
+	if (strcmp(kobject_name(&opt->kobj), POWEROP_SYSFS_HW_OPT) == 0)
+		ret = powerop_get_point(NULL, &pwr_param, 1);
+	else
+#endif				/* CONFIG_POWEROP_SYSFS_OP_DEBUG_IF */
+		ret = powerop_get_point(kobject_name(&opt->kobj), &pwr_param,
+					1);
+
+	return ret ? 0 : sprintf(buf, "%d\n", pwr_param.value);
+}
+
+static ssize_t
+powerop_sysfs_pwr_param_attr_store(struct kobject *kobj,
+				   struct attribute *attr, const char *buf,
+				   size_t count)
+{
+#ifdef CONFIG_POWEROP_SYSFS_OP_CREATE
+	struct powerop_pwr_param pwr_param;
+	struct powerop_point *opt = to_namedop(kobj);
+	ssize_t ret = 0;
+
+#ifdef CONFIG_POWEROP_SYSFS_OP_DEBUG_IF
+	if (strcmp(kobject_name(&opt->kobj), POWEROP_SYSFS_HW_OPT) == 0)
+		return -EINVAL;
+#endif				/* CONFIG_POWEROP_SYSFS_OP_DEBUG_IF */
+	if ((ret = sscanf(buf, "%d", &pwr_param.value)) == 1) {
+		pwr_param.attr = attr;
+		ret = powerop_set_pwr_params(kobject_name(&opt->kobj),
+					    &pwr_param, 1);
+		if (ret == 0) 
+			return count;
+	}
+
+	return ret;
+#else
+	return -ENOTSUPP;
+#endif				/* CONFIG_POWEROP_SYSFS_OP_CREATE */
+}
+
+static struct sysfs_ops powerop_sysfs_ops = {
+	.show = powerop_sysfs_pwr_param_attr_show,
+	.store = powerop_sysfs_pwr_param_attr_store,
+};
+
+static struct kobj_type ktype_powerop_point = {
+	.release = powerop_sysfs_point_release,
+	.sysfs_ops = &powerop_sysfs_ops,
+};
+
+#ifdef CONFIG_POWEROP_SYSFS_OP_CREATE
+static ssize_t new_show(struct subsystem *subsys, char *buf)
+{
+	return 0;
+}
+
+static ssize_t new_store(struct subsystem *subsys, const char *buf, size_t n)
+{
+	int rc = 0;
+
+	return ((rc = powerop_register_point(buf, NULL, 0)) == 0) ? n : rc;
+}
+
+powerop_attr(new);
+#endif				/* CONFIG_POWEROP_SYSFS_OP_CREATE */
+
+static ssize_t active_show(struct subsystem *subsys, char *buf)
+{
+	int ret = 0;
+
+	down(&activeop_mutex);
+	ret = sprintf(buf, "%s\n", activeop);
+	up(&activeop_mutex);
+
+	return ret;
+}
+
+static ssize_t active_store(struct subsystem *subsys, const char *buf,
+			    size_t n)
+{
+	int error;
+
+	return (error = powerop_set_point(buf)) == 0 ? n : error;
+}
+
+powerop_attr(active);
+
+static struct attribute *g[] = {
+#ifdef CONFIG_POWEROP_SYSFS_OP_CREATE
+	&new_attr.attr,
+#endif				/* CONFIG_POWEROP_SYSFS_OP_CREATE */
+	&active_attr.attr,
+	NULL,
+};
+
+static struct attribute_group attr_group = {
+	.attrs = g,
+};
+
+static int create_point_attrs(struct kobject *kobj)
+{
+	int error = 0;
+
+	if (platform_param_attr_group.attrs)
+		if ((error = sysfs_create_group(kobj, 
+						&platform_param_attr_group)))
+			printk(KERN_ERR
+			       "sysfs_create_group for op %s failed.\n",
+			       kobject_name(kobj));
+	return error;
+}
+
+static void remove_point_attrs(struct kobject *kobj)
+{
+	if (platform_param_attr_group.attrs)
+		sysfs_remove_group(kobj, &platform_param_attr_group);
+}
+
+int powerop_sysfs_register_point(struct powerop_point *op)
+{
+	int error;
+
+	op->kobj.ktype = &ktype_powerop_point;
+	op->kobj.kset = &power_subsys.kset;
+	init_completion(&op->released);
+
+	if ((error = kobject_register(&op->kobj))) {
+		printk(KERN_ERR "PowerOP kobject_register for op %s failed.\n",
+		       kobject_name(&op->kobj));
+		return error;
+	}
+
+	/* FIXME: check rc */
+	create_point_attrs(&op->kobj);
+	return 0;
+}
+
+void powerop_sysfs_unregister_point(struct powerop_point *op)
+{
+	remove_point_attrs(&op->kobj);
+	kobject_unregister(&op->kobj);
+	wait_for_completion(&op->released);
+}
+
+void powerop_sysfs_set_activeop(const char *id)
+{
+	down(&activeop_mutex);
+	strcpy(activeop, id);
+	up(&activeop_mutex);
+}
+
+int powerop_sysfs_register_pwr_params(struct attribute **param_attrs)
+{
+	if (platform_param_attr_group.attrs)
+		return -EBUSY;
+
+	platform_param_attr_group.attrs = param_attrs;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(powerop_sysfs_register_pwr_params);
+
+void powerop_sysfs_unregister_pwr_params(struct attribute **param_attrs)
+{
+	if (platform_param_attr_group.attrs != param_attrs)
+		return;
+
+	platform_param_attr_group.attrs = NULL;
+}
+EXPORT_SYMBOL_GPL(powerop_sysfs_unregister_pwr_params);
+
+int powerop_sysfs_init(void)
+{
+	int error;
+
+	if ((error =
+	     sysfs_create_group(&power_subsys.kset.kobj, &attr_group))) {
+		printk(KERN_ERR "PowerOP subsys sysfs_create_group failed.\n");
+		return error;
+	}
+#ifdef CONFIG_POWEROP_SYSFS_OP_DEBUG_IF
+	if (powerop_register_point(POWEROP_SYSFS_HW_OPT, NULL, 0))
+		printk(KERN_ERR "PowerOP subsys HW point creation failed\n");
+#endif
+	powerop_sysfs_set_activeop("Unknown");
+	return 0;
+}
+
+void powerop_sysfs_exit(void)
+{
+	powerop_sysfs_unregister_pwr_params(platform_param_attr_group.attrs);
+	sysfs_remove_group(&power_subsys.kset.kobj, &attr_group);
+}
diff --git a/kernel/power/powerop_sysfs_point.h b/kernel/power/powerop_sysfs_point.h
new file mode 100644
index 0000000..9c0baa9
--- /dev/null
+++ b/kernel/power/powerop_sysfs_point.h
@@ -0,0 +1,42 @@
+/*
+ * PowerOP SysFS non-public header
+ *
+ * Author: Eugeny S. Mints <eugeny.@nomadgs.com>
+ *
+ * 2006 (C) Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+#ifndef __POWEROP_SYSFS_INT_H__
+#define __POWEROP_SYSFS_INT_H__
+#include "powerop_point.h"
+
+#ifdef CONFIG_POWEROP_SYSFS
+int powerop_sysfs_register_point(struct powerop_point *opt);
+void powerop_sysfs_unregister_point(struct powerop_point *op);
+void powerop_sysfs_set_activeop(const char *id);
+int powerop_sysfs_init(void);
+void powerop_sysfs_exit(void);
+#else
+static inline int powerop_sysfs_register_point(struct powerop_point *opt)
+{
+	return 0;
+}
+static inline int powerop_sysfs_unregister_point(struct powerop_point *opt)
+{
+	return 0;
+}
+static inline void powerop_sysfs_set_activeop(const char *id)
+{
+}
+static inline int powerop_sysfs_init(void)
+{
+	return 0;
+}
+static inline void powerop_sysfs_exit(void)
+{
+}
+#endif /* CONFIG_POWEROP_SYSFS */
+
+#endif /* __POWEROP_SYSFS_INT_H__ */
