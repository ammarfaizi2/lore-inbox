Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262196AbSJVFLd>; Tue, 22 Oct 2002 01:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSJVFLd>; Tue, 22 Oct 2002 01:11:33 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:2314 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262196AbSJVFLb>;
	Tue, 22 Oct 2002 01:11:31 -0400
Date: Mon, 21 Oct 2002 22:16:30 -0700
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.20-pre11
Message-ID: <20021022051629.GB3076@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are three USB patches for 2.4.20-pre11.

They are:
	- reverting a previous patch for the hid-input driver.  This
	  allows USB keyboards to work again on PPC machines.  The patch
	  was incorrect.
	- adds a device id for the Sony Clie NX60 device to the USB
	  visor driver.
	- and a "big" USB 2.0 update.

The USB 2.0 update is needed by a lot of people to enable USB 2.0
controllers and hubs to work properly on their machines.  It's been in
use for quite a while in the 2.5 tree, and a number of people have had
it fix problems for them in the current 2.4.20-pre kernels.  It _only_
effects USB 2.0 controller code, and does not touch anything else.  I
know you rejected this previously, but it really is needed.  The
changeset for it below gives a better description of what it does.

Please pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email.

thanks,

greg k-h

 drivers/usb/hcd.c            |   94 +++---
 drivers/usb/hcd.h            |    1 
 drivers/usb/hcd/ehci-dbg.c   |  525 +++++++++++++++++++++++++++++++----
 drivers/usb/hcd/ehci-hcd.c   |  512 +++++++++++++++++++++++++---------
 drivers/usb/hcd/ehci-hub.c   |   16 -
 drivers/usb/hcd/ehci-q.c     |  575 +++++++++++++++++++++------------------
 drivers/usb/hcd/ehci-sched.c |  630 +++++++++++++++++--------------------------
 drivers/usb/hcd/ehci.h       |   87 +++++
 drivers/usb/hid-input.c      |    2 
 drivers/usb/serial/visor.c   |    2 
 drivers/usb/serial/visor.h   |    1 
 11 files changed, 1556 insertions(+), 889 deletions(-)
-----

ChangeSet@1.749, 2002-10-21 14:48:25-07:00, dbrownell@users.sourceforge.net
  [PATCH] USB:  USB 2.0 controller and hubs bugfixes
  
  Yes, this looks like a big patch, but for users with USB 2.0 devices it
  is necessary.  It contains the following things:
  
   - Key point:  this works, more reliably, on a lot of hardware
     that previously did not work.  So it's got all the bugfixes that
     went into 2.5 since three months into the 2.4.19 series, and a fair
     degree of user testing.  Quite a few users have reported complete
     failure on their 2.4 systems until they updated ... and that the
     update gave them no troubles.
  
   - Adds missing locking to some queue unlink paths.  This resolves
     some oopsing problems (often null pointer exceptions) that were
     rare quite some time ago, but became more common as the driver
     is (a) used much more, and (b) used on faster EHCI implementations,
     like the VIA VT8235 and other recent silicon.
  
   - Fixes the problems when used with cardbus.  Previously if you
     did a physical eject without first "rmmod ehci-hcd" (or even a
     system shutdown, which is a cardbus issue) the system would
     lock up.  No more.

 drivers/usb/hcd.c            |   94 +++---
 drivers/usb/hcd.h            |    1 
 drivers/usb/hcd/ehci-dbg.c   |  525 +++++++++++++++++++++++++++++++----
 drivers/usb/hcd/ehci-hcd.c   |  512 +++++++++++++++++++++++++---------
 drivers/usb/hcd/ehci-hub.c   |   16 -
 drivers/usb/hcd/ehci-q.c     |  575 +++++++++++++++++++++------------------
 drivers/usb/hcd/ehci-sched.c |  630 +++++++++++++++++--------------------------
 drivers/usb/hcd/ehci.h       |   87 +++++
 8 files changed, 1552 insertions(+), 888 deletions(-)
------

ChangeSet@1.748, 2002-10-21 14:37:44-07:00, greg@kroah.com
  [PATCH] USB: added support for Clie NX60 device.
  
  Thanks to Hiroyuki ARAKI <hiro@zob.ne.jp> for the information.

 drivers/usb/serial/visor.c |    2 ++
 drivers/usb/serial/visor.h |    1 +
 2 files changed, 3 insertions(+)
------

ChangeSet@1.747, 2002-10-21 13:37:47-07:00, greg@kroah.com
  Cset exclude: acme@conectiva.com.br|ChangeSet|20021011180213|25533

 drivers/usb/hid-input.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

