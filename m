Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261619AbTCTXP5>; Thu, 20 Mar 2003 18:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263294AbTCTXP4>; Thu, 20 Mar 2003 18:15:56 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:56069 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261619AbTCTXPo>;
	Thu, 20 Mar 2003 18:15:44 -0500
Date: Thu, 20 Mar 2003 15:26:59 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.65
Message-ID: <20030320232658.GA5701@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some small USB changes.  Some speedtouch movements, and some
small bugfixes, nothing major.  There is a bug when removing hubs that
is still present in 2.5.65, that I can reproduce but haven't tracked
down yet...

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/usb/misc/atmsar.c      |  380 ----------
 drivers/usb/misc/atmsar.h      |   87 --
 drivers/usb/misc/speedtouch.c  | 1216 --------------------------------
 drivers/usb/core/hub.c         |   27 
 drivers/usb/core/message.c     |    4 
 drivers/usb/host/ehci-dbg.c    |    6 
 drivers/usb/host/ehci-hcd.c    |   15 
 drivers/usb/image/scanner.c    |    5 
 drivers/usb/image/scanner.h    |   13 
 drivers/usb/input/hid-core.c   |    4 
 drivers/usb/misc/Makefile      |    2 
 drivers/usb/misc/speedtch.c    | 1514 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/misc/speedtouch.c  |   53 -
 drivers/usb/net/cdc-ether.c    |   20 
 drivers/usb/net/pegasus.c      |    6 
 drivers/usb/serial/whiteheat.c |    2 
 drivers/usb/usb-skeleton.c     |  229 ++++--
 17 files changed, 1747 insertions(+), 1836 deletions(-)
-----

ChangeSet@1.1143.1.11, 2003-03-20 14:03:46-08:00, henning@meier-geinitz.de
  [PATCH] USB: new ids for scanner driver
  
  This patch adds new vendor/product ids for various scanners.

 drivers/usb/image/scanner.c |    5 +++--
 drivers/usb/image/scanner.h |   13 +++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)
------

ChangeSet@1.1143.1.10, 2003-03-20 14:03:23-08:00, jmcmullan@linuxcare.com
  [PATCH] USB HID: Ignore P5 Data Glove (2.4 and 2.5 patches)
  
    As requested, here are the 2.4 (latest BK tree) and 2.5 (latest bk
    tree) patches to ignore the non-HID Essential Reality Data Glove
  
    (again, user-space lib to access this device via /proc/bus/usb
     is available at http://www.evillabs.net/~jmcc/p5)

 drivers/usb/input/hid-core.c |    4 ++++
 1 files changed, 4 insertions(+)
------

ChangeSet@1.1143.1.9, 2003-03-20 14:00:11-08:00, stern@rowland.harvard.edu
  [PATCH] USB: Update for usb-skeleton
  
  My update for usb-skeleton seems to have gotten lost in the shuffle, so
  here it is again -- all wrapped up in one nice little patch.  It's been
  tested by three different people and passed with flying colors.  Please
  apply.

 drivers/usb/usb-skeleton.c |  229 +++++++++++++++++++++++++++++----------------
 1 files changed, 148 insertions(+), 81 deletions(-)
------

ChangeSet@1.1143.1.8, 2003-03-20 13:54:20-08:00, greg@kroah.com
  [PATCH] USB: pegasus: fix up GFP_DMA usages.  (bugzilla.kernel.org #418)

 drivers/usb/net/pegasus.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)
------

ChangeSet@1.1143.1.7, 2003-03-20 13:43:12-08:00, greg@kroah.com
  [PATCH] USB: whiteheat bugfix (bugzilla.kernel.org #314)

 drivers/usb/serial/whiteheat.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.1143.1.6, 2003-03-19 15:41:50-08:00, randy.dunlap@verizon.net
  [PATCH] USB: reduce stack usage in cdc-ether
  
  This patch to 2.5.64 reduces the large stack usage in
  log_device_info() [and makes it static to boot].

 drivers/usb/net/cdc-ether.c |   20 ++++++++++++++++----
 1 files changed, 16 insertions(+), 4 deletions(-)
------

ChangeSet@1.1143.1.5, 2003-03-19 15:41:23-08:00, green@linuxhacker.ru
  [PATCH] USB: Memleak in drivers/usb/hub.c::usb_reset_device
  
  Hello!
  
  On Fri, Mar 14, 2003 at 11:37:19AM -0800, Greg KH wrote:
  > >    There seems to be a memleak in drivers/usb/hub.c::usb_reset_device()
  > >    on error exit path. See the patch.
  > >    Found with help of smatch + enhanced unfree script.
  > And yes, as David said, there is another kind of error in this area for
  > 2.5.  Patches to clean that up would be appreciated.
  
  Ok, I guess something like that should work:

 drivers/usb/core/hub.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)
------

ChangeSet@1.1143.1.4, 2003-03-19 13:09:22-08:00, david-b@pacbell.net
  [PATCH] USB: ehci-hcd, prink tweaks
  
  A not-very interesting patch, it just cleans up
  some debug output.

 drivers/usb/host/ehci-dbg.c |    6 +++---
 drivers/usb/host/ehci-hcd.c |   15 ++++++++-------
 2 files changed, 11 insertions(+), 10 deletions(-)
------

ChangeSet@1.1143.1.3, 2003-03-19 11:23:08-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: get rid of atmsar
  
  There are really only two patches: add atmsar stuff into
  speedtouch.c; and update the Makefile.  The other changes
  are: delete atmsar.c and atmsar.h, rename speedtouch.c to
  speedtch.c.

 drivers/usb/misc/atmsar.c     |  380 ----------
 drivers/usb/misc/atmsar.h     |   87 --
 drivers/usb/misc/speedtouch.c | 1216 ---------------------------------
 drivers/usb/misc/Makefile     |    2 
 drivers/usb/misc/speedtch.c   | 1514 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1514 insertions(+), 1685 deletions(-)
------

ChangeSet@1.1143.1.2, 2003-03-19 11:22:14-08:00, baldrick@wanadoo.fr
  [PATCH] USB speedtouch: cosmetic comment changes

 drivers/usb/misc/speedtouch.c |   53 +++++++++++-------------------------------
 1 files changed, 14 insertions(+), 39 deletions(-)
------

ChangeSet@1.1143.1.1, 2003-03-19 11:21:52-08:00, oliver@neukum.name
  [PATCH] USB: fix to synchronous API regarding memory allocation
  
  some part of the synchronous API is used in the block io error handling
  code paths. Therefore it may use only GFP_NOIO, not GFP_KERNEL.
    - avoid deadlock due to wrong memory allocation in block io path

Push file://home/greg/linux/BK/gregkh-2.5 -> file://home/greg/linux/BK/bleed-2.5
 drivers/usb/core/message.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

