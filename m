Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbSKNWVs>; Thu, 14 Nov 2002 17:21:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265368AbSKNWVs>; Thu, 14 Nov 2002 17:21:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:63749 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265361AbSKNWV2>;
	Thu, 14 Nov 2002 17:21:28 -0500
Date: Thu, 14 Nov 2002 14:22:45 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.47
Message-ID: <20021114222245.GA16235@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of USB updates.  They include one patch to kernel.h to
fix a compiler problem if DEBUG is enabled improperly ("#if" changed to
"#ifdef").

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/usb/Makefile            |    7 -
 drivers/usb/class/Kconfig       |   16 +--
 drivers/usb/class/usblp.c       |   67 ++++++++++--
 drivers/usb/core/driverfs.c     |    8 +
 drivers/usb/core/hcd-pci.c      |    1 
 drivers/usb/core/hcd.c          |   91 ++++++++---------
 drivers/usb/core/hcd.h          |    2 
 drivers/usb/core/usb.c          |   63 ++++++------
 drivers/usb/host/Kconfig        |    2 
 drivers/usb/host/Makefile       |    2 
 drivers/usb/host/ehci-dbg.c     |   17 +--
 drivers/usb/host/ehci-hcd.c     |    4 
 drivers/usb/host/ehci-mem.c     |   41 +++++--
 drivers/usb/host/ehci-q.c       |   84 ++++++++--------
 drivers/usb/host/ehci.h         |    6 -
 drivers/usb/host/ohci-dbg.c     |   15 +-
 drivers/usb/host/ohci-hcd.c     |    4 
 drivers/usb/host/ohci-pci.c     |    2 
 drivers/usb/host/ohci-q.c       |    5 
 drivers/usb/host/ohci-sa1111.c  |    4 
 drivers/usb/host/ohci.h         |    5 
 drivers/usb/image/scanner.c     |   10 -
 drivers/usb/image/scanner.h     |    8 -
 drivers/usb/input/hid-core.c    |    4 
 drivers/usb/input/hid-debug.h   |   92 +++++++++++++++++
 drivers/usb/input/hid.h         |    2 
 drivers/usb/input/hiddev.c      |    9 +
 drivers/usb/media/vicam.c       |    1 
 drivers/usb/misc/usbtest.c      |  107 +++++++++++++++++++-
 drivers/usb/net/Kconfig         |   15 +-
 drivers/usb/storage/freecom.c   |   52 ----------
 drivers/usb/storage/isd200.c    |  207 +++++++---------------------------------
 drivers/usb/storage/raw_bulk.c  |   11 --
 drivers/usb/storage/scsiglue.c  |    2 
 drivers/usb/storage/transport.c |   79 +--------------
 drivers/usb/storage/transport.h |    1 
 drivers/usb/storage/usb.c       |   35 ------
 include/linux/device.h          |   10 -
 include/linux/hiddev.h          |    1 
 include/linux/kernel.h          |    2 
 40 files changed, 524 insertions(+), 570 deletions(-)
-----

ChangeSet@1.859, 2002-11-14 13:57:34-08:00, david-b@pacbell.net
  [PATCH] HID patches for MGE UPS
  
  I thought I'd send the results of some experimentation of mine getting
  an MGE UPS (Evolution) to talk to 2.5 ... basically it behaved after
  some patches, though the "hidups" driver didn't.  They're all attached:
  
     - "hiddev-1.patch"  ... The default queue size was so small that this
       low-speed device couldn't queue up about 110 control requests
       (that many reports to check!) during init.
  
     - "hiddev-2.patch" ... Makes hid debug output more useful by
        (a) making it compile again;
        (b) adding lots of "Power Device" and "Battery System" reports,
            and putting all that data into the readonly data section;
        (c) actually printing the usage strings, if they're known;
        (d) printing a message when neither input nor hiddev claim
            the device ... likely something's wrong, like someone
            didn't configure in input subsystem or hiddev support.
  
     - "hiddev-3.patch" ... Teaches hiddev to expose the physical ID
       just like the input event framework does.  Useful to help sort
       out which UPS is which, so you won't power down the wrong set
       of servers by accident.

 drivers/usb/input/hid-core.c  |    4 +
 drivers/usb/input/hid-debug.h |   92 ++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/input/hid.h       |    2 
 drivers/usb/input/hiddev.c    |    9 ++++
 include/linux/hiddev.h        |    1 
 5 files changed, 102 insertions(+), 6 deletions(-)
------

ChangeSet@1.858, 2002-11-14 13:47:36-08:00, david-b@pacbell.net
  [PATCH] ohci-hcd, driverfs files work again, less debug output
  
  This fixes a problem from Chris' patch, letting the driverfs files
  work again.  The root cause was a duplicate "parent_dev" field,
  now gone.  This also adds minor cleanup in the hcd glue, renaming
  the value being duplicated as the "controller" that the HCD is
  driving.  (A "parent" should rarely be used, but the "controller"
  has reasonable uses all over the place ... like in dev_dbg calls!)
  It's initted by the PCI bus glue, or by the SA-1111 bus glue.
  
  Also makes some OHCI debug messages appear only when VERBOSE debug
  is (manually) enabled.  This was self-defense, otherwise running
  the link/unlink "usbtest" cases could fill up the log filesystem
  (with debug enabled).

 drivers/usb/core/hcd-pci.c     |    1 +
 drivers/usb/core/hcd.h         |    2 +-
 drivers/usb/host/ohci-dbg.c    |   15 ++++++---------
 drivers/usb/host/ohci-hcd.c    |    4 ++--
 drivers/usb/host/ohci-pci.c    |    2 --
 drivers/usb/host/ohci-q.c      |    5 ++++-
 drivers/usb/host/ohci-sa1111.c |    4 +---
 drivers/usb/host/ohci.h        |    5 -----
 8 files changed, 15 insertions(+), 23 deletions(-)
------

ChangeSet@1.823.3.20, 2002-11-14 11:33:34-08:00, greg@kroah.com
  USB: fixup previous missed hunk in vicam patch.

 drivers/usb/media/vicam.c |    1 -
 1 files changed, 1 deletion(-)
------

ChangeSet@1.823.3.19, 2002-11-14 11:26:50-08:00, greg@kroah.com
  [PATCH] USB: hcd.c: move #ifdef CONFIG_USB_DEBUG statement around a bit.
  

 drivers/usb/core/hcd.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)
------

ChangeSet@1.823.3.18, 2002-11-14 11:25:53-08:00, david-b@pacbell.net
  [PATCH] cleanup usb hcd unlink code
  
  This fixes various minor problems:
  
  - re-orders some tests so that "(no bus?)" diagnostic should
      no longer be appearing (and making folk worry needlessly)
  
  - removes one unreachable test for URB_TIMEOUT_KILLED
  
  - removes the reachable test, since it's never an error on the
      part of the device driver to unlink something the HCD is already
      unlinking.
  
  - gets rid of some comments and code that expected automagic resubmits
      for interrupts (no more!),
  
  - resolves a FIXME for a rather unlikely situation (HCD can't
      perform the unlink, it reports an error)
  
  It also starts to use dev_dbg() macros, which give more concise
  (lately) and useful (they have both driver name and device id)
  diagnostics than the previous usb-only dbg() macros.  To do this,
  DEBUG had to be #defined before <linux/driver.h> is included, but
  it can't be #undeffed before <linux/kernel.h> is included.

 drivers/usb/core/hcd.c |   81 +++++++++++++++++++++++--------------------------
 1 files changed, 39 insertions(+), 42 deletions(-)
------

ChangeSet@1.823.3.17, 2002-11-14 11:25:38-08:00, david-b@pacbell.net
  [PATCH] usb_new_device() sets up dev->dev earlier
  
  This mostly moves the initialization of some sysfs-related
  fields earlier, so HCD code can access them during those
  (initial error prone) parts of enumeration without oopsing.
  
  The particular access I wanted was using <linux/driver.h>
  debug utilities like dev_dbg(), dev_warn() and so on ... so
  I also changed the name the "generic" driver gives itself
  to be "usb" so those messages make more sense.
  
  Also added comments about how usb_new_device() moves the
  device through the other chapter 9 usb device states.

 drivers/usb/core/usb.c |   39 ++++++++++++++++++++++++---------------
 1 files changed, 24 insertions(+), 15 deletions(-)
------

ChangeSet@1.823.3.16, 2002-11-14 11:25:24-08:00, david-b@pacbell.net
  [PATCH] usb sysfs shows bNumConfigurations
  
  This patch shows how many configurations a device has,
  which will be important for eventual user mode tools
  that manage configurations.

 drivers/usb/core/driverfs.c |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.823.3.15, 2002-11-14 10:29:32-08:00, greg@kroah.com
  [PATCH] kernel.h: changed #if DEBUG to #ifdef DEBUG to play nicer with compilers.
  

 include/linux/kernel.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.823.3.14, 2002-11-13 00:14:49-08:00, greg@kroah.com
  [PATCH] USB: changed USB_UHCI_HCD_ALT to USB_UHCI_HCD as there is only one driver.

 drivers/usb/Makefile      |    7 +------
 drivers/usb/host/Kconfig  |    2 +-
 drivers/usb/host/Makefile |    2 +-
 3 files changed, 3 insertions(+), 8 deletions(-)
------

ChangeSet@1.823.3.13, 2002-11-12 23:12:19-08:00, randy.dunlap@verizon.net
  [PATCH] usblp buffer allocation (2.5.47)
  
  Here is the usblp buffer allocation patch for 2.5.47.

 drivers/usb/class/usblp.c |   67 +++++++++++++++++++++++++++++++++++-----------
 1 files changed, 52 insertions(+), 15 deletions(-)
------

ChangeSet@1.823.3.12, 2002-11-12 22:26:24-08:00, greg@kroah.com
  [PATCH] USB: fixed up the wording of the bluetty driver's help entry to be stronger.
  
  This was suggested by Max Krasnyansky to try to remove confusion between this driver
  and the BlueZ supported driver.

 drivers/usb/class/Kconfig |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)
------

ChangeSet@1.823.3.11, 2002-11-12 17:14:43-08:00, khaho@koti.soon.fi
  [PATCH] Re: USB scanner fix for 2.5.47 was not good  ?
  
  Bad news is that the scanner endpoint change did not work, maybe I
  mistested it or it never worked. My version worked, but was very ugly.
  
  Here is a working one (against 2.5.47), this also looks nicer (I did not know the
  EP_XXX() could be changed too):

 drivers/usb/image/scanner.c |   10 +++++-----
 drivers/usb/image/scanner.h |    8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)
------

ChangeSet@1.823.3.10, 2002-11-11 17:21:19-08:00, david-b@pacbell.net
  [PATCH] ehci-hcd, use dummy td when queueing
  
  What it does is give up on catching all the "race with HC" cases
  when appending to a live QH, by switching to using a disabled
  "dummy" TD at the end of all hardware queues.  The HC won't cache
  disabled TDs, so it just sees "always good" pointers: no races.
  
  As a side benefit this also makes it safe to not irq on completion
  of most TDs that are queued using the scatterlist calls, so it'll
  be typical for one 64 KByte usb-storage request to mean just one
  irq (or less!) even without tuning ehci irq latency (for the DATA
  stage, that is).

 drivers/usb/host/ehci-dbg.c |   17 +++++---
 drivers/usb/host/ehci-hcd.c |    4 +-
 drivers/usb/host/ehci-mem.c |   41 ++++++++++++++-------
 drivers/usb/host/ehci-q.c   |   84 +++++++++++++++++++++++---------------------
 drivers/usb/host/ehci.h     |    6 ---
 5 files changed, 85 insertions(+), 67 deletions(-)
------

ChangeSet@1.823.3.9, 2002-11-11 15:47:33-08:00, david-b@pacbell.net
  [PATCH] USB: update usb hotplug documentation
  

 drivers/usb/core/usb.c |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)
------

ChangeSet@1.823.3.8, 2002-11-11 15:20:40-08:00, david-b@pacbell.net
  [PATCH] usbnet Kconfig helptext
  
  Mostly just highlights the PDA support, now that we can say
  this talks to all the Linux based PDAs; adds "more info" URL.

 drivers/usb/net/Kconfig |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)
------

ChangeSet@1.823.3.7, 2002-11-11 15:19:51-08:00, david-b@pacbell.net
  [PATCH] usbtest, add some unlink testcases
  
  This adds some simple unlink test cases.  I've only run these
  against OHCI so far, and so far only in simple configurations
  (only one active device), where it hasn't yet turned up problems.

 drivers/usb/misc/usbtest.c |  107 +++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 99 insertions(+), 8 deletions(-)
------

ChangeSet@1.823.3.6, 2002-11-11 14:58:21-08:00, david-b@pacbell.net
  [PATCH] <linux/device.h> KERN_WARN(ING)
  
  This fixes <linux/device.h> so dev_warn() uses KERN_WARNING,
  instead of a non-existent symbol.  It also uses parens around
  some arguments that need them ... those macros are now usable.

 include/linux/device.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.823.3.5, 2002-11-11 13:13:45-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb storage: remove unneeded workaround for START_STOP
  
  This patch removes the special-case code for START_STOP.  It can be safely
  removed now because the higher SCSI layers won't send this command unless
  the device indicates that it needs it to allow media access.

 drivers/usb/storage/usb.c |   35 -----------------------------------
 1 files changed, 35 deletions(-)
------

ChangeSet@1.823.3.4, 2002-11-11 13:13:30-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb storage: fix spelling, comments.
  
  This patch fixes some spelling errors and makes some comments a bit
  more clear.

 drivers/usb/storage/freecom.c   |    4 ++--
 drivers/usb/storage/raw_bulk.c  |   11 ++---------
 drivers/usb/storage/scsiglue.c  |    2 +-
 drivers/usb/storage/transport.c |   13 +++++++------
 4 files changed, 12 insertions(+), 18 deletions(-)
------

ChangeSet@1.823.3.3, 2002-11-11 13:13:16-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb storage: fix aborted auto-sense
  
  This patch fixes the case of an ABORT happening during the auto-sense
  processing when using the ISD-200 driver.

 drivers/usb/storage/isd200.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.823.3.2, 2002-11-11 13:13:00-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb storage: remove duplicate functions
  
  Once upon a time, the SCSI command structure could only hold a maximum of
  12 bytes.  Thus, the ISD-200 driver needed an entirely separate function to
  work with 16-byte commands.
  
  Now that 16-bytes is stored, we can cut the duplicates.

 drivers/usb/storage/isd200.c |  175 ++++++++-----------------------------------
 1 files changed, 35 insertions(+), 140 deletions(-)
------

ChangeSet@1.823.3.1, 2002-11-11 13:12:39-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb storage: remmove unneeded abort checks
  
  Since we now test for aborts at a higher level, the low-level end of the
  drivers don't need to be constantly testing for aborts.  This patch removes
  that excess logic.

 drivers/usb/storage/freecom.c   |   48 -----------------------------
 drivers/usb/storage/isd200.c    |   28 ----------------
 drivers/usb/storage/transport.c |   66 +---------------------------------------
 drivers/usb/storage/transport.h |    1 
 4 files changed, 2 insertions(+), 141 deletions(-)
------

