Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWDMVoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWDMVoi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWDMVoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:44:38 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:995 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964983AbWDMVoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:44:38 -0400
Subject: [PATCH] tpm: update bios log code for 1.2
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org, TPM Device Driver List <tpmdd-devel@lists.sourceforge.net>
Content-Type: text/plain
Date: Thu, 13 Apr 2006 16:45:21 -0500
Message-Id: <1144964722.12054.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The acpi table which contains the BIOS log events was updated for 1.2.
There are now client and server modes as defined in the specifications
with slightly different formats.  Additionally, the start field was even
too small for the 1.1 version but had been working anyway.  This patch
updates the code to deal with any of the three types of headers
probperly (1.1, 1.2 client and 1.2 server).

Signed-off-by: Kylie Hall <kjhall@us.ibm.com>
---
 drivers/char/tpm/tpm_bios.c |   53 +++++++++++++++++++++++++---------
 1 files changed, 39 insertions(+), 14 deletions(-)

--- linux-2.6.17-rc1-mm2/drivers/char/tpm/tpm_bios.c	2006-04-02 22:22:10.000000000 -0500
+++ linux-2.6.17-rc1/drivers/char/tpm/tpm_bios.c	2006-04-13 11:25:03.623295750 -0500
@@ -29,6 +29,11 @@
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
 #define ACPI_TCPA_SIG		"TCPA"	/* 0x41504354 /'TCPA' */
 
+enum bios_platform_class {
+	BIOS_CLIENT = 0x00,
+	BIOS_SERVER = 0x01,
+};
+
 struct tpm_bios_log {
 	void *bios_event_log;
 	void *bios_event_log_end;
@@ -36,9 +41,18 @@ struct tpm_bios_log {
 
 struct acpi_tcpa {
 	struct acpi_table_header hdr;
-	u16 reserved;
-	u32 log_max_len __attribute__ ((packed));
-	u32 log_start_addr __attribute__ ((packed));
+	u16 platform_class;
+	union {
+		struct client_hdr {
+			u32 log_max_len __attribute__ ((packed));
+			u64 log_start_addr __attribute__ ((packed));
+		} client;
+		struct server_hdr {
+			u16 reserved;
+			u64 log_max_len __attribute__ ((packed));
+			u64 log_start_addr __attribute__ ((packed));
+		} server;
+	};
 };
 
 struct tcpa_event {
@@ -376,6 +390,7 @@ static int read_log(struct tpm_bios_log 
 	struct acpi_tcpa *buff;
 	acpi_status status;
 	struct acpi_table_header *virt;
+	u64 len, start;
 
 	if (log->bios_event_log != NULL) {
 		printk(KERN_ERR
@@ -396,27 +411,37 @@ static int read_log(struct tpm_bios_log 
 		return -EIO;
 	}
 
-	if (buff->log_max_len == 0) {
+	switch(buff->platform_class) {
+	case BIOS_SERVER:
+		len = buff->server.log_max_len;
+		start = buff->server.log_start_addr;
+		break;
+	case BIOS_CLIENT:
+	default:
+		len = buff->client.log_max_len;
+		start = buff->client.log_start_addr;
+		break;
+	} 
+	if (!len) {
 		printk(KERN_ERR "%s: ERROR - TCPA log area empty\n", __func__);
 		return -EIO;
-	}
-
+	} 
+	
 	/* malloc EventLog space */
-	log->bios_event_log = kmalloc(buff->log_max_len, GFP_KERNEL);
+	log->bios_event_log = kmalloc(len, GFP_KERNEL);
 	if (!log->bios_event_log) {
-		printk
-		    ("%s: ERROR - Not enough  Memory for BIOS measurements\n",
-		     __func__);
+		printk("%s: ERROR - Not enough  Memory for BIOS measurements\n",
+			__func__);
 		return -ENOMEM;
 	}
 
-	log->bios_event_log_end = log->bios_event_log + buff->log_max_len;
+	log->bios_event_log_end = log->bios_event_log + len;
 
-	acpi_os_map_memory(buff->log_start_addr, buff->log_max_len, (void *) &virt);
+	acpi_os_map_memory(start, len, (void *) &virt);
 
-	memcpy(log->bios_event_log, virt, buff->log_max_len);
+	memcpy(log->bios_event_log, virt, len);
 
-	acpi_os_unmap_memory(virt, buff->log_max_len);
+	acpi_os_unmap_memory(virt, len);
 	return 0;
 }
 


