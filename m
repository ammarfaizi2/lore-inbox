Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbVJGOlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbVJGOlT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVJGOlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:41:19 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:42178 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030218AbVJGOlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:41:18 -0400
Date: Fri, 7 Oct 2005 10:41:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Greg KH <greg@kroah.com>, <usb-storage@lists.one-eyed-alien.net>,
       <linux-kernel@vger.kernel.org>, <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [usb-storage] Re: RFC drivers/usb/storage/libusual
In-Reply-To: <20051007002419.5b7d4195.zaitcev@redhat.com>
Message-ID: <Pine.LNX.4.44L0.0510071018530.4833-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few technical comments on aspects of your patch:

On Fri, 7 Oct 2005, Pete Zaitcev wrote:

> diff -urpN -X dontdiff linux-2.6.14-rc2/drivers/usb/storage/usb.h linux-2.6.14-rc2-wip/drivers/usb/storage/usb.h
> --- linux-2.6.14-rc2/drivers/usb/storage/usb.h	2005-09-24 20:32:56.000000000 -0700
> +++ linux-2.6.14-rc2-wip/drivers/usb/storage/usb.h	2005-10-06 21:37:10.000000000 -0700
...
> -/* Dynamic flag definitions: used in set_bit() etc. */
> -#define US_FLIDX_URB_ACTIVE	18  /* 0x00040000  current_urb is in use  */
> -#define US_FLIDX_SG_ACTIVE	19  /* 0x00080000  current_sg is in use   */
> -#define US_FLIDX_ABORTING	20  /* 0x00100000  abort is in progress   */
> -#define US_FLIDX_DISCONNECTING	21  /* 0x00200000  disconnect in progress */
> -#define ABORTING_OR_DISCONNECTING	((1UL << US_FLIDX_ABORTING) | \
> -					 (1UL << US_FLIDX_DISCONNECTING))
> -#define US_FLIDX_RESETTING	22  /* 0x00400000  device reset in progress */
> -#define US_FLIDX_TIMED_OUT	23  /* 0x00800000  SCSI midlayer timed out  */
> -
> -
>  #define USB_STOR_STRING_LEN 32

I would prefer to keep these definitions in the usb-storage driver.  They 
refer to dynamic aspects of an individual device, not static blacklist or 
ID-matching for all devices of a particular type.  As such, they are of no 
interest to ub or libusual.


> diff -urpN -X dontdiff linux-2.6.14-rc2/include/linux/usb_usual.h linux-2.6.14-rc2-wip/include/linux/usb_usual.h
> --- linux-2.6.14-rc2/include/linux/usb_usual.h	1969-12-31 16:00:00.000000000 -0800
> +++ linux-2.6.14-rc2-wip/include/linux/usb_usual.h	2005-09-27 18:05:09.000000000 -0700
> +/*
> + * The bias field for libusual and friends.
> + * Observe that usb-storage blatantly mixes set_bit() and normal
> + * shift and mask operations on flags, which is strictly illegal.
> + * And it probably even works for all flags except GO_SLOW and NO_WP_DETECT.

The two types of operations are used to write these flags at strictly
different times.  The shift/mask operations are used while initializing
the data structures and the set_bit-style operations are used after
everything has been set up and the device is operational.

Once the device is running, the shift/mask operations are used _only_ for
reading, never for writing.  This is true for all of the static flags, not
just GO_SLOW and NO_WP_DETECT.  There shouldn't be anything wrong or
illegal about it.  I don't see how it could possibly cause any kind of
error or problem.

It's true that two separate words could be used for the two kinds of flag
bits.  But since they coexist peacefully now, there doesn't seem to be any
need.

Alan Stern

