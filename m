Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWIFOEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWIFOEw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 10:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWIFOEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 10:04:51 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:12938 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751094AbWIFOEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 10:04:50 -0400
Subject: Re: Linux 2.6.18-rc6
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060906110147.GA12101@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org>
	 <20060905122656.GA3650@aepfle.de>
	 <1157490066.3463.73.camel@mulgrave.il.steeleye.com>
	 <20060906110147.GA12101@aepfle.de>
Content-Type: text/plain
Date: Wed, 06 Sep 2006 09:04:40 -0500
Message-Id: <1157551480.3469.8.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 13:01 +0200, Olaf Hering wrote:
> This causes another machine check because it runs ahc_inb(ahc, SBLKCTL) again.
> With debug I get:

Exactly.  It's not a card state problem; the register simply doesn't
exist.  It looks like from the source code, it only exists on twin or U2
and above chipsets (i.e. those supporting LVD).

Try this patch, which should deduce the bus type for U and below without
resorting to the SBLKCTL register.

James

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index e5bb4d8..0b3c01a 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2539,15 +2539,23 @@ #endif
 static void ahc_linux_get_signalling(struct Scsi_Host *shost)
 {
 	struct ahc_softc *ahc = *(struct ahc_softc **)shost->hostdata;
-	u8 mode = ahc_inb(ahc, SBLKCTL);
+	u8 mode;
 
-	if (mode & ENAB40)
-		spi_signalling(shost) = SPI_SIGNAL_LVD;
-	else if (mode & ENAB20)
+	if (!(ahc->features & AHC_ULTRA2)) {
+		/* non-LVD chipset, may not have SBLKCTL reg */
 		spi_signalling(shost) = 
 			ahc->features & AHC_HVD ?
 			SPI_SIGNAL_HVD :
 			SPI_SIGNAL_SE;
+		return;
+	}
+
+	mode = ahc_inb(ahc, SBLKCTL);
+
+	if (mode & ENAB40)
+		spi_signalling(shost) = SPI_SIGNAL_LVD;
+	else if (mode & ENAB20)
+		spi_signalling(shost) = SPI_SIGNAL_SE;
 	else
 		spi_signalling(shost) = SPI_SIGNAL_UNKNOWN;
 }


