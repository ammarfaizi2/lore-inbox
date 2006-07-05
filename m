Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWGEIet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWGEIet (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 04:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbWGEIet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 04:34:49 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:36177 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932172AbWGEIes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 04:34:48 -0400
Subject: [PATCH] EISA bus MODALIAS attributes support (#1)
From: Michael Tokarev <mjt@tls.mks.ru>
To: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="eisa-modalias-1.patch"
Message-Id: <20060705083444.26F9C7FAF@paltus.tls.msk.ru>
Date: Wed,  5 Jul 2006 12:34:44 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds modalias attribute support for the
almost forgotten now EISA bus and (at least some) EISA-aware
modules.

The modalias entry looks like (for an 3c509 NIC):

 eisa:sTCM5093

and the in-module alias like:

 eisa:sTCM5093*

The patch moves struct eisa_device_id declaration from
include/linux/eisa.h to include/linux/mod_devicetable.h
(so that the former now #includes the latter), adds
proper MODULE_DEVICE_TABLE(eisa, ...) statements for
all drivers with EISA IDs I found (some drivers already
have that DEVICE_TABLE declared), and adds recognision
of __mod_eisa_device_table to scripts/mod/file2alias.c
so that proper modules.alias will be generated.

There's no support for /lib/modules/$kver/modules.eisamap,
as it's not used by any existing tools, and because with
in-kernel modalias mechanism those maps are obsolete anyway.

The rationale for this patch is:

 a) to make EISA bus to act as other busses with modalias
    support, to unify driver loading

 b) to foget about EISA finally - with this patch, kernel
    (who still supports EISA) will be the only one who knows
    how to choose the necessary drivers for this bus ;)

Thanks.

Signed-Off-By: Michael Tokarev <mjt@tls.msk.ru>

 drivers/eisa/eisa-bus.c            |   23 +++++++++++++++++++++++
 drivers/net/3c509.c                |    1 +
 drivers/net/3c59x.c                |    1 +
 drivers/net/ne3210.c               |    1 +
 drivers/net/tulip/de4x5.c          |    1 +
 drivers/scsi/aha1740.c             |    1 +
 drivers/scsi/aic7xxx/aic7770_osm.c |    3 ++-
 drivers/scsi/sim710.c              |    1 +
 include/linux/eisa.h               |    8 +-------
 include/linux/mod_devicetable.h    |   12 ++++++++++++
 scripts/mod/file2alias.c           |   10 ++++++++++
 11 files changed, 54 insertions(+), 8 deletions(-)

--- linux-2.6.17/drivers/eisa/eisa-bus.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/eisa/eisa-bus.c	2006-07-05 12:10:35.000000000 +0400
@@ -128,9 +128,23 @@ static int eisa_bus_match (struct device
 	return 0;
 }
 
+static int eisa_bus_uevent(struct device *dev, char **envp, int num_envp,
+			   char *buffer, int buffer_size)
+{
+	struct eisa_device *edev = to_eisa_device(dev);
+	int i = 0;
+	int length = 0;
+
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "MODALIAS=" EISA_DEVICE_MODALIAS_FMT, edev->id.sig);
+	envp[i] = NULL;
+	return 0;
+}
+
 struct bus_type eisa_bus_type = {
 	.name  = "eisa",
 	.match = eisa_bus_match,
+	.uevent = eisa_bus_uevent,
 };
 
 int eisa_driver_register (struct eisa_driver *edrv)
@@ -160,6 +174,14 @@ static ssize_t eisa_show_state (struct d
 
 static DEVICE_ATTR(enabled, S_IRUGO, eisa_show_state, NULL);
 
+static ssize_t eisa_show_modalias (struct device *dev, struct device_attribute *attr, char *buf)
+{
+        struct eisa_device *edev = to_eisa_device (dev);
+        return sprintf (buf, EISA_DEVICE_MODALIAS_FMT "\n", edev->id.sig);
+}
+
+static DEVICE_ATTR(modalias, S_IRUGO, eisa_show_modalias, NULL);
+
 static int __init eisa_init_device (struct eisa_root_device *root,
 				    struct eisa_device *edev,
 				    int slot)
@@ -209,6 +231,7 @@ static int __init eisa_register_device (
 
 	device_create_file (&edev->dev, &dev_attr_signature);
 	device_create_file (&edev->dev, &dev_attr_enabled);
+	device_create_file (&edev->dev, &dev_attr_modalias);
 
 	return 0;
 }
--- linux-2.6.17/drivers/net/tulip/de4x5.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/net/tulip/de4x5.c	2006-07-05 12:05:29.000000000 +0400
@@ -2115,6 +2115,7 @@ static struct eisa_device_id de4x5_eisa_
         { "DEC4250", 0 },	/* 0 is the board name index... */
         { "" }
 };
+MODULE_DEVICE_TABLE(eisa, de4x5_eisa_ids);
 
 static struct eisa_driver de4x5_eisa_driver = {
         .id_table = de4x5_eisa_ids,
--- linux-2.6.17/drivers/net/3c509.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/net/3c509.c	2006-07-05 11:35:14.000000000 +0400
@@ -226,6 +226,7 @@ static struct eisa_device_id el3_eisa_id
 		{ "TCM5095" },
 		{ "" }
 };
+MODULE_DEVICE_TABLE(eisa, el3_eisa_ids);
 
 static int el3_eisa_probe (struct device *device);
 
--- linux-2.6.17/drivers/net/3c59x.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/net/3c59x.c	2006-07-05 11:35:12.000000000 +0400
@@ -1019,6 +1019,7 @@ static struct eisa_device_id vortex_eisa
 	{ "TCM5970", CH_3C597 },
 	{ "" }
 };
+MODULE_DEVICE_TABLE(eisa, vortex_eisa_ids);
 
 static int vortex_eisa_probe(struct device *device);
 static int vortex_eisa_remove(struct device *device);
--- linux-2.6.17/drivers/net/ne3210.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/net/ne3210.c	2006-07-05 11:36:24.000000000 +0400
@@ -343,6 +343,7 @@ static struct eisa_device_id ne3210_ids[
 	{ "NVL1801" },
 	{ "" },
 };
+MODULE_DEVICE_TABLE(eisa, ne3210_ids);
 
 static struct eisa_driver ne3210_eisa_driver = {
 	.id_table = ne3210_ids,
--- linux-2.6.17/drivers/scsi/aic7xxx/aic7770_osm.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/scsi/aic7xxx/aic7770_osm.c	2006-07-05 11:37:52.000000000 +0400
@@ -132,7 +132,8 @@ static struct eisa_device_id aic7770_ids
 	{ "ADP7770", 5 }, /* AIC7770 generic */
 	{ "" }
 };
-  
+MODULE_DEVICE_TABLE(eisa, aic7770_ids);
+
 static struct eisa_driver aic7770_driver = {
 	.id_table	= aic7770_ids,
 	.driver = {
--- linux-2.6.17/drivers/scsi/aha1740.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/scsi/aha1740.c	2006-07-05 11:37:23.000000000 +0400
@@ -681,6 +681,7 @@ static struct eisa_device_id aha1740_ids
 	{ "ADP0400" },		/* 1744  */
 	{ "" }
 };
+MODULE_DEVICE_TABLE(eisa, aha1740_ids);
 
 static struct eisa_driver aha1740_driver = {
 	.id_table = aha1740_ids,
--- linux-2.6.17/drivers/scsi/sim710.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/drivers/scsi/sim710.c	2006-07-05 11:38:18.000000000 +0400
@@ -283,6 +283,7 @@ static struct eisa_device_id sim710_eisa
 	{ "HWP0C80" },
 	{ "" }
 };
+MODULE_DEVICE_TABLE(eisa, sim710_eisa_ids);
 
 static __init int
 sim710_eisa_probe(struct device *dev)
--- linux-2.6.17/include/linux/eisa.h~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/include/linux/eisa.h	2006-07-05 11:51:26.000000000 +0400
@@ -3,8 +3,8 @@
 
 #include <linux/ioport.h>
 #include <linux/device.h>
+#include <linux/mod_devicetable.h>
 
-#define EISA_SIG_LEN   8
 #define EISA_MAX_SLOTS 8
 
 #define EISA_MAX_RESOURCES 4
@@ -27,12 +27,6 @@
 #define EISA_CONFIG_ENABLED         1
 #define EISA_CONFIG_FORCED          2
 
-/* The EISA signature, in ASCII form, null terminated */
-struct eisa_device_id {
-	char          sig[EISA_SIG_LEN];
-	unsigned long driver_data;
-};
-
 /* There is not much we can say about an EISA device, apart from
  * signature, slot number, and base address. dma_mask is set by
  * default to parent device mask..*/
--- linux-2.6.17/include/linux/mod_devicetable.h~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/include/linux/mod_devicetable.h	2006-07-05 11:47:52.000000000 +0400
@@ -297,4 +297,16 @@ struct input_device_id {
 	kernel_ulong_t driver_info;
 };
 
+/* EISA */
+
+#define EISA_SIG_LEN   8
+
+/* The EISA signature, in ASCII form, null terminated */
+struct eisa_device_id {
+	char          sig[EISA_SIG_LEN];
+	unsigned long driver_data;
+};
+
+#define EISA_DEVICE_MODALIAS_FMT "eisa:s%s"
+
 #endif /* LINUX_MOD_DEVICETABLE_H */
--- linux-2.6.17/scripts/mod/file2alias.c~	2006-06-18 05:49:35.000000000 +0400
+++ linux-2.6.17/scripts/mod/file2alias.c	2006-07-05 11:55:34.000000000 +0400
@@ -421,6 +421,13 @@ static int do_input_entry(const char *fi
 	return 1;
 }
 
+static int do_eisa_entry(const char *filename, struct eisa_device_id *eisa,
+		char *alias)
+{
+	sprintf(alias, EISA_DEVICE_MODALIAS_FMT "*", eisa->sig);
+	return 1;
+}
+
 /* Ignore any prefix, eg. v850 prepends _ */
 static inline int sym_is(const char *symbol, const char *name)
 {
@@ -511,6 +518,9 @@ void handle_moddevtable(struct module *m
 	else if (sym_is(symname, "__mod_input_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct input_device_id),
 			 do_input_entry, mod);
+	else if (sym_is(symname, "__mod_eisa_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct eisa_device_id),
+			 do_eisa_entry, mod);
 }
 
 /* Now add out buffered information to the generated C source */
