Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262140AbTEHVkT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 17:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTEHVkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 17:40:19 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:49882 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262140AbTEHVj6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 17:39:58 -0400
Date: Thu, 8 May 2003 14:51:02 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       david-b@pacbell.net
Subject: [BK PATCH] USB Gadget core and driver for 2.5.69
Message-ID: <20030508215102.GA3538@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some changesets that add USB gadget support to the kernel.
This is completely new code from the last time I submitted something like
this (that was based on the old Lineo code, this is a new rewrite from
David Brownell.)  It's much cleaner, smaller, and saner.  There is only
support for one hardware platform in here, but others are being worked
on by a number of people (which validates that this design is relatively
sane.)

USB gadget code (for those who don't remember the long discussion a
while ago) enables Linux to look like a USB device.  An example of this
is a Zarus that plugs into a desktop using a USB cable.  The Zarus is a
USB gadget, and the desktop is the USB host.  These patches include
support for ethernet support within a USB gadget.  More gadget drivers
(like serial, keyboard, etc) will be forthcoming in the future.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/gadget-2.5


Patches for these changesets are available at kernel.org at:
	kernel.org/pub/linux/kernel/people/gregkh/usb/2.5/usb-gadget-?-2.5.69.patch
I'm not going to post them to lkml or linux-usb-devel, as they have all
been posted to linux-usb-devel within the past few days.

thanks,

greg k-h

 drivers/usb/Kconfig            |    2 
 drivers/usb/Makefile           |    4 
 drivers/usb/gadget/Kconfig     |  155 ++
 drivers/usb/gadget/Makefile    |   14 
 drivers/usb/gadget/ether.c     | 1686 ++++++++++++++++++++++++-
 drivers/usb/gadget/net2280.c   | 2736 ++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/gadget/net2280.h   |  709 ++++++++++
 drivers/usb/gadget/usbstring.c |   73 +
 drivers/usb/gadget/zero.c      | 1287 ++++++++++++++++++-
 include/linux/usb_gadget.h     |  776 +++++++++++
 10 files changed, 7307 insertions(+), 135 deletions(-)
-----

ChangeSet@1.1078.2.9, 2003-05-08 11:36:11-07:00, david-b@pacbell.net
  [PATCH] USB gadget: net2280: dmachain off, zlp pio ok
  
  This patch has two small fixes for issues that people
  reported to me yesterday:
  
    - One of the out-of-tree drivers sees odd things
      happening when dma chaining is enabled.  (The
      in-tree drivers seem fine with it.)  So disable
      for now; it's easily enabled if needed.
  
    - Zero Length Packets (ZLPs):
  
       * Should now read/write ok with PIO.
  
       * On DMA endpoints, explicit ZLPs need PIO.
         Until they do, don't allow queuing zero length
         buffers onto DMA endpoints.

 drivers/usb/gadget/net2280.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)
------

ChangeSet@1.1078.2.8, 2003-05-08 11:35:48-07:00, david-b@pacbell.net
  [PATCH] USB: gadget zero, loopback config fix
  
  If the host writes OUT packets using URB_ZERO_PACKET
  (or its analogue on other USB host systems), then the
  loopback configuration should set req->zero, to use that
  same transfer termination policy when it writes the
  response back IN to the host.

 drivers/usb/gadget/zero.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.1078.2.7, 2003-05-08 11:35:20-07:00, david-b@pacbell.net
  [PATCH] USB: gadget cleanup of #ifdefs
  
  > can you get rid of all of the #ifdef HAVE_DRIVER_MODEL stuff?
  
  Done.  Now this code "knows" it's running in a 2.5
  environment, and needs modifications to run on 2.4.
  
  I also changed the file modes in the module_parm()
  calls so the parameters will be writable when they
  eventually show up in sysfs; and fixed a typo.
  
  Compile-tested with and without DEBUG enabled.

 drivers/usb/gadget/Kconfig     |    2 -
 drivers/usb/gadget/ether.c     |   31 +++++++----------------------
 drivers/usb/gadget/net2280.c   |   43 ++++++++++++-----------------------------
 drivers/usb/gadget/usbstring.c |    2 -
 drivers/usb/gadget/zero.c      |   43 ++++++++++-------------------------------
 include/linux/usb_gadget.h     |   42 +---------------------------------------
 6 files changed, 36 insertions(+), 127 deletions(-)
------

ChangeSet@1.1078.2.6, 2003-05-08 11:34:56-07:00, david-b@pacbell.net
  [PATCH] kbuild/kbuild for USB Gadgets (6/6)
  
  This patch adds kconfig/kbuild support for the preceding
  code, so that an EXPERIMENTAL option appears in the
  USB part of the config menus.
  
  Once a USB device controller driver is configured (which
  just now means net2280, but sa11x0 and pxa25x options
  are just waiting for updates!), gadget driver options
  are also available.

 drivers/usb/Kconfig         |    2 
 drivers/usb/Makefile        |    4 +
 drivers/usb/gadget/Kconfig  |  153 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/Makefile |   14 ++++
 4 files changed, 173 insertions(+)
------

ChangeSet@1.1078.2.5, 2003-05-08 11:34:30-07:00, david-b@pacbell.net
  [PATCH] USB Gadget string utility (5/6)
  
  This adds utility code that gadget drivers can use to manage
  string descriptors (drivers/usb/gadget/usbstring.c) in the
  common case that the ISO-8859/1 character set is in use.
  
  Both "Gadget Zero" and the Ethernet gadget code use this.

 drivers/usb/gadget/usbstring.c |   71 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+)
------

ChangeSet@1.1078.2.4, 2003-05-08 11:34:06-07:00, david-b@pacbell.net
  [PATCH] USB Ethernet Gadget (4/6)
  
  This patch adds an "Ethernet Gadget" driver, implementing
  the CDC Ethernet model (drivers/usb/gadget/ether.c).
  
  It interops with the current CDC Ether drivers on Linux,
  both 2.4 (CDCEther, using Marcelo's latest) and 2.5
  (cdc-ether with recent patches, or on 2.5.68 "usbnet")
  
  On a net2280, this has successfully streamed dozens of
  megabytes per second using "ttcp" (high speed, and using
  "usbnet" on the host side), for days at a time.  And no
  problems using SSH/NFS/etc in lighter duty testing.
  
  It's possible this will need tweaking to cope with UDC
  bugs on Intel's pxa25x controllers, presenting itself
  as a non-CDC device. (I'm told altsettings are even
  more broken than originally specified to be.)

 drivers/usb/gadget/ether.c | 1655 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1655 insertions(+)
------

ChangeSet@1.1078.2.3, 2003-05-08 11:33:41-07:00, david-b@pacbell.net
  [PATCH] USB "Gadget Zero" driver (3/6)
  
  This patch adds "Gadget Zero" (drivers/usb/gadget/zero.c).
  
  Gadget Zero is a simple gadget driver that's useful for
  testing controller drivers, and as an example to be used
  for clone/modify style development.
  
  This driver implements two configurations, and needs only
  two bulk endpoints (in addition to ep0) ... so pretty much
  any USB device controller should be usable with it in
  one configuration or another.  It (optionally) supports
  high speed devices, and has passed the USB-IF "chapter 9"
  device model conformance tests.
  
  It's worth noticing the kinds of hardware differences that
  gadget drivers need to cope with.  Endpoints differ, in
  ways that must be reflected various ways in descriptors.
  And sometimes chip errata cause interoperability problems;
  for example, an sa1100 can't change configurations after
  enumerating.

 drivers/usb/gadget/zero.c | 1243 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 1243 insertions(+)
------

ChangeSet@1.1078.2.2, 2003-05-08 11:33:15-07:00, david-b@pacbell.net
  [PATCH] Net2280 driver (2/6)
  
  This patch creates drivers/usb/gadget/net2280.[hc],
  providing a driver for NetChip's "Net2280 PCI USB 2.0
  High Speed Peripheral Controller".
  
  It implements the API included in the first patch.
  
  The driver has behaved well with chiprev 0100 under
  stress tests with Gadget Zero and the ethernet model
  driver, and has passed sanity tests for chiprev 0110.

 drivers/usb/gadget/net2280.c | 2677 +++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/gadget/net2280.h |  709 +++++++++++
 2 files changed, 3386 insertions(+)
------

ChangeSet@1.1078.2.1, 2003-05-08 11:32:50-07:00, david-b@pacbell.net
  [PATCH] USB Gadget API (1/6)
  
  This patch createss <linux/usb_gadget.h>, the gadget API
  and inlined implementation.
  
  There's additional kerneldoc, which I won't submit at
  this time, available.

 include/linux/usb_gadget.h |  734 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 734 insertions(+)
------

