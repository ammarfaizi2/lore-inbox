Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266152AbUFRSxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUFRSxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266479AbUFRSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:53:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:57034 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266152AbUFRStH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:49:07 -0400
Date: Fri, 18 Jun 2004 11:47:44 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB patches for 2.6.7
Message-ID: <20040618184744.GA16294@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a number of various USB fixes and cleanups for 2.6.7.  All
of these patches have been in the past few -mm releases.

There's lots of good stuff in here:
	- gadget fixes
	- new host controller driver for lh7a404 devices
	- lots of hub locking rework to fix up the mess there.
	- sparse markups to remove warnings
	- loads of bugfixes.

Please pull from:
	bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 usb/host/ohci-lh7a404.c            |  385 ------------------
 drivers/usb/Kconfig                |    2 
 drivers/usb/class/audio.c          |  130 +++---
 drivers/usb/class/cdc-acm.c        |  323 ++++++---------
 drivers/usb/class/cdc-acm.h        |  115 +++++
 drivers/usb/class/usblp.c          |   11 
 drivers/usb/core/devices.c         |    2 
 drivers/usb/core/devio.c           |    6 
 drivers/usb/core/hcd-pci.c         |    4 
 drivers/usb/core/hcd.c             |   23 -
 drivers/usb/core/hcd.h             |   13 
 drivers/usb/core/hub.c             |  759 ++++++++++++++++++++++++++-----------
 drivers/usb/core/hub.h             |   17 
 drivers/usb/core/message.c         |   32 -
 drivers/usb/core/sysfs.c           |   89 ++--
 drivers/usb/core/usb.c             |  231 -----------
 drivers/usb/core/usb.h             |    5 
 drivers/usb/gadget/dummy_hcd.c     |   28 -
 drivers/usb/gadget/ether.c         |   90 ++--
 drivers/usb/gadget/file_storage.c  |    5 
 drivers/usb/gadget/ndis.h          |   30 +
 drivers/usb/gadget/net2280.c       |   25 -
 drivers/usb/gadget/rndis.c         |  707 ++++++++++++++++++----------------
 drivers/usb/gadget/rndis.h         |   41 +
 drivers/usb/host/ehci-hcd.c        |   12 
 drivers/usb/host/ehci-sched.c      |    2 
 drivers/usb/host/hc_sl811_rh.c     |   10 
 drivers/usb/host/ohci-dbg.c        |   30 -
 drivers/usb/host/ohci-hcd.c        |   47 +-
 drivers/usb/host/ohci-hub.c        |   42 +-
 drivers/usb/host/ohci-lh7a404.c    |  385 ++++++++++++++++++
 drivers/usb/host/ohci-omap.c       |    4 
 drivers/usb/host/ohci-q.c          |    6 
 drivers/usb/host/ohci-sa1111.c     |    4 
 drivers/usb/host/ohci.h            |   19 
 drivers/usb/host/uhci-hcd.c        |   50 +-
 drivers/usb/image/mdc800.c         |    6 
 drivers/usb/input/Kconfig          |   14 
 drivers/usb/input/ati_remote.c     |   54 ++
 drivers/usb/input/hid-core.c       |    4 
 drivers/usb/input/hiddev.c         |   59 +-
 drivers/usb/media/Kconfig          |    4 
 drivers/usb/media/dabusb.c         |   10 
 drivers/usb/media/ov511.c          |    2 
 drivers/usb/media/ov511.h          |    2 
 drivers/usb/media/pwc-if.c         |   13 
 drivers/usb/media/se401.c          |    2 
 drivers/usb/media/stv680.c         |    2 
 drivers/usb/media/usbvideo.c       |    4 
 drivers/usb/media/vicam.c          |   32 -
 drivers/usb/media/w9968cf.c        |   47 +-
 drivers/usb/media/w9968cf.h        |    2 
 drivers/usb/misc/auerswald.c       |   28 -
 drivers/usb/misc/legousbtower.c    |    8 
 drivers/usb/misc/phidgetservo.c    |  117 +++--
 drivers/usb/misc/usbtest.c         |   16 
 drivers/usb/net/pegasus.h          |    3 
 drivers/usb/net/rtl8150.c          |   30 -
 drivers/usb/net/usbnet.c           |    7 
 drivers/usb/serial/bus.c           |    4 
 drivers/usb/serial/cyberjack.c     |   21 -
 drivers/usb/serial/ftdi_sio.c      |   13 
 drivers/usb/serial/io_edgeport.c   |   15 
 drivers/usb/serial/io_ti.c         |    6 
 drivers/usb/serial/kl5kusb105.c    |   15 
 drivers/usb/serial/kobil_sct.c     |    9 
 drivers/usb/serial/visor.c         |   19 
 drivers/usb/serial/visor.h         |    3 
 drivers/usb/serial/whiteheat.c     |    5 
 drivers/usb/storage/Kconfig        |   22 +
 drivers/usb/storage/isd200.c       |    8 
 drivers/usb/storage/jumpshot.c     |    2 
 drivers/usb/storage/scsiglue.c     |   55 ++
 drivers/usb/storage/transport.c    |   54 +-
 drivers/usb/storage/unusual_devs.h |   26 -
 drivers/usb/storage/usb.c          |  221 ++++------
 drivers/usb/storage/usb.h          |    5 
 include/linux/usb.h                |    1 
 usb/host/ohci-lh7a404.c            |  391 ++++++++++++++++++-
 79 files changed, 2972 insertions(+), 2073 deletions(-)
-----

<kaie:kuix.de>:
  o USB: enable pwc usb camera driver

<numlock:freesurf.ch>:
  o Add support for ISD-300 controller

<scott:concord.org>:
  o USB: kyocera 7135 patch

<siegfried.hildebrand:fernuni-hagen.de>:
  o Re: Problems with cyberjack usb-serial-module since kernel 2.6.2

<spitalnik:penguin.cz>:
  o USB: pegasus driver and ATEN device support

Alan Stern:
  o USB: dummy_hcd shouldn't reject SET-ADDRESS requests
  o USB: Fix endian bug in g_file_storage
  o USB Storage: unusual_devs.h update
  o USB: Only process ports with change events pending
  o USB: Remove private khubd semaphore
  o USB: Fix bug in TT initialization introduced by earlier
  o USB: Mark devices as NOTATTACHED as soon as possible
  o USB: Update root-hub code for the ohci-lh7a404 driver
  o USB: Minor tidying up of hub driver
  o USB: Fix bus-list root-hub race
  o USB: Initialize endpoint autoconfig in g_file_storage
  o USB: unusual_devs.h update
  o USB: Fix resource leakage in the hub driver
  o USB: Check port reset return code
  o USB: Fix logic in usb_get_descriptor()
  o USB: Genuine changes to hub_port_debounce()
  o USB: Superficial improvements to hub_port_debounce()
  o USB: Debounce all connect change events
  o USB: Code cleanup for the UHCI driver
  o USB: 2.6-BK usb (printing) broken
  o USB: Move usb_new_device() et al. into hub.c
  o USB: Minor cleanups for hub driver
  o USB: Fix disconnect bug in dummy_hcd
  o USB: unusual_devs.h update

David Brownell:
  o USB: retry string fetches on ZLPs not just STALLs
  o USB: usbnet shouldn't oops on cdc error path
  o USB: usbtest just uses module_param()
  o lh7a404 USB host against 2.6.7-rc2
  o USB: usb suspend/resume work better on net2280
  o USB: usb root hubs can set power budgets
  o USB: rndis (4/4) start documenting spec variances
  o USB: rndis (1/4) update OID support
  o USB: usb retry cleanups
  o USB: pxa/rndis device descriptor

Duncan Sands:
  o USB devio.c: deadlock fix

Gary Lerhaupt:
  o proper bios handoff in ehci-hcd

Greg Kroah-Hartman:
  o USB: mark pwc driver broken again, as it still is :(
  o USB: fix up dumb int_user_arg variable name as pointed out by Al Viro
  o USB: sparse cleanups for the whole driver/usb/* tree
  o USB: crap, I misapplied a patch with the wrong level
  o USB: make usb devices remove their sysfs files when disconnected
  o USB: remove "devfs" message from kernel log for usb-serial driver
  o Cset exclude: vojtech@suse.cz|ChangeSet|20040602201956|45549

Joe Nardelli:
  o USB: fix Memory leak in visor.c and ftdi_sio.c

Jon Neal:
  o USB: rndis (3/4) Big Endian support for gadget RNDIS

Matthew Dharm:
  o USB Storage: Lexar Jumpshot CF reader
  o USB Storage: Fix race when removing the SCSI host
  o USB Storage: INQUIRY fixup, mode-sense options, Genesys devices
  o USB Storage: GetMaxLUN tightening

Neil Bortnak:
  o USB: add support for Buffalo LUA-U2-KTX

Oliver Neukum:
  o USB: add printer reset ioctl
  o USB: fix race between disconnect and write of acm driver
  o USB: fix racy access to urb->status in cdc acm driver
  o USB: error handling of open of acm driver
  o USB: proper evaluation of the union descriptor for CDC ACM

Rick Sewill:
  o USB: usb on big endian, ehci needs a byteswap

Robert T. Johnson:
  o 2.6.7-rc3 drivers/usb/core/devio.c: user/kernel pointer bugs

Sean Young:
  o USB: PhidgetServo driver fixes

Tao Huang:
  o USB: rndis (2/4) fix memory leaks

Torrey Hoffman:
  o USB: ATI Remote driver update

Vojtech Pavlik:
  o USB: Patch to prevent overlapping access by usb-storage and usbfs

