Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261639AbSJ2Sjh>; Tue, 29 Oct 2002 13:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbSJ2Sjh>; Tue, 29 Oct 2002 13:39:37 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34829 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261639AbSJ2Sjb>;
	Tue, 29 Oct 2002 13:39:31 -0500
Date: Tue, 29 Oct 2002 10:43:19 -0800
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PNP driver changes for 2.5.44
Message-ID: <20021029184318.GB27082@kroah.com>
References: <20021029184010.GA27082@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021029184010.GA27082@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.808.4.1, 2002/10/21 11:39:24-07:00, ambx1@neo.rr.com

[PATCH] PnP Rewrite Fixes - 2.5.44

This patch addresses a few minor issues for the Linux Plug and Play Rewrite.  It
is against 2.5.44.

They are as follows.

1.) fix Config.in file - from Adrian Bunk and Roman Zippel
2.) if unable to activate a device the match should fail.  This can be done now
that the driver model matching bug has been corrected.
3.) move compat.c to isapnp directory and fix everything accordingly - suggested
by Stelian Pop.  This fixes a compile error if ISAPNP is disabled.
4.) fix a typo in pnp.h - patch from Skip Ford

Please Apply,
Adam


diff -Nru a/drivers/pnp/Config.in b/drivers/pnp/Config.in
--- a/drivers/pnp/Config.in	Tue Oct 29 10:39:05 2002
+++ b/drivers/pnp/Config.in	Tue Oct 29 10:39:05 2002
@@ -4,15 +4,17 @@
 mainmenu_option next_comment
 comment 'Plug and Play configuration'
 
-dep_bool 'Plug and Play support' CONFIG_PNP
+bool 'Plug and Play support' CONFIG_PNP
 
-   dep_bool '  Plug and Play device name database' CONFIG_PNP_NAMES $CONFIG_PNP
-   dep_bool '  PnP Debug Messages' CONFIG_PNP_DEBUG $CONFIG_PNP
+if [ "$CONFIG_PNP" = "y" ]; then
+   bool '  Plug and Play device name database' CONFIG_PNP_NAMES
+   bool '  PnP Debug Messages' CONFIG_PNP_DEBUG
 
-comment 'Protocols' $CONFIG_PNP
+   comment 'Protocols'
 
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-   dep_bool '  ISA Plug and Play support (EXPERIMENTAL)' CONFIG_ISAPNP $CONFIG_PNP
-   dep_bool '  Plug and Play BIOS support (EXPERIMENTAL)' CONFIG_PNPBIOS $CONFIG_PNP
+   if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
+      bool '  ISA Plug and Play support (EXPERIMENTAL)' CONFIG_ISAPNP
+      bool '  Plug and Play BIOS support (EXPERIMENTAL)' CONFIG_PNPBIOS
+   fi
 fi
 endmenu
diff -Nru a/drivers/pnp/Makefile b/drivers/pnp/Makefile
--- a/drivers/pnp/Makefile	Tue Oct 29 10:39:05 2002
+++ b/drivers/pnp/Makefile	Tue Oct 29 10:39:05 2002
@@ -2,11 +2,11 @@
 # Makefile for the Linux Plug-and-Play Support.
 #
 
-obj-y		:= core.o driver.o resource.o interface.o quirks.o names.o compat.o system.o
+obj-y		:= core.o driver.o resource.o interface.o quirks.o names.o system.o
 
 obj-$(CONFIG_PNPBIOS)		+= pnpbios/
 obj-$(CONFIG_ISAPNP)		+= isapnp/
 
-export-objs	:= core.o driver.o resource.o compat.o
+export-objs	:= core.o driver.o resource.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/pnp/base.h b/drivers/pnp/base.h
--- a/drivers/pnp/base.h	Tue Oct 29 10:39:05 2002
+++ b/drivers/pnp/base.h	Tue Oct 29 10:39:05 2002
@@ -4,8 +4,5 @@
 extern int pnp_interface_attach_device(struct pnp_dev *dev);
 extern void pnp_name_device(struct pnp_dev *dev);
 extern void pnp_fixup_device(struct pnp_dev *dev);
-extern int compare_pnp_id(struct list_head * id_list, char * id);
 extern void pnp_free_ids(struct pnp_dev *dev);
 extern void pnp_free_resources(struct pnp_resources *resources);
-
-
diff -Nru a/drivers/pnp/compat.c b/drivers/pnp/compat.c
--- a/drivers/pnp/compat.c	Tue Oct 29 10:39:05 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,94 +0,0 @@
-/*
- * compat.c - A series of functions to make it easier to convert drivers that use
- *            the old isapnp APIs. If possible use the new APIs instead.
- *
- * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
- *
- */
- 
-/* TODO: see if more isapnp functions are needed here */
-
-#include <linux/pnp.h>
-#include <linux/isapnp.h>
-#include <linux/string.h>
-#include <linux/module.h>
-#include "base.h"
-
-static void pnp_convert_id(char *buf, unsigned short vendor, unsigned short device)
-{
-	sprintf(buf, "%c%c%c%x%x%x%x",
-			'A' + ((vendor >> 2) & 0x3f) - 1,
-			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
-			'A' + ((vendor >> 8) & 0x1f) - 1,
-			(device >> 4) & 0x0f,
-			device & 0x0f,
-			(device >> 12) & 0x0f,
-			(device >> 8) & 0x0f);
-	return;
-}
-
-struct pnp_card *pnp_find_card(unsigned short vendor,
-				 unsigned short device,
-				 struct pnp_card *from)
-{
-	char id[7];
-	char any[7];
-	struct list_head *list;
-	pnp_convert_id(id, vendor, device);
-	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
-	list = isapnp_cards.next;
-	if (from)
-		list = from->node.next;
-
-	while (list != &isapnp_cards) {
-		struct pnp_card *card = to_pnp_card(list);
-		if (compare_pnp_id(&card->ids,id) || (memcmp(id,any,7)==0))
-			return card;
-		list = list->next;
-	}
-	return NULL;
-}
-
-struct pnp_dev *pnp_find_dev(struct pnp_card *card,
-				unsigned short vendor,
-				unsigned short function,
-				struct pnp_dev *from)
-{
-	char id[7];
-	char any[7];
-	pnp_convert_id(id, vendor, function);
-	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
-	if (card == NULL) {	/* look for a logical device from all cards */
-		struct list_head *list;
-
-		list = pnp_global.next;
-		if (from)
-			list = from->global_list.next;
-
-		while (list != &pnp_global) {
-			struct pnp_dev *dev = global_to_pnp_dev(list);
-			if (compare_pnp_id(&dev->ids,id) || (memcmp(id,any,7)==0))
-				return dev;
-			list = list->next;
-		}
-	} else {
-		struct list_head *list;
-
-		list = card->devices.next;
-		if (from) {
-			list = from->card_list.next;
-			if (from->card != card)	/* something is wrong */
-				return NULL;
-		}
-		while (list != &card->devices) {
-			struct pnp_dev *dev = card_to_pnp_dev(list);
-			if (compare_pnp_id(&dev->ids,id))
-				return dev;
-			list = list->next;
-		}
-	}
-	return NULL;
-}
-
-EXPORT_SYMBOL(pnp_find_card);
-EXPORT_SYMBOL(pnp_find_dev);
diff -Nru a/drivers/pnp/driver.c b/drivers/pnp/driver.c
--- a/drivers/pnp/driver.c	Tue Oct 29 10:39:05 2002
+++ b/drivers/pnp/driver.c	Tue Oct 29 10:39:05 2002
@@ -93,7 +93,7 @@
 
 	if (pnp_dev->active == 0)
 		if(pnp_activate_dev(pnp_dev)<0)
-			return 0;
+			return -1;
 	if (pnp_drv->probe && pnp_dev->active) {
 		if (pnp_dev->card && pnp_drv->card_id_table){
 			card_id = match_card(pnp_drv, pnp_dev->card);
diff -Nru a/drivers/pnp/isapnp/Makefile b/drivers/pnp/isapnp/Makefile
--- a/drivers/pnp/isapnp/Makefile	Tue Oct 29 10:39:05 2002
+++ b/drivers/pnp/isapnp/Makefile	Tue Oct 29 10:39:05 2002
@@ -2,10 +2,10 @@
 # Makefile for the kernel ISAPNP driver.
 #
 
-export-objs := core.o
+export-objs := core.o compat.o
 
 isapnp-proc-$(CONFIG_PROC_FS) = proc.o
 
-obj-y := core.o $(isapnp-proc-y)
+obj-y := core.o compat.o $(isapnp-proc-y)
 
 include $(TOPDIR)/Rules.make
diff -Nru a/drivers/pnp/isapnp/compat.c b/drivers/pnp/isapnp/compat.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/pnp/isapnp/compat.c	Tue Oct 29 10:39:05 2002
@@ -0,0 +1,93 @@
+/*
+ * compat.c - A series of functions to make it easier to convert drivers that use
+ *            the old isapnp APIs. If possible use the new APIs instead.
+ *
+ * Copyright 2002 Adam Belay <ambx1@neo.rr.com>
+ *
+ */
+ 
+/* TODO: see if more isapnp functions are needed here */
+
+#include <linux/pnp.h>
+#include <linux/isapnp.h>
+#include <linux/string.h>
+#include <linux/module.h>
+
+static void pnp_convert_id(char *buf, unsigned short vendor, unsigned short device)
+{
+	sprintf(buf, "%c%c%c%x%x%x%x",
+			'A' + ((vendor >> 2) & 0x3f) - 1,
+			'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
+			'A' + ((vendor >> 8) & 0x1f) - 1,
+			(device >> 4) & 0x0f,
+			device & 0x0f,
+			(device >> 12) & 0x0f,
+			(device >> 8) & 0x0f);
+	return;
+}
+
+struct pnp_card *pnp_find_card(unsigned short vendor,
+				 unsigned short device,
+				 struct pnp_card *from)
+{
+	char id[7];
+	char any[7];
+	struct list_head *list;
+	pnp_convert_id(id, vendor, device);
+	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
+	list = isapnp_cards.next;
+	if (from)
+		list = from->node.next;
+
+	while (list != &isapnp_cards) {
+		struct pnp_card *card = to_pnp_card(list);
+		if (compare_pnp_id(&card->ids,id) || (memcmp(id,any,7)==0))
+			return card;
+		list = list->next;
+	}
+	return NULL;
+}
+
+struct pnp_dev *pnp_find_dev(struct pnp_card *card,
+				unsigned short vendor,
+				unsigned short function,
+				struct pnp_dev *from)
+{
+	char id[7];
+	char any[7];
+	pnp_convert_id(id, vendor, function);
+	pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
+	if (card == NULL) {	/* look for a logical device from all cards */
+		struct list_head *list;
+
+		list = pnp_global.next;
+		if (from)
+			list = from->global_list.next;
+
+		while (list != &pnp_global) {
+			struct pnp_dev *dev = global_to_pnp_dev(list);
+			if (compare_pnp_id(&dev->ids,id) || (memcmp(id,any,7)==0))
+				return dev;
+			list = list->next;
+		}
+	} else {
+		struct list_head *list;
+
+		list = card->devices.next;
+		if (from) {
+			list = from->card_list.next;
+			if (from->card != card)	/* something is wrong */
+				return NULL;
+		}
+		while (list != &card->devices) {
+			struct pnp_dev *dev = card_to_pnp_dev(list);
+			if (compare_pnp_id(&dev->ids,id))
+				return dev;
+			list = list->next;
+		}
+	}
+	return NULL;
+}
+
+EXPORT_SYMBOL(pnp_find_card);
+EXPORT_SYMBOL(pnp_find_dev);
diff -Nru a/include/linux/pnp.h b/include/linux/pnp.h
--- a/include/linux/pnp.h	Tue Oct 29 10:39:05 2002
+++ b/include/linux/pnp.h	Tue Oct 29 10:39:05 2002
@@ -227,25 +227,16 @@
 int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode);
 
 /* driver */
+int compare_pnp_id(struct list_head * id_list, const char * id);
 int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev);
 int pnp_register_driver(struct pnp_driver *drv);
 void pnp_unregister_driver(struct pnp_driver *drv);
 
-/* compat */
-struct pnp_card *pnp_find_card(unsigned short vendor,
-				 unsigned short device,
-				 struct pnp_card *from);
-struct pnp_dev *pnp_find_dev(struct pnp_card *card,
-				unsigned short vendor,
-				unsigned short function,
-				struct pnp_dev *from);
-
-
 #else
 
 /* just in case anyone decides to call these without PnP Support Enabled */
 static inline int pnp_protocol_register(struct pnp_protocol *protocol) { return -ENODEV; }
-static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; )
+static inline void pnp_protocol_unregister(struct pnp_protocol *protocol) { ; }
 static inline int pnp_init_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_add_device(struct pnp_dev *dev) { return -ENODEV; }
 static inline void pnp_remove_device(struct pnp_dev *dev) { ; }
@@ -260,9 +251,25 @@
 static inline int pnp_activate_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_disable_dev(struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_raw_set_dev(struct pnp_dev *dev, int depnum, int mode) { return -ENODEV; }
+static inline int compare_pnp_id(struct list_head * id_list, char * id) { return -ENODEV; }
 static inline int pnp_add_id(struct pnp_id *id, struct pnp_dev *dev) { return -ENODEV; }
 static inline int pnp_register_driver(struct pnp_driver *drv) { return -ENODEV; }
 static inline void pnp_unregister_driver(struct pnp_driver *drv) { ; }
+
+#endif /* CONFIG_PNP */
+
+#if defined(CONFIG_ISAPNP)
+/* compat */
+struct pnp_card *pnp_find_card(unsigned short vendor,
+				 unsigned short device,
+				 struct pnp_card *from);
+struct pnp_dev *pnp_find_dev(struct pnp_card *card,
+				unsigned short vendor,
+				unsigned short function,
+				struct pnp_dev *from);
+
+#else
+
 static inline struct pnp_card *pnp_find_card(unsigned short vendor,
 				 unsigned short device,
 				 struct pnp_card *from) { return NULL; }
@@ -271,7 +278,7 @@
 				unsigned short function,
 				struct pnp_dev *from) { return NULL; }
 
-#endif /* CONFIG_PNP */
+#endif /* CONFIG_ISAPNP */
 
 
 #ifdef DEBUG
