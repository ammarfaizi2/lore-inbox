Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319235AbSHUWvG>; Wed, 21 Aug 2002 18:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSHUWvG>; Wed, 21 Aug 2002 18:51:06 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:32005 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319235AbSHUWvD>;
	Wed, 21 Aug 2002 18:51:03 -0400
Date: Wed, 21 Aug 2002 15:49:40 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] Still more USB changes for 2.5.31
Message-ID: <20020821224940.GA3099@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This tree includes the last set of USB changes that have not shown up in
your tree yet, and these new ones.

Pull from:  http://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/Config.in          |    8 
 drivers/usb/Makefile           |    2 
 drivers/usb/image/scanner.h    |    5 
 drivers/usb/media/ibmcam.c     |   84 +--
 drivers/usb/media/konicawc.c   |  144 ++++-
 drivers/usb/media/ultracam.c   |   36 -
 drivers/usb/media/usbvideo.c   |  279 ++++------
 drivers/usb/media/usbvideo.h   |   42 -
 drivers/usb/misc/Config.help   |   28 +
 drivers/usb/misc/Config.in     |   11 
 drivers/usb/misc/Makefile      |    4 
 drivers/usb/misc/atmsar.c      |  720 +++++++++++++++++++++++++++
 drivers/usb/misc/atmsar.h      |   81 +++
 drivers/usb/misc/speedtouch.c  | 1068 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/misc/usblcd.c      |  356 +++++++++++++
 drivers/usb/storage/scsiglue.c |    9 
 drivers/usb/storage/scsiglue.h |    1 
 drivers/usb/storage/usb.c      |   49 +
 18 files changed, 2654 insertions(+), 273 deletions(-)
-----

ChangeSet@1.518, 2002-08-21 15:04:15-07:00, spse@secret.org.uk
  [PATCH] typedef uvd_t removal in usbvideo
  
  This patch replaces typedef struct { .. } uvd_t with struct uvd as a
  cleanup removing typedef *_t types.

 drivers/usb/media/ibmcam.c   |   84 +++++++++++++++++++++---------------------
 drivers/usb/media/konicawc.c |   36 +++++++++---------
 drivers/usb/media/ultracam.c |   36 +++++++++---------
 drivers/usb/media/usbvideo.c |   86 +++++++++++++++++++++----------------------
 drivers/usb/media/usbvideo.h |   42 ++++++++++-----------
 5 files changed, 142 insertions(+), 142 deletions(-)
------

ChangeSet@1.517, 2002-08-21 14:54:14-07:00, greg@kroah.com
  USB: added the speedtouch usb driver.
  
  Patch originally from Richard Purdie <rpurdie@rpsys.net> but tweaked by me.

 drivers/usb/Makefile          |    1 
 drivers/usb/misc/Config.help  |   28 +
 drivers/usb/misc/Config.in    |    1 
 drivers/usb/misc/Makefile     |    3 
 drivers/usb/misc/atmsar.c     |  720 ++++++++++++++++++++++++++++
 drivers/usb/misc/atmsar.h     |   81 +++
 drivers/usb/misc/speedtouch.c | 1068 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 1902 insertions(+)
------

ChangeSet@1.516, 2002-08-21 14:27:46-07:00, beattie@beattie-home.net
  [PATCH] patch for 2.5 scanner.h add device id's
  

 drivers/usb/image/scanner.h |    5 +++++
 1 files changed, 5 insertions(+)
------

ChangeSet@1.515, 2002-08-21 14:26:53-07:00, spse@secret.org.uk
  [PATCH] use __FUNCTION__ in usbvideo
  
  This patch replaces static const char proc[] = <function name>
  with __FUNCTION__

 drivers/usb/media/usbvideo.c |  193 ++++++++++++++++++-------------------------
 1 files changed, 85 insertions(+), 108 deletions(-)
------

ChangeSet@1.514, 2002-08-21 13:53:49-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] PATCH: fix devices which don't support START_STOP
  
  Based on my discussions with Pete Zaitcev <zaitcev@redhat.com>, I'm
  convinced that globally re-writing the START_STOP command into a
  TEST_UNIT_READY command is a good idea.  This is supported by the fact
  that:
  
  (1) Lots of devices don't support START_STOP
  (2) Those that do support it often don't do a good job
  (3) Win/Mac will never send these commands over a USB bus
  
  So, here's a patch that re-writes them into Test Unit Ready commands.  It
  seems to work on my system, but needs more testing.  There may be a problem
  with this code still.... it seems that the SCSI layer can get convinced
  that the unit is not ready permanently.  I'm honestly not certain what bit
  of code is wrong where, so reports from others would be greatly
  appreciated.

 drivers/usb/storage/usb.c |   38 +++++++++++++++++++++++++++++++-------
 1 files changed, 31 insertions(+), 7 deletions(-)
------

ChangeSet@1.513, 2002-08-21 13:52:42-07:00, mdharm-usb@one-eyed-alien.net
  [PATCH] PATCH: fix devices which don't support EVPD
  
  Apparently, some new 2.5 scsi code tries to get the vital product data
  pages using the INQUIRY command.  Unfortunately, most USB devices do not
  support this.
  
  The following patch intercepts all EVPD requests and responds with the
  per-spec response of "Illegal Request: Invalid field in CDB".

 drivers/usb/storage/scsiglue.c |    9 +++++++++
 drivers/usb/storage/scsiglue.h |    1 +
 drivers/usb/storage/usb.c      |   11 +++++++++++
 3 files changed, 21 insertions(+)
------

ChangeSet@1.512, 2002-08-21 13:45:45-07:00, spse@secret.org.uk
  [PATCH] add VIDIOCSWIN support to konicawc driver
  
  This patch uses the setVideoMode callback in usbvideo to allow
  the VIDIOCSWIN ioctl() to set the size and speed of the camera.

 drivers/usb/media/konicawc.c |  108 +++++++++++++++++++++++++++++++++++++++----
 1 files changed, 100 insertions(+), 8 deletions(-)
------

ChangeSet@1.511, 2002-08-21 13:38:10-07:00, greg@kroah.com
  USB: fix minor number for the usblcd driver.

 drivers/usb/misc/usblcd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.510, 2002-08-21 13:34:24-07:00, greg@kroah.com
  USB: added usblcd driver
  
  Ported it from 2.4, any breakage is my fault :)

 drivers/usb/Config.in      |    8 -
 drivers/usb/Makefile       |    1 
 drivers/usb/misc/Config.in |   10 +
 drivers/usb/misc/Makefile  |    1 
 drivers/usb/misc/usblcd.c  |  354 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 367 insertions(+), 7 deletions(-)
------

