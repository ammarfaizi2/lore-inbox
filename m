Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbTC1AIU>; Thu, 27 Mar 2003 19:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261654AbTC1AIT>; Thu, 27 Mar 2003 19:08:19 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19721 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261638AbTC1AHw>;
	Thu, 27 Mar 2003 19:07:52 -0500
Date: Thu, 27 Mar 2003 16:18:00 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.21-pre6
Message-ID: <20030328001800.GA3237@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates and bugfixes for 2.4.21-pre6.  These are all
changes and bugfixes that have been in 2.5 for a while.  Lots of good
memory leak fixes are in here.

There is also a real nasty bugfix for the usb-ohci and usb-storage
drivers that Pete Zaitcev and Arjan van de Ven tracked down.  Many
thanks to them for finding and fixing this problem.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/marcelo-2.4

(note, this is a different address than previous pulls)

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 CREDITS                         |    4 
 MAINTAINERS                     |   23 
 drivers/usb/CDCEther.c          |   23 
 drivers/usb/Makefile            |   12 
 drivers/usb/auerbuf.c           |    4 
 drivers/usb/auermain.c          |    2 
 drivers/usb/dsbr100.c           |   59 -
 drivers/usb/hid-core.c          |    4 
 drivers/usb/host/ehci-dbg.c     |    6 
 drivers/usb/host/ehci-hcd.c     |   15 
 drivers/usb/host/uhci.c         |    2 
 drivers/usb/host/usb-ohci.c     |   22 
 drivers/usb/hub.c               |    4 
 drivers/usb/kaweth.c            |    5 
 drivers/usb/scanner.c           |    7 
 drivers/usb/scanner.h           |   15 
 drivers/usb/serial/io_ti.c      |   22 
 drivers/usb/serial/kobil_sct.c  |    2 
 drivers/usb/serial/pl2303.c     |    1 
 drivers/usb/serial/pl2303.h     |    3 
 drivers/usb/serial/visor.c      |  235 ++++-
 drivers/usb/serial/visor.h      |   39 
 drivers/usb/storage/scsiglue.c  |   23 
 drivers/usb/storage/sddr09.c    | 1823 +++++++++++++++++++++++++++-------------
 drivers/usb/storage/sddr09.h    |    4 
 drivers/usb/storage/transport.c |    4 
 drivers/usb/storage/usb.c       |   10 
 drivers/usb/storage/usb.h       |    6 
 28 files changed, 1702 insertions(+), 677 deletions(-)
-----

ChangeSet@1.1057, 2003-03-27 14:46:26-08:00, arjanv@redhat.com
  [PATCH] usb storage horkage fix
  
  usb-storage and usb-ohci fixes from me and Pete
  * Make detect() not sleep with spinlocks helt
  * Make queuecommand() not sleep with spinlocks helt and/or from
    irq context by transforming the semaphore into a spinlock
  * Fix PCI posting mess in usb-ohci
  * Fix usb-storage abort handling; the completion didn't actually happen
    due to a design bug so on any timeout you get really stuck

 drivers/usb/host/usb-ohci.c    |   22 +++++++++++++++++++---
 drivers/usb/storage/scsiglue.c |   23 +++++++++++++++++------
 drivers/usb/storage/usb.c      |   10 ++++++----
 drivers/usb/storage/usb.h      |    6 +++++-
 4 files changed, 47 insertions(+), 14 deletions(-)
------

ChangeSet@1.1056, 2003-03-26 18:23:39-08:00, greg@kroah.com
  Merge kroah.com:/home/linux/linux/BK/bleed-2.4
  into kroah.com:/home/linux/linux/BK/gregkh-2.4

 MAINTAINERS            |   18 ++++++++++++++++++
 drivers/usb/CDCEther.c |    2 +-
 2 files changed, 19 insertions(+), 1 deletion(-)
------

ChangeSet@1.1006.11.21, 2003-03-25 14:30:45-08:00, greg@kroah.com
  [PATCH] USB: fix up zero packet issues with CDCEther driver

 drivers/usb/CDCEther.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)
------

ChangeSet@1.1006.11.20, 2003-03-25 14:16:08-08:00, bhards@bigpond.net.au
  [PATCH] USB: CDC Ethernet maintainer transfer

 CREDITS     |    4 ++++
 MAINTAINERS |    5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)
------

ChangeSet@1.1006.11.19, 2003-03-25 11:42:33-08:00, stern@rowland.harvard.edu
  [PATCH] USB: Belkin Compact Flash card reader fix
  
  On Sat, 22 Mar 2003, Matthew Dharm wrote:
  
  > I have it, I think... better resend to make certain.
  
  See below.
  
  > It should probably be part of 2.5 also, but I was hoping to hear from JE
  > first about the odd looking code in UHCI.
  
  I think 2.5 doesn't need it; the odd code in question was moved from uhci
  into the upper hcd layer and fixed (or removed) along the way.  But I
  don't have the source here so I can't be sure about that.  It certainly
  seems strange, though -- without this change the driver would fail
  everything once an abort occurred on a uhci host.
  
  Alan Stern

 drivers/usb/storage/transport.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.1006.11.18, 2003-03-25 11:15:54-08:00, davem@redhat.com
  [PATCH] USB: fix for host controler build
  
   Moving the HCD drivers under drivers/usb/host in 2.4.x makes
   them not get built statically into the kernel successfully any
   more.

 drivers/usb/Makefile |   12 ++++++++++++
 1 files changed, 12 insertions(+)
------

ChangeSet@1.1006.11.17, 2003-03-20 15:24:42-08:00, greg@kroah.com
  [PATCH] USB: usb-storage bugfix.

 drivers/usb/storage/transport.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1006.11.16, 2003-03-20 14:19:53-08:00, henning@meier-geinitz.de
  [PATCH] USB: New ids for scanner driver
  
  this patch adds some more vendor/product ids for the USB scanner driver.

 drivers/usb/scanner.c |    7 ++++---
 drivers/usb/scanner.h |   15 ++++++++++++++-
 2 files changed, 18 insertions(+), 4 deletions(-)
------

ChangeSet@1.1006.11.15, 2003-03-20 14:19:13-08:00, jmcmullan@linuxcare.com
  [PATCH] USB HID: Ignore P5 Data Glove
  
    As requested, here are the 2.4 (latest BK tree) and 2.5 (latest bk
    tree) patches to ignore the non-HID Essential Reality Data Glove
  
    (again, user-space lib to access this device via /proc/bus/usb
     is available at http://www.evillabs.net/~jmcc/p5)

 drivers/usb/hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.1006.11.14, 2003-03-19 14:35:42-08:00, wolfgang@iksw-muees.de
  [PATCH] USB: Memory leak in auerswald driver
  
  Oleg Drokin <green@linuxhacker.ru> has reported a memory leak in auerbuf.c,
  which is only exposed under low memory conditions.
  
  The appended patch fixes this leak. It is for 2.4.21.

 drivers/usb/auerbuf.c  |    4 +++-
 drivers/usb/auermain.c |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)
------

ChangeSet@1.1006.11.13, 2003-03-19 13:07:35-08:00, david-b@pacbell.net
  [PATCH] USB: ehci-hcd, prink tweaks
  
  A not-very interesting patch, it just cleans up
  some debug output.

 drivers/usb/host/ehci-dbg.c |    6 +++---
 drivers/usb/host/ehci-hcd.c |   15 ++++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)
------

ChangeSet@1.1006.11.12, 2003-03-14 15:02:47-08:00, greg@kroah.com
  [PATCH] USB: added support for Ericsson data cable to pl2303 driver.
  
  Thanks to kai.engert@gmx.de for the needed information

 drivers/usb/serial/pl2303.c |    1 +
 drivers/usb/serial/pl2303.h |    3 +++
 2 files changed, 4 insertions(+)
------

ChangeSet@1.1006.11.11, 2003-03-14 12:14:42-08:00, greg@kroah.com
  [PATCH] USB: fixup from previous io_ti.c patch

 drivers/usb/serial/io_ti.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.1006.11.10, 2003-03-14 12:10:15-08:00, green@linuxhacker.ru
  [PATCH] USB: memleak in Edgeport USB Serial Converter driver

 drivers/usb/serial/io_ti.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)
------

ChangeSet@1.1006.11.9, 2003-03-14 11:49:08-08:00, green@linuxhacker.ru
  [PATCH] USB: Memleak in drivers/usb/hub.c::usb_reset_device
  
     There seems to be a memleak in drivers/usb/hub.c::usb_reset_device()
     on error exit path. See the patch.
     Found with help of smatch + enhanced unfree script.

 drivers/usb/hub.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)
------

ChangeSet@1.1006.11.8, 2003-03-14 11:29:37-08:00, green@linuxhacker.ru
  [PATCH] USB: more Edgeport USB Serial Converter driver stuff

 drivers/usb/serial/io_ti.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.1006.11.7, 2003-03-14 10:48:09-08:00, johannes@erdfelt.com
  [PATCH] USB: uhci.c 2.4 finish completions in the correct order
  
  Here's a patch to finish completions in the order they occur. This
  brings uhci.c in line with the other HCDs and what people generally
  would expect.

 drivers/usb/host/uhci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1006.11.6, 2003-03-14 10:47:15-08:00, green@linuxhacker.ru
  [PATCH] Memleak in KOBIL USB Smart Card Terminal Driver
  
     There is a memleak on error exit path in KOBIL USB Smart Card Terminal
     Driver in both current 2.4 and 2.5.
     See the patch.
     Found with help of smatch + enhanced unfree script.

 drivers/usb/serial/kobil_sct.c |    2 ++
 1 files changed, 2 insertions(+)
------

ChangeSet@1.1006.11.5, 2003-03-11 17:45:38-08:00, greg@kroah.com
  [PATCH] USB: add support for Treo devices to the visor driver
  
  Thanks to Adam Pennington <adamp@coed.org> for the bulk of this work.

 drivers/usb/serial/visor.c |  227 +++++++++++++++++++++++++++++++++++++--------
 drivers/usb/serial/visor.h |   37 ++++++-
 2 files changed, 223 insertions(+), 41 deletions(-)
------

ChangeSet@1.1006.11.4, 2003-03-11 17:33:41-08:00, greg@kroah.com
  [PATCH] USB: Added support for the Sony Clie NZ90V device.
  
  Thanks to Martin Brachtl <brachtl@redgrep.cz> for the information.

 drivers/usb/serial/visor.c |    6 ++++++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 7 insertions(+)
------

ChangeSet@1.1006.11.3, 2003-03-11 17:22:11-08:00, msdemlei@cl.uni-heidelberg.de
  [PATCH] USB: Patch for DSBR-100 driver
  
  This is mainly code cosmetics
  (fixed ugly missing spaces after commas I inherited from the
  aztech driver, some constants moved to preprocessor symbols), but
  there's one technical change: I used to stop the radio when my
  file descriptor was closed.  Petr Slansky <slansky@usa.net>
  pointed out that the other radio drivers don't do that, so
  now I just let the radio run.
  
  In the interest of a consistent interface on the v4l side, this
  patch should be applied.

 drivers/usb/dsbr100.c |   59 +++++++++++++++++++++++++++-----------------------
 1 files changed, 32 insertions(+), 27 deletions(-)
------

ChangeSet@1.1006.11.2, 2003-03-11 17:19:41-08:00, Andries.Brouwer@cwi.nl
  [PATCH] USB: add better sddr09 support

 drivers/usb/storage/sddr09.c | 1823 ++++++++++++++++++++++++++++++-------------
 drivers/usb/storage/sddr09.h |    4 
 2 files changed, 1276 insertions(+), 551 deletions(-)
------

ChangeSet@1.1006.11.1, 2003-03-11 17:00:38-08:00, greg@kroah.com
  [PATCH] USB: added support for the palm M100
  
  Thanks to C Falconer <cf@avonside.school.nz> for the information.

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.1006.4.24, 2003-03-05 22:12:42-08:00, okurth@gmx.net
  [PATCH] USB: MTU patch for kaweth
  
  Recently, I had problems using NFS with my kaweth device, tcpdump showed
  fragmented packages. The reason, I found, was the MTU, which is 1514
  by default for kaweth. Setting it to 1500 solved the problems. The
  attached patch sets the MTU to 1500 by default.

Push file://home/greg/linux/BK/gregkh-2.4 -> file://home/greg/linux/BK/bleed-2.4
 drivers/usb/kaweth.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
------

