Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751080AbWJMHmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbWJMHmk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 03:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWJMHmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 03:42:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:53010 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751080AbWJMHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 03:42:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:organization:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=mU5U5IC7mezEOgX1Z3nFV6NEXq+11+hm4cwcwH2ib/vhFH0tF/QH/UU1bKFcgtxOsLm9iL3VOkbWfq7A/MCXNGr9iTu9R4j8IxgZg15RdILyPHhmp9/0BLSaZy0PKOu72i44LBtYJE6Gl+L0tWH4rnKB3VyLhYdHziQX2wwXFZ0=
Date: Fri, 13 Oct 2006 00:42:34 -0700
From: Amit Choudhary <amit2030@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.19-rc1] scsi: check kmalloc() return value.
Message-Id: <20061013004234.ac039a4e.amit2030@gmail.com>
Organization: X
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.15; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Description: Check the return value of kmalloc() in function ch_readconfig(), in file drivers/scsi/ch.c.

Signed-off-by: Amit Choudhary <amit2030@gmail.com>

diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
index f6caa43..fcd635b 100644
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -324,7 +324,7 @@ ch_readconfig(scsi_changer *ch)
 	if (!buffer)
 		return -ENOMEM;
 	memset(buffer,0,512);
-	
+
 	memset(cmd,0,sizeof(cmd));
 	cmd[0] = MODE_SENSE;
 	cmd[1] = ch->device->lun << 5;
@@ -367,7 +367,7 @@ ch_readconfig(scsi_changer *ch)
 	} else {
 		vprintk("reading element address assigment page failed!\n");
 	}
-	
+
 	/* vendor specific element types */
 	for (i = 0; i < 4; i++) {
 		if (0 == vendor_counts[i])
@@ -384,6 +384,10 @@ ch_readconfig(scsi_changer *ch)
 	/* look up the devices of the data transfer elements */
 	ch->dt = kmalloc(ch->counts[CHET_DT]*sizeof(struct scsi_device),
 			 GFP_KERNEL);
+	if (!ch->dt) {
+		kfree(buffer);
+		return -ENOMEM;
+	}
 	for (elem = 0; elem < ch->counts[CHET_DT]; elem++) {
 		id  = -1;
 		lun = 0;
