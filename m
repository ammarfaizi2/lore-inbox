Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVKPNY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVKPNY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 08:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbVKPNY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 08:24:27 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:24583 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1030323AbVKPNY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 08:24:26 -0500
Date: Wed, 16 Nov 2005 13:24:21 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Tony <tony.uestc@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MOD_INC_USE_COUNT
Message-ID: <20051116132421.GC3229@linux-mips.org>
References: <437347B5.6080201@gmail.com> <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com> <43735766.3070205@gmail.com> <20051113102930.GA16973@linux-mips.org> <43795C71.6070108@gmail.com> <20051115153444.GB15733@linux-mips.org> <437AE21D.9040501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437AE21D.9040501@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 03:39:09PM +0800, Tony wrote:

> >>>Not strange at all.  The typical network driver is implemented using
> >>>pci_register_driver which will set the owner filed of the driver's struct
> >>>driver which then is being used for internal reference counting.  Other
> >>>busses or line disciplines (SLIP, PPP, AX.25 ...) need to do the 
> >>>equivalent
> >>>or the kernel will believe reference counting isn't necessary and it's
> >>>ok to unload the module at any time.
> >>>
> >>>In which driver did you hit this problem?
> >>>
> >>>Ralf
> >>>
> >>
> >>I have a radio connected to host using ethernet. I'm writing a radio 
> >>driver that masquerade radio as a NIC. when the module is loaded, I just 
> >>register_netdev a net_device struct, while unregister_netdev at module 
> >>cleanup.
> >
> >
> >register_netdev / unregister_netdev don't deal with the .owner stuff, so
> >your bug isn't there.  If your NIC is a PCI card, it should register it's
> >driver through pci_register_driver which would deal with the necessary
> >reference counting.  If it's implemented as a platform device you're
> >presumably calling driver_register() before platform_device_register() and
> >driver_register() would do the necessary magic for you.  If you're using a
> >different bus it may have it's own variant of driver_register which you
> >should call.  If you don't, you have a problem :-)
> >
> >  Ralf
> >
> That is indeed my problem. My driver is none of types of drivers, it's 
> just a software virtual one. I think I should mimic the way SLIP handle 
> it. thank a loooooooot!!!

SLIP is a line discipline; it's reference counting happens through
tty_register_ldisc() but probably your code isn't a line discipline ...
You however might use the platform device code - see
include/linux/platform_device.h and the many users throughout the kernel.
The platform device concept was really meant to support physical hardware
but it should work just fine in your case.  Maybe
drivers/net/mipsnet.c can serve as an example - it's a driver for virtual
NIC on a software emulator.

  Ralf
