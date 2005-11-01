Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbVKBFLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbVKBFLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 00:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751504AbVKBFLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 00:11:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:40835 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751502AbVKBFLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 00:11:18 -0500
Date: Tue, 1 Nov 2005 14:45:10 -0800
From: Greg KH <greg@kroah.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051101224510.GB28193@kroah.com>
References: <4363F9B5.6010907@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4363F9B5.6010907@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:37:41AM +0200, matthieu castet wrote:
> Please comment and consider for inclusion.

I need a "Signed-off-by:" line in order to be able to add it.  Care to
redo things based on the comments you have had and resend it with this
line?

> + *
> + * This software is available to you under a choice of one of two
> + * licenses. You may choose to be licensed under the terms of the GNU
> + * General Public License (GPL) Version 2, available from the file
> + * COPYING in the main directory of this source tree, or the
> + * BSD license below:
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:

<snip>  You don't need the whole GPL 2 copy here, just put the first
paragraph you have before this one in.

> +#define EAGLEUSBVERSION "ueagle-svn $Id: ueagle.c 141 2005-09-03 20:12:24Z matc $"

We don't use $Id within the kernel tree, please remove this.

> +static int uea_read_proc(char *page, char **start, off_t off, int count,
> +			int *eof, void *data);

No new proc files will be added for drivers, please use sysfs instead
(with only one file per value.)

> +/*
> + * sometime hotplug don't have time to give the firmware the
> + * first time, retry it.
> + */
> +static int sleepy_request_firmware(const struct firmware **fw, 
> +		const char *name, struct device *dev)
> +{
> +	if (request_firmware(fw, name, dev) == 0)
> +		return 0;
> +	msleep(1000);
> +	return request_firmware(fw, name, dev);
> +}

No, use the async firmware download mode instead of this.  That will
solve all of your problems.

> +/* we need to use semaphore until sysfs and removable devices is fixed
> + * the problem is explained on http://marc.theaimsgroup.com/?t=112006484100003
> + */

This is the proper fix, why do you think it should be fixed in the
driver core?

> +#define UEA_DEVICE(vid, pid, info) \
> +	{USB_DEVICE((vid), (pid)), .driver_info = (info)}

Why create a macro for such a simple thing?  That's not needed.

> diff -rNu -x '*.ko*' -x '*.mod*' -x '*.o*' linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h linux-2.6.14/drivers/usb/atm/ueagle-atm.h
> --- linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.14/drivers/usb/atm/ueagle-atm.h	2005-10-30 00:25:27.000000000 +0200

Why do you need a header file for a single .c file?

> +#define PACKED __attribute__ ((packed))

No, spell it out please.

> +/* structure describing a block within a DSP page */
> +typedef struct {
> +	__le16 wHdr;
> +#define UEA_BIHDR 0xabcd
> +	__le16 wAddress;
> +	__le16 wSize;
> +	__le16 wOvlOffset;
> +	__le16 wOvl;		/* overlay */
> +	__le16 wLast;
> +} PACKED block_info_t;

Do not create new typedefs.  Please get rid of all of them.

thanks,

greg k-h
