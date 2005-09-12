Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbVILQ32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbVILQ32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 12:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbVILQ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 12:29:28 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:56049 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932069AbVILQ31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 12:29:27 -0400
Date: Mon, 12 Sep 2005 09:27:39 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, ltuikov@yahoo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050912162739.GA11455@us.ibm.com>
References: <20050910024454.20602.qmail@web51613.mail.yahoo.com> <1126368081.4813.46.camel@mulgrave> <4325997D.3050103@adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4325997D.3050103@adaptec.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2005 at 11:06:37AM -0400, Luben Tuikov wrote:

> > We have an infrastructure in the mid-layer for doing report lun scans.
> > You have a parallel one in your code.  In my book, that's duplication.
> 
> This infrastructure is broken.  Its interface is broken.  It is a horrible
> excuse of LUN scanning written initially to support a certain hardware.

That is not true of the report lun support, it was written initially for
support of any hardware. Of course it was tested on certain hardware, but
that was not the goal.

> And secondly, the routine which I've written is NOT duplication.
> It is the _correct_ way to do it, while the one in SCSI Core
> is *crap*, thus there is no duplication.

What is wrong with the one in scsi core?

Your implementation has problems for large numbers of LU the secondary
kmalloc() will always fail. I do not see how it handles transient failures
either, or (per below discussion) devices that return bogus data.

> >>>>+ * REPORT LUNS is mandatory.  If a device doesn't support it,
> [cut]
> >>Second, SAS devices being very recent have their firmware written
> >>to latest specs, and advertised as SPC-3 and SAM-3.

> > We have boatloads of devices that claim SCSI-n or SPC-n compliance then
> > fail in various ways.  That's what the list in scsi_devinfo.c is all
> > about.  I'm sure the manufacturers of those devices didn't intentionally
> > set out to violate the specs; however, what they actually released does.
> > I'm sure that SAS vendors will start out with the best of intentions
> > too ...
> 
> I've run this code on pre-pre-pre-.... firmware and it handles
> really broken REPORT LUNS devices.  It works *without the need* for
> a blacklist lookup table.

There could (will?) be bridges from SAS to anything (like existing SPI to
IDE bridges, or FC to SPI bridges), so it is likely it will have to
handle not-so-new and potentially brain dead storage devices.

> Second, I did ask for REPORT LUNS mechanism into SCSI Core before it
> was there.

That code was not written because anyone asked for it.

> Are you asking me to submit a patch for SCSI Core to do proper
> REPORT LUNS?   *This is ubelievable.*  I would like the whole
> world to note it (for your sake).

At least tell us what is wrong with it, I know it does not have well known
LUN support, and we already know about 8 byte LUN support.


IMO adding well known LUNs at this point to the standard added nothing of
value, the target firmware has to check for special paths no matter what,
adding a well known LUN does not change that. And most vendors will
(likely) have support for use without a well known LUN. (This does not
mean we should not support it in linux, I just don't know why this went
into the standard.)

Using well known LUNs will be another code path that will have to live
alongside existing ones, and will likely require further black listing
(similar to REPORT LUN vs scanning for LUNs).

-- Patrick Mansfield
