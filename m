Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269614AbUIRTRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269614AbUIRTRs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 15:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269617AbUIRTRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 15:17:48 -0400
Received: from locomotive.csh.rit.edu ([129.21.60.149]:59454 "EHLO
	locomotive.unixthugs.org") by vger.kernel.org with ESMTP
	id S269616AbUIRTP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 15:15:28 -0400
Message-ID: <414C8A07.5030700@suse.com>
Date: Sat, 18 Sep 2004 15:18:31 -0400
From: Jeff Mahoney <jeffm@suse.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Hotplug for openfirmware/macio devices
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------060002040203060209080306"
X-Bogosity: No, tests=bogofilter, spamicity=0.000000, version=0.92.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060002040203060209080306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hey all -

Many devices on the macintosh hardware platform are hidden behind a
macio asic that places devices beyond the PCI bus for hotplug. Loading
the driver manually works fine, but we have this wonderful hotplug
system now. Why should macio be a second class citizen?

At least for me, the most noticable one was my airport card, but there
may be others. I only have an ibook and a powermac.

Attached are three patches, which do the following:
* kernel-of-hotplug.diff; against 2.6.9-rc2 (mainline)
~   - exports OF information to userspace
~   - removes struct of_device in favor of struct of_device_id, which
~     uses character arrays such that the structure can be more easily
~     used by module-init-tools [the renaming is required to use the
~     MODULE_DEVICE_TABLE macro]
~   - changes the semantics of OF_MATCH_ANY to be an empty string
~   - adds the name, type, and compat strings to the macio sysfs tree
~   - adds a hotplug filter to pass the name, type, and compat info
~     to hotplug
~   - adds the appropriate MODULE_DEVICE_TABLE entries so that
~     module-init-tools can know about macio devices
~   - (Yes, I know this information is available via /proc/device_tree,
~      but sysfs is a much more natural fit)

* hotplug-macio.diff
~   - macio.rc: handles coldplugging of devices by traversing
~     the macio sysfs tree
~   - macio.agent: handles macio hotplug events

* module-init-tools-3.0-pre10-openfirmware.diff
~   - adds support for a modules.ofmap table so that the hotplug scripts
~     can determine which modules to load based on the OF information.

Is there a limit for the length of the various OF strings? I've assumed
32 for the sake of testing, but it's completely arbitrary.

Take a look if you're interested. My familiarity with the PPC world is
peripheral at best. I'd love feedback.

- -Jeff

- --
Jeff Mahoney
SuSE Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBTIoGLPWxlyuTD7IRAtYEAJ9Id+GpTR/CKt3DeJ3Nuo4KNAxTbQCdE/Rs
mr3A/coTxixXGohDtN2Fcro=
=xR6t
-----END PGP SIGNATURE-----

--------------060002040203060209080306
Content-Type: text/plain;
 name="hotplug-macio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hotplug-macio.diff"

--- /dev/null	2004-09-09 09:18:19.101224496 -0400
+++ /etc/hotplug/macio.rc	2004-09-09 08:41:55.000000000 -0400
@@ -0,0 +1,96 @@
+#!/bin/bash
+# $Id: ccw.rc,v 1.3 2004/05/13 11:59:50 hare Exp $
+# vim: syntax=sh
+#
+# macio.rc	configure macio devices.
+#
+
+SYSFS=needed
+cd /etc/hotplug
+. hotplug.functions
+
+if [ ! -d ${SYSFS}/bus/macio ]; then
+    echo "No macio bus support"
+    exit 0
+fi
+
+HWUP=/sbin/hwup
+macio_call_hotplug () {
+	# There may be /etc/hotplug.d/default/eventrecorder.hotplug
+	# that logs the environment of every hotplug events. Therefore
+	# we keep environment clean.
+#	echo " "\
+	eval \
+	$ENV \
+	${ACTION:+ ACTION=$ACTION} \
+	${DEVPATH:+ DEVPATH="$DEVPATH"} \
+	${OF_NAME:+ OF_NAME="$OF_NAME"} \
+	${OF_TYPE:+ OF_TYPE="$OF_TYPE"} \
+	${OF_COMPATIBLE:+ OF_COMPATIBLE="$OF_COMPATIBLE"} \
+	${HOTPLUG_TRACE:+ HOTPLUG_TRACE="$HOTPLUG_TRACE"} \
+	/sbin/hotplug macio \
+	< /dev/null > /dev/null 2>&1 & 
+}
+macio_boot_events_sysfs () {
+	cd /sys/bus/macio/devices
+	for i in *; do
+
+		if [ -d /sys/bus/macio/drivers/*/$i \
+			-a "$SKIP_DRIVEN_DEVICES" != no ]; then
+			echo -n . >&3
+		fi
+		OF_NAME=`cat $i/name`
+		OF_TYPE=`cat $i/type`
+                OF_COMPATIBLE=`cat $i/compatible`
+		DEVPATH=`cd $i/ ; /bin/pwd`
+		echo -n "*" >&3
+		macio_call_hotplug
+	done
+}
+
+macio_boot_events () {
+	macio_boot_events_sysfs
+}
+
+# See how we were called.
+case "$1" in
+  start)
+	ACTION=add
+	macio_boot_events;
+
+        # Configure all macio devices for which a hwcfg file is found
+	cd /etc/sysconfig/hardware
+        for cfg in hwcfg-bus-macio*; do
+            # Skip all symbolic links, only use the actual configuration
+            if [ -f "$cfg" -a ! -L "$cfg" ] ; then
+                cfgname=`echo $cfg | sed -n 's,hwcfg-.*-bus,bus,p;s,hwcfg-.*-id,id,p;s,hwcfg-bus,bus,p'`
+		if [ "$cfgname" ]; then
+		    debug_mesg "Calling ${HWUP} ${cfgname}"
+		    ${HWUP} ${cfgname}
+		    echo -n "*" >&3
+		else
+		    echo -n "." >&3
+		fi
+            fi
+        done
+
+	
+        ;;
+  stop)
+	# echo "$0 stop -- ignored"
+        ;;
+  status)
+	# echo "$0 status -- ignored"
+  	;;
+  status-verbose)
+	# echo "$0 status-verbose -- ignored"
+	;;
+  restart)
+	# always invoke by absolute path, else PATH=$PATH:
+	$0 stop && $0 start
+	;;
+  *)
+        echo $"Usage: $0 {start|stop|status[-verbose]|restart}"
+        exit 1
+	;;
+esac
--- /dev/null	2004-09-09 09:18:19.101224496 -0400
+++ /etc/hotplug/macio.agent	2004-09-09 09:07:58.000000000 -0400
@@ -0,0 +1,84 @@
+#!/bin/bash
+# $Id: generic_empty.agent,v 1.1.1.1 2004/03/10 15:41:49 adrian Exp $
+#
+# empty hotplug policy agent for Linux kernels. For events that need not to be
+# handled, but should have an agent.
+# If you need to do something for this event, then copy this file to $1.agent
+# before modifying.
+#
+# Kernel hotplug params include:
+#	
+#	ACTION=%s [add or remove]
+#	DEVPATH=%s
+#
+: ${ACTION?Bad invocation: \$ACTION is not set}
+: ${DEVPATH?Bad invocation: \$DEVPATH is not set}
+: ${OF_NAME?Bad invocation: \$OF_NAME is not set}
+: ${OF_TYPE?Bad invocation: \$OF_TYPE is not set}
+: ${OF_COMPATIBLE?Bad invocation: \$OF_COMPATIBLE is not set}
+
+
+
+cd /etc/hotplug
+. ./hotplug.functions
+
+# generated by module-init-tools
+MAP_CURRENT=$MODULE_DIR/modules.ofmap
+
+declare OF_ANY="*"
+
+of_map_modules ()
+{
+    # read modules.ofmap
+    while read line
+    do
+	declare -a compat
+	# skip comments and blank lines
+	case "$line" in
+	\#*|"") continue ;;
+	esac
+
+	set -o noglob
+	set -- $line
+	module=$1
+	name=$2
+	type=$3
+	clist=$4
+	set -- `IFS=,; echo $clist`
+        compat=($@)
+
+	if [ $name != "$OF_ANY" -a $name != $OF_NAME ]; then
+    	    continue
+	fi
+
+	if [ $type != "$OF_ANY" -a $type != $OF_TYPE ]; then
+	    continue
+	fi
+
+        if [ $clist != "$OF_ANY" -a -n "$clist" ]; then
+            set -- `IFS=,; echo $OF_COMPATIBLE`
+            of_compatible=($@)
+            while [ ${#compat} -gt 0]; do
+                let index=0
+                centry=$1 
+                while [ $index -lt ${#of_compatible} ]; do
+                    debug_mesg "outer=$centry inner=${of_compatible[$index]}"
+                    list_entry=${of_compatible[$index]}
+                    if [ $centry = $list_entry ]; then
+                        COMPAT_MATCH="$COMPAT_MATCH $centry"
+                        break 2
+                    fi
+                    let index++
+                done
+                shift
+            done
+	    if [ -z $COMPAT_MATCH ]; then
+		    continue
+	    fi
+	fi
+
+	DRIVERS="$module $DRIVERS"
+    done
+}
+
+load_drivers of $MAP_CURRENT "$OF_NAME; $OF_TYPE"

--------------060002040203060209080306
Content-Type: text/plain;
 name="module-init-tools-3.0-pre10-openfirmware.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module-init-tools-3.0-pre10-openfirmware.diff"

diff -rup -x '.*.[^ch]' modutils-2.4.26/module-init-tools-3.0-pre10/depmod.c modutils-2.4.26.devel/module-init-tools-3.0-pre10/depmod.c
--- modutils-2.4.26/module-init-tools-3.0-pre10/depmod.c	2004-09-07 04:49:52.104112544 -0400
+++ modutils-2.4.26.devel/module-init-tools-3.0-pre10/depmod.c	2004-09-07 04:08:46.446949408 -0400
@@ -648,6 +648,7 @@ static struct depfile depfiles[] = {
 	{ "modules.ieee1394map", output_ieee1394_table },
 	{ "modules.isapnpmap", output_isapnp_table },
 	{ "modules.inputmap", output_input_table },
+	{ "modules.ofmap", output_of_table },
 	{ "modules.alias", output_aliases },
 	{ "modules.symbols", output_symbols },
 };
diff -rup -x '.*.[^ch]' modutils-2.4.26/module-init-tools-3.0-pre10/depmod.h modutils-2.4.26.devel/module-init-tools-3.0-pre10/depmod.h
--- modutils-2.4.26/module-init-tools-3.0-pre10/depmod.h	2003-12-23 21:10:57.000000000 -0500
+++ modutils-2.4.26.devel/module-init-tools-3.0-pre10/depmod.h	2004-09-07 04:08:56.221463456 -0400
@@ -47,6 +47,8 @@ struct module
 	void *pnp_card_table;
 	unsigned int input_size;
 	void *input_table;
+	unsigned int of_size;
+	void *of_table;
 
 	/* File contents and length. */
 	void *data;
diff -rup -x '.*.[^ch]' modutils-2.4.26/module-init-tools-3.0-pre10/moduleops_core.c modutils-2.4.26.devel/module-init-tools-3.0-pre10/moduleops_core.c
--- modutils-2.4.26/module-init-tools-3.0-pre10/moduleops_core.c	2003-12-24 00:17:07.000000000 -0500
+++ modutils-2.4.26.devel/module-init-tools-3.0-pre10/moduleops_core.c	2004-09-07 04:15:23.918524544 -0400
@@ -192,6 +192,11 @@ static void PERBIT(fetch_tables)(struct 
 	module->input_size = PERBIT(INPUT_DEVICE_SIZE);
 	module->input_table = PERBIT(deref_sym)(module->data,
 					"__mod_input_device_table");
+
+	module->of_size = PERBIT(OF_DEVICE_SIZE);
+	module->of_table = PERBIT(deref_sym)(module->data,
+					"__mod_of_device_table");
+
 }
 
 struct module_ops PERBIT(mod_ops) = {
diff -rup -x '.*.[^ch]' modutils-2.4.26/module-init-tools-3.0-pre10/tables.c modutils-2.4.26.devel/module-init-tools-3.0-pre10/tables.c
--- modutils-2.4.26/module-init-tools-3.0-pre10/tables.c	2003-12-24 00:23:38.000000000 -0500
+++ modutils-2.4.26.devel/module-init-tools-3.0-pre10/tables.c	2004-09-07 04:45:51.761650152 -0400
@@ -340,3 +340,33 @@ void output_input_table(struct module *m
 		}
 	}
 }
+
+/* We set driver_data to zero */
+static void output_of_entry(struct of_device_id *dev, char *name, FILE *out)
+{
+
+        fprintf (out, "%-20s %-20s %-20s %s\n",
+                name,
+                dev->name[0] ? dev->name : "*",
+                dev->type[0] ? dev->type : "*",
+                dev->compatible[0] ? dev->compatible : "*");
+}
+
+void output_of_table(struct module *modules, FILE *out)
+{
+	struct module *i;
+
+        fprintf (out, "# of module          name                 type                 compatible\n");                                 
+	for (i = modules; i; i = i->next) {
+		struct of_device_id *e;
+		char shortname[strlen(i->pathname) + 1];
+
+		if (!i->of_table)
+			continue;
+
+		make_shortname(shortname, i->pathname);
+		for (e = i->of_table; e->name[0]|e->type[0]|e->compatible[0];
+                     e = (void *)e + i->of_size)
+			output_of_entry(e, shortname, out);
+	}
+}
diff -rup -x '.*.[^ch]' modutils-2.4.26/module-init-tools-3.0-pre10/tables.h modutils-2.4.26.devel/module-init-tools-3.0-pre10/tables.h
--- modutils-2.4.26/module-init-tools-3.0-pre10/tables.h	2003-12-24 00:18:54.000000000 -0500
+++ modutils-2.4.26.devel/module-init-tools-3.0-pre10/tables.h	2004-09-07 04:46:59.057419640 -0400
@@ -116,6 +116,16 @@ struct input_device_id_32 {
 #define INPUT_DEVICE_SIZE32 (4 + 4 * 2 + 4 + 16 * 4 + 4 + 2 * 4 + 4 + 4 + 4 + 4 * 4 + 4)
 #define INPUT_DEVICE_SIZE64 (8 + 4 * 2 + 8 + 8 * 8 + 8 + 8 + 8 + 8 + 8 + 2 * 8 + 8)
 
+#define MAX_OF_NAMELEN (32)
+struct of_device_id {
+	char name[MAX_OF_NAMELEN];
+	char type[MAX_OF_NAMELEN];
+	char compatible[MAX_OF_NAMELEN];
+};
+
+#define OF_DEVICE_SIZE32 (MAX_OF_NAMELEN * 3 + 4)
+#define OF_DEVICE_SIZE64 (MAX_OF_NAMELEN * 3 + 8)
+
 /* Functions provided by tables.c */
 struct module;
 void output_usb_table(struct module *modules, FILE *out);
@@ -124,5 +134,6 @@ void output_pci_table(struct module *mod
 void output_ccw_table(struct module *modules, FILE *out);
 void output_isapnp_table(struct module *modules, FILE *out);
 void output_input_table(struct module *modules, FILE *out);
+void output_of_table(struct module *modules, FILE *out);
 
 #endif /* MODINITTOOLS_TABLES_H */

--------------060002040203060209080306
Content-Type: text/plain;
 name="kernel-of-hotplug.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel-of-hotplug.diff"

diff -rupN -X dontdiff linux-2.6.8/arch/ppc/syslib/of_device.c linux-2.6.8.devel/arch/ppc/syslib/of_device.c
--- linux-2.6.8/arch/ppc/syslib/of_device.c	2004-08-14 01:38:10.000000000 -0400
+++ linux-2.6.8.devel/arch/ppc/syslib/of_device.c	2004-09-16 17:12:37.212924568 -0400
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <asm/errno.h>
 #include <asm/of_device.h>
 
@@ -15,20 +16,20 @@
  * Used by a driver to check whether an of_device present in the
  * system is in its list of supported devices.
  */
-const struct of_match * of_match_device(const struct of_match *matches,
+const struct of_device_id * of_match_device(const struct of_device_id *matches,
 					const struct of_device *dev)
 {
 	if (!dev->node)
 		return NULL;
-	while (matches->name || matches->type || matches->compatible) {
+	while (matches->name[0] || matches->type[0] || matches->compatible[0]) {
 		int match = 1;
-		if (matches->name && matches->name != OF_ANY_MATCH)
+		if (matches->name[0])
 			match &= dev->node->name
 				&& !strcmp(matches->name, dev->node->name);
-		if (matches->type && matches->type != OF_ANY_MATCH)
+		if (matches->type[0])
 			match &= dev->node->type
 				&& !strcmp(matches->type, dev->node->type);
-		if (matches->compatible && matches->compatible != OF_ANY_MATCH)
+		if (matches->compatible[0])
 			match &= device_is_compatible(dev->node,
 				matches->compatible);
 		if (match)
@@ -42,7 +43,7 @@ static int of_platform_bus_match(struct 
 {
 	struct of_device * of_dev = to_of_device(dev);
 	struct of_platform_driver * of_drv = to_of_platform_driver(drv);
-	const struct of_match * matches = of_drv->match_table;
+	const struct of_device_id * matches = of_drv->match_table;
 
 	if (!matches)
 		return 0;
@@ -75,7 +76,7 @@ static int of_device_probe(struct device
 	int error = -ENODEV;
 	struct of_platform_driver *drv;
 	struct of_device *of_dev;
-	const struct of_match *match;
+	const struct of_device_id *match;
 
 	drv = to_of_platform_driver(dev->driver);
 	of_dev = to_of_device(dev);
diff -rupN -X dontdiff linux-2.6.8/drivers/i2c/busses/i2c-keywest.c linux-2.6.8.devel/drivers/i2c/busses/i2c-keywest.c
--- linux-2.6.8/drivers/i2c/busses/i2c-keywest.c	2004-09-16 17:10:39.329845520 -0400
+++ linux-2.6.8.devel/drivers/i2c/busses/i2c-keywest.c	2004-09-16 17:12:37.215924112 -0400
@@ -694,7 +694,7 @@ dispose_iface(struct device *dev)
 }
 
 static int
-create_iface_macio(struct macio_dev* dev, const struct of_match *match)
+create_iface_macio(struct macio_dev* dev, const struct of_device_id *match)
 {
 	return create_iface(dev->ofdev.node, &dev->ofdev.dev);
 }
@@ -706,7 +706,7 @@ dispose_iface_macio(struct macio_dev* de
 }
 
 static int
-create_iface_of_platform(struct of_device* dev, const struct of_match *match)
+create_iface_of_platform(struct of_device* dev, const struct of_device_id *match)
 {
 	return create_iface(dev->node, &dev->dev);
 }
@@ -717,10 +717,9 @@ dispose_iface_of_platform(struct of_devi
 	return dispose_iface(&dev->dev);
 }
 
-static struct of_match i2c_keywest_match[] = 
+static struct of_device_id i2c_keywest_match[] = 
 {
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "i2c",
 	.compatible	= "keywest"
 	},
diff -rupN -X dontdiff linux-2.6.8/drivers/ide/ppc/pmac.c linux-2.6.8.devel/drivers/ide/ppc/pmac.c
--- linux-2.6.8/drivers/ide/ppc/pmac.c	2004-09-16 17:11:14.056566256 -0400
+++ linux-2.6.8.devel/drivers/ide/ppc/pmac.c	2004-09-16 17:12:37.221923200 -0400
@@ -1279,7 +1279,7 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
  * Attach to a macio probed interface
  */
 static int __devinit
-pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_match *match)
+pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	unsigned long base, regbase;
 	int irq;
@@ -1500,27 +1500,19 @@ pmac_ide_pci_resume(struct pci_dev *pdev
 	return rc;
 }
 
-static struct of_match pmac_ide_macio_match[] = 
+static struct of_device_id pmac_ide_macio_match[] = 
 {
 	{
 	.name 		= "IDE",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
 	.name 		= "ATA",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "ide",
-	.compatible	= OF_ANY_MATCH
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "ata",
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
diff -rupN -X dontdiff linux-2.6.8/drivers/macintosh/macio_asic.c linux-2.6.8.devel/drivers/macintosh/macio_asic.c
--- linux-2.6.8/drivers/macintosh/macio_asic.c	2004-08-14 01:36:45.000000000 -0400
+++ linux-2.6.8.devel/drivers/macintosh/macio_asic.c	2004-09-16 17:12:37.242920008 -0400
@@ -33,7 +33,7 @@ static int macio_bus_match(struct device
 {
 	struct macio_dev * macio_dev = to_macio_device(dev);
 	struct macio_driver * macio_drv = to_macio_driver(drv);
-	const struct of_match * matches = macio_drv->match_table;
+	const struct of_device_id * matches = macio_drv->match_table;
 
 	if (!matches) 
 		return 0;
@@ -66,7 +66,7 @@ static int macio_device_probe(struct dev
 	int error = -ENODEV;
 	struct macio_driver *drv;
 	struct macio_dev *macio_dev;
-	const struct of_match *match;
+	const struct of_device_id *match;
 
 	drv = to_macio_driver(dev->driver);
 	macio_dev = to_macio_device(dev);
@@ -126,11 +126,80 @@ static int macio_device_resume(struct de
 	return 0;
 }
 
+static int macio_hotplug (struct device *dev, char **envp, int num_envp,
+                          char *buffer, int buffer_size)
+{
+        struct macio_dev * macio_dev;
+        struct of_device * of;
+	char *scratch, *compat;
+	int i = 0;
+	int length = 0;
+        int cplen, seen = 0;
+
+        if (!dev)
+                return -ENODEV;
+
+        macio_dev = to_macio_device(dev);
+        if (!macio_dev)
+                return -ENODEV;
+
+        of = &macio_dev->ofdev;
+	scratch = buffer;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length, "OF_NAME=%s",
+			    of->node->name);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length, "OF_TYPE=%s",
+                            of->node->type);
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	envp[i++] = scratch;
+	length += scnprintf (scratch, buffer_size - length,
+			    "OF_COMPATIBLE=");
+	if ((buffer_size - length <= 0) || (i >= num_envp))
+		return -ENOMEM;
+	++length;
+	scratch += length;
+
+	compat = (char *) get_property(of->node, "compatible", &cplen);
+	while (cplen > 0) {
+                int l;
+                length += scnprintf (scratch, buffer_size - length,
+                                    "%s%s", seen ? "," : "", compat);
+                if ((buffer_size - length <= 0) || (i >= num_envp))
+                        return -ENOMEM;
+                length++;
+                scratch += length;
+                l = strlen (compat) + 1;
+                compat += l;
+		cplen -= l;
+                seen++;
+	}
+
+	envp[i] = NULL;
+
+	return 0;
+
+}
+extern struct device_attribute macio_dev_attrs[];
+
 struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
+       .hotplug = macio_hotplug,
        .suspend	= macio_device_suspend,
        .resume	= macio_device_resume,
+       .dev_attrs = macio_dev_attrs,
 };
 
 static int __init macio_bus_driver_init(void)
diff -rupN -X dontdiff linux-2.6.8/drivers/macintosh/macio_sysfs.c linux-2.6.8.devel/drivers/macintosh/macio_sysfs.c
--- linux-2.6.8/drivers/macintosh/macio_sysfs.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.8.devel/drivers/macintosh/macio_sysfs.c	2004-09-16 17:12:37.244919704 -0400
@@ -0,0 +1,49 @@
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/stat.h>
+#include <asm/macio.h>
+
+
+#define macio_config_of_attr(field, format_string)              \
+static ssize_t                                                  \
+field##_show (struct device *dev, char *buf)                    \
+{                                                               \
+    struct macio_dev *mdev = to_macio_device (dev);             \
+    return sprintf (buf, format_string, mdev->ofdev.node->field);     \
+}
+
+static ssize_t
+compatible_show (struct device *dev, char *buf)        
+{
+        struct of_device *of;
+        char *compat;
+        int cplen;
+        int length = 0;
+        
+        of = &to_macio_device (dev)->ofdev;
+	compat = (char *) get_property(of->node, "compatible", &cplen);
+	if (!compat) {
+		*buf = '\0';
+		return 0;
+	}
+	while (cplen > 0) {
+                int l;
+                length += sprintf (buf, "%s%s", length ? "," : "", compat);
+                buf += length;
+                l = strlen (compat) + 1;
+                compat += l;
+		cplen -= l;
+	}
+
+        return length;
+}
+
+macio_config_of_attr (name, "%s");
+macio_config_of_attr (type, "%s");
+
+struct device_attribute macio_dev_attrs[] = {
+    __ATTR_RO(name),
+    __ATTR_RO(type),
+    __ATTR_RO(compatible),
+    __ATTR_NULL
+};
diff -rupN -X dontdiff linux-2.6.8/drivers/macintosh/Makefile linux-2.6.8.devel/drivers/macintosh/Makefile
--- linux-2.6.8/drivers/macintosh/Makefile	2004-08-14 01:37:40.000000000 -0400
+++ linux-2.6.8.devel/drivers/macintosh/Makefile	2004-09-16 17:12:37.252918488 -0400
@@ -4,7 +4,7 @@
 
 # Each configuration option enables a list of files.
 
-obj-$(CONFIG_PPC_PMAC)		+= macio_asic.o
+obj-$(CONFIG_PPC_PMAC)		+= macio_asic.o macio_sysfs.o
 
 obj-$(CONFIG_PMAC_PBOOK)	+= mediabay.o
 obj-$(CONFIG_MAC_SERIAL)	+= macserial.o
diff -rupN -X dontdiff linux-2.6.8/drivers/macintosh/mediabay.c linux-2.6.8.devel/drivers/macintosh/mediabay.c
--- linux-2.6.8/drivers/macintosh/mediabay.c	2004-08-14 01:36:32.000000000 -0400
+++ linux-2.6.8.devel/drivers/macintosh/mediabay.c	2004-09-16 17:12:37.262916968 -0400
@@ -648,7 +648,7 @@ static int __pmac media_bay_task(void *x
 	}
 }
 
-static int __devinit media_bay_attach(struct macio_dev *mdev, const struct of_match *match)
+static int __devinit media_bay_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct media_bay_info* bay;
 	volatile u32 *regbase;
@@ -802,23 +802,20 @@ static struct mb_ops keylargo_mb_ops __p
  * Therefore we do it all by polling the media bay once each tick.
  */
 
-static struct of_match media_bay_match[] =
+static struct of_device_id media_bay_match[] =
 {
 	{
 	.name		= "media-bay",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "keylargo-media-bay",
 	.data		= &keylargo_mb_ops,
 	},
 	{
 	.name		= "media-bay",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "heathrow-media-bay",
 	.data		= &heathrow_mb_ops,
 	},
 	{
 	.name		= "media-bay",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "ohare-media-bay",
 	.data		= &ohare_mb_ops,
 	},
diff -rupN -X dontdiff linux-2.6.8/drivers/macintosh/therm_windtunnel.c linux-2.6.8.devel/drivers/macintosh/therm_windtunnel.c
--- linux-2.6.8/drivers/macintosh/therm_windtunnel.c	2004-08-14 01:37:37.000000000 -0400
+++ linux-2.6.8.devel/drivers/macintosh/therm_windtunnel.c	2004-09-16 17:12:37.265916512 -0400
@@ -43,6 +43,7 @@
 #include <asm/system.h>
 #include <asm/sections.h>
 #include <asm/of_device.h>
+#include <asm/macio.h>
 
 #define LOG_TEMP		0			/* continously log temperature */
 
@@ -453,7 +454,7 @@ do_probe( struct i2c_adapter *adapter, i
 /************************************************************************/
 
 static int
-therm_of_probe( struct of_device *dev, const struct of_match *match )
+therm_of_probe( struct of_device *dev, const struct of_device_id *match )
 {
 	return i2c_add_driver( &g4fan_driver );
 }
@@ -464,9 +465,8 @@ therm_of_remove( struct of_device *dev )
 	return i2c_del_driver( &g4fan_driver );
 }
 
-static struct of_match therm_of_match[] = {{
+static struct of_device_id therm_of_match[] = {{
 	.name		= "fan",
-	.type		= OF_ANY_MATCH,
 	.compatible	= "adm1030"
     }, {}
 };
diff -rupN -X dontdiff linux-2.6.8/drivers/net/bmac.c linux-2.6.8.devel/drivers/net/bmac.c
--- linux-2.6.8/drivers/net/bmac.c	2004-08-14 01:36:13.000000000 -0400
+++ linux-2.6.8.devel/drivers/net/bmac.c	2004-09-16 17:25:18.793146776 -0400
@@ -1261,7 +1261,7 @@ static void bmac_reset_and_enable(struct
 	spin_unlock_irqrestore(&bp->lock, flags);
 }
 
-static int __devinit bmac_probe(struct macio_dev *mdev, const struct of_match *match)
+static int __devinit bmac_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	int j, rev, ret;
 	struct bmac_data *bp;
@@ -1649,16 +1649,13 @@ static int __devexit bmac_remove(struct 
 	return 0;
 }
 
-static struct of_match bmac_match[] = 
+static struct of_device_id bmac_match[] = 
 {
 	{
 	.name 		= "bmac",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH,
 	.data		= (void *)0,
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "network",
 	.compatible	= "bmac+",
 	.data		= (void *)1,
diff -rupN -X dontdiff linux-2.6.8/drivers/net/mace.c linux-2.6.8.devel/drivers/net/mace.c
--- linux-2.6.8/drivers/net/mace.c	2004-08-14 01:36:33.000000000 -0400
+++ linux-2.6.8.devel/drivers/net/mace.c	2004-09-16 17:24:15.594754392 -0400
@@ -109,7 +109,7 @@ bitrev(int b)
 }
 
 
-static int __devinit mace_probe(struct macio_dev *mdev, const struct of_match *match)
+static int __devinit mace_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct device_node *mace = macio_get_of_node(mdev);
 	struct net_device *dev;
@@ -1011,12 +1011,10 @@ static irqreturn_t mace_rxdma_intr(int i
     return IRQ_HANDLED;
 }
 
-static struct of_match mace_match[] = 
+static struct of_device_id mace_match[] = 
 {
 	{
 	.name 		= "mace",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
diff -rupN -X dontdiff linux-2.6.8/drivers/net/wireless/airport.c linux-2.6.8.devel/drivers/net/wireless/airport.c
--- linux-2.6.8/drivers/net/wireless/airport.c	2004-09-16 17:10:44.689030800 -0400
+++ linux-2.6.8.devel/drivers/net/wireless/airport.c	2004-09-16 17:12:37.267916208 -0400
@@ -188,7 +188,7 @@ static int airport_hard_reset(struct ori
 }
 
 static int
-airport_attach(struct macio_dev *mdev, const struct of_match *match)
+airport_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct orinoco_private *priv;
 	struct net_device *dev;
@@ -272,16 +272,16 @@ MODULE_AUTHOR("Benjamin Herrenschmidt <b
 MODULE_DESCRIPTION("Driver for the Apple Airport wireless card.");
 MODULE_LICENSE("Dual MPL/GPL");
 
-static struct of_match airport_match[] = 
+static struct of_device_id airport_match[] = 
 {
 	{
 	.name 		= "radio",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
 
+MODULE_DEVICE_TABLE (of, airport_match);
+
 static struct macio_driver airport_driver = 
 {
 	.name 		= DRIVER_NAME,
diff -rupN -X dontdiff linux-2.6.8/drivers/scsi/mac53c94.c linux-2.6.8.devel/drivers/scsi/mac53c94.c
--- linux-2.6.8/drivers/scsi/mac53c94.c	2004-08-14 01:36:14.000000000 -0400
+++ linux-2.6.8.devel/drivers/scsi/mac53c94.c	2004-09-16 17:12:37.281914080 -0400
@@ -425,7 +425,7 @@ static struct scsi_host_template mac53c9
 	.use_clustering	= DISABLE_CLUSTERING,
 };
 
-static int mac53c94_probe(struct macio_dev *mdev, const struct of_match *match)
+static int mac53c94_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct device_node *node = macio_get_of_node(mdev);
 	struct pci_dev *pdev = macio_get_pci_dev(mdev);
@@ -545,15 +545,14 @@ static int mac53c94_remove(struct macio_
 }
 
 
-static struct of_match mac53c94_match[] = 
+static struct of_device_id mac53c94_match[] = 
 {
 	{
 	.name 		= "53c94",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, mac53c94_match);
 
 static struct macio_driver mac53c94_driver = 
 {
diff -rupN -X dontdiff linux-2.6.8/drivers/scsi/mesh.c linux-2.6.8.devel/drivers/scsi/mesh.c
--- linux-2.6.8/drivers/scsi/mesh.c	2004-08-14 01:37:25.000000000 -0400
+++ linux-2.6.8.devel/drivers/scsi/mesh.c	2004-09-16 17:12:37.292912408 -0400
@@ -1847,7 +1847,7 @@ static struct scsi_host_template mesh_te
 	.use_clustering			= DISABLE_CLUSTERING,
 };
 
-static int mesh_probe(struct macio_dev *mdev, const struct of_match *match)
+static int mesh_probe(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	struct device_node *mesh = macio_get_of_node(mdev);
 	struct pci_dev* pdev = macio_get_pci_dev(mdev);
@@ -2014,20 +2014,18 @@ static int mesh_remove(struct macio_dev 
 }
 
 
-static struct of_match mesh_match[] = 
+static struct of_device_id mesh_match[] = 
 {
 	{
 	.name 		= "mesh",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
-	.name 		= OF_ANY_MATCH,
 	.type		= "scsi",
 	.compatible	= "chrp,mesh0"
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, mesh_match);
 
 static struct macio_driver mesh_driver = 
 {
diff -rupN -X dontdiff linux-2.6.8/drivers/serial/pmac_zilog.c linux-2.6.8.devel/drivers/serial/pmac_zilog.c
--- linux-2.6.8/drivers/serial/pmac_zilog.c	2004-09-16 17:11:20.350609416 -0400
+++ linux-2.6.8.devel/drivers/serial/pmac_zilog.c	2004-09-16 17:12:37.297911648 -0400
@@ -1520,7 +1520,7 @@ static void pmz_dispose_port(struct uart
 /*
  * Called upon match with an escc node in the devive-tree.
  */
-static int pmz_attach(struct macio_dev *mdev, const struct of_match *match)
+static int pmz_attach(struct macio_dev *mdev, const struct of_device_id *match)
 {
 	int i;
 	
@@ -1826,20 +1826,17 @@ err_out:
 	return rc;
 }
 
-static struct of_match pmz_match[] = 
+static struct of_device_id pmz_match[] = 
 {
 	{
 	.name 		= "ch-a",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{
 	.name 		= "ch-b",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH
 	},
 	{},
 };
+MODULE_DEVICE_TABLE (of, pmz_match);
 
 static struct macio_driver pmz_driver = 
 {
diff -rupN -X dontdiff linux-2.6.8/drivers/video/platinumfb.c linux-2.6.8.devel/drivers/video/platinumfb.c
--- linux-2.6.8/drivers/video/platinumfb.c	2004-09-16 17:10:52.729808416 -0400
+++ linux-2.6.8.devel/drivers/video/platinumfb.c	2004-09-16 17:48:10.990541064 -0400
@@ -523,7 +523,7 @@ int __init platinumfb_setup(char *option
 #define invalidate_cache(addr)
 #endif
 
-static int __devinit platinumfb_probe(struct of_device* odev, const struct of_match *match)
+static int __devinit platinumfb_probe(struct of_device* odev, const struct of_device_id *match)
 {
 	struct device_node	*dp = odev->node;
 	struct fb_info		*info;
@@ -647,12 +647,10 @@ static int __devexit platinumfb_remove(s
 	return 0;
 }
 
-static struct of_match platinumfb_match[] = 
+static struct of_device_id platinumfb_match[] = 
 {
 	{
 	.name 		= "platinum",
-	.type		= OF_ANY_MATCH,
-	.compatible	= OF_ANY_MATCH,
 	},
 	{},
 };
diff -rupN -X dontdiff linux-2.6.8/include/asm-ppc/macio.h linux-2.6.8.devel/include/asm-ppc/macio.h
--- linux-2.6.8/include/asm-ppc/macio.h	2004-08-14 01:36:17.000000000 -0400
+++ linux-2.6.8.devel/include/asm-ppc/macio.h	2004-09-16 17:12:37.307910128 -0400
@@ -1,6 +1,7 @@
 #ifndef __MACIO_ASIC_H__
 #define __MACIO_ASIC_H__
 
+#include <linux/mod_devicetable.h>
 #include <asm/of_device.h>
 
 extern struct bus_type macio_bus_type;
@@ -120,10 +121,10 @@ static inline struct pci_dev *macio_get_
 struct macio_driver
 {
 	char			*name;
-	struct of_match		*match_table;
+	struct of_device_id	*match_table;
 	struct module		*owner;
 
-	int	(*probe)(struct macio_dev* dev, const struct of_match *match);
+	int	(*probe)(struct macio_dev* dev, const struct of_device_id *match);
 	int	(*remove)(struct macio_dev* dev);
 
 	int	(*suspend)(struct macio_dev* dev, u32 state);
diff -rupN -X dontdiff linux-2.6.8/include/asm-ppc/of_device.h linux-2.6.8.devel/include/asm-ppc/of_device.h
--- linux-2.6.8/include/asm-ppc/of_device.h	2004-08-14 01:37:14.000000000 -0400
+++ linux-2.6.8.devel/include/asm-ppc/of_device.h	2004-09-16 17:12:37.331906480 -0400
@@ -24,20 +24,8 @@ struct of_device
 };
 #define	to_of_device(d) container_of(d, struct of_device, dev)
 
-/*
- * Struct used for matching a device
- */
-struct of_match
-{
-	char	*name;
-	char	*type;
-	char	*compatible;
-	void	*data;
-};
-#define OF_ANY_MATCH		((char *)-1L)
-
-extern const struct of_match *of_match_device(
-	const struct of_match *matches, const struct of_device *dev);
+extern const struct of_device_id *of_match_device(
+	const struct of_device_id *matches, const struct of_device *dev);
 
 extern struct of_device *of_dev_get(struct of_device *dev);
 extern void of_dev_put(struct of_device *dev);
@@ -49,10 +37,10 @@ extern void of_dev_put(struct of_device 
 struct of_platform_driver
 {
 	char			*name;
-	struct of_match		*match_table;
+	struct of_device_id	*match_table;
 	struct module		*owner;
 
-	int	(*probe)(struct of_device* dev, const struct of_match *match);
+	int	(*probe)(struct of_device* dev, const struct of_device_id *match);
 	int	(*remove)(struct of_device* dev);
 
 	int	(*suspend)(struct of_device* dev, u32 state);
diff -rupN -X dontdiff linux-2.6.8/include/linux/mod_devicetable.h linux-2.6.8.devel/include/linux/mod_devicetable.h
--- linux-2.6.8/include/linux/mod_devicetable.h	2004-08-14 01:38:08.000000000 -0400
+++ linux-2.6.8.devel/include/linux/mod_devicetable.h	2004-09-16 17:12:37.350903592 -0400
@@ -164,5 +164,16 @@ struct pnp_card_device_id {
 	} devs[PNP_MAX_DEVICES];
 };
 
+/*
+ * Struct used for matching a device
+ */
+struct of_device_id
+{
+	char	name[32];
+	char	type[32];
+	char	compatible[32];
+	void	*data;
+};
+
 
 #endif /* LINUX_MOD_DEVICETABLE_H */
diff -rupN -X dontdiff linux-2.6.8/scripts/mod/file2alias.c linux-2.6.8.devel/scripts/mod/file2alias.c
--- linux-2.6.8/scripts/mod/file2alias.c	2004-08-14 01:36:57.000000000 -0400
+++ linux-2.6.8.devel/scripts/mod/file2alias.c	2004-09-16 17:12:37.370900552 -0400
@@ -199,6 +199,15 @@ static int do_pnp_card_entry(const char 
 	return 1;
 }
 
+static int do_macio_entry (const char *filename, struct of_device_id *of, char *alias)
+{
+    sprintf (alias, "macio:N%sT%sC%s",
+                    of->name[0] ? of->name : "*",
+                    of->type[0] ? of->type : "*",
+                    of->compatible[0] ? of->compatible : "*");
+    return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -271,6 +280,10 @@ void handle_moddevtable(struct module *m
 	else if (sym_is(symname, "__mod_pnp_card_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct pnp_card_device_id),
 			 do_pnp_card_entry, mod);
+        else if (sym_is(symname, "__mod_macio_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct of_device_id),
+			 do_macio_entry, mod);
+
 }
 
 /* Now add out buffered information to the generated C source */

--------------060002040203060209080306--
