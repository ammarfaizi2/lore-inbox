Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261895AbTCaXMj>; Mon, 31 Mar 2003 18:12:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbTCaXMi>; Mon, 31 Mar 2003 18:12:38 -0500
Received: from dp.samba.org ([66.70.73.150]:13469 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261895AbTCaXMf>;
	Mon, 31 Mar 2003 18:12:35 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re-xmit: PCI IDs module alias fix
Date: Tue, 01 Apr 2003 09:18:01 +1000
Message-Id: <20030331232358.F38B52C003@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please apply (OK'd by Greg Kroah-Hartmann).

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Subdivide PCI class for aliases
Author: Rusty Russell
Status: Tested on 2.5.66-bk2

D: The previous handling of PCI class masks was too primitive: the
D: class field is not "all or nothing" but has base class, subclass
D: and interface fields.  This patch changes the alias form from:
D: pci:vNdNsvNsdNcN to pci:vNdNsvNsdNbcNscNiN.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.66-bk2/scripts/file2alias.c working-2.5.66-bk2-pci-alias/scripts/file2alias.c
--- linux-2.5.66-bk2/scripts/file2alias.c	2003-02-18 11:18:57.000000000 +1100
+++ working-2.5.66-bk2-pci-alias/scripts/file2alias.c	2003-03-27 16:35:37.000000000 +1100
@@ -81,10 +81,14 @@ static int do_usb_entry(const char *file
 	return 1;
 }
 
-/* Looks like: pci:vNdNsvNsdNcN. */
+/* Looks like: pci:vNdNsvNsdNbcNscNiN. */
 static int do_pci_entry(const char *filename,
 			struct pci_device_id *id, char *alias)
 {
+	/* Class field can be divided into these three. */
+	unsigned char baseclass, subclass, interface,
+		baseclass_mask, subclass_mask, interface_mask;
+
 	id->vendor = TO_NATIVE(id->vendor);
 	id->device = TO_NATIVE(id->device);
 	id->subvendor = TO_NATIVE(id->subvendor);
@@ -97,13 +101,26 @@ static int do_pci_entry(const char *file
 	ADD(alias, "d", id->device != PCI_ANY_ID, id->device);
 	ADD(alias, "sv", id->subvendor != PCI_ANY_ID, id->subvendor);
 	ADD(alias, "sd", id->subdevice != PCI_ANY_ID, id->subdevice);
-	if (id->class_mask != 0 && id->class_mask != ~0) {
+
+	baseclass = (id->class) >> 16;
+	baseclass_mask = (id->class_mask) >> 16;
+	subclass = (id->class) >> 8;
+	subclass_mask = (id->class_mask) >> 8;
+	interface = id->class;
+	interface_mask = id->class_mask;
+
+	if ((baseclass_mask != 0 && baseclass_mask != 0xFF)
+	    || (subclass_mask != 0 && subclass_mask != 0xFF)
+	    || (interface_mask != 0 && interface_mask != 0xFF)) {
 		fprintf(stderr,
-			"*** Warning: Can't handle class_mask in %s:%04X\n",
+			"*** Warning: Can't handle masks in %s:%04X\n",
 			filename, id->class_mask);
 		return 0;
 	}
-	ADD(alias, "c", id->class_mask == ~0, id->class);
+
+	ADD(alias, "bc", baseclass_mask == 0xFF, baseclass);
+	ADD(alias, "sc", subclass_mask == 0xFF, subclass);
+	ADD(alias, "i", interface_mask == 0xFF, interface);
 	return 1;
 }
 

