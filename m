Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTBTUDR>; Thu, 20 Feb 2003 15:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbTBTUDR>; Thu, 20 Feb 2003 15:03:17 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29445 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S263137AbTBTUDG>;
	Thu, 20 Feb 2003 15:03:06 -0500
Date: Thu, 20 Feb 2003 12:06:02 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.21-pre4
Message-ID: <20030220200602.GA25165@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates and bugfixes for 2.4.21-pre4.

Please pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 drivers/usb/auerswald.c             | 2178 ------------------------------------
 Documentation/Configure.help        |    2 
 Documentation/usb/auerswald.txt     |   10 
 Documentation/usb/ehci.txt          |  103 +
 drivers/usb/Config.in               |    2 
 drivers/usb/Makefile                |   11 
 drivers/usb/auerbuf.c               |  148 ++
 drivers/usb/auerbuf.h               |   69 +
 drivers/usb/auerchain.c             |  468 +++++++
 drivers/usb/auerchain.h             |   79 +
 drivers/usb/auerchar.c              |  615 ++++++++++
 drivers/usb/auerchar.h              |   79 +
 drivers/usb/auerisdn.c              | 1076 +++++++++++++++++
 drivers/usb/auerisdn.h              |   94 +
 drivers/usb/auerisdn_b.c            |  689 +++++++++++
 drivers/usb/auerisdn_b.h            |   66 +
 drivers/usb/auermain.c              |  897 ++++++++++++++
 drivers/usb/auermain.h              |  172 ++
 drivers/usb/auerserv.h              |   47 
 drivers/usb/hcd/ehci-dbg.c          |  114 +
 drivers/usb/hcd/ehci-hcd.c          |   66 -
 drivers/usb/hcd/ehci-mem.c          |    2 
 drivers/usb/hcd/ehci-q.c            |  144 +-
 drivers/usb/hcd/ehci.h              |    9 
 drivers/usb/hid-core.c              |   13 
 drivers/usb/kaweth.c                |    5 
 drivers/usb/pegasus.h               |    6 
 drivers/usb/scanner.c               |    6 
 drivers/usb/serial/ftdi_sio.c       |    2 
 drivers/usb/serial/ftdi_sio.h       |    3 
 drivers/usb/serial/pl2303.c         |    1 
 drivers/usb/serial/pl2303.h         |    3 
 drivers/usb/storage/datafab.c       |    4 
 drivers/usb/storage/freecom.c       |   34 
 drivers/usb/storage/isd200.c        |   10 
 drivers/usb/storage/jumpshot.c      |    6 
 drivers/usb/storage/sddr09.c        |    6 
 drivers/usb/storage/sddr55.c        |    4 
 drivers/usb/storage/shuttle_usbat.c |    6 
 drivers/usb/storage/transport.c     |   24 
 drivers/usb/uhci.c                  |    4 
 drivers/usb/usb-midi.h              |    8 
 drivers/usb/usb-ohci.c              |    3 
 drivers/usb/usb-ohci.h              |    1 
 drivers/usb/usbkbd.c                |    2 
 drivers/usb/usbmouse.c              |    2 
 drivers/usb/usbnet.c                |    4 
 include/linux/usb.h                 |   13 
 48 files changed, 4923 insertions(+), 2387 deletions(-)
-----

ChangeSet@1.1007, 2003-02-20 12:03:09-08:00, andrew.wood@ivarch.com
  [PATCH] USB: USB-MIDI support for Roland SC8820
  
  Please find attached a patch against kernel 2.4.20 which adds support for
  the Roland SC8820 to the USB MIDI driver. It just adds another ID to the
  list of supported devices.
  
  Although Roland have discontinued this product they do still produce a
  development board on request using this chipset, and there are a few SC8820
  boxes still around, so other people may find this patch useful.

 drivers/usb/usb-midi.h |    8 ++++++++
 1 files changed, 8 insertions(+)
------

ChangeSet@1.1006, 2003-02-20 12:02:59-08:00, johannes@erdfelt.com
  [PATCH] USB: 2.4 OHCI trivial comment cleanup
  
  I've been digging into the OHCI driver to understand and/or fix a couple
  of bugs I've been running into and I noticed this comment.
  
  It's not accurate anymore since all 3 HCs use urb->timeout as a relative
  value.

 drivers/usb/usb-ohci.c |    3 ---
 1 files changed, 3 deletions(-)
------

ChangeSet@1.1005, 2003-02-20 12:02:50-08:00, johannes@erdfelt.com
  [PATCH] USB: OHCI trivial remove unused field
  
  While looking at the driver, I noticed this field was not used anymore.
  
  Trivial patch to remove it.

 drivers/usb/usb-ohci.h |    1 -
 1 files changed, 1 deletion(-)
------

ChangeSet@1.1004, 2003-02-20 12:02:41-08:00, d3august@dtek.chalmers.se
  [PATCH] USB: small uhci bug
  
  I noticed that if you modprobe uhci but have no such hardware (it was
  an alpha, with ohci, and I was tired) the module fails to load,
  obviously, but it leaves a proc file behind, /proc/driver/uhci.
  
  The attached patch should fix that, it seemed simple enough. It's not
  tested beyond the fact that it compiles, but I have a good feeling about
  it.

 drivers/usb/uhci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1003, 2003-02-20 11:12:44-08:00, rusty@rustcorp.com.au
  [PATCH] USB: Clean up some USB macros
  
  Reported by Joern Engel.
  
  1) Wrap "ep" arg in brackets.
  2) Make usb_settoggle an inline, to avoid double eval.

 include/linux/usb.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)
------

ChangeSet@1.1002, 2003-02-20 11:12:35-08:00, oliver@neukum.name
  [PATCH] USB: new device id for kaweth
  
    - additional device ID

 drivers/usb/kaweth.c |    1 +
 1 files changed, 1 insertion(+)
------

ChangeSet@1.1001, 2003-02-20 11:12:24-08:00, oliver@neukum.name
  [PATCH] USB: kaweth length calculation fix
  
  this is a fix for the DHCP problem people have reported.
  
    - fix dhcp problem by correct length calculation
    Thanks to Oliver Kurth

 drivers/usb/kaweth.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1000, 2003-02-20 11:12:14-08:00, johannes@erdfelt.com
  [PATCH] usb_get_driver_np() gives wrong driver name (usb_mouse)
  
  On Thu, Feb 06, 2003, Boris Duerner <Marc.Duerner@student.shu.ac.uk> wrote:
  > I use the usb_get_driver_np() function to get the name of the loaded driver
  > for a usb device and I found that for a device using the usbmouse module the
  > wrong driver name is returned. It gives me "usb_mouse" instead of usbmouse.
  > the driver name is also wrong in /proc/bus/usb/drivers but correct in lsmod
  > or /proc/modules resp.
  
  The driver name in /proc/bus/usb/drivers is given differently than from
  /proc/modules.
  
  I'm not exactly sure why the names are seperate, but it leads to
  situations like this where the names won't match for seemingly no good
  reason. The usbkbd driver was even worse, giving it's name as "keyboard".

 drivers/usb/usbkbd.c   |    2 +-
 drivers/usb/usbmouse.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.999, 2003-02-20 11:12:04-08:00, cniehaus@handhelds.org
  [PATCH] spelling fix for drivers_usb_usbnet.c
  
    Hi
  
    This fixes iPaq to iPAQ.
  
    Carsten

 drivers/usb/usbnet.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.998, 2003-02-20 11:11:54-08:00, oliver@neukum.name
  [PATCH] USB: 2.4 ehci uses SLAB_KERNEL in interrupt

 drivers/usb/hcd/ehci-q.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.997, 2003-02-20 11:11:44-08:00, petkan@users.sourceforge.net
  [PATCH] USB: pegasus update (2.4)
  
  These are very small and similar csets against both usb-2.4 and usb-2.5
  trees.  One part of them is adding a missing flag to one of the device
  descriptors.  The other part is fixing a vendor name which i mistakenly
  replaced with the product name.

 drivers/usb/pegasus.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.996, 2003-02-20 11:11:34-08:00, stern@rowland.harvard.edu
  [PATCH] USB: Patches for the ECONNRESET error (2.4)
  
  Matt Dharm asked me to send these bug-fix patches directly to you.  They
  correct the error-code handling in usb-storage.  The change for 2.5 is
  pretty minor; it only affects debugging output.  But the change for 2.4 is
  more pervasive, and according to Tom Collins it is the key to making a usb
  hard disk work on his MIPS-based system.

 drivers/usb/storage/datafab.c       |    4 ++--
 drivers/usb/storage/freecom.c       |   34 +++++++++++++++++-----------------
 drivers/usb/storage/isd200.c        |   10 +++++-----
 drivers/usb/storage/jumpshot.c      |    6 +++---
 drivers/usb/storage/sddr09.c        |    6 +++---
 drivers/usb/storage/sddr55.c        |    4 ++--
 drivers/usb/storage/shuttle_usbat.c |    6 +++---
 drivers/usb/storage/transport.c     |   24 ++++++++++++------------
 8 files changed, 47 insertions(+), 47 deletions(-)
------

ChangeSet@1.995, 2003-02-20 11:11:24-08:00, david-b@pacbell.net
  [PATCH] USB: ehci-hcd, more hangs gone
  
  The key update in this patch is an important qh state machine fix.
  In my testing, that removes hangs that I could reproduce on VIA and
  Philips (much friendlier failures), without resort to sadism.
  
  I suspect VT6202 users will still complain. (I just saw one test
  deadlock in usb-storage; and at least one bug in the EHCI code
  enjoys hide-and-seek too much.)  And the VT8235 and "hdparm -tT"
  numbers are still about half what they should be (on 2.4).

 Documentation/usb/ehci.txt |  103 ++++++++++++++++++++++----------
 drivers/usb/hcd/ehci-dbg.c |  114 +++++++++++++++++++++++++-----------
 drivers/usb/hcd/ehci-hcd.c |   66 ++++++++++++--------
 drivers/usb/hcd/ehci-mem.c |    2 
 drivers/usb/hcd/ehci-q.c   |  142 ++++++++++++++++++++++++++++++---------------
 drivers/usb/hcd/ehci.h     |    9 ++
 6 files changed, 298 insertions(+), 138 deletions(-)
------

ChangeSet@1.994, 2003-02-20 11:11:14-08:00, greg@kroah.com
  [PATCH] USB: added tripp device id's to pl2303 driver.
  
  Thanks to John Moses <jmoses@lanl.gov> for the information.

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.993, 2003-02-20 11:11:04-08:00, p.guehring@futureware.at
  [PATCH] USB: FTDI driver, new id added

 drivers/usb/serial/ftdi_sio.c |    2 ++
 drivers/usb/serial/ftdi_sio.h |    3 +++
 2 files changed, 5 insertions(+)
------

ChangeSet@1.992, 2003-02-20 11:10:54-08:00, wolfgang@iksw-muees.de
  [PATCH] USB: updated Auerswald driver

 drivers/usb/auerswald.c         | 2178 ----------------------------------------
 Documentation/Configure.help    |    2 
 Documentation/usb/auerswald.txt |   10 
 drivers/usb/Config.in           |    2 
 drivers/usb/Makefile            |   11 
 drivers/usb/auerbuf.c           |  148 ++
 drivers/usb/auerbuf.h           |   69 +
 drivers/usb/auerchain.c         |  468 ++++++++
 drivers/usb/auerchain.h         |   79 +
 drivers/usb/auerchar.c          |  615 +++++++++++
 drivers/usb/auerchar.h          |   79 +
 drivers/usb/auerisdn.c          | 1076 +++++++++++++++++++
 drivers/usb/auerisdn.h          |   94 +
 drivers/usb/auerisdn_b.c        |  689 ++++++++++++
 drivers/usb/auerisdn_b.h        |   66 +
 drivers/usb/auermain.c          |  897 ++++++++++++++++
 drivers/usb/auermain.h          |  172 +++
 drivers/usb/auerserv.h          |   47 
 18 files changed, 4520 insertions(+), 2182 deletions(-)
------

ChangeSet@1.991, 2003-02-20 11:10:31-08:00, henning@meier-geinitz.de
  [PATCH] USB scanner.c: Adjust syslog output
  
  This patch prints the vendor + product ids of the scanner after it has
  been successfully detected.
  
  Also the annoying error message about "Scanner device is already open"
  was downgraded to a dbg. Scanning for devices while one scanner device
  was open produced several 100 error messages in syslog.

 drivers/usb/scanner.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)
------

ChangeSet@1.990, 2003-02-20 11:10:22-08:00, greg@kroah.com
  [PATCH] USB: more hid blacklist items.

 drivers/usb/hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.989, 2003-02-20 11:10:12-08:00, greg@kroah.com
  [PATCH] USB: hid blacklist update.

 drivers/usb/hid-core.c |    9 +++++++++
 1 files changed, 9 insertions(+)
------

