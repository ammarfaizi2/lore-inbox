Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261158AbSJWLak>; Wed, 23 Oct 2002 07:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261223AbSJWLak>; Wed, 23 Oct 2002 07:30:40 -0400
Received: from wilma1.suth.com ([207.127.128.4]:29448 "EHLO wilma1.suth.com")
	by vger.kernel.org with ESMTP id <S261158AbSJWLai>;
	Wed, 23 Oct 2002 07:30:38 -0400
Subject: Re: Linux 2.5.44-ac1
From: Jason Williams <jason_williams@suth.com>
To: Alan Cox <alan@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
References: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
Content-Type: multipart/mixed; boundary="=-81KYlk5lfS/Na32gcQVt"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 07:39:35 -0400
Message-Id: <1035373185.24550.21.camel@cermanius.suth.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-81KYlk5lfS/Na32gcQVt
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-10-22 at 13:27, Alan Cox wrote:
> ** I strongly recommend saying N to IDE TCQ options otherwise this
>    should hopefully build and run happily.

I don't have the IDE TCQ options on and am still having an issue with a
kernel oops in the default kernel code.  I did some digging after  I
noticed it in 2.5.43 and found a possibility for a null pointer in the
code within the ide_iomio_dma function in ide-dma.c The problem shows
itself if you only enable the secondary channel of your IDE controller. 
I understand this is a strange set up, but it could happen in a machine
that boots off of SCSI and uses IDE disks for DATA or a CD Burner. I
came up with a fix, some extra sanity checks before this line in the
code:

hwif->dma_master = (hwif->channel) ? hwif->mate->dma_base : base;

Because it is the hwif->mate variable that is null when it gets here and
if hwif->channel is not 0 I am taking it from the logic on this line
that hwif->mate should not be a null variable.  So I applied the sainity
checks in the attached patch and this seems to work.  I did this against
the 2.5.43 and 2.5.44 kernels, and have posted patches for each of them
but no one seems interested.  If I am completely off base here, just let
me know and I'll go back to the code and look for a different way to
conquer this little bug.

Jason





--=-81KYlk5lfS/Na32gcQVt
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


--=-81KYlk5lfS/Na32gcQVt--

