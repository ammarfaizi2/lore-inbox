Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVKGRsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVKGRsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVKGRsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:48:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:37861 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964958AbVKGRsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:48:32 -0500
Date: Mon, 7 Nov 2005 09:46:21 -0800
From: Greg KH <greg@kroah.com>
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, usbatm@lists.infradead.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Eagle and ADI 930 usb adsl modem driver
Message-ID: <20051107174621.GD17004@kroah.com>
References: <4363F9B5.6010907@free.fr> <20051101224510.GB28193@kroah.com> <43691E7E.5090902@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43691E7E.5090902@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 09:15:58PM +0100, matthieu castet wrote:
> Hi Greg,
> 
> thanks for your review.
> 
> Greg KH wrote:
> >On Sun, Oct 30, 2005 at 12:37:41AM +0200, matthieu castet wrote:
> >
> >>Please comment and consider for inclusion.
> >
> >
> >I need a "Signed-off-by:" line in order to be able to add it.  Care to
> >redo things based on the comments you have had and resend it with this
> >line?
> >
> >
> no problem ;)
> >>+ *
> >>+ * This software is available to you under a choice of one of two
> >>+ * licenses. You may choose to be licensed under the terms of the GNU
> >>+ * General Public License (GPL) Version 2, available from the file
> >>+ * COPYING in the main directory of this source tree, or the
> >>+ * BSD license below:
> >>+ *
> >>+ * Redistribution and use in source and binary forms, with or without
> >>+ * modification, are permitted provided that the following conditions
> >>+ * are met:
> >
> >
> ><snip>  You don't need the whole GPL 2 copy here, just put the first
> >paragraph you have before this one in.
> >
> The paragraph you quote is the BSD licence, and point 1 is :
> Redistributions of source code must retain the above copyright
>  *    notice unmodified, this list of conditions, and the following
>  *    disclaimer
> 
> So could I remove it ?

Ugh, you are right, I missed that this was BSD also, sorry.  It's fine.

> >>+/*
> >>+ * sometime hotplug don't have time to give the firmware the
> >>+ * first time, retry it.
> >>+ */
> >>+static int sleepy_request_firmware(const struct firmware **fw, 
> >>+		const char *name, struct device *dev)
> >>+{
> >>+	if (request_firmware(fw, name, dev) == 0)
> >>+		return 0;
> >>+	msleep(1000);
> >>+	return request_firmware(fw, name, dev);
> >>+}
> >
> >
> >No, use the async firmware download mode instead of this.  That will
> >solve all of your problems.
> >
> >
> Thanks, but does userspace will retry if it fails the first time ?
> The device needs the firmware quickly and after 3-5 seconds without it, 
> it goes berserk.

That sounds like a pretty broken device :)

I don't know, have your own timer that disconnects it after X seconds if
you haven't gotten the firmware yet?  Don't rely on userspace getting
around to you real quickly, as we have seen lots of problems with
drivers relying on that timeout.

> >>+/* we need to use semaphore until sysfs and removable devices is fixed
> >>+ * the problem is explained on 
> >>http://marc.theaimsgroup.com/?t=112006484100003
> >>+ */
> >
> >
> >This is the proper fix, why do you think it should be fixed in the
> >driver core?
> >
> I don't remember, but aren't any possible race in sysfs code ?
> In the read, after the up, the usb_disconnect is scheduled, and call 
> device_remove_file. Is that ok for the sysfs code to be still in the 
> read code ?

Depends on what that code does.

> An other case : a process open a file, and start a read. Before the down 
> , the usb_disconnect is scheduled and the module is removed.
> What will do the read, run code from the removed code ?

Again, depends on how your code is structured, and what you are
referencing in that read code.

> >>diff -rNu -x '*.ko*' -x '*.mod*' -x '*.o*' 
> >>linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h 
> >>linux-2.6.14/drivers/usb/atm/ueagle-atm.h
> >>--- linux-2.6.14/drivers/usb/atm.old/ueagle-atm.h	1970-01-01 
> >>01:00:00.000000000 +0100
> >>+++ linux-2.6.14/drivers/usb/atm/ueagle-atm.h	2005-10-30 
> >>00:25:27.000000000 +0200
> >
> >
> >Why do you need a header file for a single .c file?
> >
> I think it makes things cleaner. I even like the bsd style where there 
> is an header for reg (hardware values) and an other for val (driver 
> structures).

This isn't BSD :)

thanks,

greg k-h
