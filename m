Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161468AbWALX3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161468AbWALX3a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161469AbWALX3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:29:30 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:34487 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161468AbWALX33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:29:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 00:31:33 +0100
User-Agent: KMail/1.9
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200601122241.07363.rjw@sisk.pl> <20060112220940.GA10088@elf.ucw.cz>
In-Reply-To: <20060112220940.GA10088@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601130031.34624.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > This is the next version of the patch that adds a user space interface to
> > swsusp.
> 
> Looks mostly okay, few nits...
> 
> > +	case SNAPSHOT_IOCFREEZE:
> 
> Could we make it SNAPSHOT_IOC_FREEZE or even better SNAPSHOT_FREEZE?

Sure, I'll do that.

> > +commands defined in kernel/power/power.h.  The major and minor
> > +numbers of the device are, respectively, 10 and 231, and they can
> > +be read from /sys/class/misc/snapshot/dev.
> 
> Is this still true?

You mean the /sys/class/misc/snapshot/dev?  Yes, until sysfs gets revamped.

> > +The device can be open either for reading or for writing.  If open for
> > +reading, it is considered to be in the suspend mode.  Otherwise it is
> > +assumed to be in the resume mode.  The device cannot be open for reading
> > +and writing.  It is also imposiible to have the device open more
>                             ~~~~~~~~~~
> 				typo.

Ah, thanks.

> > +SNAPSHOT_IOCSET_IMAGE_SIZE - set the preferred maximum size of the image
> > +	(the kernel will do its best to ensure the image size will not exceed
> > +	this number, but if it turns out to be impossible, the kernel will
> > +	create the smallest image possible)
> 
> Nice.
> 
> > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> > +	should be a pointer to an unsigned int variable that will contain
> > +	the result if the call is successful)
> 
> Is this good idea? It will overflow on 32-bit systems. Ammount of
> available swap can be >4GB. [Or maybe it is in something else than
> bytes, then you need to specify it.]

It returns the number of pages.  Well, it should be written explicitly,
so I'll fix that.

[This feature is actually useful, because it allows you to check if you have
enough swap after creating the snapshot and retry for eg. image_size = 0
without unfreezing tasks.]

> > +SNAPSHOT_IOCSET_SWAP_FILE - set the resume partition (the last ioctl() argument
> > +	should specify the device's major and minor numbers in the old
> > +	two-byte format, as returned by the stat() function in the .st_rdev
> > +	member of the stat structure); it is recommended to always use this
> > +	call, because the other code the could have set the resume partition
> > +	need not be present in the kernel
> 
> Parse error on last sentence.
> 
> "because the code to set the resume partition could be removed from
> future kernels"?

Yes, I forgot to change this.  Thanks.

> > +For details, please refer to the source code.
> 
> We should specify that userland suspend/resume utilities should lock
> themselves in memory before freezing system, and not attempt
> filesystem operations after freeze. (Probably not even reads).

Yes, I'll do that.

> We may want to specify if it is okay to snapshot system and then
> unfreeze and continue. I'd suggest supporting that -- it will be handy
> for "esc to abort" and "suspend to RAM and disk".

Sure, you can do that.  Closing the device should return the system to
the normal state.

> Ouch and you have my ACK on next attempt :-).

Thanks (you are brave, though ;-)).

Greetings,
Rafael
