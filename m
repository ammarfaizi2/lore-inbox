Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946519AbWKAFky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946519AbWKAFky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946112AbWKAFky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:40:54 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:12690 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946526AbWKAFkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:40:39 -0500
Message-Id: <20061101054043.672202000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:11 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk,
       James Bottomley <James.Bottomley@steeleye.com>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 31/61] SCSI: aic7xxx: avoid checking SBLKCTL register for certain cards
Content-Disposition: inline; filename=scsi-aic7xxx-avoid-checking-sblkctl-register-for-certain-cards.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: James Bottomley <James.Bottomley@steeleye.com>

[SCSI] aic7xxx: avoid checking SBLKCTL register for certain cards

For cards that don't support LVD, checking the SBLKCTL register to
determine the bus singalling doesn't work.  So, check that the card
supports LVD first (AHC_ULTRA2) before checking the register.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/scsi/aic7xxx/aic7xxx_osm.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

--- linux-2.6.18.1.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ linux-2.6.18.1/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2539,15 +2539,23 @@ static void ahc_linux_set_iu(struct scsi
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

--
