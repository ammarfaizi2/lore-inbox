Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWIZFh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWIZFh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 01:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWIZFh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 01:37:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:21461 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750978AbWIZFh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 01:37:28 -0400
Date: Mon, 25 Sep 2006 22:37:28 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver Core patches for 2.6.18
Message-ID: <20060926053728.GA8970@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are a bunch of driver core and sysfs patches and fixes for 2.6.18.
They contain the following changes:
	- your suspend resume api changes
	- lots of other suspend issue fixes and documentation for power
	  issues.
	- driver core additions to allow devices to replace class
	  devices (no subsystems have been changed however, those remain
	  out of mainline until udev and other helper utilities get
	  fixed up properly.)
	- __must_check config option to shut it up because of:
	- add __must_check to the driver core to fix driver bugs  (lots
	  of __must_check fixes are staged and ready to come in after
	  these patches go in).
	- multi-thread device probe addition to both the driver core,
	  and the PCI subsystem (overridden by a config and command line
	  option.)
	- other minor bugfixes.

All of these patches have been in the -mm tree for a quite a while.

Please pull from:
	git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet:
	master.kernel.org:/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

Patches will be sent as a follow-on to this message to lkml for people
to see.

thanks,

greg k-h


 Documentation/ABI/{obsolete => removed}/devfs |    5 
 Documentation/ABI/testing/sysfs-power         |   88 +++
 Documentation/feature-removal-schedule.txt    |   27 +
 Documentation/power/devices.txt               |  733 ++++++++++++++++++-------
 drivers/base/base.h                           |    2 
 drivers/base/bus.c                            |  133 +++--
 drivers/base/class.c                          |   34 +
 drivers/base/core.c                           |  230 +++++++-
 drivers/base/dd.c                             |  147 ++++-
 drivers/base/driver.c                         |   16 -
 drivers/base/platform.c                       |   30 +
 drivers/base/power/resume.c                   |   37 +
 drivers/base/power/suspend.c                  |   92 ++-
 drivers/base/power/sysfs.c                    |   35 +
 drivers/ide/ide.c                             |    6 
 drivers/ide/ppc/pmac.c                        |   14 
 drivers/media/dvb/cinergyT2/cinergyT2.c       |    2 
 drivers/pci/Kconfig                           |   25 +
 drivers/pci/hotplug/acpiphp_ibm.c             |    4 
 drivers/pci/pci-driver.c                      |   38 +
 drivers/pci/pci.c                             |    4 
 drivers/scsi/mesh.c                           |   15 -
 drivers/usb/core/hcd-pci.c                    |    2 
 drivers/usb/host/ehci-pci.c                   |    6 
 drivers/usb/host/ohci-pci.c                   |    5 
 drivers/usb/host/sl811-hcd.c                  |    9 
 drivers/usb/host/uhci-hcd.c                   |    4 
 drivers/video/aty/radeon_pm.c                 |   15 -
 drivers/video/i810/i810_main.c                |   12 
 drivers/video/nvidia/nvidia.c                 |   13 
 drivers/video/savage/savagefb_driver.c        |   14 
 fs/debugfs/file.c                             |   56 +-
 fs/debugfs/inode.c                            |   15 -
 fs/namespace.c                                |   10 
 fs/sysfs/bin.c                                |   13 
 fs/sysfs/dir.c                                |    2 
 fs/sysfs/inode.c                              |   11 
 fs/sysfs/symlink.c                            |   14 
 fs/sysfs/sysfs.h                              |    2 
 include/linux/compiler.h                      |    5 
 include/linux/device.h                        |   99 ++-
 include/linux/kobject.h                       |   16 -
 include/linux/pci.h                           |   36 +
 include/linux/platform_device.h               |    2 
 include/linux/pm.h                            |   63 ++
 include/linux/sysfs.h                         |   28 +
 include/media/v4l2-dev.h                      |    2 
 init/do_mounts.c                              |    5 
 kernel/power/Kconfig                          |   11 
 kernel/power/disk.c                           |    4 
 kernel/power/swsusp.c                         |    9 
 kernel/power/user.c                           |    2 
 lib/Kconfig.debug                             |    7 
 lib/klist.c                                   |   26 +
 lib/kobject.c                                 |    9 
 55 files changed, 1663 insertions(+), 581 deletions(-)
 rename Documentation/ABI/{obsolete/devfs => removed/devfs} (73%)
 create mode 100644 Documentation/ABI/testing/sysfs-power

---------------

Alan Stern:
      Driver core: Fix potential deadlock in driver core
      Driver core: Remove unneeded routines from driver core
      Driver core: Don't call put methods while holding a spinlock

Andrew Morton:
      add __must_check to device management code
      add CONFIG_ENABLE_MUST_CHECK
      v4l-dev2: handle __must_check
      drivers/base: check errors
      sysfs: add proper sysfs_init() prototype

Brian Walsh:
      drivers/base: Platform notify needs to occur before drivers attach to the device

David Brownell:
      make suspend quieter
      fix broken/dubious driver suspend() methods
      PM: define PM_EVENT_PRETHAW
      PM: PCI and IDE handle PM_EVENT_PRETHAW
      PM: video drivers and PM_EVENT_PRETHAW
      PM: USB HCDs use PM_EVENT_PRETHAW
      PM: issue PM_EVENT_PRETHAW
      updated Documentation/power/devices.txt
      PM: update docs for writing .../power/state
      PM: add kconfig option for deprecated .../power/state files
      PM: no suspend_prepare() phase
      PM: platform_bus and late_suspend/early_resume

Dmitry Torokhov:
      class_device_create(): make fmt argument 'const char *'
      Driver core: fix comments in drivers/base/power/resume.c

Greg Kroah-Hartman:
      device_create(): make fmt argument 'const char *'
      SYSFS: allow sysfs_create_link to create symlinks in the root of sysfs
      Driver core: add groups support to struct device
      Driver core: allow devices in classes to have no parent
      Driver core: add ability for classes to handle devices properly
      Driver core: add device_rename function
      Driver core: create devices/virtual/ tree
      Class: add support for class interfaces for devices
      Driver core: add ability for devices to create and remove bin files
      Driver Core: add ability for drivers to do a threaded probe
      PCI: enable driver multi-threaded probe

jens m. noedler:
      Documentation/ABI: devfs is not obsolete, but removed!

Juha Yrjölä:
      sysfs: Make poll behaviour consistent

Kay Sievers:
      deprecate PHYSDEV* keys

Linus Torvalds:
      Suspend infrastructure cleanup and extension
      Suspend changes for PCI core

Miguel Ojeda Sandonis:
      Driver core: add const to class_create

Pavel Machek:
      PM: schedule /sys/devices/.../power/state for removal
      PM: device_suspend/resume may sleep

Rafael J. Wysocki:
      PM: add /sys/power documentation to Documentation/ABI

Randy Dunlap:
      Debugfs: kernel-doc fixes for debugfs
      kobject: must_check fixes

Randy.Dunlap:
      sysfs_remove_bin_file: no return value, dump_stack on error

Yoichi Yuasa:
      Driver core: fixed add_bind_files() definition

