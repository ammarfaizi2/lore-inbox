Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTEOOSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264051AbTEOOSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:18:40 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:45580 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264045AbTEOOSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:18:38 -0400
Date: Thu, 15 May 2003 16:31:21 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: davej@codemonkey.org.uk
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, gregkh@kroah.com
Subject: Re: mysterious shifts in USB storage drivers.
Message-ID: <20030515143121.GA29658@win.tue.nl>
References: <200305150331.h4F3VHID000770@deviant.impure.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305150331.h4F3VHID000770@deviant.impure.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 04:31:17AM +0100, davej@codemonkey.org.uk wrote:

> These went into 2.4 over a year ago. Unfortunatly,
> with no comments in the logs.
> 
> 
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/storage/datafab.c linux-2.5/drivers/usb/storage/datafab.c
> --- bk-linus/drivers/usb/storage/datafab.c	2003-04-10 06:01:25.000000000 +0100
> +++ linux-2.5/drivers/usb/storage/datafab.c	2003-03-17 23:42:38.000000000 +0000
> @@ -670,7 +670,7 @@ int datafab_transport(Scsi_Cmnd * srb, s
>  			srb->result = SUCCESS;
>  		} else {
>  			info->sense_key = UNIT_ATTENTION;
> -			srb->result = CHECK_CONDITION << 1;
> +			srb->result = CHECK_CONDITION;
>  		}
>  		return rc;
>  	}

And then you say: I have no idea what they do, let us also put them in 2.5?

Very long ago someone noticed that all status codes were even
and decided to save some space in arrays by shifting them right one.

Thus, we find in drivers/scsi/scsi.h:
#define status_byte(result) (((result) >> 1) & 0x1f)

Usually the status byte is returned by the device, but everywhere
where we invent a status ourselves we need the <<1.
This is annoying, and the kernl, both 2.4 and 2.5, is full of
mistakes here - may submit some patches against 2.5.70 in case
that appears soon. These days we also have the explicit codes
that have been shifted already:

/*
 *  SCSI Architecture Model (SAM) Status codes. Taken from SAM-3 draft
 *  T10/1561-D Revision 4 Draft dated 7th November 2002.
 */
#define SAM_STAT_GOOD            0x00
#define SAM_STAT_CHECK_CONDITION 0x02
#define SAM_STAT_CONDITION_MET   0x04
#define SAM_STAT_BUSY            0x08
...
/*
 *  Status codes. These are deprecated as they are shifted 1 bit right
 *  from those found in the SCSI standards. This causes confusion for
 *  applications that are ported to several OSes. Prefer SAM Status codes
 *  above.
 */

#define GOOD                 0x00
#define CHECK_CONDITION      0x01
#define CONDITION_GOOD       0x02
#define BUSY                 0x04

Andries

