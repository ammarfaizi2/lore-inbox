Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSGQTPG>; Wed, 17 Jul 2002 15:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSGQTPG>; Wed, 17 Jul 2002 15:15:06 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:18602 "EHLO ibm.com")
	by vger.kernel.org with ESMTP id <S316390AbSGQTPF>;
	Wed, 17 Jul 2002 15:15:05 -0400
Date: Wed, 17 Jul 2002 14:58:20 -0500
From: sullivan <sullivan@austin.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: [PATCH] ide-scsi cleanup bug
Message-ID: <20020717145820.F1136@austin.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following patch is against lk 2.5.26. The prior implementation called  
scsi_unregister(host) from idescsi_cleanup(), removing the Scsi_Host instance 
from the scsi_hostlist. Later when scsi_unregister_host(&template) was called 
from exit_idescsi_module() but since the Scsi_Host instance had already been 
removed no matches for the template were found and the device instances 
remained.

The patch moves the scsi_unregister_host(&template) to idescsi_cleanup(). 
Since scsi_unregister_host() invokes scsi_unregister() this part of the 
cleanup also occurs normally.


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.5.26-ide-scsi.patch"

diff -Naur linux-2.5.26/drivers/scsi/ide-scsi.c linux-2.5.26-patched/drivers/scsi/ide-scsi.c
--- linux-2.5.26/drivers/scsi/ide-scsi.c	Tue Jul 16 18:49:24 2002
+++ linux-2.5.26-patched/drivers/scsi/ide-scsi.c	Wed Jul 17 19:14:35 2002
@@ -491,14 +491,13 @@
 	MOD_DEC_USE_COUNT;
 }
 
+static Scsi_Host_Template template;
 static int idescsi_cleanup (struct ata_device *drive)
 {
-	struct Scsi_Host *host = drive->driver_data;
-
 	if (ide_unregister_subdriver (drive)) {
 		return 1;
 	}
-	scsi_unregister(host);
+	scsi_unregister_host(&template);
 
 	return 0;
 }
@@ -801,7 +800,6 @@
 static void __exit exit_idescsi_module(void)
 {
 	unregister_ata_driver(&ata_ops);
-	scsi_unregister_host(&template);
 }
 
 module_init(init_idescsi_module);

--eqp4TxRxnD4KrmFZ--
