Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbTCGAFx>; Thu, 6 Mar 2003 19:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261309AbTCGAFx>; Thu, 6 Mar 2003 19:05:53 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:59401 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261308AbTCGAFo>;
	Thu, 6 Mar 2003 19:05:44 -0500
Date: Thu, 6 Mar 2003 16:06:28 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.64
Message-ID: <20030307000628.GA13766@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small USB changes.  The most interesting thing here is a
fix to the io_edgeport driver to now work on big endian machines, and
finally we now support the Treo USB devices properly.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/usb/class/usb-midi.h     |   23 ++++++++++++++++--
 drivers/usb/core/hub.c           |    1 
 drivers/usb/core/message.c       |   16 +++++++++++-
 drivers/usb/core/urb.c           |   20 +++++++++++++--
 drivers/usb/core/usb.c           |   29 +++++++++++++++--------
 drivers/usb/serial/io_edgeport.c |   45 ++++++++++++++++++-----------------
 drivers/usb/serial/pl2303.c      |    1 
 drivers/usb/serial/pl2303.h      |    3 ++
 drivers/usb/serial/visor.c       |   49 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/storage/transport.c  |   13 +++++++---
 include/linux/usb.h              |    3 --
 include/linux/usb_ch9.h          |   21 ++++++++++++++++
 12 files changed, 180 insertions(+), 44 deletions(-)
-----

ChangeSet@1.1068.7.7, 2003-03-06 15:47:22-08:00, greg@kroah.com
  [PATCH] USB: unfortunatly, we can't call usb_unlink_urb() right now all of the time.
  
  The host controllers have to be fixed up before we can safely take
  out the check for dev->state.

 drivers/usb/core/urb.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletion(-)
------

ChangeSet@1.1068.7.6, 2003-03-06 15:46:40-08:00, david-b@pacbell.net
  [PATCH] USB: track usb ch9 device state
  
  This patch merges the USB state definitions from the ARM Linux
  code (inside the sa1100 driver) and uses them to track what can
  be done with the device.  That replaces the recently added
  "udev->present" flag with a more complete/standard state model.
  
  There are a few changes that might affect behavior if things
  start to go really haywire:
  
   - usb_set_address() and usb_set_configuration(), used while
     enumerating, handle some unlikely cases more correctly:
     don't allow setting address to zero (undefined behavior),
     and do allow un-configuring (config 0).  (Adds a FIXME
     for an existing set-configuration bug too.)
  
   - usb_disconnect() flags the state change earlier (as soon
     as it's known).
  
   - usb_submit_urb() works in the states where messaging is
     allowed, and also enforces the "unless configured, only
     control traffic is legal" rule.
  
   - usb_unlink_urb() doesn't care any more about that state.
     (There seemed to be agreement that it must not matter.)
  
  This will help with some further cleanups in the complex of
  issues relating to driver removal, device removal, config
  changing (with driver unbind and rebind), reset, and so on.

 drivers/usb/core/hub.c     |    1 +
 drivers/usb/core/message.c |   16 ++++++++++++++--
 drivers/usb/core/urb.c     |    9 +++++++--
 drivers/usb/core/usb.c     |   29 ++++++++++++++++++++---------
 include/linux/usb.h        |    3 +--
 include/linux/usb_ch9.h    |   21 +++++++++++++++++++++
 6 files changed, 64 insertions(+), 15 deletions(-)
------

ChangeSet@1.1068.7.5, 2003-03-06 13:55:05-08:00, stern@rowland.harvard.edu
  [PATCH] USB: Patch for auto-sense cmd_len
  
  This patch fixes an oversight in usb-storage whereby the command length
  and command buffer for an automatically-generated REQUEST-SENSE command
  would not be initialized properly.

 drivers/usb/storage/transport.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)
------

ChangeSet@1.1068.7.4, 2003-03-05 12:06:48-08:00, greg@kroah.com
  [PATCH] USB: added support for radio shack device to pl2303 driver.
  
  Thanks to gene_heskett@iolinc.net for the info for this.

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.1068.7.3, 2003-03-05 11:44:45-08:00, andre.breiler@null-mx.org
  [PATCH] io_edgeport.c diff to fix endianess bugs
  
  attached a fix for the io_edgeport usb serial driver
  This diff fixes endianess issues which prevented the driver to work on
  bigendian machines (e.g. sparc).

 drivers/usb/serial/io_edgeport.c |   45 +++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 22 deletions(-)
------

ChangeSet@1.1068.7.2, 2003-03-05 11:43:00-08:00, clemens@ladisch.de
  [PATCH] usb-midi.h: fixes for SC-8820/50
  
   sync with Nagano's version:
   - protect vendors ids against multiple definitions
   - sort Roland device ids
   - fix SC-8850 cable bitmask
   - add quirk for the SC-8820
   - add quirk for the MOTU Fastlane

 drivers/usb/class/usb-midi.h |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)
------

ChangeSet@1.1068.7.1, 2003-03-05 11:41:00-08:00, greg@kroah.com
  [PATCH] USB: add support for Treo devices to the visor driver.
  
  Finally...

 drivers/usb/serial/visor.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 48 insertions(+), 1 deletion(-)
------

