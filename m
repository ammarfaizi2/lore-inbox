Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSKTIxs>; Wed, 20 Nov 2002 03:53:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265974AbSKTIxs>; Wed, 20 Nov 2002 03:53:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:39442 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262190AbSKTIxq>;
	Wed, 20 Nov 2002 03:53:46 -0500
Date: Wed, 20 Nov 2002 00:54:13 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.48
Message-ID: <20021120085413.GF22936@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h

 drivers/usb/core/config.c       |   23 +--
 drivers/usb/media/vicam.c       |  252 ++++++++++++++++-----------------
 drivers/usb/net/pegasus.c       |  303 ++++++++++++++++++++++++++--------------
 drivers/usb/net/pegasus.h       |   15 +
 drivers/usb/serial/usb-serial.c |   81 +++++++---
 drivers/usb/storage/freecom.c   |   56 ++-----
 drivers/usb/storage/isd200.c    |    4 
 drivers/usb/storage/transport.c |  190 +++++++++++--------------
 drivers/usb/storage/transport.h |   14 +
 9 files changed, 519 insertions(+), 419 deletions(-)
-----

ChangeSet@1.911, 2002-11-20 00:10:26-08:00, zwane@holomorphy.com
  [PATCH] USB core/config.c == memory corruption
  
  parse_interface allocates the incorrect storage size for additional
  altsettings (new buffer) leading to a BUG being triggered in
  mm/slab.c:1453 when we do the memcpy from the old buffer to the new
  buffer (writing beyond new buffer).
  Patch appended, tested with an OV511 on an Intel PIIX4

 drivers/usb/core/config.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)
------

ChangeSet@1.872.3.8, 2002-11-19 22:32:33-08:00, greg@kroah.com
  USB:  usb-serial core updates
  
   - removed a few #ifdefs in the main code
   - cleaned up the failure logic in initialization.

 drivers/usb/serial/usb-serial.c |   79 +++++++++++++++++++++++++++-------------
 1 files changed, 55 insertions(+), 24 deletions(-)
------

ChangeSet@1.872.3.7, 2002-11-19 14:51:56-08:00, petkan@tequila.dce.bg
  [PATCH] ADM8513 support added;

 drivers/usb/net/pegasus.c |  303 ++++++++++++++++++++++++++++++----------------
 drivers/usb/net/pegasus.h |   15 +-
 2 files changed, 208 insertions(+), 110 deletions(-)
------

ChangeSet@1.872.3.6, 2002-11-18 18:34:46-08:00, bunk@fs.tum.de
  [PATCH] fix compile error in usb-serial.c
  
  drivers/usb/serial/usb-serial.c in 2.5.48 fails to compile with the
  following error:
  
  drivers/usb/serial/usb-serial.c:842: dereferencing pointer to incompletetype
  
  Is the following patch correct?

 drivers/usb/serial/usb-serial.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.872.3.5, 2002-11-18 17:08:42-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: code consolidation
  
  This patch puts all the code to interpret the result code from an URB into
  a single place, instead of copying it everywhere throughout transport.c

 drivers/usb/storage/transport.c |  158 +++++++++++++++++-----------------------
 1 files changed, 68 insertions(+), 90 deletions(-)
------

ChangeSet@1.872.3.4, 2002-11-18 17:05:46-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: fix missed changes in freecom.c and isd200.c
  
  This patch changes freecom.c and isd200.c to use the new data-moving logic
  instead of the old data-moving logic.  This allows for code consolidation
  and better error-handling.

 drivers/usb/storage/freecom.c |   56 +++++++++++++++---------------------------
 drivers/usb/storage/isd200.c  |    4 +--
 2 files changed, 23 insertions(+), 37 deletions(-)
------

ChangeSet@1.872.3.3, 2002-11-18 17:04:16-08:00, mdharm-usb@one-eyed-alien.net
  [PATCH] usb-storage: change function signatures and cleanup debug msgs
  
  This patch changes the data buffer type from char* to void*, and fixes some
  problems with debug prints and comments.

 drivers/usb/storage/transport.c |   32 ++++++++++++++++----------------
 drivers/usb/storage/transport.h |   14 +++++++++++---
 2 files changed, 27 insertions(+), 19 deletions(-)
------

ChangeSet@1.872.3.2, 2002-11-18 17:03:33-08:00, greg@kroah.com
  USB: vicam.c driver fixes
  
  fixed a bug if CONFIG_VIDEO_PROC_FS was not enabled.
  removed unneeded #ifdefs
  removed bool nonsense.

 drivers/usb/media/vicam.c |   43 +++++++++++++++++--------------------------
 1 files changed, 17 insertions(+), 26 deletions(-)
------

ChangeSet@1.872.3.1, 2002-11-18 16:54:24-08:00, joe@wavicle.org
  [PATCH] vicam.c
  
  Included in this patch:
  
  - (From John Tyner) Move allocation of memory out of send_control_msg. With
  the allocation moved to open, control messages are less expensive since
  they don't allocate and free memory every time.
  - (From John Tyner) Change the behaviour of send_control_msg to return 0 on
  success instead of the number of bytes transferred.
  - Clean up of a couple down_interruptible() calls that weren't checking for
  failure
  - Rewrite of proc fs entries to use one file per value instead of parsing
  in the kernel

 drivers/usb/media/vicam.c |  209 +++++++++++++++++++++++-----------------------
 1 files changed, 109 insertions(+), 100 deletions(-)
------

