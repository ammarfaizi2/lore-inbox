Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267163AbTAFVYB>; Mon, 6 Jan 2003 16:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbTAFVYB>; Mon, 6 Jan 2003 16:24:01 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:53509 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267163AbTAFVXj>;
	Mon, 6 Jan 2003 16:23:39 -0500
Date: Mon, 6 Jan 2003 13:32:13 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.21-pre2
Message-ID: <20030106213213.GA22055@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates and bugfixes for 2.4.21-pre2.

Please pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 Documentation/usb/scanner-hp-sane.txt |   79 ----
 Documentation/Configure.help          |   27 +
 Documentation/usb/ov511.txt           |   10 
 Documentation/usb/scanner.txt         |  328 +++++++------------
 Documentation/usb/usb-serial.txt      |   34 +-
 Makefile                              |    4 
 drivers/usb/hcd.c                     |   34 +-
 drivers/usb/hcd.h                     |    7 
 drivers/usb/hcd/ehci-dbg.c            |   90 +++--
 drivers/usb/hcd/ehci-hcd.c            |  203 ++++++------
 drivers/usb/hcd/ehci-hub.c            |   19 -
 drivers/usb/hcd/ehci-mem.c            |   83 ++--
 drivers/usb/hcd/ehci-q.c              |  571 ++++++++++++++++------------------
 drivers/usb/hcd/ehci-sched.c          |   28 -
 drivers/usb/hcd/ehci.h                |    9 
 drivers/usb/ibmcam.c                  |  135 ++++----
 drivers/usb/kaweth.c                  |    8 
 drivers/usb/ov511.c                   |  511 ++++++++++++++++--------------
 drivers/usb/ov511.h                   |   22 -
 drivers/usb/pegasus.c                 |    5 
 drivers/usb/pegasus.h                 |    9 
 drivers/usb/rtl8150.c                 |   10 
 drivers/usb/scanner.c                 |  156 +++++----
 drivers/usb/scanner.h                 |   68 ++--
 drivers/usb/serial/ipaq.c             |   38 ++
 drivers/usb/serial/ipaq.h             |   53 ++-
 drivers/usb/ultracam.c                |   62 +--
 drivers/usb/usbvideo.c                |  493 +++++++++++++++--------------
 drivers/usb/usbvideo.h                |  196 ++++++-----
 29 files changed, 1699 insertions(+), 1593 deletions(-)
-----

ChangeSet@1.955, 2003-01-06 11:13:49-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.4
  into kroah.com:/home/greg/linux/BK/gregkh-2.4

 Documentation/Configure.help |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)
------

ChangeSet@1.893.2.27, 2003-01-06 11:07:07-08:00, mark@alpha.dyndns.org
  [PATCH] USB ov511: Convert to new V4L 1 interface
  
  Here's a patch to switch ov511 over to the new V4L 1 interface
  introduced in 2.4.19. Rather than storing the function pointers for
  open(), ioctl(), etc in struct video_device, I just hand the V4L layer a
  struct file_operations.
  
  The advantages of this are:
  
  - The driver more closely resembles its 2.5 counterpart.
  
  - Multiple simultaneous opens will eventually be possible.
  
  - The old interfaces required calling video_unregister_device() from
  close() if the device was unplugged while open, causing a deadlock in
  the V4L layer. Now we just call video_unregister_device()
  unconditionally from disconnect(). (Credit goes to Duncan Haldane for
  tracking that bug down)
  
  This is just a backport of the changes made to the driver in ~2.5.10;
  nothing new here. I've been using this version of the code under 2.4 for
  months and it works well.

 drivers/usb/ov511.c |  127 ++++++++++++++++++----------------------------------
 1 files changed, 44 insertions(+), 83 deletions(-)
------

ChangeSet@1.893.2.26, 2003-01-06 11:02:25-08:00, henning@meier-geinitz.de
  [PATCH] USB scanner driver: updated documentation
  
  This patch updates the documentation for the USB scanner driver. The
  details:
  
  Documentation/usb/scanner.txt:
    - Added information about read_timeout
    - Added more details about /proc/bus/usb/devices
    - Added/updated links
    - Added pointers two "special" scanner drivers
    - Reordering, spell-checking, formatting
    - Used /dev/usb/scanner[0-15] instead of /dev/usbscanner[0-15]
    - Removed some basic USB configuration stuff
    - Added EHCI
    - Removed some more references to HP
  
  Documentation/usb/scanner-hp-sane.txt:
    Removed completely. This was a very outdated text for some HP
    scanners. All of this is explained in the documentation of the
    user-space SANE tools. Links and a short explanation about SANE was
    added to scanner.txt instead.

 Documentation/usb/scanner-hp-sane.txt |   79 --------
 Documentation/usb/scanner.txt         |  328 +++++++++++++---------------------
 2 files changed, 133 insertions(+), 274 deletions(-)
------

ChangeSet@1.893.2.25, 2003-01-06 11:02:15-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: fix race in ioctl_scanner()
  
  This patch adds locking to ioctl_scanner() which was completely
  lacking until now. The patch is originally from Oliver Neukum
  <oliver@neukum.name>.

 drivers/usb/scanner.c |   95 +++++++++++++++++++++++++-------------------------
 1 files changed, 48 insertions(+), 47 deletions(-)
------

ChangeSet@1.893.2.24, 2003-01-06 10:59:57-08:00, oliver@oenone.homelinux.org
  [PATCH] USB kaweth bugfix
  
  - correct freeing of skbs

 drivers/usb/kaweth.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.893.2.23, 2003-01-06 10:49:31-08:00, petkan@rakia.hell.org
  [PATCH] Petkan's email address change
  
  email address change

 Documentation/Configure.help |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.893.2.22, 2003-01-06 10:49:21-08:00, petkan@rakia.hell.org
  [PATCH] USB rtl8150 update
  
  set mac address at dev->open() time;

 drivers/usb/rtl8150.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)
------

ChangeSet@1.893.2.21, 2003-01-06 10:49:12-08:00, petkan@rakia.hell.org
  [PATCH] USB pegasus update
  
  set mac address at dev->open() time as per the standard;
  missing flag added to Linksys USB10T;

 drivers/usb/pegasus.c |    5 ++++-
 drivers/usb/pegasus.h |    4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)
------

ChangeSet@1.893.2.20, 2002-12-26 18:54:18-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo fixes from 2.5  5/5
  
  Make usbvideo_register take a usb_device_id argument which it
  can then pass to usb_register via the struct usb_device.
  Currently it passes NULL.

 drivers/usb/ibmcam.c   |   23 +++++++++++++----------
 drivers/usb/ultracam.c |   18 ++++++++----------
 drivers/usb/usbvideo.c |    4 +++-
 drivers/usb/usbvideo.h |    3 ++-
 4 files changed, 26 insertions(+), 22 deletions(-)
------

ChangeSet@1.893.2.19, 2002-12-26 18:54:02-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo fixes from 2.5  4/5
  
  Add setVideoMode callback to VIDIOCSWIN
  Make VIDIOCGWIN return videosize instead of canvas size

 drivers/usb/usbvideo.c |    7 +++++--
 drivers/usb/usbvideo.h |    1 +
 2 files changed, 6 insertions(+), 2 deletions(-)
------

ChangeSet@1.893.2.18, 2002-12-26 18:53:43-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo fixes from 2.5  3/5
  
  Add startDataPump and stopDataPump callbacks to usbvideo.c

 drivers/usb/usbvideo.c |   12 ++++++++----
 drivers/usb/usbvideo.h |    2 ++
 2 files changed, 10 insertions(+), 4 deletions(-)
------

ChangeSet@1.893.2.17, 2002-12-26 18:53:28-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo fixes from 2.5  2/5
  
  This patch fixes the use of USBVIDEO_NUMFRAMES. A few places in the code
  assumed it was 2.

 drivers/usb/usbvideo.c |   49 ++++++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 23 deletions(-)
------

ChangeSet@1.893.2.16, 2002-12-26 18:53:13-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo fixes from 2.5  1/5
  
  This patch backports some fixes from 2.5 for the RingQueue_*
  functions
  
  Make the buffer length be a power of 2 to speed up index manipulation
  Make RingQueue_Dequeue use memcpy() rather than a byte by byte copy
  Make RingQueue_Enqueue use memcpy() instead of memmove() as the memory
    regions do not overlap
  Add RingQueue_Flush() and RingQueue_GetFreeSpace()
  Make RingQueue_GetLength() an inline

 drivers/usb/usbvideo.c |   80 +++++++++++++++++++++++++++++++------------------
 drivers/usb/usbvideo.h |   22 ++++++++-----
 2 files changed, 66 insertions(+), 36 deletions(-)
------

ChangeSet@1.893.2.15, 2002-12-24 11:56:19-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo cleanups 4/4
  
  This is a backport of some usbvideo cleanups from 2.5:
  
  typedef enum { .. } ScanState_t -> enum ScanState
  typedef enum { .. } ParseState_t -> enum ParseState
  typedef enum { .. } FrameState_t -> enum FrameState
  typedef enum { .. } Deinterlace_t -> enum Deinterlace
  typedef struct { .. } usbvideo_t -> struct usbvideo

 drivers/usb/ibmcam.c   |   14 +++++++-------
 drivers/usb/ultracam.c |    2 +-
 drivers/usb/usbvideo.c |   30 +++++++++++++++---------------
 drivers/usb/usbvideo.h |   36 ++++++++++++++++++------------------
 4 files changed, 41 insertions(+), 41 deletions(-)
------

ChangeSet@1.893.2.14, 2002-12-24 11:56:06-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo cleanups 3/4
  
  This is a backport of some usbvideo cleanups from 2.5:
  
  typedef struct { .. } RingQueue_t -> struct RingQueue
  typedef struct { .. } usbvideo_sbuf_t -> struct usbvideo_sbuf
  typedef struct { .. } usbvideo_frame_t -> struct usbvideo_frame
  typedef struct { .. } usbvideo_statistics_t -> struct usbvideo_statistics
  typedef struct { .. } usbvideo_cb_t -> struct usbvideo_cb

 drivers/usb/ibmcam.c   |   14 ++++-----
 drivers/usb/ultracam.c |    4 +-
 drivers/usb/usbvideo.c |   42 +++++++++++++--------------
 drivers/usb/usbvideo.h |   74 +++++++++++++++++++++++--------------------------
 4 files changed, 66 insertions(+), 68 deletions(-)
------

ChangeSet@1.893.2.13, 2002-12-24 11:55:52-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo cleanups 2/4
  
  This is a backport of some usbvideo cleanups from 2.5:
  
  typedef struct { } uvd_t -> struct uvd

 drivers/usb/ibmcam.c   |   84 ++++++++++++++++++++++++-------------------------
 drivers/usb/ultracam.c |   38 +++++++++++-----------
 drivers/usb/usbvideo.c |   74 +++++++++++++++++++++----------------------
 drivers/usb/usbvideo.h |   58 ++++++++++++++++-----------------
 4 files changed, 127 insertions(+), 127 deletions(-)
------

ChangeSet@1.893.2.12, 2002-12-24 11:55:39-08:00, spse@secret.org.uk
  [PATCH] 2.4.20 usbvideo cleanups 1/4
  
  This is a backport of some usbvideo cleanups from 2.5:
  
  Replace static const char proc[] = <function name> with __FUNCTION__

 drivers/usb/usbvideo.c |  195 +++++++++++++++++++++----------------------------
 1 files changed, 86 insertions(+), 109 deletions(-)
------

ChangeSet@1.893.4.1, 2002-12-24 10:23:21-08:00, ganesh@tuxtop.vxindia.veritas.com
  [PATCH] USB ipaq driver update
  
  The ActiveSync USB "protocol" seems to be the same for all WinCE
  devices seen so far. So it seems reasonable to pre-emptively support
  all devices which work with ActiveSync.

 Documentation/Configure.help     |    6 ++--
 Documentation/usb/usb-serial.txt |   34 ++++++++++++++++---------
 drivers/usb/serial/ipaq.c        |   38 +++++++++++++++++++++++++--
 drivers/usb/serial/ipaq.h        |   53 +++++++++++++++++++++++++++++++++++----
 4 files changed, 107 insertions(+), 24 deletions(-)
------

ChangeSet@1.893.2.10, 2002-12-23 16:02:27-08:00, greg@kroah.com
  [PATCH] USB scanner: stop managing our module reference count, and let the VFS do it.

 drivers/usb/scanner.c |    9 +--------
 1 files changed, 1 insertion(+), 8 deletions(-)
------

ChangeSet@1.893.2.9, 2002-12-23 11:55:53-08:00, rddunlap@osdl.org
  [PATCH] usb semaphore lock in 2.4.20-rc1 (since 2.4.13)
  
  This fixes an oops if cpia is built into the kernel along with USB.
  cpia (in drivers/media/) inits before USB and causes use of an
  uninitialized semaphore in USB.
  
  Patch is from Duncan Haldane.
  
  Alan OK-ed this patch.

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.893.2.8, 2002-12-23 11:49:14-08:00, henning@meier-geinitz.de
  [PATCH] [PATCH 2.4.21-pre1] scanner.c: Use first altsetting in probe_scanner()
  
  Without this patch, the alternate setting with index ifnum was used,
  not the first one.

 drivers/usb/scanner.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.893.2.7, 2002-12-23 11:48:26-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: Accept scanners with more than one interface
  
  This patch allows the scanner driver to accept devices with more than
  one interface. That's needed by some multi-function periphals (e.g.
  scanner+printer).

 drivers/usb/scanner.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)
------

ChangeSet@1.893.2.6, 2002-12-23 11:48:06-08:00, david-b@pacbell.net
  [PATCH] ehci updates
  
  This patch basically brings the 2.4 code up to the level
  of the latest 2.5.52bk4+ patches ... so while not perfect
  (I know of a hub issue) I think it's worth circulating:
  
  - Fixes "it hangs" ... at least for the storage cases
      I could reproduce.
  
  - Longer reset timeout for Intel EHCI ... this bug had
      been lurking since July in the 2.5 series, but was
      only reported (and most of the fix identified!) by a
      user after 2.4.21pre1 came out.
  
  - Better fixes for a problem first seen with VT8235.
      Had to dedicate a QH as list head, never unlinked.
      Oopsable, but NEC hardware seemingly implemented the
      EHCI spec in a way that they didn't require that.
  
  - Significant updates to QTD and URB queuing.  Much
      more robust, fewer hardware races.  Uses "dummy td"
      scheme.  Most USB device drivers in 2.4 won't stress
      that logic as much as usb-storage does in 2.5, but
      the robustness should help all around.
  
  - Diagnostics updates.  Both 2.4 and 2.5 versions
      should emit the same "new style" diagnostics,
      but 2.4 can't use <linux/device.h> to do it.
  
  - DaveM's "remove tasklet" patch.  Bubbled up to the
      "hcd" glue, but completions on 2.4 don't receive
      the 'struct pt_regs *' so it stops there.
  
  - Other less notable fixes and cleanups too.
  
  One way to look at the patch is:  (a) a smallish set
  of "hcd" updates, which can help 2.4 backports of the
  other 2.5 "*hcd" drivers too; (b) the 2.5 ehci-hcd with
  the addition of about 4K of patches to handle things
  like "2.4 needs interrupt automagic".

 drivers/usb/hcd.c            |   34 +-
 drivers/usb/hcd.h            |    7 
 drivers/usb/hcd/ehci-dbg.c   |   90 ++++--
 drivers/usb/hcd/ehci-hcd.c   |  203 ++++++++-------
 drivers/usb/hcd/ehci-hub.c   |   19 -
 drivers/usb/hcd/ehci-mem.c   |   83 +++---
 drivers/usb/hcd/ehci-q.c     |  571 +++++++++++++++++++++----------------------
 drivers/usb/hcd/ehci-sched.c |   28 --
 drivers/usb/hcd/ehci.h       |    9 
 9 files changed, 543 insertions(+), 501 deletions(-)
------

ChangeSet@1.893.2.5, 2002-12-23 11:47:29-08:00, mark@hal9000.dyndns.org
  [PATCH] Update ov511 to version 1.63. This is a backport of the 2.5 driver,
  
  Notable changes:
  * Make use of usb_make_path()
  * Fix an oops when snapshot mode is enabled
  * Get rid of automagic resubmit
  * OV518 is closer to working
  * Clean up OV6x30 register settings
  * Remove some dead code

 Documentation/usb/ov511.txt |   10 +
 drivers/usb/ov511.c         |  384 ++++++++++++++++++++++++++------------------
 drivers/usb/ov511.h         |   22 --
 3 files changed, 242 insertions(+), 174 deletions(-)
------

ChangeSet@1.893.2.4, 2002-12-19 15:03:38-08:00, petkan@rakia.hell.org
  [PATCH] a new device added and assign proper vendor id to the Netgear adapter

 drivers/usb/pegasus.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
------

ChangeSet@1.893.2.3, 2002-12-19 14:47:00-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: Support for devices with only one bulk-in endpoint
  
  This patch (originally from Sergey Vlasov) adds support for scanners
  with only one bulk-in endpoint. It's needed by all the GT-6801 based
  scanners like the Artec Ultima 2000 or some of the Mustek BearPaws.

 drivers/usb/scanner.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)
------

ChangeSet@1.893.2.2, 2002-12-19 14:46:51-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: silence noisy debug message
  
  The patch changes the noisy "Unable to access minor data" message to a
  dbg.

 drivers/usb/scanner.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.893.2.1, 2002-12-19 14:46:41-08:00, henning@meier-geinitz.de
  [PATCH] scanner.h: add/fix vendor/product ids
  
  This patch adds additional vendor and product ids for Nikon, Mustek,
  Plustek, Genius, Epson, Canon, Umax, Hewlett-Packard, Benq, Agfa,
  and Minolta scanners. The entries for Benq, Genius and Plustek
  scanners have been updated.
  
  I've also increased the version number to 0.4.9 and brought the
  version numbers in scanner.c and scanner.h in sync.

 drivers/usb/scanner.c |   13 ++++++++-
 drivers/usb/scanner.h |   68 ++++++++++++++++++++++++++++++++++----------------
 2 files changed, 59 insertions(+), 22 deletions(-)
------

