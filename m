Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264867AbSLVIic>; Sun, 22 Dec 2002 03:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSLVIic>; Sun, 22 Dec 2002 03:38:32 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52746 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264867AbSLVIi2>;
	Sun, 22 Dec 2002 03:38:28 -0500
Date: Sun, 22 Dec 2002 00:43:15 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] More USB changes for 2.5.52
Message-ID: <20021222084314.GK18933@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This also includes one patch to device.h to add the dev_printk macro.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/class/cdc-acm.c      |    2 
 drivers/usb/core/hcd.c           |   12 +
 drivers/usb/core/hub.c           |   57 ++++-----
 drivers/usb/core/inode.c         |    2 
 drivers/usb/host/ehci-mem.c      |    2 
 drivers/usb/host/ehci-q.c        |  247 ++++++++++++++++++---------------------
 drivers/usb/image/scanner.c      |   33 ++++-
 drivers/usb/image/scanner.h      |   96 ++++++++++-----
 drivers/usb/media/ibmcam.c       |    6 
 drivers/usb/media/stv680.h       |    6 
 drivers/usb/misc/speedtouch.c    |   35 ++---
 drivers/usb/net/cdc-ether.c      |    4 
 drivers/usb/serial/keyspan_pda.c |    4 
 include/linux/device.h           |   15 +-
 14 files changed, 282 insertions(+), 239 deletions(-)
-----

ChangeSet@1.865.28.18, 2002-12-21 23:54:35-08:00, jkenisto@us.ibm.com
  [PATCH] dev_printk macro

 include/linux/device.h |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)
------

ChangeSet@1.865.28.17, 2002-12-21 23:07:29-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: Support for devices with only one bulk-in endpoint
  
  This patch (originally from Sergey Vlasov) adds support for scanners
  with only one bulk-in endpoint. It's needed by all the GT-6801 based
  scanners like the Artec Ultima 2000 or some of the Mustek BearPaws.

 drivers/usb/image/scanner.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)
------

ChangeSet@1.865.28.16, 2002-12-21 23:07:03-08:00, henning@meier-geinitz.de
  [PATCH] scanner.h: add/fix vendor/product ids
  
  This patch adds additional vendor and product ids for Nikon, Mustek,
  Plustek, Genius, Epson, Canon, Umax, Hewlett-Packard, Benq, Agfa,
  and Minolta scanners. The entries for Benq, Genius and Plustek
  scanners have been updated.
  
  I've also increased the version number to 0.4.9 and brought the
  version numbers in scanner.c and scanner.h in sync.

 drivers/usb/image/scanner.c |   13 +++++
 drivers/usb/image/scanner.h |   96 ++++++++++++++++++++++++++++++--------------
 2 files changed, 78 insertions(+), 31 deletions(-)
------

ChangeSet@1.865.28.15, 2002-12-21 23:03:20-08:00, david-b@pacbell.net
  [PATCH] ehci, qtd submit and completions
  
   > ... usb-storage gets unhappy when
   > it decides (why?  and unsuccessfully) to reset high speed
   > devices.  ...
  
  I don't know if that problem is resolved, but this patch
  makes the question moot by handling an earlier error correctly.
  
  The patch updates an incorrect test, so a short read will now
  be treated as one.  Please merge.
  
  This lets storage behave again.  As in, "mkfs -c" then copy
  about 8 GB around, then 'dbench'.

 drivers/usb/host/ehci-q.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.865.28.14, 2002-12-19 15:14:03-08:00, david-b@pacbell.net
  [PATCH] usbcore: rm hub oops, message cleanups, unlink
  
  These changes are unrelated except I ran into them all at once:
  
  - Fixes an oops from a partial hub_configure() clean; let
     hub_disconnect() do the whole thing, simpler.
  
  - Since I was there, modify that routine's err() messages
     to use dev_err().  Then eliminate a redundant diagnostic
     in hub_probe(), and merge the "bad descriptor" cases into
     one diagnostic.  Saves a few hundred rodata bytes, and
     the messages now say what hub's involved.
  
  - Unlink fixes:  if lower level code reports a submit error,
     make sure the urb gets unlinked from the device's urb_list;
     and report "it's already being unlinked" as -EBUSY so callers
     can do something smarter than wonder "what did I do wrong".

 drivers/usb/core/hcd.c |   12 +++++++---
 drivers/usb/core/hub.c |   57 +++++++++++++++++++++++--------------------------
 2 files changed, 36 insertions(+), 33 deletions(-)
------

ChangeSet@1.865.28.13, 2002-12-19 15:13:46-08:00, david-b@pacbell.net
  [PATCH] ehci, qtd submit and completions
  
  This ought to address a number of the problems with the
  recent "dummy td" update as well as some older ones:
  
      - Slims down the qh_append_tds() to remove two pairs
        of "should be duplicate" logic so that
          * qh_make() only creates and initializes;
          * qh_append_tds() calls it earlier;
          * always appends with dummy, no routine qh updates.
  
      - Reworked qh_completions() ... simpler, better.
         * two notable FIXMEs gone, and a bug related to
           how they interacted with scatterlist i/o
         * fixed bugs (including one oops) exposed by
           using dummies more.
  
  Passes basic testing:  most 'usbtest' cases, usb2 hub
  with keyboard and CF adapter, storage enumeration.
  So it seems less troublesome, though it's still not
  as happy as I've seen it.
  
  However, "testusb -at12" (running 'write unlink' tests)
  still fails for me, and usb-storage gets unhappy when
  it decides (why?  and unsuccessfully) to reset high speed
  devices.  I'm still chasing those problems, which seem
  to come from higher up in the stack.

 drivers/usb/host/ehci-mem.c |    2 
 drivers/usb/host/ehci-q.c   |  244 ++++++++++++++++++++------------------------
 2 files changed, 117 insertions(+), 129 deletions(-)
------

ChangeSet@1.865.28.12, 2002-12-19 14:23:57-08:00, greg@kroah.com
  [PATCH] USB: fix the spelling of "deprecated".
  
  Thanks to Randy Dunlap for pointing this out.

 drivers/usb/core/inode.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.865.28.11, 2002-12-19 12:11:06-08:00, oliver@neukum.name
  [PATCH] USB cdc-ether: GFP_KERNEL in interrupt
  
  cdc-ether has the same problem as cdc-acm.
    - usb_submit_urb() under spinlock or in interrupt must use GFP_ATOMIC

 drivers/usb/net/cdc-ether.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.865.28.10, 2002-12-19 12:10:47-08:00, oliver@neukum.name
  [PATCH] USB cdc-acm: missed a GFP_KERNEL in interrupt
  
  the patch turns it into GFP_ATOMIC.

 drivers/usb/class/cdc-acm.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.865.28.9, 2002-12-19 12:10:31-08:00, oliver@neukum.name
  [PATCH] USB: speedtouch possible deadlock in atm_close path
  
  this removes the spinlocks in close, so that
  the synchronous unlinking is safe.

 drivers/usb/misc/speedtouch.c |    3 ---
 1 files changed, 3 deletions(-)
------

ChangeSet@1.865.28.8, 2002-12-19 12:10:13-08:00, oliver@neukum.name
  [PATCH] USB: remove obviously broken code from the speedtouch disconnect handler
  
  I am not sure what this code was supposed to do, but it can stop khubd
  indefinitely. It has to go.

 drivers/usb/misc/speedtouch.c |    5 -----
 1 files changed, 5 deletions(-)
------

ChangeSet@1.865.28.7, 2002-12-19 12:09:56-08:00, oliver@neukum.name
  [PATCH] USB: speedtouch reentrancy race through usbfs
  
  speedtouch povides an ioctl handler through usbfs.
  It must not be reentered. A semaphore ensures that.

 drivers/usb/misc/speedtouch.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)
------

ChangeSet@1.865.28.6, 2002-12-19 12:09:37-08:00, oliver@neukum.name
  [PATCH] USB: speedtouch remove error handling with usb_clear_halt
  
  usb_clear_halt cannot be used from a completion handler because it sleeps
  As that code path would have crashed the driver, it's obviously not needed
  and can be removed.

 drivers/usb/misc/speedtouch.c |    3 ---
 1 files changed, 3 deletions(-)
------

ChangeSet@1.865.28.5, 2002-12-19 12:09:18-08:00, oliver@neukum.name
  [PATCH] USB: more spinlock work for speedtouch
  
     - simple spinlocks will do

 drivers/usb/misc/speedtouch.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)
------

ChangeSet@1.865.28.4, 2002-12-19 12:09:01-08:00, oliver@neukum.name
  [PATCH] USB: simplify spinlocks in send path for speedtouch
  
  irqsave spinlocks in an interrupt handler are superfluous.
  Simple spinlocks are sufficient and quicker. As this is in
  interrupt context, every cycle counts.

 drivers/usb/misc/speedtouch.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)
------

ChangeSet@1.865.28.3, 2002-12-19 12:07:51-08:00, arnd@bergmann-dalldorf.de
  [PATCH] namespace pollution in ibmcam driver
  
  The variable 'cams' should be static.
  Don't initialize to 0, while we're here.

 drivers/usb/media/ibmcam.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.865.28.2, 2002-12-19 12:07:31-08:00, arnd@bergmann-dalldorf.de
  [PATCH] namespace pollution in STV0680 camera driver
  
  Variables should not be defined in a header file.
  This slightly improves the driver by making them
  static instead of global.

 drivers/usb/media/stv680.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.865.16.10, 2002-12-17 09:33:01-08:00, greg@kroah.com
  [PATCH] USB: keyspan_pda: fix up the short names, as they were too big.

 drivers/usb/serial/keyspan_pda.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

