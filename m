Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263170AbSIPWTA>; Mon, 16 Sep 2002 18:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbSIPWTA>; Mon, 16 Sep 2002 18:19:00 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:20488 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263170AbSIPWSy>;
	Mon, 16 Sep 2002 18:18:54 -0400
Date: Mon, 16 Sep 2002 15:19:30 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.35
Message-ID: <20020916221929.GA15790@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set of patches includes some usb-storage changes from Matt Dharm
(yes, he touched that show_trace() line), a ov511 update, and the very
large struct device_driver model change for the USB code from me, which
was based on some earlier work from Pat Mochel  There are also two small
patches to the driver core code, one adds some helper functions, and the
other fixes a oops when USB devices are removed.  Both of them were
blessed by Pat.

I broke down the USB changes by subdirectories to make it a bit smaller,
but it is still a large set of changes, as every USB device driver had
to be modified.  I choose to force the drivers to be modified by
changing the probe() and disconnect() callbacks to be based on
usb_interface instead of usb_device which is a more correct model of
what a USB driver is bound to (drivers have always been bound to USB
interfaces, but the core kind of glossed over this in the past.)

I still think a bit of work needs to be done in the portion of the usbfs
code that deals with disconnecting and connecting drivers to devices,
and in the usb-storage code where a forced disconnect happens, but the
code is working fine for me, and I'm getting tired of lugging this large
diff around :)  Patches for this section of code greatly appreciated.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/ov511.txt                |   35 -
 Documentation/usb/usb-serial.txt           |    4 
 drivers/base/core.c                        |    3 
 drivers/bluetooth/hci_usb.c                |   22 -
 drivers/input/joystick/iforce/iforce-usb.c |   29 -
 drivers/isdn/hisax/st5481_init.c           |   27 -
 drivers/media/video/cpia_usb.c             |   31 +
 drivers/usb/class/audio.c                  |   41 +-
 drivers/usb/class/bluetty.c                |   31 -
 drivers/usb/class/cdc-acm.c                |   30 -
 drivers/usb/class/usb-midi.c               |   37 +
 drivers/usb/class/usblp.c                  |   20 -
 drivers/usb/core/devices.c                 |    1 
 drivers/usb/core/devio.c                   |   61 ---
 drivers/usb/core/hcd.c                     |    8 
 drivers/usb/core/hcd.h                     |    8 
 drivers/usb/core/hub.c                     |  160 +++-----
 drivers/usb/core/hub.h                     |    2 
 drivers/usb/core/usb.c                     |  567 ++++++++---------------------
 drivers/usb/image/hpusbscsi.c              |   29 -
 drivers/usb/image/mdc800.c                 |   51 +-
 drivers/usb/image/microtek.c               |   45 +-
 drivers/usb/image/microtek.h               |    2 
 drivers/usb/image/scanner.c                |  102 ++---
 drivers/usb/input/aiptek.c                 |   62 +--
 drivers/usb/input/hid-core.c               |   36 +
 drivers/usb/input/hiddev.c                 |    6 
 drivers/usb/input/powermate.c              |   50 +-
 drivers/usb/input/usbkbd.c                 |   42 +-
 drivers/usb/input/usbmouse.c               |   56 +-
 drivers/usb/input/wacom.c                  |   33 +
 drivers/usb/input/xpad.c                   |   31 -
 drivers/usb/media/dabusb.c                 |   41 +-
 drivers/usb/media/dsbr100.c                |   37 +
 drivers/usb/media/ibmcam.c                 |   39 +
 drivers/usb/media/konicawc.c               |   45 +-
 drivers/usb/media/ov511.c                  |  205 ++++++----
 drivers/usb/media/ov511.h                  |   18 
 drivers/usb/media/pwc-if.c                 |   43 +-
 drivers/usb/media/se401.c                  |   60 +--
 drivers/usb/media/stv680.c                 |   36 +
 drivers/usb/media/ultracam.c               |   45 +-
 drivers/usb/media/usbvideo.c               |   15 
 drivers/usb/media/usbvideo.h               |    4 
 drivers/usb/media/vicam.c                  |   51 +-
 drivers/usb/misc/auerswald.c               |   28 -
 drivers/usb/misc/brlvger.c                 |   26 -
 drivers/usb/misc/emi26.c                   |   12 
 drivers/usb/misc/rio500.c                  |   51 +-
 drivers/usb/misc/speedtouch.c              |   69 +--
 drivers/usb/misc/tiglusb.c                 |   31 -
 drivers/usb/misc/usblcd.c                  |   47 +-
 drivers/usb/misc/uss720.c                  |   42 +-
 drivers/usb/net/catc.c                     |   42 +-
 drivers/usb/net/cdc-ether.c                |   32 +
 drivers/usb/net/kaweth.c                   |   56 +-
 drivers/usb/net/pegasus.c                  |   26 -
 drivers/usb/net/rtl8150.c                  |   53 +-
 drivers/usb/net/usbnet.c                   |   51 +-
 drivers/usb/serial/belkin_sa.c             |    9 
 drivers/usb/serial/cyberjack.c             |    9 
 drivers/usb/serial/digi_acceleport.c       |   12 
 drivers/usb/serial/empeg.c                 |   15 
 drivers/usb/serial/ftdi_sio.c              |   11 
 drivers/usb/serial/io_edgeport.c           |    8 
 drivers/usb/serial/io_tables.h             |    2 
 drivers/usb/serial/io_ti.c                 |   11 
 drivers/usb/serial/ipaq.c                  |   10 
 drivers/usb/serial/ir-usb.c                |    9 
 drivers/usb/serial/keyspan.c               |    2 
 drivers/usb/serial/keyspan.h               |    9 
 drivers/usb/serial/keyspan_pda.c           |   11 
 drivers/usb/serial/kl5kusb105.c            |    8 
 drivers/usb/serial/mct_u232.c              |    8 
 drivers/usb/serial/omninet.c               |    9 
 drivers/usb/serial/pl2303.c                |    8 
 drivers/usb/serial/safe_serial.c           |    9 
 drivers/usb/serial/usb-serial.h            |    3 
 drivers/usb/serial/usbserial.c             |   72 +--
 drivers/usb/serial/visor.c                 |   11 
 drivers/usb/serial/whiteheat.c             |   11 
 drivers/usb/storage/debug.c                |    2 
 drivers/usb/storage/debug.h                |    2 
 drivers/usb/storage/freecom.c              |    4 
 drivers/usb/storage/isd200.c               |   51 --
 drivers/usb/storage/protocol.c             |    2 
 drivers/usb/storage/raw_bulk.c             |   16 
 drivers/usb/storage/scsiglue.c             |   29 -
 drivers/usb/storage/sddr09.c               |   35 -
 drivers/usb/storage/shuttle_usbat.c        |    9 
 drivers/usb/storage/transport.c            |   93 +---
 drivers/usb/storage/usb.c                  |   42 +-
 drivers/usb/storage/usb.h                  |    5 
 include/linux/device.h                     |   12 
 include/linux/usb.h                        |   41 --
 95 files changed, 1780 insertions(+), 1687 deletions(-)
-----

ChangeSet@1.587, 2002-09-16 14:45:30-07:00, greg@kroah.com
  USB: convert the USB drivers that live outside of drivers/usb to the new USB driver model.

 drivers/bluetooth/hci_usb.c                |   22 ++++++++++++--------
 drivers/input/joystick/iforce/iforce-usb.c |   29 +++++++++++++++------------
 drivers/isdn/hisax/st5481_init.c           |   27 ++++++++++++++-----------
 drivers/media/video/cpia_usb.c             |   31 ++++++++++++++++++-----------
 4 files changed, 66 insertions(+), 43 deletions(-)
------

ChangeSet@1.586, 2002-09-16 14:44:48-07:00, greg@kroah.com
  USB: convert the drivers/usb/storage files to the new USB driver model.

 drivers/usb/storage/scsiglue.c |    8 ++------
 drivers/usb/storage/usb.c      |   34 +++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 21 deletions(-)
------

ChangeSet@1.585, 2002-09-16 14:42:29-07:00, greg@kroah.com
  USB: convert the drivers/usb/net files to the new USB driver model.
  
  Note the cdc-ether.c driver does NOT work properly now, someone who 
  understands the interface mess in that driver needs to fix it up.

 drivers/usb/net/catc.c      |   42 ++++++++++++++++++---------------
 drivers/usb/net/cdc-ether.c |   32 ++++++++++++++++---------
 drivers/usb/net/kaweth.c    |   56 ++++++++++++++++++++++----------------------
 drivers/usb/net/pegasus.c   |   26 ++++++++++++--------
 drivers/usb/net/rtl8150.c   |   53 ++++++++++++++++++++++-------------------
 drivers/usb/net/usbnet.c    |   51 ++++++++++++++++++++--------------------
 6 files changed, 145 insertions(+), 115 deletions(-)
------

ChangeSet@1.584, 2002-09-16 14:40:36-07:00, greg@kroah.com
  USB: convert the drivers/usb/misc files to the new USB driver model.

 drivers/usb/misc/auerswald.c  |   28 ++++++++++-------
 drivers/usb/misc/brlvger.c    |   26 +++++++++------
 drivers/usb/misc/emi26.c      |   12 ++++---
 drivers/usb/misc/rio500.c     |   51 +++++++++++++++++--------------
 drivers/usb/misc/speedtouch.c |   69 +++++++++++++++++++++++-------------------
 drivers/usb/misc/tiglusb.c    |   31 ++++++++++--------
 drivers/usb/misc/usblcd.c     |   47 +++++++++++++++-------------
 drivers/usb/misc/uss720.c     |   42 ++++++++++++++-----------
 8 files changed, 175 insertions(+), 131 deletions(-)
------

ChangeSet@1.583, 2002-09-16 14:37:15-07:00, greg@kroah.com
  USB: convert the drivers/usb/media files to the new USB driver model.

 drivers/usb/media/dabusb.c   |   41 ++++++++++++++++-------------
 drivers/usb/media/dsbr100.c  |   37 ++++++++++++++------------
 drivers/usb/media/ibmcam.c   |   39 +++++++++++++++------------
 drivers/usb/media/konicawc.c |   45 +++++++++++++++++++-------------
 drivers/usb/media/ov511.c    |   26 +++++++++++-------
 drivers/usb/media/pwc-if.c   |   43 ++++++++++++++++--------------
 drivers/usb/media/se401.c    |   60 ++++++++++++++++++++++---------------------
 drivers/usb/media/stv680.c   |   36 +++++++++++++++----------
 drivers/usb/media/ultracam.c |   45 +++++++++++++++++++-------------
 drivers/usb/media/usbvideo.c |   15 ++++++----
 drivers/usb/media/usbvideo.h |    4 +-
 drivers/usb/media/vicam.c    |   51 ++++++++++++++++++++----------------
 12 files changed, 249 insertions(+), 193 deletions(-)
------

ChangeSet@1.582, 2002-09-16 14:36:29-07:00, greg@kroah.com
  USB: convert the drivers/usb/input files to the new USB driver model.

 drivers/usb/input/aiptek.c    |   62 +++++++++++++++++++++++-------------------
 drivers/usb/input/hid-core.c  |   36 ++++++++++++++----------
 drivers/usb/input/hiddev.c    |    6 ++--
 drivers/usb/input/powermate.c |   50 +++++++++++++++++++--------------
 drivers/usb/input/usbkbd.c    |   42 ++++++++++++++++------------
 drivers/usb/input/usbmouse.c  |   56 +++++++++++++++++++++----------------
 drivers/usb/input/wacom.c     |   33 +++++++++++++---------
 drivers/usb/input/xpad.c      |   31 ++++++++++++---------
 8 files changed, 181 insertions(+), 135 deletions(-)
------

ChangeSet@1.581, 2002-09-16 14:35:48-07:00, greg@kroah.com
  USB: convert the drivers/usb/image files to the new USB driver model.

 drivers/usb/image/hpusbscsi.c |   29 +++++++----
 drivers/usb/image/mdc800.c    |   51 +++++++++++----------
 drivers/usb/image/microtek.c  |   45 +++++++++---------
 drivers/usb/image/microtek.h  |    2 
 drivers/usb/image/scanner.c   |  102 +++++++++++++++++++++++-------------------
 5 files changed, 125 insertions(+), 104 deletions(-)
------

ChangeSet@1.580, 2002-09-16 14:34:49-07:00, greg@kroah.com
  USB: convert the drivers/usb/class files to the new USB driver model.

 drivers/usb/class/audio.c    |   41 ++++++++++++++++++++++++++---------------
 drivers/usb/class/bluetty.c  |   31 +++++++++++++++++--------------
 drivers/usb/class/cdc-acm.c  |   30 ++++++++++++++++++------------
 drivers/usb/class/usb-midi.c |   37 ++++++++++++++++++++++++-------------
 drivers/usb/class/usblp.c    |   20 ++++++++++++--------
 5 files changed, 97 insertions(+), 62 deletions(-)
------

ChangeSet@1.579, 2002-09-16 14:34:00-07:00, greg@kroah.com
  USB: convert usb-serial drivers to new driver model.
  
  This adds the requirement that the usb-serial drivers call 
  usb_register() and usb_unregister() themselves, instead of having
  the usbserial.c file do it.  Step one in moving the usbserial.c 
  code to being a "class"  :)

 drivers/usb/serial/belkin_sa.c       |    9 ++++
 drivers/usb/serial/cyberjack.c       |    9 ++++
 drivers/usb/serial/digi_acceleport.c |   12 +++++
 drivers/usb/serial/empeg.c           |   15 +++++--
 drivers/usb/serial/ftdi_sio.c        |   11 ++++-
 drivers/usb/serial/io_edgeport.c     |    8 +++
 drivers/usb/serial/io_tables.h       |    2 
 drivers/usb/serial/io_ti.c           |   11 ++++-
 drivers/usb/serial/ipaq.c            |   10 ++++
 drivers/usb/serial/ir-usb.c          |    9 ++++
 drivers/usb/serial/keyspan.c         |    2 
 drivers/usb/serial/keyspan.h         |    9 +++-
 drivers/usb/serial/keyspan_pda.c     |   11 ++++-
 drivers/usb/serial/kl5kusb105.c      |    8 +++
 drivers/usb/serial/mct_u232.c        |    8 +++
 drivers/usb/serial/omninet.c         |    9 ++++
 drivers/usb/serial/pl2303.c          |    8 +++
 drivers/usb/serial/safe_serial.c     |    9 ++++
 drivers/usb/serial/usb-serial.h      |    3 +
 drivers/usb/serial/usbserial.c       |   72 ++++++++++++++++-------------------
 drivers/usb/serial/visor.c           |   11 ++++-
 drivers/usb/serial/whiteheat.c       |   11 ++++-
 22 files changed, 206 insertions(+), 51 deletions(-)
------

ChangeSet@1.578, 2002-09-16 14:27:53-07:00, greg@kroah.com
  USB: Convert the core code to use struct device_driver.

 drivers/usb/core/devices.c |    1 
 drivers/usb/core/devio.c   |   61 +---
 drivers/usb/core/hcd.c     |    8 
 drivers/usb/core/hcd.h     |    8 
 drivers/usb/core/hub.c     |  160 ++++++------
 drivers/usb/core/hub.h     |    2 
 drivers/usb/core/usb.c     |  567 +++++++++++++--------------------------------
 include/linux/usb.h        |   41 +--
 8 files changed, 289 insertions(+), 559 deletions(-)
------

ChangeSet@1.577, 2002-09-16 14:16:16-07:00, greg@kroah.com
  Driver Model: fix oops when device is removed from system

 drivers/base/core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.576, 2002-09-16 14:15:26-07:00, greg@kroah.com
  Driver Model: add dev_get_drvdata() and dev_set_drvdata() functions

 include/linux/device.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)
------

ChangeSet@1.575, 2002-09-16 14:14:26-07:00, greg@kroah.com
  USB: change the contact email address for the omninet driver

 Documentation/usb/usb-serial.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.574, 2002-09-16 13:28:01-07:00, mark@alpha.dyndns.org
  [PATCH] ov511 1.62 for 2.5.34
  
   Update the ov511 driver to version 1.62:
   o Update email address
   o Remove some dead code and fix some harmless typos
   o New device: Alpha Vision Tech. AlphaCam SE
   o Fix assignment of ov->proc_button->owner to not cause
     NULL pointer deref (credit: Oleg K.)
   o Support I2C read/write ioctl()s via V4L (credit: Oleg K.)
   o Add OV518-specific register dump code
   o New snapshot reset sequence; old one was causing
     erroneous I2C writes (credit: Oleg K.)
   o OV6630 needs different register 0x14 settings than OV6620
   o Don't print palette errors by default
   o Detect OV518 cameras that have packet numbering enabled
     by default and set ov->packet_numbering accordingly. This
     should fix the problems some users were having with babble
     (USB error -75) and cameras not working at all.

 Documentation/usb/ov511.txt |   35 --------
 drivers/usb/media/ov511.c   |  179 +++++++++++++++++++++++++-------------------
 drivers/usb/media/ov511.h   |   18 ----
 3 files changed, 106 insertions(+), 126 deletions(-)
------

ChangeSet@1.564.2.5, 2002-09-16 10:31:51-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: add error checks, remove useless code
  
  This patch removes attempts to clear halts on a control endpoint (think
  about it for a minute if you don't see why this is pointless....) and also
  adds return-code checks for all places where halts are cleared.
  
  This _should_ be just redundant code, but recent tests suggest that this
  is, in fact, not the case.  People should _heavily_ test this patch.  I'm
  going to pause here for a while (in the patch stream) until we've got this
  sorted out -- initial results on my test setup seem to show some problems
  still remain.  Where those problems are (HCD or usb-storage) remains to be
  seen.

 drivers/usb/storage/isd200.c        |   27 +++++------------------
 drivers/usb/storage/raw_bulk.c      |   10 +++-----
 drivers/usb/storage/shuttle_usbat.c |    9 +++++--
 drivers/usb/storage/transport.c     |   41 ++++++++----------------------------
 drivers/usb/storage/usb.c           |    3 --
 5 files changed, 27 insertions(+), 63 deletions(-)
------

ChangeSet@1.564.2.4, 2002-09-16 10:31:22-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: minor compilation fixes
  
  This patch fixes up some minor compilation problems.

 drivers/usb/storage/isd200.c    |    2 +-
 drivers/usb/storage/transport.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.564.2.3, 2002-09-16 10:30:55-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: macro-ize address manipulation
  
  This patch converts all uses of page_addres() to the sg_address() macro.
  This will make backporting to 2.4 easier, as well as eliminate lots of
  redundant code.

 drivers/usb/storage/debug.c     |    2 +-
 drivers/usb/storage/debug.h     |    2 +-
 drivers/usb/storage/freecom.c   |    4 ++--
 drivers/usb/storage/isd200.c    |    8 ++++----
 drivers/usb/storage/protocol.c  |    2 +-
 drivers/usb/storage/raw_bulk.c  |    6 +++---
 drivers/usb/storage/scsiglue.c  |   21 +++++++++------------
 drivers/usb/storage/sddr09.c    |   35 ++++++++++++++++-------------------
 drivers/usb/storage/transport.c |    4 ++--
 drivers/usb/storage/usb.c       |    4 ++--
 drivers/usb/storage/usb.h       |    3 +--
 11 files changed, 42 insertions(+), 49 deletions(-)
------

ChangeSet@1.564.2.2, 2002-09-16 10:30:27-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: remove tests against EINPROGRESS
  
  This patch removes tests of urb->status for EINPROGRESS.  As was pointed
  out, that's not such a good idea, for a variety of reasons.
  
  In the process, a semaphore became useless.

 drivers/usb/storage/transport.c |   44 +++++++++++++++++++++-------------------
 drivers/usb/storage/usb.c       |    1 
 drivers/usb/storage/usb.h       |    2 -
 3 files changed, 25 insertions(+), 22 deletions(-)
------

ChangeSet@1.564.2.1, 2002-09-16 10:30:06-07:00, stern@rowland.harvard.edu
  [PATCH] USB storage:  Merging raw_bulk.c with transport.c
  
  Here's a very simple patch that can go into the source tree right away.
  It just fixes some occurrences of the scsi result code GOOD to GOOD << 1
  in isd200.c.

 drivers/usb/storage/isd200.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)
------

