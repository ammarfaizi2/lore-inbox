Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267203AbSLRI34>; Wed, 18 Dec 2002 03:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267202AbSLRI34>; Wed, 18 Dec 2002 03:29:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:3344 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267206AbSLRI3v>;
	Wed, 18 Dec 2002 03:29:51 -0500
Date: Wed, 18 Dec 2002 00:35:15 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.52
Message-ID: <20021218083515.GB29391@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/core/hcd.c             |    5 
 drivers/usb/core/hub.c             |   61 +++++++----
 drivers/usb/core/inode.c           |    5 
 drivers/usb/host/ehci-dbg.c        |   37 ++++++-
 drivers/usb/host/ehci-hcd.c        |  161 +++++++++++++++----------------
 drivers/usb/host/ehci-hub.c        |    2 
 drivers/usb/host/ehci-mem.c        |    5 
 drivers/usb/host/ehci-q.c          |  189 ++++++++++++++++++-------------------
 drivers/usb/host/ehci-sched.c      |   26 +----
 drivers/usb/host/ehci.h            |    3 
 drivers/usb/media/ibmcam.c         |   14 +-
 drivers/usb/media/konicawc.c       |    2 
 drivers/usb/media/pwc-ctrl.c       |   12 +-
 drivers/usb/media/pwc-if.c         |    9 -
 drivers/usb/media/pwc-ioctl.h      |   13 ++
 drivers/usb/media/pwc-uncompress.h |    4 
 drivers/usb/media/pwc.h            |    4 
 drivers/usb/media/ultracam.c       |    2 
 drivers/usb/media/usbvideo.c       |   32 +++---
 drivers/usb/media/usbvideo.h       |   36 +++----
 drivers/usb/misc/speedtouch.c      |   45 ++++----
 drivers/usb/misc/usblcd.c          |    2 
 drivers/usb/net/usbnet.c           |  168 +++++++++++++++++---------------
 drivers/usb/serial/belkin_sa.c     |    1 
 drivers/usb/serial/bus.c           |    5 
 drivers/usb/serial/cyberjack.c     |    1 
 drivers/usb/serial/generic.c       |    1 
 drivers/usb/serial/io_tables.h     |    4 
 drivers/usb/serial/io_ti.c         |    2 
 drivers/usb/serial/keyspan.h       |    4 
 drivers/usb/serial/keyspan_pda.c   |    3 
 drivers/usb/serial/kl5kusb105.c    |    1 
 drivers/usb/serial/mct_u232.c      |    1 
 drivers/usb/serial/omninet.c       |    1 
 drivers/usb/serial/usb-serial.h    |    4 
 drivers/usb/serial/visor.c         |    2 
 drivers/usb/serial/whiteheat.c     |    4 
 drivers/usb/storage/transport.c    |   46 ++++-----
 drivers/usb/storage/usb.c          |   20 ++-
 39 files changed, 522 insertions(+), 415 deletions(-)
-----

ChangeSet@1.894, 2002-12-18 00:18:53-08:00, david-b@pacbell.net
  [PATCH] ehci, more small fixes
  
  - some access to urb->hcpriv and urb->status needed to be
     locked using urb->lock
  - paranoia: don't depend on two values being in lock-step.

 drivers/usb/host/ehci-q.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.893, 2002-12-18 00:12:02-08:00, greg@kroah.com
  [PATCH] USB: warn users that they should not be using the usbdevfs name.

 drivers/usb/core/inode.c |    5 +++++
 1 files changed, 5 insertions(+)
------

ChangeSet@1.883.3.16, 2002-12-17 22:38:44-08:00, greg@kroah.com
  [PATCH] USB: whiteheat: fix some gcc 3.2 warning messages

 drivers/usb/serial/whiteheat.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.883.3.15, 2002-12-17 22:22:16-08:00, david-b@pacbell.net
  [PATCH] hub driver uses dev_info(), less log clutter
  
  This patch converts most common hub diagnostics to use the
  device model diagnostic macros ... not all, someone should
  reduce the number of err() strings for "bogus hub" cases,
  and ideally streamline some of the dozen or so "here's what's
  special about this new hub" dbg() messages.
  
  So the messages become more useful:  they id the port (and
  implicitly the device) involved, using a kernel-wide standard
  convention.  Size overhead is smaller too.
  
  For folk running with USB debugging enabled, it also cuts
  the useless chatter on connections by deleting the per-poll
  success messages and a partial dup message when things change.
  And it deletes a newish diagnostic on a (non-hub) unlink path.
  
  It also makes Pete's new debounce message use the right
  port number -- one-based, not zero-based.
  
  My main issue with this patch is that it doesn't change
  more messages, but it seems reasonable to merge it anyway.

 drivers/usb/core/hcd.c |    5 +---
 drivers/usb/core/hub.c |   61 ++++++++++++++++++++++++++++---------------------
 2 files changed, 38 insertions(+), 28 deletions(-)
------

ChangeSet@1.883.3.14, 2002-12-17 21:57:17-08:00, oliver@neukum.name
  [PATCH] USB: proper error return for usblcd
  
  unknown ioctls return -ENOTTY and nothing else.

 drivers/usb/misc/usblcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.883.3.13, 2002-12-17 21:51:57-08:00, oliver@neukum.name
  [PATCH] USB: fix an unlinking race in speedtouch driver
  
  checking for -EINPROGRESS is wrong.

 drivers/usb/misc/speedtouch.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
------

ChangeSet@1.883.3.12, 2002-12-17 21:51:12-08:00, oliver@neukum.name
  [PATCH] USB: speedtouch: eliminate sleep_on

 drivers/usb/misc/speedtouch.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletion(-)
------

ChangeSet@1.883.3.11, 2002-12-17 21:49:24-08:00, oliver@neukum.name
  [PATCH] USB: clean kernel thread exit for speedtouch
  
  this makes sure that the kernel thread is dead and gone on module unload.
    - use a completion to wait for the kernel thread's death

 drivers/usb/misc/speedtouch.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)
------

ChangeSet@1.883.3.10, 2002-12-17 20:40:12-08:00, stern@rowland.harvard.edu
  [PATCH] USB: usb-storage bugfix
  
  Don't try to dereference the interrupt endpoint if it doesn't exist.

 drivers/usb/storage/usb.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)
------

ChangeSet@1.883.3.9, 2002-12-16 18:13:47-08:00, greg@kroah.com
  [PATCH] USB: usbserial: Add a short_name field to work better with sysfs.
  
  This cleans up the bus/usb-serial/drivers/ directory

 drivers/usb/serial/belkin_sa.c   |    1 +
 drivers/usb/serial/bus.c         |    5 ++++-
 drivers/usb/serial/cyberjack.c   |    1 +
 drivers/usb/serial/generic.c     |    1 +
 drivers/usb/serial/io_tables.h   |    4 ++++
 drivers/usb/serial/io_ti.c       |    2 ++
 drivers/usb/serial/keyspan.h     |    4 ++++
 drivers/usb/serial/keyspan_pda.c |    3 +++
 drivers/usb/serial/kl5kusb105.c  |    1 +
 drivers/usb/serial/mct_u232.c    |    1 +
 drivers/usb/serial/omninet.c     |    1 +
 drivers/usb/serial/usb-serial.h  |    4 ++++
 drivers/usb/serial/visor.c       |    2 ++
 drivers/usb/serial/whiteheat.c   |    2 ++
 14 files changed, 31 insertions(+), 1 deletion(-)
------

ChangeSet@1.883.3.8, 2002-12-16 16:35:58-08:00, oliver@oenone.homelinux.org
  [PATCH] USB: speedtouch driver memory allocation deadlock fix

 drivers/usb/misc/speedtouch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.883.3.7, 2002-12-16 10:49:56-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: fixup interpret_urb_result()
  
  This patch fixes interpret_urb_result in two major ways:
  (1) Uses a switch() instead of nested if() statements
  (2) Handle -EREMOTEIO to indicate a short scatter-gather transfer

 drivers/usb/storage/transport.c |   46 ++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 22 deletions(-)
------

ChangeSet@1.883.3.6, 2002-12-16 10:45:26-08:00, nemosoft@smcc.demon.nl
  [PATCH] USB: PWC 8.10 for 2.5.51
  
  Well, two patches in one... These patches will bring the PWC (Philips
  Webcam) driver in both 2.4.20 and 2.5.51 up to version 8.10. Functionally,
  the two branches are the same (about 70% of the code is shared), but the
  differences in kernel architecture are too large to handle with a few
  #ifdefs.
  
  This patch fixes the following (this are only the differences between 8.9
  and 8.10):
  
  * Fixed ID for QuickCam Notebook pro
  * Added GREALSIZE ioctl() call
  * Fixed bug in case PWCX was not loaded and invalid size was set

 drivers/usb/media/pwc-ctrl.c       |   12 ++++++++++--
 drivers/usb/media/pwc-if.c         |    9 ++++-----
 drivers/usb/media/pwc-ioctl.h      |   13 +++++++++++--
 drivers/usb/media/pwc-uncompress.h |    4 ++--
 drivers/usb/media/pwc.h            |    4 ++--
 5 files changed, 29 insertions(+), 13 deletions(-)
------

ChangeSet@1.883.3.5, 2002-12-16 10:35:48-08:00, spse@secret.org.uk
  [PATCH] 2.5.51 More typedef removal from usbvideo
  
  This patch against 2.5.51 removes the remaining typedefs from usbvideo
  
  typedef enum { .. } ScanState_t -> enum ScanState
  typedef enum { .. } ParseState_t -> enum ParseState
  typedef enum { .. } FrameState_t -> enum FrameState
  typedef enum { .. } Deinterlace_t -> enum Deinterlace
  typedef struct { .. } usbvideo_t -> struct usbvideo

 drivers/usb/media/ibmcam.c   |   14 +++++++-------
 drivers/usb/media/konicawc.c |    2 +-
 drivers/usb/media/ultracam.c |    2 +-
 drivers/usb/media/usbvideo.c |   32 ++++++++++++++++----------------
 drivers/usb/media/usbvideo.h |   36 ++++++++++++++++++------------------
 5 files changed, 43 insertions(+), 43 deletions(-)
------

ChangeSet@1.883.3.4, 2002-12-16 10:31:59-08:00, david-b@pacbell.net
  [PATCH] ehci misc patches
  
  small fixes flushed by the hunt for bigger game:
  
  - terminate td lists with dummy, not list end marker
  - use alt_next only for real short control reads
  - un-halt async qhs before scheduling
  - deletes unused debug code, pointless assignments
  - surely nobody ever sees that memleak
  - terminate two related "while" loops the same way

 drivers/usb/host/ehci-hcd.c |    2 +-
 drivers/usb/host/ehci-q.c   |   36 +++++++++++-------------------------
 2 files changed, 12 insertions(+), 26 deletions(-)
------

ChangeSet@1.883.3.3, 2002-12-16 10:31:41-08:00, david-b@pacbell.net
  [PATCH] usbnet:  zaurus, oops, etc
  
  This patch:
  
  - Removes Pavel's Zaurus-private crc32 code; the base patch
     was from Pavel.
  
  - Addresses two issues Toby Milne reported against the Zaurus:
     (a) if skbs had extra framing added (z, net1080, gl620a),
         the original size (now too small) was used on tx;
     (b) added FLAG_FRAMING_Z so rx packets had enough space
  
  - Removes an oops from the driver model conversion (saved
     the wrong pointer).  Disconnecting wasn't healthy.
  
  - Forward-ports some ethtool support from the 2.4 version:
     PDAs are always connected, so report them that way.
  
  - Stubs in some PXA-250 support for non-Zaurus PDAs.
     This is currently commented out; so far those PDAs
     only run Linux for bleeding edge developers.
  
  - Minor cleanups.

 drivers/usb/net/usbnet.c |  168 ++++++++++++++++++++++++-----------------------
 1 files changed, 89 insertions(+), 79 deletions(-)
------

ChangeSet@1.883.3.2, 2002-12-16 10:31:24-08:00, david-b@pacbell.net
  [PATCH] ehci-hcd (2/2): rest of tasklet remove
  
  This is the rest of the work to remove the tasklet: the non-syntax
  portions which affect work scheduling.  It's not quite davem's version;
  it's got locking updates, which among other things prevent a hang when
  the timer kicks in.
  
  This scheduling change is split out from the other parts in case more
  problems like that unlink race (fixed in my previous patch) show up.
  It doesn't fix (or help fix) any ehci bugs, but simpler code is fine.

 drivers/usb/host/ehci-hcd.c   |   56 +++++++++++++++++++++++-------------------
 drivers/usb/host/ehci-sched.c |    2 -
 drivers/usb/host/ehci.h       |    3 --
 3 files changed, 32 insertions(+), 29 deletions(-)
------

ChangeSet@1.883.3.1, 2002-12-16 10:31:05-08:00, david-b@pacbell.net
  [PATCH] ehci-hcd (1/2):  portability (2.4), tasklet,
  
  This should be innocuous; I expect most folk won't notice anything
  better (or worse) from this patch unless they're using Intel EHCI.
  
  removing tasklet
       - parts of davem's patch (passing pt_regs down)
       - remove 'max_completions'
       - update cleanup after hc died
       - fix an urb unlink oops (null ptr) that happens more often this way
  
  talking to hardware
       - fixes for some short read issues (may still be others)
  	* use qtd->hw_alt_next to stop qh processing after short reads
  	* detect/report short reads differently
       - longer reset timeout (it was excessively short, broke Intel)
  
  other
       - simpler diagnostics portability to 2.4:  wrap dev_err() etc
       - urb unlink wait and non-wait unlink codepaths share most code
       - don't try ehci_stop() in interrupt context (bug from hcd layer)
       - minor stuff, including
  	* some "after hc died" paths were wrong
  	* verbose debug messages compile again
  	* don't break error irq count

 drivers/usb/host/ehci-dbg.c   |   37 ++++++++--
 drivers/usb/host/ehci-hcd.c   |  103 +++++++++++++----------------
 drivers/usb/host/ehci-hub.c   |    2 
 drivers/usb/host/ehci-mem.c   |    5 +
 drivers/usb/host/ehci-q.c     |  147 ++++++++++++++++++++++--------------------
 drivers/usb/host/ehci-sched.c |   24 ++----
 6 files changed, 173 insertions(+), 145 deletions(-)
------

