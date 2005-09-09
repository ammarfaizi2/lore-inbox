Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbVIITkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbVIITkT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbVIITkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:40:13 -0400
Received: from magic.adaptec.com ([216.52.22.17]:51910 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030362AbVIITj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:39:58 -0400
Message-ID: <4321E508.3080306@adaptec.com>
Date: Fri, 09 Sep 2005 15:39:52 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 4/14] sas-class: sas_common.c Common functions
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:39:57.0428 (UTC) FILETIME=[425FF340:01C5B576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/sas-class/sas_common.c linux-2.6.13/drivers/scsi/sas-class/sas_common.c
--- linux-2.6.13-orig/drivers/scsi/sas-class/sas_common.c	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/sas-class/sas_common.c	2005-09-09 11:14:29.000000000 -0400
@@ -0,0 +1,115 @@
+/*
+ * Serial Attached SCSI (SAS) class common functions
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of the
+ * License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
+ * USA
+ *
+ * $Id: //depot/sas-class/sas_common.c#8 $
+ */
+
+#include <scsi/sas/sas_class.h>
+#include "sas_internal.h"
+
+int sas_show_class(enum sas_class class, char *buf)
+{
+	static const char *class_str[] = {
+		[SAS] = "SAS",
+		[EXPANDER] = "EXPANDER",
+	};
+	return sprintf(buf, "%s\n", class_str[class]);
+}
+
+int sas_show_proto(enum sas_proto proto, char *page)
+{
+	static const char *proto_str[] = {
+		[SATA_PROTO] = "SATA",
+		[SAS_PROTO_SMP] = "SMP",
+		[SAS_PROTO_STP] = "STP",
+		[SAS_PROTO_SSP] = "SSP",
+	};
+	int  v;
+	char *buf = page;
+
+	for (v = 1; proto != 0 && v <= SAS_PROTO_SSP; v <<= 1) {
+		if (v & proto) {
+			buf += sprintf(buf, "%s", proto_str[v]);
+		
+			if (proto & ~((v<<1)-1))
+				buf += sprintf(buf, "|");
+			else
+				buf += sprintf(buf, "\n");
+		}
+	}
+	return buf-page;
+}
+
+int sas_show_linkrate(enum sas_phy_linkrate linkrate, char *page)
+{
+	static const char *phy_linkrate_str[] = {
+		[PHY_LINKRATE_NONE] = "",
+		[PHY_DISABLED] = "disabled",
+		[PHY_RESET_PROBLEM] = "phy reset problem",
+		[PHY_SPINUP_HOLD] = "phy spinup hold",
+		[PHY_PORT_SELECTOR] = "phy port selector",
+		[PHY_LINKRATE_1_5] = "1,5 GB/s",
+		[PHY_LINKRATE_3]  = "3,0 GB/s",
+		[PHY_LINKRATE_6] = "6,0 GB/s",
+	};
+	return sprintf(page, "%s\n", phy_linkrate_str[linkrate]);
+}
+
+int sas_show_oob_mode(enum sas_oob_mode oob_mode, char *buf)
+{
+	switch (oob_mode) {
+	case OOB_NOT_CONNECTED:
+		return sprintf(buf, "%s", "");
+		break;
+	case SATA_OOB_MODE:
+		return sprintf(buf, "%s\n", "SATA");
+		break;
+	case SAS_OOB_MODE:
+		return sprintf(buf, "%s\n", "SAS");
+		break;
+	}
+	return 0;
+}
+
+void sas_hash_addr(u8 *hashed, const u8 *sas_addr)
+{
+	const u32 poly = 0x00DB2777;
+	u32 	r = 0;
+	int 	i;
+
+	for (i = 0; i < 8; i++) {
+		int b;
+		for (b = 7; b >= 0; b--) {
+			r <<= 1;
+			if ((1 << b) & sas_addr[i]) {
+				if (!(r & 0x01000000))
+					r ^= poly;
+			} else if (r & 0x01000000)
+				r ^= poly;
+		}
+	}
+
+	hashed[0] = (r >> 16) & 0xFF;
+	hashed[1] = (r >> 8) & 0xFF ;
+	hashed[2] = r & 0xFF;
+}


