Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317432AbSGDPjC>; Thu, 4 Jul 2002 11:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317433AbSGDPjB>; Thu, 4 Jul 2002 11:39:01 -0400
Received: from host194.steeleye.com ([216.33.1.194]:20493 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317432AbSGDPjA>; Thu, 4 Jul 2002 11:39:00 -0400
Message-Id: <200207041541.g64FfNW02097@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Anton Altaparmakov <aia21@cantab.net>
cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       sullivan@austin.ibm.com
Subject: [BUG-2.5.24-BK] DriverFS panics on boot!
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-20731811840"
Date: Thu, 04 Jul 2002 11:41:22 -0400
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-20731811840
Content-Type: text/plain; charset=us-ascii

Er, oops, I think this one's my fault.

The recent driverfs additions for SCSI also added partition handling in 
driverfs.  The code is slightly more invasive than it should be so the IDE 
driver needs to know how to use it (which it doesn't yet).  In theory there's 
a NULL pointer check in driverfs_create_partitions for precisely this case, 
but it looks like the IDE code is forgetting to zero out a kmalloc of a struct 
gendisk somewhere (hence the 5a5a... contents).  At a cursory glance, this 
seems to be in ide/probe.c, so does the attached patch fix it?

I'll try to reproduce, but I'm all SCSI here except for my laptop.

James


--==_Exmh_-20731811840
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

===== drivers/ide/probe.c 1.58 vs edited =====
--- 1.58/drivers/ide/probe.c	Fri Jun 14 09:11:19 2002
+++ edited/drivers/ide/probe.c	Thu Jul  4 10:31:35 2002
@@ -1143,6 +1143,7 @@
 	if (!gd)
 		goto err_kmalloc_gd;
 
+	memset(gd, 0, sizeof(struct gendisk));
 	gd->sizes = kmalloc(ATA_MINORS * sizeof(int), GFP_KERNEL);
 	if (!gd->sizes)
 		goto err_kmalloc_gd_sizes;

--==_Exmh_-20731811840--


