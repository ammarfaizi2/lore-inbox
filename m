Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267546AbSLFDuU>; Thu, 5 Dec 2002 22:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbSLFDuU>; Thu, 5 Dec 2002 22:50:20 -0500
Received: from dp.samba.org ([66.70.73.150]:53921 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267538AbSLFDuS>;
	Thu, 5 Dec 2002 22:50:18 -0500
From: Rusty Trivial Russell <rusty@rustcorp.com.au>
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [TRIVIAL] Re: Kernel patches...
Date: Fri, 06 Dec 2002 14:45:59 +1100
Message-Id: <20021206035754.B2B912C256@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From:  Woody Suwalski <woodys@xandros.com>

  >Yes agreed, a hdX=multilun is what I'm after.
  >
  >  
  >
  >>This works for me, no dice on getting me to bite on this whopper.
  >>    
  >>
  >
  >I'm sure woody will supply such a patch :)
  >
  >  
  >
  OK, so here is the new patch.
  It takes advantage of hdXlun, so no changes to the config files are needed.
  By default keeps IDE LUN at zero, unless hdXlun=n specified on command line.
  Compiles with 2.4.20.
  
  Thanks, Woody
  

--- trivial-2.5-bk/drivers/scsi/ide-scsi.c.orig	2002-12-06 13:56:56.000000000 +1100
+++ trivial-2.5-bk/drivers/scsi/ide-scsi.c	2002-12-06 13:56:56.000000000 +1100
@@ -640,8 +640,17 @@
 	if(host == NULL)
 		return 0;
 		
-	for (id = 0; id < MAX_HWIFS * MAX_DRIVES && idescsi_drives[id]; id++)
-		last_lun = IDE_MAX(last_lun, idescsi_drives[id]->last_lun);
+/*
+ * by default do not trust multiple LUN support on IDE devices.
+ * Too many broken IDE controllers respond to LUN != 0
+ * To reenable this feature, specify "hdxlun=n" on the command line.
+ */
+	for (id = 0; id < MAX_HWIFS * MAX_DRIVES && idescsi_drives[id]; id++) {
+		if (idescsi_drives[id]->forced_lun)
+			last_lun = IDE_MAX(last_lun, idescsi_drives[id]->last_lun);
+		else
+			last_lun = 0;
+	}
 	host->max_id = id;
 	host->max_lun = last_lun + 1;
 	host->can_queue = host->cmd_per_lun * id;
-- 
  Don't blame me: the Monkey is driving
  File: Woody Suwalski <woodys@xandros.com>: Re: Kernel patches...
