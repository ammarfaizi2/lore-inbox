Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbSK1Qu1>; Thu, 28 Nov 2002 11:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbSK1Qu0>; Thu, 28 Nov 2002 11:50:26 -0500
Received: from host194.steeleye.com ([66.206.164.34]:4113 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265843AbSK1QuY>; Thu, 28 Nov 2002 11:50:24 -0500
Message-Id: <200211281657.gASGve102802@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi/hosts.c device_register fix 
In-Reply-To: Message from Andries.Brouwer@cwi.nl 
   of "Thu, 28 Nov 2002 17:47:53 +0100." <UTC200211281647.gASGlrq03953.aeb@smtp.cwi.nl> 
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_5066416220"
Date: Thu, 28 Nov 2002 10:57:40 -0600
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_5066416220
Content-Type: text/plain; charset=us-ascii

Actually, the patch is wrong.  It will wreak havoc with SCSI's use of sysfs.  
The device_register has to be done in scsi_add_host, which is called after all 
the driver specific sysfs setup has been done.  The correct fix is to move the 
corresponding device_unregister into scsi_remove_host so that they match.

I've attached it below.  I'll also commit it to the scsi-misc-2.5 BK tree.

James


--==_Exmh_5066416220
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== hosts.c 1.31 vs edited =====
--- 1.31/drivers/scsi/hosts.c	Sun Nov 17 15:47:02 2002
+++ edited/hosts.c	Sat Nov 23 17:25:57 2002
@@ -295,6 +295,8 @@
 		kfree(sdev);
 	}
 
+	device_unregister(&shost->host_driverfs_dev);
+
 	return 0;
 }
 
@@ -348,7 +350,6 @@
 
 	/* Cleanup proc and driverfs */
 	scsi_proc_host_rm(shost);
-	device_unregister(&shost->host_driverfs_dev);
 
 	kfree(shost);
 }

--==_Exmh_5066416220--


