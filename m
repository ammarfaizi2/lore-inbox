Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTJZTdy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 14:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263623AbTJZTdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 14:33:54 -0500
Received: from hera.cwi.nl ([192.16.191.8]:13967 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263622AbTJZTdt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 14:33:49 -0500
From: Andries.Brouwer@cwi.nl
Date: Sun, 26 Oct 2003 20:33:45 +0100 (MET)
Message-Id: <UTC200310261933.h9QJXjN04379.aeb@smtp.cwi.nl>
To: fw@deneb.enyo.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test9] Strange SCSI messages
Cc: linux-scsi@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Florian Weimer <fw@deneb.enyo.de>

    | Info fld=0x440b6b, Current sdsdd: sense key Recovered Error
    | Additional sense: Address mark not found for data field

    According to the sources, these are SCSI messages (matbe this should be
    noted in the message?) -- but what do they mean?

No doubt you are asking something else, but your sdsdd should have been sdd.
That is, these days error printing is a bit broken.

Something like the patch below might help.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/drivers/scsi/constants.c b/drivers/scsi/constants.c
--- a/drivers/scsi/constants.c	Sun Oct 26 00:00:11 2003
+++ b/drivers/scsi/constants.c	Sun Oct 26 20:11:07 2003
@@ -915,15 +915,15 @@
 
 /* Print sense information */
 static void
-print_sense_internal(const char * devclass, 
-		     const unsigned char * sense_buffer,
+print_sense_internal(const char *devclass, 
+		     const unsigned char *sense_buffer,
 		     struct request *req)
 {
 	int s, sense_class, valid, code, info;
-	const char * error = NULL;
+	const char *error = NULL;
 	unsigned char asc, ascq;
 	const char *sense_txt;
-	char *name = req->rq_disk ? req->rq_disk->disk_name : "?";
+	const char *name = req->rq_disk ? req->rq_disk->disk_name : devclass;
     
 	sense_class = (sense_buffer[0] >> 4) & 0x07;
 	code = sense_buffer[0] & 0xf;
@@ -966,11 +966,9 @@
 
 		sense_txt = scsi_sense_key_string(sense_buffer[2]);
 		if (sense_txt)
-			printk("%s%s: sense key %s\n",
-			       devclass, name, sense_txt);
+			printk("%s: sense key %s\n", name, sense_txt);
 		else
-			printk("%s%s: sense = %2x %2x\n",
-			       devclass, name,
+			printk("%s: sense = %2x %2x\n", name,
 			       sense_buffer[0], sense_buffer[2]);
 
 		asc = ascq = 0;
@@ -993,11 +991,9 @@
 
 		sense_txt = scsi_sense_key_string(sense_buffer[0]);
 		if (sense_txt)
-			printk("%s%s: old sense key %s\n",
-			       devclass, name, sense_txt);
+			printk("%s: old sense key %s\n", name, sense_txt);
 		else
-			printk("%s%s: sense = %2x %2x\n",
-			       devclass, name,
+			printk("%s: sense = %2x %2x\n", name,
 			       sense_buffer[0], sense_buffer[2]);
 
 		printk("Non-extended sense class %d code 0x%0x\n",
