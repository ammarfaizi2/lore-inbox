Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265236AbSLBG5k>; Mon, 2 Dec 2002 01:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbSLBG5j>; Mon, 2 Dec 2002 01:57:39 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37894 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265236AbSLBG50>;
	Mon, 2 Dec 2002 01:57:26 -0500
Date: Mon, 2 Dec 2002 00:05:14 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.50
Message-ID: <20021202080514.GA11936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/core/devio.c        |   63 +++++++++-------------
 drivers/usb/core/hcd-pci.c      |   31 ++++++-----
 drivers/usb/core/hcd.c          |   11 +--
 drivers/usb/core/usb.c          |   43 ++++++---------
 drivers/usb/host/ehci-dbg.c     |   46 +++++++++-------
 drivers/usb/host/ehci-hcd.c     |   76 ++++++++++++++++-----------
 drivers/usb/host/ehci-hub.c     |   19 ++----
 drivers/usb/host/ehci-mem.c     |   45 +++++++---------
 drivers/usb/host/ehci-q.c       |  111 ++++++++++++++++------------------------
 drivers/usb/host/uhci-hcd.c     |    4 -
 drivers/usb/serial/usb-serial.c |   53 ++++++++++---------
 drivers/usb/storage/transport.c |    2 
 12 files changed, 243 insertions(+), 261 deletions(-)
-----

ChangeSet@1.924.3.11, 2002-11-30 22:28:49-08:00, oliver@oenone.homelinux.org
  [PATCH] USB core: cleanup BKL

 drivers/usb/core/devio.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)
------

ChangeSet@1.924.3.10, 2002-11-30 22:20:27-08:00, greg@kroah.com
  [PATCH] USB: get previous module patch to even build properly...

 drivers/usb/core/devio.c |    2 +-
 drivers/usb/core/usb.c   |   13 ++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)
------

ChangeSet@1.924.3.9, 2002-11-30 22:19:57-08:00, oliver@oenone.homelinux.org
  [PATCH] - cleanup for new module primitives

 drivers/usb/core/devio.c |   16 +++++++---------
 drivers/usb/core/usb.c   |   30 ++++++++++++------------------
 2 files changed, 19 insertions(+), 27 deletions(-)
------

ChangeSet@1.924.3.8, 2002-11-30 22:09:07-08:00, whitney@math.berkeley.edu
  [PATCH] uhci-hcd.c shouldn't halt control endpoints
  
  uhci-hcd.c currently calls usb_endpoint_halt() in the td_error: path of
  uhci_result_control().  David Brownell told me that "control endpoints
  don't halt" and that this is wrong.  The patch below fixes this and allows
  my Belkin Universal UPS to work.  [Although it still prints lots of
  "drivers/usb/input/hid-core.c: ctrl urb status -32 received" messages.]
  Greg K-H, could you merge this if it looks right?  David mentioned that
  the same bug exists in 2.4.x.

 drivers/usb/host/uhci-hcd.c |    4 ----
 1 files changed, 4 deletions(-)
------

ChangeSet@1.924.3.7, 2002-11-30 00:09:00-08:00, david-b@pacbell.net
  [PATCH] ehci, more diagnostics use dev_*() macros
  
  This reduces the quantity of messages, by using the
  newer dev_*() macros, and by deleting some messages.

 drivers/usb/host/ehci-dbg.c |   27 ++++++++++++---------------
 drivers/usb/host/ehci-hcd.c |   40 +++++++++++++++++++++-------------------
 drivers/usb/host/ehci-hub.c |   19 +++++++------------
 drivers/usb/host/ehci-mem.c |    6 ++----
 drivers/usb/host/ehci-q.c   |    5 +++--
 5 files changed, 45 insertions(+), 52 deletions(-)
------

ChangeSet@1.924.3.6, 2002-11-30 00:08:43-08:00, david-b@pacbell.net
  [PATCH] ehci-hcd, handle async_next register correctly
  
  This patch should improve behavior of the EHCI driver,
  particularly on VIA hardware.
  
    - A more careful reading of the EHCI spec turns up
      requirements not to change this register's value
      while the async schedule is enabled.  That means
      in effect that it must never point to a QH that'd
      get unlinked ... driver now uses a dedicated QH.
  
    - Disables async schedule a bit faster:  after 50msec
      idle, not 330msec idle.
  
    - Streamline the "can't init memory" failure path.
  
    - Start to use the dev_dbg()/dev_info()/... macros
      in more places.
  
  This version acts a bunch happier than the previous
  version, removing some failure modes I could never
  quite convince myself were hardware (they weren't!)
  I suspect it'll remove a lot of the "it hangs" failures
  that some folk have reported (mostly on 2.4 though).

 drivers/usb/host/ehci-dbg.c |   19 +++++--
 drivers/usb/host/ehci-hcd.c |   36 ++++++++++----
 drivers/usb/host/ehci-mem.c |   39 ++++++++--------
 drivers/usb/host/ehci-q.c   |  106 ++++++++++++++++++--------------------------
 4 files changed, 103 insertions(+), 97 deletions(-)
------

ChangeSet@1.924.3.5, 2002-11-30 00:08:25-08:00, david-b@pacbell.net
  [PATCH] reduce debug message volume
  
  This reduces the debug message volume a bit, mostly by using the
  new dev_dbg() macros instead of the usb dbg() ones in some places
  during HCD init/shutdown.  Likewise dev_info().

 drivers/usb/core/hcd-pci.c |   31 ++++++++++++++++++-------------
 drivers/usb/core/hcd.c     |   11 +++--------
 2 files changed, 21 insertions(+), 21 deletions(-)
------

ChangeSet@1.924.3.4, 2002-11-30 00:08:09-08:00, david-b@pacbell.net
  [PATCH] usb-storage doesn't say clear_halt WORKED
  
  This removes a printk that's been cluttering up my logs,
  especially when I do things like 'mkfs -c ...' it doesn't
  seem to be needed any more.

 drivers/usb/storage/transport.c |    2 --
 1 files changed, 2 deletions(-)
------

ChangeSet@1.924.3.3, 2002-11-30 00:03:51-08:00, baldrick@wanadoo.fr
  [PATCH] usbfs: more list cleanups
  
  Here is a small cleanup patch for 2.5 that goes on top of my previous
  ones.  It makes devio.c use the list traversal macros from list.h.

 drivers/usb/core/devio.c |   29 ++++++++++-------------------
 1 files changed, 10 insertions(+), 19 deletions(-)
------

ChangeSet@1.924.3.2, 2002-11-30 00:02:08-08:00, greg@kroah.com
  [PATCH] USB serial: cleaned up the rest of the __MOD_INC and __MOD_DEC calls to use the new module API

 drivers/usb/serial/usb-serial.c |   44 ++++++++++++++++++++--------------------
 1 files changed, 23 insertions(+), 21 deletions(-)
------

ChangeSet@1.924.3.1, 2002-11-30 00:01:04-08:00, oliver@oenone.homelinux.org
  [PATCH] module unload race with usb serial drivers
  
  the serial subdrivers may be unloading while we open.
  This patch against 2.5 guards against that.

 drivers/usb/serial/usb-serial.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)
------

