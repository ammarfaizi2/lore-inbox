Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbULAXhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbULAXhd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 18:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbULAXhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 18:37:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38872 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261494AbULAXel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 18:34:41 -0500
Subject: Re: phase change messages cusing slowdown with sym53c8xx_2 driver
From: Doug Ledford <dledford@redhat.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Matthew Wilcox <matthew@wil.cx>,
       "Jose R. Santos" <jrsantos@austin.ibm.com>,
       linux-scsi mailing list <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1101933788.1930.226.camel@mulgrave>
References: <20041130030212.GB22916@austin.ibm.com>
	 <20041201165654.GA32687@rx8.austin.ibm.com>
	 <1101921398.1930.24.camel@mulgrave>
	 <20041201203226.GI5752@parcelfarce.linux.theplanet.co.uk>
	 <1101933788.1930.226.camel@mulgrave>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 18:34:24 -0500
Message-Id: <1101944065.6490.34.camel@compaq-rhel4.xsintricity.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-01 at 15:43 -0500, James Bottomley wrote:
> On Wed, 2004-12-01 at 15:32, Matthew Wilcox wrote:
> > On Wed, Dec 01, 2004 at 12:16:33PM -0500, James Bottomley wrote:
> > > does this look like the "drive won't respond properly to PPR if the bus
> > > is SE" problem again?
> > 
> > Thomas Babut who tested that fix reported it didn't solve his problem ;-(
> > 
> > http://marc.theaimsgroup.com/?l=linux-scsi&m=109968716312783&w=2
> > http://marc.theaimsgroup.com/?l=linux-scsi&m=109969829411685&w=2
> > 
> > I'm out of ideas for fixing that one.  Would you consider Richard
> > Waltham's patch?
> > 
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109967237930243&w=2
> 
> Actually, yes, or the attached variant of it.  Does this solve the
> problem?
> 
> There's no reason why we should assume a SCSI_3 or greater device
> automatically supports ppr (especially if it's inquiry bit is
> advertising that it doesn't...)

Eh?  Where did that mickey mouse idea come from.  PPR is Mandatory in
SCSI-3 and above SPI class devices, so *yes*, we *should* be assuming
that.  The DT INQUIRY bit was not added to indicate PPR (although PPR is
a requirement of implementing it), it was added so that devices that
didn't conform to the entire SCSI-3 spec and couldn't qualify to carry a
SCSI-3 level could still use higher transfer speeds.  Consider it an LVD
addendum to the SCSI-2 spec.

All this patch does is *hide* the problem, the bug still exists and it's
in the sym_2 driver.

Further, most devices don't change the DT bit in the INQUIRY return data
or their SCSI level depending on bus conditions that will effect whether
or not they can do LVD signaling rates, so the PPR bit is a capability
bit, not a guaranteed to be appropriate at this moment in time bit.
With this patch, those devices that are on LVD buses, support higher
speed transfers, and are full SCSI-3 (or at least some portion of them
will, most SCSI-3 devices didn't use the DT INQUIRY bit as it's
redundant, don't know about the latest stuff) will start magically
negotiating all the way down to a max of 80MB/s data transfer rates
without any CRC checks on the data, parity checks only.

This is a totally broken patch.  I wrote up a description of what the
driver needs to be doing for this stuff and sent it to linux-scsi
mailing list on Nov. 5th.  Just because no one has fixed up the sym_2
driver to do the right thing is no reason to hork the SCSI layer. NAK.

> James
> 
> ===== drivers/scsi/scsi_scan.c 1.134 vs edited =====
> --- 1.134/drivers/scsi/scsi_scan.c	2004-10-24 07:09:48 -04:00
> +++ edited/drivers/scsi/scsi_scan.c	2004-12-01 15:41:03 -05:00
> @@ -554,10 +554,8 @@
>  	sdev->removable = (0x80 & inq_result[1]) >> 7;
>  	sdev->lockable = sdev->removable;
>  	sdev->soft_reset = (inq_result[7] & 1) && ((inq_result[3] & 7) == 2);
> +	sdev->ppr = (sdev->inquiry_len > 56 && (inq_result[56] & 0x04) == 0x04);
>  
> -	if (sdev->scsi_level >= SCSI_3 || (sdev->inquiry_len > 56 &&
> -		inq_result[56] & 0x04))
> -		sdev->ppr = 1;
>  	if (inq_result[7] & 0x60)
>  		sdev->wdtr = 1;
>  	if (inq_result[7] & 0x10)
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
  Doug Ledford <dledford@redhat.com>
         Red Hat, Inc.
         1801 Varsity Dr.
         Raleigh, NC 27606

