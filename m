Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265251AbSJRQWJ>; Fri, 18 Oct 2002 12:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbSJRQWJ>; Fri, 18 Oct 2002 12:22:09 -0400
Received: from wilma1.suth.com ([207.127.128.4]:8207 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S265251AbSJRQWH>;
	Fri, 18 Oct 2002 12:22:07 -0400
Subject: [PATCH] IDE handles Secondary Only incorrectly
From: Jason Williams <jason_williams@suth.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-PfehaL0/WdJA5Zj4iHIE"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Oct 2002 12:30:34 -0400
Message-Id: <1034958639.26868.14.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-PfehaL0/WdJA5Zj4iHIE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

After some investigation, I found that the IDE System in the 2.5.43
kernel didn't handle IDE set up correctly on an interface with just the
secondary channel enabled in BIOS.  I thought it was a problem with the
VIA controller, but it was actually a piece of code not handling a null
variable properly.  This variable is not being populated because one of
the interfaces in the system is not enabled.  The culprit is in the
ide-dma.c file.  Attached is a patch to act as a quick fix to this
problem.  It circumvents the kernel oops my checking the variable in
question and ignoring it if there is only one interface.  This is safe
to do for development purposes, but a real fix should probably come out
of the IDE folks.  The behavior that I think might be what is intended
is that the hwif->mate should be populated with the same values as the
hwif variable itself is there is only the secondary interface enabled. 
Just a thought, I am not sure if it is on the right path though.


Jason Williams



--=-PfehaL0/WdJA5Zj4iHIE
Content-Disposition: attachment; filename=ide_sec_fix.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ide_sec_fix.patch; charset=ISO-8859-1

--- ide-dma.orig.c	2002-10-18 12:25:08.000000000 -0500
+++ ide-dma.c	2002-10-18 12:23:55.000000000 -0500
@@ -905,7 +905,12 @@
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra =3D hwif->cds->extra;
 	}
-	hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;
+	if(hwif->channel && hwif->mate =3D=3D NULL) {
+		hwif->dma_master =3D base;
+	}
+	else {
+		hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;
+	}
 	if (hwif->dma_base2) {
 		if (!check_mem_region(hwif->dma_base2, ports))
 			request_mem_region(hwif->dma_base2, ports, hwif->name);
@@ -926,7 +931,12 @@
 		request_region(base+16, hwif->cds->extra, hwif->cds->name);
 		hwif->dma_extra =3D hwif->cds->extra;
 	}
-	hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;=09
+	if(hwif->mate =3D=3D NULL && hwif->channel) {
+		hwif->dma_master =3D base;
+	}
+	else {
+		hwif->dma_master =3D (hwif->channel) ? hwif->mate->dma_base : base;=09
+	}
 	if (hwif->dma_base2) {
 	=09
 		if (!request_region(hwif->dma_base2, ports, hwif->name))

--=-PfehaL0/WdJA5Zj4iHIE--

