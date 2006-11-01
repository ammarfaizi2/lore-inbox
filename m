Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946386AbWKAFmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946386AbWKAFmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946531AbWKAFlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:41:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:38875 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946526AbWKAFls
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:41:48 -0500
Message-Id: <20061101054158.412867000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:34:17 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Doug Ledford <dledford@redhat.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 37/61] SCSI: aic7xxx: pause sequencer before touching SBLKCTL
Content-Disposition: inline; filename=scsi-aic7xxx-pause-sequencer-before-touching-sblkctl.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Doug Ledford <dledford@redhat.com>

[SCSI] aic7xxx: pause sequencer before touching SBLKCTL

Some cards need to pause the sequencer before the SBLKCTL register is
touched.  This fixes a PCI related oops seen on powerpc macs with this
card caused by trying to ascertain the bus signalling before beginning
domain validation.

Signed-off-by: James Bottomley <James.Bottomley@SteelEye.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/scsi/aic7xxx/aic7xxx_osm.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.18.1.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ linux-2.6.18.1/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2539,6 +2539,7 @@ static void ahc_linux_set_iu(struct scsi
 static void ahc_linux_get_signalling(struct Scsi_Host *shost)
 {
 	struct ahc_softc *ahc = *(struct ahc_softc **)shost->hostdata;
+	unsigned long flags;
 	u8 mode;
 
 	if (!(ahc->features & AHC_ULTRA2)) {
@@ -2550,7 +2551,11 @@ static void ahc_linux_get_signalling(str
 		return;
 	}
 
+	ahc_lock(ahc, &flags);
+	ahc_pause(ahc);
 	mode = ahc_inb(ahc, SBLKCTL);
+	ahc_unpause(ahc);
+	ahc_unlock(ahc, &flags);
 
 	if (mode & ENAB40)
 		spi_signalling(shost) = SPI_SIGNAL_LVD;

--
