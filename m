Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSJUNEl>; Mon, 21 Oct 2002 09:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261371AbSJUNEl>; Mon, 21 Oct 2002 09:04:41 -0400
Received: from wilma1.suth.com ([207.127.128.4]:47376 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S261373AbSJUNE2>;
	Mon, 21 Oct 2002 09:04:28 -0400
Subject: [PATCH] 2.5.44 and Secondary Channel Only configuration Kernel Ooops
From: Jason Williams <jason_williams@suth.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: andre@linux-ide.org
Content-Type: multipart/mixed; boundary="=-4cM6w68X8PyLS3KMPaRE"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 09:13:01 -0400
Message-Id: <1035205986.967.8.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4cM6w68X8PyLS3KMPaRE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Here is a patch to correct the problem with the IDE code when you have
the Secondary Channel Only enabled in your BIOS.  If you have only the
secondary channel enabled, a null pointer get passed to the
ide_iomio_dma function as the part of the hwif var (more specifically
hwif->mate)  This patch puts in some extra sanity checks in that section
so make sure we don't hit the null.

Jason

P.S.  This is a continuation of a previous patch I submitted for 2.5.43
which wasn't committed and I didn't send that to the maintainer (Sorry
Andre) so I am resending it now as a patch to the 2.5.44 kernel.



--=-4cM6w68X8PyLS3KMPaRE
Content-Description: 
Content-Disposition: inline; filename=ide-sec-channel-fix.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; charset=ISO-8859-1

diff -u -r linux-2.5.44-vanilla/drivers/ide/ide-dma.c linux-2.5.44/drivers/=
ide/ide-dma.c
--- linux-2.5.44-vanilla/drivers/ide/ide-dma.c	2002-10-21 08:02:49.00000000=
0 -0500
+++ linux-2.5.44/drivers/ide/ide-dma.c	2002-10-21 08:56:49.000000000 -0500
@@ -905,7 +905,12 @@
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra =3D hwif->cds->extra;
 	}
-	hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;
+	if(!hwif->mate && hwif->channel){
+		hwif->dma_master=3Dbase;
+	}
+	else{
+		hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;
+	}
 	if (hwif->dma_base2) {
 		if (!check_mem_region(hwif->dma_base2, ports))
 			request_mem_region(hwif->dma_base2, ports, hwif->name);
@@ -925,8 +930,13 @@
 	if ((hwif->cds->extra) && (hwif->channel =3D=3D 0)) {
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra =3D hwif->cds->extra;
+	}=09
+	if(!hwif->mate && hwif->channel){
+		hwif->dma_master=3Dbase;
+	}
+	else{
+		hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;
 	}
-	hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;
 	if (hwif->dma_base2) {
 		if (!request_region(hwif->dma_base2, ports, hwif->name))
 		{


--=-4cM6w68X8PyLS3KMPaRE--

