Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVD1TdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVD1TdH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262251AbVD1TbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:31:04 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:18884 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262246AbVD1TaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:30:18 -0400
Subject: Re: 2.6.12-rc3 won't boot from aic7899
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <4269C60C.3070700@cybsft.com>
References: <4269C60C.3070700@cybsft.com>
Content-Type: text/plain
Date: Thu, 28 Apr 2005 12:30:11 -0700
Message-Id: <1114716611.5022.6.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-22 at 22:50 -0500, K.R. Foley wrote:
> scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
>         <Adaptec aic7899 Ultra160 SCSI adapter>
>         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
> 
>   Vendor: SEAGATE   Model: SX118273LC        Rev: 6679
>   Type:   Direct-Access                      ANSI SCSI revision: 02
> scsi1:A:0:0: Tagged Queuing enabled.  Depth 32
>  target1:0:0: Beginning Domain Validation
> (scsi1:A:0): 6.600MB/s transfers (16bit)
> (scsi1:A:0:0): parity error detected in Data-in phase. SEQADDR(0x6b)
> SCSIRATE(0x80)


I assume it just locks up after this?

It looks like the parity error isn't propagating upwards like it should.
What did a 2.6.11 boot sequence show for this (i.e. did the internal
aic7xxx DV configure the device narrow)?

I suspect the attached patch might fix this in the core driver, if you
could try it out.

Thanks,

James

--- k/drivers/scsi/aic7xxx/aic7xxx_core.c  (mode:100644)
+++ l/drivers/scsi/aic7xxx/aic7xxx_core.c  (mode:100644)
@@ -1125,16 +1125,9 @@ ahc_handle_scsiint(struct ahc_softc *ahc
 			else
 				ahc_outb(ahc, MSG_OUT, mesg_out);
 		}
-		/*
-		 * Force a renegotiation with this target just in
-		 * case we are out of sync for some external reason
-		 * unknown (or unreported) by the target.
-		 */
-		ahc_fetch_devinfo(ahc, &devinfo);
-		ahc_force_renegotiation(ahc, &devinfo);
-
-		ahc_outb(ahc, CLRINT, CLRSCSIINT);
-		ahc_unpause(ahc);
+		if (scb != NULL)
+			ahc_set_transaction_status(scb, CAM_UNCOR_PARITY);
+		ahc_reset_channel(ahc, devinfo.channel, TRUE);
 	} else if ((status & SELTO) != 0) {
 		u_int	scbptr;
 


