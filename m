Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271654AbTGRABW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271745AbTGRABV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:01:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:21410 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271654AbTGQX6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 19:58:13 -0400
Date: Thu, 17 Jul 2003 17:13:03 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB fixes for 2.6.0-test1
Message-ID: <20030718001303.GA4849@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB fixes for 2.6.0-test1.  There are a lot of good race
condition fixes from Oliver Neukum, and some usb-storage fixes for some
devices.  I've also included the change that flushes all in-flight urbs
_before_ disconnect() is called to fix some problems in the visor and
ftdi_sio drivers.  This also lets drivers become a lot simpler as they
don't have to manage their list of urbs now.  And some usb gadget fixes
are also present.

I've also fixed a nasty bug in the usb-serial core that has been there
for about 4 years now.  Thanks to the good debugging options in the
kernel now, it was pretty easy to find.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/usb/class/bluetty.c        |    3 
 drivers/usb/class/cdc-acm.c        |    3 
 drivers/usb/class/usblp.c          |   35 +-
 drivers/usb/core/hcd-pci.c         |    9 
 drivers/usb/core/hcd.c             |   12 
 drivers/usb/core/usb.c             |   33 +-
 drivers/usb/gadget/ether.c         |  359 ++++++++++++++++++--------
 drivers/usb/gadget/net2280.c       |    6 
 drivers/usb/gadget/net2280.h       |    2 
 drivers/usb/gadget/zero.c          |   80 ++++-
 drivers/usb/host/ohci-hcd.c        |    3 
 drivers/usb/host/ohci-q.c          |   10 
 drivers/usb/host/uhci-hcd.c        |   18 -
 drivers/usb/image/hpusbscsi.c      |   18 +
 drivers/usb/image/scanner.c        |   16 -
 drivers/usb/image/scanner.h        |    8 
 drivers/usb/media/dabusb.c         |   15 -
 drivers/usb/misc/usblcd.c          |   22 -
 drivers/usb/misc/usbtest.c         |  103 ++++++-
 drivers/usb/net/ax8817x.c          |    1 
 drivers/usb/net/catc.c             |    1 
 drivers/usb/net/kaweth.c           |    3 
 drivers/usb/net/pegasus.c          |    3 
 drivers/usb/net/rtl8150.c          |    1 
 drivers/usb/net/usbnet.c           |    2 
 drivers/usb/serial/ftdi_sio.c      |    3 
 drivers/usb/serial/ftdi_sio.h      |    6 
 drivers/usb/serial/ipaq.c          |    3 
 drivers/usb/serial/ipaq.h          |    5 
 drivers/usb/serial/usb-serial.c    |    2 
 drivers/usb/serial/visor.c         |   13 
 drivers/usb/storage/isd200.c       |   37 +-
 drivers/usb/storage/jumpshot.c     |   42 ++-
 drivers/usb/storage/protocol.c     |  189 +-------------
 drivers/usb/storage/scsiglue.c     |  497 -------------------------------------
 drivers/usb/storage/sddr09.c       |  101 ++++---
 drivers/usb/storage/sddr55.c       |   41 +--
 drivers/usb/storage/unusual_devs.h |    6 
 drivers/usb/storage/usb.h          |   10 
 drivers/usb/usb-skeleton.c         |   37 +-
 include/linux/usb.h                |   22 +
 41 files changed, 746 insertions(+), 1034 deletions(-)
-----

<david:csse.uwa.edu.au>:
  o USB: Adding DSS-20 SyncStation to ftdi_sio

Alan Stern:
  o USB: Handle over current inputs on all Intel controllers
  o USB: Make sddr55 use proper I/O buffering
  o USB: I/O buffering for sddr09
  o USB: More unusual_devs.h entry updates

David Brownell:
  o USB: better locking in hcd_endpoint_disable()
  o USB: ethernet gadget, another pxa update
  o USB: gadget zero learns about pxa2xx udc
  o USB: usbtest, autoconfigure from descriptors
  o USB: ethernet gadget learns about pxa2xx udc
  o USB: usb net drivers SET_NETDEV_DEV
  o USB: ohci minor tweaks

Ganesh Varadarajan:
  o USB: more ids for ipaq

Greg Kroah-Hartman:
  o USB: fix memory leak in the visor driver
  o USB: fix a nasty use-after-free bug in the usb-serial core
  o USB: fix up cdc-acm driver's tty and devfs names
  o USB: fix up bluetty driver's tty and devfs names
  o USB: flush all in-flight urbs _before_ disconnect() is called
  o USB: remove some warnings when building the documentation
  o USB: fixed up pci slot_name accesses in usb gadget code
  o USB: fixed up pci slot_name accesses in usb code

Henning Meier-Geinitz:
  o USB: unlink interrupt URBs in scanner driver
  o USB: New vendor/product ids for scanner driver
  o USB: fix open/probe race in scanner driver

Matthew Dharm:
  o USB: remove now-dead mode-translation code
  o USB: convert ISD200 and Jumpshot to DMA-safe buffer

Oliver Neukum:
  o USB: fix race between probe and open in dabusb
  o USB: usblcd: race between open and read/write
  o USB: fix race between probe and open in skeleton
  o USB: fix irq urb in hpusbscsi
  o USB: fix layering violation in usblp
  o USB: fix race between open() and probe()

