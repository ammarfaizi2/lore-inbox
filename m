Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319382AbSIKXOM>; Wed, 11 Sep 2002 19:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319383AbSIKXOM>; Wed, 11 Sep 2002 19:14:12 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:63493 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319382AbSIKXOE>;
	Wed, 11 Sep 2002 19:14:04 -0400
Date: Wed, 11 Sep 2002 16:15:34 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Patrick Mochel <mochel@osdl.org>
Subject: [RFC] USB driver conversion to "struct device_driver" for 2.5.34
Message-ID: <20020911231533.GA29887@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've made an updated version of the patch that converts the USB core and
drivers to use struct device_driver.  It is now against 2.5.34 and can
be found at:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.5/usb-device_driver-2.5.34.patch

Here's a small list of things different from the previous version of
this patch:
	- fix oops when usb device is removed from the system.
	- many more USB drivers converted to the new code.

This version is stable for me (am typing with it right now) and I'm
almost ready to sent this in for the main kernel tree, so I'd recommend
people getting this and testing it out.

Here's a list of things left to do:
	- convert remaining drivers to the proper code (basically
	  /drivers/usb/misc and /drivers/usb/net, and USB drivers living
	  outside of drivers/usb)
	- clean up the "grab an interface" logic that usbfs and the
	  usb-storage code does.

For the curious people, here is what an edited version of driverfs looks
like on my machine with this patch (I've cut out all of the non-USB
portions of the tree).  The USB busses now have a simpler name, along
with the different devices.  I have a UHCI and EHCI card in the machine,
with a few hubs, 2 usb-serial devices, and a usb trackball attached.

Comments appreciated.

thanks,

greg k-h


|-- bus
|   `-- usb
|       |-- devices
|       |   |-- 1-0:0 -> ../../../root/pci0/00:1f.2/usb1/1-0:0
|       |   |-- 1-1 -> ../../../root/pci0/00:1f.2/usb1/1-1
|       |   |-- 1-1.2 -> ../../../root/pci0/00:1f.2/usb1/1-1/1-1.2
|       |   |-- 1-1.2:0 -> ../../../root/pci0/00:1f.2/usb1/1-1/1-1.2/1-1.2:0
|       |   |-- 1-1:0 -> ../../../root/pci0/00:1f.2/usb1/1-1/1-1:0
|       |   |-- 2-0:0 -> ../../../root/pci0/00:1e.0/01:0d.0/usb2/2-0:0
|       |   |-- 3-0:0 -> ../../../root/pci0/00:1e.0/01:0d.1/usb3/3-0:0
|       |   |-- 3-1 -> ../../../root/pci0/00:1e.0/01:0d.1/usb3/3-1
|       |   |-- 3-1.3 -> ../../../root/pci0/00:1e.0/01:0d.1/usb3/3-1/3-1.3
|       |   |-- 3-1.3:0 -> ../../../root/pci0/00:1e.0/01:0d.1/usb3/3-1/3-1.3/3-1.3:0
|       |   |-- 3-1:0 -> ../../../root/pci0/00:1e.0/01:0d.1/usb3/3-1/3-1:0
|       |   |-- 4-0:0 -> ../../../root/pci0/00:1e.0/01:0d.2/usb4/4-0:0
|       |   |-- usb1 -> ../../../root/pci0/00:1f.2/usb1
|       |   |-- usb2 -> ../../../root/pci0/00:1e.0/01:0d.0/usb2
|       |   |-- usb3 -> ../../../root/pci0/00:1e.0/01:0d.1/usb3
|       |   `-- usb4 -> ../../../root/pci0/00:1e.0/01:0d.2/usb4
|       `-- drivers
|           |-- hid
|           |-- hiddev
|           |-- hub
|           |-- pl2303
|           |-- serial
|           `-- usbfs
`-- root
    |-- pci0
    |   |-- 00:1e.0
    |   |   |-- 01:0d.0
    |   |   |   |-- async
    |   |   |   |-- irq
    |   |   |   |-- name
    |   |   |   |-- periodic
    |   |   |   |-- pools
    |   |   |   |-- power
    |   |   |   |-- resource
    |   |   |   `-- usb2
    |   |   |       |-- 2-0:0
    |   |   |       |   |-- altsetting
    |   |   |       |   |-- name
    |   |   |       |   `-- power
    |   |   |       |-- configuration
    |   |   |       |-- manufacturer
    |   |   |       |-- name
    |   |   |       |-- power
    |   |   |       |-- product
    |   |   |       `-- serial
    |   |   |-- 01:0d.1
    |   |   |   |-- async
    |   |   |   |-- irq
    |   |   |   |-- name
    |   |   |   |-- periodic
    |   |   |   |-- pools
    |   |   |   |-- power
    |   |   |   |-- resource
    |   |   |   `-- usb3
    |   |   |       |-- 3-0:0
    |   |   |       |   |-- altsetting
    |   |   |       |   |-- name
    |   |   |       |   `-- power
    |   |   |       |-- 3-1
    |   |   |       |   |-- 3-1.3
    |   |   |       |   |   |-- 3-1.3:0
    |   |   |       |   |   |   |-- altsetting
    |   |   |       |   |   |   |-- name
    |   |   |       |   |   |   `-- power
    |   |   |       |   |   |-- configuration
    |   |   |       |   |   |-- name
    |   |   |       |   |   `-- power
    |   |   |       |   |-- 3-1:0
    |   |   |       |   |   |-- altsetting
    |   |   |       |   |   |-- name
    |   |   |       |   |   `-- power
    |   |   |       |   |-- configuration
    |   |   |       |   |-- name
    |   |   |       |   `-- power
    |   |   |       |-- configuration
    |   |   |       |-- manufacturer
    |   |   |       |-- name
    |   |   |       |-- power
    |   |   |       |-- product
    |   |   |       `-- serial
    |   |   |-- 01:0d.2
    |   |   |   |-- async
    |   |   |   |-- irq
    |   |   |   |-- name
    |   |   |   |-- periodic
    |   |   |   |-- pools
    |   |   |   |-- power
    |   |   |   |-- registers
    |   |   |   |-- resource
    |   |   |   `-- usb4
    |   |   |       |-- 4-0:0
    |   |   |       |   |-- altsetting
    |   |   |       |   |-- name
    |   |   |       |   `-- power
    |   |   |       |-- configuration
    |   |   |       |-- manufacturer
    |   |   |       |-- name
    |   |   |       |-- power
    |   |   |       |-- product
    |   |   |       `-- serial
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- power
    |   |   `-- resource
    |   |-- 00:1f.2
    |   |   |-- irq
    |   |   |-- name
    |   |   |-- pools
    |   |   |-- power
    |   |   |-- resource
    |   |   `-- usb1
    |   |       |-- 1-0:0
    |   |       |   |-- altsetting
    |   |       |   |-- name
    |   |       |   `-- power
    |   |       |-- 1-1
    |   |       |   |-- 1-1.2
    |   |       |   |   |-- 1-1.2:0
    |   |       |   |   |   |-- altsetting
    |   |       |   |   |   |-- name
    |   |       |   |   |   `-- power
    |   |       |   |   |-- configuration
    |   |       |   |   |-- manufacturer
    |   |       |   |   |-- name
    |   |       |   |   |-- power
    |   |       |   |   `-- product
    |   |       |   |-- 1-1:0
    |   |       |   |   |-- altsetting
    |   |       |   |   |-- name
    |   |       |   |   `-- power
    |   |       |   |-- configuration
    |   |       |   |-- name
    |   |       |   `-- power
    |   |       |-- configuration
    |   |       |-- manufacturer
    |   |       |-- name
    |   |       |-- power
    |   |       |-- product
    |   |       `-- serial

