Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265393AbUAJU7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 15:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265399AbUAJU7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 15:59:24 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:47608 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265393AbUAJU7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 15:59:21 -0500
Date: Sat, 10 Jan 2004 15:59:18 -0500
From: Willem Riede <wrlk@riede.org>
To: linux-kernel@vger.kernel.org
Cc: Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [PATCH][2.6] units= parameter for ide-scsi
Message-ID: <20040110205918.GK4339@linnie.riede.org>
Reply-To: wrlk@riede.org
References: <200401101502.i0AF2LOp022413@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200401101502.i0AF2LOp022413@harpo.it.uu.se> (from mikpe@csd.uu.se on Sat, Jan 10, 2004 at 10:02:21 -0500)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004.01.10 10:02, Mikael Pettersson wrote:
> This is my patch to add a "units=" parameter to ide-scsi.
> It's useful for people that, like me, have more than one
> ATAPI device in a machine. Sample usage:

I found that if only the existing hdx=ide-scsi mechanism had been
strictly enforced, this functionality had already existed:

--- linux-2.6.1/drivers/scsi/ide-scsi.c	2003-12-17 21:59:05.000000000 -0500
+++ /tmp/ide-scsi.c	2004-01-10 15:44:35.000000000 -0500
@@ -54,6 +54,9 @@
 #include "hosts.h"
 #include <scsi/sg.h>
 
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Scsi emulator for ATAPI Tape and MO devices");
+
 #define IDESCSI_DEBUG_LOG		0
 
 typedef struct idescsi_pc_s {
@@ -954,17 +957,18 @@
 	static int warned;
 	int err;
 
-	if (!warned && drive->media == ide_cdrom) {
-		printk(KERN_WARNING "ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device\n");
-		warned = 1;
-	}
-
-	if (!strstr("ide-scsi", drive->driver_req) ||
+	if (!drive->driver_req ||
+	    !strstr(drive->driver_req, "ide-scsi") ||
 	    !drive->present ||
 	    drive->media == ide_disk ||
 	    !(host = scsi_host_alloc(&idescsi_template,sizeof(idescsi_scsi_t))))
 		return 1;
 
+	if (!warned && drive->media == ide_cdrom) {
+		printk(KERN_WARNING "ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device\n");
+		warned = 1;
+	}
+
 	host->max_id = 1;
 	host->max_lun = 1;
 	drive->driver_data = host;
@@ -1000,4 +1004,3 @@
 
 module_init(init_idescsi_module);
 module_exit(exit_idescsi_module);
-MODULE_LICENSE("GPL");


Regards, Willem Riede.
