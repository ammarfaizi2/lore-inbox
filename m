Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbVLHRpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbVLHRpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 12:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbVLHRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 12:45:21 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:46565 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750817AbVLHRpV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 12:45:21 -0500
Subject: [PATCH] tpmdd: remove global event log
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Content-Type: text/plain
Date: Thu, 08 Dec 2005 11:46:10 -0600
Message-Id: <1134063970.6708.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove global event log in the tpm bios event measurement log code that
would have caused problems when the code was run concurrently.  A log is
now allocated and attached to the seq file upon open and destroyed
appropriately.

Signed-off-by: Kylene Hall
---
--- linux-2.6.15-rc5/drivers/char/tpm/tpm_bios.c	2005-12-06 12:34:25.000000000 -0600
+++ linux-2.6.15-rc3-bios/drivers/char/tpm/tpm_bios.c	2005-12-08 11:37:39.000000000 -0600
@@ -29,6 +29,11 @@
 #define MAX_TEXT_EVENT		1000	/* Max event string length */
 #define ACPI_TCPA_SIG		"TCPA"	/* 0x41504354 /'TCPA' */
 
+struct tpm_bios_log {
+	void *bios_event_log;
+	void *bios_event_log_end;
+};
+
 struct acpi_tcpa {
 	struct acpi_table_header hdr;
 	u16 reserved;
@@ -117,15 +122,13 @@ static const char* tcpa_pc_event_id_stri
 	"S-CRTM POST Contents",
 };
 
-/* (Binary) bios measurement buffer */
-static void *tcg_eventlog;
-static void *tcg_eventlog_addr_limit;	/* MAX */
-
 /* returns pointer to start of pos. entry of tcg log */
 static void *tpm_bios_measurements_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t i;
-	void *addr = tcg_eventlog;
+	struct tpm_bios_log *log = m->private;
+	void *addr = log->bios_event_log;
+	void *limit = log->bios_event_log_end;
 	struct tcpa_event *event;
 
 	/* read over *pos measurements */
@@ -133,7 +136,7 @@ static void *tpm_bios_measurements_start
 		event = addr;
 
 		if ((addr + sizeof(struct tcpa_event)) <
-		    tcg_eventlog_addr_limit) {
+		    limit) {
 			if (event->event_type == 0 && event->event_size == 0)
 				return NULL;
 			addr +=
@@ -142,14 +145,14 @@ static void *tpm_bios_measurements_start
 	}
 
 	/* now check if current entry is valid */
-	if ((addr + sizeof(struct tcpa_event)) >= tcg_eventlog_addr_limit)
+	if ((addr + sizeof(struct tcpa_event)) >= limit)
 		return NULL;
 
 	event = addr;
 
 	if ((event->event_type == 0 && event->event_size == 0) ||
 	    ((addr + sizeof(struct tcpa_event) + event->event_size) >=
-	     tcg_eventlog_addr_limit))
+	     limit))
 		return NULL;
 
 	return addr;
@@ -159,11 +162,13 @@ static void *tpm_bios_measurements_next(
 					loff_t *pos)
 {
 	struct tcpa_event *event = v;
+	struct tpm_bios_log *log = m->private;
+	void *limit = log->bios_event_log_end;	
 
 	v += sizeof(struct tcpa_event) + event->event_size;
 
 	/* now check if current entry is valid */
-	if ((v + sizeof(struct tcpa_event)) >= tcg_eventlog_addr_limit)
+	if ((v + sizeof(struct tcpa_event)) >= limit)
 		return NULL;
 
 	event = v;
@@ -173,7 +178,7 @@ static void *tpm_bios_measurements_next(
 
 	if ((event->event_type == 0 && event->event_size == 0) ||
 	    ((v + sizeof(struct tcpa_event) + event->event_size) >=
-	     tcg_eventlog_addr_limit))
+	     limit))
 		return NULL;
 
 	(*pos)++;
@@ -312,10 +317,14 @@ static int tpm_binary_bios_measurements_
 static int tpm_bios_measurements_release(struct inode *inode,
 					 struct file *file)
 {
-	if (tcg_eventlog) {
-		kfree(tcg_eventlog);
-		tcg_eventlog = NULL;
+	struct seq_file *seq = file->private_data;
+	struct tpm_bios_log *log = seq->private;
+	
+	if (log) {
+		kfree(log->bios_event_log);
+		kfree(log);
 	}
+
 	return seq_release(inode, file);
 }
 
@@ -367,13 +376,13 @@ static struct seq_operations tpm_binary_
 };
 
 /* read binary bios log */
-static int read_log(void)
+static int read_log(struct tpm_bios_log *log)
 {
 	struct acpi_tcpa *buff;
 	acpi_status status;
 	void *virt;
 
-	if (tcg_eventlog != NULL) {
+	if (log->bios_event_log != NULL) {
 		printk(KERN_ERR
 		       "%s: ERROR - Eventlog already initialized\n",
 		       __func__);
@@ -399,19 +408,19 @@ static int read_log(void)
 	}
 
 	/* malloc EventLog space */
-	tcg_eventlog = kmalloc(buff->log_max_len, GFP_KERNEL);
-	if (!tcg_eventlog) {
+	log->bios_event_log = kmalloc(buff->log_max_len, GFP_KERNEL);
+	if (!log->bios_event_log) {
 		printk
 		    ("%s: ERROR - Not enough  Memory for BIOS measurements\n",
 		     __func__);
 		return -ENOMEM;
 	}
 
-	tcg_eventlog_addr_limit = tcg_eventlog + buff->log_max_len;
+	log->bios_event_log_end = log->bios_event_log + buff->log_max_len;
 
 	acpi_os_map_memory(buff->log_start_addr, buff->log_max_len, &virt);
 
-	memcpy(tcg_eventlog, virt, buff->log_max_len);
+	memcpy(log->bios_event_log, virt, buff->log_max_len);
 
 	acpi_os_unmap_memory(virt, buff->log_max_len);
 	return 0;
@@ -421,12 +430,26 @@ static int tpm_ascii_bios_measurements_o
 					    struct file *file)
 {
 	int err;
+	struct tpm_bios_log *log;
+	struct seq_file *seq;
 
-	if ((err = read_log()))
+	log = kzalloc(sizeof(struct tpm_bios_log), GFP_KERNEL);
+	if ( !log )
+		return -ENOMEM;
+	
+	if ((err = read_log(log)))
 		return err;
 
 	/* now register seq file */
-	return seq_open(file, &tpm_ascii_b_measurments_seqops);
+	err = seq_open(file, &tpm_ascii_b_measurments_seqops);
+	if ( !err ){
+		seq = file->private_data;
+		seq->private = log;
+	} else {
+		kfree(log->bios_event_log);
+		kfree(log);
+	}
+	return err;
 }
 
 struct file_operations tpm_ascii_bios_measurements_ops = {
@@ -440,12 +463,26 @@ static int tpm_binary_bios_measurements_
 					     struct file *file)
 {
 	int err;
+	struct tpm_bios_log *log;
+	struct seq_file *seq;
+
+	log = kzalloc(sizeof(struct tpm_bios_log), GFP_KERNEL);
+	if ( !log )
+		return -ENOMEM;
 
-	if ((err = read_log()))
+	if ((err = read_log(log)))
 		return err;
 
 	/* now register seq file */
-	return seq_open(file, &tpm_binary_b_measurments_seqops);
+	err = seq_open(file, &tpm_binary_b_measurments_seqops);
+	if ( !err ){
+		seq = file->private_data;
+		seq->private = log;
+	} else {
+		kfree(log->bios_event_log);
+		kfree(log);
+	}
+	return err;
 }
 
 struct file_operations tpm_binary_bios_measurements_ops = {


