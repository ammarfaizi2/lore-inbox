Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265400AbSKFAgt>; Tue, 5 Nov 2002 19:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265421AbSKFAgt>; Tue, 5 Nov 2002 19:36:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:65295 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265400AbSKFAgp>;
	Tue, 5 Nov 2002 19:36:45 -0500
Date: Tue, 5 Nov 2002 16:39:25 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.46
Message-ID: <20021106003925.GA18627@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/net/irda/irda-usb.c         |    2 
 drivers/usb/class/Kconfig           |    2 
 drivers/usb/core/devio.c            |    6 
 drivers/usb/core/hcd.h              |    1 
 drivers/usb/host/ohci-dbg.c         |   17 +-
 drivers/usb/host/ohci-pci.c         |   11 +
 drivers/usb/host/ohci-q.c           |    6 
 drivers/usb/host/ohci-sa1111.c      |   10 +
 drivers/usb/host/ohci.h             |    1 
 drivers/usb/image/scanner.c         |    4 
 drivers/usb/image/scanner.h         |    8 -
 drivers/usb/media/vicam.c           |   40 +-----
 drivers/usb/misc/Kconfig            |    7 -
 drivers/usb/misc/usbtest.c          |   37 +++--
 drivers/usb/serial/visor.c          |    2 
 drivers/usb/serial/visor.h          |    1 
 drivers/usb/storage/datafab.c       |    1 
 drivers/usb/storage/freecom.c       |   27 ++--
 drivers/usb/storage/isd200.c        |  236 +++++++-----------------------------
 drivers/usb/storage/jumpshot.c      |    1 
 drivers/usb/storage/sddr09.c        |    1 
 drivers/usb/storage/sddr55.c        |    1 
 drivers/usb/storage/shuttle_usbat.c |    4 
 drivers/usb/storage/transport.c     |   71 ++--------
 sound/usb/usbaudio.c                |    2 
 25 files changed, 177 insertions(+), 322 deletions(-)
------

ChangeSet@1.855.9.15, 2002-11-05 14:59:36-08:00, ch@hpl.hp.com
  [PATCH] [PATCH] 2.5.44 sa-1111 ohci hcd
  
  Dereferencing hcd.pdev will always oops with SA-1111.  It has to be
  treated as a cookie, not a pointer in any common OHCI HCD code.
  
  Apparently we need a clean way to go from struct device * to struct
  ohci_hcd *.  I added dev_to_ohci that does the obvious thing and added
  separate implementations for PCI and SA-1111.  Two implementations is
  ugly but I didn't think it wise (for me) to hack on the PCI/driverfs
  interface, so I just cut & paste the old code.
  
  Two patches.  The first is a diff from linux-2.5.44 and
  linux-2.5.44-rmk1.  It is from rmk and adds a struct device pointer to
  ohci_hcd.  The second depends on the first and contains my changes to
  clean up to the pdev oops problems.  (Some fuzz may occur as I have
  ohci-1024 applied.)
  
  With these changes, SA111 OHCI-HC/HCD is showing some signs of life on
  linux-2.5.44-rmk1.  usb-storage is currentl blowing chunks, but I think
  I saw some patches go by against 2.5.44 that I haven't yet tried.

 drivers/usb/core/hcd.h         |    1 +
 drivers/usb/host/ohci-dbg.c    |   17 +++++++----------
 drivers/usb/host/ohci-pci.c    |   11 +++++++++++
 drivers/usb/host/ohci-sa1111.c |   10 +++++++++-
 drivers/usb/host/ohci.h        |    1 +
 5 files changed, 29 insertions(+), 11 deletions(-)
------

ChangeSet@1.855.9.14, 2002-11-05 11:21:58-08:00, randy.dunlap@verizon.net
  [PATCH] usb-midi requires SOUND
  
  usb-midi requires SOUND, otherwise, when built in-kernel but soundcore
  is modular, usb-midi can't resolve some sound interfaces.

 drivers/usb/class/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.855.9.13, 2002-11-05 11:17:41-08:00, stern@rowland.harvard.edu
  [PATCH] USB storage: use the new transfer_buf() routine
  
  This patch switches from using usb_stor_bulk_msg() to
  usb_stor_bulk_transfer_buf(), which includes a great deal more logic.  This
  allows for elimination of all sorts of duplicate code (clearing STALLs,
  etc.).
  
  This also eliminates the (now) redundant functions from the ISD-200 driver.

 drivers/usb/storage/isd200.c    |  209 +++++-----------------------------------
 drivers/usb/storage/transport.c |   64 ++----------
 2 files changed, 39 insertions(+), 234 deletions(-)
------

ChangeSet@1.855.9.12, 2002-11-05 11:17:27-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: check for abort at higher levels
  
  This patch adds tests for an aborted command to higher-level functions.
  This allows faster exit from a couple of paths and will allow code
  consolidation in the lower-level transport functions.

 drivers/usb/storage/isd200.c    |   20 ++++++++++++++++++--
 drivers/usb/storage/transport.c |    6 ++++--
 2 files changed, 22 insertions(+), 4 deletions(-)
------

ChangeSet@1.855.9.11, 2002-11-05 11:17:12-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: fix result code checks
  
  This patch fixes up some result-code tests that were missed in previous
  patches.

 drivers/usb/storage/freecom.c       |   27 +++++++++++++++++----------
 drivers/usb/storage/isd200.c        |    6 +++++-
 drivers/usb/storage/shuttle_usbat.c |    3 ++-
 3 files changed, 24 insertions(+), 12 deletions(-)
------

ChangeSet@1.855.9.10, 2002-11-05 11:16:58-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: move init of residue to a central place
  
  This patch moves the initialization of the SCSI residue field to be in
  just a couple of places, instead of all over the map.  It's code
  consolidation.

 drivers/usb/storage/datafab.c       |    1 -
 drivers/usb/storage/isd200.c        |    1 +
 drivers/usb/storage/jumpshot.c      |    1 -
 drivers/usb/storage/sddr09.c        |    1 -
 drivers/usb/storage/sddr55.c        |    1 -
 drivers/usb/storage/shuttle_usbat.c |    1 -
 drivers/usb/storage/transport.c     |    1 +
 7 files changed, 2 insertions(+), 5 deletions(-)
------

ChangeSet@1.855.9.9, 2002-11-05 11:08:14-08:00, david-b@pacbell.net
  [PATCH] ohci-hcd, remove oops and...
  
  Two changes, one big one not:
  
  - check before traversing a null pointer, removing oops
  
  - always do bandwidth checks, no point in allowing overcommit
  
  That oops possibility has been there for a bit over two months,
  but something changed recently which made me see it.   Maybe
  sme other folk have seen this one too (in ed_deschedule).

 drivers/usb/host/ohci-q.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.855.9.8, 2002-11-05 11:07:55-08:00, david-b@pacbell.net
  [PATCH] usbtest, Kconfig and misc
  
  Minor patches:
  
  - resend of the Config.in patch, updated to Kconfig,
     plus makes 'usbtest' modular when usb is;
  
  - hmm, "usbfs" isn't locking here.  protect.  fix
     is basically from martin:  add/use a semaphore.
  
  - that one-liner to make sure get_configuration is
     called correctly (with funkier test firmware).
  
  - new 'realworld' module param can be used to turn
     off the real-world accomodations and be stricter
     about what device failures make ch9 tests fail.

 drivers/usb/misc/Kconfig   |    5 ++++-
 drivers/usb/misc/usbtest.c |   37 ++++++++++++++++++++++++-------------
 2 files changed, 28 insertions(+), 14 deletions(-)
------

ChangeSet@1.855.9.7, 2002-11-04 14:57:26-08:00, erik@aarg.net
  [PATCH] USB: added support for Palm Tungsten T devices to visor driver
  

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.855.9.6, 2002-10-31 23:43:47-08:00, jtyner@cs.ucr.edu
  [PATCH] USB vicam.c: minor fixes
  
  This patch fixes some things that have failed to go in as part of other
  patches that have been rejected. Namely, this adds the forgotten up call
  in the read function, removes the usb_put_dev (since there is no
  usb_get_dev), and also moves the allocation and freeing of the image and
  frame buffers to the open and close calls only.

 drivers/usb/media/vicam.c |   40 ++++++++++++----------------------------
 1 files changed, 12 insertions(+), 28 deletions(-)
------

ChangeSet@1.855.9.5, 2002-10-31 19:01:51-08:00, ddstreet@ieee.org
  [PATCH] [patch] set interrupt interval in usbfs
  
  This patch sets up the URB interval correctly when using interrupts via
  usbfs.  This is finally possible since the automagic resubmission is gone.

 drivers/usb/core/devio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)
------

ChangeSet@1.855.9.4, 2002-10-31 18:23:43-08:00, greg@kroah.com
  [PATCH] USB: audio fix up for missed debug code.

 sound/usb/usbaudio.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.855.9.3, 2002-10-31 17:21:07-08:00, dhollis@davehollis.com
  [PATCH] 2.5.45 drivers/net/irda/irda-usb.c Compile Fix
  
  Fixes an apparent typo in irda-usb.c that prevented it from compiling.

 drivers/net/irda/irda-usb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.855.9.2, 2002-10-31 17:20:51-08:00, baldrick@wanadoo.fr
  [PATCH] USB: fix typo
  

 drivers/usb/misc/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.855.9.1, 2002-10-31 17:20:30-08:00, greg@kroah.com
  [PATCH] USB: scanner fixes due to changes to USB structures.
  

 drivers/usb/image/scanner.c |    4 ++--
 drivers/usb/image/scanner.h |    8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)
------
