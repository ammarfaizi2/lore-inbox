Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264283AbTL3EBx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 23:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264367AbTL3EBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 23:01:53 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:65432 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S264283AbTL3EBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 23:01:44 -0500
Message-ID: <3FF0F6F5.10409@pacbell.net>
Date: Mon, 29 Dec 2003 19:54:29 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net,
       Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] improce USB Gadget Kconfig
References: <20031123172356.GB16828@fs.tum.de>
In-Reply-To: <20031123172356.GB16828@fs.tum.de>
Content-Type: multipart/mixed;
 boundary="------------010606020103010803020709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010606020103010803020709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Adrian Bunk wrote:
> The patch below contains small changes to the USB Gadget Kconfig.
> 
> The main change is that multiple modular peripheral controllers are no 
> longer allowed (currently only one is there, but this may change).

How about using this approach instead?   It simplifies the kconfig
for the gadget drivers by providing a boolean "which hardware"
symbol, so gadget drivers don't need to make their own.  The symbol
that's synthetic is the one needed only by the Makefile.

It's a larger change, but likely a better one.  Greg, does it
behave for you?

Roman, this seems to trigger some kind of xconfig/menuconfig bug,
since I can go down the list of hardware options (net2280, goku,
dummy -- three, not the single one Adrian was working with) and
each deselects the previous selection ... but then it's impossible
to turn off the dummy, and select real hardware.

- Dave


--------------010606020103010803020709
Content-Type: text/plain;
 name="Kconfig"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Kconfig"

#
# USB Gadget support on a system involves
#    (a) a peripheral controller, and
#    (b) the gadget driver using it.
#
menu "USB Gadget Support"

config USB_GADGET
	tristate "Support for USB Gadgets"
	depends on EXPERIMENTAL
	help
	   USB is a master/slave protocol, organized with one master
	   host (such as a PC) controlling up to 127 peripheral devices.
	   The USB hardware is asymmetric, which makes it easier to set up:
	   you can't connect two "to-the-host" connectors to each other.

	   Linux can run in the host, or in the peripheral.  In both cases
	   you need a low level bus controller driver, and some software
	   talking to it.  Peripheral controllers are often discrete silicon,
	   or are integrated with the CPU in a microcontroller.  The more
	   familiar host side controllers have names like like "EHCI", "OHCI",
	   or "UHCI", and are usually integrated into southbridges on PC
	   motherboards.

	   Enable this configuration option if you want to run Linux inside
	   a USB peripheral device.  Configure one hardware driver for your
	   peripheral/device side bus controller, and a "gadget driver" for
	   your peripheral protocol.  (If you use modular gadget drivers,
	   you may configure more than one.)

	   If in doubt, say "N" and don't enable these drivers; most people
	   don't have this kind of hardware (except maybe inside Linux PDAs).

#
# USB Peripheral Controller Support
#
choice
	prompt "USB Peripheral Controller Support"
	depends on USB_GADGET != n
	optional
	help
	   A USB device uses a controller to talk to its host.
	   Systems should have only one such upstream link.

config USB_GADGET_NET2280
	boolean "NetChip 2280 USB Peripheral Controller"
	depends on PCI
	help
	   NetChip 2280 is a PCI based USB peripheral controller which
	   supports both full and high speed USB 2.0 data transfers.  
	   
	   It has six configurable endpoints, as well as endpoint zero
	   (for control transfers) and several endpoints with dedicated
	   functions.

	   Say "y" to link the driver statically, or "m" to build a
	   dynamically linked module called "net2280" and force all
	   gadget drivers to also be dynamically linked.

config USB_GADGET_PXA2XX
	boolean "PXA 2xx USB Device Controller"
	depends on ARCH_PXA
	help
	   Intel's PXA 2xx series XScale ARM-5TE processors include
	   an integrated full speed USB 1.1 device controller.

	   It has fifteen fixed-function endpoints, as well as endpoint
	   zero (for control transfers).

	   Say "y" to link the driver statically, or "m" to build a
	   dynamically linked module called "pxa2xx_udc" and force all
	   gadget drivers to also be dynamically linked.

config USB_GADGET_GOKU
	boolean "Toshiba TC86C001 (Goku-S) USB Device Controller"
	depends on PCI
	help
	   The Toshiba TC86C001 is a PCI device which includes controllers
	   for full speed USB devices, IDE, I2C, SIO, plus a USB host (OHCI).
	   
	   The device controller has three configurable (bulk or interrupt)
	   endpoints, plus endpoint zero (for control transfers).

	   Say "y" to link the driver statically, or "m" to build a
	   dynamically linked module called "goku_udc" and to force all
	   gadget drivers to also be dynamically linked.

# this could be built elsewhere (doesn't yet exist)
config USB_GADGET_SA1100
	boolean "SA 1100 USB Device Controller"
	depends on ARCH_SA1100
	help
	   Intel's SA-1100 is an ARM-4 processor with an integrated
	   full speed USB 1.1 device controller.

	   It has two fixed-function endpoints, as well as endpoint
	   zero (for control transfers).

config USB_GADGET_DUMMY_HCD
	boolean "Dummy HCD support (DEVELOPMENT)"
	depends on USB
	help
	  This host controller driver emulates USB, looping all data transfer
	  requests back to a USB "gadget driver" in the same host.  The host
	  side is the master; the gadget side is the slave.  Gadget drivers
	  can be high, full, or low speed; and they have access to endpoints
	  like those from NET2280, PXA2xx, or SA1100 hardware.
	  
	  This may help in some stages of creating a driver to embed in a
	  Linux device, since it lets you debug several parts of the gadget
	  driver without its hardware or drivers being involved.
	  
	  Since such a gadget side driver needs to interoperate with a host
	  side Linux-USB device driver, this may help to debug both sides
	  of a USB protocol stack.

	  Say "y" to link the driver statically, or "m" to build a
	  dynamically linked module called "dummy_hcd" and force all
	  gadget drivers to also be dynamically linked.

endchoice

# Gadget drivers should use the CONFIG_USB_GADGET_XXX symbol
# for hardware-specific logic (like driver configuration).

# These sibling CONFIG_USB_XXX symbols are for the Makefile.

config USB_NET2280
	tristate
	default n if USB_GADGET_NET2280 = n
	default m if USB_GADGET = m
	default y

config USB_PXA2XX
	tristate
	default n if USB_GADGET_PXA2XX = n
	default m if USB_GADGET = m
	default y

# if there's only one gadget driver, using only two bulk endpoints,
# the other endpoints don't need to waste that extra memory
config USB_PXA2XX_SMALL
	depends on USB_PXA2XX
	bool
	default y if (USB_ZERO = y) && (USB_PXA2XX = y)
	default y if (USB_ETH = y) && (USB_PXA2XX = y)
	default y if (USB_G_SERIAL = y) && (USB_PXA2XX = y)
	default n

config USB_GOKU
	tristate
	default n if USB_GADGET_GOKU = n
	default m if USB_GADGET = m
	default y

config USB_SA1100
	tristate
	default n if USB_GADGET_SA1100 = n
	default m if USB_GADGET = m
	default y

config USB_DUMMY_HCD
	tristate
	default n if USB_GADGET_DUMMY_HCD = n
	default m if USB_GADGET = m
	default y


#
# USB Gadget Drivers
#
choice
	tristate "USB Gadget Drivers"
	depends on USB_GADGET
	default USB_ETH

config USB_ZERO
	tristate "Gadget Zero (DEVELOPMENT)"
	depends USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_GOKU || USB_SA1100
	help
	  Gadget Zero is a two-configuration device.  It either sinks and
	  sources bulk data; or it loops back a configurable number of
	  transfers.  It also implements control requests, for "chapter 9"
	  conformance.  The driver needs only two bulk-capable endpoints, so
	  it can work on top of most device-side usb controllers.  It's
	  useful for testing, and is also a working example showing how
	  USB "gadget drivers" can be written.

	  Make this be the first driver you try using on top of any new
	  USB peripheral controller driver.  Then you can use host-side
	  test software, like the "usbtest" driver, to put your hardware
	  and its driver through a basic set of functional tests.

	  Gadget Zero also works with the host-side "usb-skeleton" driver,
	  and with many kinds of host-side test software.  You may need
	  to tweak product and vendor IDs before host software knows about
	  this device, and arrange to select an appropriate configuration.

	  Say "y" to link the driver statically, or "m" to build a
	  dynamically linked module called "g_zero".

config USB_ETH
	tristate "Ethernet Gadget"
	depends on NET && (USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_GOKU || USB_SA1100)
	help
	  This driver implements Ethernet style communication, in either
	  of two ways:
	  
	   - The "Communication Device Class" (CDC) Ethernet Control Model.
	     That protocol is often avoided with pure Ethernet adapters, in
	     favor of simpler vendor-specific hardware, but is widely
	     supported by firmware for smart network devices.

	   - On hardware can't implement that protocol, a simpler approach
	     is used, placing fewer demands on USB.

	  Within the USB device, this gadget driver exposes a network device
	  "usbX", where X depends on what other networking devices you have.
	  Treat it like a two-node Ethernet link:  host, and gadget.

	  The Linux-USB host-side "usbnet" driver interoperates with this
	  driver, so that deep I/O queues can be supported.  On 2.4 kernels,
	  use "CDCEther" instead, if you're using the CDC option. That CDC
	  mode should also interoperate with standard CDC Ethernet class
	  drivers on other host operating systems.

	  Say "y" to link the driver statically, or "m" to build a
	  dynamically linked module called "g_ether".


config USB_GADGETFS
	tristate "Gadget Filesystem (EXPERIMENTAL)"
	depends on (USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_SA1100 || USB_GOKU) && EXPERIMENTAL
	help
	  This driver provides a filesystem based API that lets user mode
	  programs implement a single-configuration USB device, including
	  endpoint I/O and control requests that don't relate to enumeration.
	  All endpoints, transfer speeds, and transfer types supported by
	  the hardware are available, through read() and write() calls.

	  Say "y" to link the driver statically, or "m" to build a
	  dynamically linked module called "gadgetfs".

config USB_FILE_STORAGE
	tristate "File-backed Storage Gadget (DEVELOPMENT)"
	depends on USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_GOKU
	# we don't support the SA1100 because of its limitations
	help
	  The File-backed Storage Gadget acts as a USB Mass Storage
	  disk drive.  As its storage repository it can use a regular
	  file or a block device (in much the same way as the "loop"
	  device driver), specified as a module parameter.

	  Say "y" to link the driver statically, or "m" to build a
	  dynamically linked module called "g_file_storage".

config USB_G_SERIAL
	tristate "Serial Gadget"
	depends on USB_DUMMY_HCD || USB_NET2280 || USB_PXA2XX || USB_GOKU || USB_SA1100
	help
	  The Serial Gadget talks to the Linux-USB generic serial driver.

	  Say "y" to link the driver statically, or "m" to build a
	  dynamically linked module called "g_serial".

endchoice

endmenu

--------------010606020103010803020709--


