Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263740AbUESAVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263740AbUESAVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUESAVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:21:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:51592 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263601AbUESAVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:21:22 -0400
Date: Tue, 18 May 2004 17:20:00 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       sensors@Stimpy.netroedge.com
Subject: [BK PATCH] Some driver changes for 2.6.6 (msleep)
Message-ID: <20040519002000.GA11409@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Based on the previous USB changes creating a useful sleep function that
all drivers can use, Jeff Garzik suggested that I make it available to
all of the kernel.  Doing this enabled me to remove a lot of local
driver functions that all did the same thing (and some of them did it
wrong, like the i2c code...)  Anyway, here is the result of this
cleanup, it's been discussed on lkml as to the name and location of the
function.

Please pull from:  bk://kernel.bkbits.net/gregkh/linux/usb-2.6

Patches will be posted to linux-usb-devel as a follow-up thread for
those who want to see them.

thanks,

greg k-h

 drivers/block/carmel.c              |    6 ------
 drivers/i2c/busses/i2c-ali1535.c    |    5 +++--
 drivers/i2c/busses/i2c-ali1563.c    |    5 +++--
 drivers/i2c/busses/i2c-ali15x3.c    |    5 +++--
 drivers/i2c/busses/i2c-amd756.c     |    7 ++++---
 drivers/i2c/busses/i2c-amd8111.c    |    2 +-
 drivers/i2c/busses/i2c-i801.c       |    7 ++++---
 drivers/i2c/busses/i2c-piix4.c      |    3 ++-
 drivers/i2c/busses/i2c-sis5595.c    |    3 ++-
 drivers/i2c/busses/i2c-sis630.c     |    3 ++-
 drivers/i2c/busses/i2c-sis96x.c     |    3 ++-
 drivers/i2c/busses/i2c-viapro.c     |    3 ++-
 drivers/i2c/chips/w83l785ts.c       |    3 ++-
 drivers/input/gameport/ns558.c      |    5 +++--
 drivers/input/gameport/vortex.c     |    3 ++-
 drivers/input/joystick/adi.c        |    6 +++---
 drivers/input/joystick/analog.c     |    6 +++---
 drivers/input/joystick/gf2k.c       |    4 ++--
 drivers/macintosh/therm_pm72.c      |   17 +++++------------
 drivers/net/irda/stir4200.c         |    5 +++--
 drivers/scsi/libata-core.c          |   17 -----------------
 drivers/usb/core/hub.c              |   14 +++++++-------
 drivers/usb/core/usb.c              |   11 -----------
 drivers/usb/host/ehci-hcd.c         |    6 +++---
 drivers/usb/host/ehci-hub.c         |    2 +-
 drivers/usb/host/ehci.h             |    6 ------
 drivers/usb/host/ohci-hcd.c         |    4 ++--
 drivers/usb/host/ohci-hub.c         |    4 ++--
 drivers/usb/host/ohci-pci.c         |    6 +++---
 drivers/usb/host/ohci.h             |    6 ------
 drivers/usb/input/aiptek.c          |    2 +-
 drivers/usb/misc/usbtest.c          |    2 +-
 drivers/usb/net/usbnet.c            |    2 +-
 drivers/usb/serial/io_ti.c          |    4 ++--
 drivers/usb/storage/datafab.c       |    2 +-
 drivers/usb/storage/isd200.c        |    4 ++--
 drivers/usb/storage/jumpshot.c      |    2 +-
 drivers/usb/storage/shuttle_usbat.c |   14 +++++++-------
 drivers/video/aty/radeon_base.c     |    2 +-
 drivers/video/aty/radeon_i2c.c      |   16 ++++++++--------
 drivers/video/aty/radeonfb.h        |    9 ---------
 include/linux/delay.h               |    2 ++
 include/linux/gameport.h            |    6 ------
 include/linux/i2c.h                 |    7 -------
 include/linux/usb.h                 |   13 -------------
 kernel/timer.c                      |   17 +++++++++++++++++
 sound/oss/dmasound/dac3550a.c       |    5 +++--
 sound/oss/dmasound/dmasound.h       |    6 ------
 sound/oss/dmasound/dmasound_awacs.c |   30 +++++++++++++++---------------
 sound/oss/trident.c                 |    2 +-
 sound/pci/au88x0/au88x0_game.c      |    3 ++-
 51 files changed, 134 insertions(+), 193 deletions(-)
-----

Greg Kroah-Hartman:
  o Some more misc wait_ms() conversions to use msleep()
  o Input: remove wait_ms() in place of using msleep()
  o I2C: change i2c_delay() to use msleep() instead
  o USB: remove wait_ms() from usb.h as it's no longer needed
  o USB: remove ehci and ohci's private sleep function and use msleep() instead
  o USB: clean up usages of wait_ms() now that we have msleep()
  o USB: remove usb_uninterruptible_sleep_ms() now that we have msleep()
  o Remove libata's version of msleep()
  o Delete block/carmel.c's version of msleep()
  o Add msleep function to the kernel core to prevent duplication

