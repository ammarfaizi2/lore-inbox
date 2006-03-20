Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030486AbWCTVu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030486AbWCTVu0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWCTVu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:50:26 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:29644
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1030451AbWCTVuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:50:25 -0500
Date: Mon, 20 Mar 2006 13:50:09 -0800
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, kay.sievers@suse.de
Subject: [GIT PATCH] Driver Core and sysfs stuff for 2.6.16
Message-ID: <20060320215009.GA19665@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some driver core and sysfs patches for 2.6.16.  They contain
the following changes:
	- EXPORT_SYMBOL_GPL_FUTURE() added to the kernel
	- mark a few subsystems with this new export
	- fix a few sysfs bugs (fixes a few bugs with USB device
	  removals).
	- kref optimization
	- semaphore to mutex conversions
	- module sysfs files reference counting fixes
	- make sysfs a bit more verbous about errors/stupid usages.
	- mark where people are using the driver model wrong more
	  obvious.
	- add kobject_add_dir() function
	- add binary blob file type helper to debugfs
	- remove a few sysfs functions from being exported as no one
	  except the kobject code should be using it (it is impossible
	  to use these, so no one has.)
	- firmware error path fixes

All of these patches have been in the -mm tree for a number of weeks, if
not months.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 Documentation/feature-removal-schedule.txt |   18 ++
 arch/arm/common/locomo.c                   |    2 
 arch/arm/common/sa1111.c                   |    2 
 arch/m68knommu/kernel/vmlinux.lds.S        |   10 +
 arch/v850/kernel/vmlinux.lds.S             |    8 +
 block/genhd.c                              |   31 ++--
 drivers/base/cpu.c                         |    2 
 drivers/base/firmware_class.c              |    6 
 drivers/base/map.c                         |   21 +--
 drivers/base/platform.c                    |    4 
 drivers/char/s3c2410-rtc.c                 |    4 
 drivers/char/watchdog/mpcore_wdt.c         |    4 
 drivers/i2c/busses/i2c-iop3xx.c            |    9 +
 drivers/i2c/busses/i2c-mpc.c               |    5 
 drivers/i2c/busses/i2c-mv64xxx.c           |    4 
 drivers/ide/mips/au1xxx-ide.c              |    5 
 drivers/mmc/pxamci.c                       |    2 
 drivers/net/arm/am79c961a.c                |    4 
 drivers/net/fs_enet/mac-fcc.c              |    2 
 drivers/net/fs_enet/mac-fec.c              |    2 
 drivers/net/fs_enet/mac-scc.c              |    2 
 drivers/net/gianfar.c                      |    4 
 drivers/net/smc91x.c                       |    4 
 drivers/pcmcia/omap_cf.c                   |    2 
 drivers/serial/s3c2410.c                   |    2 
 drivers/usb/core/driver.c                  |    6 
 drivers/usb/host/ohci-omap.c               |    9 +
 drivers/video/epson1355fb.c                |    1 
 drivers/video/sa1100fb.c                   |    2 
 drivers/video/vfb.c                        |    1 
 fs/char_dev.c                              |   17 +-
 fs/debugfs/file.c                          |   46 ++++++
 fs/sysfs/dir.c                             |   37 ++++-
 fs/sysfs/file.c                            |    9 -
 fs/sysfs/inode.c                           |    9 -
 fs/sysfs/symlink.c                         |    6 
 fs/sysfs/sysfs.h                           |    1 
 include/asm-generic/vmlinux.lds.h          |   14 ++
 include/linux/cpu.h                        |    2 
 include/linux/debugfs.h                    |   15 ++
 include/linux/device.h                     |    2 
 include/linux/kobj_map.h                   |    4 
 include/linux/kobject.h                    |    4 
 include/linux/module.h                     |   10 +
 kernel/ksysfs.c                            |    3 
 kernel/module.c                            |  199 +++++++++++++++++------------
 kernel/params.c                            |   10 -
 kernel/rcupdate.c                          |    6 
 lib/kobject.c                              |   60 +++++++-
 lib/kobject_uevent.c                       |    2 
 lib/kref.c                                 |    7 -
 scripts/genksyms/keywords.c_shipped        |   91 ++++++-------
 scripts/genksyms/keywords.gperf            |    1 
 53 files changed, 514 insertions(+), 219 deletions(-)

---------------

Adrian Bunk:
      Kobject: kobject.h: fix a typo

Andrew Morton:
      get_cpu_sysdev() signedness fix

David Vrabel:
      driver core: platform_get_irq*(): return -ENXIO on error
      handle errors returned by platform_get_irq*()

Eric Dumazet:
      kref: avoid an atomic operation in kref_put()

Eric Sesterhenn:
      sysfs: kzalloc conversion

Greg Kroah-Hartman:
      sysfs: sysfs_remove_dir() needs to invalidate the dentry
      Mark empty release functions as broken
      add EXPORT_SYMBOL_GPL_FUTURE()
      add EXPORT_SYMBOL_GPL_FUTURE() to RCU subsystem
      add EXPORT_SYMBOL_GPL_FUTURE() to USB subsystem
      fix module sysfs files reference counting
      Kobject: provide better warning messages when people do stupid things
      sysfs: don't export dir symbols
      sysfs: fix a kobject leak in sysfs_add_link on the error path

Jeff Moyer:
      firmware: fix BUG: in fw_realloc_buffer

Jes Sorensen:
      kobj_map semaphore to mutex conversion

Jun'ichi Nomura:
      kobject: fix build error if CONFIG_SYSFS=n
      kobject_add_dir

Maneesh Soni:
      sysfs: fix problem with duplicate sysfs directories and files

Michael Ellerman:
      debugfs: Add debugfs_create_blob() helper for exporting binary data

Sam Ravnborg:
      Clean up module.c symbol searching logic

Tilman Schmidt:
      Driver core: add macros notice(), dev_notice()

