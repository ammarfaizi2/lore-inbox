Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751056AbWERX2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751056AbWERX2o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 19:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751070AbWERX2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 19:28:44 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:30524 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751049AbWERX2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 19:28:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=jmwZHKAEeXUvdjgEqRXVPG0q8ebmE1oIkVY8Ft9EsHcYh1nrwPJsgqew9UjLOJmIoEtb1OGslOZFJPa/4/0itLgai6dCTMHKu2o2f4gH88sNQwbGvMbozn86LERZF6LHcNX8vXL7u3DEDB9it3cWQFXDb2qHOLiWnkeHlkIbu6s=
Subject: [PATCH 2/2] tpm: bios log parsing fixes
From: Seiji Munetoh <seiji.munetoh@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: kjhall@us.ibm.com, tpmdd-devel@lists.sourceforge.net
Content-Type: text/plain
Date: Fri, 19 May 2006 08:29:07 +0900
Message-Id: <1147994947.14102.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the BINARY output format to actual ACPI TCPA log
structure for any userland tool easily parse the binary data with
reference to TCG PC specification.

Signed-off-by: Seiji Munetoh <seiji.munetoh@gmail.com>
--- linux-2.6.17-rc4/drivers/char/tpm/tpm_bios.c	2006-05-16
09:33:06.000000000 +0900
+++ linux-2.6.17-rc4-tpm/drivers/char/tpm/tpm_bios.c	2006-05-19
08:12:30.000000000 +0900
@@ -275,53 +285,13 @@ static int get_event_name(char *dest, st
 
 static int tpm_binary_bios_measurements_show(struct seq_file *m, void
*v)
 {
-
-	char *eventname;
-	char data[4];
-	u32 help;
-	int i, len;
 	struct tcpa_event *event = (struct tcpa_event *) v;
-	unsigned char *event_entry =
-	    (unsigned char *) (v + sizeof(struct tcpa_event));
-
-	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
-	if (!eventname) {
-		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
-		       __func__);
-		return -ENOMEM;
-	}
-
-	/* 1st: PCR used is in little-endian format (4 bytes) */
-	help = le32_to_cpu(event->pcr_index);
-	memcpy(data, &help, 4);
-	for (i = 0; i < 4; i++)
-		seq_putc(m, data[i]);
-
-	/* 2nd: SHA1 (20 bytes) */
-	for (i = 0; i < 20; i++)
-		seq_putc(m, event->pcr_value[i]);
+	char *data = (char *) v;
+	int i;
 
-	/* 3rd: event type identifier (4 bytes) */
-	help = le32_to_cpu(event->event_type);
-	memcpy(data, &help, 4);
-	for (i = 0; i < 4; i++)
+	for (i = 0;i < sizeof(struct tcpa_event) + event->event_size; i++)
 		seq_putc(m, data[i]);
 
-	len = 0;
-
-	len += get_event_name(eventname, event, event_entry);
-
-	/* 4th:  filename <= 255 + \'0' delimiter */
-	if (len > TCG_EVENT_NAME_LEN_MAX)
-		len = TCG_EVENT_NAME_LEN_MAX;
-
-	for (i = 0; i < len; i++)
-		seq_putc(m, eventname[i]);
-
-	/* 5th: delimiter */
-	seq_putc(m, '\0');
-
-	kfree(eventname);
 	return 0;
 }
 


