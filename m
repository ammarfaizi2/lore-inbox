Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVKOPez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVKOPez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 10:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVKOPez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 10:34:55 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:7943 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S932542AbVKOPey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 10:34:54 -0500
Date: Tue, 15 Nov 2005 15:34:44 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Tony <tony.uestc@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MOD_INC_USE_COUNT
Message-ID: <20051115153444.GB15733@linux-mips.org>
References: <437347B5.6080201@gmail.com> <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com> <43735766.3070205@gmail.com> <20051113102930.GA16973@linux-mips.org> <43795C71.6070108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43795C71.6070108@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 11:56:33AM +0800, Tony wrote:

> >Not strange at all.  The typical network driver is implemented using
> >pci_register_driver which will set the owner filed of the driver's struct
> >driver which then is being used for internal reference counting.  Other
> >busses or line disciplines (SLIP, PPP, AX.25 ...) need to do the equivalent
> >or the kernel will believe reference counting isn't necessary and it's
> >ok to unload the module at any time.
> >
> >In which driver did you hit this problem?
> >
> >  Ralf
> >
> I have a radio connected to host using ethernet. I'm writing a radio 
> driver that masquerade radio as a NIC. when the module is loaded, I just 
> register_netdev a net_device struct, while unregister_netdev at module 
> cleanup.

register_netdev / unregister_netdev don't deal with the .owner stuff, so
your bug isn't there.  If your NIC is a PCI card, it should register it's
driver through pci_register_driver which would deal with the necessary
reference counting.  If it's implemented as a platform device you're
presumably calling driver_register() before platform_device_register() and
driver_register() would do the necessary magic for you.  If you're using a
different bus it may have it's own variant of driver_register which you
should call.  If you don't, you have a problem :-)

  Ralf
