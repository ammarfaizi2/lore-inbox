Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262695AbTLWXBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 18:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLWXB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 18:01:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50659 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262695AbTLWXBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 18:01:25 -0500
Date: Tue, 23 Dec 2003 18:01:20 -0500
From: Alan Cox <alan@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4 IDE hotplug disk change and size change problem
Message-ID: <20031223230120.GA5771@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people found that the

	hdparm -b0 
	swap disk for a larger one
	hdparm -b1

would then go nuts with disks IFF the new disk was larger and fdisk wasnt run.

Can folks seeing this try the following guess at the problem (I dont currently
have any hotpluggable IDE working except CD/DVD bays)


--- ide.c~	2003-12-23 22:45:50.000000000 +0000
+++ ide.c	2003-12-23 22:51:26.000000000 +0000
@@ -826,7 +826,11 @@
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
 		if(drive->present && !drive->dead)
+		{
+			drive->revalidate = 1;
 			ide_attach_drive(drive);
+			ide_revalidate_disk(MKDEV(hwif->major, unit<<PARTN_BITS));
+		}
 	}
 	our_drive->usage++;
 	return 0;


