Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318782AbSHLS06>; Mon, 12 Aug 2002 14:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318783AbSHLS06>; Mon, 12 Aug 2002 14:26:58 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:8719 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318782AbSHLS0z>;
	Mon, 12 Aug 2002 14:26:55 -0400
Date: Mon, 12 Aug 2002 11:26:57 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.31
Message-ID: <20020812182657.GA15975@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Pull from:  http://linuxusb.bkbits.net/linus-2.5

 Documentation/DocBook/kernel-api.tmpl |    2 
 drivers/usb/core/Makefile             |    4 
 drivers/usb/core/buffer.c             |  186 +++++++++++++
 drivers/usb/core/hcd-pci.c            |   17 -
 drivers/usb/core/hcd.c                |   12 
 drivers/usb/core/hcd.h                |   41 +++
 drivers/usb/core/usb.c                |  175 ++++++++++++-
 drivers/usb/host/ehci-dbg.c           |  214 +++++++++++++++-
 drivers/usb/host/ehci-hcd.c           |  129 ++++++---
 drivers/usb/host/ehci-q.c             |  364 +++++++++++++++------------
 drivers/usb/host/ehci-sched.c         |  454 ++++++++++++++--------------------
 drivers/usb/host/ehci.h               |   18 -
 drivers/usb/host/ohci-q.c             |    2 
 drivers/usb/media/konicawc.c          |  386 +++++++++++++++-------------
 drivers/usb/misc/tiglusb.c            |    4 
 drivers/usb/net/cdc-ether.c           |   48 +--
 drivers/usb/storage/scsiglue.c        |    3 
 drivers/usb/storage/usb.h             |    7 
 include/linux/usb.h                   |   53 +++
 19 files changed, 1422 insertions(+), 697 deletions(-)
------

ChangeSet@1.477, 2002-08-12 10:49:18-07:00, spse@secret.org.uk
  [PATCH] misc fixes for konicawc driver
  
  This patch against 2.5.31 fixes some problems in the konicawc driver
  
  - add new video mode 160x120
  - add konicawc_camera_on/off()
  - initially send out URBs in status,data order
  - fix konicawc_isoc_irq to always resubmit status then data URBs
  - tidy up debug messages
  - make konicawc_compress_iso look for frame start on initial image

 drivers/usb/media/konicawc.c |  386 ++++++++++++++++++++++---------------------
 1 files changed, 206 insertions(+), 180 deletions(-)
------

ChangeSet@1.476, 2002-08-12 10:31:46-07:00, greg@kroah.com
  USB: remove LINUX_VERSION_CODE checks.

 drivers/usb/misc/tiglusb.c |    4 ----
 drivers/usb/storage/usb.h  |    7 -------
 2 files changed, 11 deletions(-)
------

ChangeSet@1.468.3.4, 2002-08-10 09:40:56-07:00, oliver@neukum.name
  [PATCH] fix urb leak in error in cdc-ether
  
  Probably leftover of statically allocated urbs.
  
  fix memory leak

 drivers/usb/net/cdc-ether.c |   48 ++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 23 deletions(-)
------

ChangeSet@1.457.7.9, 2002-08-06 21:57:39-07:00, paulus@samba.org
  [PATCH] USB root hub polling and suspend
  
  Currently with 2.5, when I suspend and resume my powerbook, I find
  that the USB subsystem no longer sees root hub events, i.e. it doesn't
  notice when I plug in a new USB device (it doesn't notice when I
  unplug a device either but of course the driver for the device sees
  that it is no longer responding).
  
  It turns out that what happens is that the root hub timer goes off
  after the OHCI driver has done its suspend stuff.  The timer routine
  sees that the HCD is not running at the moment and doesn't schedule
  another timeout.  Hence the series of timeouts stops.

 drivers/usb/core/hcd.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)
------

ChangeSet@1.457.7.8, 2002-08-06 20:49:14-07:00, greg@kroah.com
  USB: Makefile fix for previous patch

 drivers/usb/core/Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.457.7.7, 2002-08-06 20:05:47-07:00, david-b@pacbell.net
  [PATCH] expose dma_addr_t in urbs
  
  This patch exposes DMA addresses in URBs.  It exposes new APIs that
  let drivers be a bit smarter in terms of DMA, reducing USB overhead
  on some platforms (but not commodity pcs).  As discussed with DaveM,
  and on the usb-devel list.
  
  Supporting patches are still needed.  Of course, there's teaching HCDs
  to use _these_ addresses when they're provided (easy).  There's also
  teaching drivers (like hid) to use the new usb_buffer_alloc() support,;
  can happen incrementally.  And adding scatterlist support, which will
  be desirable for usb-storage and hpusbscanner.  But this is the start
  needed to get all of that going.

 Documentation/DocBook/kernel-api.tmpl |    2 
 drivers/usb/core/buffer.c             |  186 ++++++++++++++++++++++++++++++++++
 drivers/usb/core/hcd-pci.c            |   17 ++-
 drivers/usb/core/hcd.c                |    5 
 drivers/usb/core/hcd.h                |   41 +++++++
 drivers/usb/core/usb.c                |  153 +++++++++++++++++++++++++++
 include/linux/usb.h                   |   53 ++++++++-
 7 files changed, 446 insertions(+), 11 deletions(-)
------

ChangeSet@1.457.7.6, 2002-08-06 19:29:58-07:00, david-b@pacbell.net
  [PATCH] ehci does interrupt queuing
  
  This patch makes EHCI
  
    - Share the same TD queueing code for control, bulk,
      and interrupt traffic;
    - Queue interrupt transfers, modifying the code for
      urb submit/unlink/complete;
    - Thinner, by removing lots of nasty fatty special case
      logic for interrupt transfers (size, no queueing, etc);
    - Grow some "automagic resubmit" logic, ready to be
      ripped out soonish;
    - Package its interrupt scheduling so it can be called
      from more places.

 drivers/usb/host/ehci-hcd.c   |   45 +++--
 drivers/usb/host/ehci-q.c     |  166 ++++++++-----------
 drivers/usb/host/ehci-sched.c |  362 +++++++++++++++++++-----------------------
 drivers/usb/host/ehci.h       |    1 
 4 files changed, 278 insertions(+), 296 deletions(-)
------

ChangeSet@1.457.7.5, 2002-08-06 15:58:22-07:00, david-b@pacbell.net
  [PATCH] ehci, debug info in driverfs
  
  This patch teaches the ehci driver how to dump its schedule
  through two driverfs files:
  
    "sched-async" shows the control/bulk queue.  usually has
       no tds, often the idle queue head is showing.
    "sched-periodic" shows the iso/interrupt schedule.
  
  Since this is for debugging, the files aren't normally
  configured into the driver.

 drivers/usb/host/ehci-dbg.c |  214 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/host/ehci-hcd.c |    4 
 2 files changed, 217 insertions(+), 1 deletion(-)
------

ChangeSet@1.457.7.4, 2002-08-05 15:38:08-07:00, Andries.Brouwer@cwi.nl
  [PATCH] usb_string fix
  
  Things are indeed as conjectured, and I can reproduce the situation
  where usb_string() returns -EPIPE. Now that this is an internal
  error code for the USB subsystem, and not meant to get out to the
  user, I made these driverfs files empty in case of error.
  (While if there is no error but the string has length 0,
  the file will consist of a single '\n'.)
  
  One fewer random memory corruption. Unfortunately, there are more.
  
  Andries

 drivers/usb/core/usb.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)
------

ChangeSet@1.457.7.3, 2002-08-05 15:37:54-07:00, david-b@pacbell.net
  [PATCH] ohci, rm sparc64 oops
  
  The recent "unlink cleanups" patch had a problem
  with bitmask byteswapping.

 drivers/usb/host/ohci-q.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.457.7.2, 2002-08-05 10:24:05-07:00, david-b@pacbell.net
  [PATCH] ehci updates
  
  This patch is the first part of fixing the EHCI driver to queue
  interrupt transactions, handle larger requests, and basically treat
  interrupt as just "bulk that lives on the periodic schedule".  One
  more patch should wrap that up.
  
       qh processing cleanup
  	- split "append tds to qh" logic out of "put on async schedule",
  	  so it can be used with "put on periodic schedule" too
       interrupt transfer cleanup
  	- save rest of scheduling params in the qh
  	- calculate scheduling params only once
       other cleanup
  	- use new container_of()
  	- minor code shrinkage (avoid pipe bitops, conditionals, etc)
  	- rename variable (will track endpoints, not urbs)
  	- free_config() logic

 drivers/usb/host/ehci-hcd.c   |   80 ++++++++++------
 drivers/usb/host/ehci-q.c     |  198 +++++++++++++++++++++++++++++-------------
 drivers/usb/host/ehci-sched.c |   92 +++++--------------
 drivers/usb/host/ehci.h       |   17 ++-
 4 files changed, 226 insertions(+), 161 deletions(-)
------

ChangeSet@1.457.7.1, 2002-08-05 10:12:38-07:00, greg@kroah.com
  USB storage: split up BUG_ON for easier debugging.
  
  As requested by Adam Richter.

 drivers/usb/storage/scsiglue.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)
------

