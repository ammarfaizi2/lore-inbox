Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263582AbUEKUOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263582AbUEKUOn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 16:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbUEKUOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 16:14:42 -0400
Received: from smtpq3.home.nl ([213.51.128.198]:59347 "EHLO smtpq3.home.nl")
	by vger.kernel.org with ESMTP id S263582AbUEKUOW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 16:14:22 -0400
Message-ID: <40A133BF.90403@keyaccess.nl>
Date: Tue, 11 May 2004 22:12:47 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
CC: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       mikeserv@bmts.com
Subject: Re: linux-2.6.6: ide-disks are shutdown on reboot
References: <20040511142017.1bc39ce1.vmlinuz386@yahoo.com.ar>
In-Reply-To: <20040511142017.1bc39ce1.vmlinuz386@yahoo.com.ar>
Content-Type: multipart/mixed;
 boundary="------------060008050000020505030908"
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060008050000020505030908
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gerardo Exequiel Pozzi wrote:

> With the recent version 2.6.6 my ide disks are shutdown on reboot, 
> this not happens with 2.6.5. I try booting with acpi=off and it
> behaves equal, disk shutdown on reboot.

Wildly annoying isn't it? Seems to be a generic problem with linux not 
differentiatinng between REBOOT and HALT/POWEROFF. Andrew Morton just 
posted a patch to deplex them:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108425291909843&w=2

You can wait for the IDE crowd to use that to implement a proper fix or 
staple the attached hack on top if it must go now.

Rene.



--------------060008050000020505030908
Content-Type: text/plain;
 name="linux-2.6.6_spin.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.6_spin.diff"

--- linux-2.6.6.orig/drivers/ide/ide-disk.c	2004-05-11 12:40:53.000000000 +0200
+++ linux-2.6.6/drivers/ide/ide-disk.c	2004-05-11 12:09:30.000000000 +0200
@@ -1704,10 +1704,11 @@
 
 static void ide_device_shutdown(struct device *dev)
 {
-	ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
-
-	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	if (system_state != SYSTEM_RESTART) {
+		ide_drive_t *drive = container_of(dev, ide_drive_t, gendev);
+		printk("Shutdown: %s\n", drive->name);
+		dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	}
 }
 
 /*

--------------060008050000020505030908--
