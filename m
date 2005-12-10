Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbVLJRim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbVLJRim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 12:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVLJRim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 12:38:42 -0500
Received: from [205.233.219.253] ([205.233.219.253]:55780 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S964909AbVLJRil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 12:38:41 -0500
Date: Sat, 10 Dec 2005 12:32:34 -0500
From: Jody McIntyre <scjody@modernduck.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, torvalds@osdl.org,
       linux1394-devel@lists.sourceforge.net, bcollins@debian.org,
       adq@lidskialf.net, linux-kernel@vger.kernel.org
Message-ID: <20051210173233.GG19441@conscoop.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com>
Bcc: 
Subject: Re: [PATCH] sbp2: fix panic when ejecting an ipod
Reply-To: 
In-Reply-To: <200512101125.jBABP7Z9001085@einhorn.in-berlin.de>

On Sat, Dec 10, 2005 at 12:24:59PM +0100, Stefan Richter wrote:
> sbp2: fix panic when ejecting an ipod
> 
> Sbp2 did not catch some bogus transfer directions in requests from upper
> layers.  Problem became apparent when iPods were to be ejected:
> http://marc.theaimsgroup.com/?l=linux1394-devel&m=113399994920181
> http://marc.theaimsgroup.com/?l=linux1394-user&m=112152701817435
> Debugging and original variant of the patch by Andrew de Quincey.

NAK.  James has a patch to fix this in the SCSI layer, which is his
preference.

Cheers,
Jody

> 
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> Cc: Andrew de Quincey <adq@lidskialf.net>
> 
> ---
> 
> Corresponding fix of the places where transfer direction is actually set and
> how to clean sbp2_create_command_orb() up after this fix is being discussed.
> A patch for SCSI mid and high level has been submitted.
> http://marc.theaimsgroup.com/?t=113400010000001
> Please apply the following patch to prevent kernel panics as the first step.
> 
>  drivers/ieee1394/sbp2.c |   16 ++++++----------
>  1 files changed, 6 insertions(+), 10 deletions(-)
> 
> --- linux/drivers/ieee1394.orig/sbp2.c	2005-11-24 23:10:21.000000000 +0100
> +++ linux/drivers/ieee1394/sbp2.c	2005-12-10 11:57:41.000000000 +0100
> @@ -1784,6 +1784,12 @@ static int sbp2_create_command_orb(struc
>  			break;
>  	}
>  
> +	if (orb_direction != ORB_DIRECTION_NO_DATA_TRANSFER &&
> +	    scsi_request_bufflen == 0) {
> +		SBP2_WARN("Enforcing transfer direction DMA_NONE");
> +		orb_direction = ORB_DIRECTION_NO_DATA_TRANSFER;
> +	}
> +
>  	/*
>  	 * Set-up our pagetable stuff... unfortunately, this has become
>  	 * messier than I'd like. Need to clean this up a bit.   ;-)
> @@ -1900,16 +1906,6 @@ static int sbp2_create_command_orb(struc
>  			command_orb->misc |= ORB_SET_DATA_SIZE(scsi_request_bufflen);
>  			command_orb->misc |= ORB_SET_DIRECTION(orb_direction);
>  
> -			/*
> -			 * Sanity, in case our direction table is not
> -			 * up-to-date
> -			 */
> -			if (!scsi_request_bufflen) {
> -				command_orb->data_descriptor_hi = 0x0;
> -				command_orb->data_descriptor_lo = 0x0;
> -				command_orb->misc |= ORB_SET_DIRECTION(1);
> -			}
> -
>  		} else {
>  			/*
>  			 * Need to turn this into page tables, since the
> 

-- 
