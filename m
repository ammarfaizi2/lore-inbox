Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967370AbWK2OkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967370AbWK2OkJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 09:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967369AbWK2OkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 09:40:09 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64441 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S967367AbWK2OkH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 09:40:07 -0500
Date: Wed, 29 Nov 2006 14:46:52 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] ide_scsi: allow it to be used for non CD only
Message-ID: <20061129144652.299f7919@localhost.localdomain>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some people want to use ide_cd for CD-ROM but still dynamically load
ide-scsi for things like tape drives. If you compile in the CD driver
this works out but if you want them modular you need an option to ensure
that whoever loads first the right things happen.

This replaces the original draft patch which leaked a scsi host reference

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c linux-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c
--- linux.vanilla-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c	2006-11-24 13:58:08.000000000 +0000
+++ linux-2.6.19-rc6-mm1/drivers/scsi/ide-scsi.c	2006-11-29 14:18:12.000000000 +0000
@@ -110,6 +110,7 @@
 } idescsi_scsi_t;
 
 static DEFINE_MUTEX(idescsi_ref_mutex);
+static int idescsi_nocd;			/* Set by module param to skip cd */
 
 #define ide_scsi_g(disk) \
 	container_of((disk)->private_data, struct ide_scsi_obj, driver)
@@ -1127,11 +1128,14 @@
 		warned = 1;
 	}
 
+	if (idescsi_nocd && drive->media == ide_cdrom)
+		return -ENODEV;
+
 	if (!strstr("ide-scsi", drive->driver_req) ||
 	    !drive->present ||
 	    drive->media == ide_disk ||
 	    !(host = scsi_host_alloc(&idescsi_template,sizeof(idescsi_scsi_t))))
 		return -ENODEV;
 
 	g = alloc_disk(1 << PARTN_BITS);
 	if (!g)
@@ -1187,6 +1192,7 @@
 	driver_unregister(&idescsi_driver.gen_driver);
 }
 
+module_param(idescsi_nocd, int, 0600);
 module_init(init_idescsi_module);
 module_exit(exit_idescsi_module);
 MODULE_LICENSE("GPL");
