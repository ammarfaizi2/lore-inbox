Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSJAA2E>; Mon, 30 Sep 2002 20:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbSJAA2E>; Mon, 30 Sep 2002 20:28:04 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:518 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261402AbSJAA2A>;
	Mon, 30 Sep 2002 20:28:00 -0400
Date: Mon, 30 Sep 2002 17:31:05 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.39
Message-ID: <20021001003104.GA3994@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series also includes a patch to the driver core that enables
/sbin/hotplug events for all devices in the system (add and remove).

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/base/hotplug.c          |   40 +++-
 drivers/usb/class/bluetty.c     |    4 
 drivers/usb/class/cdc-acm.c     |    3 
 drivers/usb/core/Makefile       |    2 
 drivers/usb/core/devio.c        |   36 ++--
 drivers/usb/core/driverfs.c     |  177 +++++++++++++++++++++
 drivers/usb/core/hcd.c          |   24 +-
 drivers/usb/core/hub.c          |    7 
 drivers/usb/core/message.c      |  327 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/urb.c          |   31 +--
 drivers/usb/core/usb.c          |  110 -------------
 drivers/usb/core/usb.h          |    5 
 drivers/usb/host/ehci-hcd.c     |    2 
 drivers/usb/host/ehci-q.c       |   47 ++---
 drivers/usb/host/hc_sl811.c     |    3 
 drivers/usb/host/ohci-hcd.c     |    6 
 drivers/usb/host/ohci-mem.c     |    8 
 drivers/usb/host/ohci-q.c       |    5 
 drivers/usb/serial/cyberjack.c  |   14 -
 drivers/usb/serial/empeg.c      |    6 
 drivers/usb/serial/ftdi_sio.c   |    4 
 drivers/usb/serial/ipaq.c       |    6 
 drivers/usb/serial/ir-usb.c     |    5 
 drivers/usb/serial/keyspan.c    |    6 
 drivers/usb/serial/kl5kusb105.c |    5 
 drivers/usb/serial/mct_u232.c   |    3 
 drivers/usb/serial/omninet.c    |    5 
 drivers/usb/serial/pl2303.c     |    5 
 drivers/usb/serial/usbserial.c  |    7 
 drivers/usb/serial/visor.c      |   11 -
 drivers/usb/serial/visor.h      |    1 
 drivers/usb/serial/whiteheat.c  |    5 
 drivers/usb/storage/transport.c |    2 
 include/linux/usb.h             |   77 +++++++--
 include/linux/usbdevice_fs.h    |    2 
 35 files changed, 723 insertions(+), 278 deletions(-)
-----

ChangeSet@1.660.1.13, 2002-09-30 16:50:31-07:00, randy.dunlap@verizon.net
  [PATCH] hc_sl811 build and memory leak
  
  It needs s/malloc.h/slab.h/ .
  It also forgets to free some memory on an error exit patch.
  Patch for 2.5.39 follows.

 drivers/usb/host/hc_sl811.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.660.1.12, 2002-09-30 16:45:33-07:00, david-b@pacbell.net
  [PATCH] usb_sg_{init,wait,cancel}()
  
  Here are the scatterlist primitives there's been mail about before.
  Now the code has passed basic sanity testing, and is ready to merge
  into Linus' tree to start getting wider use.  Greg, please merge!
  
  To recap, the routines are a utility layer packaging several usb
  core facilities to improve system performance.  It's synchronous.
  The code uses functionality that drivers could use already, but
  generally haven't:
  
      - Request queueing.  This is a big performance win.  It lets
        device drivers help the hcds avoid wasted i/o bandwidth, by
        eliminating irq and scheduling latencies between requests.  It
        can make a huge difference at high speed, when the latencies
        often exceed the time to handle each i/o request!
  
      - The new usb_map_sg() primitives, leveraging IOMMU hardware
        if it's there (better than entry-at-a-time mapping).
  
      - URB_NO_INTERRUPT transfer flag, a hint to hcds that they
        can avoid a 'success irq' for this urb.  Only the urb for
        the last scatterlist entry really needs an IRQ, the others
        can be eliminated or delayed.  (OHCI uses this today, and
        any HCD can safely ignore it.)
  
  The particular functionality in these APIs seemed to meet Matt's
  requirements for usb-storage, so I'd hope the 2.5 usb-storage
  code will start to use these routines in a while.  (And maybe
  those two scanner drivers: hpusbscsi, microtek.)
  
  Brief summary of testing:  this code seems correct for normal
  reads and writes, but the fault paths (including cancelation)
  haven't been tested yet.  Both EHCI and OHCI seem to be mostly
  OK with these more aggressive queued loads, but may need small
  updates (like the two I sent yesterday).  Unfortunately I have
  to report that UHCI and urb queueing will sometimes lock up my
  hardware (PIIX4), so while we're lots better than 2.4 this is
  still a bit of a trouble spot for now.
  
  I'll be making some testing software available shortly, which
  will help track down remaining HCD level problems by giving the
  queuing APIs (and some others!) a more strenuous workout than
  most drivers will, in their day-to-day usage.
  
  - Dave

 drivers/usb/core/message.c |  321 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h        |   52 +++++++
 2 files changed, 373 insertions(+)
------

ChangeSet@1.660.1.11, 2002-09-30 16:43:41-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB-storage: problem clearing halts
  
  Greg, attached is a patch designed for diagnostic purposes.  Please apply
  to the 2.5 tree -- yes, we'll be removing this at some point in the future.
  
  It appears that we have a problem clearing halts.  This patch causes a very
  clear message to be printed whenever a usb_stor_clear_halt() manages to
  work.  So far, I haven't seen such a thing happen.  And I've seen _lots_ of
  STALL conditions.
  
  This problem has likely been around for a while... however, it hasn't been
  noticed before because usb-storage was difficult to use because of other
  bugs.  Heck, the most recent 'bk pull' is the first one for me in _months_
  which let me boot all the way into X11.
  
  I'm going to hold my patch queue until this is resolved.  On my test setup,
  it's easy to see this failing.  I've tried with 4 different devices, with
  both UHCI and EHCI drivers.  I don't want to confuse this problem with
  other patches...
  
  'result' in this function always seems to be -32.  Which is odd, because
  control endpoints shouldn't do that.
  
  I'm open to suggestions as to where to look for this bug, but my instincts
  are telling me that this is a core or HCD issue, not a usb-storage issue.
  
  On a positive note, this means that the error-recovery system gets a good
  workout.

 drivers/usb/storage/transport.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.660.1.10, 2002-09-30 16:41:46-07:00, david-b@pacbell.net
  [PATCH] ohci-hcd, paranoia
  
  In a test where some memory corruption happened, I noticed an
  oops (null pointer exception in_irq) that's avoidable.  Here's
  a patch that avoids it ... anyone seeing the err() is likely
  to hang some process, but that's better than the alternative.
  (Also inlines some used-once routines, saving a bit of space
  to make up for the new diagnostic.)

 drivers/usb/host/ohci-mem.c |    8 ++++----
 drivers/usb/host/ohci-q.c   |    5 +++++
 2 files changed, 9 insertions(+), 4 deletions(-)
------

ChangeSet@1.660.1.9, 2002-09-30 16:41:16-07:00, david-b@pacbell.net
  [PATCH] ehci-hcd, urb queuing
  
  In doing some more extensive testing of the urb queueing behavior,
  I noticed that (a) IOC wasn't always being set for each urb, while
  for now it needs to be set; (b) a qh patchup wasn't done quite
  where it should be.  This resolves those two issues, as well
  as making it a bit less noisy to unlink lots of urbs at the once.

 drivers/usb/host/ehci-hcd.c |    2 -
 drivers/usb/host/ehci-q.c   |   47 ++++++++++++++++++--------------------------
 2 files changed, 21 insertions(+), 28 deletions(-)
------

ChangeSet@1.660.1.8, 2002-09-30 16:40:06-07:00, greg@kroah.com
  USB: fix typo from previous schedule_task() patch.

 drivers/usb/serial/usbserial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.660.1.7, 2002-09-30 16:28:15-07:00, david-b@pacbell.net
  [PATCH] usbcore misc cleanup
  
  This has minor usbcore cleanups:
  
  DOC:
      - the changes passing a usb_interface to driver probe() and disconnect()
        weren't reflected in their adjacent docs.  likewise they still said
        it was possible to get a null usb_device_id (no more).
  
      - the (root) hub API restrictions from rmk's ARM patch weren't
        flagged
  
      - mention the non-dma-coherent cache issue for usb_buffer_alloc()
  
      - mention disconnect() cleanup issue with usb_{control,bulk}_msg()
        [ you can't cancel those urbs from disconnect() ]
  
  CODE
      - make driver ioctl() use 'usb_interface' too ... this update
        also resolves an old 'one instance per device' bad assumption
  
      - module locking on driver->ioctl() was goofy, kept BKL way too
        long and didn't try_inc_mod_count() like the rest of usbcore
  
      - hcd unlink code treated iso inappropriately like interrupt;
        only interrupt still wants that automagic mode
  
      - move iso init out of ohci into shared submit_urb logic
  
      - remove interrupt transfer length restriction; hcds that don't
        handle packetization (just like bulk :) should be updated,
        but device drivers won't care for now.

 drivers/usb/core/devio.c     |   36 +++++++++++++++++++++---------------
 drivers/usb/core/hcd.c       |   24 +++++++++++++-----------
 drivers/usb/core/hub.c       |    5 ++++-
 drivers/usb/core/message.c   |    6 ++++++
 drivers/usb/core/urb.c       |   31 ++++++++++++-------------------
 drivers/usb/core/usb.c       |    4 ++++
 drivers/usb/host/ohci-hcd.c  |    6 ------
 include/linux/usb.h          |   25 +++++++++++--------------
 include/linux/usbdevice_fs.h |    2 +-
 9 files changed, 72 insertions(+), 67 deletions(-)
------

ChangeSet@1.660.1.6, 2002-09-30 16:11:26-07:00, greg@kroah.com
  USB: allow /sbin/hotplug to be called for the main USB device.

 drivers/usb/core/usb.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)
------

ChangeSet@1.660.1.5, 2002-09-30 16:09:50-07:00, greg@kroah.com
  USB: Fix the name of usb hubs in driverfs.

 drivers/usb/core/hub.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.660.1.4, 2002-09-30 16:09:11-07:00, greg@kroah.com
  USB: add a lot more driverfs files for all usb devices.

 drivers/usb/core/Makefile   |    2 
 drivers/usb/core/driverfs.c |  177 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c      |  103 -------------------------
 drivers/usb/core/usb.h      |    5 +
 4 files changed, 186 insertions(+), 101 deletions(-)
------

ChangeSet@1.660.1.3, 2002-09-30 16:07:29-07:00, greg@kroah.com
  driver core: added location of device in driverfs tree to /sbin/hotplug call.
  
  /sbin/hotplug is now called when any device is added or removed from the
  system.

 drivers/base/hotplug.c |   40 +++++++++++++++++++++++++++++++---------
 1 files changed, 31 insertions(+), 9 deletions(-)
------

ChangeSet@1.660.1.2, 2002-09-30 16:05:03-07:00, greg@kroah.com
  USB: added Palm Zire id to the visor driver, thanks to Martin Brachtl

 drivers/usb/serial/visor.c |    6 ++++--
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 5 insertions(+), 2 deletions(-)
------

ChangeSet@1.660.1.1, 2002-09-30 15:54:02-07:00, greg@kroah.com
  USB: queue_task() fixups

 drivers/usb/class/bluetty.c     |    4 +---
 drivers/usb/class/cdc-acm.c     |    3 +--
 drivers/usb/serial/cyberjack.c  |   14 +++-----------
 drivers/usb/serial/empeg.c      |    6 +-----
 drivers/usb/serial/ftdi_sio.c   |    4 +---
 drivers/usb/serial/ipaq.c       |    6 ++----
 drivers/usb/serial/ir-usb.c     |    5 +----
 drivers/usb/serial/keyspan.c    |    6 ++----
 drivers/usb/serial/kl5kusb105.c |    5 +----
 drivers/usb/serial/mct_u232.c   |    3 +--
 drivers/usb/serial/omninet.c    |    5 +----
 drivers/usb/serial/pl2303.c     |    5 +----
 drivers/usb/serial/usbserial.c  |    5 +----
 drivers/usb/serial/visor.c      |    5 +----
 drivers/usb/serial/whiteheat.c  |    5 +----
 15 files changed, 19 insertions(+), 62 deletions(-)
------

