Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSLQAl2>; Mon, 16 Dec 2002 19:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbSLQAl1>; Mon, 16 Dec 2002 19:41:27 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:29708 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262812AbSLQAlY>;
	Mon, 16 Dec 2002 19:41:24 -0500
Date: Mon, 16 Dec 2002 16:46:50 -0800
From: Greg KH <greg@kroah.com>
To: marcelo@conectiva.com.br
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.4.21-pre1
Message-ID: <20021217004650.GB18319@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some USB updates for 2.4.21-pre1.  It also includes the tipar char
driver which has been in the 2.5 tree for a while.

Please pull from:  bk://linuxusb.bkbits.net/marcelo-2.4

The individual patches will be sent in follow up messages to this email
to you and the linux-usb-devel mailing list.

thanks,

greg k-h

 Documentation/Configure.help       |   66 +++
 Documentation/tipar.txt            |   93 ++++
 MAINTAINERS                        |   10 
 drivers/char/Config.in             |    1 
 drivers/char/Makefile              |    1 
 drivers/char/tipar.c               |  540 +++++++++++++++++++++++++++
 drivers/usb/Config.in              |    3 
 drivers/usb/hc_sl811.c             |    2 
 drivers/usb/pegasus.c              |   31 +
 drivers/usb/pwc-ctrl.c             |   38 -
 drivers/usb/pwc-if.c               |  406 ++++++++++++--------
 drivers/usb/pwc-ioctl.h            |   13 
 drivers/usb/pwc-uncompress.c       |   24 -
 drivers/usb/pwc.h                  |    9 
 drivers/usb/rtl8150.c              |   53 ++
 drivers/usb/serial/Config.in       |    1 
 drivers/usb/serial/Makefile        |    1 
 drivers/usb/serial/ftdi_sio.c      |   31 +
 drivers/usb/serial/ftdi_sio.h      |   12 
 drivers/usb/serial/kobil_sct.c     |  721 ++++++++++++++++++++++++++++++++++++-
 drivers/usb/serial/kobil_sct.h     |   60 +++
 drivers/usb/storage/unusual_devs.h |   16 
 drivers/usb/uhci.c                 |    4 
 drivers/usb/usb.c                  |   14 
 drivers/usb/usbnet.c               |  100 +++--
 25 files changed, 1969 insertions(+), 281 deletions(-)
-----

ChangeSet@1.886, 2002-12-16 16:20:13-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.4
  into kroah.com:/home/greg/linux/BK/gregkh-2.4

 Documentation/Configure.help |   33 +++++++++++++++++++++++++++++++++
 MAINTAINERS                  |    5 +++++
 2 files changed, 38 insertions(+)
------

ChangeSet@1.811.1.18, 2002-12-16 12:00:21-08:00, greg@kroah.com
  [PATCH] USB: uhci: fix formatting problem with last patch.

 drivers/usb/uhci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.811.1.17, 2002-12-16 11:55:30-08:00, jkt@Helius.COM
  [PATCH] uhci corruption on usb_submit_urb when already -EINPROGRESS
  
    uhci corrupts a list, either uhci->urb_list or uhci->urb_remove_list,
    when usb_submit_urb is called against an urb already in flight
    (urb->status == -EINPROGRESS).  yeah, i know you're not *supposed* to do
    that but Real Programmers(tm) make Real Mistakes(tm) (and timeouts are
    oh, so tricky!) and the code catches this case otherwise; unfortunately,
    the INIT_LIST_HEAD has already hammered your list.
  
    :{)}

 drivers/usb/uhci.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.811.1.16, 2002-12-16 11:55:18-08:00, david-b@pacbell.net
  [PATCH] usbnet:  framing, sync with 2.5
  
  This patch matches the 2.5 patch I just submitted, except that
  it keeps Pavel's table-based crc32 code since <linux/crc32.h>
  says it's not for "bulk data" (which is what this driver does).
  Plus some changes (ethtool) were forward ports from pre1.
  
  - Addresses two issues Toby Milne reported against the Zaurus:
      (a) if skbs had extra framing added (z, net1080, gl620a),
          the original size (now too small) was used on tx;
      (b) added FLAG_FRAMING_Z so rx packets had enough space
  
  - Stubs in some PXA-250 support for non-Zaurus PDAs.
      This is currently commented out; so far those PDAs
      only run Linux for bleeding edge developers.
  
  - Minor cleanups.

 drivers/usb/Config.in |    2 -
 drivers/usb/usbnet.c  |   98 +++++++++++++++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 30 deletions(-)
------

ChangeSet@1.811.1.15, 2002-12-16 11:55:06-08:00, david-b@pacbell.net
  [PATCH] remove CONFIG_USB_LONG_TIMEOUT
  
  This matches 2.5.latest ... the config option isn't needed,
  since neither timeout was actually as large as what the
  USB spec says (5 seconds).  It'll prevent some devices
  from failing to enumerate (like MGE Ellips UPSes).

 drivers/usb/Config.in |    1 -
 drivers/usb/usb.c     |   14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)
------

ChangeSet@1.811.1.14, 2002-12-16 11:24:34-08:00, greg@kroah.com
  USB: pwc driver: fix compile time warning

 drivers/usb/pwc-if.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.811.1.13, 2002-12-16 11:21:34-08:00, greg@kroah.com
  Merge

 drivers/usb/pwc-if.c |  197 +++++++++++++++++++++++++++++----------------------
 1 files changed, 115 insertions(+), 82 deletions(-)
------

ChangeSet@1.811.2.1, 2002-12-16 11:18:15-08:00, arjanv@redhat.com
  [PATCH] USB pwc deadlock fixes

 drivers/usb/pwc-if.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)
------

ChangeSet@1.811.1.12, 2002-12-16 10:45:23-08:00, nemosoft@smcc.demon.nl
  [PATCH] USB: PWC 8.10 for 2.4.20
  
  Well, two patches in one... These patches will bring the PWC (Philips
  Webcam) driver in both 2.4.20 and 2.5.51 up to version 8.10. Functionally,
  the two branches are the same (about 70% of the code is shared), but the
  differences in kernel architecture are too large to handle with a few
  #ifdefs.
  
  This patch fixes the following (this are only the differences between 8.9
  and 8.10):
  
  * Fixed ID for QuickCam Notebook pro
  * Added GREALSIZE ioctl() call
  * Fixed bug in case PWCX was not loaded and invalid size was set

 drivers/usb/pwc-ctrl.c       |   38 ++++----
 drivers/usb/pwc-if.c         |  197 +++++++++++++++++++++++++------------------
 drivers/usb/pwc-ioctl.h      |   13 ++
 drivers/usb/pwc-uncompress.c |   24 +----
 drivers/usb/pwc.h            |    9 +
 5 files changed, 157 insertions(+), 124 deletions(-)
------

ChangeSet@1.811.1.11, 2002-12-13 09:30:44-08:00, petkan@rakia.dce.bg
  [PATCH] USB: pegasus: the data for the control requests is now stored in DMA able memory.
  

 drivers/usb/pegasus.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)
------

ChangeSet@1.811.1.10, 2002-12-12 13:45:00-08:00, kuba@mareimbrium.org
  [PATCH] USB: ftdi-sio update
  
  Attached is a patch which updates ftdi sio driver with better (i.e. always
  correct ;-) fractional divisor code. The previous one was an
  oversimplification that would not always give the best approximation of the
  divisor. It also became an internal static function -- exposing it as a (yet
  another) macro was unnecessary.

 drivers/usb/serial/ftdi_sio.c |   31 ++++++++++++++++++++++++++++++-
 drivers/usb/serial/ftdi_sio.h |   12 ++----------
 2 files changed, 32 insertions(+), 11 deletions(-)
------

ChangeSet@1.811.1.9, 2002-12-12 13:32:39-08:00, nobita@t-online.de
  [PATCH] support for Sony Cybershot F717 digital camera / usb-storage
  
  here is an id-patch to get the Sony Cybershot F717 6meg pixel digital
  camera working with the standard usb-storage device driver.

 drivers/usb/storage/unusual_devs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.811.1.8, 2002-12-11 00:38:01-08:00, marekm@amelek.gda.pl
  [PATCH] Datafab KECF-USB / Sagatek DCS-CF / Simpletech UCF-100
  
  sorry to bother you again - now that 2.4.20 is out, is there any
  chance to include this in 2.4.21?  I've been trying since 2.4.19,
  a few other UNUSUAL_DEV entries were added, but not this one...
  
  The device works fine with the patch (and doesn't work at all without
  it) for me and a few other people (devices with different "marketing"
  names, the same vendor:device id), no one has reported any problems.
  The patch has been in the 2.4-ac tree for a while, too.

 drivers/usb/storage/unusual_devs.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)
------

ChangeSet@1.811.1.7, 2002-12-11 00:37:49-08:00, m.c.p@wolk-project.de
  [PATCH] Eliminate warning in drivers/usb/hc_sl811.c
  
  compile warning is:
   #warning linux/malloc.h is deprecated, use linux/slab.h instead.
  
  attached patch uses linux/slab.h instead, as adviced by above ;)

 drivers/usb/hc_sl811.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.811.1.6, 2002-12-11 00:37:38-08:00, stelian@popies.net
  [PATCH] usbnet typo
  
  There is a typo in the latest usbnet driver which disables
  the compile of iPAQ specific code.
  
  With the attached patch, the new driver recognises the iPAQ
  and even works :*)

 drivers/usb/usbnet.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.811.1.5, 2002-12-11 00:37:26-08:00, greg@kroah.com
  [PATCH] tipar: fix #include so the driver can compile.

 drivers/char/tipar.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.811.1.4, 2002-12-11 00:37:14-08:00, rlievin@free.fr
  [PATCH] Add tipar char driver

 Documentation/Configure.help |   22 +
 Documentation/tipar.txt      |   93 +++++++
 MAINTAINERS                  |    5 
 drivers/char/Config.in       |    1 
 drivers/char/Makefile        |    1 
 drivers/char/tipar.c         |  538 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 660 insertions(+)
------

ChangeSet@1.811.1.3, 2002-12-11 00:36:59-08:00, wahrenbruch@kobil.de
  [PATCH] USB: kobil_sct driver bugfix
  
  Here it is. For readers, connected via Adapter B (Kaan Pro, B1 Pro),
  the driver starts now reading after open(), so that the PNP string doesn't
  confuse the CT-API.

 drivers/usb/serial/kobil_sct.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)
------

ChangeSet@1.811.1.2, 2002-12-11 00:36:47-08:00, wahrenbruch@kobil.de
  [PATCH] USB: add kobil_sct driver

 Documentation/Configure.help   |   11 
 drivers/usb/serial/Config.in   |    1 
 drivers/usb/serial/Makefile    |    1 
 drivers/usb/serial/kobil_sct.c |  711 +++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/kobil_sct.h |   60 +++
 5 files changed, 784 insertions(+)
------

ChangeSet@1.811.1.1, 2002-12-11 00:36:25-08:00, petkan@mastika.dce.bg
  [PATCH] set_mac_address is now added to the driver.  thanks to Orjan Friberg <orjan.friberg@axis.com>

 drivers/usb/rtl8150.c |   53 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 49 insertions(+), 4 deletions(-)
------

