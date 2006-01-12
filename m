Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161349AbWALWJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161349AbWALWJy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161356AbWALWJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:09:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:62360 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161349AbWALWJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:09:53 -0500
Date: Thu, 12 Jan 2006 23:09:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Message-ID: <20060112220940.GA10088@elf.ucw.cz>
References: <200601122241.07363.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601122241.07363.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is the next version of the patch that adds a user space interface to
> swsusp.

Looks mostly okay, few nits...

> +	case SNAPSHOT_IOCFREEZE:

Could we make it SNAPSHOT_IOC_FREEZE or even better SNAPSHOT_FREEZE?

> +commands defined in kernel/power/power.h.  The major and minor
> +numbers of the device are, respectively, 10 and 231, and they can
> +be read from /sys/class/misc/snapshot/dev.

Is this still true?

> +The device can be open either for reading or for writing.  If open for
> +reading, it is considered to be in the suspend mode.  Otherwise it is
> +assumed to be in the resume mode.  The device cannot be open for reading
> +and writing.  It is also imposiible to have the device open more
                            ~~~~~~~~~~
				typo.

> +SNAPSHOT_IOCSET_IMAGE_SIZE - set the preferred maximum size of the image
> +	(the kernel will do its best to ensure the image size will not exceed
> +	this number, but if it turns out to be impossible, the kernel will
> +	create the smallest image possible)

Nice.

> +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> +	should be a pointer to an unsigned int variable that will contain
> +	the result if the call is successful)

Is this good idea? It will overflow on 32-bit systems. Ammount of
available swap can be >4GB. [Or maybe it is in something else than
bytes, then you need to specify it.]

> +SNAPSHOT_IOCSET_SWAP_FILE - set the resume partition (the last ioctl() argument
> +	should specify the device's major and minor numbers in the old
> +	two-byte format, as returned by the stat() function in the .st_rdev
> +	member of the stat structure); it is recommended to always use this
> +	call, because the other code the could have set the resume partition
> +	need not be present in the kernel

Parse error on last sentence.

"because the code to set the resume partition could be removed from
future kernels"?

> +For details, please refer to the source code.

We should specify that userland suspend/resume utilities should lock
themselves in memory before freezing system, and not attempt
filesystem operations after freeze. (Probably not even reads).

We may want to specify if it is okay to snapshot system and then
unfreeze and continue. I'd suggest supporting that -- it will be handy
for "esc to abort" and "suspend to RAM and disk".

Ouch and you have my ACK on next attempt :-).
								Pavel
-- 
Thanks, Sharp!
