Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267930AbTAHUOT>; Wed, 8 Jan 2003 15:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267960AbTAHUOT>; Wed, 8 Jan 2003 15:14:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47627 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267930AbTAHUN5>;
	Wed, 8 Jan 2003 15:13:57 -0500
Date: Wed, 8 Jan 2003 12:22:13 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.54
Message-ID: <20030108202213.GA5018@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's some more USB changes, including a change to the dev_printk()
macro to take a pointer instead of a reference to struct device.  This
was requested by a lot of different people, with Randy Dunlap being the
most persistent :)

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/usb/scanner-hp-sane.txt |   79 --------
 Documentation/usb/scanner.txt         |  329 +++++++++++++---------------------
 drivers/usb/class/usblp.c             |    3 
 drivers/usb/core/hcd-pci.c            |   16 -
 drivers/usb/core/hcd.c                |   34 +--
 drivers/usb/core/hub.c                |   70 +++----
 drivers/usb/core/usb-debug.c          |    2 
 drivers/usb/core/usb.c                |   38 +--
 drivers/usb/host/ehci-dbg.c           |    8 
 drivers/usb/host/ehci-hcd.c           |   11 -
 drivers/usb/host/ehci-q.c             |   19 +
 drivers/usb/host/ehci.h               |    2 
 drivers/usb/host/ohci-dbg.c           |   35 ++-
 drivers/usb/host/ohci-hcd.c           |   10 -
 drivers/usb/host/ohci-hub.c           |    2 
 drivers/usb/host/ohci-mem.c           |    2 
 drivers/usb/host/ohci-q.c             |    4 
 drivers/usb/image/Kconfig             |    4 
 drivers/usb/image/mdc800.c            |    4 
 drivers/usb/image/scanner.c           |  203 +++++++-------------
 drivers/usb/image/scanner.h           |   24 --
 drivers/usb/input/pid.c               |   45 +---
 drivers/usb/misc/Makefile             |    6 
 drivers/usb/misc/atmsar.c             |  177 +++++++-----------
 drivers/usb/misc/atmsar.h             |   27 +-
 drivers/usb/misc/auerswald.c          |    7 
 drivers/usb/misc/brlvger.c            |   21 --
 drivers/usb/misc/rio500.c             |    5 
 drivers/usb/misc/speedtouch.c         |   80 ++++----
 drivers/usb/misc/usbtest.c            |  306 +++++++++++++++++++++++++++++++
 drivers/usb/net/kaweth.c              |    8 
 drivers/usb/net/pegasus.c             |    5 
 drivers/usb/net/pegasus.h             |    4 
 drivers/usb/net/rtl8150.c             |    5 
 drivers/usb/net/usbnet.c              |   22 ++
 drivers/usb/serial/bus.c              |    9 
 drivers/usb/serial/empeg.c            |   12 -
 drivers/usb/serial/ezusb.c            |    4 
 drivers/usb/serial/generic.c          |    6 
 drivers/usb/serial/io_edgeport.c      |   38 +--
 drivers/usb/serial/io_ti.c            |   58 ++---
 drivers/usb/serial/ir-usb.c           |   16 -
 drivers/usb/serial/keyspan.c          |    6 
 drivers/usb/serial/pl2303.c           |   18 -
 drivers/usb/serial/usb-serial.c       |   38 +--
 drivers/usb/serial/usb-serial.h       |    2 
 drivers/usb/serial/visor.c            |   48 ++--
 drivers/usb/serial/whiteheat.c        |    4 
 drivers/usb/storage/freecom.c         |    4 
 drivers/usb/storage/transport.c       |  307 -------------------------------
 drivers/usb/storage/transport.h       |    1 
 include/linux/device.h                |   36 ++-
 52 files changed, 1021 insertions(+), 1203 deletions(-)
-----

ChangeSet@1.897.1.8, 2003-01-08 10:21:15-08:00, neilt@slimy.greenend.org.uk
  [PATCH] USB Serial patch for old pl2303 devices.
  
  I got a PL2303 USB serial converter a few days ago, and got your driver
  up and running fairly quickly.  The problem is that I got an oops when I
  rmmod-ed the drivers.  The pl2303 uses two interfaces but registers only
  the second (technically wrong, I guess, but should work).  When pl2303.o
  is removed, it attempts to deregister the first interface (which has no
  effect), so the second interface remains registered with usbserial.  The
  old struct serial still points at the removed pl2303 driver so things go
  pop when anything touches it.
  
  I think the PL2303 hack in usb_serial_probe should not change the
  "interface" variable, which gets stored in serial->interface, since
  usbcore will register whatever "ifnum" says.  I think that's enough
  waffle.  The patch is below.  Keep up the good work!

 drivers/usb/serial/usb-serial.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)
------

ChangeSet@1.897.1.7, 2003-01-08 10:09:32-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c, scanner.h: Use symbolic name for interface class
  
  Hi,
  
  On Wed, Jan 08, 2003 at 08:29:36AM -0800, Greg KH wrote:
  > On Tue, Dec 24, 2002 at 05:44:55PM +0100, Henning Meier-Geinitz wrote:
  > > Hi,
  > >
  > > On Tue, Dec 24, 2002 at 12:40:06AM +0100, Oliver Neukum wrote:
  > > >
  > > > > Well, the reason I didn't use one was that I didn't found one in
  > > > > usb.h/usb_ch9.h for 16. It's also not listed on www.usb.org.
  > > > >
  > > > > lsusb calls it "Data". However, I'm not sure if this is a hex/dec
  > > > > error and they really mean "Data" = dec 10, not 0x10 (=dec 16).
  > > > >
  > > > > Shall I define a local symbolic name (e.g.
  > > > > STRANGE_HP_SCANJET_INTERFACE_CLASS)? But I really don't know what this
  > > > > class is. I only know that it's used by a Hewlett-Packard ScanJet
  > > > > 3300c and Genius HR6 USB - Vivid III.
  > > >
  > > > Better that than a bare number.
  > >
  > > Patch attached.
  >
  > Applied to my 2.4 tree, sorry for the delay.
  
  Here is the same for 2.5.44:

 drivers/usb/image/scanner.c |    2 +-
 drivers/usb/image/scanner.h |    3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)
------

ChangeSet@1.897.1.6, 2003-01-08 09:32:25-08:00, baldrick@wanadoo.fr
  [PATCH] USB: speedtouch: add GPL notices
  
  speedtouch and friends: add GPL notices (yes, the module was released by Alcatel
  under the GPL) and fix some typos.

 drivers/usb/misc/atmsar.c     |  146 +++++++++++++++++++++---------------------
 drivers/usb/misc/atmsar.h     |   27 +++++--
 drivers/usb/misc/speedtouch.c |   72 ++++++++++++--------
 3 files changed, 138 insertions(+), 107 deletions(-)
------

ChangeSet@1.897.1.5, 2003-01-08 09:32:04-08:00, duncan.sands@math.u-psud.fr
  [PATCH] USB: speedtouch: remove version string duplication
  
  speedtouch: remove udsl_version in favour of DRIVER_VERSION (which it duplicated).

 drivers/usb/misc/speedtouch.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)
------

ChangeSet@1.897.1.4, 2003-01-08 09:31:41-08:00, baldrick@wanadoo.fr
  [PATCH] USB: speedtouch missing __init and __exit
  
  speedtouch: add __init and __exit to the module init/exit routines.

 drivers/usb/misc/speedtouch.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.897.1.3, 2003-01-08 09:31:20-08:00, baldrick@wanadoo.fr
  [PATCH] USB: atmsar is not a module
  
  atmsar is not a module in its own right, it is an auxiliary library for speedtouch.
  So remove module code from atmsar and build module speedtch from speedtouch and
  atmsar.  Note the module name change speedtouch -> speedtch (speedtch is the name
   used for the original 2.4 module, and is the name used in the online documentation).

 drivers/usb/misc/Makefile |    6 +++---
 drivers/usb/misc/atmsar.c |   31 -------------------------------
 2 files changed, 3 insertions(+), 34 deletions(-)
------

ChangeSet@1.897.1.2, 2003-01-08 08:23:03-08:00, henning@meier-geinitz.de
  [PATCH] [PATCH 2.5.54] scanner.c: endpoint detection cleanup
  
  This patch makes endpoint detection more generic. Basically, only one bulk-in
  endpoint is required, everything else is optional.
  
  The patch is on top of the PV8630 removal patch.

 drivers/usb/image/scanner.c |   55 ++++++++++++++++----------------------------
 1 files changed, 21 insertions(+), 34 deletions(-)
------

ChangeSet@1.897.1.1, 2003-01-07 21:29:37-08:00, greg@kroah.com
  Merge kroah.com:/home/linux/linux/BK/bleeding-2.5
  into kroah.com:/home/linux/linux/BK/gregkh-2.5

 include/linux/device.h |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)
------

ChangeSet@1.879.9.26, 2003-01-07 15:45:51-08:00, greg@kroah.com
  [PATCH] USB serial: fixup for probe function paramaters changing.

 drivers/usb/serial/visor.c     |    4 ++--
 drivers/usb/serial/whiteheat.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.879.9.25, 2003-01-07 15:45:31-08:00, greg@kroah.com
  [PATCH] USB serial: pass the usb_device_id to the probe() function
  
  This is needed for drivers that want to use the driver_info field.

 drivers/usb/serial/usb-serial.c |    2 +-
 drivers/usb/serial/usb-serial.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.879.9.24, 2003-01-07 15:34:35-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c, scanner.h: Remove PV8630 ioctls
  
  This patch removes the inofficial ioctls that were used to support the
  PV8630 USB-over-Parport chipset. They were alreaded ifdefed out.
  Instead of them, the more generic (and official) SCANNER_IOCTL_CTRLMSG
  should be used. The last software that used the old ioctl
  (sane-hp4200) switched to the new ioctls a long time ago.
  
  This patch is ontop of the "user-supplied" patch.

 drivers/usb/image/scanner.c |   60 +-------------------------------------------
 drivers/usb/image/scanner.h |   17 +-----------
 2 files changed, 4 insertions(+), 73 deletions(-)
------

ChangeSet@1.879.9.23, 2003-01-07 15:22:11-08:00, pablo@menichini.com.ar
  [PATCH] 2.5.54 dev_*(&<dev>,...): drivers/usb/input/pid.c

 drivers/usb/input/pid.c |   45 +++++++++++++++------------------------------
 1 files changed, 15 insertions(+), 30 deletions(-)
------

ChangeSet@1.879.9.22, 2003-01-07 15:10:35-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: print user-supplied ids only on start-up
  
  With this patch, information about user-supplied ids is printed only
  once at startup instead of everytime any USB device is plugged in.
  
  The patch is on top of the new ids patch.

 drivers/usb/image/scanner.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.879.9.21, 2003-01-07 15:10:17-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c, scanner.h: Added vendor/product ids
  
  This patch adds vendor/product ids for two Visioneer scanners.
  
  The patch is on top of the ioctl patch.

 drivers/usb/image/scanner.c |    5 ++++-
 drivers/usb/image/scanner.h |    4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)
------

ChangeSet@1.879.9.20, 2003-01-07 15:09:59-08:00, henning@meier-geinitz.de
  [PATCH] USB scanner driver: updated Kconfig
  
  This patch removes the link in Kconfig to
  Documentation/usb/scanner-hp-sane.txt which was removed by the
  documentation update.

 drivers/usb/image/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.879.9.19, 2003-01-07 15:09:40-08:00, henning@meier-geinitz.de
  [PATCH] USB scanner driver: updated documentation
  
  This patch updates the documentation for the USB scanner driver. The
  details:
  
  Documentation/usb/scanner.txt:
    - Amended for linux-2.5.54
    - Added information about read_timeout
    - Added more details about /proc/bus/usb/devices
    - Added/updated links
    - Added pointers two "special" scanner drivers
    - Reordering, spell-checking, formatting
    - Used /dev/usb/scanner[0-15] instead of /dev/usbscanner[0-15]
    - Removed some basic USB configuration stuff
    - Added EHCI
    - Removed some more references to HP
  
  Documentation/usb/scanner-hp-sane.txt:
    Removed completely. This was a very outdated text for some HP
    scanners. All of this is explained in the documentation of the
    user-space SANE tools. Links and a short explanation about SANE was
    added to scanner.txt instead.
  
  This is the (slightly adapted) patch you already apllied for 2.4.

 Documentation/usb/scanner-hp-sane.txt |   79 --------
 Documentation/usb/scanner.txt         |  329 +++++++++++++---------------------
 2 files changed, 134 insertions(+), 274 deletions(-)
------

ChangeSet@1.879.9.18, 2003-01-07 15:09:22-08:00, henning@meier-geinitz.de
  [PATCH] scanner.c: fix race in ioctl_scanner()
  
  This patch adds locking to ioctl_scanner() which was completely
  lacking until now. The patch is originally from Oliver Neukum
  <oliver@neukum.name>.
  
  The patch was forward-ported from 2.4.

 drivers/usb/image/scanner.c |   73 ++++++++++++++++++++++++++------------------
 1 files changed, 44 insertions(+), 29 deletions(-)
------

ChangeSet@1.879.9.17, 2003-01-07 14:52:33-08:00, greg@kroah.com
  [PATCH] USB: drivers/usb/serial/ fixups due to dev_printk change

 drivers/usb/serial/bus.c         |    9 +++---
 drivers/usb/serial/empeg.c       |   12 ++++----
 drivers/usb/serial/ezusb.c       |    4 +-
 drivers/usb/serial/generic.c     |    6 ++--
 drivers/usb/serial/io_edgeport.c |   38 ++++++++++++-------------
 drivers/usb/serial/io_ti.c       |   58 +++++++++++++++++++--------------------
 drivers/usb/serial/ir-usb.c      |   16 +++++-----
 drivers/usb/serial/keyspan.c     |    6 ++--
 drivers/usb/serial/pl2303.c      |   18 ++++++------
 drivers/usb/serial/usb-serial.c  |   32 ++++++++++-----------
 drivers/usb/serial/visor.c       |   44 ++++++++++++++---------------
 11 files changed, 122 insertions(+), 121 deletions(-)
------

ChangeSet@1.879.9.16, 2003-01-07 14:52:13-08:00, greg@kroah.com
  [PATCH] USB: drivers/usb/host/ fixups due to dev_printk change

 drivers/usb/host/ehci-dbg.c |    8 ++++----
 drivers/usb/host/ohci-dbg.c |   22 +++++++++++-----------
 drivers/usb/host/ohci-hcd.c |   10 +++++-----
 drivers/usb/host/ohci-hub.c |    2 +-
 drivers/usb/host/ohci-mem.c |    2 +-
 drivers/usb/host/ohci-q.c   |    4 ++--
 6 files changed, 24 insertions(+), 24 deletions(-)
------

ChangeSet@1.879.9.15, 2003-01-07 14:51:54-08:00, greg@kroah.com
  [PATCH] USB: drivers/usb/core/ fixups due to dev_printk change

 drivers/usb/core/hcd-pci.c   |   16 ++++-----
 drivers/usb/core/hcd.c       |   34 ++++++++++----------
 drivers/usb/core/hub.c       |   70 +++++++++++++++++++++----------------------
 drivers/usb/core/usb-debug.c |    2 -
 drivers/usb/core/usb.c       |   38 +++++++++++------------
 5 files changed, 80 insertions(+), 80 deletions(-)
------

ChangeSet@1.879.9.14, 2003-01-07 14:51:34-08:00, greg@kroah.com
  [PATCH] DEV: change dev_printk() to take a pointer to dev instead of the structure itself.
  
  This was suggested by many people, Randy Dunlap being the most vocal :)

 include/linux/device.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)
------

ChangeSet@1.879.9.13, 2003-01-07 12:59:07-08:00, greg@kroah.com
  [PATCH] USB mdc800: forward port 2.4 fix for misuse of types.
  
  Thanks to Dave Jones for pointing this out.

 drivers/usb/image/mdc800.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.879.9.12, 2003-01-07 12:57:25-08:00, greg@kroah.com
  [PATCH] USB printer driver: forward port 2.4 fix for misuse of types.
  
  Thanks to Dave Jones for pointing this out.

 drivers/usb/class/usblp.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.879.9.11, 2003-01-07 12:55:14-08:00, greg@kroah.com
  [PATCH] USB: removed MOD_INC_USE_COUNT and MOD_DEC_USE_COUNT from driver that do not need it.

 drivers/usb/misc/auerswald.c |    7 -------
 drivers/usb/misc/brlvger.c   |   18 +++++-------------
 drivers/usb/misc/rio500.c    |    5 +----
 3 files changed, 6 insertions(+), 24 deletions(-)
------

ChangeSet@1.879.9.10, 2003-01-06 17:26:56-08:00, greg@kroah.com
  USB brlvger: Forward port 2.4 fix for misuse of types.
  
  Thanks to Dave Jones for pointing this out.

 drivers/usb/misc/brlvger.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

ChangeSet@1.879.9.9, 2003-01-06 16:35:55-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] USB storage: remove usb_stor_tranfer_length()
  
  This patch removes the (often troublesome) usb_stor_transfer_length()
  function.
  
  We've finally gotten all the command initiators to send the correct values
  in the srb->request_bufflen field, so this is no longer needed.
  
  There are probably some sanity checks that can also be removed now, but
  that's for a later patch.

 drivers/usb/storage/freecom.c   |    4 
 drivers/usb/storage/transport.c |  307 ----------------------------------------
 drivers/usb/storage/transport.h |    1 
 3 files changed, 5 insertions(+), 307 deletions(-)
------

ChangeSet@1.879.9.8, 2003-01-06 16:31:07-08:00, greg@kroah.com
  USB: revert davem's compile time fix, now that it's fixed properly.

 drivers/usb/host/ohci-dbg.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.879.9.7, 2003-01-06 16:21:39-08:00, david-b@pacbell.net
  [PATCH] usbtest, covers control queueing and fault cleanup
  
  I wrote this a while back, finally debugged it.  This covers
  some functionality that 2.5 newly demands of all HCDs:  control
  requests can be queued.  (Example:  a user mode driver can talk
  on one interface, and a kernel mode one can talk on another,
  no need to handshake about who can make control requests.)
  
  The good news is that all the HCDs seem (light testing) to do
  the right things ... until some of the requests (intentionally)
  trigger routine faults (like protocol stalls) which the HCDs
  need to recover from.  At that point, uhci-hcd started acting
  confused (it's got newish queueing code); details will come
  separately.  The other two HCDs acted fine.  I had expected more
  trouble there, maybe it'll show up later on.

 drivers/usb/misc/usbtest.c |  306 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 304 insertions(+), 2 deletions(-)
------

ChangeSet@1.879.9.6, 2003-01-06 16:21:21-08:00, david-b@pacbell.net
  [PATCH] 2.5.54 -- ohci-dbg.c: 358: In function `show_list': `data1'
  
  OK here's the version that without the kernel version #ifdef
  that helped the backport ... it fixes the build by restoring
  the "debug support only if CONFIG_USB_DEBUG" semantics.

 drivers/usb/host/ohci-dbg.c |   11 +++++++++++
 1 files changed, 11 insertions(+)
------

ChangeSet@1.879.9.5, 2003-01-06 16:01:14-08:00, oliver@neukum.name
  [PATCH] USB: kaweth freeing skbs
  
  this is the 2.5 version of the 2.4 fix
    - proper freeing of skbs

 drivers/usb/net/kaweth.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)
------

ChangeSet@1.879.9.4, 2003-01-06 15:58:15-08:00, petkan@users.sourceforge.net
  [PATCH] again rtl8150
  
  this diff is agains the latest linux-2.5;
  set mac address at dev->open()
  (as per Jeff Garzik :-)

 drivers/usb/net/rtl8150.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
------

ChangeSet@1.879.9.3, 2003-01-06 15:55:16-08:00, petkan@users.sourceforge.net
  [PATCH] USB pegasus: small patch for 2.5
  
  Same as the previous email, just against latest linux-2.5 tree.  Sorry
  about the diffs - i can't sync with usb-2.5.

 drivers/usb/net/pegasus.c |    5 ++++-
 drivers/usb/net/pegasus.h |    4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)
------

ChangeSet@1.879.9.2, 2003-01-06 15:48:03-08:00, david-b@pacbell.net
  [PATCH] zaurus B500 (sl-5600?) & usbnet
  
  More Zaurii.  That model will be interesting from the
  perspective of "usb gadget drivers", lots of flexible
  endpoints are available.

 drivers/usb/net/usbnet.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)
------

ChangeSet@1.879.9.1, 2003-01-06 15:47:26-08:00, david-b@pacbell.net
  [PATCH] ehci, remove potential hangs
  
  These don't affect the hang I'm hunting for, but paranoia
  argues the patch is better integrated than not:
  
  - prevent resubmit-from-completion looping in_irq if the
     transfers complete really fast.  (likely never seen, but...)
  
  - grab ehci lock before reading irq status; should be harmless
     except in one host error cleanup-after-death

 drivers/usb/host/ehci-hcd.c |   11 +++++++----
 drivers/usb/host/ehci-q.c   |   19 +++++++++++++------
 drivers/usb/host/ehci.h     |    2 ++
 3 files changed, 22 insertions(+), 10 deletions(-)
------

