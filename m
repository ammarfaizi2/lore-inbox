Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWGDQyU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWGDQyU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:54:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbWGDQyR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:54:17 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:13964 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932302AbWGDQyH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:54:07 -0400
Date: Tue, 4 Jul 2006 18:54:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, rwuerthn@de.ibm.com,
       cornelia.huck@de.ibm.com
Subject: [patch 5/6] s390: zcrypt driver Makefile, Kconfig and monolithic build.
Message-ID: <20060704165408.GF6202@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Ralph Wuerthner <rwuerthn@de.ibm.com>
From: Cornelia Huck <cornelia.huck@de.ibm.com>

[patch 5/6] s390: zcrypt driver Makefile, Kconfig and monolithic build.

The Makefile and Kconfig changes should be obvious. The monolithic
build option is there to create an old-style z90crypt module for
backward compatability to older distributions.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/Kconfig              |   20 +++++++
 drivers/s390/crypto/Makefile      |   13 ++++
 drivers/s390/crypto/zcrypt_mono.c |  100 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 133 insertions(+)

diff -urpN linux-2.6/drivers/s390/crypto/Makefile linux-2.6-patched/drivers/s390/crypto/Makefile
--- linux-2.6/drivers/s390/crypto/Makefile	2006-07-04 18:31:34.000000000 +0200
+++ linux-2.6-patched/drivers/s390/crypto/Makefile	2006-07-04 18:32:54.000000000 +0200
@@ -2,3 +2,16 @@
 # S/390 crypto devices
 #
 
+ifdef CONFIG_ZCRYPT_MONOLITHIC
+
+z90crypt-objs := zcrypt_mono.o ap_bus.o zcrypt_api.o \
+		zcrypt_pcica.o zcrypt_pcicc.o zcrypt_pcixcc.o zcrypt_cex2a.o
+obj-$(CONFIG_ZCRYPT) += z90crypt.o
+
+else
+
+ap-objs := ap_bus.o
+obj-$(CONFIG_ZCRYPT) += ap.o zcrypt_api.o zcrypt_pcicc.o zcrypt_pcixcc.o
+obj-$(CONFIG_ZCRYPT) += zcrypt_pcica.o zcrypt_cex2a.o
+
+endif
diff -urpN linux-2.6/drivers/s390/crypto/zcrypt_mono.c linux-2.6-patched/drivers/s390/crypto/zcrypt_mono.c
--- linux-2.6/drivers/s390/crypto/zcrypt_mono.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/crypto/zcrypt_mono.c	2006-07-04 18:32:54.000000000 +0200
@@ -0,0 +1,100 @@
+/*
+ *  linux/drivers/s390/crypto/zcrypt_mono.c
+ *
+ *  zcrypt 2.0.0
+ *
+ *  Copyright (C)  2001, 2006 IBM Corporation
+ *  Author(s): Robert Burroughs
+ *	       Eric Rossman (edrossma@us.ibm.com)
+ *
+ *  Hotplug & misc device support: Jochen Roehrig (roehrig@de.ibm.com)
+ *  Major cleanup & driver split: Martin Schwidefsky <schwidefsky@de.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/proc_fs.h>
+#include <linux/compat.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#include "ap_bus.h"
+#include "zcrypt_api.h"
+#include "zcrypt_pcica.h"
+#include "zcrypt_pcicc.h"
+#include "zcrypt_pcixcc.h"
+#include "zcrypt_cex2a.h"
+
+/**
+ * The module initialization code.
+ */
+int __init zcrypt_init(void)
+{
+	int rc;
+
+	rc = ap_module_init();
+	if (rc)
+		goto out;
+	rc = zcrypt_api_init();
+	if (rc)
+		goto out_ap;
+	rc = zcrypt_pcica_init();
+	if (rc)
+		goto out_api;
+	rc = zcrypt_pcicc_init();
+	if (rc)
+		goto out_pcica;
+	rc = zcrypt_pcixcc_init();
+	if (rc)
+		goto out_pcicc;
+	rc = zcrypt_cex2a_init();
+	if (rc)
+		goto out_pcixcc;
+	return 0;
+
+out_pcixcc:
+	zcrypt_pcixcc_exit();
+out_pcicc:
+	zcrypt_pcicc_exit();
+out_pcica:
+	zcrypt_pcica_exit();
+out_api:
+	zcrypt_api_exit();
+out_ap:
+	ap_module_exit();
+out:
+	return rc;
+}
+
+/**
+ * The module termination code.
+ */
+void __exit zcrypt_exit(void)
+{
+	zcrypt_cex2a_exit();
+	zcrypt_pcixcc_exit();
+	zcrypt_pcicc_exit();
+	zcrypt_pcica_exit();
+	zcrypt_api_exit();
+	ap_module_exit();
+}
+
+module_init(zcrypt_init);
+module_exit(zcrypt_exit);
diff -urpN linux-2.6/drivers/s390/Kconfig linux-2.6-patched/drivers/s390/Kconfig
--- linux-2.6/drivers/s390/Kconfig	2006-07-04 18:31:34.000000000 +0200
+++ linux-2.6-patched/drivers/s390/Kconfig	2006-07-04 18:32:54.000000000 +0200
@@ -217,4 +217,24 @@ endmenu
 
 menu "Cryptographic devices"
 
+config ZCRYPT
+	tristate "Support for PCI-attached cryptographic adapters"
+	default "m"
+	help
+	  Select this option if you want to use a PCI-attached cryptographic
+	  adapter like:
+	  + PCI Cryptographic Accelerator (PCICA)
+	  + PCI Cryptographic Coprocessor (PCICC)
+	  + PCI-X Cryptographic Coprocessor (PCIXCC)
+	  + Crypto Express2 Coprocessor (CEX2C)
+	  + Crypto Express2 Accelerator (CEX2A)
+
+config ZCRYPT_MONOLITHIC
+	bool "Monolithic zcrypt module"
+	depends on ZCRYPT
+	help
+	  Select this option if you want to have a single module z90crypt.ko
+	  that contains all parts of the crypto device driver (ap bus,
+	  request router and all the card drivers).
+
 endmenu
