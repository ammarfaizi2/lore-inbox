Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbVHJKdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbVHJKdZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 06:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932571AbVHJKdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 06:33:21 -0400
Received: from relay.rost.ru ([80.254.111.11]:16277 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S932567AbVHJKc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 06:32:56 -0400
Subject: [PATCH 3/5] 2.6.13-rc5-mm1, add onboard devices discovery
In-Reply-To: <11236699713656@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 10 Aug 2005 14:32:53 +0400
Message-Id: <11236699731737@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       cminyard@mvista.com
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds onboard devices and IPMI BMC discovery into DMI scan code.
Drivers can use dmi_find_device() function to search for devices by type
and name.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |  102 ++++++++++++++++++++++++++++++++++++++------
 include/linux/dmi.h         |   34 +++++++++++++-
 2 files changed, 121 insertions(+), 15 deletions(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.13-rc5-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-08-09 14:39:13.000000000 +0400
+++ linux-2.6.13-rc5-mm1/arch/i386/kernel/dmi_scan.c	2005-08-09 15:07:57.000000000 +0400
@@ -6,13 +6,6 @@
 #include <linux/bootmem.h>
 
 
-struct dmi_header {
-	u8 type;
-	u8 length;
-	u16 handle;
-};
-
-
 static char * __init dmi_string(struct dmi_header *dm, u8 s)
 {
 	u8 *bp = ((u8 *) dm) + dm->length;
@@ -88,6 +81,7 @@ static int __init dmi_checksum(u8 *buf)
 }
 
 static char *dmi_ident[DMI_STRING_MAX];
+static LIST_HEAD(dmi_devices);
 
 /*
  *	Save a DMI string
@@ -106,6 +100,58 @@ static void __init dmi_save_ident(struct
 	dmi_ident[slot] = p;
 }
 
+static void __init dmi_save_devices(struct dmi_header *dm)
+{
+	int i, count = (dm->length - sizeof(struct dmi_header)) / 2;
+	struct dmi_device *dev;
+
+	for (i = 0; i < count; i++) {
+		char *d = ((char *) dm) + (i * 2);
+
+		/* Skip disabled device */
+		if ((*d & 0x80) == 0)
+			continue;
+
+		dev = alloc_bootmem(sizeof(*dev));
+		if (!dev) {
+			printk(KERN_ERR "dmi_save_devices: out of memory.\n");
+			break;
+		}
+
+		dev->type = *d++ & 0x7f;
+		dev->name = dmi_string(dm, *d);
+		dev->device_data = NULL;
+
+		list_add(&dev->list, &dmi_devices);
+	}
+}
+
+static void __init dmi_save_ipmi_device(struct dmi_header *dm)
+{
+	struct dmi_device *dev;
+	void * data;
+
+	data = alloc_bootmem(dm->length);
+	if (data == NULL) {
+		printk(KERN_ERR "dmi_save_ipmi_device: out of memory.\n");
+		return;
+	}
+
+	memcpy(data, dm, dm->length);
+
+	dev = alloc_bootmem(sizeof(*dev));
+	if (!dev) {
+		printk(KERN_ERR "dmi_save_ipmi_device: out of memory.\n");
+		return;
+	}
+
+	dev->type = DMI_DEV_TYPE_IPMI;
+	dev->name = "IPMI controller";
+	dev->device_data = data;
+
+	list_add(&dev->list, &dmi_devices);
+}
+
 /*
  *	Process a DMI table entry. Right now all we care about are the BIOS
  *	and machine entries. For 2.5 we should pull the smbus controller info
@@ -113,25 +159,28 @@ static void __init dmi_save_ident(struct
  */
 static void __init dmi_decode(struct dmi_header *dm)
 {
-	u8 *data __attribute__((__unused__)) = (u8 *)dm;
-	
 	switch(dm->type) {
-	case  0:
+	case 0:		/* BIOS Information */
 		dmi_save_ident(dm, DMI_BIOS_VENDOR, 4);
 		dmi_save_ident(dm, DMI_BIOS_VERSION, 5);
 		dmi_save_ident(dm, DMI_BIOS_DATE, 8);
 		break;
-	case 1:
+	case 1:		/* System Information */
 		dmi_save_ident(dm, DMI_SYS_VENDOR, 4);
 		dmi_save_ident(dm, DMI_PRODUCT_NAME, 5);
 		dmi_save_ident(dm, DMI_PRODUCT_VERSION, 6);
 		dmi_save_ident(dm, DMI_PRODUCT_SERIAL, 7);
 		break;
-	case 2:
+	case 2:		/* Base Board Information */
 		dmi_save_ident(dm, DMI_BOARD_VENDOR, 4);
 		dmi_save_ident(dm, DMI_BOARD_NAME, 5);
 		dmi_save_ident(dm, DMI_BOARD_VERSION, 6);
 		break;
+	case 10:	/* Onboard Devices Information */
+		dmi_save_devices(dm);
+		break;
+	case 38:	/* IPMI Device Information */
+		dmi_save_ipmi_device(dm);
 	}
 }
 
@@ -221,3 +270,32 @@ char *dmi_get_system_info(int field)
 	return dmi_ident[field];
 }
 EXPORT_SYMBOL(dmi_get_system_info);
+
+/**
+ *	dmi_find_device - find onboard device by type/name
+ *	@type: device type or %DMI_DEV_TYPE_ANY to match all device types
+ *	@desc: device name string or %NULL to match all
+ *	@from: previous device found in search, or %NULL for new search.
+ *
+ *	Iterates through the list of known onboard devices. If a device is
+ *	found with a matching @vendor and @device, a pointer to its device
+ *	structure is returned.  Otherwise, %NULL is returned.
+ *	A new search is initiated by passing %NULL to the @from argument.
+ *	If @from is not %NULL, searches continue from next device.
+ */
+struct dmi_device * dmi_find_device(int type, const char *name,
+				    struct dmi_device *from)
+{
+	struct list_head *d, *head = from ? &from->list : &dmi_devices;
+
+	for(d = head->next; d != &dmi_devices; d = d->next) {
+		struct dmi_device *dev = list_entry(d, struct dmi_device, list);
+
+		if (((type == DMI_DEV_TYPE_ANY) || (dev->type == type)) &&
+		    ((name == NULL) || (strcmp(dev->name, name) == 0)))
+			return dev;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(dmi_find_device);
diff -urdpNX /usr/share/dontdiff linux-2.6.13-rc5-mm1.vanilla/include/linux/dmi.h linux-2.6.13-rc5-mm1/include/linux/dmi.h
--- linux-2.6.13-rc5-mm1.vanilla/include/linux/dmi.h	2005-06-12 23:08:16.000000000 +0400
+++ linux-2.6.13-rc5-mm1/include/linux/dmi.h	2005-06-12 22:45:19.000000000 +0400
@@ -16,6 +16,24 @@ enum dmi_field {
 	DMI_STRING_MAX,
 };
 
+enum dmi_device_type {
+	DMI_DEV_TYPE_ANY = 0,
+	DMI_DEV_TYPE_OTHER,
+	DMI_DEV_TYPE_UNKNOWN,
+	DMI_DEV_TYPE_VIDEO,
+	DMI_DEV_TYPE_SCSI,
+	DMI_DEV_TYPE_ETHERNET,
+	DMI_DEV_TYPE_TOKENRING,
+	DMI_DEV_TYPE_SOUND,
+	DMI_DEV_TYPE_IPMI = -1
+};
+
+struct dmi_header {
+	u8 type;
+	u8 length;
+	u16 handle;
+};
+
 /*
  *	DMI callbacks for problem boards
  */
@@ -26,22 +44,32 @@ struct dmi_strmatch {
 
 struct dmi_system_id {
 	int (*callback)(struct dmi_system_id *);
-	char *ident;
+	const char *ident;
 	struct dmi_strmatch matches[4];
 	void *driver_data;
 };
 
-#define DMI_MATCH(a,b)	{ a, b }
+#define DMI_MATCH(a, b)	{ a, b }
+
+struct dmi_device {
+	struct list_head list;
+	int type;
+	const char *name;
+	void *device_data;	/* Type specific data */
+};
 
 #if defined(CONFIG_X86) && !defined(CONFIG_X86_64)
 
 extern int dmi_check_system(struct dmi_system_id *list);
 extern char * dmi_get_system_info(int field);
-
+extern struct dmi_device * dmi_find_device(int type, const char *name,
+	struct dmi_device *from);
 #else
 
 static inline int dmi_check_system(struct dmi_system_id *list) { return 0; }
 static inline char * dmi_get_system_info(int field) { return NULL; }
+static struct dmi_device * dmi_find_device(int type, const char *name,
+	struct dmi_device *from) { return NULL; }
 
 #endif
 

