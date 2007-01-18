Return-Path: <linux-kernel-owner+w=401wt.eu-S932443AbXART3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbXART3O (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 14:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbXART3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 14:29:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:60089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932443AbXART3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 14:29:12 -0500
X-Authenticated: #14842415
From: Alessandro Di Marco <dmr@gmx.it>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] System Inactivity Monitor v1.0
Date: Thu, 18 Jan 2007 20:29:03 +0100
Message-ID: <877ivkrv5s.fsf@gmx.it>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all,

this is a new 2.6.20 module implementing a user inactivity trigger. Basical=
ly
it acts as an event sniffer, issuing an ACPI event when no user activity is
detected for more than a certain amount of time. This event can be successi=
vely
grabbed and managed by an user-level daemon such as acpid, blanking the scr=
een,
dimming the lcd-panel light =E0 la mac, etc...

For the interested guys I have included a bash configuration helper (called
gentable) that covers the details.

Best,


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=sin.patch
Content-Description: System Inactivity Monitor v1.0

diff -uN SIN/Makefile SIN.new/Makefile
--- SIN/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/Makefile	2007-01-18 19:20:59.000000000 +0100
@@ -0,0 +1,41 @@
+MODLPATH = kernel/drivers/char
+
+MODL = sinmod
+OBJS = sin.o procfs.o table.o input_enumerator.o acpi_enumerator.o
+
+SRCS := $(patsubst %.o,%.c,$(OBJS))
+HDRS := $(patsubst %.o,%.h,$(OBJS))
+CMDS := $(patsubst %.o,.%.o.cmd,$(OBJS))
+
+ifneq ($(KERNELRELEASE),)
+	EXTRA_CFLAGS := $(DEBUG)
+	obj-m := $(MODL).o
+	$(MODL)-objs := $(OBJS)
+else
+	KDIR := /lib/modules/$(shell uname -r)/build
+	PWD := $(shell pwd)
+
+all:	$(MODL).ko
+
+$(MODL).ko:	$(SRCS) $(HDRS)
+	@$(MAKE) -C $(KDIR) M=$(PWD) modules
+
+im:	$(MODL).ko
+	@sudo insmod $(MODL).ko
+
+rm:
+	@sudo rmmod $(MODL)
+
+rmf:
+	@sudo rmmod -f $(MODL)
+
+install:
+	@sudo $(MAKE) INSTALL_MOD_DIR=$(MODLPATH) -C $(KDIR) M=$(PWD) modules_install
+
+modules_install:
+	@$(MAKE) INSTALL_MOD_DIR=$(MODLPATH) -C $(KDIR) M=$(PWD) modules_install
+
+clean:
+	@$(MAKE) -C $(KDIR) M=$(PWD) clean
+	@rm -f Module.symvers
+endif
diff -uN SIN/acpi_enumerator.c SIN.new/acpi_enumerator.c
--- SIN/acpi_enumerator.c	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/acpi_enumerator.c	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,114 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/acpi.h>
+
+#include "acpi_enumerator.h"
+
+static struct acpi_handlers *ah;
+static int ahsize;
+
+static char *page;
+static size_t size;
+
+int get_handlers(void)
+{
+	return ahsize;
+}
+
+char *get_hardware_id(int handle)
+{
+	return ah[handle].hardware_id;
+}
+
+static int acpi_store(struct acpi_device *device, struct acpi_driver *driver)
+{
+	if (device->flags.hardware_id) {
+		strcpy(ah[ahsize++].hardware_id,
+		       acpi_device_hid(device));
+	}
+
+	return -ENOENT;
+}
+
+static int acpi_show(struct acpi_device *device, struct acpi_driver *driver)
+{
+	if (device->flags.hardware_id && size < PAGE_SIZE) {
+		int err;
+
+		err = snprintf(&page[size],
+			       PAGE_SIZE - size,
+			       "%d: %s [%s, %lx]\n",
+			       ahsize++,
+			       acpi_device_hid(device),
+			       acpi_device_bid(device),
+			       acpi_device_adr(device));
+
+		if (err >= PAGE_SIZE - size) {
+			err = PAGE_SIZE - size;
+		}
+
+		if (err > 0) {
+			size += err;
+		}
+	}
+
+	return -ENOENT;
+}
+
+int acpi_enum(char *buf)
+{
+	struct acpi_driver ad;
+
+	page = buf;
+
+	ad.ops.match = acpi_show;
+	(void) acpi_bus_register_driver(&ad);
+	acpi_bus_unregister_driver(&ad);
+
+	if (!ahsize) {
+		printk(KERN_NOTICE "no acpi handlers found\n");
+		return -ENODEV;
+	}
+
+	ah = kmalloc(ahsize * sizeof (struct acpi_handlers), GFP_KERNEL);
+
+	ahsize = 0;
+
+	if (!ah) {
+		return -ENOMEM;
+	}
+
+	ad.ops.match = acpi_store;
+	(void) acpi_bus_register_driver(&ad);
+	acpi_bus_unregister_driver(&ad);
+
+	return size;
+}
+
+void free_acpi_enum(void)
+{
+	if (ahsize) {
+		ahsize = 0;
+		kfree(ah);
+	}
+}
diff -uN SIN/acpi_enumerator.h SIN.new/acpi_enumerator.h
--- SIN/acpi_enumerator.h	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/acpi_enumerator.h	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,36 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef ACPI_ENUMERATOR_H
+#define ACPI_ENUMERATOR_H
+
+#include <acpi/acpi_bus.h>
+
+struct acpi_handlers {
+	acpi_hardware_id hardware_id;
+};
+
+extern int get_handlers(void);
+extern char *get_hardware_id(int handle);
+extern int acpi_enum(char *page);
+extern void free_acpi_enum(void);
+
+#endif /* ACPI_ENUMERATOR_H */
diff -uN SIN/gentable SIN.new/gentable
--- SIN/gentable	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/gentable	2007-01-18 19:21:06.000000000 +0100
@@ -0,0 +1,170 @@
+#!/bin/bash
+
+# This file is part of SIN.
+#
+# SIN is free software; you can redistribute it and/or modify it under the
+# terms of the GNU General Public License as published by the Free Software
+# Foundation; version 2 of the License.
+#
+# SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
+# A PARTICULAR PURPOSE.  See the GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License along with
+# SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin St,
+# Fifth Floor, Boston, MA 02110-1301 USA
+
+function input {
+    echo -n -e "$1 "
+    read -r $2
+}
+
+if (( $# == 0 )); then
+   echo "$0 <table>"
+   exit
+fi
+
+if [ ! -d "/proc/sin" ]; then
+    echo "/proc/sin not found, has sinmod been loaded?"
+    exit
+fi
+
+cat <<EOF
+
+SIN wakes up periodically and checks for user activity occurred in the
+meantime; this options lets you to specify how much frequently SIN should be
+woken-up. Its value is expressed in tenth of seconds.
+
+EOF
+
+input "Pace ticks?" pace
+
+if [ -z "${pace}" ]; then
+    pace="10"
+fi
+
+cat <<EOF
+
+Asleep or not, SIN constantly monitors the input devices searching for user
+activity. This option lets you choose which device have to be monitored. At
+least one device is needed and please avoid the duplicates.
+
+EOF
+
+echo -e "Specify the the input devices you want to monitor from the list below:\n"
+cat /proc/sin/input
+
+echo
+input "Please digit the corresponding numbers separated by spaces" devs
+
+if [ -z "${devs}" ]; then
+    devs="0"
+fi
+
+devices=(${devs})
+
+cat <<EOF
+
+SIN produces ACPI events depending on the user activity. To do this you have to
+specify a suitable handler that will be used as originator.
+
+EOF
+
+echo -e "Specify the acpi handler you want to use from the list below:\n"
+cat /proc/sin/acpi
+
+echo
+input "Please digit the corresponding number" handle
+
+if [ -z "${handle}" ]; then
+    handle="0"
+fi
+
+cat <<EOF
+
+SIN produces events in base to rules. Each rule is a triple composed by a
+"counter", a "type" and a "data". Once awaken, a global counter is increased if
+SIN detects no user activity and reset to zero, otherwise. When this global
+counter reaches the value specified in the counter field of a rule, an event is
+generated with the corresponding "type" and "data". Clearly, different rules
+should have different "type" and "data" fields to convey different signals to
+the user space daemon.
+
+For example, the rule "60 1 19" produces the ACPI event "XXXX 00000001
+00000019" right after one minute of user inactivity (assuming pace=10.)
+
+Please specify each rule as a space-separated triple; to finish just press
+enter.
+
+EOF
+
+for (( i = 0; ; i++ )); do
+    input "Rule ${i}?" rule
+
+    if [ -z "${rule}" ] ; then
+	break;
+    fi
+
+    rules[${i}]=${rule}
+done
+
+if (( ${i} == 0 )); then
+    rules[0]="60 1 2"
+fi
+
+cat <<EOF
+
+A special event has been provided to better help those of us who wanna use SIN
+as a screen-blanker. It will be generated as soon as some user activity is
+detected, but only after one or more rule have been triggered.
+
+EOF
+
+input "Special event \"type\" and \"data\"?" resume
+
+if [ -z "${resume}" ]; then
+    resume="2 1"
+fi
+
+cat <<EOF
+
+Usually a rule-list terminates with dead-end actions such as suspend or
+hibernate, requiring the user interaction to wake-up the system. Unfortunately
+this activity occurs when SIN, as well as the kernel, are not ready to capture
+these events yet. As a consequence, no special event will ever be generated and
+the system will remain in the state associated with the next-to-last rule
+(e.g. blanked screen, wireless powered off, etc.) In such cases this field
+forces the special event generation, resetting simultaneously the global
+counter to an arbitrary value, so to reinstate the rule-list evaluation to the
+beginning. Possible value ranges are described below, where N is the maximum
+counter in the rule list:
+
+    [0, N]    => reset the global counter to the specified value
+    otherwise => do nothing, the global counter goes on and on and on...
+
+EOF
+
+input "Reset value?" reset
+
+if [ -z "${reset}" ]; then
+    reset="-1"
+fi
+
+echo -e "0\n${pace}\n${#devices[@]} ${#rules[@]}\n${devices[@]}\n${handle}\n${reset}\n${resume}" > $1
+
+for (( i = 0; ${i}<${#rules[@]}; i++ )); do
+    echo "${rules[${i}]}" >> $1
+done
+
+cat <<EOF
+
+All done. Now you can try your newly generated table as follows:
+
+# modprobe sinmod
+# echo $1 >/proc/sin/table
+
+An "Invalid argument" error signals a mismatch in the table file, usually due
+to wrong acpi or input device specified. In these cases restart from scratch
+double checking your answers. Have fun!
+
+EOF
diff -uN SIN/input_enumerator.c SIN.new/input_enumerator.c
--- SIN/input_enumerator.c	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/input_enumerator.c	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,180 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+
+#include "input_enumerator.h"
+
+static struct input_devices *id;
+static int idsize;
+
+static char *page;
+static size_t size;
+
+int get_devices(void)
+{
+	return idsize;
+}
+
+void fill_input_device(struct input_device_id *idi, int device)
+{
+	idi->flags = MATCH_MODEL;
+
+	idi->bustype = id[device].bustype;
+	idi->vendor = id[device].vendor;
+	idi->product = id[device].product;
+	idi->version = id[device].version;
+}
+
+static struct input_handle *input_store(struct input_handler *handler,
+					struct input_dev *dev,
+					const struct input_device_id *idi)
+{
+	if (dev->name || dev->phys || dev->uniq) {
+		struct input_devices *idev = &id[idsize++];
+
+		idev->bustype = dev->id.bustype;
+		idev->vendor = dev->id.vendor;
+		idev->product = dev->id.product;
+		idev->version = dev->id.version;
+	}
+
+	return NULL;
+}
+
+static struct input_handle *input_show(struct input_handler *handler,
+				       struct input_dev *dev,
+				       const struct input_device_id *idi)
+{
+	const int left = PAGE_SIZE - size;
+
+	int flags = 0;
+	int err;
+
+	flags |= dev->name ? 1 : 0;
+	flags |= dev->phys ? 2 : 0;
+	flags |= dev->uniq ? 4 : 0;
+
+	switch (flags) {
+	case 7:
+		err = snprintf(&page[size], left,
+			       "%d: %s [%s #%s]\n",
+			       idsize, dev->name, dev->phys, dev->uniq);
+		break;
+
+	case 6:
+		err = snprintf(&page[size], left,
+			       "%d: [%s #%s]\n",
+			       idsize, dev->phys, dev->uniq);
+		break;
+
+	case 5:
+		err = snprintf(&page[size], left,
+			       "%d: %s [#%s]\n",
+			       idsize, dev->name, dev->uniq);
+		break;
+
+	case 4:
+		err = snprintf(&page[size], left,
+			       "%d: [#%s]\n",
+			       idsize, dev->uniq);
+		break;
+
+	case 3:
+		err = snprintf(&page[size], left,
+			       "%d: %s [%s]\n",
+			       idsize, dev->name, dev->phys);
+		break;
+
+	case 2:
+		err = snprintf(&page[size], left,
+			       "%d: [%s]\n",
+			       idsize, dev->phys);
+		break;
+
+	case 1:
+		err = snprintf(&page[size], left,
+			       "%d: %s\n",
+			       idsize, dev->name);
+		break;
+
+	default:
+		goto skip;
+	}
+
+	idsize++;
+
+	if (err >= left) {
+		err = left;
+	}
+
+	if (err > 0) {
+		size += err;
+	}
+
+skip:
+	return NULL;
+}
+
+int input_enum(char *buf)
+{
+	const struct input_device_id idi[] = {
+		{ .driver_info = 1 },	/* matches all devices */
+		{ },
+	};
+
+	struct input_handler ih = {
+		.name =		"input enumerator",
+		.id_table =	idi,
+	};
+
+	page = buf;
+
+	ih.connect = input_show;
+	(void) input_register_handler(&ih);
+
+	if (!idsize) {
+		printk(KERN_NOTICE "no input devices found\n");
+		return -ENODEV;
+	}
+
+	id = kmalloc(idsize * sizeof (struct input_devices), GFP_KERNEL);
+
+	idsize = 0;
+
+	if (!id) {
+		return -ENOMEM;
+	}
+
+	ih.connect = input_store;
+	(void) input_register_handler(&ih);
+
+	return size;
+}
+
+void free_input_enum(void)
+{
+	if (idsize) {
+		idsize = 0;
+		kfree(id);
+	}
+}
diff -uN SIN/input_enumerator.h SIN.new/input_enumerator.h
--- SIN/input_enumerator.h	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/input_enumerator.h	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,45 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef INPUT_ENUMERATOR_H
+#define INPUT_ENUMERATOR_H
+
+#include <linux/input.h>
+
+struct input_devices {
+	__u16 bustype;
+	__u16 vendor;
+	__u16 product;
+	__u16 version;
+};
+
+#define MATCH_MODEL (INPUT_DEVICE_ID_MATCH_BUS		\
+		     |INPUT_DEVICE_ID_MATCH_VENDOR	\
+		     |INPUT_DEVICE_ID_MATCH_PRODUCT	\
+		     |INPUT_DEVICE_ID_MATCH_VERSION)
+
+extern int get_devices(void);
+extern void fill_input_device(struct input_device_id *idi, int i);
+
+extern int input_enum(char *page);
+extern void free_input_enum(void);
+
+#endif /* INPUT_ENUMERATOR_H */
diff -uN SIN/procfs.c SIN.new/procfs.c
--- SIN/procfs.c	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/procfs.c	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,215 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/proc_fs.h>
+#include <linux/uaccess.h>
+
+#include "sin.h"
+#include "table.h"
+#include "procfs.h"
+#include "acpi_enumerator.h"
+#include "input_enumerator.h"
+
+static struct procfs_bs ibs, abs, tbs;
+static struct proc_dir_entry *rootdir;
+
+static int read_proc(char *page, char **start,
+		     off_t off, int count, int *eof, void *data)
+{
+	struct procfs_bs *bs = data;
+	int left = bs->size - off;
+
+	if (count > left) {
+		count = left;
+	}
+
+	memcpy(page + off, bs->page, count);
+
+	if (!count) {
+		*eof = 1;
+	}
+
+	return off + count;
+}
+
+static int write_proc(struct file *file, const __user char *ubuf,
+		      unsigned long count, void *data)
+{
+	struct procfs_bs *bs = data;
+	char *buf;
+	int err;
+
+	buf = kmalloc(count * sizeof (char), GFP_KERNEL);
+	if (!buf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(buf, ubuf, count + 1)) {
+		err = -EFAULT;
+		goto cleanout;
+	}
+
+	buf[count] = '\0';
+
+	err = push_table(buf, count);
+	if (err < 0) {
+		goto cleanout;
+	}
+
+	kfree(bs->page);
+
+	bs->size = pull_table(&bs->page);
+	if (bs->size < 0) {
+		err = bs->size;
+	}
+
+cleanout:
+	kfree(buf);
+out:
+	return err;
+}
+
+int start_procfs(void)
+{
+	struct proc_dir_entry *inputd, *acpid, *table, *ilink, *alink;
+
+	int err = -ENOMEM;
+
+	ibs.page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!ibs.page) {
+		goto out;
+	}
+
+	ibs.size = input_enum(ibs.page);
+	if (ibs.size < 0) {
+		err = ibs.size;
+		goto cleanout1;
+	}
+
+	abs.page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!abs.page) {
+		goto cleanout2;
+	}
+
+	abs.size = acpi_enum(abs.page);
+	if (abs.size < 0) {
+		err = abs.size;
+		goto cleanout3;
+	}
+
+	tbs.size = sizeof RT_HELP;
+
+	tbs.page = kmalloc(tbs.size, GFP_KERNEL);
+	if (!tbs.page) {
+		goto cleanout4;
+	}
+
+	memcpy(tbs.page, RT_HELP, tbs.size);
+
+	rootdir = proc_mkdir(MODULE_NAME, NULL);
+	if (!rootdir) {
+		goto cleanout5;
+	}
+
+	rootdir->owner = THIS_MODULE;
+
+	inputd = create_proc_read_entry("input", 0444,
+					rootdir, read_proc, &ibs);
+	if (!inputd) {
+		goto cleanout6;
+	}
+
+	inputd->owner = THIS_MODULE;
+
+	acpid = create_proc_read_entry("acpi", 0444,
+				       rootdir, read_proc, &abs);
+	if (!acpid) {
+		goto cleanout7;
+	}
+
+	acpid->owner = THIS_MODULE;
+
+	table = create_proc_entry("table", 0644, rootdir);
+	if (!table) {
+		goto cleanout8;
+	}
+
+	table->data = &tbs;
+	table->read_proc = read_proc;
+	table->write_proc = write_proc;
+	table->owner = THIS_MODULE;
+
+	ilink = proc_symlink("sources", rootdir, "input");
+	if (!ilink) {
+		goto cleanout9;
+	}
+
+	ilink->owner = THIS_MODULE;
+
+	alink = proc_symlink("destinations", rootdir, "acpi");
+	if (!alink) {
+		goto cleanout10;
+	}
+
+	alink->owner = THIS_MODULE;
+
+	return 0;
+
+cleanout10:
+	remove_proc_entry("sources", rootdir);
+cleanout9:
+	remove_proc_entry("table", rootdir);
+cleanout8:
+	remove_proc_entry("acpi", rootdir);
+cleanout7:
+	remove_proc_entry("input", rootdir);
+cleanout6:
+	remove_proc_entry(MODULE_NAME, NULL);
+cleanout5:
+	kfree(tbs.page);
+cleanout4:
+	free_acpi_enum();
+cleanout3:
+	kfree(abs.page);
+cleanout2:
+	free_input_enum();
+cleanout1:
+	kfree(ibs.page);
+out:
+	return err;
+}
+
+void stop_procfs(void)
+{
+	remove_proc_entry("destinations", rootdir);
+	remove_proc_entry("sources", rootdir);
+	remove_proc_entry("table", rootdir);
+	remove_proc_entry("acpi", rootdir);
+	remove_proc_entry("input", rootdir);
+	remove_proc_entry(MODULE_NAME, NULL);
+	kfree(tbs.page);
+	free_acpi_enum();
+	kfree(abs.page);
+	free_input_enum();
+	kfree(ibs.page);
+}
diff -uN SIN/procfs.h SIN.new/procfs.h
--- SIN/procfs.h	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/procfs.h	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,35 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of Procfs.
+ *
+ *  Procfs is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  Procfs is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with Procfs; if not, write to the Free Software Foundation, Inc., 51
+ *  Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef PROCFS_H
+#define PROCFS_H
+
+#define RT_HELP "<debug>\n<pace>\n<N> <M>\n<input1> ... <inputN>\n<acpi>\n<reset>\n<special type> <special data>\n<counter1> <type1> <data1>\n...\n<counterM> <typeM> <dataM>\n"
+
+struct procfs_bs {
+	char *page;
+	int size;
+};
+
+extern int start_procfs(void);
+extern void stop_procfs(void);
+
+#endif /* PROCFS_H */
diff -uN SIN/sin.c SIN.new/sin.c
--- SIN/sin.c	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/sin.c	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,190 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/acpi.h>
+#include <linux/mutex.h>
+
+#include "sin.h"
+#include "table.h"
+#include "procfs.h"
+
+MODULE_AUTHOR("Alessandro Di Marco <dmr@c0nc3pt.com>");
+MODULE_DESCRIPTION("System Inactivity Notifier");
+MODULE_LICENSE("GPL v2");
+
+MODULE_ALIAS("blanker");
+
+MODULE_VERSION("1.0");
+
+static struct acpi_device *acpi_device;
+
+static atomic_t interactions;
+static unsigned long notify;
+
+static struct timer_list timer;
+static int shutdown;
+
+static struct input_handler ih;
+
+static DEFINE_MUTEX(runlock);
+static int running;
+
+static void event(struct input_handle *handle,
+		  unsigned int type, unsigned int code, int value)
+{
+	if (unlikely(test_and_clear_bit(0, &notify))) {
+		clear_bit(1, &notify);
+		occasionally_generate_event(acpi_device);
+	}
+
+	atomic_inc(&interactions);
+}
+
+static struct input_handle *connect(struct input_handler *handler,
+				    struct input_dev *dev,
+				    const struct input_device_id *id)
+{
+	struct input_handle *handle;
+
+	if (!(handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL))) {
+		return NULL;
+	}
+
+	handle->handler = handler;
+	handle->dev = dev;
+	handle->name = MODULE_NAME;
+
+	input_open_device(handle);
+
+	return handle;
+}
+
+static void disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	kfree(handle);
+}
+
+void timer_fn(unsigned long pace)
+{
+	if (!shutdown) {
+		if (unlikely(test_and_clear_bit(1, &notify) &&
+			     test_and_clear_bit(0, &notify))) {
+			occasionally_generate_event(acpi_device);
+		}
+
+		timely_generate_event(acpi_device,
+				      atomic_read(&interactions), &notify);
+
+		atomic_set(&interactions, 0);
+
+		timer.expires = jiffies + pace;
+		add_timer(&timer);
+	}
+}
+
+static int acpi_match(struct acpi_device *device, struct acpi_driver *driver)
+{
+	if (device->flags.hardware_id &&
+	    strstr(driver->ids, device->pnp.hardware_id)) {
+		acpi_device = device;
+	}
+
+	return -ENOENT;
+}
+
+int start_monitor(char *ids, struct input_device_id *idi, unsigned long pace)
+{
+	struct acpi_driver ad = {
+		.ids = ids,
+		.ops = { .match = acpi_match }
+	};
+
+	int err;
+
+	mutex_lock(&runlock);
+
+	atomic_set(&interactions, 0);
+	notify = 0;
+
+	if (acpi_bus_register_driver(&ad) < 0 || !acpi_device) {
+		printk("couldn't find system ACPI device\n");
+		return -ENODEV;
+	}
+
+	acpi_bus_unregister_driver(&ad);
+
+	ih.event = event;
+	ih.connect = connect;
+	ih.disconnect =	disconnect;
+	ih.name = MODULE_NAME;
+	ih.id_table = idi;
+
+	err = input_register_handler(&ih);
+	if  (err < 0) {
+		return err;
+	}
+
+	setup_timer(&timer, timer_fn, pace);
+
+	timer.expires = jiffies + pace;
+
+	shutdown = 0;
+	add_timer(&timer);
+
+	running = 1;
+
+	mutex_unlock(&runlock);
+
+	return 0;
+}
+
+void stop_monitor(void)
+{
+	mutex_lock(&runlock);
+
+	if (running) {
+		shutdown = 1;
+		del_timer_sync(&timer);
+		input_unregister_handler(&ih);
+		kfree(ih.id_table);
+		running = 0;
+	}
+
+	mutex_unlock(&runlock);
+}
+
+static int __init sih_init(void)
+{
+	printk("System Inactivity Notifier 1.0 - (c) Alessandro Di Marco <dmr@c0nc3pt.com>\n");
+	return start_procfs();
+}
+
+static void __exit sih_exit(void)
+{
+	stop_procfs();
+	stop_monitor();
+}
+
+module_init(sih_init);
+module_exit(sih_exit);
diff -uN SIN/sin.h SIN.new/sin.h
--- SIN/sin.h	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/sin.h	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,32 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef SIN_H
+#define SIN_H
+
+#include <linux/input.h>
+
+#define MODULE_NAME "sin"
+
+extern int start_monitor(char *ids, struct input_device_id *idi, unsigned long pace);
+extern void stop_monitor(void);
+
+#endif /* SIN_H */
diff -uN SIN/table.c SIN.new/table.c
--- SIN/table.c	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/table.c	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,274 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/acpi.h>
+#include <linux/sort.h>
+
+#include "sin.h"
+#include "uniq.h"
+#include "table.h"
+
+#include "input_enumerator.h"
+#include "acpi_enumerator.h"
+
+static struct table rt;
+static int debug;
+
+/*
+ * WARNING: sonypi, buttons and others issue a spurious event when removed from
+ * the system, fooling the event counter. Make sure to _not_ remove them in
+ * event service routines (e.g. /etc/acpid/default.sh).
+ */
+
+void occasionally_generate_event(struct acpi_device *acpi_device)
+{
+	if (unlikely(debug)) {
+		printk("generating special event [%d, %d]\n",
+		       rt.rules[rt.rnum].type, rt.rules[rt.rnum].data);
+	}
+
+	(void) acpi_bus_generate_event(acpi_device, rt.rules[rt.rnum].type,
+				       rt.rules[rt.rnum].data);
+}
+
+void timely_generate_event(struct acpi_device *acpi_device,
+			   int interactions, unsigned long *notify)
+{
+	static int counter, action;
+
+	if (interactions && counter) {
+		if (unlikely(debug)) {
+			printk("user activity detected, counter reset!\n");
+		}
+
+		counter = action = 0;
+	}
+
+	if (unlikely(debug)) {
+		printk("global counter %d, next rule is [%d %d %d]\n",
+		       counter,
+		       rt.rules[action].counter,
+		       rt.rules[action].type,
+		       rt.rules[action].data);
+	}
+
+	while (action < rt.rnum && rt.rules[action].counter == counter) {
+		if (unlikely(debug)) {
+			printk("generating event [%d, %d]\n",
+			       rt.rules[action].type,
+			       rt.rules[action].data);
+		}
+
+		(void) acpi_bus_generate_event(acpi_device,
+					       rt.rules[action].type,
+					       rt.rules[action].data);
+		action++;
+		set_bit(0, notify);
+	}
+
+	if (rt.raction >= 0 && action == rt.rnum) {
+		if (unlikely(debug)) {
+			printk("last rule reached, restarting from %d\n",
+			       rt.rcounter);
+		}
+
+		counter = rt.rcounter;
+		action = rt.raction;
+		set_bit(1, notify);
+
+	} else {
+		counter++;
+	}
+}
+
+#define parse_num(endp) ({				\
+			char *cp = endp;		\
+							\
+			while (*cp && isspace(*cp)) {	\
+				++cp;			\
+			}				\
+							\
+			simple_strtol(cp, &endp, 10);	\
+		})
+
+static int cmp(const void *l, const void *r)
+{
+	int lc = ((struct rule *) l)->counter;
+	int rc = ((struct rule *) r)->counter;
+
+	return lc < rc ? -1 : lc > rc ? 1 : 0;
+}
+
+static void swap(void *l, void *r, int size)
+{
+	struct rule t = *((struct rule *) l);
+
+	*((struct rule *) l) = *((struct rule *) r);
+	*((struct rule *) r) = t;
+}
+
+int push_table(char *buf, unsigned long count)
+{
+	struct input_device_id *idi;
+	struct uniq uniq;
+	int devices;
+
+	int i, err = -ENOMEM;
+
+	devices = get_devices();
+
+	debug = parse_num(buf);
+
+	rt.pace = (parse_num(buf) * HZ) / 10;
+	rt.dnum = parse_num(buf);
+	rt.rnum = parse_num(buf);
+
+	if (out_of_range(1, rt.pace, 1000000) ||
+	    out_of_range(0, rt.dnum, devices)) {
+		err = -EINVAL;
+		goto out;
+	}
+
+	rt.devices = kmalloc(rt.dnum * sizeof (int), GFP_KERNEL);
+	if (!rt.devices) {
+		goto out;
+	}
+
+	rt.rules = kmalloc((rt.rnum + 1) * sizeof (struct rule), GFP_KERNEL);
+	if (!rt.rules) {
+		goto cleanout1;
+	}
+
+	if (uniq_alloc(&uniq, devices) < 0) {
+		goto cleanout2;
+	}
+
+	for (i = 0; i < rt.dnum; i++) {
+		rt.devices[i] = parse_num(buf);
+		if (uniq_check(&uniq, rt.devices[i])) {
+			break;
+		}
+	}
+
+	uniq_free(&uniq);
+
+	if (i < rt.dnum) {
+		err = -EINVAL;
+		goto cleanout2;
+	}
+
+	rt.handle = parse_num(buf);
+	if (out_of_range(0, rt.handle, get_handlers())) {
+		err = -EINVAL;
+		goto cleanout2;
+	}
+
+	rt.rcounter = parse_num(buf);
+
+	rt.rules[rt.rnum].counter = -1;
+	rt.rules[rt.rnum].type = parse_num(buf);
+	rt.rules[rt.rnum].data = parse_num(buf);
+
+	for (i = 0; i < rt.rnum; i++) {
+		rt.rules[i].counter = parse_num(buf);
+		if (rt.rules[i].counter < 0) {
+			err = -EINVAL;
+			goto cleanout2;
+		}
+
+		rt.rules[i].type = parse_num(buf);
+		rt.rules[i].data = parse_num(buf);
+	}
+
+	sort(rt.rules, rt.rnum, sizeof (struct rule), cmp, swap);
+
+	rt.raction = -1;
+
+	if (rt.rcounter >= 0) {
+		for (i = 0; i < rt.rnum; i++) {
+			if (rt.rules[i].counter >= rt.rcounter) {
+				rt.raction = i;
+				break;
+			}
+		}
+	}
+
+	stop_monitor();
+
+	idi = kzalloc((rt.dnum + 1) *
+		      sizeof (struct input_device_id), GFP_KERNEL);
+	if (!idi) {
+		goto cleanout2;
+	}
+
+	for (i = 0; i < rt.dnum; i++) {
+		fill_input_device(&idi[i], rt.devices[i]);
+	}
+
+	err = start_monitor(get_hardware_id(rt.handle), idi, rt.pace);
+	if (err < 0) {
+		goto cleanout3;
+	}
+
+	return count;
+
+cleanout3:
+	kfree(idi);
+cleanout2:
+	kfree(rt.rules);
+cleanout1:
+	kfree(rt.devices);
+out:
+	return err;
+}
+
+int pull_table(char **buf)
+{
+	char *b;
+	int i;
+
+	*buf = b = kmalloc(TABLE_BUFFER_SIZE, GFP_KERNEL);
+	if (!b) {
+		return -EFAULT;
+	}
+
+	b += sprintf(b, "%d\n%lu\n%d %d\n", debug,
+		     (rt.pace * 10) / HZ, rt.dnum, rt.rnum);
+
+	for (i = 0; i < rt.dnum; i++) {
+		b += sprintf(b, "%d ", rt.devices[i]);
+	}
+
+	b--;
+
+	b += sprintf(b, "\n%d\n%d\n%d %d\n",
+		     rt.handle, rt.rcounter,
+		     rt.rules[rt.rnum].type, rt.rules[rt.rnum].data);
+
+	for (i = 0; i < rt.rnum; i++) {
+		b += sprintf(b, "%d %d %d\n", rt.rules[i].counter,
+			     rt.rules[i].type, rt.rules[i].data);
+	}
+
+	return b - *buf;
+}
diff -uN SIN/table.h SIN.new/table.h
--- SIN/table.h	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/table.h	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,54 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef TABLE_H
+#define TABLE_H
+
+#include <acpi/acpi_bus.h>
+
+struct rule {
+	int counter;
+	int type;
+	int data;
+};
+
+struct table {
+	unsigned long pace;
+	int dnum, rnum;
+	int *devices;
+	int handle;
+	int rcounter, raction;
+	struct rule *rules;
+};
+
+#define TABLE_SIZE (sizeof (struct table) - 2 * sizeof (void *)	  \
+		    + rt.dnum * sizeof (int)			  \
+		    + rt.rnum * sizeof (struct rule))
+
+#define TABLE_BUFFER_SIZE (9 + rt.dnum + rt.rnum * 3 + (TABLE_SIZE << 3) / 3)
+
+extern void occasionally_generate_event(struct acpi_device *acpi_device);
+extern void timely_generate_event(struct acpi_device *acpi_device, int interactions, unsigned long *notify);
+
+extern int push_table(char *buf, unsigned long count);
+extern int pull_table(char **buf);
+
+#endif /* TABLE_H */
diff -uN SIN/uniq.h SIN.new/uniq.h
--- SIN/uniq.h	1970-01-01 01:00:00.000000000 +0100
+++ SIN.new/uniq.h	2007-01-18 19:20:53.000000000 +0100
@@ -0,0 +1,59 @@
+/*
+ *  Copyright (C) 2007 Alessandro Di Marco
+ */
+
+/*
+ *  This file is part of SIN.
+ *
+ *  SIN is free software; you can redistribute it and/or modify it under the
+ *  terms of the GNU General Public License as published by the Free Software
+ *  Foundation; version 2 of the License.
+ *
+ *  SIN is distributed in the hope that it will be useful, but WITHOUT ANY
+ *  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
+ *  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
+ *  details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with SIN; if not, write to the Free Software Foundation, Inc., 51 Franklin
+ *  St, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+
+#ifndef UNIQ_H
+#define UNIQ_H
+
+#include <linux/bitops.h>
+
+#define out_of_range(l, x, u) ((x) < (l) || (x) >= (u))
+
+struct uniq {
+	int elements;
+	unsigned long *bitmap;
+};
+
+static inline int uniq_alloc(struct uniq *ci, int elm)
+{
+	int size = (1 + elm / sizeof (unsigned long)) * sizeof (unsigned long);
+
+	ci->elements = elm;
+
+	ci->bitmap = kzalloc(size, GFP_KERNEL);
+	if (!ci->bitmap) {
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static inline void uniq_free(struct uniq *ci)
+{
+	kfree(ci->bitmap);
+}
+
+static inline int uniq_check(struct uniq *ci, int index)
+{
+	return out_of_range(0, index, ci->elements)
+		|| test_and_set_bit(index, ci->bitmap);
+}
+
+#endif /* UNIQ_H */

--=-=-=


-- 
Man is the only animal that laughs and has a state legislature. - Samuel Butler

--=-=-=--
