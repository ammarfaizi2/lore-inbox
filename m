Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVCOT7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVCOT7W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 14:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVCOT4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 14:56:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:21919 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261842AbVCOTvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 14:51:38 -0500
Date: Tue, 15 Mar 2005 11:51:21 -0800
From: Greg KH <greg@kroah.com>
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [RFC] Changes to the driver model class code.
Message-ID: <20050315195121.GA27408@kroah.com>
References: <20050315170834.GA25475@kroah.com> <20050315190847.GA1870@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050315190847.GA1870@isilmar.linta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2005 at 08:08:47PM +0100, Dominik Brodowski wrote:
> On Tue, Mar 15, 2005 at 09:08:34AM -0800, Greg KH wrote:
> > Then I moved the USB host controller code to use this new interface.
> > That was a bit more complex as it used the struct class and struct
> > class_device code directly.  As you can see by the patch, the result is
> > pretty much identical, and actually a bit smaller in the end.
> > 
> > So I'll be slowly converting the kernel over to using this new
> > interface, and when finished, I can get rid of the old class apis (or
> > actually, just make them static) so that no one can implement them
> > improperly again...
> > 
> > Comments?
> 
> The "old" class api _forced_ you to think of reference counting of
> dynamically allocated objects, while it gets easier to get reference
> counting wrong using this "simple"/"new" interface: while struct class will 
> always have fine reference counting, the "parent" struct [with struct class
> no longer being embedded] needs to be thought of individually; and the 
> reference count cannot be shared any longer.

The reference counting will now be correct.  That is implicit in the
interface, and was done because, not to sound like a broken record,
_everyone_ got it wrong when they tried to do it...

> Also, it seems to me that you view the class subsystem to be too closely
> related to /dev entries -- and for these /dev entries class_simple was
> introduced, IIRC. However, /dev is not the reason the class subsystem was 
> introduced for -- instead, it describes _types_ of devices which want to
> share (userspace and in-kernel) interfaces.

I agree, I know it isn't directly related to /dev entries, but that _is_
the most common usage of it, so I can't ignore it :)

Anyway, it's very simple to convert over to using the new functions, and
still have all of your sysfs and reference counting functionality.  See
the USB patch that I posted in this series as an example of how to do
this.  Just use a kref and a pointer to the class_device.  You have all
of the previous functionality that you needed before right there.

> For example pcmcia sockets which
> can reside on different buses, but can be handled (mostly) the same way by
> kernel- and userspace. For example, temperature sensors could be exported
> using /sys/class/temp_sensors/... -- then userspace wouldn't need to know
> whether the temperature was determined using an ACPI BIOS call or by
> accessing an i2c device. Such "abstractions", and other kernel code whcih
> uses these "abstractions" (a.k.a. class interfaces) are a great feature to
> have, and one too less used by now.

class interfaces are not going away, there's a good need for them like
you have pointed out.  I'm not expecting to just delete those api
functions tomorrow, but slowly phase out the use of them over time, and
hopefully, eventually get rid of them.  I think that with my USB host
controller patch, I've proved that they are not as needed as you might
think they were.

It's easy to make a complex, powerful, all-singing-all-dancing api.
That's what we have today.  It's hard to make such an api easy to use,
that's what we need to realize and start to fix.  This is the first of
such steps to try to achieve this.

thanks,

greg k-h
