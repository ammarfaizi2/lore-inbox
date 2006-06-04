Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750709AbWFDQK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWFDQK2 (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 12:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWFDQK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 12:10:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:63909 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750709AbWFDQK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 12:10:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=E+5/tkpknFoUny+t57vFHwC3SdVyHUvub/t2rpXEAt9eeIioXNi/oqf0UjgUwB7nzK9nxaQmN/nRFEqKs1bJuTlQb8S52GUA7RC8kdWBG7pIA2+gjxSNZcjAgj2nvzGLSUarzKWXOa8pUF62qg19O7m5eShT6pMgpeCki/BeYDE=
Date: Sun, 4 Jun 2006 20:11:24 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rune Torgersen <runet@innovsys.com>, jgarzik@pobox.com,
        linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
Message-ID: <20060604161124.GA7587@martell.zuzino.mipt.ru>
References: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com> <DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com> <20060602163035.05ab7c71.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060602163035.05ab7c71.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2006 at 04:30:35PM -0700, Andrew Morton wrote:
> > There is an endian issue in the sil24 driver.
> > The follwing pathc seems to fix it for me. (it is also attached in case
> > the mailer borks it for me)
> >
> > Signed-off-by: Rune Torgersen <runet@innovsys.com>
> >
> > Index: linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c
> > ===================================================================
> > --- linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(revision 101)
> > +++ linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(working copy)
> > @@ -446,7 +446,7 @@
> >  	 */
> >  	msleep(10);
> >
> > -	prb->ctrl = PRB_CTRL_SRST;
> > +	prb->ctrl = cpu_to_le16(PRB_CTRL_SRST);
> >  	prb->fis[1] = 0; /* no PM yet */
> >
> >  	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
> > @@ -537,9 +537,9 @@
> >
> >  		if (qc->tf.protocol != ATA_PROT_ATAPI_NODATA) {
> >  			if (qc->tf.flags & ATA_TFLAG_WRITE)
> > -				prb->ctrl = PRB_CTRL_PACKET_WRITE;
> > +				prb->ctrl =
> > cpu_to_le16(PRB_CTRL_PACKET_WRITE);
> >  			else
> > -				prb->ctrl = PRB_CTRL_PACKET_READ;
> > +				prb->ctrl =
> > cpu_to_le16(PRB_CTRL_PACKET_READ);

Are there some other fields that should be marked?

[PATCH] sata_sil24: endian annotations

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/scsi/sata_sil24.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/scsi/sata_sil24.c
+++ b/drivers/scsi/sata_sil24.c
@@ -37,7 +37,7 @@
  * Port request block (PRB) 32 bytes
  */
 struct sil24_prb {
-	u16	ctrl;
+	__le16	ctrl;
 	u16	prot;
 	u32	rx_cnt;
 	u8	fis[6 * 4];
@@ -47,9 +47,9 @@ struct sil24_prb {
  * Scatter gather entry (SGE) 16 bytes
  */
 struct sil24_sge {
-	u64	addr;
-	u32	cnt;
-	u32	flags;
+	__le64	addr;
+	__le32	cnt;
+	__le32	flags;
 };
 
 /*

