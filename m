Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264806AbSK0UvQ>; Wed, 27 Nov 2002 15:51:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264814AbSK0UvQ>; Wed, 27 Nov 2002 15:51:16 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40964 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264806AbSK0Uu5>;
	Wed, 27 Nov 2002 15:50:57 -0500
Date: Wed, 27 Nov 2002 12:50:13 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.49
Message-ID: <20021127205013.GD6596@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This also includes some small driver core hotplug fixes.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/ov511.txt        |    9 
 Documentation/usb/usb-serial.txt   |   43 ---
 drivers/base/base.h                |    2 
 drivers/base/hotplug.c             |    6 
 drivers/usb/core/Kconfig           |   12 
 drivers/usb/core/devio.c           |   67 +++--
 drivers/usb/host/ohci-mem.c        |  130 ++--------
 drivers/usb/host/ohci.h            |   21 -
 drivers/usb/media/Kconfig          |   27 +-
 drivers/usb/media/ov511.c          |  227 +++++++++--------
 drivers/usb/media/ov511.h          |    4 
 drivers/usb/media/pwc-ctrl.c       |   28 --
 drivers/usb/media/pwc-if.c         |  307 ++++++++++++++++--------
 drivers/usb/media/pwc-misc.c       |    2 
 drivers/usb/media/pwc-uncompress.c |   26 --
 drivers/usb/media/pwc-uncompress.h |    2 
 drivers/usb/media/pwc.h            |    9 
 drivers/usb/media/vicam.c          |  307 +++++++++++++-----------
 drivers/usb/misc/tiglusb.c         |   11 
 drivers/usb/serial/Kconfig         |    5 
 drivers/usb/serial/Makefile        |    5 
 drivers/usb/serial/ezusb.c         |   67 +++++
 drivers/usb/serial/generic.c       |  304 +++++++++++++++++++++++
 drivers/usb/serial/ipaq.c          |   25 +
 drivers/usb/serial/keyspan.c       |    2 
 drivers/usb/serial/usb-serial.c    |  357 ----------------------------
 drivers/usb/serial/usb-serial.h    |   28 --
 drivers/usb/serial/visor.c         |    2 
 drivers/usb/serial/visor.h         |    1 
 drivers/usb/serial/whiteheat.c     |  469 ++++++++++++++++++++++++++++++-------
 include/linux/usb.h                |   11 
 33 files changed, 1483 insertions(+), 1033 deletions(-)
-----

ChangeSet@1.842.46.18, 2002-11-27 10:56:01-08:00, stuartm@connecttech.com
  [PATCH] WhiteHEAT update
  
  1-fix-lowlat:
  
  QA found that running all four ports at 460800 would drop data. I
  traced it to data being dropped in the read callback because the flip
  buffers were full. Turning on the low latency flag fixed things.
  
  2-fix-taint
  
  A side-effect of turning on low latency; the interrupt context from
  the callback is now passed through to the tty layer, passing it on to
  calls back into usb-serial.c. Which causes deadlocks when trying to
  re-acquire the per-port semaphore. We've already talked about this.
  This patch is my work-around for the usb-serial.c brokenness.
  Basically, implemement a buffering scheme, and schedule a software
  interrupt to handle the data handoff to the tty layer sometime later.
  urb_pool_size defaults to 8, but is a module parameter and can be
  modified at runtime.
  The buffering is needed so that the driver can run while data is
  waiting to be processed, but I could have used the tty layer
  scheduling instead of doing my own by turning off low latency.
  However, I looked at the tty layer and it seems to me that there's
  nothing preventing a really fast device from flipping one buffer,
  flipping the next, and flipping back to the still full buffer from
  before (actually, the flip just gets scheduled for later), so my
  driver needs to be able to hold onto buffered data and schedule them
  for processing later anyway. So, might as well leave low_latency on.
  
  
  diff -Naur linux-2.5.49-0-virgin/drivers/usb/serial/whiteheat.c linux-2.5.49-1-fix-
  lowlat/drivers/usb/serial/whiteheat.c

 drivers/usb/serial/whiteheat.c |  469 ++++++++++++++++++++++++++++++++++-------
 1 files changed, 392 insertions(+), 77 deletions(-)
------

ChangeSet@1.842.46.17, 2002-11-27 10:27:41-08:00, stuartm@connecttech.com
  [PATCH] usb-serial.c disconnect race
  
  Attached is a patch that changes the 2.5.x disconnect to be similar to
  2.4.x disconnect. This doesn't fix the race, but does shrink the
  window such that I've never seen it trigger, even under testing
  designed to do that.
  
  There doesn't seem to be a good way to fix the race. The fix should be
  to have _disconnect force any sleeping semaphore holders to run to
  completion between the end of the loop in the patch below and the spot
  where the underlying memory is freed, but I don't see a way to do
  that.
  
  
  diff -Naur linux-2.5.49-2-fix-taint/drivers/usb/serial/usb-serial.c linux-2.5.49-3-fix-drvdata/drivers/usb/serial/usb-
  serial.c

 drivers/usb/serial/usb-serial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.842.46.16, 2002-11-27 09:54:32-08:00, jtyner@cs.ucr.edu
  [PATCH] [patch] speed/clean up vicam_decode_color
  
  This patch cleans up the vicam_decode_color function by removing
  unused/useless variables and combining the two "x" loops inside the
  y loop into one. It also reduces the number of times that the "x"
  loop occurs from 512 to 320 which should provide a decent speed
  increase. It also fixes a bug in the y loop that wrote beyond its bound.

 drivers/usb/media/vicam.c |  154 +++++++++++++++++++---------------------------
 1 files changed, 64 insertions(+), 90 deletions(-)
------

ChangeSet@1.842.46.15, 2002-11-27 09:46:14-08:00, nemosoft@smcc.demon.nl
  [PATCH] [PATCH] PWC 8.9
  
  After a little absence, here's a patch to bring the Philips Webcam driver up
  to version 8.9 (skipping 8.8 which has been available as a download on my
  website for a while).
  
  This patch is against 2.5.49, and includes some of the following:
  * New USB IDs for Logitech and Visionite webcams.
  * Better URB link/unlink sequence when opening/closing device
    and switching resolutions.
  * Adding probe for CCD/CMOS sensor type.
  * Removed remnants of YUV420 palette stuff.
  
  Also updated the description in 'Kconfig'.

 drivers/usb/media/Kconfig          |   27 ++-
 drivers/usb/media/pwc-ctrl.c       |   28 ---
 drivers/usb/media/pwc-if.c         |  307 ++++++++++++++++++++++++-------------
 drivers/usb/media/pwc-misc.c       |    2 
 drivers/usb/media/pwc-uncompress.c |   26 ---
 drivers/usb/media/pwc-uncompress.h |    2 
 drivers/usb/media/pwc.h            |    9 -
 7 files changed, 245 insertions(+), 156 deletions(-)
------

ChangeSet@1.842.46.14, 2002-11-27 09:40:14-08:00, mark@hal9000.dyndns.org
  [PATCH] USB ov511 driver: Update to version 1.63

 Documentation/usb/ov511.txt |    9 +
 drivers/usb/media/ov511.c   |  227 +++++++++++++++++++++++---------------------
 drivers/usb/media/ov511.h   |    4 
 3 files changed, 136 insertions(+), 104 deletions(-)
------

ChangeSet@1.842.46.13, 2002-11-27 09:06:12-08:00, ganesh@tuxtop.vxindia.veritas.com
  [PATCH] added support for insmod options to specify vendor/product id. this

 Documentation/usb/usb-serial.txt |   43 +++++++++------------------------------
 drivers/usb/serial/ipaq.c        |   22 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 35 deletions(-)
------

ChangeSet@1.842.46.12, 2002-11-26 15:33:15-08:00, greg@kroah.com
  [PATCH] USB serial: split the generic functions out into their own file
  

 drivers/usb/serial/Makefile     |    2 
 drivers/usb/serial/generic.c    |  304 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/usb-serial.c |  310 +---------------------------------------
 drivers/usb/serial/usb-serial.h |   12 +
 4 files changed, 327 insertions(+), 301 deletions(-)
------

ChangeSet@1.842.46.11, 2002-11-26 14:27:06-08:00, randy.dunlap@verizon.net
  [PATCH] tiglusb timeouts
  
  It addresses the timeout parameter in the tiglusb driver.
  
  1.  timeout could be 0, causing a divide-by-zero.
  The patch prevents this.
  
  2.  The timeout value to usb_bulk_msg() could be rounded
  down to cause a divide-by-zero if timeout was < 10, e.g. 9,
  in:
  	result = usb_bulk_msg (s->dev, pipe, buffer, bytes_to_read,
  			       &bytes_read, HZ / (timeout / 10));
  9 / 10 == 0 => divide-by-zero !!
  
  3.  The timeout value above doesn't do very well on converting
  timeout to tenths of seconds.  Even for the default timeout
  value of 15 (1.5 seconds), it becomes:
  	HZ / (15 / 10) == HZ / 1 == HZ, or 1 second.
  The patch corrects this formula to use:
  	(HZ * 10) / timeout

 drivers/usb/misc/tiglusb.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)
------

ChangeSet@1.842.46.10, 2002-11-26 14:16:49-08:00, greg@kroah.com
  [PATCH] USB serial: move the ezusb functions into their own file.
  

 drivers/usb/serial/Kconfig      |    5 ++
 drivers/usb/serial/Makefile     |    3 +
 drivers/usb/serial/ezusb.c      |   67 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/usb-serial.c |   45 --------------------------
 drivers/usb/serial/usb-serial.h |   16 ---------
 5 files changed, 74 insertions(+), 62 deletions(-)
------

ChangeSet@1.842.46.9, 2002-11-25 16:53:04-08:00, jtyner@cs.ucr.edu
  [PATCH] USB: [patch] fix vicam disconnect/locking
  
  Here is a patch that fixes the disconnect handling and locking for the
  vicam driver. It does the following.
  
  1.)	Change the parameters of send_control_msg to take a struct
  	vicam_camera instead of struct usb_device to allow for locking
  	of the device. Note that __send_control_msg does not lock the
  	camera. send_control_msg locks the camera before calling
  	__send_control_msg.
  2.)	Remove all instances of busy_lock. busy_lock was renamed to
  	cam_lock and used to lock out simultaneous uses of the camera
  	and handle disconnects. We may want to add back a different lock
  	to handle smp type stuff.
  3.)	Separate read_frame and vicam_decode_color. This should move us
  	along toward asynchronous urbs.
  
  This patch does not address the locking of the camera that is still
  needed by the proc interface.

 drivers/usb/media/vicam.c |  153 +++++++++++++++++++++++++++++++---------------
 1 files changed, 104 insertions(+), 49 deletions(-)
------

ChangeSet@1.842.46.8, 2002-11-25 16:39:49-08:00, greg@kroah.com
  [PATCH] USB: added Palm Tungsten W support.
  
  Thanks to Ralf Dietrich <ralle@envicon.de> for the information.

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.842.46.7, 2002-11-25 10:53:08-08:00, greg@kroah.com
  [PATCH] driver core: fix compiler warning if CONFIG_HOTPLUG is not defined
  
  fixes bug #26 <http://bugme.osdl.org/show_bug.cgi?id=26>

 drivers/base/base.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.842.46.6, 2002-11-23 23:52:53-08:00, baldrick@wanadoo.fr
  [PATCH] usbdevfs: finalize urbs on interface release
  
  Description: When an urb has been submitted via usbdevfs, and is still
  pending when the interface it was submitted to is released, force the
  urb to be completed.  This is the correct behaviour.  It fixes an oops on
  system shutdown when using the user space driver for the speedtouch
  modem.

 drivers/usb/core/devio.c |   67 +++++++++++++++++++++++++++++++++--------------
 1 files changed, 48 insertions(+), 19 deletions(-)
------

ChangeSet@1.842.46.5, 2002-11-23 23:47:11-08:00, ganesh@vxindia.veritas.com
  [PATCH] uninitialized spinlock in ipaq.c
  
  this fixes an uninitialzed spinlock in ipaq.c. the driver should work
  on smp machines now.

 drivers/usb/serial/ipaq.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.842.46.4, 2002-11-23 23:37:01-08:00, randy.dunlap@verizon.net
  [PATCH] USB: use time_before() to compare times

 drivers/usb/serial/keyspan.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.842.46.3, 2002-11-23 23:34:26-08:00, david-b@pacbell.net
  [PATCH] ohci uses less slab memory
  
  When chasing down some of those 'bad entry' diagnostics, I once
  got suspicious that the problem was slab corruption coming from
  the way the td hashtable code worked.   So I put together this
  patch, eliminating some kmallocation, and the next times I ran
  that test, the oops went away and it worked like a charm.  Hmm.
  
  This patch is good because it shrinks memory and code, and gets
  rid of some could-fail allocations, so I figured I'd send it on
  (low priority) even if I don't think it fixes the root problem.

 drivers/usb/host/ohci-mem.c |  130 +++++++++++---------------------------------
 drivers/usb/host/ohci.h     |   21 +------
 2 files changed, 39 insertions(+), 112 deletions(-)
------

ChangeSet@1.842.46.2, 2002-11-23 23:33:53-08:00, david-b@pacbell.net
  [PATCH] remove CONFIG_USB_LONG_TIMEOUT
  
  Basically, no point in having short and long timeout options
  where both are _shorter_ than the timeout from the USB spec.

 drivers/usb/core/Kconfig |   12 ------------
 include/linux/usb.h      |   11 ++++-------
 2 files changed, 4 insertions(+), 19 deletions(-)
------

ChangeSet@1.842.46.1, 2002-11-23 23:33:37-08:00, david-b@pacbell.net
  [PATCH] drivers/base/hotplug.c, fix $DEVPATH
  
  Hotplug agents couldn't use /sys/$DEVPATH after /sys/root
  morphed into /sys/devices ... now they can do it again.

 drivers/base/hotplug.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)
------

