Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030332AbVIITcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030332AbVIITcy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbVIITcx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:32:53 -0400
Received: from magic.adaptec.com ([216.52.22.17]:59844 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S1030332AbVIITcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:32:42 -0400
Message-ID: <4321E354.40604@adaptec.com>
Date: Fri, 09 Sep 2005 15:32:36 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: [PATCH 2.6.13 3/20] aic94xx: aic94xx.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2005 19:32:41.0370 (UTC) FILETIME=[3E76C7A0:01C5B575]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Luben Tuikov <luben_tuikov@adaptec.com>

diff -X linux-2.6.13/Documentation/dontdiff -Naur linux-2.6.13-orig/drivers/scsi/aic94xx/aic94xx.h linux-2.6.13/drivers/scsi/aic94xx/aic94xx.h
--- linux-2.6.13-orig/drivers/scsi/aic94xx/aic94xx.h	1969-12-31 19:00:00.000000000 -0500
+++ linux-2.6.13/drivers/scsi/aic94xx/aic94xx.h	2005-09-09 11:21:23.000000000 -0400
@@ -0,0 +1,114 @@
+/*
+ * Aic94xx SAS/SATA driver header file.
+ *
+ * Copyright (C) 2005 Adaptec, Inc.  All rights reserved.
+ * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
+ *
+ * This file is licensed under GPLv2.
+ * 
+ * This file is part of the aic94xx driver.
+ *
+ * The aic94xx driver is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ * The aic94xx driver is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with the aic94xx driver; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ * $Id: //depot/aic94xx/aic94xx.h#30 $
+ */
+
+#ifndef _AIC94XX_H_
+#define _AIC94XX_H_
+
+#include <linux/slab.h>
+#include <linux/ctype.h>
+#include <scsi/sas/sas_discover.h>
+
+#define ASD_DRIVER_NAME		"aic94xx"
+#define ASD_DRIVER_DESCRIPTION	"Adaptec aic94xx SAS/SATA driver"
+
+#define asd_printk(fmt, ...)	printk(KERN_NOTICE ASD_DRIVER_NAME ": " fmt, ## __VA_ARGS__)
+
+#ifdef ASD_ENTER_EXIT
+#define ENTER  printk(KERN_NOTICE "%s: ENTER %s\n", ASD_DRIVER_NAME, \
+		__FUNCTION__)
+#define EXIT   printk(KERN_NOTICE "%s: --EXIT %s\n", ASD_DRIVER_NAME, \
+		__FUNCTION__)
+#else
+#define ENTER
+#define EXIT
+#endif
+
+#ifdef ASD_DEBUG
+#define ASD_DPRINTK asd_printk
+#else
+#define ASD_DPRINTK(fmt, ...)
+#endif
+
+/* 2*ITNL timeout + 1 second */
+#define AIC94XX_SCB_TIMEOUT  (5*HZ)
+
+extern kmem_cache_t *asd_dma_token_cache;
+extern kmem_cache_t *asd_ascb_cache;
+extern char sas_addr_str[2*SAS_ADDR_SIZE + 1];
+
+static inline void asd_stringify_sas_addr(char *p, const u8 *sas_addr)
+{
+	int i;
+	for (i = 0; i < SAS_ADDR_SIZE; i++, p += 2)
+		snprintf(p, 3, "%02X", sas_addr[i]);
+	*p = '\0';
+}
+
+static inline void asd_destringify_sas_addr(u8 *sas_addr, const char *p)
+{
+	int i;
+	for (i = 0; i < SAS_ADDR_SIZE; i++) {
+		u8 h, l;
+		if (!*p)
+			break;
+		h = isdigit(*p) ? *p-'0' : *p-'A'+10;
+		p++;
+		l = isdigit(*p) ? *p-'0' : *p-'A'+10;
+		p++;
+		sas_addr[i] = (h<<4) | l;
+	}
+}
+
+struct asd_ha_struct;
+struct asd_ascb;
+
+int  asd_read_ocm(struct asd_ha_struct *asd_ha);
+int  asd_read_flash(struct asd_ha_struct *asd_ha);
+
+int  asd_dev_found(struct domain_device *dev);
+void asd_dev_gone(struct domain_device *dev);
+
+void asd_invalidate_edb(struct asd_ascb *ascb, int edb_id);
+
+int  asd_execute_task(struct sas_task *, int num, unsigned long gfp_flags);
+
+/* ---------- TMFs ---------- */
+int  asd_abort_task(struct sas_task *);
+int  asd_abort_task_set(struct domain_device *, u8 *lun);
+int  asd_clear_aca(struct domain_device *, u8 *lun);
+int  asd_clear_task_set(struct domain_device *, u8 *lun);
+int  asd_lu_reset(struct domain_device *, u8 *lun);
+int  asd_query_task(struct sas_task *);
+
+/* ---------- Adapter and Port management ---------- */
+int  asd_clear_nexus_port(struct sas_port *port);
+int  asd_clear_nexus_ha(struct sas_ha_struct *sas_ha);
+
+/* ---------- Phy Management ---------- */
+int  asd_control_phy(struct sas_phy *phy, enum phy_func func);
+
+#endif

