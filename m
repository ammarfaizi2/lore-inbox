Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261425AbSIWWcI>; Mon, 23 Sep 2002 18:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261426AbSIWWcI>; Mon, 23 Sep 2002 18:32:08 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:15108 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261425AbSIWWcF>;
	Mon, 23 Sep 2002 18:32:05 -0400
Date: Mon, 23 Sep 2002 15:36:21 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.38
Message-ID: <20020923223621.GD19309@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/usb-serial.txt    |   14 
 MAINTAINERS                         |    8 
 drivers/usb/core/usb.c              |    1 
 drivers/usb/host/ehci-dbg.c         |   14 
 drivers/usb/host/ehci-hcd.c         |   68 -
 drivers/usb/host/ehci-hub.c         |    3 
 drivers/usb/host/ehci-q.c           |   88 +
 drivers/usb/host/ehci-sched.c       |   71 -
 drivers/usb/host/ehci.h             |   36 
 drivers/usb/host/ohci-hcd.c         |   22 
 drivers/usb/host/ohci-q.c           |  255 ++---
 drivers/usb/misc/Config.help        |   10 
 drivers/usb/misc/usblcd.c           |    8 
 drivers/usb/serial/usb-serial.h     |    1 
 drivers/usb/serial/usbserial.c      |   26 
 drivers/usb/serial/whiteheat.c      | 1164 +++++++++++++++++-------
 drivers/usb/serial/whiteheat.h      |  274 ++++-
 drivers/usb/serial/whiteheat_fw.h   | 1685 ++++++++++++++++++------------------
 drivers/usb/storage/datafab.c       |   41 
 drivers/usb/storage/freecom.c       |   16 
 drivers/usb/storage/jumpshot.c      |   16 
 drivers/usb/storage/raw_bulk.c      |   22 
 drivers/usb/storage/sddr09.c        |   42 
 drivers/usb/storage/sddr55.c        |   58 -
 drivers/usb/storage/shuttle_usbat.c |   22 
 drivers/usb/storage/transport.c     |   59 -
 drivers/usb/storage/transport.h     |   11 
 27 files changed, 2409 insertions(+), 1626 deletions(-)
-----

ChangeSet@1.579.9.10, 2002-09-23 14:30:42-07:00, info@usblcd.de
  [PATCH] USBLCD updates
  
  -increased timeout value because some people reported problems
  -(important!) Vender ID has changed from 0x1212 to 0x10D2 , my official
    assigned one.
  -added usblcd driver to configure.help

 drivers/usb/misc/Config.help |   10 ++++++++++
 drivers/usb/misc/usblcd.c    |    8 ++++----
 2 files changed, 14 insertions(+), 4 deletions(-)
------

ChangeSet@1.579.9.9, 2002-09-23 14:17:05-07:00, stuartm@connecttech.com
  [PATCH] usb whiteheat driver update
  
  Update to full working driver status. Latest firmware 4.06 too. Driver
  now officially supported.

 Documentation/usb/usb-serial.txt  |   14 
 MAINTAINERS                       |    8 
 drivers/usb/serial/whiteheat.c    | 1164 ++++++++++++++++++--------
 drivers/usb/serial/whiteheat.h    |  274 ++++--
 drivers/usb/serial/whiteheat_fw.h | 1685 +++++++++++++++++++-------------------
 5 files changed, 1896 insertions(+), 1249 deletions(-)
------

ChangeSet@1.579.9.8, 2002-09-23 14:03:13-07:00, greg@kroah.com
  [PATCH] USB:  made port_softint global for other usb-serial drivers to use.
  
  Based off of a patch from Stuart MacDonald <stuartm@connecttech.com>

 drivers/usb/serial/usb-serial.h |    1 +
 drivers/usb/serial/usbserial.c  |   13 ++++++++++---
 2 files changed, 11 insertions(+), 3 deletions(-)
------

ChangeSet@1.579.9.7, 2002-09-23 13:56:54-07:00, stuartm@connecttech.com
  [PATCH] USB: clean up the error logic for open() in the usb-serial driver
  
  This cleans up the error path in the open() call to make a bit more
  sense.

 drivers/usb/serial/usbserial.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)
------

ChangeSet@1.579.9.6, 2002-09-23 13:54:25-07:00, greg@kroah.com
  [PATCH] USB: fix for ezusb firmware download
  
  This fixes a stupid error in the timeout value when downloading firmware
  to a device.  The WhiteHEAT device now works properly with this patch.

 drivers/usb/serial/usbserial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.579.9.5, 2002-09-23 13:16:44-07:00, stern@rowland.org
  [PATCH] usb-storage: fix return codes...
  
  Like the header says, this patch fixes up the various Transfer- and
  Transport-level return codes.  There were a lot of places in the various
  subdrivers that were not particularly careful about distinguishing the
  two; it would help if the people currently maintaining those drivers could
  take a look at my changes to make sure I haven't screwed anything up.
  
  # Converted US_BULK_TRANSFER_xxx to USB_STOR_XFER_xxx, to make it more
  # easily distinguishable from USB_STOR_TRANSPORT_xxx.  (Also, in the
  # future these codes may apply to control transfers as well as to bulk
  # transfers.)
  #
  # Changed USB_STOR_XFER_FAILED to USB_STOR_XFER_ERROR, since it implies
  # a transport error rather than a transport failure.
  #
  # Added a USB_STOR_XFER_STALLED code, to indicate a transfer that was
  # terminated by an endpoint stall.
  
  This patch is in preparation for one in which usb_stor_transfer_partial()
  and usb_stor_transfer() are replaced by usb_stor_bulk_transfer_buf() and
  usb_stor_bulk_transfer_srb() respectively, with slightly different
  argument lists.  Ultimately the subdrivers will be able to use these
  routines in place of the slightly specialized versions they have now and
  in place of the ones in raw_bulk.c.

 drivers/usb/storage/datafab.c       |   41 ++++++++++++-------------
 drivers/usb/storage/freecom.c       |   16 ++++-----
 drivers/usb/storage/jumpshot.c      |   16 ++++-----
 drivers/usb/storage/raw_bulk.c      |   22 ++++++-------
 drivers/usb/storage/sddr09.c        |   42 +++++++++++++++----------
 drivers/usb/storage/sddr55.c        |   58 +++++++++++++++++++++--------------
 drivers/usb/storage/shuttle_usbat.c |   22 +++++++------
 drivers/usb/storage/transport.c     |   59 ++++++++++++++++++------------------
 drivers/usb/storage/transport.h     |   11 +++---
 9 files changed, 156 insertions(+), 131 deletions(-)
------

ChangeSet@1.579.9.4, 2002-09-23 13:16:05-07:00, luc.vanoostenryck@easynet.be
  [PATCH] #include <linux/version.h> missing in drivers/usb/host/ohci-hcd.c
  
  compile fails with the following message:
  
  	> In file included from ohci-hcd.c:136:
  	> ohci-dbg.c:318: parse error
  	> make[3]: *** [ohci-hcd.o] Error 1
  
  due to a missing #include <linux/version.h>
  
  Here is a trivial patch for this.

 drivers/usb/host/ohci-hcd.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.579.9.3, 2002-09-23 13:15:28-07:00, david-b@pacbell.net
  [PATCH] USB shutdown oopser
  
  is it guarenteed that callers have zero'd out the device
  before this is invoked?  Else the following is necessary to
  prevent potential OOPS's derefencing interface->dev.driver in
  the generic device layer.

 drivers/usb/core/usb.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.579.9.2, 2002-09-23 13:14:52-07:00, david-b@pacbell.net
  [PATCH] ehci-hcd: update
  
  Here's an EHCI update, I'll send separate patches to sync 2.4 with
  this version.  Changes in this version include:
  
    - An earlier locking update would give trouble on SPARC, where
      irqsave "flags" aren't flags.  This resolves that issue by
      adding a module parameter to limit work done with irqs off.
      (Some net drivers do the same thing.)
  
    - Optionally (now #ifdef DEBUG) collects some statistics on IRQs
      and URBs.  There are more IAA interrupts than I want to see,
      during extended usb-storage loading.
  
    - Adds a commented-out workaround for a problem I've seen on one
      VT8235.  Seems likely an issue with this specific motherboard;
      another tester hasn't reported such issues.
  
    - Includes the jiffies time_after() patch from Tim Schmielau.
  
    - Minor tweaks to the hcd portability (get rid of another #if).
  
    - Minor doc/diagnostic/... updates

 drivers/usb/host/ehci-dbg.c   |   14 ++++++
 drivers/usb/host/ehci-hcd.c   |   68 +++++++++++++++++++-------------
 drivers/usb/host/ehci-hub.c   |    3 -
 drivers/usb/host/ehci-q.c     |   88 +++++++++++++++++++++++++-----------------
 drivers/usb/host/ehci-sched.c |   71 +++++++++++++++++----------------
 drivers/usb/host/ehci.h       |   36 +++++++++++++++++
 6 files changed, 181 insertions(+), 99 deletions(-)
------

ChangeSet@1.579.9.1, 2002-09-23 13:14:20-07:00, david-b@pacbell.net
  [PATCH] ohci-hcd, queue fault recovery + rm DEBUG
  
  This USB patch updates the OHCI driver:
  
    - converts to relying on td_list shadowing the hardware's
      schedule; only collecting the donelist needs dma_to_td(),
      and td list handling works much like EHCI or UHCI.
  
    - leaves faulted endpoint queues (bulk/intr) disabled until
      the relevant drivers had a chance to clean up.
  
    - fixes minor bugs (unreported) in the affected code:
        * byteswap problem when unlinking urbs ... symptom would
          be data toggle confusion (since 2.4.2x) on big-endian cpus
        * latent bug if folk unlinked queue in LIFO order, not FIFO
  
    - removes unnecessary debug code; mostly de-BUG()ged
  
  The interesting fix is the "leave queues halted" one.  As
  discussed on email a while back, this HCD fault handling
  policy (also followed by EHCI) is sufficient to let device
  drivers implement the two key fault handling policies that
  seem to be necessary:
  
      (a) Datagram style, where issues on one I/O won't affect
          the next unless the device halted the endpoint.  The
          device driver can ignore most errors other than -EPIPE.
  
      (b) Stream style, where for example it'd be wrong to ever
          let block N+1 overwrite block N on the disk.  Once
          the first URB fails, the rest would just be unlinked
          in the completion handler.
  
  As a consequence of using the td_list, you can now see urb
  queuing in action in the driverfs 'async' file.  At least, if
  you look at the right time, or use drivers (networking, etc)
  that queue (bulk) reads for a long time.

 drivers/usb/host/ohci-hcd.c |   21 +--
 drivers/usb/host/ohci-q.c   |  255 +++++++++++++++++++++++---------------------
 2 files changed, 143 insertions(+), 133 deletions(-)
------

