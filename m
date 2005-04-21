Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbVDUIvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbVDUIvX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 04:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVDUI32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 04:29:28 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:2488 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261460AbVDUHaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 03:30:24 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: sensors@Stimpy.netroedge.com
Subject: [RFC/PATCH 20/22] W1: add w1_device_id/MODULE_DEVICE_TABLE for automatic driver loading
Date: Thu, 21 Apr 2005 02:27:36 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>
References: <200504210207.02421.dtor_core@ameritech.net>
In-Reply-To: <200504210207.02421.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504210227.36554.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W1: support for automatic family drivers loading via hotplug:
    - allow family drivers support list of families;
    - export supported families through MODULE_DEVICE_TABLE.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/w1/w1.c                 |    6 ++++--
 drivers/w1/w1.h                 |    3 ++-
 drivers/w1/w1_sernum.c          |    9 ++++++++-
 drivers/w1/w1_thermal.c         |    9 ++++++++-
 include/linux/mod_devicetable.h |    4 ++++
 scripts/mod/file2alias.c        |   16 ++++++++++++++++
 6 files changed, 42 insertions(+), 5 deletions(-)

Index: dtor/drivers/w1/w1.c
===================================================================
--- dtor.orig/drivers/w1/w1.c
+++ dtor/drivers/w1/w1.c
@@ -58,9 +58,11 @@ static int w1_bus_match(struct device *d
 	 */
 	struct w1_slave *slave = to_w1_slave(dev);
 	struct w1_family *family = to_w1_family(drv);
+	struct w1_device_id *id;
 
-	if (slave->reg_num.family == family->fid)
-		return 1;
+	for (id = family->id_table; id->family; id++)
+		if (slave->reg_num.family == id->family)
+			return 1;
 
 	return 0;
 }
Index: dtor/drivers/w1/w1.h
===================================================================
--- dtor.orig/drivers/w1/w1.h
+++ dtor/drivers/w1/w1.h
@@ -41,6 +41,7 @@ struct w1_reg_num
 
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 
 #include <asm/semaphore.h>
 
@@ -118,7 +119,7 @@ void w1_remove_master_device(struct w1_m
 
 struct w1_family {
 	struct device_driver	driver;
-	u8			fid;
+	struct w1_device_id	*id_table;
 	const char		*name;
 
 	int (*join)(struct w1_slave *);
Index: dtor/drivers/w1/w1_thermal.c
===================================================================
--- dtor.orig/drivers/w1/w1_thermal.c
+++ dtor/drivers/w1/w1_thermal.c
@@ -50,11 +50,18 @@ static void w1_thermal_leave(struct w1_s
 	device_remove_file(&slave->dev, &w1_thermal_temperature_attr);
 }
 
+static struct w1_device_id w1_thermal_ids[] = {
+	{ .family = W1_FAMILY_THERMAL, },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(w1, w1_thermal_ids);
+
 static struct w1_family w1_thermal_family = {
 	.driver		= {
 		.name	= "thermal",
 	},
-	.fid		= W1_FAMILY_THERMAL,
+	.id_table	= w1_thermal_ids,
 	.name		= "Digital Thermometer Driver",
 	.join		= w1_thermal_join,
 	.leave		= w1_thermal_leave,
Index: dtor/drivers/w1/w1_sernum.c
===================================================================
--- dtor.orig/drivers/w1/w1_sernum.c
+++ dtor/drivers/w1/w1_sernum.c
@@ -40,11 +40,18 @@ MODULE_DESCRIPTION("1-Wire Silicon Seria
  * by W1 core.
  */
 
+static struct w1_device_id w1_serial_num_ids[] = {
+	{ .family = W1_FAMILY_SERIAL_NUM, },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(w1, w1_serial_num_ids);
+
 static struct w1_family w1_serial_num_family = {
 	.driver		= {
 		.name	= "sernum",
 	},
-	.fid		= W1_FAMILY_SERIAL_NUM,
+	.id_table	= w1_serial_num_ids,
 	.name		= "Serial Number Driver",
 };
 
Index: dtor/scripts/mod/file2alias.c
===================================================================
--- dtor.orig/scripts/mod/file2alias.c
+++ dtor/scripts/mod/file2alias.c
@@ -25,6 +25,7 @@ typedef Elf64_Addr	kernel_ulong_t;
 #include <stdint.h>
 #endif
 
+typedef uint64_t	__u64;
 typedef uint32_t	__u32;
 typedef uint16_t	__u16;
 typedef unsigned char	__u8;
@@ -199,6 +200,18 @@ static int do_serio_entry(const char *fi
 	return 1;
 }
 
+/* Looks like: "w1:fidNsnN" */
+static int do_w1_entry(const char *filename,
+		       struct w1_device_id *id, char *alias)
+{
+	id->family = TO_NATIVE(id->family);
+	id->serial = TO_NATIVE(id->serial);
+
+	sprintf(alias, "w1:fid%02Xsn%024llX", id->family, id->serial);
+
+	return 1;
+}
+
 /* looks like: "pnp:dD" */
 static int do_pnp_entry(const char *filename,
 			struct pnp_device_id *id, char *alias)
@@ -291,6 +304,9 @@ void handle_moddevtable(struct module *m
 	else if (sym_is(symname, "__mod_serio_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct serio_device_id),
 			 do_serio_entry, mod);
+	else if (sym_is(symname, "__mod_w1_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct w1_device_id),
+			 do_w1_entry, mod);
 	else if (sym_is(symname, "__mod_pnp_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct pnp_device_id),
 			 do_pnp_entry, mod);
Index: dtor/include/linux/mod_devicetable.h
===================================================================
--- dtor.orig/include/linux/mod_devicetable.h
+++ dtor/include/linux/mod_devicetable.h
@@ -174,5 +174,9 @@ struct serio_device_id {
 	__u8 proto;
 };
 
+struct w1_device_id {
+	__u8	family;
+	__u64	serial;
+};
 
 #endif /* LINUX_MOD_DEVICETABLE_H */
