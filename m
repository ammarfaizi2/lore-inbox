Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbTHYPXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 11:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbTHYPXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 11:23:30 -0400
Received: from pc1-cmbg5-6-cust223.cmbg.cable.ntl.com ([81.104.201.223]:24572
	"EHLO flat") by vger.kernel.org with ESMTP id S261897AbTHYPX2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 11:23:28 -0400
Date: Mon, 25 Aug 2003 16:25:29 +0100
From: cb-lkml@fish.zetnet.co.uk
To: Greg KH <greg@kroah.com>, maxk@qualcomm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] [USB] [2.6.0-test3] crash after inserting bluetooth dongle
Message-ID: <20030825152529.GB2132@fish.zetnet.co.uk>
References: <20030821211409.GA2062@fish.zetnet.co.uk> <20030821225614.GA5287@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030821225614.GA5287@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 03:56:14PM -0700, Greg KH wrote:
> On Thu, Aug 21, 2003 at 10:14:10PM +0100, cb-lkml@fish.zetnet.co.uk wrote:
> > I got this oops. Suspicious /proc/interrupts is below, as well as
> > /proc/ioports, dmesg output, config, and lspci -vvv.
> 
> This has been fixed in the test3-bk tree, I would suggest either waiting
> for test4, or downloading the latest -bk patch.
> 
> If this still happens in 2.6.0-test4, please let the bluetooth driver
> author know about it.

Hi Greg, Maxim,

2.6.0-test3-mm3 works fine until APM suspend when the USB controller stops
delivering interrupts. (I'll report further when I have USB working again)

However, in 2.6.0-test4, and 2.6.0-test4-mm1, my USB mouse works but the
bluetooth dongle fails. dmesg logs the following

hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 1, assigned address 3
PM: Adding info for usb:1-1
PM: Adding info for usb:1-1:0
hci_usb: probe of 1-1:1 failed with error -5
PM: Adding info for usb:1-1:1
hci_usb: probe of 1-1:2 failed with error -5
PM: Adding info for usb:1-1:2
hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb c4d6c014 err -22

I've done a bit of printk debugging and found that:
error -5 is -EIO, which is returned because the following test in hci_usb.c
triggers:
        if (intf->altsetting[0].desc.bNumEndpoints < 3)
		return -EIO;

during the first probe bNumEndpoints is 2, during the second it equals 0.

The bluetooth dongle is a bluetake bt009.

I can test patches if required.

Charlie
