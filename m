Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261559AbSJ1V5p>; Mon, 28 Oct 2002 16:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261561AbSJ1V5p>; Mon, 28 Oct 2002 16:57:45 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21003 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261559AbSJ1V5d>;
	Mon, 28 Oct 2002 16:57:33 -0500
Date: Mon, 28 Oct 2002 14:01:27 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.44
Message-ID: <20021028220127.GC19523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series also has a change to the driver core that adds /sbin/hotplug
support for all class information.  That patch was verified by Pat
Mochel as good.

Also the way USB interrupt urbs work has been changed to work like all
other types of urbs, in that they are not automatically resubmitted.  So
all drivers that used interrupt urbs have been fixed up to resubmit them
if appropriate.  If anyone has any problems with these changes, please
let me know about it.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/base/base.h                        |    5 
 drivers/base/class.c                       |    7 
 drivers/base/hotplug.c                     |   64 +
 drivers/bluetooth/hci_usb.c                |   30 
 drivers/input/joystick/iforce/iforce-usb.c |   25 
 drivers/isdn/hisax/st5481_usb.c            |   30 
 drivers/usb/class/audio.c                  |    8 
 drivers/usb/class/bluetty.c                |   33 
 drivers/usb/class/cdc-acm.c                |   31 
 drivers/usb/core/hcd.c                     |   35 
 drivers/usb/core/hub.c                     |    9 
 drivers/usb/core/message.c                 |   63 -
 drivers/usb/core/urb.c                     |   65 -
 drivers/usb/core/usb.c                     |   34 
 drivers/usb/host/ehci-hcd.c                |    2 
 drivers/usb/host/ehci-q.c                  |   58 -
 drivers/usb/host/ohci-hcd.c                |   10 
 drivers/usb/host/ohci-q.c                  |   64 -
 drivers/usb/host/uhci-hcd.c                |   40 -
 drivers/usb/image/hpusbscsi.c              |    7 
 drivers/usb/image/microtek.c               |   11 
 drivers/usb/image/scanner.c                |   19 
 drivers/usb/input/aiptek.c                 |   20 
 drivers/usb/input/hid-core.c               |   22 
 drivers/usb/input/hiddev.c                 |    2 
 drivers/usb/input/powermate.c              |   21 
 drivers/usb/input/usbkbd.c                 |   19 
 drivers/usb/input/usbmouse.c               |   20 
 drivers/usb/input/wacom.c                  |   94 ++
 drivers/usb/input/xpad.c                   |   21 
 drivers/usb/media/se401.c                  |   23 
 drivers/usb/media/vicam.c                  |   77 --
 drivers/usb/misc/auerswald.c               |   38 -
 drivers/usb/misc/brlvger.c                 |   27 
 drivers/usb/misc/usbtest.c                 |   17 
 drivers/usb/net/catc.c                     |   18 
 drivers/usb/net/kaweth.c                   |   21 
 drivers/usb/net/pegasus.c                  |    8 
 drivers/usb/net/rtl8150.c                  |   16 
 drivers/usb/net/usbnet.c                   |  308 ++++++--
 drivers/usb/serial/belkin_sa.c             |   25 
 drivers/usb/serial/io_edgeport.c           |   47 -
 drivers/usb/serial/io_ti.c                 |   26 
 drivers/usb/serial/keyspan_pda.c           |   23 
 drivers/usb/serial/mct_u232.c              |   32 
 drivers/usb/serial/pl2303.c                |   31 
 drivers/usb/serial/visor.c                 |    2 
 drivers/usb/serial/visor.h                 |    1 
 drivers/usb/serial/whiteheat.c             |   34 
 drivers/usb/serial/whiteheat_fw.h          | 1034 ++++++++++++++---------------
 drivers/usb/storage/shuttle_usbat.c        |    2 
 drivers/usb/storage/transport.c            |  145 +++-
 drivers/usb/storage/transport.h            |    3 
 drivers/usb/storage/usb.c                  |   13 
 drivers/usb/storage/usb.h                  |    2 
 include/linux/device.h                     |    2 
 include/linux/usb.h                        |  162 ----
 include/linux/usb_ch9.h                    |  215 ++++++
 58 files changed, 1965 insertions(+), 1256 deletions(-)
-----

ChangeSet@1.808.2.27, 2002-10-28 12:06:13-08:00, david-b@pacbell.net
  [PATCH] create <linux/usb_ch9.h>
  
  This patch addresses some of the minor problems with programming
  USB with "usbfs", or coming up with any kind of usb slave/target
  device driver API (including eventually USB-OTG).
  
  It does so by creating a new <linux/usb_ch9.h> file that defines
  common constants and descriptor structures that are now found in
  <linux/usb.h> but which are (a) not exported to userspace, making
  programming with "usbfs" awkward, and (b) needlessly mixed up with
  the usb master/host-only side APIs, which a slave/target-only side
  API will not want to require.  These definitions are just moved out
  of <linux/usb.h>, so they can be accessed safely.
  
  
  If folk agree that this should be done, instead of different headers
  and declarations for master/host, slave/target, and dual-mode OTG
  (which was the road the Lineo APIs, rejected by Linus, started down),
  I think this should be merged (compiles but untested) as a start.
  
  Then configuration, interface, and device descriptors could get split
  out too.  That'd involve some code changes, since those descriptor
  structures have been augmented (or maybe "sullied"?) with data that's
  specific to the Linux host-side driver implementation.  So they're
  currently unsuitable to be used by user-space or slave/target drivers.

 include/linux/usb.h     |  154 ----------------------------------
 include/linux/usb_ch9.h |  215 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 217 insertions(+), 152 deletions(-)
------

ChangeSet@1.808.2.26, 2002-10-28 12:02:49-08:00, david-b@pacbell.net
  [PATCH] Zaurus support for usbnet
  
  > This is a patch against 2.4.20-pre11, because i can't use the 2.5.44 (kernel
  > freeze a boot time). The second patch is a incremental patch for the latest
  > 2.5 kernel.
  
  Cool!  Greg, 2.5 version (attached) looks fine to me.  If it
  applies against your BK repository, please merge it.
  
  The 2.4.20 version looks to be using an older version of the
  usbnet driver, so please don't merge that one.  I'll resync in
  a while.
  
  By the way, I found out that it's not "the www.handhelds.org"
  kernel but the standard ARM kernels (like 2.4.29-rmk2) that
  have the "usb-eth" driver for the SA-1100.  They're going to
  need similar changes (switch endpoints for pxa250 versions).
  
  Time to actually look at the endpoint descriptors, maybe ... :)

 drivers/usb/net/usbnet.c |   25 +++++++++++++++++++++----
 1 files changed, 21 insertions(+), 4 deletions(-)
------

ChangeSet@1.808.2.25, 2002-10-28 11:58:59-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: use scatter-gather core primitives
  
  This patch switches the usb-storage driver to using the new USB core
  scatter-gather primitives.  This _should_ create a significant performance
  gain.

 drivers/usb/storage/transport.c |  122 +++++++++++++++++++++++++++++++---------
 drivers/usb/storage/transport.h |    3 
 drivers/usb/storage/usb.c       |   13 ++++
 drivers/usb/storage/usb.h       |    2 
 4 files changed, 114 insertions(+), 26 deletions(-)
------

ChangeSet@1.808.2.24, 2002-10-28 11:58:39-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: fix error code
  
  This patch fixes a return code that was mangled during a hand-merging of
  some code changes.

 drivers/usb/storage/shuttle_usbat.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.808.2.23, 2002-10-28 11:55:09-08:00, greg@kroah.com
  [PATCH] USB: fix GFP flags for usb audio driver.

 drivers/usb/class/audio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.808.2.22, 2002-10-28 11:52:34-08:00, greg@kroah.com
  USB: fix the usb drivers outside the drivers/usb tree due to interrupt urb no automatic resubmission change to the usb core.

 drivers/bluetooth/hci_usb.c                |   30 ++++++++++++++++++++++++++---
 drivers/input/joystick/iforce/iforce-usb.c |   25 +++++++++++++++++++++++-
 drivers/isdn/hisax/st5481_usb.c            |   30 ++++++++++++++++++++---------
 3 files changed, 72 insertions(+), 13 deletions(-)
------

ChangeSet@1.808.2.21, 2002-10-28 11:51:35-08:00, greg@kroah.com
  fix the usb storage drivers due to interrupt urb no automatic resubmission change to the usb core.

 drivers/usb/storage/transport.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)
------

ChangeSet@1.808.2.20, 2002-10-28 11:50:48-08:00, greg@kroah.com
  USB: fix the usb net drivers due to interrupt urb no automatic resubmission change to the usb core.

 drivers/usb/net/usbnet.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)
------

ChangeSet@1.808.2.19, 2002-10-28 11:50:05-08:00, greg@kroah.com
  USB: fix the usb misc drivers due to interrupt urb no automatic resubmission change to the usb core.

 drivers/usb/misc/auerswald.c |   38 ++++++++++++++++++++++++++------------
 drivers/usb/misc/brlvger.c   |   27 ++++++++++++++++++++-------
 2 files changed, 46 insertions(+), 19 deletions(-)
------

ChangeSet@1.808.2.18, 2002-10-28 11:49:17-08:00, greg@kroah.com
  USB: fix the usb media drivers due to interrupt urb no automatic resubmission change to the usb core.

 drivers/usb/media/se401.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletion(-)
------

ChangeSet@1.808.2.17, 2002-10-28 11:48:30-08:00, greg@kroah.com
  fix the usb image drivers due to interrupt urb no automatic resubmission change to the usb core.

 drivers/usb/image/scanner.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)
------

ChangeSet@1.808.2.16, 2002-10-28 11:47:41-08:00, greg@kroah.com
  USB: fix the usb class drivers due to interrupt urb no automatic resubmission change to the usb core

 drivers/usb/class/bluetty.c |   33 +++++++++++++++++++++++++--------
 drivers/usb/class/cdc-acm.c |   31 ++++++++++++++++++++++++-------
 2 files changed, 49 insertions(+), 15 deletions(-)
------

ChangeSet@1.808.2.15, 2002-10-28 11:46:49-08:00, greg@kroah.com
  USB: fix the usb input drivers due to interrupt urb no automatic resubmission change to the usb core.

 drivers/usb/input/aiptek.c    |   20 ++++++++
 drivers/usb/input/powermate.c |   21 ++++++++-
 drivers/usb/input/wacom.c     |   94 ++++++++++++++++++++++++++++++++++++++----
 drivers/usb/input/xpad.c      |   21 ++++++++-
 4 files changed, 146 insertions(+), 10 deletions(-)
------

ChangeSet@1.808.2.14, 2002-10-28 11:45:45-08:00, greg@kroah.com
  USB: fix the usb serial drivers due to interrupt urb no automatic resubmission change to the usb core.

 drivers/usb/serial/belkin_sa.c   |   25 ++++++++++++++++----
 drivers/usb/serial/io_edgeport.c |   47 ++++++++++++++++++++++++++-------------
 drivers/usb/serial/io_ti.c       |   26 +++++++++++++++++----
 drivers/usb/serial/keyspan_pda.c |   23 ++++++++++++++++---
 drivers/usb/serial/mct_u232.c    |   32 ++++++++++++++++++--------
 drivers/usb/serial/pl2303.c      |   31 +++++++++++++++++--------
 6 files changed, 136 insertions(+), 48 deletions(-)
------

ChangeSet@1.808.2.13, 2002-10-25 09:59:54-07:00, david-b@pacbell.net
  [PATCH] rm "automagic resubmit" for usb interrupt transfers
  
  Here's that promised patch to remove the problematic "automagic
  resubmit" mode from the API for interrupt transfers.  It covers
  the core (including main HCDs) and a few essential drivers.
  
  All urbs now obey a simple rule:  submit them once, then wait for
  some completion callback.  Or unlink the urb if you're impatient,
  canceling the i/o request (which may have been partially completed).
  Bulk and interrupt transfers now behave the same at the API level,
  except that only interrupt transfers have bandwidth failure modes.
  
  
  Previously, interrupt transfers were different from bulk transfers
  in several ways that made limited sense.  The only thing that's
  supposed to be special is achieving service latency guarantees by
  using the reserved periodic bandwidth.
  
  But there were a lot of other restrictions, plus HCD-dependent
  behaviors/bugs.  Doing something like sending a 97 byte message
  to a device portably was a thing of pain, since the low-level
  "one packet per interval" rule was pushed up to drivers instead
  of being handled inside HCDs like it is for bulk, and sending a
  final "short" packet meant an urb unlink/relink.  (Fixing this
  required UHCI to use a queue of TDs, like EHCI and OHCI; fixed
  by 2.5.44, and a small change in this patch.  I'm not sure the
  unlink/relink issues have ever been really addressed.)  Neither
  1-msec transfer intervals nor USB 2.0 "high bandwidth" mode can
  reliably be serviced without a multi-buffered queue of interrupt
  transfers.  (Comes almost for free with TD queueing; as of 2.5.44
  all HCDs should do this.)
  
  And then there's "automagic resubmission", which made HCDs
  keep urbs during their complete() callbacks in a rather curious
  state ... half-owned by HCD, half-owned by device driver, not
  exactly linked but maybe not unlinked either.  Bug-prone, and
  hard to test.
  
  
  So that's all gone now!  This particular patch
  
    - updates the main hcds to use normal urb-completion logic
      for interrupt transfers, nothing special. (*)
  
    - makes usbcore (hub and root hub drivers) expect that, and
      removes an old kernel 2.3 "urb state confusion" workaround.
      (urb->dev is no longer nulled to distinguish unlinked urbs,
      since there's no longer a "half-in/half-out" state.)  also
      the relevent kerneldoc is updated.
  
    - enables the 'usbtest' support for interrupt transfers, in
      both queued and non-queued modes.  (but I haven't made time
      to test this ... the hcds "should" be fine since they use the
      same code now for bulk and interrupt, and bulk checked out.)
  
    - teaches hid-core, usbkbd, and usbmouse how to resubmit
      interrupt transfers explicitly. usb keyboards/mice work,
      but some less-common HID devices won't.
  
    - updated usb/net drivers (catc, kaweth, pegasus, rtl8150)
  
  But it doesn't update all device drivers that use interrupt
  transfers.  The failure mode for un-converted drivers will
  be that interrupts after the first one get lost, and the
  fix for those drivers will be simple (see what the drivers
  here do).
  
  
  (*) It doesn't touch non-{E,O,U}HCI HCDs, like the SL-811HS,
       since those changes will require hardware as well as
       some quality time with 'usbtest'.

 drivers/usb/core/hcd.c       |   35 +++++++----------------
 drivers/usb/core/hub.c       |    9 +++++
 drivers/usb/core/message.c   |    6 ---
 drivers/usb/core/urb.c       |   65 +++++++++++++++++++++----------------------
 drivers/usb/host/ehci-hcd.c  |    2 -
 drivers/usb/host/ehci-q.c    |   34 ----------------------
 drivers/usb/host/ohci-q.c    |   64 +-----------------------------------------
 drivers/usb/host/uhci-hcd.c  |   40 +++++---------------------
 drivers/usb/input/hid-core.c |   22 +++++++++++---
 drivers/usb/input/usbkbd.c   |   19 +++++++++++-
 drivers/usb/input/usbmouse.c |   20 ++++++++++++-
 drivers/usb/misc/usbtest.c   |   17 +++++------
 drivers/usb/net/catc.c       |   18 ++++++++++-
 drivers/usb/net/kaweth.c     |   21 ++++++++++++-
 drivers/usb/net/pegasus.c    |    8 +++++
 drivers/usb/net/rtl8150.c    |   16 +++++++++-
 include/linux/usb.h          |    8 -----
 17 files changed, 185 insertions(+), 219 deletions(-)
------

ChangeSet@1.808.2.12, 2002-10-24 15:01:51-07:00, greg@kroah.com
  driver core: add support for calling /sbin/hotplug when classes are found and removed from the system.

 drivers/base/base.h    |    5 +++
 drivers/base/class.c   |    7 ++++-
 drivers/base/hotplug.c |   64 +++++++++++++++++++++++++++++++++++++++----------
 include/linux/device.h |    2 +
 4 files changed, 64 insertions(+), 14 deletions(-)
------

ChangeSet@1.808.2.11, 2002-10-23 11:27:20-07:00, david-b@pacbell.net
  [PATCH] ehci enumerating full speed devices
  
  The EHCI driver was never adjusting the full speed maximum packet size up
  (when enumerating through a transaction translating hub).  This broke the
  enumeration of some devices (maxpacket != 8) pretty early.
  
  This patch updates EHCI to fix the bug, and does minor cleanup to usbcore
  logic that figures out ep0 maxpacket.  I left the partial read in for all
  speeds, even though only full speed needs it.

 drivers/usb/core/usb.c    |   34 ++++++++++++++++++++++++++--------
 drivers/usb/host/ehci-q.c |   24 ++++++++++++++++++++----
 2 files changed, 46 insertions(+), 12 deletions(-)
------

ChangeSet@1.808.2.10, 2002-10-23 11:27:03-07:00, arnaud.quette@mgeups.com
  [PATCH] drivers/usb/input/hiddev.c: fix hiddev_connect issue when
  
  The following one line patch (against 2.5.44) fixes an index problem when
  connecting a new hiddev
  device, when kernel isn't compiled with CONFIG_USB_DYNAMIC_MINORS. Previous
  attempt to open
  hiddev device terminated with an ENODEV error. Note that this fix works with
  either dynamic minors
  flag enabled or not.

 drivers/usb/input/hiddev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.808.2.9, 2002-10-22 13:08:34-07:00, oliver@oenone.homelinux.org
  [PATCH] USB: hpusbscsi - kill wrong error case
  

 drivers/usb/image/hpusbscsi.c |    7 +------
 1 files changed, 1 insertion(+), 6 deletions(-)
------

ChangeSet@1.808.2.8, 2002-10-21 23:30:44-07:00, jtyner@cs.ucr.edu
  [PATCH] drivers/usb/media/vicam.c: simplify vicam_read
  
  > The following patch removes the old framebuf_size and framebuf_read_start
  > values from the cam structure and simplifes the read function. It also
  > moves the needs dummy read check into the read_frame function. cp and dd
  > should both still work.
  
  This is in addition to the previous patch. It should allow any programs
  that read entire frames to receive a new frame with each successive read.
  Programs that read less than the entire frame will read until they reach
  the end of the frame. They will then read 0 bytes (signifying EOF). The
  next read will start the next frame.

 drivers/usb/media/vicam.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.808.2.7, 2002-10-21 23:30:26-07:00, jtyner@cs.ucr.edu
  [PATCH] drivers/usb/media/vicam.c: simplify vicam_read
  
  The following patch removes the old framebuf_size and framebuf_read_start
  values from the cam structure and simplifes the read function. It also
  moves the needs dummy read check into the read_frame function. cp and dd
  should both still work.

 drivers/usb/media/vicam.c |   73 ++++++++++------------------------------------
 1 files changed, 17 insertions(+), 56 deletions(-)
------

ChangeSet@1.808.2.6, 2002-10-21 23:28:48-07:00, stuartm@connecttech.com
  [PATCH] More wh patches
  
  Inlined are a few more patches to 2.5.43 that fix problems that
  were discovered during QA.
  
  1-firm4.07 :: I've moved to the bottom since it's huge
  
  Updates the firmware to 4.07. Fixes a bug introduced in 4.05 where
  RTS is high after boot. Also fixes a bug where the whiteheat would
  allow data reception after boot when no ports were open.
  
  2-fix-dtr-rts
  
  I didn't know this, but the firmware open command also handles
  raising the signals for me. This code is superflous.
  
  3-fix-read-urb
  
  Read polling was started right away in whiteheat_open(). Coupled
  with the firmware bug fixed above where data could be received
  by a port that wasn't open, this caused the whiteheat_read_callback
  to fire before open() was finished, and in some cases this caused
  harm to the tty layer. I didn't track down the exact mechanism
  because either moving the read polling to the last operation of open()
  or using the fixed firmware caused the crash to stop happening. I
  have stack traces if you'd like to have a look; it looks like something
  scribbles on the stack, but I couldn't figure out what eactly, as the
  scribbled data didn't match anything in the whiteheat driver or the
  test applications.
  
  4-fix-ixoff
  
  RELEVANT_IFLAG masks off the software flow control bits, so that
  a change that is restricted to the soft flow bits will be ignored. This
  is the email I sent earlier; I've decided to just not use the macro for
  now, but I'd still like to know if the macro should be fixed,.
  
  ..Stu

 drivers/usb/serial/whiteheat.c    |   34 -
 drivers/usb/serial/whiteheat_fw.h | 1034 +++++++++++++++++++-------------------
 2 files changed, 528 insertions(+), 540 deletions(-)
------

ChangeSet@1.808.2.5, 2002-10-21 23:25:48-07:00, oliver@oenone.homelinux.org
  [PATCH] USB: microtek driver - remove dead code

 drivers/usb/image/microtek.c |   11 +----------
 1 files changed, 1 insertion(+), 10 deletions(-)
------

ChangeSet@1.808.2.4, 2002-10-21 23:22:52-07:00, dbrownell@users.sourceforge.net
  [PATCH] usb: problem clearing halts
  
  This is a slightly cleaned up version of that earlier patch:
  
  - Makes both copies of the clear_halt() logic know that
     usb_pipein() returns boolean (zero/not) not integer (0/1).
     This resolves a problem folk have had with usb-storage.
     (I looked at kernel uses of usb_pipein and it really was
     only the clear_halt logic that cares.)
  
  - Removes some code from the "standard" version; no point
     in Linux expecting devices to do something neither Microsoft
     nor Apple will test for.

 drivers/usb/core/message.c      |   57 +++++++++++++++-------------------------
 drivers/usb/storage/transport.c |    5 ++-
 2 files changed, 26 insertions(+), 36 deletions(-)
------

ChangeSet@1.808.2.3, 2002-10-21 23:22:14-07:00, dbrownell@users.sourceforge.net
  [PATCH] usbnet, preliminary zaurus support
  
  This is Pavel's patch, with some cleanups and re-sorting of
  the various SA-1100 cases.  According to Pavel this works
  as well as his earlier version ... which is to say, maybe
  not yet, he saw a uhci "very bad" error (on 2.5.43).
  
  I'm sending it along since it's clearly the right way to
  support the Zaurus, and it can't be that far off given the
  code I've seen.

 drivers/usb/net/usbnet.c |  263 ++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 206 insertions(+), 57 deletions(-)
------

ChangeSet@1.808.2.2, 2002-10-21 23:21:09-07:00, dbrownell@users.sourceforge.net
  [PATCH] ohci-hcd, longer bios handshake timeout
  
  This should resolve the problems Nicolas Mailhot reported,
  where an old BIOS seemed reluctant to release the controller
  and the dbg() message delayed things enough to work.  At
  worst, it'll eliminate dbg() messages as a factor.

 drivers/usb/host/ohci-hcd.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)
------

ChangeSet@1.808.2.1, 2002-10-21 23:19:12-07:00, greg@kroah.com
  [PATCH] USB: added support for Clie NX60 device.
  
  Thanks to Hiroyuki ARAKI <hiro@zob.ne.jp> for the information.

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

