Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319389AbSH2VLM>; Thu, 29 Aug 2002 17:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319396AbSH2VLM>; Thu, 29 Aug 2002 17:11:12 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:45840 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319389AbSH2VLI>;
	Thu, 29 Aug 2002 17:11:08 -0400
Date: Thu, 29 Aug 2002 14:14:40 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.20-pre4
Message-ID: <20020829211440.GA4481@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This includes a much needed usb-serial backport to fix a number of
module count and oopses on close() that people have been reporting,
along with some other minor cleanups, and a new USB driver.

Pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email.

thanks,

greg k-h

 drivers/usb/Config.in                   |    1 
 drivers/usb/Makefile                    |    1 
 drivers/usb/bluetooth.c                 |  195 ++++----
 drivers/usb/hid-core.c                  |    2 
 drivers/usb/kaweth.c                    |  367 +++++++++++-----
 drivers/usb/pegasus.h                   |   17 
 drivers/usb/serial/Config.in            |    2 
 drivers/usb/serial/belkin_sa.c          |  265 +++--------
 drivers/usb/serial/cyberjack.c          |  122 +----
 drivers/usb/serial/digi_acceleport.c    |  230 ++++------
 drivers/usb/serial/empeg.c              |  139 +-----
 drivers/usb/serial/ftdi_sio.c           |  244 ++++------
 drivers/usb/serial/io_edgeport.c        |  399 ++++++++---------
 drivers/usb/serial/io_edgeport.h        |    1 
 drivers/usb/serial/io_fw_boot.h         |   12 
 drivers/usb/serial/io_fw_boot2.h        |   12 
 drivers/usb/serial/io_fw_down.h         |   12 
 drivers/usb/serial/io_fw_down2.h        |   14 
 drivers/usb/serial/io_fw_down3.h        |    6 
 drivers/usb/serial/io_ionsp.h           |    4 
 drivers/usb/serial/io_tables.h          |   16 
 drivers/usb/serial/io_ti.c              |  379 +++++++----------
 drivers/usb/serial/io_ti.h              |    4 
 drivers/usb/serial/io_usbvend.h         |   26 -
 drivers/usb/serial/ipaq.c               |  268 ++++--------
 drivers/usb/serial/ir-usb.c             |  172 +++----
 drivers/usb/serial/keyspan.c            |  711 +++++++++++++++++++-------------
 drivers/usb/serial/keyspan.h            |  669 ++++++++++--------------------
 drivers/usb/serial/keyspan_pda.c        |  268 ++++--------
 drivers/usb/serial/keyspan_usa18x_fw.h  |  632 ++++++++++++++--------------
 drivers/usb/serial/keyspan_usa19_fw.h   |  325 +++++++-------
 drivers/usb/serial/keyspan_usa19qi_fw.h |  284 ++++++++++++
 drivers/usb/serial/keyspan_usa19qw_fw.h |  448 ++++++++++++++++++++
 drivers/usb/serial/keyspan_usa19w_fw.h  |  350 +++++++--------
 drivers/usb/serial/keyspan_usa26msg.h   |   64 +-
 drivers/usb/serial/keyspan_usa28_fw.h   |  411 +++++++++---------
 drivers/usb/serial/keyspan_usa28msg.h   |   20 
 drivers/usb/serial/keyspan_usa28x_fw.h  |  631 ++++++++++++++--------------
 drivers/usb/serial/keyspan_usa28xa_fw.h |  641 ++++++++++++++--------------
 drivers/usb/serial/keyspan_usa28xb_fw.h |  645 ++++++++++++++---------------
 drivers/usb/serial/keyspan_usa49msg.h   |   68 +--
 drivers/usb/serial/keyspan_usa49w_fw.h  |  578 +++++++++++++-------------
 drivers/usb/serial/kl5kusb105.c         |  307 ++++---------
 drivers/usb/serial/kl5kusb105.h         |    4 
 drivers/usb/serial/mct_u232.c           |  247 +++--------
 drivers/usb/serial/omninet.c            |  111 +---
 drivers/usb/serial/pl2303.c             |  208 +++------
 drivers/usb/serial/pl2303.h             |    3 
 drivers/usb/serial/usb-serial.h         |  143 ++++--
 drivers/usb/serial/usbserial.c          |  636 +++++++++++++++-------------
 drivers/usb/serial/visor.c              |  301 ++++---------
 drivers/usb/serial/whiteheat.c          |  191 +++-----
 drivers/usb/storage/scsiglue.c          |    2 
 drivers/usb/storage/transport.c         |   14 
 drivers/usb/storage/unusual_devs.h      |    6 
 drivers/usb/storage/usb.h               |    1 
 drivers/usb/usb-ohci.c                  |    2 
 drivers/usb/usblcd.c                    |  346 +++++++++++++++
 58 files changed, 6333 insertions(+), 5844 deletions(-)
-----

ChangeSet@1.638, 2002-08-29 13:46:43-07:00, oliver@neukum.name
  [PATCH] USB: backport of kaweth driver
  
  this is a backport of kaweth of 2.5 to 2.4.

 drivers/usb/kaweth.c |  367 ++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 246 insertions(+), 121 deletions(-)
------

ChangeSet@1.637, 2002-08-29 13:46:29-07:00, david-b@pacbell.net
  [PATCH] USB: ohci completion of unlinked urbs patch
  
  OHCI bug fix

 drivers/usb/usb-ohci.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.636, 2002-08-29 13:46:17-07:00, zaitcev@redhat.com
  [PATCH] Patch for urb->status abuse in usb-storage in 2.4
  
  Here is a patch from Pete Zaitcev <zaitcev@redhat.com> which rids us of a
  EINPROGRESS test.  These tests really aren't a good thing according to
  Pete, and I tend to agree with him.
  
  This is for the 2.4 tree.  Pete claims to have tested this.
  Note that the changes are in an error-handling path and look pretty
  reasonable on their face, so I don't think there is any reason not to send
  this on to Marcello.

 drivers/usb/storage/scsiglue.c  |    2 +-
 drivers/usb/storage/transport.c |   14 ++++++--------
 drivers/usb/storage/usb.h       |    1 +
 3 files changed, 8 insertions(+), 9 deletions(-)
------

ChangeSet@1.635, 2002-08-29 13:46:00-07:00, pekon@informatics.muni.cz
  [PATCH] Patch to include support for Minolta Dimage 7i
  
  Hi,
  
  another try to get the patch for Minolta DImage 7i into the kernel, last
  time I checked bk it still was not there. Patch and
  /proc/bus/usb/devices appended.

 drivers/usb/storage/unusual_devs.h |    6 ++++++
 1 files changed, 6 insertions(+)
------

ChangeSet@1.634, 2002-08-29 13:45:47-07:00, nahshon@actcom.co.il
  [PATCH] USB keyboards (patch)
  
  The attached patch is required to use some (buggy?)
  USB keyboards. IMHO it should not cause new problems
  with other HID devices (though, testing with hardware that
  I do not have is a good idea).
  
  I'm using it with recent 2.4 kernels for some time now.
  
  Just removing the call to usb_set_idle also works (but
  it is less efficient).
  
  The 2.5 kernels do not need this changes - they already call
  the equivalent of usb_set_idle (only for input reports) after
  reading the first report.

 drivers/usb/hid-core.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.633, 2002-08-29 11:20:18-07:00, greg@kroah.com
  USB: whiteheat update due to usbserial core changes.

 drivers/usb/serial/whiteheat.c |  191 +++++++++++++++--------------------------
 1 files changed, 73 insertions(+), 118 deletions(-)
------

ChangeSet@1.632, 2002-08-29 11:19:57-07:00, greg@kroah.com
  USB: visor update due to usbserial core changes.

 drivers/usb/serial/visor.c |  301 ++++++++++++++-------------------------------
 1 files changed, 97 insertions(+), 204 deletions(-)
------

ChangeSet@1.631, 2002-08-29 11:19:26-07:00, greg@kroah.com
  USB: pl2303 update due to usbserial core changes.

 drivers/usb/serial/pl2303.c |  208 ++++++++++++++++++--------------------------
 drivers/usb/serial/pl2303.h |    3 
 2 files changed, 91 insertions(+), 120 deletions(-)
------

ChangeSet@1.630, 2002-08-29 11:18:57-07:00, greg@kroah.com
  USB: omninet update due to usbserial core changes.

 drivers/usb/serial/omninet.c |  111 ++++++++++++++-----------------------------
 1 files changed, 38 insertions(+), 73 deletions(-)
------

ChangeSet@1.629, 2002-08-29 11:18:35-07:00, greg@kroah.com
  USB: mct_u232 update due to usbserial core changes.

 drivers/usb/serial/mct_u232.c |  247 +++++++++++-------------------------------
 1 files changed, 70 insertions(+), 177 deletions(-)
------

ChangeSet@1.628, 2002-08-29 11:18:03-07:00, greg@kroah.com
  USB: kl5kusb105 update due to usbserial core changes.

 drivers/usb/serial/kl5kusb105.c |  307 ++++++++++++++--------------------------
 drivers/usb/serial/kl5kusb105.h |    4 
 2 files changed, 113 insertions(+), 198 deletions(-)
------

ChangeSet@1.627, 2002-08-29 10:56:46-07:00, greg@kroah.com
  USB: keyspan update due to usbserial core changes.
  
  Also update the firmware with the latest versions, and add support for
  the 19qi and 19qw devices.

 drivers/usb/serial/Config.in            |    2 
 drivers/usb/serial/keyspan.c            |  711 +++++++++++++++++++-------------
 drivers/usb/serial/keyspan.h            |  669 ++++++++++--------------------
 drivers/usb/serial/keyspan_usa18x_fw.h  |  632 ++++++++++++++--------------
 drivers/usb/serial/keyspan_usa19_fw.h   |  325 +++++++-------
 drivers/usb/serial/keyspan_usa19qi_fw.h |  284 ++++++++++++
 drivers/usb/serial/keyspan_usa19qw_fw.h |  448 ++++++++++++++++++++
 drivers/usb/serial/keyspan_usa19w_fw.h  |  350 +++++++--------
 drivers/usb/serial/keyspan_usa26msg.h   |   64 +-
 drivers/usb/serial/keyspan_usa28_fw.h   |  411 +++++++++---------
 drivers/usb/serial/keyspan_usa28msg.h   |   20 
 drivers/usb/serial/keyspan_usa28x_fw.h  |  631 ++++++++++++++--------------
 drivers/usb/serial/keyspan_usa28xa_fw.h |  641 ++++++++++++++--------------
 drivers/usb/serial/keyspan_usa28xb_fw.h |  645 ++++++++++++++---------------
 drivers/usb/serial/keyspan_usa49msg.h   |   68 +--
 drivers/usb/serial/keyspan_usa49w_fw.h  |  578 +++++++++++++-------------
 16 files changed, 3623 insertions(+), 2856 deletions(-)
------

ChangeSet@1.626, 2002-08-29 10:55:17-07:00, greg@kroah.com
  USB: keyspan_pda update due to usbserial core changes.

 drivers/usb/serial/keyspan_pda.c |  268 +++++++++++++++------------------------
 1 files changed, 105 insertions(+), 163 deletions(-)
------

ChangeSet@1.625, 2002-08-29 10:54:45-07:00, greg@kroah.com
  USB: ir-usb update due to usbserial core changes.

 drivers/usb/serial/ir-usb.c |  172 ++++++++++++++++++++++----------------------
 1 files changed, 88 insertions(+), 84 deletions(-)
------

ChangeSet@1.624, 2002-08-29 10:54:17-07:00, greg@kroah.com
  USB: ipaq update due to usbserial core changes.

 drivers/usb/serial/ipaq.c |  268 +++++++++++++++++++---------------------------
 1 files changed, 111 insertions(+), 157 deletions(-)
------

ChangeSet@1.623, 2002-08-29 10:53:47-07:00, greg@kroah.com
  USB: io_ti update due to usbserial core changes.

 drivers/usb/serial/io_ti.c |  379 +++++++++++++++++++--------------------------
 drivers/usb/serial/io_ti.h |    4 
 2 files changed, 170 insertions(+), 213 deletions(-)
------

ChangeSet@1.621, 2002-08-29 10:52:32-07:00, greg@kroah.com
  USB: ftdi_sio update due to usbserial core changes.

 drivers/usb/serial/ftdi_sio.c |  244 +++++++++++++++++-------------------------
 1 files changed, 103 insertions(+), 141 deletions(-)
------

ChangeSet@1.620, 2002-08-29 10:52:01-07:00, greg@kroah.com
  USB: empeg update due to usbserial core changes.

 drivers/usb/serial/empeg.c |  139 +++++++++++++--------------------------------
 1 files changed, 43 insertions(+), 96 deletions(-)
------

ChangeSet@1.619, 2002-08-29 10:51:28-07:00, greg@kroah.com
  USB: digi_acceleport update due to usbserial core changes.

 drivers/usb/serial/digi_acceleport.c |  230 +++++++++++++----------------------
 1 files changed, 90 insertions(+), 140 deletions(-)
------

ChangeSet@1.618, 2002-08-29 10:50:59-07:00, greg@kroah.com
  USB: cyberjack update due to usbserial core changes.

 drivers/usb/serial/cyberjack.c |  122 +++++++++++++----------------------------
 1 files changed, 40 insertions(+), 82 deletions(-)
------

ChangeSet@1.617, 2002-08-29 10:49:54-07:00, greg@kroah.com
  belkin_sa update due to usbserial core changes.

 drivers/usb/serial/belkin_sa.c |  265 ++++++++++-------------------------------
 1 files changed, 70 insertions(+), 195 deletions(-)
------

ChangeSet@1.616, 2002-08-29 10:43:21-07:00, greg@kroah.com
  USB: usbserial core synced up with the 2.5 version
  
  This fixes up the module reference count problem, 
  and should fix the oops on close/disconnect that some people are seeing.

 drivers/usb/serial/usb-serial.h |  143 ++++++--
 drivers/usb/serial/usbserial.c  |  636 +++++++++++++++++++++-------------------
 2 files changed, 447 insertions(+), 332 deletions(-)
------

ChangeSet@1.615, 2002-08-29 10:41:00-07:00, greg@kroah.com
  USB: updated the bluetooth driver to the latest version

 drivers/usb/bluetooth.c |  195 +++++++++++++++++++++++++-----------------------
 1 files changed, 105 insertions(+), 90 deletions(-)
------

ChangeSet@1.614, 2002-08-29 10:39:53-07:00, greg@kroah.com
  USB: added LCD driver

 drivers/usb/Config.in |    1 
 drivers/usb/Makefile  |    1 
 drivers/usb/usblcd.c  |  346 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 348 insertions(+)
------

ChangeSet@1.587.1.18, 2002-08-26 09:11:16-07:00, petkan@users.sourceforge.net
  [PATCH] USB: pegasus.h
  
  license change, 1 new device ID, device rename

 drivers/usb/pegasus.h |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)
------

