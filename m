Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261984AbVDEUeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261984AbVDEUeq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVDEUbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:31:41 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:37545 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261945AbVDEUGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:06:09 -0400
Message-Id: <20050405194446.284170000@delft.aura.cs.cmu.edu>
References: <20050405193859.506836000@delft.aura.cs.cmu.edu>
Date: Tue, 05 Apr 2005 15:39:02 -0400
From: Jan Harkes <jaharkes@cs.cmu.edu>
To: Greg KH <greg@kroah.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: jaharkes@cs.cmu.edu, Dmitry Torokhov <dtor_core@ameritech.net>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: [patch 3/5] Hotplug firmware loader for Keyspan usb-serial driver
Content-Disposition: inline; filename=keyspan-dumpfw
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Simple program to convert the keyspan firmware header files to IHEX
formatted files that can be loaded with hotplug.

This is really only needed once to convert the existing keyspan firmware
headers, which is what the next patch does.


Index: linux/drivers/usb/serial/dumpfw.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/drivers/usb/serial/dumpfw.c	2005-03-10 23:16:37.240765747 -0500
@@ -0,0 +1,98 @@
+/*
+ * Convert keyspan firmware header files to Intel HEX format
+ * cc -I/usr/src/linux/drivers/usb/serial -o dumpfw dumpfw.c
+ */
+#include <stdint.h>
+#include <stdio.h>
+
+//#include "keyspan.h" /* ezusb_hex_record */
+
+struct ezusb_hex_record {
+    uint16_t address;
+    uint8_t  size;
+    uint8_t  data[64];
+};
+
+#include "keyspan_usa28_fw.h"
+#include "keyspan_usa28x_fw.h"
+#include "keyspan_usa28xa_fw.h"
+#include "keyspan_usa28xb_fw.h"
+#include "keyspan_usa19_fw.h"
+#include "keyspan_usa19qi_fw.h"
+#include "keyspan_mpr_fw.h"
+#include "keyspan_usa19qw_fw.h"
+#include "keyspan_usa18x_fw.h"
+#include "keyspan_usa19w_fw.h"
+#include "keyspan_usa49w_fw.h"
+#include "keyspan_usa49wlc_fw.h"
+
+char *boilerplate = "\
+# This firmware for the Keyspan %s USB-to-Serial adapter is\n\
+#\n\
+#    Copyright (C) 1999-2003\n\
+#    Keyspan, A division of InnoSys Incorporated (\"Keyspan\")\n\
+#\n\
+# as an unpublished work. This notice does not imply unrestricted or\n\
+# public access to the source code from which this firmware image is\n\
+# derived.  Except as noted below this firmware image may not be\n\
+# reproduced, used, sold or transferred to any third party without\n\
+# Keyspan's prior written consent.  All Rights Reserved.\n\
+#\n\
+# Permission is hereby granted for the distribution of this firmware\n\
+# image as part of a Linux or other Open Source operating system kernel\n\
+# in text or binary form as required.\n\
+#\n\
+# This firmware may not be modified and may only be used with\n\
+# Keyspan hardware.  Distribution of this firmware, in whole or in\n\
+# part, requires the inclusion of this statement.\n\
+#\n";
+
+void dumpfw(char *name, const struct ezusb_hex_record *record)
+{
+    char fw_name[20];
+    char NAME[10];
+    uint16_t address, i;
+    uint8_t crc;
+    FILE *f;
+
+    for (i = 0; name[i] != '\0'; i++)
+	NAME[i] = toupper(name[i]);
+    NAME[i] = '\0';
+
+    sprintf(fw_name, "keyspan-%s.fw", name);
+    printf("writing %s\n", fw_name);
+
+    f = fopen(fw_name, "w");
+    fprintf(f, boilerplate, NAME);
+
+    while (record->address != 0xffff) {
+	crc = record->size + (record->address >> 8) + record->address;
+	fprintf(f, ":%02X%04X00", record->size, record->address);
+	for (i = 0; i < record->size; i++) {
+	    fprintf(f, "%02X", record->data[i]);
+	    crc += record->data[i];
+	}
+	fprintf(f, "%02X\n", (uint8_t)-crc);
+	record++;
+    }
+    fprintf(f, ":00000001FF\n");
+
+    fclose(f);
+}
+
+int main(int argc, char **argv)
+{
+    dumpfw("mpr",	keyspan_mpr_firmware);
+    dumpfw("usa18x",	keyspan_usa18x_firmware);
+    dumpfw("usa19",	keyspan_usa19_firmware);
+    dumpfw("usa19qi",	keyspan_usa19qi_firmware);
+    dumpfw("usa19qw",	keyspan_usa19qw_firmware);
+    dumpfw("usa19w",	keyspan_usa19w_firmware);
+    dumpfw("usa28",	keyspan_usa28_firmware);
+    dumpfw("usa28x",	keyspan_usa28x_firmware);
+    dumpfw("usa28xa",	keyspan_usa28xa_firmware);
+    dumpfw("usa28xb",	keyspan_usa28xb_firmware);
+    dumpfw("usa49w",	keyspan_usa49w_firmware);
+    dumpfw("usa49wlc",	keyspan_usa49wlc_firmware);
+}
+

--

