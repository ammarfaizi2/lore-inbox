Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269672AbTGaVFN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269685AbTGaVFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:05:12 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:47856 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S269672AbTGaVE5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:04:57 -0400
Message-ID: <3F298517.8060202@pacbell.net>
Date: Thu, 31 Jul 2003 14:07:35 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: Charles Lepple <clepple@ghz.cc>, Greg KH <greg@kroah.com>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] reorganize USB submenu's
References: <20030731101144.32a3f0d7.shemminger@osdl.org>	<23979.216.12.38.216.1059672599.squirrel@www.ghz.cc> <20030731125032.785ffba1.shemminger@osdl.org>
In-Reply-To: <20030731125032.785ffba1.shemminger@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> --- linux-2.5/drivers/usb/gadget/Kconfig	2003-06-05 10:04:40.000000000 -0700
> +++ usb/drivers/usb/gadget/Kconfig	2003-07-31 12:45:04.000000000 -0700
> @@ -35,9 +35,6 @@
>  #
>  # USB Peripheral Controller Support
>  #
> -choice
> -	prompt "USB Peripheral Controller Support"
> -	depends on USB_GADGET
>  
>  config USB_NET2280
>  	tristate "NetChip 2280 USB Peripheral Controller"
> @@ -54,21 +51,23 @@
>  	   dynamically linked module called "net2280" and force all
>  	   gadget drivers to also be dynamically linked.
>  
> -endchoice

Why do you want to remove that choice menu?  By doing that,
you've enabled illegal configurations.

In this case:  no more than one controller driver may be
linked, since USB devices have exactly one upstream link.
By detecting this at configuration time, the current menus
prevent a link-time error.

This choice could be improved (at this point I'd likely
desupport "dummy plus real controller as modules", and
the more troublesome cases it carries along with it), but
that's not how I'd do it.



> @@ -110,7 +109,7 @@
>  
>  config USB_ETH
>  	tristate "Ethernet Gadget"
> -	depends on USB_GADGET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA250 || USB_SA1100)
> +	depends on USB_GADGET_CONTROL

This approach allows illegal configurations too.  The config-time
dependencies prevent compile-time errors, by only enabling the
configurations that are known to compile and work.

When an "au1x00_udc" controller is added, each gadget driver will
need to be modified to know about its endpoints and config quirks,
then tested.  (And some gadget drivers won't be able to do that:
maybe they need lots of endpoints, or rely on config change events
that particular hardware disallows.)  By allowing arbitrary driver
stacking, you'd be causing at least compile errors.

Likewise, when an "audio" gadget driver is added, it'll need testing
on each controller.  And since SA1100 can never support iso transfers,
that configuration shouldn't even be allowed.


Both your proposed changes share a common feature:  reducing the degree
to which illegal configurations are prevented.  Is that intentional?

- Dave



