Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265393AbSJRVlq>; Fri, 18 Oct 2002 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265402AbSJRVlq>; Fri, 18 Oct 2002 17:41:46 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47633 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265393AbSJRVla>;
	Fri, 18 Oct 2002 17:41:30 -0400
Date: Fri, 18 Oct 2002 14:46:58 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.43
Message-ID: <20021018214658.GA10404@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This series has a bunch of merges as I tried to find the problems the
driver model core caused.  It also has a update for the char tipar
driver.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/tipar.txt         |   93 ++++++
 drivers/base/core.c             |  329 +++++++-----------------
 drivers/char/tipar.c            |    2 
 drivers/media/video/cpia.h      |    4 
 drivers/usb/core/devio.c        |    2 
 drivers/usb/core/message.c      |    2 
 drivers/usb/core/usb.c          |    4 
 drivers/usb/host/uhci-debug.c   |  246 ++++++++++--------
 drivers/usb/host/uhci-hcd.c     |  535 +++++++++++++++++++---------------------
 drivers/usb/host/uhci-hcd.h     |  166 +++++-------
 drivers/usb/input/Config.help   |    6 
 drivers/usb/input/Config.in     |    7 
 drivers/usb/misc/usbtest.c      |   23 +
 drivers/usb/net/pegasus.h       |    3 
 drivers/usb/storage/transport.c |   26 +
 15 files changed, 721 insertions(+), 727 deletions(-)
-----

ChangeSet@1.798.4.5, 2002-10-18 14:18:29-07:00, rlievin@free.fr
  [PATCH] char tipar driver minor update
  
  you will find a patch for the tipar char driver.
  This patch fixes some typos and add a documentation entry.

 Documentation/tipar.txt |   93 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/char/tipar.c    |    2 -
 2 files changed, 93 insertions(+), 2 deletions(-)
------

ChangeSet@1.798.4.4, 2002-10-18 14:18:15-07:00, rddunlap@osdl.org
  [PATCH] cpia fix for older compilers
  

 drivers/media/video/cpia.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.793.1.19, 2002-10-18 11:35:15-07:00, greg@kroah.com
  USB: fix problem with removing a USB root hub.

 drivers/usb/core/usb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.793.1.18, 2002-10-18 10:13:22-07:00, greg@kroah.com
  driver core: fix up merge mess

 drivers/base/core.c |   40 ----------------------------------------
 1 files changed, 40 deletions(-)
------

ChangeSet@1.793.1.17, 2002-10-18 10:00:13-07:00, greg@kroah.com
  merge between the usb and driver model trees.

 drivers/base/core.c |  259 +++++++++++++++++-----------------------------------
 1 files changed, 87 insertions(+), 172 deletions(-)
------

ChangeSet@1.781.21.17, 2002-10-18 09:34:20-07:00, ddstreet@ieee.org
  [PATCH] uhci interrupt resubmit fixes
  
  After the interrupt queueing was added, I don't think the old way of
  resetting interrupts will work anymore.  This patch changes it to simply
  do a full unlink and resubmission automatically.  Note that since
  usb_hcd_giveback_urb() is never called for a resubmitting interrupt URB,
  that means whatever gets released in usb_hcd_giveback_urb() won't get
  released for that URB.  The only way to work around that is call
  usb_hcd_giveback_urb after the user unlinks in their completion handler,
  which will call the completion handler again with -ECONNRESET
  status...which wouldn't be all that bad, but the drivers have to expect
  it.
  
  Hopefully the interrupt resubmission will go away soon...

 drivers/usb/host/uhci-hcd.c |   68 ++++++++++++++++++--------------------------
 1 files changed, 29 insertions(+), 39 deletions(-)
------

ChangeSet@1.781.21.16, 2002-10-18 00:05:29-07:00, david-b@pacbell.net
  [PATCH] one liner, anti-oops
  
  This fixes a potential oops (depending on how the HCD handles it)
  from a recent patch of mine.  Evidently I didn't test this bit a
  device that'd show the problem, sigh.  Luckily Martin Diehl was
  testing and found this.

 drivers/usb/core/message.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.781.21.15, 2002-10-17 23:38:08-07:00, acme@conectiva.com.br
  [PATCH] Add support for JTEC FA8101 USB to Ethernet device
  
    o Add support for JTEC FA8101 USB to Ethernet device

 drivers/usb/net/pegasus.h |    3 +++
 1 files changed, 3 insertions(+)
------

ChangeSet@1.781.21.14, 2002-10-17 23:37:50-07:00, ddstreet@ieee.org
  [PATCH] change devio-disconnect no-driver error code
  
  The talk about disconnect locking reminded me of this - the error code in
  the no-driver case for the disconnect ioctl isn't a unique error code.
  This changes the error code to what getdriver() uses, -ENODATA.

 drivers/usb/core/devio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.781.21.13, 2002-10-17 23:37:35-07:00, david-b@pacbell.net
  [PATCH] LDM and driver binding
  
  Here's a more complete patch for that driver binding problem.
  Now (a) when scanning for a driver to handle a new device,
  scanning stops after the first successful probe not the
  first successful match; and (b) new drivers get every chance to
  bind to additional devices, even after the first one succeeds.
  
  Please merge.  This will help resolve some of the USB flakies
  in recent kernels.  Note that (a) was noticed independently by
  me and Andries Brouwer, and AFAIK this is the first patch to
  also fix failure (b) which was uncovered by fixing (a).

 drivers/base/core.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)
------

ChangeSet@1.781.39.1, 2002-10-17 23:21:37-07:00, greg@kroah.com
  Cset exclude: david-b@pacbell.net|ChangeSet|20021015071026|11647

 drivers/base/core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)
------

ChangeSet@1.781.21.11, 2002-10-17 17:16:04-07:00, lists@mdiehl.de
  [PATCH] usbtest updates
  
  Various small fixes and adds ids for new test firmware.

 drivers/usb/misc/usbtest.c |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)
------

ChangeSet@1.781.21.10, 2002-10-15 15:28:49-07:00, ddstreet@ieee.org
  [PATCH] uhci: remove qh from qh->list
  
  I think the qh needs to be removed from its qh->list, or else
  uhci_remove_qh will incorrectly change the previous endpoint's qh->link,
  undoing what was just done in uhci_delete_queued_urb.

 drivers/usb/host/uhci-hcd.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.781.21.9, 2002-10-15 15:28:23-07:00, ddstreet@ieee.org
  [PATCH] uhci: slight docs update
  
  Slight change - the int qh order is actually opposite of the example.

 drivers/usb/host/uhci-hcd.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.781.21.8, 2002-10-15 10:58:03-07:00, johannes@erdfelt.com
  [PATCH] 2.5 uhci control and interrupt queuing
  
  This is 95% Dan's patch, but I made some small changes. The changes I've
  made relative to Dan's patch is:
  
  Drop concept of skeleton TD. After Dan's patch, this was reduced to one
  entry in the form of skel_term_td. That wasn't even a skeleton TD in the
  first place. This simplifies the code a little bit.
  Minor formatting tweaks.
  Pass on USB bandwidth changes for now.
  Pass on Interrupt auto-resubmit changes for now.
  Use complete_list_lock, not complete_list as the lock.
  Use frame_list_lock, not fame_list_lock.
  Reorganize skeleton QH's to match the order in the schedule. This cleaned
  up some debugging code and made the list more logical.
  Update some obsolete documentation.
  Pass on code to check for race conditions and fix up. It was racy as well.
  
  Dan, do you compile with SMP? Those two locking typos would have
  generated a warning and/or error.
  
  I've done some light testing and haven't found any problems yet. I
  haven't tested the control or interrupt queuing for lack of anything to
  test with yet.
  
  Anyway, please apply.
  
     Merge in Dan's patch to add interrupt and control queuing support. Summary of changes:
     Add queuing support for Interrupt and Control message in addition to Bulk.
     This resulted in some merging of code.
     Fix a queuing bug when moving a child into the parent position.
     Update documentation.
     Update debugging code.

 drivers/usb/host/uhci-debug.c |  246 +++++++++++++----------
 drivers/usb/host/uhci-hcd.c   |  441 ++++++++++++++++++++----------------------
 drivers/usb/host/uhci-hcd.h   |  158 ++++++---------
 3 files changed, 422 insertions(+), 423 deletions(-)
------

ChangeSet@1.781.21.7, 2002-10-15 10:48:33-07:00, johannes@erdfelt.com
  [PATCH] 2.5 uhci breadth first traversal for low speed
  
  Woops, my fault. I forgot to send you this patch which needs to be
  applied before the big one.
  
  It's from Dan as well and switches low speed control to use breadth
  first traversal to make it more fair.
  
    Don't make low speed control use depth first. That isn't
    particularly fair. Thanks to Dan Streetman for bringing
    this up and the original patch.

 drivers/usb/host/uhci-hcd.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.781.21.6, 2002-10-15 00:31:12-07:00, johannes@erdfelt.com
  [PATCH] 2.5 uhci proc path
  
  This is a patchlet that updates a comment to use the correct path to the
  proc debugging file.

 drivers/usb/host/uhci-hcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.781.21.5, 2002-10-15 00:11:55-07:00, randy.dunlap@verizon.net
  [PATCH] 2.5.42 HID-BP menu
  
  HID-BP confuses people, we know that.
  I don't want to see the HID-BP drivers removed,
  but I think it would be a good idea to make them more
  difficult to enable, unless someone knows what they
  are looking for.  (Basically it would reduce support
  incidents a lot.)
  
  The second way puts HID-BP in its own sub-menu and
  updates the Help file.  I think that this is the better
  choice, so unless there is a great hue and cry,
  please apply the "hidbpmenu-2542.patch" file.

 drivers/usb/input/Config.help |    6 ++++--
 drivers/usb/input/Config.in   |    7 +++++--
 2 files changed, 9 insertions(+), 4 deletions(-)
------

ChangeSet@1.781.21.4, 2002-10-15 00:11:37-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] Fixes to CB/CBI and compilation problems...
  
  This patch:
  	(a) updates some comments
  	(b) adds some debugging
  	(c) fixes CB and CBI data stages
  	(d) adds some missing {'s and }'s -- only dumb luck let the old
  	version compile.

 drivers/usb/storage/transport.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)
------

ChangeSet@1.781.21.3, 2002-10-15 00:11:13-07:00, johannes@erdfelt.com
  [PATCH] 2.5 uhci remove urb from lists on error
  
  I'm applying Dan's patches by hand to double check everything and I
  wanted to get a couple of the trivial ones out of the way first.
  
  This patch fixes a bug where errors on the submit path wouldn't remove
  URB's from the HC linked list.
  
    If we fail adding the URB to the schedule, we need to make
    sure that we remove it from the urb_list. Thanks to
    Dan Streetman for finding and fixing this bug.

 drivers/usb/host/uhci-hcd.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)
------

ChangeSet@1.781.21.2, 2002-10-15 00:10:53-07:00, johannes@erdfelt.com
  [PATCH] 2.5 uhci remove correct proc directory
  
  This patch fixes a typo in the names used to remove the proc directory
  that uhci uses.
  
  The longer term fix of splitting out (or dropping outright) the
  debugging code will come soon after the important bugs and features are
  merged.

 drivers/usb/host/uhci-hcd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.781.21.1, 2002-10-15 00:10:26-07:00, david-b@pacbell.net
  [PATCH] found_match return value incorrect.
  
  > I've seen several cases where 'usbtest' would look at the device
  > and say "no thanks", but then the "right" driver wouldn't ever
  > bind to the device.
  
  This patch seems to fix it.  I think Linus' tree needs it,
  or something like it.
  
  (Since the probe routine returns zero on success, there
  was confusion inside the driver model code where it assumed
  that zero meant failure.)

 drivers/base/core.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)
------

