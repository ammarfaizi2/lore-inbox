Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWIQFjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWIQFjF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 01:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWIQFjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 01:39:04 -0400
Received: from natblert.rzone.de ([81.169.145.181]:46770 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S1751087AbWIQFjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 01:39:01 -0400
Date: Sun, 17 Sep 2006 07:38:15 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Doug Ledford <dledford@redhat.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.18-rc6
Message-ID: <20060917053815.GA10918@aepfle.de>
References: <Pine.LNX.4.64.0609031939100.27779@g5.osdl.org> <20060905122656.GA3650@aepfle.de> <1157490066.3463.73.camel@mulgrave.il.steeleye.com> <20060906110147.GA12101@aepfle.de> <1157551480.3469.8.camel@mulgrave.il.steeleye.com> <20060907091517.GA21728@aepfle.de> <1157637874.3462.8.camel@mulgrave.il.steeleye.com> <1158378424.2661.150.camel@fc6.xsintricity.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1158378424.2661.150.camel@fc6.xsintricity.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, Doug Ledford wrote:

> On Thu, 2006-09-07 at 09:04 -0500, James Bottomley wrote:
> > On Thu, 2006-09-07 at 11:15 +0200, Olaf Hering wrote:
> > > This does not work: ahc_linux_get_signalling: f 56f6
> > > 
> > > echo $(( 0x56f6 & 0x00002 )) gives 2, and the ahc_inb is called.
> > 
> > Erm, there's something else going on then:  An ultra 2 card has to have
> > this register.  It's used to signal mode changes in
> > ahc_handle_scsiint().  The piece of code in there will trigger and read
> > this register for any ultra 2 + controller every time there's an error
> > (just to see if the bus mode changed).
> 
> Sorry for my belated response, but this usually happens when you access
> an aic chipset too soon after a chip reset.  Try putting a delay before
> whatever access is causing this to see if it make s difference.  Common
> problems include after a chip reset, touching any register will cause
> the card to reset, etc.

As pointed out in private mail, this patch fixes the machine check for
me. Thanks Doug.

Maybe the AHC_ULTRA2 feature check is needed as well for other cards.

---
 drivers/scsi/aic7xxx/aic7xxx_osm.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc7/drivers/scsi/aic7xxx/aic7xxx_osm.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ linux-2.6.18-rc7/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -2539,7 +2539,14 @@ static void ahc_linux_set_iu(struct scsi
 static void ahc_linux_get_signalling(struct Scsi_Host *shost)
 {
 	struct ahc_softc *ahc = *(struct ahc_softc **)shost->hostdata;
-	u8 mode = ahc_inb(ahc, SBLKCTL);
+	unsigned long flags;
+	u8 mode;
+
+	ahc_lock(ahc, &flags);
+	ahc_pause(ahc);
+	mode = ahc_inb(ahc, SBLKCTL);
+	ahc_unpause(ahc);
+	ahc_unlock(ahc, &flags);
 
 	if (mode & ENAB40)
 		spi_signalling(shost) = SPI_SIGNAL_LVD;
