Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271970AbRHVTrF>; Wed, 22 Aug 2001 15:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271956AbRHVTqz>; Wed, 22 Aug 2001 15:46:55 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:32741 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S271944AbRHVTqu>;
	Wed, 22 Aug 2001 15:46:50 -0400
Date: Wed, 22 Aug 2001 21:46:03 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200108221946.VAA01879@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [PATCH,RFC] make ide-scsi more selective
Cc: alan@lxorguk.ukuu.org.uk, ionut@cs.columbia.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Aug 2001 12:28:27 -0400 (EDT), Ion Badulescu wrote:

>The current IDE code doesn't allow the user to reserve a drive to be used 
>only with ide-scsi emulation, if the ide-scsi layer is compiled as a 
>module.

I've been rather annoyed by a dual problem in the ide-scsi setup:
during initialisation, ide-scsi will claim ALL currently unassigned
IDE devices. This is a problem in modular setups, since there's
no guarantee that currently unassigned devices actually are intended
for ide-scsi.

In my case ide-scsi would often steal my ATAPI tape drive since
my ide-tape module usually isn't loaded. Since I don't want this
to happen (for both practical and aesthetic reasons) I've used a
hack in my /etc/modules.conf to forcibly load ide-tape before
scsi_mod, but this is extremely ugly.

Seeing Ion's comment I decided to do something about this, so I
implemented a "units=" module parameter for ide-scsi, which causes
ide-scsi to skip units not explicitly listed. For symmetry one can
also specify this with a "idescsi=" kernel boot parameter.

Caveat: When listing multiple units, don't use "," to separate their
names (e.g. units=hdc,hdd). modutils insists that "," separates array
elements but the actual MODULE_PARM is a single string. I'd use "+"
instead (e.g. units=hdc+hdd), except I actually want to restrict
ide-scsi to a single unit, so I pass "units=hdc" to it.

The patch below implements this option for 2.4.8-ac9. I've also put
it in http://www.csd.uu.se/~mikpe/linux/idescsi/ together with patches
for 2.2.20pre9 with and without Andre's big IDE patch.

Comments?

/Mikael

--- linux-2.4.8-ac9/drivers/ide/ide.c.~1~	Wed Aug 22 14:13:03 2001
+++ linux-2.4.8-ac9/drivers/ide/ide.c	Wed Aug 22 14:20:56 2001
@@ -3006,6 +3006,9 @@
 	if (strncmp(s,"hd",2) == 0 && s[2] == '=')	/* hd= is for hd.c   */
 		return 0;				/* driver and not us */
 
+	if (!strncmp(s, "idescsi=", 8))	/* for ide-scsi.c not us */
+		return 0;
+
 	if (strncmp(s,"ide",3) &&
 	    strncmp(s,"idebus",6) &&
 	    strncmp(s,"hd",2))		/* hdx= & hdxlun= */
--- linux-2.4.8-ac9/drivers/scsi/ide-scsi.c.~1~	Thu Feb 22 15:23:46 2001
+++ linux-2.4.8-ac9/drivers/scsi/ide-scsi.c	Wed Aug 22 14:20:56 2001
@@ -561,6 +561,19 @@
 	NULL
 };
 
+static char *units;
+#ifdef MODULE
+MODULE_PARM(units, "s");
+#else
+/* the name "idescsi_setup" has already been taken :-( */
+static int __init setup_idescsi(char *s)
+{
+	units = s;
+	return 1;
+}
+__setup("idescsi=", setup_idescsi);
+#endif
+
 /*
  *	idescsi_init will register the driver for each scsi.
  */
@@ -580,7 +593,8 @@
 	for (i = 0; media[i] != 255; i++) {
 		failed = 0;
 		while ((drive = ide_scan_devices (media[i], idescsi_driver.name, NULL, failed++)) != NULL) {
-
+			if (units && !strstr(units, drive->name))
+				continue;
 			if ((scsi = (idescsi_scsi_t *) kmalloc (sizeof (idescsi_scsi_t), GFP_KERNEL)) == NULL) {
 				printk (KERN_ERR "ide-scsi: %s: Can't allocate a scsi structure\n", drive->name);
 				continue;
