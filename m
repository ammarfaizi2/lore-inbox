Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbTDQFyE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 01:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbTDQFx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 01:53:29 -0400
Received: from granite.he.net ([216.218.226.66]:51728 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S263075AbTDQFuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 01:50:55 -0400
Date: Wed, 16 Apr 2003 23:03:17 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB fixes for 2.5.67
Message-ID: <20030417060317.GI2201@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB bugfixes.  These changesets fix the oft-reported oops
when disconnecting a USB hub.  They also fix a number of bugs found by
the smatch tool.

Due to the reworking of the USB core to disconnect all urbs in flight
when a device is disconnected, if CONFIG_USB_DEBUG is enabled, some
drivers might report a lot of the following type of messages in the
kernel log:
usb 1-1.2: hcd_unlink_urb ed85e2c0 fail -22
usb 1-1.2: hcd_unlink_urb ed85e320 fail -22
usb 1-1.2: hcd_unlink_urb ed85e380 fail -22
usb 1-1.2: hcd_unlink_urb ed85e3e0 fail -22
usb 1-1.2: hcd_unlink_urb ed85e440 fail -22
usb 1-1.2: hcd_unlink_urb ed85e4a0 fail -22
usb 1-1.2: hcd_unlink_urb ed85e500 fail -22

If this happens during normal operation (open, read, write, close type
stuff), please let the people at linux-usb-devel know what device and
driver causes this, those drivers need to be fixed up.

It is normal to see a lot of these messages when a device is
disconnected, and after the drivers have been cleaned up, this message
will be suppressed in a few kernel versions.

Also, I'm seeing a oops when unloading the host controller drivers in
the hotplug call for the root hub device, these patches do not fix that
problem, and I'm actively trying to track that down.  But due to the fact
that it is a fairly rare thing to unload a USB controller driver,
compared to removing a USB hub, I think these patches should be applied
now.


Please pull from:  bk://kernel.bkbits.net/gregkh/linux/linus-2.5


Patches will be posted to linux-usb-devel and lkml as a follow-up thread
for those who want to see them.

thanks,

greg k-h


 Documentation/DocBook/usb.tmpl     |    6 +
 drivers/usb/core/hcd.c             |  130 +++++++++++++++++++++++++++++++++----
 drivers/usb/core/hcd.h             |   11 +--
 drivers/usb/core/urb.c             |   11 ---
 drivers/usb/core/usb.c             |   22 +++++-
 drivers/usb/host/ehci-hcd.c        |  101 ++++++++++------------------
 drivers/usb/host/ohci-hcd.c        |   85 ++++++++++--------------
 drivers/usb/host/ohci-pci.c        |    2 
 drivers/usb/host/ohci-sa1111.c     |    2 
 drivers/usb/host/uhci-hcd.c        |    1 
 drivers/usb/image/scanner.c        |   10 +-
 drivers/usb/misc/speedtch.c        |    9 +-
 drivers/usb/serial/io_edgeport.c   |    5 -
 drivers/usb/serial/keyspan.c       |    6 -
 drivers/usb/serial/kl5kusb105.c    |   10 +-
 drivers/usb/serial/kobil_sct.c     |    8 +-
 drivers/usb/storage/unusual_devs.h |    9 ++
 17 files changed, 265 insertions(+), 163 deletions(-)
-----

<arndt@lin02384n012.mc.schoenewald.de>:
  o USB: Patch against unusual_devs.h to enable Pontis SP600

David Brownell <david-b@pacbell.net>:
  o USB: EHCI disconnect cleanup
  o USB: DocBook/usb.tmpl patch
  o disconnect cleanup, new HCD callback
  o USB: disconnect cleanup, new HCD callback

Duncan Sands <baldrick@wanadoo.fr>:
  o USB speedtouch: discard packets for non-existant vcc's

Greg Kroah-Hartman <greg@kroah.com>:
  o USB: keyspan: fixed up might_sleep() problems on device close
  o USB: io_edgeport: stop unlinking a urb that we don't need to unlink
  o USB: kobil_sct fix up errors found by smatch
  o USB: kl5kusb105 fix up errors found by smatch
  o USB: add better check to prevent oops in hcd_unlink_urb()
  o USB: fix up spin_unlock_irqrestore() issues in previous patch

Henning Meier-Geinitz <henning@meier-geinitz.de>:
  o USB scanner.c endpoint detection fix

