Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268232AbTB1Wt3>; Fri, 28 Feb 2003 17:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268233AbTB1Wt3>; Fri, 28 Feb 2003 17:49:29 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4874 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268232AbTB1WtP>;
	Fri, 28 Feb 2003 17:49:15 -0500
Date: Fri, 28 Feb 2003 14:50:56 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.63
Message-ID: <20030228225055.GA29861@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some more USB changes.  There are a lot of speedtouch driver
updates from Duncan Sands, and a bunch of usb-serial changes by me, as I
go though and try to audit all of them for locking issues.  There's also
some ohci and ehci controller driver updates, and a bunch of other minor
changes.  David Brownell also created a new usb document for all of the
related USB documentation (pulling it out of the kernel-api document).

Oh, and I fixed the bug that caused the unload of the usbcore module to
hang, which a number of people have reported in the past.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 Documentation/DocBook/Makefile           |    2 
 Documentation/DocBook/kernel-api.tmpl    |   95 ------
 Documentation/DocBook/usb.tmpl           |  294 +++++++++++++++++++
 drivers/usb/class/usb-midi.h             |    8 
 drivers/usb/core/driverfs.c              |    6 
 drivers/usb/core/hcd.h                   |    4 
 drivers/usb/core/hub.c                   |    2 
 drivers/usb/host/ehci-dbg.c              |    6 
 drivers/usb/host/ehci-hcd.c              |    6 
 drivers/usb/host/ehci-q.c                |   24 +
 drivers/usb/host/ehci.h                  |    1 
 drivers/usb/host/ohci-dbg.c              |  345 +++++++++++++++-------
 drivers/usb/host/ohci-hcd.c              |   99 +++---
 drivers/usb/host/ohci-hub.c              |   10 
 drivers/usb/host/ohci-mem.c              |    6 
 drivers/usb/host/ohci-pci.c              |   75 ++--
 drivers/usb/host/ohci-q.c                |   80 ++---
 drivers/usb/host/ohci-sa1111.c           |   10 
 drivers/usb/host/ohci.h                  |   23 +
 drivers/usb/image/scanner.c              |    9 
 drivers/usb/image/scanner.h              |   24 +
 drivers/usb/input/Kconfig                |   14 
 drivers/usb/input/Makefile               |    1 
 drivers/usb/input/hid-core.c             |    5 
 drivers/usb/input/kbtab.c                |  229 ++++++++++++++
 drivers/usb/misc/rio500.c                |    2 
 drivers/usb/misc/speedtouch.c            |  258 +++++++++-------
 drivers/usb/misc/usblcd.c                |    2 
 drivers/usb/misc/usbtest.c               |  134 +++++---
 drivers/usb/serial/Kconfig               |   12 
 drivers/usb/serial/belkin_sa.c           |   53 ++-
 drivers/usb/serial/ipaq.c                |    1 
 drivers/usb/serial/ipaq.h                |    3 
 drivers/usb/serial/keyspan.c             |   33 ++
 drivers/usb/serial/keyspan.h             |   42 ++
 drivers/usb/serial/keyspan_mpr_fw.h      |  286 ++++++++++++++++++
 drivers/usb/serial/keyspan_usa49wlc_fw.h |  476 +++++++++++++++++++++++++++++++
 drivers/usb/serial/kl5kusb105.c          |   69 ++--
 drivers/usb/serial/mct_u232.c            |  106 ++++--
 drivers/usb/serial/pl2303.c              |   88 +++--
 drivers/usb/serial/visor.c               |   63 +---
 drivers/usb/storage/unusual_devs.h       |   14 
 include/linux/usb.h                      |    2 
 43 files changed, 2367 insertions(+), 655 deletions(-)
-----

ChangeSet@1.1117.2.7, 2003-02-28 14:20:05-08:00, levon@movementarian.org
  [PATCH] rio500 typo
  
  I believe && is meant here, but I cannot test it. This is against 2.5.63

 drivers/usb/misc/rio500.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1117.2.6, 2003-02-28 14:19:46-08:00, levon@movementarian.org
  [PATCH] usbcld typo
  
  Against 2.5.63. I believe && is meant here, not &.

 drivers/usb/misc/usblcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1117.2.5, 2003-02-28 14:19:20-08:00, david-b@pacbell.net
  [PATCH] USB: kerneldoc/pdf
  
  Move the USB documentation to a separate file.

 Documentation/DocBook/Makefile        |    2 
 Documentation/DocBook/kernel-api.tmpl |   95 ----------
 Documentation/DocBook/usb.tmpl        |  294 ++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+), 96 deletions(-)
------

ChangeSet@1.1117.2.4, 2003-02-28 13:41:54-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: handle usb_string failure

 drivers/usb/misc/speedtouch.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)
------

ChangeSet@1.1117.2.3, 2003-02-28 13:34:46-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: be firm when disconnected
  
  Just say -ENODEV

 drivers/usb/misc/speedtouch.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)
------

ChangeSet@1.1117.2.2, 2003-02-28 13:34:06-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: don't race the tasklets

 drivers/usb/misc/speedtouch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1087.1.4, 2003-02-27 09:16:13-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: better proc info
  
  Output the correct device name, show the state of the device (for debugging) and of the
  ADSL line (anyone want to write a graphical utility to show this, like under windows?).  We
  no longer consult the usb_device struct in udsl_atm_proc_read, so don't take a reference
  to it.  Against Greg's current 2.5 USB tree.

 drivers/usb/misc/speedtouch.c |   68 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 58 insertions(+), 10 deletions(-)
------

ChangeSet@1.1087.1.3, 2003-02-26 16:29:39-08:00, greg@kroah.com
  [PATCH] USB: add support for two new keyspan drivers
  
  Thanks to kernel1@jsl.com for helping with this patch.

 drivers/usb/serial/Kconfig               |   12 
 drivers/usb/serial/keyspan.c             |   33 ++
 drivers/usb/serial/keyspan.h             |   42 ++
 drivers/usb/serial/keyspan_mpr_fw.h      |  286 ++++++++++++++++++
 drivers/usb/serial/keyspan_usa49wlc_fw.h |  476 +++++++++++++++++++++++++++++++
 5 files changed, 848 insertions(+), 1 deletion(-)
------

ChangeSet@1.1087.1.2, 2003-02-26 16:15:42-08:00, stern@rowland.harvard.edu
  [PATCH] Trivial patch for usb.h
  
  The usb_snddefctrl and usb_rcvdefctrl macros are wrong.  This hasn't shown
  up until now because usb_rcvdefctrl isn't used anywhere at all, and
  usb_snddefctrl is used exactly once (in core/usb.c).
  
  This patch fixes the macros and moves them to hcd.h.

 drivers/usb/core/hcd.h |    4 ++++
 include/linux/usb.h    |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.1002.3.24, 2003-02-26 11:19:37-08:00, greg@kroah.com
  USB: fix bug that prevented usbcore from shutting down.

 drivers/usb/core/hub.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1002.3.23, 2003-02-26 11:18:23-08:00, greg@kroah.com
  [PATCH] USB: add the rest of the interface descriptor info to sysfs

 drivers/usb/core/driverfs.c |    6 ++++++
 1 files changed, 6 insertions(+)
------

ChangeSet@1.1002.3.22, 2003-02-25 16:10:13-08:00, mdharm@one-eyed-alien.net
  [PATCH] USB: Small patch
  
  Here's a small patch to make your tree in sync with mine.  Somehow, a
  line of comment got lost somewhere.

 drivers/usb/storage/unusual_devs.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.1002.3.21, 2003-02-25 16:07:43-08:00, greg@kroah.com
  [PATCH] USB: fixed potential races in kl5kusb105.c now that there's no locks in the usb-serial core

 drivers/usb/serial/kl5kusb105.c |   69 ++++++++++++++++++++++++++--------------
 1 files changed, 45 insertions(+), 24 deletions(-)
------

ChangeSet@1.1002.3.20, 2003-02-25 13:50:42-08:00, josh@joshisanerd.com
  [PATCH] USB: KB Gear USB Tablet Drivers
  
  Attached are drivers for the KB Gear JamStudio Tablet. There are two
  files, one is against 2.4.20, the other against 2.5.62. I'm hoping this
  isn't too late in the 2.4.21-pre stages to get included (or the 2.5, for
  that matter =). This driver Works For Me, on both 2.4.20 and 2.5.62.
  
  Anyway, as usual, comments, complaints, and patches are more than
  welcome.

 drivers/usb/input/Kconfig    |   14 ++
 drivers/usb/input/Makefile   |    1 
 drivers/usb/input/hid-core.c |    5 
 drivers/usb/input/kbtab.c    |  229 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 249 insertions(+)
------

ChangeSet@1.1002.3.19, 2003-02-25 11:41:18-08:00, henning@meier-geinitz.de
  [PATCH] USB: Fixed generation of devfs names in scanner driver
  
  This patch fixes the generation of devfs names if dynamic minors are disabled.

 drivers/usb/image/scanner.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.1002.3.18, 2003-02-25 11:40:54-08:00, henning@meier-geinitz.de
  [PATCH] USB: New vendor/product ids for scanner driver
  
  This patch adds vendor/product ids for Artec, Avision, Brother,
  Medion, Primax, Prolink, Fujitsu, Plustek, and SYSCAN scanners.

 drivers/usb/image/scanner.c |    6 +++++-
 drivers/usb/image/scanner.h |   24 +++++++++++++++++++++---
 2 files changed, 26 insertions(+), 4 deletions(-)
------

ChangeSet@1.1002.3.17, 2003-02-25 11:32:55-08:00, david-b@pacbell.net
  [PATCH] USB: ehci-hcd, partial VIA workaround
  
  This patch resolves a FIXME, which happens to make many of
  the VIA problems act significantly less severe.  The change
  defers unlinking any QH that just became idle, since it's not
  unlikely it'll be used again before many milliseconds pass.
  
  It reduces the number of unlink interrupts (IAA), and means
  fewer re-activation issues.  Like: newly queued TDs being
  all or partially processed before the QH gets de-activated.
  The VIA hardware seems to have some problems in those cases.
  (Which are extremely common on 2.4 kernels, and less so on
  2.5 because usb-storage streams data much better now.)
  
  It also starts tracking the "lost IAA" errors that I see on
  at least one VT8235 motherboard.  It shows in the "registers"
  sysfs file.  It'd be good to know if it's just my hardware
  that has this problem, or if other folk also see it.

 drivers/usb/host/ehci-dbg.c |    6 ++++--
 drivers/usb/host/ehci-hcd.c |    6 ++++--
 drivers/usb/host/ehci-q.c   |   24 +++++++++++++++++-------
 drivers/usb/host/ehci.h     |    1 +
 4 files changed, 26 insertions(+), 11 deletions(-)
------

ChangeSet@1.1002.3.16, 2003-02-25 11:32:31-08:00, david-b@pacbell.net
  [PATCH] USB ohci:  "registers" sysfs file
  
  This is a slightly cleaned up version of Kevin's patch to
  add a "registers" sysfs debug file.  Minor style and whitespace
  fixups, prints the other register, resolved config/build
  issues (minor).
  
  It also has two minor tweaks: a fix for a potential assertion
  violation on a "dead-hc" cleanup path (rare), and wasting less
  time blocking irqs when they're already blocked.

 drivers/usb/host/ohci-dbg.c |  248 +++++++++++++++++++++++++++++++++-----------
 drivers/usb/host/ohci-hcd.c |   18 ++-
 drivers/usb/host/ohci-pci.c |    2 
 drivers/usb/host/ohci-q.c   |   21 +--
 4 files changed, 212 insertions(+), 77 deletions(-)
------

ChangeSet@1.1002.3.15, 2003-02-25 11:16:10-08:00, greg@kroah.com
  USB: fixed potential races in belkin_sa.c now that there's no locks in the usb-serial core

 drivers/usb/serial/belkin_sa.c |   53 ++++++++++++++++++++++++++++++++---------
 1 files changed, 42 insertions(+), 11 deletions(-)
------

ChangeSet@1.1002.3.14, 2003-02-25 11:12:34-08:00, greg@kroah.com
  [PATCH] USB: fix potential races in mct_u232 now that there's no locks in the usb-serial core.

 drivers/usb/serial/mct_u232.c |  106 ++++++++++++++++++++++++++++++------------
 1 files changed, 76 insertions(+), 30 deletions(-)
------

ChangeSet@1.1002.3.13, 2003-02-21 17:03:07-08:00, greg@kroah.com
  [PATCH] USB pl2303: add locking now that the usb-serial core doesn't protect us.

 drivers/usb/serial/pl2303.c |   88 ++++++++++++++++++++++++++------------------
 1 files changed, 53 insertions(+), 35 deletions(-)
------

ChangeSet@1.1002.3.12, 2003-02-21 17:02:50-08:00, greg@kroah.com
  [PATCH] USB visor: cleanup the close() logic

 drivers/usb/serial/visor.c |   33 ++++++++++++++-------------------
 1 files changed, 14 insertions(+), 19 deletions(-)
------

ChangeSet@1.1002.3.11, 2003-02-21 17:02:34-08:00, greg@kroah.com
  [PATCH] USB visor: fixed the driver_info cast to the proper type.

 drivers/usb/serial/visor.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)
------

ChangeSet@1.1002.3.10, 2003-02-21 09:17:40-08:00, andrew.wood@ivarch.com
  [PATCH] USB: USB-MIDI support for Roland SC8820

 drivers/usb/class/usb-midi.h |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.1002.3.9, 2003-02-21 09:17:14-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: use USB dbg macro

 drivers/usb/misc/speedtouch.c |  159 ++++++++++++++++++++----------------------
 1 files changed, 77 insertions(+), 82 deletions(-)
------

ChangeSet@1.1002.3.8, 2003-02-21 09:16:48-08:00, ganesh@vxindia.veritas.com
  [PATCH] USB ipaq.c: add ids for fujitsu loox
  
   Added ids for the Fujitsu-Siemens Loox. Thanks to Michael Brausen.

 drivers/usb/serial/ipaq.c |    1 +
 drivers/usb/serial/ipaq.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.1002.3.7, 2003-02-21 09:16:22-08:00, zaitcev@redhat.com
  [PATCH] USB: Yet another unusual_devs.h member.
  
  Also note that SL11R was duplicated, so I removed it.

 drivers/usb/storage/unusual_devs.h |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)
------

ChangeSet@1.1002.3.5, 2003-02-20 10:18:21-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: take ref to USB device
  
  udsl_atm_proc_read may be called after USB disconnect.

 drivers/usb/misc/speedtouch.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.1002.3.4, 2003-02-20 10:18:03-08:00, david-b@pacbell.net
  [PATCH] USB: usbtest checks for in-order completions
  
  This makes "test 10" verify that completions are returned in-order,
  resolving a FIXME.  OHCI and EHCI do, but UHCI doesn't. (*)  That
  simplified a cleanup of the queue fault tests to make it easier
  to handle optional faults (with one or more failure modes).
  
  It also returns a "lost subcase" that accidentally was not getting
  run.  And in a case of pure paranoia, the unlink tests handle the
  EBUSY return from an async urb unlink ... if that ever shows up I'd
  expect it to be on an SMP box.
  
  
  (*) I'd suspected as much given the first round of tests with UHCI;
       the diagnostics from "usbtest" made no sense otherwise.  This
       is just repeatable confirmation of the earlier bug report.  This
       could cause trouble in the usb_sg_*() I/O calls.
  
       In this case, "testusb -at10 -g4" reported that subcase 1 completed
       out of order (before subcase 0) ... without looking at details, I'd
       guess a list_add() vs list_add_tail() issue.
  
       Then after trying the queue cleanup code, I got diagnostics from
       uhci_destroy_urb_priv; then a kmalloc poisoning oops in uhci_irq,
       or "uhci_remove_pending_qhs+0x7c/0x1b0" in more detail.  Those
       looks to be the same "can't unlink from completions" errors that
       was also reported before in that code.
  
       Note that "testusb -at10" (like "testusb -at9") can be made to
       work with any USB device, using "usbtest" module options.

 drivers/usb/misc/usbtest.c |  134 +++++++++++++++++++++++++++------------------
 1 files changed, 82 insertions(+), 52 deletions(-)
------

ChangeSet@1.1002.3.3, 2003-02-20 10:17:46-08:00, david-b@pacbell.net
  [PATCH] USB: ohci-hcd fewer diagnostics
  
  This gets rid of some potentially scarey messages I've recently
  seen on disconnect, "bad hash" for a TD ... it's really a "no hash"
  case, and this prevents the message in some cases where that's
  not an issue.  Likely this is what Gary Gorgen noticed, but even
  he had a different problem, this message shouldn't always appear.
  
  It also slims down one other message, preventing it from appearing
  in the routine "protocol stall" case (and cluttering logfiles).

 drivers/usb/host/ohci-mem.c |    4 ++--
 drivers/usb/host/ohci-q.c   |   20 ++++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)
------

ChangeSet@1.1002.3.2, 2003-02-20 10:17:28-08:00, david-b@pacbell.net
  [PATCH] USB: ohci-hcd, more portable diagnostics
  
  This is the rest of the work to make the driver not care which
  version of the OS it's using, so the difference between the 2.5
  and 2.5 versions can just be a small patch with stuff that has
  a real need to be different.

 drivers/usb/host/ohci-dbg.c |   71 ++++++++++++++++++++++----------------------
 drivers/usb/host/ohci-hcd.c |   28 ++++++++---------
 drivers/usb/host/ohci-hub.c |    7 +---
 drivers/usb/host/ohci-mem.c |    2 -
 drivers/usb/host/ohci-pci.c |   29 +++++++++--------
 drivers/usb/host/ohci-q.c   |   12 ++-----
 6 files changed, 73 insertions(+), 76 deletions(-)
------

ChangeSet@1.1002.3.1, 2003-02-20 10:17:07-08:00, david-b@pacbell.net
  [PATCH] USB: sync with some 2.4 ohci fixes, prepare for backport
  
  The 2.5 version branched from 2.4.5 or so, and since then
  a couple hardware-specific tweaks were merged to 2.4; this
  teaches 2.5 about NatSemi SUPERIO and PA-RISC quirks.
  
  This also uses os/version neutral HCD calls to register the root
  hub and find the HCD's bus.  It also adds os/version neutral
  macros for its diagnostic macros.  Most of those changes have
  been split out separately, but the macros and a few uses of them
  weren't naturally splittable.
  
  Also a couple minor cleanups, like removing CVS ids, having
  only one copy of a routine used with the debug files, and
  getting rid of some inline #ifdefs.

Push file://home/greg/linux/BK/gregkh-2.5 -> file://home/greg/linux/BK/bleed-2.5
 drivers/usb/host/ohci-dbg.c    |   26 +++++++++++---------
 drivers/usb/host/ohci-hcd.c    |   53 +++++++++++++++++++++++++++--------------
 drivers/usb/host/ohci-hub.c    |    3 --
 drivers/usb/host/ohci-pci.c    |   44 ++++++++++++++++++++--------------
 drivers/usb/host/ohci-q.c      |   27 ++++++++------------
 drivers/usb/host/ohci-sa1111.c |   10 -------
 drivers/usb/host/ohci.h        |   23 +++++++++++++++++
 7 files changed, 112 insertions(+), 74 deletions(-)
------

