Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbUAJPC3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUAJPC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:02:29 -0500
Received: from aun.it.uu.se ([130.238.12.36]:61064 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S265203AbUAJPCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:02:25 -0500
Date: Sat, 10 Jan 2004 16:02:21 +0100 (MET)
Message-Id: <200401101502.i0AF2LOp022413@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: wrlk@riede.org
Subject: [PATCH][2.6] units= parameter for ide-scsi
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, 7 Jan 2004 21:28:35 -0500, Willem Riede wrote:
>On 2004.01.05 17:00, Mikael Pettersson wrote:
>> On Fri, 26 Dec 2003 13:12:42 -0500, Willem Riede wrote:
>> ...
>> >So can we agree to keep ide-scsi? I know it is not desired any
>> >more for cd writers. To avoid the problem reports from people who
>> >don't realize that and select ide-scsi anyway, we can refuse to
>> >attach to a cd-type device (today it just warns). And/or make a 
>> >new explicit module parameter to tell ide-scsi exactly which 
>> >drives to attach to.
>> 
>> I have a simple patch to do exactly that. Contact me if you want it.
>
>Yes, please do send me that patch.

This is my patch to add a "units=" parameter to ide-scsi.
It's useful for people that, like me, have more than one
ATAPI device in a machine. Sample usage:

modprobe ide_scsi units=hdc+hdd
to claim both hdc and hdd for ide-scsi.

modprobe ide_scsi units=hdd
to claim only hdd for ide-scsi, skipping all
other unclaimed devices.

This also works in the non-modular case. Simply pass
"ide_scsi.units=..." as a kernel boot argument.

The /* XXX: too horrible to explain */ comment refers to a
problem with the module_param implementation, which creates a
string literal from the kbuild-defined module name. Unfortunately
"ide_scsi" is a #define in <linux/ide.h>, so the string literal
ends up containing the value of ide_scsi rather than its spelling.
Hence the #undef.

/Mikael

diff -rupN linux-2.6.1/drivers/scsi/ide-scsi.c linux-2.6.1.ide-scsi-units/drivers/scsi/ide-scsi.c
--- linux-2.6.1/drivers/scsi/ide-scsi.c	2003-12-18 10:57:09.000000000 +0100
+++ linux-2.6.1.ide-scsi-units/drivers/scsi/ide-scsi.c	2004-01-10 15:40:11.000000000 +0100
@@ -45,6 +45,7 @@
 #include <linux/hdreg.h>
 #include <linux/slab.h>
 #include <linux/ide.h>
+#include <linux/moduleparam.h>
 
 #include <asm/io.h>
 #include <asm/bitops.h>
@@ -947,6 +948,10 @@ static Scsi_Host_Template idescsi_templa
 	.proc_name		= "ide-scsi",
 };
 
+static char *units;
+#undef ide_scsi /* XXX: too horrible to explain */
+module_param_named(units, units, charp, 0);
+
 static int idescsi_attach(ide_drive_t *drive)
 {
 	idescsi_scsi_t *idescsi;
@@ -954,6 +959,10 @@ static int idescsi_attach(ide_drive_t *d
 	static int warned;
 	int err;
 
+	if (units && !strstr(units, drive->name)) {
+		printk(KERN_INFO "ide-scsi: ignoring drive %s\n", drive->name);
+		return 1;
+	}
 	if (!warned && drive->media == ide_cdrom) {
 		printk(KERN_WARNING "ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device\n");
 		warned = 1;
