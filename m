Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbWJPBac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWJPBac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 21:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWJPBac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 21:30:32 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:8915 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751283AbWJPBab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 21:30:31 -0400
Date: Sun, 15 Oct 2006 18:31:48 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Neil Brown <neilb@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       aeb@cwi.nl, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-Id: <20061015183148.13f9d1da.randy.dunlap@oracle.com>
In-Reply-To: <17714.52626.667835.228747@cse.unsw.edu.au>
References: <17710.54489.486265.487078@cse.unsw.edu.au>
	<1160752047.25218.50.camel@localhost.localdomain>
	<17714.52626.667835.228747@cse.unsw.edu.au>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Oct 2006 10:08:50 +1000 Neil Brown wrote:

> On Friday October 13, alan@lxorguk.ukuu.org.uk wrote:
> > Ar Gwe, 2006-10-13 am 09:50 +1000, ysgrifennodd Neil Brown:
> > > So:  Is there any good reason to not clip the partitions to fit
> > > within the device - and discard those that are completely beyond
> > > the end of the device??
> > 
> > Its close but not quite the right approach
> > 
> > > The patch at the end of the mail does that.  Is it OK to submit this
> > > to mainline?
> > 
> > No I think not. Any partition which is partly outside the disk should be
> > ignored entirely, that ensures it doesn't accidentally get mounted and
> > trashed by an HPA or similar mixup.
> 
> Hmmm.. So Alan things a partially-outside-this-disk partition
> shouldn't show up at all, and Andries thinks it should.
> And both give reasonably believable justifications.
> 
> Maybe we need a kernel parameter?  How about this?
> 
> NeilBrown
> 
> 
> -----------------------------
> Don't allow partitions to start or end beyond the end of the device.
> 
> Corrupt partitions tables can cause wierd partitions that confuse
> programs.  This is confusion that can be avoided.
> 
> If a partition appears to start at or beyond the end of a device, we
> don't enable it.
> If it starts within the device but ends after the end, we clip it to 
> fit within the device.
> 
> Not enabling partitions does not affect partition numbering of
> subsequent partitions.
> 
> This change applies to partitions found by fs/partitions/check.c
> and to partitions explicitly created via an ioctl.
> 
> There is no uniform agreement on whether partitions that extend
> beyond the end of the device should be clipped or discarded.
> Discarding is safer as it makes corruption less likely.
> Clipping is more flexable and gives continued access to the partition.
> So provide a kernel-parameter which a 'safe' default.
> 
>    partitions=strict
> is the default
>    partitions=relaxed
> means that partitions are clipped rather than rejected.
> This kernel parameters only applies to auto-detected partitions,
> not those set by ioctl.
> 
> 
> Signed-off-by: Neil Brown <neilb@suse.de>
> 
> ### Diffstat output
>  ./Documentation/kernel-parameters.txt |    8 ++++++++
>  ./block/ioctl.c                       |    6 ++++++
>  ./fs/partitions/check.c               |   28 ++++++++++++++++++++++++++--
>  3 files changed, 40 insertions(+), 2 deletions(-)
> 
> diff .prev/Documentation/kernel-parameters.txt ./Documentation/kernel-parameters.txt
> --- .prev/Documentation/kernel-parameters.txt	2006-10-16 10:03:40.000000000 +1000
> +++ ./Documentation/kernel-parameters.txt	2006-10-16 10:06:42.000000000 +1000
> @@ -1148,6 +1148,14 @@ and is between 256 and 4096 characters. 
>  			Currently this function knows 686a and 8231 chips.
>  			Format: [spp|ps2|epp|ecp|ecpepp]
>  
> +	partitions=	How to interpret partition information that
> +			could be corrupt.
> +			'strict' is the default.  Partitions that
> +			don't fit in the device are rejected.
> +			'relaxed' is an option.  Partitions that start
> +			within the device be end beyond the end are

s/be/but/ ??

> +			clipped.
> +

---
~Randy
