Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261775AbSJNAGy>; Sun, 13 Oct 2002 20:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261786AbSJNAGy>; Sun, 13 Oct 2002 20:06:54 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6660 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261775AbSJNAGt>;
	Sun, 13 Oct 2002 20:06:49 -0400
Date: Sun, 13 Oct 2002 17:13:02 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.42
Message-ID: <20021014001302.GA806@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series also adds the char tipar driver, as the author didn't know
anyone else to send it to.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/char/Config.help            |   21 
 drivers/char/Config.in              |    1 
 drivers/char/Makefile               |    1 
 drivers/char/tipar.c                |  541 ++++++++++
 drivers/usb/core/hcd-pci.c          |    3 
 drivers/usb/core/hub.c              |   12 
 drivers/usb/core/inode.c            |   33 
 drivers/usb/core/message.c          |   30 
 drivers/usb/core/urb.c              |    2 
 drivers/usb/core/usb.c              |   37 
 drivers/usb/host/ehci-hcd.c         |    3 
 drivers/usb/host/hc_sl811.c         |    3 
 drivers/usb/host/ohci-pci.c         |    3 
 drivers/usb/host/ohci-sa1111.c      |    5 
 drivers/usb/host/uhci-hcd.c         |    3 
 drivers/usb/input/wacom.c           |    1 
 drivers/usb/media/Makefile          |    0 
 drivers/usb/media/Makefile          |    2 
 drivers/usb/media/vicam.c           | 1928 ++++++++++++++++++++++--------------
 drivers/usb/media/vicam.h           |   81 -
 drivers/usb/media/vicamurbs.h       |  332 ------
 drivers/usb/net/usbnet.c            |    2 
 drivers/usb/serial/io_ti.c          |   76 -
 drivers/usb/serial/usb-serial.c     |   30 
 drivers/usb/serial/visor.c          |    2 
 drivers/usb/serial/whiteheat.c      |   18 
 drivers/usb/storage/datafab.c       |   11 
 drivers/usb/storage/freecom.c       |   90 -
 drivers/usb/storage/initializers.c  |    2 
 drivers/usb/storage/isd200.c        |   42 
 drivers/usb/storage/jumpshot.c      |   42 
 drivers/usb/storage/raw_bulk.c      |  221 ----
 drivers/usb/storage/raw_bulk.h      |   17 
 drivers/usb/storage/sddr09.c        |   50 
 drivers/usb/storage/sddr55.c        |   10 
 drivers/usb/storage/shuttle_usbat.c |  270 ++---
 drivers/usb/storage/transport.c     |  298 ++---
 drivers/usb/storage/transport.h     |   24 
 drivers/usb/storage/usb.c           |    6 
 drivers/usb/storage/usb.h           |    4 
 include/linux/usb.h                 |   37 
 include/linux/videodev.h            |    1 
 MAINTAINERS                         |    8 
 43 files changed, 2409 insertions(+), 1894 deletions(-)
------

ChangeSet@1.738.5.31, 2002-10-13 15:40:00-07:00, david-b@pacbell.net
  [PATCH] usbcore doc + minor fixes
  
  Cleaning out my queue of most minor patches:
  
    - Provides some kerneldoc for 'struct usb_interface' now that
      the API is highlighting it.
  
    - Fixes usb_set_interface() so it doesn't affect other interfaces.
  
      This provides the right place for an eventual HCD call to clean
      out now-invalid records of endpoint state, and also gets rid of
      a potential SMP issue where drivers on different interfaces
      calling concurrently could clobber each other.  (Per-interface
      data doesn't need locking except against config changes.)
  
    - It's OK to pass URB_NO_INTERRUPT hints if you're queueing a
      bunch of interrupt transfers.
  
  The set_interface call should eventually take the interface as a
  parameter, it's one of the few left using the "device plus magic
  number" identifier.  I have a partial patch for that, but it doesn't
  handle the (newish) ALSA usb audio driver or a few other callers.

 drivers/usb/core/message.c |   30 +++++++++++++++++++++++-------
 drivers/usb/core/urb.c     |    2 +-
 include/linux/usb.h        |   36 +++++++++++++++++++++++++++++++++---
 3 files changed, 57 insertions(+), 11 deletions(-)
------

ChangeSet@1.738.5.30, 2002-10-13 15:07:46-07:00, greg@kroah.com
  USB: visor.c: changed USB_DT_DEVICE to USB_RECIP_INTERFACE, as that's the proper #define to use.
  
  Thanks to David Brownell for pointing this out to me.

 drivers/usb/serial/visor.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.738.5.29, 2002-10-13 14:46:31-07:00, rlievin@free.fr
  [PATCH] char driver: added tipar driver
  
  Here is patch which adds parallel link cable support for Texas Instruments
  graphing calculators.

 MAINTAINERS              |    5 
 drivers/char/Config.help |   21 +
 drivers/char/Config.in   |    1 
 drivers/char/Makefile    |    1 
 drivers/char/tipar.c     |  541 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 569 insertions(+)
------

ChangeSet@1.738.5.28, 2002-10-13 13:50:55-07:00, ahaas@neosoft.com
  [PATCH] C99 designated initializers for drivers/usb
  
  Hi.
  
  Here's a set of three patches for switching  ...
  
  drivers/usb/serial/io_ti.c
  drivers/usb/net/usbnet.c
  drivers/usb/core/hub.c
  
  ... to use C99 named initializers. The patches are all against 2.5.42.

 drivers/usb/core/hub.c     |    8 ++--
 drivers/usb/net/usbnet.c   |    2 -
 drivers/usb/serial/io_ti.c |   76 ++++++++++++++++++++++-----------------------
 3 files changed, 43 insertions(+), 43 deletions(-)
------

ChangeSet@1.738.5.27, 2002-10-13 13:49:01-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: convert to common transfer functions
  
  This patch fixes the bulk transport data stage to use the correct pipe for
  data exchange, based on the transfer direction.

 drivers/usb/storage/transport.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.738.5.26, 2002-10-13 13:48:37-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: convert to common transfer functions
  
  This patch makes all sub-drivers use the same data-moving functions.  It
  also eliminates the duplicate functions from raw_bulk.c

 drivers/usb/storage/datafab.c       |   10 -
 drivers/usb/storage/jumpshot.c      |   28 ++--
 drivers/usb/storage/raw_bulk.c      |  213 -------------------------------
 drivers/usb/storage/raw_bulk.h      |   15 --
 drivers/usb/storage/sddr09.c        |   43 +++---
 drivers/usb/storage/sddr55.c        |    9 -
 drivers/usb/storage/shuttle_usbat.c |  242 ++++++++++++++++++------------------
 drivers/usb/storage/transport.c     |    5 
 8 files changed, 175 insertions(+), 390 deletions(-)
------

ChangeSet@1.738.5.25, 2002-10-13 13:48:19-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: generalize transfer functions
  
  This patch generalizes the transfer functions.  This is in preparation for
  consolidating all sub-drivers to use a common set of functions.
  
  Oh, and this patch makes the residue field be initialized.  Making this the
  correct value is still on the TODO list.

 drivers/usb/storage/datafab.c       |    1 
 drivers/usb/storage/freecom.c       |   71 -----------
 drivers/usb/storage/jumpshot.c      |    2 
 drivers/usb/storage/sddr09.c        |    1 
 drivers/usb/storage/sddr55.c        |    1 
 drivers/usb/storage/shuttle_usbat.c |    1 
 drivers/usb/storage/transport.c     |  218 +++++++++++++++++++-----------------
 drivers/usb/storage/transport.h     |   18 ++
 8 files changed, 145 insertions(+), 168 deletions(-)
------

ChangeSet@1.738.5.24, 2002-10-13 13:48:00-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: cache pipe values
  
  This patch to usb-storage makes all pipe values used by the driver an
  unsigned int (like they should be), and caches them in the device data
  structure.

 drivers/usb/storage/freecom.c       |   19 ++++-----
 drivers/usb/storage/initializers.c  |    2 -
 drivers/usb/storage/isd200.c        |   42 +++++++++------------
 drivers/usb/storage/jumpshot.c      |   12 ++----
 drivers/usb/storage/raw_bulk.c      |    8 ++--
 drivers/usb/storage/raw_bulk.h      |    2 -
 drivers/usb/storage/sddr09.c        |    6 +--
 drivers/usb/storage/shuttle_usbat.c |   27 +++++---------
 drivers/usb/storage/transport.c     |   69 ++++++++++++++++--------------------
 drivers/usb/storage/transport.h     |    6 +--
 drivers/usb/storage/usb.c           |    6 +++
 drivers/usb/storage/usb.h           |    4 ++
 12 files changed, 94 insertions(+), 109 deletions(-)
------

ChangeSet@1.738.5.23, 2002-10-13 13:44:34-07:00, greg@kroah.com
  [PATCH] USB: fix up previous pl2303 fix.
  
  This returns the proper value, and fixes a memory leak.

 drivers/usb/serial/usb-serial.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)
------

ChangeSet@1.738.5.22, 2002-10-13 13:44:18-07:00, barryn@pobox.com
  [PATCH] USB: 2.5.42 partial fix for older pl2303
  
  On Sat, Oct 12, 2002 at 06:16:44PM -0700, Greg KH wrote:
  > Now, would you mind taking a look at 2.5, and fixing this there too? :)
  
  Here's a half-successful attempt. With this patch, the device no longer
  appears twice, and it always works on the first open (at least, so I've
  observed up to this point). The open following a successful open usually
  fails (roughly speaking, it appears to play dead), and the open following
  a failed open usually (always?) succeeds.
  
  So, on my PL-2303, it's not perfect but it's certainly livable.
  
  This patch is based on the one I did for 2.4, and in fact, this code
  functions when it's plugged into 2.4.20-pre10 instead of 2.5.42. In that
  scenario, the opens work 100% of the time.
  
  I'd be interested in suggestions or comments regarding this patch.
  Anyone who has a PL-2303 working under 2.5 might want to try this patch
  just to make sure it doesn't kill their working setup.
  
  -Barry K. Nathan <barryn@pobox.com>

 drivers/usb/serial/usb-serial.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)
------

ChangeSet@1.738.5.21, 2002-10-13 13:29:35-07:00, greg@kroah.com
  deleted drivers/usb/media/vicamurbs.h as it's no longer needed.

 drivers/usb/media/vicamurbs.h |  332 ------------------------------------------
 1 files changed, 332 deletions(-)
------

ChangeSet@1.738.5.20, 2002-10-13 13:24:09-07:00, joe@wavicle.org
  [PATCH] USB: Vicam driver update/rewrite
  
  Updates the vicam driver to the latest version from the sourceforge.net
  project.
  
  
  Binary files linux-2.5.41/drivers/usb/media/.usbvideo.c.swp and
  linux-2.5.41-vicam/drivers/usb/media/.usbvideo.c.swp differ
  diff -urN linux-2.5.41/drivers/usb/media/Makefile
  linux-2.5.41-vicam/drivers/usb/media/Makefile

 drivers/usb/media/vicam.h  |   81 -
 drivers/usb/media/Makefile |    2 
 drivers/usb/media/vicam.c  | 1928 ++++++++++++++++++++++++++++-----------------
 include/linux/videodev.h   |    1 
 4 files changed, 1205 insertions(+), 807 deletions(-)
------

ChangeSet@1.738.5.19, 2002-10-11 15:31:15-07:00, adam@yggdrasil.com
  [PATCH] linux-2.5.41/drivers/usb/core/hub.c called down() from interrupt context
  
  	On second thought after reading Oliver Neukum's question about
  "shaving off a cycle or two", here is version of my fix for down()
  being called from interrupt context that uses unlikely() to get the
  speed advantage that would be available from BUG_ON(), while still
  ensuring that the condition is executed even if assertions are
  compiled out.

 drivers/usb/core/hub.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.738.5.18, 2002-10-11 15:03:10-07:00, wli@holomorphy.com
  [PATCH] remove unused variable in wacom driver
  
  wacom.c generates the following warning:
  
  drivers/usb/input/wacom.c: In function `wacom_probe':
  drivers/usb/input/wacom.c:405: warning: unused variable `rep_data'

 drivers/usb/input/wacom.c |    1 -
 1 files changed, 1 deletion(-)
------

ChangeSet@1.738.5.17, 2002-10-11 15:02:59-07:00, ddstreet@ieee.org
  [PATCH] fix usbfs mount count
  
  Hi, this patch fixes usbfs.  You can't use a single mount_count for 2
  different mounts.

 drivers/usb/core/inode.c |   33 +++++++++++++++++----------------
 1 files changed, 17 insertions(+), 16 deletions(-)
------

ChangeSet@1.738.5.16, 2002-10-11 15:02:46-07:00, randy.dunlap@verizon.net
  [PATCH] "nousb" for in-kernel USB
  
  Here's the updated "nousb" patch for vanilla 2.5.41.
  It applies with 2 small offsets to 2.5.41-bk3.

 drivers/usb/core/hcd-pci.c     |    3 +++
 drivers/usb/core/usb.c         |   37 +++++++++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-hcd.c    |    3 +++
 drivers/usb/host/hc_sl811.c    |    3 +++
 drivers/usb/host/ohci-pci.c    |    3 +++
 drivers/usb/host/ohci-sa1111.c |    5 +++++
 drivers/usb/host/uhci-hcd.c    |    3 +++
 include/linux/usb.h            |    1 +
 8 files changed, 58 insertions(+)
------

ChangeSet@1.738.5.15, 2002-10-11 15:02:34-07:00, stuartm@connecttech.com
  [PATCH] USB Whiteheat driver patches
  
  A couple patches on 2.5.41; issues discovered during QA.
  
  1: The hack to get around the unlinking bug. You said this was also in
  2.5.x, so I've included this.
  
  2: filp is NULL when called from usb_serial_disconnect. Fixes an oops.
  
  3: In the case where the module is reloaded; the endpoints in the
  usbsubsystem don't go away. So when the module comes back, the
  endpoints still have the unlink thing, and also need to be cleared.
  Otherwise the firmware appears not respond to the version nubmer query
  and the driver doesn't attach, and you have no device.

 drivers/usb/serial/whiteheat.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletion(-)
------

