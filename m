Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbTEBN27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 09:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbTEBN26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 09:28:58 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:53721 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262902AbTEBN25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 09:28:57 -0400
Date: Fri, 2 May 2003 09:18:30 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] IEEE1394 file2alias additions
Message-ID: <20030502131830.GD543@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As suggested by Rusty, here's additions for ieee1394's module id table.


Index: scripts/file2alias.c
===================================================================
RCS file: /home/scm/linux-2.5/scripts/file2alias.c,v
retrieving revision 1.3
diff -u -u -r1.3 file2alias.c
--- linux/scripts/file2alias.c	2 Apr 2003 04:42:38 -0000	1.3
+++ linux/scripts/file2alias.c	2 May 2003 13:39:04 -0000
@@ -81,6 +81,29 @@
 	return 1;
 }
 
+/* Looks like: ieee1394:venNmoNspNverN */
+static int do_ieee1394_entry(const char *filename,
+			     struct ieee1394_device_id *id, char *alias)
+{
+	id->match_flags = TO_NATIVE(id->match_flags);
+	id->vendor_id = TO_NATIVE(id->vendor_id);
+	id->model_id = TO_NATIVE(id->model_id);
+	id->specifier_id = TO_NATIVE(id->specifier_id);
+	id->version = TO_NATIVE(id->version);
+
+	strcpy(alias, "ieee1394:");
+	ADD(alias, "ven", id->match_flags & IEEE1394_MATCH_VENDOR_ID,
+	    id->vendor_id);
+	ADD(alias, "mo", id->match_flags & IEEE1394_MATCH_MODEL_ID,
+	    id->model_id);
+	ADD(alias, "sp", id->match_flags & IEEE1394_MATCH_SPECIFIER_ID,
+	    id->specifier_id);
+	ADD(alias, "ver", id->match_flags & IEEE1394_MATCH_VERSION,
+	    id->version);
+
+	return 1;
+}
+
 /* Looks like: pci:vNdNsvNsdNbcNscNiN. */
 static int do_pci_entry(const char *filename,
 			struct pci_device_id *id, char *alias)
@@ -184,6 +207,9 @@
 	else if (sym_is(symname, "__mod_usb_device_table"))
 		do_table(symval, sym->st_size, sizeof(struct usb_device_id),
 			 do_usb_entry, mod);
+	else if (sym_is(symname, "__mod_ieee1394_device_table"))
+		do_table(symval, sym->st_size, sizeof(struct ieee1394_device_id),
+			 do_ieee1394_entry, mod);
 }
 
 /* Now add out buffered information to the generated C source */
Index: include/linux/mod_devicetable.h
===================================================================
RCS file: /home/scm/linux-2.5/include/linux/mod_devicetable.h,v
retrieving revision 1.2
diff -u -u -r1.2 mod_devicetable.h
--- linux/include/linux/mod_devicetable.h	16 Feb 2003 00:10:07 -0000	1.2
+++ linux/include/linux/mod_devicetable.h	2 May 2003 13:39:04 -0000
@@ -21,6 +21,22 @@
 	kernel_ulong_t driver_data;	/* Data private to the driver */
 };
 
+
+#define IEEE1394_MATCH_VENDOR_ID	0x0001
+#define IEEE1394_MATCH_MODEL_ID		0x0002
+#define IEEE1394_MATCH_SPECIFIER_ID	0x0004
+#define IEEE1394_MATCH_VERSION		0x0008
+
+struct ieee1394_device_id {
+	__u32 match_flags;
+	__u32 vendor_id;
+	__u32 model_id;
+	__u32 specifier_id;
+	__u32 version;
+	kernel_ulong_t driver_data;
+};
+
+
 /*
  * Device table entry for "new style" table-driven USB drivers.
  * User mode code can read these tables to choose which modules to load.
