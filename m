Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTK3OqL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 09:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264920AbTK3OqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 09:46:11 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41902 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262610AbTK3OqG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 09:46:06 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Silicon Image 3112A SATA trouble
Date: Sun, 30 Nov 2003 15:47:32 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, marcush@onlinehome.de
References: <3FC36057.40108@gmx.de> <20031129165648.GB14704@gtf.org> <3FC94F5A.8020900@gmx.de>
In-Reply-To: <3FC94F5A.8020900@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311301547.32347.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Okay, stop bashing IDE driver... three mails is enough...

Apply this patch and you should get similar performance from IDE driver.
You are probably seeing big improvements with libata driver because you are
using Samsung and IBM/Hitachi drives only, for Seagate it probably sucks just
like IDE driver...

IDE driver limits requests to 15kB for all SATA drives...
libata driver limits requests to 15kB only for Seagata SATA drives...

Both drivers still need proper fix for Seagate drives...

--bart

On Sunday 30 of November 2003 03:00, Prakash K. Cheemplavam wrote:
> Jeff Garzik wrote:
> > On Sat, Nov 29, 2003 at 04:39:34PM +0100, Prakash K. Cheemplavam wrote:
> >>I just tried the libata driver and it ROCKSSSS! So far, at least.
> >>
> >>I already wrote about the crappy SiI3112 ide driver, now with libata I
> >>get >60mb/sec!!!! More then I get with windows.
> >
> > Thanks :)
>
> Come on, we must thank you. You don't imagine how frustrated I became of
> the SiI bugger. :-)
>
> Prakash


[IDE] siimage.c: limit requests to 15kB only for Seagate SATA drives

Fix from jgarzik's sata_sil.c libata driver.

 drivers/ide/pci/siimage.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletion(-)

diff -puN drivers/ide/pci/siimage.c~ide-siimage-seagate drivers/ide/pci/siimage.c
--- linux-2.6.0-test11/drivers/ide/pci/siimage.c~ide-siimage-seagate	2003-11-30 15:38:48.512585200 +0100
+++ linux-2.6.0-test11-root/drivers/ide/pci/siimage.c	2003-11-30 15:38:48.516584592 +0100
@@ -1047,6 +1047,27 @@ static void __init init_mmio_iops_siimag
 	hwif->mmio			= 2;
 }
 
+static int is_dev_seagate_sata(ide_drive_t *drive)
+{
+	const char *s = &drive->id->model[0];
+	unsigned len;
+
+	if (!drive->present)
+		return 0;
+
+	len = strnlen(s, sizeof(drive->id->model));
+
+	if ((len > 4) && (!memcmp(s, "ST", 2))) {
+		if ((!memcmp(s + len - 2, "AS", 2)) ||
+		    (!memcmp(s + len - 3, "ASL", 3))) {
+			printk(KERN_INFO "%s: applying pessimistic Seagate "
+					 "errata fix\n", drive->name);
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /**
  *	init_iops_siimage	-	set up iops
  *	@hwif: interface to set up
@@ -1068,7 +1089,7 @@ static void __init init_iops_siimage (id
 	hwif->hwif_data = 0;
 
 	hwif->rqsize = 128;
-	if (is_sata(hwif))
+	if (is_sata(hwif) && is_dev_seagate_sata(&hwif->drives[0]))
 		hwif->rqsize = 15;
 
 	if (pci_get_drvdata(dev) == NULL)

_

