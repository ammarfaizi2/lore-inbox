Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268116AbTBSAst>; Tue, 18 Feb 2003 19:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268112AbTBSAst>; Tue, 18 Feb 2003 19:48:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:35599 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268116AbTBSAsk>;
	Tue, 18 Feb 2003 19:48:40 -0500
Date: Tue, 18 Feb 2003 16:51:52 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.62
Message-ID: <20030219005152.GA11326@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a raft of different USB changes.  The majority of them are
cleanups of the speedtouch driver from Duncan Sands.  There are lots of
other minor bug fixes from a lot of different people, and a change to
the usb-serial core from me which should fix up a lot of races that
people have been seeing in the current code.  I still need to audit all
of the usb-serial drivers now that the lock protecting all of the
callback functions is gone.  This also fixes some of the ppp over
usb-serial errors where we were deadlocking on different tty callbacks,
and removes some run-time warnings of sleeping at improper times.

There is also a change that allows the usb_device structure to be safely
held by drivers after the physical device has disappeared, which makes
the driver's lives a lot easier on cleanup time (no data can be sent to
such a device, and things properly cleanup when the last reference is
dropped.)  This has been a long standing bug that a number of drivers
have had problems with in the past.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/usb/class/Makefile.lib  |    1 
 CREDITS                         |    8 
 MAINTAINERS                     |    8 
 drivers/usb/Makefile.lib        |    3 
 drivers/usb/class/cdc-acm.c     |    3 
 drivers/usb/core/message.c      |   19 
 drivers/usb/core/urb.c          |    4 
 drivers/usb/core/usb.c          |    5 
 drivers/usb/host/ehci-hcd.c     |   19 
 drivers/usb/host/ehci.h         |    2 
 drivers/usb/input/Kconfig       |   18 
 drivers/usb/input/usbkbd.c      |    4 
 drivers/usb/input/usbmouse.c    |    4 
 drivers/usb/media/ov511.c       |  127 ++---
 drivers/usb/misc/Kconfig        |    9 
 drivers/usb/misc/atmsar.c       |  403 -------------------
 drivers/usb/misc/atmsar.h       |   22 -
 drivers/usb/misc/speedtouch.c   |  848 +++++++++++++++++++++++-----------------
 drivers/usb/net/kaweth.c        |    5 
 drivers/usb/net/pegasus.h       |    5 
 drivers/usb/serial/Kconfig      |    4 
 drivers/usb/serial/console.c    |    6 
 drivers/usb/serial/usb-serial.c |  178 ++++----
 drivers/usb/serial/usb-serial.h |    4 
 drivers/usb/storage/transport.c |    2 
 include/linux/usb.h             |    2 
 lib/Makefile                    |    4 
 27 files changed, 756 insertions(+), 961 deletions(-)
-----

ChangeSet@1.1107, 2003-02-18 16:33:05-08:00, greg@kroah.com
  USB: usbnet driver also needs the crc32 code.
  
  Thanks to David Brownell for this.

 drivers/usb/Makefile.lib |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.1106, 2003-02-18 16:27:45-08:00, greg@kroah.com
  [PATCH] USB: added sched.h to usb.h
  
  Thanks to Matt Wilcox for the info.

 include/linux/usb.h |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.1105, 2003-02-18 16:12:44-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/gregkh-2.5

 lib/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1043.1.26, 2003-02-18 16:05:07-08:00, greg@kroah.com
  [PATCH] USB: serial core fix to solve ordering issues when destroying our objects.

 drivers/usb/serial/usb-serial.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1043.1.25, 2003-02-18 16:03:32-08:00, greg@kroah.com
  [PATCH] USB serial: fix locking logic
  
  This gets rid of the port semaphore, and the serialization caused by
  that, and replaces it with the proper reference counting logic for
  the usb serial object.

 drivers/usb/serial/console.c    |    6 -
 drivers/usb/serial/usb-serial.c |  174 +++++++++++++++++++---------------------
 drivers/usb/serial/usb-serial.h |    4 
 3 files changed, 86 insertions(+), 98 deletions(-)
------

ChangeSet@1.1043.1.24, 2003-02-18 15:52:11-08:00, greg@kroah.com
  [PATCH] USB: add "present" flag to usb_device structure.
  
  This solves lots of races when drivers hold a reference to the usb_device
  after the device is physically removed from the system (like when a user
  has a open handle.)  This now prevents any new urbs being submitted or
  canceled for the device.

 drivers/usb/core/urb.c |    4 ++--
 drivers/usb/core/usb.c |    5 +++++
 include/linux/usb.h    |    1 +
 3 files changed, 8 insertions(+), 2 deletions(-)
------

ChangeSet@1.1043.1.23, 2003-02-18 09:29:42-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: speedtouch cleanups
  
  Grab bag of minor cleanups.

 drivers/usb/misc/speedtouch.c |   52 +++++++++++++++---------------------------
 1 files changed, 19 insertions(+), 33 deletions(-)
------

ChangeSet@1.1043.1.22, 2003-02-18 09:22:09-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: speedtouch stability fix fix
  
  It's usually considered stupid to stuff-up like this. However,
  for this once we'll just call it "inspired".

 drivers/usb/misc/speedtouch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1043.1.21, 2003-02-18 08:43:30-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: replace speedtouch crc routines
  
  Use the kernel CRC routines rather than a do-it-yourself version.
  By the way, I created a common USB Makefile.lib, rather than having
  one for the class drivers, and one for speedtouch.

 drivers/usb/class/Makefile.lib |    1 
 drivers/usb/Makefile.lib       |    2 
 drivers/usb/misc/atmsar.c      |  102 -----------------------------------------
 drivers/usb/misc/atmsar.h      |    7 --
 drivers/usb/misc/speedtouch.c  |   10 ++--
 lib/Makefile                   |    2 
 6 files changed, 11 insertions(+), 113 deletions(-)
------

ChangeSet@1.1043.1.20, 2003-02-17 10:41:09-08:00, mark@alpha.dyndns.org
  [PATCH] USB: ov511 bugfixes/cleanup
  
  This patch updates the 2.5 ov511 driver to version 1.64. This fixes some
  longstanding bugs and cleans the code up a bit.
  
  Changes:
   - Eliminate remaining uses of sleep_on()
   - Remove unnecessary (and racy) calls to waitqueue_active()
   - Fix a memory leak in the open() error path
   - Remove some redundant and unused variables
   - Documentation fixes

 drivers/usb/media/ov511.c |  127 +++++++++++++++++++++-------------------------
 1 files changed, 58 insertions(+), 69 deletions(-)
------

ChangeSet@1.1043.1.19, 2003-02-17 10:40:43-08:00, david-b@pacbell.net
  [PATCH] USB: USB keyboard works after reboot (ehci-hcd)
  
  This resolves a problem caused by "reboot" not actually
  doing a clean shutdown of drivers.  It uses a reboot
  notifier to make sure that typical BIOS code (using the
  USB 1.1 companion controllers) will see keyboards even
  without an EHCI driver being active.

 drivers/usb/host/ehci-hcd.c |   19 ++++++++++++++++++-
 drivers/usb/host/ehci.h     |    2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)
------

ChangeSet@1.1043.1.18, 2003-02-17 10:40:17-08:00, david-b@pacbell.net
  [PATCH] USB: sg_complete() warning downgrade
  
  An error check would wrongly fire after usb_sg_cancel().
  This patch prevents the misfire, and also makes the
  diagnostic (a) more useful, (b) less scarey.

 drivers/usb/core/message.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)
------

ChangeSet@1.1043.1.17, 2003-02-17 10:39:56-08:00, elenstev@mesatop.com
  [PATCH] USB: trivial help texts for drivers/usb/serial/Kconfig
  
  Here are some trivial help texts for drivers/usb/serial/Kconfig.

 drivers/usb/serial/Kconfig |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.1043.1.16, 2003-02-17 10:14:43-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: minor speedtouch changes
  
  Add some comments and debug info.

 drivers/usb/misc/speedtouch.c |   30 ++++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)
------

ChangeSet@1.1043.1.15, 2003-02-17 10:13:56-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: speedtouch 330 support
  
  Differences: speedtouch 330 vs the older speedtouch USB:
  Vendor and ProdID: no difference (!)
  Rev: 2.00 vs 0.00
  SerialNumber: 0090D0xxxxxx, xxxxxx larger for 330
  Interface 1, Alt 2:
  	E: Ad=06(O) Atr=02(Bulk) MxPS=64 Ivl=0ms
  	E: Ad=07(O) Atr=02(Bulk) MxPS=64 Ivl=0ms
  	E: Ad=87(I) Atr=01(Isoc) MxPS=640 Ivl=1ms
  vs
  	E: Ad=06(O) Atr=02(Bulk) MxPS=32 Ivl=0ms
  	E: Ad=07(O) Atr=02(Bulk) MxPS=32 Ivl=0ms
  	E: Ad=87(I) Atr=02(Bulk) MxPS=64 Ivl=0ms
  Interface 1, Alt 3:
  	E: Ad=06(O) Atr=02(Bulk) MxPS=64 Ivl=0ms
  	E: Ad=07(O) Atr=02(Bulk) MxPS=64 Ivl=0ms
  	E: Ad=87(I) Atr=01(Isoc) MxPS=960 Ivl=1ms
  vs
  	E: Ad=06(O) Atr=02(Bulk) MxPS=16 Ivl=0ms
  	E: Ad=07(O) Atr=02(Bulk) MxPS=16 Ivl=0ms
  	E: Ad=87(I) Atr=02(Bulk) MxPS=64 Ivl=0ms
  The current driver works with the speedtouch 330 as long as we use alternate setting
  1 on interface 1 rather than alternate 2 as we do now.  In fact it makes sense to use
  alternate 1 for the speedtouch USB as well: the difference is in the max packet size
  for the out bulk endpoint (0x07): 64 for Alt 1, 32 for Alt 2.  Since we send only
  multiples of 53 bytes (ATM cell size), the potential lower latency for Alt 2 is not
  really exploitable (think about it!).  My tests indicate no harm and perhaps a slight
  gain by using Alt 1.  The manufacturer seems to think so too, since they chose to
  keep the Alt 1 setting and threw out Alt 2 when designing the 330.  So just use Alt 1
  for both modems.

 drivers/usb/misc/speedtouch.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1043.1.14, 2003-02-17 10:10:04-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: add help text for speedtouch

 drivers/usb/misc/Kconfig |    9 +++++++++
 1 files changed, 9 insertions(+)
------

ChangeSet@1.1043.1.13, 2003-02-17 10:09:44-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: Update CREDITS and MAINTAINERS

 CREDITS     |    8 ++++++++
 MAINTAINERS |    8 ++++++++
 2 files changed, 16 insertions(+)
------

ChangeSet@1.1043.1.12, 2003-02-17 10:09:22-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: Fix speedtouch maxi race
  
  Instead of trying to close all ATM connections in the USB disconnect routine,
  just notify the ATM layer that the ATM device should go down when the last
  connection is closed.  This should be the last big speedtouch stability fix.

 drivers/usb/misc/speedtouch.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)
------

ChangeSet@1.1043.1.11, 2003-02-17 10:09:00-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: fix speedtouch micro race
  
  The disconnect routine counts the completed_receivers/spare_senders list
  to see if the completion handler has finished.  It then kills the tasklet.
  However the tasklet was being scheduled after adding to the lists, creating
  a micro race.  So schedule the tasklet before adding to the list.

 drivers/usb/misc/speedtouch.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)
------

ChangeSet@1.1043.1.10, 2003-02-16 09:41:02-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: Missing speedtouch bits
  
  Let's not forget to update the ATM transmission statistics!  And
  let's not pretend to support AAL0 when we don't.

 drivers/usb/misc/speedtouch.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)
------

ChangeSet@1.1043.1.9, 2003-02-16 09:40:01-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: speedtouch dead code elimination
  
  Eliminate a pile of code that isn't used anymore now the new send code
  is in place, and make some cosmetic changes.

 drivers/usb/misc/atmsar.c     |  286 ------------------------------------------
 drivers/usb/misc/atmsar.h     |    8 -
 drivers/usb/misc/speedtouch.c |   42 ++----
 3 files changed, 15 insertions(+), 321 deletions(-)
------

ChangeSet@1.1043.1.8, 2003-02-16 09:39:39-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: new speedtouch send path
  
  Finally, here is the new code for sending packets.  The ATM layer passes us a skb
  containing the packet to be sent.  We need to encode that as AAL5, and then encapsulate
  the result in a series of ATM cells.  Finally, the result has to be sent to the modem.
  When we have finished with the skb, we need to pass it back to the ATM layer.
  
  The old code did this as follows: (1) Try to do the AAL5 encoding in place in the skb.
  This fattens the packet, so there is not always enough room.  Thus sometimes a new skb
  is allocated.  (2) Try to form the frame of ATM cells in place.  This also fattens the
  packet, so sometimes another skb is allocated here too.  (3) send the urb, using the
  skb as buffer.
  
  The main problems with this are: (1) in the urb completion handler, we need to pass
  the skb back to the ATM layer, or free it ourselves if we allocated a new one.  The
  driver was pretty confused about which to do.  Also, error conditions were not
  always handled right.  (2) if the ATM layer wants to close the VCC (connection),
  any urbs in flight using skbs from that VCC need to be shot down, otherwise the
  skb may be returned to a VCC that no longer exists when the urb completes.  You
  have to be careful to shoot down the right urb (beware of resubmission), and deal
  with failures of usb_unlink_urb.  (3) There may need to be several memory allocations.
  
  The new code sidesteps all this by (1) not sending the skb off with the urb, and
  (2) not reallocating the skb at all.  It simply has a couple of buffers of fixed
  size: the encoded and encapsulated content of the skb is placed in a buffer.  The
  skb is sent back down to the ATM layer and the buffer is sent off with the urb.
  Et voila, as they say around here.
  
  Now for the complicating factors: (1) if there are no spare buffers, the incoming
  skb needs to be queued (this was already the case if there were no free urbs).  If
  the VCC is closed, the skbs from that VCC need to be removed from the queue.  This
  is trivial and is done in udsl_usb_cancelsends.  (2) The skbs can be quite big.  In
  practice, with the default configuration for pppd, they contain at most 1502 bytes.
  However pppd can be configured to send up to 16k packets, and who says everyone
  is using pppd? - the ATM layer allows up to 64k packets.  So how big should the
  buffers be?  Not 64k, that's for sure - I've set them to about 6k (128 ATM cells).
  So there needs to be a way to encode/encapsulate and transfer only part of the skb's
  payload into a buffer.  This is done by udsl_write_cell, which extracts one ATM
  cell from the skb.  The data needed is precalculated by udsl_groom_skb and stored
  in the skb's cb field.  This also means that if there is only a little room left
  in a buffer, it can still be filled by extracting part of a skb.  A nice consequence
  is that under heavy load (many packets being sent), the driver starts streaming the
  data to the USB subsystem: every time a send urb completes, there is a completely
  filled buffer waiting to be sent, so not only is the time between urb completion and
  resubmission essentially zero, but the amount of data sent in each USB transaction is
  as big as possible, each buffer containing the contents of several skbs (typically 4).
  
  And the best thing is: it actually works!

 drivers/usb/misc/speedtouch.c |  375 +++++++++++++++++++++---------------------
 1 files changed, 191 insertions(+), 184 deletions(-)
------

ChangeSet@1.1043.1.7, 2003-02-16 09:39:17-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: on-the-fly AAL5/ATM encoding for speedtouch
  
  Add a new encoding routine, udsl_write_cell, which extracts one ATM cell from a skb
  and writes it, doing the AAL5/ATM encoding on the fly.  To make this possible, various
  bits of info about the AAL5/ATM structure need to be stored beforehand in the skb.
  This is done by udsl_groom_skb using the udsl_control structure introduced in the
  previous patch.

 drivers/usb/misc/speedtouch.c |   80 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 80 insertions(+)
------

ChangeSet@1.1043.1.6, 2003-02-16 09:38:54-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: More infrastructure for new speedtouch send path
  
  Add a new structure, udsl_control.  It will live in the sk_buff cb field,
  so check there is room for it and bail out during module init if not.

 drivers/usb/misc/speedtouch.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)
------

ChangeSet@1.1043.1.5, 2003-02-16 09:38:32-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: expose crc defs to speedtouch
  
  Expose some CRC definitions in atmsar.h (for use by speedtouch.c).

 drivers/usb/misc/atmsar.c |    3 ---
 drivers/usb/misc/atmsar.h |    7 +++++++
 2 files changed, 7 insertions(+), 3 deletions(-)
------

ChangeSet@1.1043.1.4, 2003-02-16 09:38:10-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: infrastructure for new speedtouch send path
  
  Put in infrastructure for the new send code.  The only code changes are in the
  udsl_usb_probe and udsl_usb_disconnect functions, changed to initialize/finalize the
  new fields (plus cleaned up a bit).  I couldn't resist a real code change while I was
  there: freeing the memory used by the ATM after shutting it down, rather than before!
  This doesn't make any difference since the shutdown routine doesn't work - so it still
  oopses.  I will fix the shutdown routine later.

 drivers/usb/misc/speedtouch.c |  160 ++++++++++++++++++++++++++++++------------
 1 files changed, 116 insertions(+), 44 deletions(-)
------

ChangeSet@1.1043.1.3, 2003-02-16 09:37:49-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: yet another trivial speedtouch change
  
  Measure the receive buffer size in ATM cells (53 bytes).

 drivers/usb/misc/speedtouch.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.1043.1.2, 2003-02-16 09:37:27-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB speedtouch: Even more trivial speedtouch change
  
  Rename UDSL_RECEIVE_BUFFER_SIZE to UDSL_RCV_BUFFER_SIZE.

 drivers/usb/misc/speedtouch.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)
------

ChangeSet@1.1043.1.1, 2003-02-16 07:37:34-08:00, greg@kroah.com
  Merge kroah.com:/home/linux/linux/BK/bleeding-2.5
  into kroah.com:/home/linux/linux/BK/gregkh-2.5

 drivers/usb/input/Kconfig    |    9 ++++-----
 drivers/usb/input/usbkbd.c   |    2 +-
 drivers/usb/input/usbmouse.c |    2 +-
 drivers/usb/misc/atmsar.c    |    6 +++---
 4 files changed, 9 insertions(+), 10 deletions(-)
------

ChangeSet@1.925.62.9, 2003-02-07 17:22:54+11:00, oliver@neukum.name
  [PATCH] USB: kaweth fix
  
  this is the length calculation fix against 2.5.
    - fix DHCP problem with correct length calculation
    Thanks to Oliver Kurth

 drivers/usb/net/kaweth.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.925.62.8, 2003-02-07 17:22:22+11:00, oliver@neukum.name
  [PATCH] USB: added device id for kaweth
  
    - additional device id

 drivers/usb/net/kaweth.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.925.62.7, 2003-02-07 17:21:51+11:00, johannes@erdfelt.com
  [PATCH] usb_get_driver_np() gives wrong driver name (usb_mouse)
  
  On Thu, Feb 06, 2003, Johannes Erdfelt <johannes@erdfelt.com> wrote:
  > On Thu, Feb 06, 2003, Boris Duerner <Marc.Duerner@student.shu.ac.uk> wrote:
  > > I use the usb_get_driver_np() function to get the name of the loaded driver
  > > for a usb device and I found that for a device using the usbmouse module the
  > > wrong driver name is returned. It gives me "usb_mouse" instead of usbmouse.
  > > the driver name is also wrong in /proc/bus/usb/drivers but correct in lsmod
  > > or /proc/modules resp.
  >
  > The driver name in /proc/bus/usb/drivers is given differently than from
  > /proc/modules.
  >
  > I'm not exactly sure why the names are seperate, but it leads to
  > situations like this where the names won't match for seemingly no good
  > reason. The usbkbd driver was even worse, giving it's name as "keyboard".
  
  And the 2.5 patch.

 drivers/usb/input/usbkbd.c   |    2 +-
 drivers/usb/input/usbmouse.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.925.62.6, 2003-02-07 17:21:17+11:00, shields@msrl.com
  [PATCH] Re: Griffin Powermate: Aluminum
  
  > Greg KH says "please send 2.5 patch".

 drivers/usb/input/Kconfig |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)
------

ChangeSet@1.925.62.5, 2003-02-07 16:54:22+11:00, petkan@users.sourceforge.net
  [PATCH] USB: pegasus update (2.5)
  
  These are very small and similar csets against both usb-2.4 and usb-2.5
  trees.  One part of them is adding a missing flag to one of the device
  descriptors.  The other part is fixing a vendor name which i mistakenly
  replaced with the product name.
  
  
    Adding Mobility EasyDock device into the list.
    Adding a missing flag to Accton's SpeedStream description

 drivers/usb/net/pegasus.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
------

ChangeSet@1.925.62.4, 2003-02-07 16:45:32+11:00, randy.dunlap@verizon.net
  [PATCH] USB: cdc-acm memory leak
  
  The Stanford Checker discovered a memory leak in cdc-acm.
  This patch to 2.5.59 fixes it.  Please apply.

 drivers/usb/class/cdc-acm.c |    3 +++
 1 files changed, 3 insertions(+)
------

ChangeSet@1.925.62.3, 2003-02-07 16:42:38+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: Fix atmsar memory leak
  
  Leak found by the Stanford Checker (patch by Randy Dunlap).

 drivers/usb/misc/atmsar.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.925.62.2, 2003-02-07 16:39:47+11:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: trivial speedtouch changes
  
  Get rid of some unused #defines.

 drivers/usb/misc/speedtouch.c |    3 ---
 1 files changed, 3 deletions(-)
------

ChangeSet@1.925.62.1, 2003-02-07 16:36:33+11:00, stern@rowland.harvard.edu
  [PATCH] USB: Patches for the ECONNRESET error (2.5)
  
  Matt Dharm asked me to send these bug-fix patches directly to you.  They
  correct the error-code handling in usb-storage.  The change for 2.5 is
  pretty minor; it only affects debugging output.  But the change for 2.4 is
  more pervasive, and according to Tom Collins it is the key to making a usb
  hard disk work on his MIPS-based system.

 drivers/usb/storage/transport.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

