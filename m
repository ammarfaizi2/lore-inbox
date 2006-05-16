Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751807AbWEPMeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751807AbWEPMeE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:34:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751812AbWEPMeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:34:04 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:44808 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1751807AbWEPMeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:34:01 -0400
Date: Tue, 16 May 2006 14:33:51 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Heiko Gerstung <heiko@am-anger-1.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug related to bonding
Message-ID: <20060516123351.GA22040@w.ods.org>
References: <44684B60.1070705@am-anger-1.de> <20060516045332.GN11191@w.ods.org> <44695D2A.9080705@am-anger-1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44695D2A.9080705@am-anger-1.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2006 at 07:03:38AM +0200, Heiko Gerstung wrote:
> Good morning/afternoon/evening (please choose your favourtite time of
> day:-))!

it was the morning by then :-)

> Thank you very much for the hint. I was able to track this down to the
> driver which seems to crash when trying to serve a ETHTOOL_GSET ioctl
> from the bonding driver. When I comment that out, it does not crash
> anymore but then there is link detection available, of course.

OK, this is a significative finding.

> > If you can use a serial console, it will help you. If you don't have
> > enough time to copy it by hand, boot with 'panic=180' to get 3 minutes
> > before the automatic reboot. It is very important to get the other
> > registers, and particularly the stack dump to know what function called
> > schedule().
> >   
> 
> Another nice hint, but unfortunately the device I have to deal with has
> no serial ports available.

In this case, hand-copying is still available. We've all done that a lot
of times and it does not take as long as you can imagine.

> For me it looks like the driver (rtl8150.c) seems to always call
> "copy_to_user" when it handles such a ETHTOOL_GSET call. I would assume
> that this causes trouble when the bonding module uses the ioctl, because
> there is no userspace memory that has to be addressed in such a case.
> Mmmh, it should find out from the pointer (I get with the ETHTOOL ioctl)
> if this is kernelspace or userspace and then call copy_to_user only if
> applicable.

Well, at first, I did not find this driver, then I realized that it was
and USB one ! Its ethtool ioctl calls usb_control_msg() which is defined
in usb/usb.c. Look at the header :

 *      Don't use this function from within an interrupt context, like a
 *      bottom half handler.  If you need a asyncronous message, or need to send
 *      a message from within interrupt context, use usb_submit_urb()
 */
int usb_control_msg(struct usb_device *dev, unsigned int pipe, __u8 request,

So I think that the rtl8150 driver is simply buggy, or at least does not
expect to be used this way.

> Anyone here who can tell me how to handle this (or point me to a driver
> which already does that)?

May be you can try to change the 2 usb_control_msg() calls for a
combination of FILL_CONTROL_URB() + usb_submit_urb ? Hmmm reading the
code, it looks like nearly everything is already provided. In
rtl8150_ethtool_ioctl(), you should try to replaces occurences of
get_registers() by async_get_registers() that you will write by
comparing set_registers() with async_set_registers().

> >> All 2.6.x kernels I tried worked fine, but I am currently bound to a
> >> 2.4.x kernel and all 2.4.x kernels I tried (2.4.20, 2.4.29) showed
> >> similiar problems when activating bonding.
> >>     
> >
> > That's interesting, I'll try to diff the bonding driver between 2.4 and
> > 2.6. For info, I have multiple production machines running it on 2.4 with
> > e1000 and tg3 drivers which never had a single problem during years of
> > uptime.
> >   
> We had a number of problems with bonding and that particular driver, but
> we are bound to it due to hardware design decisions. For instance, in a
> 2.4.20 driver the kernel crashed when we used NET-SNMP to get the
> interface statistics for the bond0 interface.

Older versions were awful, but it ahs quickly stabilized and seems OK to me
in *recent* kernels.

> Thanks again for your support,
> kind regards,
> Heiko

Regards,
Willy

