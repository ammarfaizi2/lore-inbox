Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbVFUEtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbVFUEtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 00:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVFUEtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 00:49:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:47074 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261571AbVFTWzr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 18:55:47 -0400
Date: Mon, 20 Jun 2005 15:55:38 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PATCH] Driver core changes for 2.6.12
Message-ID: <20050620225538.GA16888@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Loads of fun stuff in this patch series (86 patches in all).  They can
all be broken down into the following categories:
	- driver core locking rework (added klists)
	- class_simple rework (removing it and moving that api to be the
	  main class api)
	- sysfs attribute change for driver attributes (gets another
	  parameter on all attributes).
	- const marking for some driver core structures
	- persistent permissions and owners for sysfs files
	- misc sysfs and driver core changes and fixes.

Due to some of the driver core apis changing, it has required all users
of these functions to also change.  That accounts for the large size in
these patches, and why they touch so many different files.  If you want
me to break these down into the individual categories (one per pull), I
would be glad to do so.

All of these have been in the -mm tree for a few months.

Please pull from:
	rsync://rsync.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/
or if master.kernel.org hasn't synced up yet (seems like the git trees
are killing the mirror functions), use the following directory on
master.kernel.org:
	/pub/scm/linux/kernel/git/gregkh/driver-2.6.git/

The full patch series will sent to the linux-kernel mailing list, if
anyone wants to see them.

thanks,

greg k-h


 Documentation/DocBook/kernel-api.tmpl    |    1 
 Documentation/driver-model/device.txt    |    8 
 Documentation/driver-model/driver.txt    |   51 +-
 Documentation/filesystems/sysfs.txt      |    2 
 arch/arm/common/amba.c                   |    2 
 arch/arm/kernel/ecard.c                  |   12 
 arch/arm26/kernel/ecard.c                |   10 
 arch/i386/kernel/cpuid.c                 |   22 -
 arch/i386/kernel/msr.c                   |   22 -
 arch/ia64/sn/kernel/tiocx.c              |   25 -
 arch/parisc/kernel/drivers.c             |    2 
 arch/ppc/kernel/pci.c                    |    2 
 arch/ppc/syslib/ocp.c                    |    2 
 arch/ppc/syslib/of_device.c              |    2 
 arch/ppc64/kernel/of_device.c            |    2 
 arch/ppc64/kernel/pci.c                  |    2 
 arch/ppc64/kernel/vio.c                  |    4 
 drivers/acpi/scan.c                      |    4 
 drivers/base/Makefile                    |    4 
 drivers/base/base.h                      |    2 
 drivers/base/bus.c                       |  331 +++-------------
 drivers/base/class.c                     |  194 ++++++++-
 drivers/base/class_simple.c              |  199 ---------
 drivers/base/core.c                      |   64 +--
 drivers/base/dd.c                        |  534 +++++++++++++++++++-------
 drivers/base/dmapool.c                   |    2 
 drivers/base/driver.c                    |   67 ++-
 drivers/base/node.c                      |   20 
 drivers/base/power/resume.c              |    8 
 drivers/base/power/suspend.c             |   16 
 drivers/base/power/sysfs.c               |    4 
 drivers/base/sys.c                       |    4 
 drivers/block/aoe/aoechr.c               |   10 
 drivers/block/as-iosched.c               |    4 
 drivers/block/cfq-iosched.c              |    4 
 drivers/block/deadline-iosched.c         |    4 
 drivers/block/genhd.c                    |    2 
 drivers/block/ll_rw_blk.c                |    4 
 drivers/block/paride/pg.c                |   14 
 drivers/block/paride/pt.c                |   20 
 drivers/block/ub.c                       |    2 
 drivers/char/dsp56k.c                    |   14 
 drivers/char/ftape/zftape/zftape-init.c  |   30 -
 drivers/char/hvcs.c                      |   14 
 drivers/char/ip2main.c                   |   24 -
 drivers/char/ipmi/ipmi_devintf.c         |   14 
 drivers/char/istallion.c                 |   10 
 drivers/char/lp.c                        |   12 
 drivers/char/mbcs.c                      |    4 
 drivers/char/mem.c                       |    7 
 drivers/char/misc.c                      |   16 
 drivers/char/mwave/mwavedd.c             |    2 
 drivers/char/ppdev.c                     |   12 
 drivers/char/raw.c                       |   18 
 drivers/char/snsc.c                      |    9 
 drivers/char/stallion.c                  |   10 
 drivers/char/tipar.c                     |   14 
 drivers/char/tpm/tpm.c                   |    6 
 drivers/char/tty_io.c                    |   16 
 drivers/char/vc_screen.c                 |   16 
 drivers/char/viotape.c                   |   16 
 drivers/cpufreq/cpufreq.c                |    4 
 drivers/dio/dio-sysfs.c                  |   10 
 drivers/eisa/eisa-bus.c                  |    4 
 drivers/firmware/edd.c                   |    2 
 drivers/firmware/efivars.c               |    4 
 drivers/i2c/chips/adm1021.c              |    6 
 drivers/i2c/chips/adm1025.c              |   28 -
 drivers/i2c/chips/adm1026.c              |  622 ++++++++++++++-----------------
 drivers/i2c/chips/adm1031.c              |   44 +-
 drivers/i2c/chips/asb100.c               |   46 +-
 drivers/i2c/chips/ds1621.c               |    6 
 drivers/i2c/chips/fscher.c               |    8 
 drivers/i2c/chips/fscpos.c               |   16 
 drivers/i2c/chips/gl518sm.c              |   12 
 drivers/i2c/chips/gl520sm.c              |    8 
 drivers/i2c/chips/it87.c                 |   50 +-
 drivers/i2c/chips/lm63.c                 |   24 -
 drivers/i2c/chips/lm75.c                 |    4 
 drivers/i2c/chips/lm77.c                 |   14 
 drivers/i2c/chips/lm78.c                 |   36 -
 drivers/i2c/chips/lm80.c                 |   20 
 drivers/i2c/chips/lm83.c                 |    6 
 drivers/i2c/chips/lm85.c                 |   72 +--
 drivers/i2c/chips/lm87.c                 |   46 +-
 drivers/i2c/chips/lm90.c                 |   12 
 drivers/i2c/chips/lm92.c                 |   14 
 drivers/i2c/chips/max1619.c              |    6 
 drivers/i2c/chips/pc87360.c              |   68 +--
 drivers/i2c/chips/pcf8574.c              |    6 
 drivers/i2c/chips/pcf8591.c              |   10 
 drivers/i2c/chips/sis5595.c              |   34 -
 drivers/i2c/chips/smsc47b397.c           |    4 
 drivers/i2c/chips/smsc47m1.c             |   20 
 drivers/i2c/chips/via686a.c              |   32 -
 drivers/i2c/chips/w83627hf.c             |   56 +-
 drivers/i2c/chips/w83781d.c              |   52 +-
 drivers/i2c/chips/w83l785ts.c            |    4 
 drivers/i2c/i2c-core.c                   |    4 
 drivers/ieee1394/dv1394.c                |    6 
 drivers/ieee1394/ieee1394_core.c         |    8 
 drivers/ieee1394/ieee1394_core.h         |    3 
 drivers/ieee1394/nodemgr.c               |   27 -
 drivers/ieee1394/raw1394.c               |   10 
 drivers/ieee1394/sbp2.c                  |    2 
 drivers/ieee1394/video1394.c             |    4 
 drivers/infiniband/core/sysfs.c          |  124 ++----
 drivers/input/evdev.c                    |    9 
 drivers/input/gameport/gameport.c        |    4 
 drivers/input/input.c                    |   10 
 drivers/input/joydev.c                   |    8 
 drivers/input/keyboard/atkbd.c           |    4 
 drivers/input/mouse/psmouse.h            |    4 
 drivers/input/mousedev.c                 |   16 
 drivers/input/serio/serio.c              |   16 
 drivers/input/tsdev.c                    |    9 
 drivers/isdn/capi/capi.c                 |   14 
 drivers/macintosh/adb.c                  |    9 
 drivers/macintosh/therm_adt746x.c        |   11 
 drivers/macintosh/therm_pm72.c           |    4 
 drivers/macintosh/therm_windtunnel.c     |    4 
 drivers/mca/mca-bus.c                    |    4 
 drivers/media/dvb/dvb-core/dvbdev.c      |   13 
 drivers/message/fusion/mptscsih.c        |    2 
 drivers/message/fusion/mptscsih.h        |    2 
 drivers/mmc/mmc_sysfs.c                  |    2 
 drivers/net/ppp_generic.c                |   14 
 drivers/net/wan/cosa.c                   |   12 
 drivers/pci/hotplug/cpqphp_sysfs.c       |    4 
 drivers/pci/hotplug/pci_hotplug_core.c   |    4 
 drivers/pci/hotplug/rpadlpar_sysfs.c     |    2 
 drivers/pci/hotplug/shpchp_sysfs.c       |    4 
 drivers/pci/pci-driver.c                 |   26 -
 drivers/pci/pci-sysfs.c                  |   21 -
 drivers/pci/pcie/portdrv_core.c          |  139 +++---
 drivers/pcmcia/ds.c                      |    4 
 drivers/pnp/card.c                       |    4 
 drivers/pnp/driver.c                     |   12 
 drivers/pnp/interface.c                  |    8 
 drivers/s390/block/dasd_devmap.c         |   10 
 drivers/s390/block/dcssblk.c             |   24 -
 drivers/s390/char/raw3270.c              |    6 
 drivers/s390/char/tape_class.c           |   10 
 drivers/s390/char/tape_core.c            |   10 
 drivers/s390/char/vmlogrdr.c             |   22 -
 drivers/s390/cio/ccwgroup.c              |    6 
 drivers/s390/cio/chsc.c                  |    6 
 drivers/s390/cio/cmf.c                   |   12 
 drivers/s390/cio/device.c                |   14 
 drivers/s390/net/claw.c                  |   40 -
 drivers/s390/net/ctcmain.c               |   18 
 drivers/s390/net/lcs.c                   |   10 
 drivers/s390/net/netiucv.c               |   44 +-
 drivers/s390/net/qeth_sys.c              |  126 +++---
 drivers/s390/scsi/zfcp_scsi.c            |    2 
 drivers/s390/scsi/zfcp_sysfs_adapter.c   |   10 
 drivers/s390/scsi/zfcp_sysfs_port.c      |   10 
 drivers/s390/scsi/zfcp_sysfs_unit.c      |    6 
 drivers/scsi/53c700.c                    |    2 
 drivers/scsi/arm/eesox.c                 |    4 
 drivers/scsi/arm/powertec.c              |    4 
 drivers/scsi/ipr.c                       |    2 
 drivers/scsi/megaraid/megaraid_mbox.c    |    4 
 drivers/scsi/osst.c                      |   10 
 drivers/scsi/scsi_sysfs.c                |   42 +-
 drivers/scsi/scsi_transport_spi.c        |   16 
 drivers/scsi/sg.c                        |   14 
 drivers/scsi/st.c                        |   28 -
 drivers/sh/superhyway/superhyway-sysfs.c |    2 
 drivers/usb/core/devices.c               |    2 
 drivers/usb/core/file.c                  |   13 
 drivers/usb/core/hcd.c                   |   61 +--
 drivers/usb/core/sysfs.c                 |   26 -
 drivers/usb/core/usb.c                   |   59 +-
 drivers/usb/gadget/dummy_hcd.c           |    4 
 drivers/usb/gadget/file_storage.c        |    8 
 drivers/usb/gadget/net2280.c             |    6 
 drivers/usb/gadget/pxa2xx_udc.c          |    2 
 drivers/usb/host/ehci-dbg.c              |   10 
 drivers/usb/host/ohci-dbg.c              |   10 
 drivers/usb/input/aiptek.c               |   78 +--
 drivers/usb/misc/cytherm.c               |   20 
 drivers/usb/misc/phidgetkit.c            |   14 
 drivers/usb/misc/phidgetservo.c          |    4 
 drivers/usb/misc/usbled.c                |    4 
 drivers/usb/serial/ftdi_sio.c            |    6 
 drivers/usb/storage/scsiglue.c           |    4 
 drivers/video/fbmem.c                    |   10 
 drivers/video/gbefb.c                    |    4 
 drivers/video/w100fb.c                   |   12 
 drivers/w1/w1.c                          |   16 
 drivers/w1/w1_family.h                   |    4 
 drivers/w1/w1_smem.c                     |    8 
 drivers/w1/w1_therm.c                    |    8 
 drivers/zorro/zorro-sysfs.c              |    4 
 fs/coda/psdev.c                          |   18 
 fs/debugfs/file.c                        |   67 +--
 fs/libfs.c                               |  100 ++++
 fs/sysfs/bin.c                           |    4 
 fs/sysfs/dir.c                           |   26 -
 fs/sysfs/file.c                          |    6 
 fs/sysfs/inode.c                         |  102 ++++-
 fs/sysfs/mount.c                         |    4 
 fs/sysfs/symlink.c                       |    8 
 fs/sysfs/sysfs.h                         |    4 
 include/asm-ppc/ocp.h                    |    2 
 include/linux/device.h                   |   66 +--
 include/linux/fs.h                       |   46 ++
 include/linux/i2c-sysfs.h                |   36 +
 include/linux/input.h                    |    2 
 include/linux/klist.h                    |   55 ++
 include/linux/kobject.h                  |    8 
 include/linux/node.h                     |    1 
 include/linux/sysfs.h                    |   15 
 include/linux/usb.h                      |    5 
 kernel/params.c                          |    4 
 lib/Makefile                             |    7 
 lib/klist.c                              |  269 +++++++++++++
 lib/kobject.c                            |    2 
 lib/kobject_uevent.c                     |    6 
 security/seclvl.c                        |    4 
 sound/core/sound.c                       |    6 
 sound/oss/soundcard.c                    |   19 
 sound/sound_core.c                       |   10 
 224 files changed, 3194 insertions(+), 2568 deletions(-)

---------------

Adrian Bunk:
  fix "make mandocs" after class_simple.c removal

Alan Stern:
  usbcore: Don't call device_release_driver recursively
  driver core: Fix races in driver_detach()

Andrew Morton:
  fix up ipmi code after class_simple.c removal

Arnd Bergmann:
  libfs: add simple attribute files

Benjamin Herrenschmidt:
  Driver core: Don't "lose" devices on suspend on failure

David Brownell:
  Driver Core: driver model doc update

Dmitry Torokhov:
  sysfs: (rest) if show/store is missing return -EIO
  sysfs: (driver/block) if show/store is missing return -EIO
  sysfs: (driver/pci) if show/store is missing return -EIO
  sysfs: if show/store is missing return -EIO
  sysfs: (driver/base) if show/store is missing return -EIO
  Make attributes names const char *
  make driver's name be const char *
  kset_hotplug_ops->name shoudl return const char *
  Make kobject's name be const char *
  kobject_hotplug() should use kobject_name()
  sysfs_{create|remove}_link should take const char *

Greg Kroah-Hartman:
  PCI: fix show_modalias() function due to attribute change
  USB: fix show_modalias() function due to attribute change
  Driver core: Fix up the driver and device iterators to be quieter
  USB: fix build warning in usb core as pointed out by Andrew.
  Use device_for_each_child() to unregister devices in nodemgr_remove_host_dev()
  driver core: change export symbol for driver_for_each_device()
  use device_for_each_child() to properly access child devices.
  class: remove class_simple code, as no one in the tree is using it anymore.
  class: add kerneldoc for the new class functions.
  class: convert the remaining class_simple users in the kernel to usee the new class api
  class: convert arch/* to use the new class api instead of class_simple
  class: convert drivers/* to use the new class api instead of class_simple
  class: convert drivers/scsi/* to use the new class api instead of class_simple
  class: convert drivers/char/* to use the new class api instead of class_simple
  class: convert drivers/ieee1394/* to use the new class api instead of class_simple
  class: convert drivers/block/* to use the new class api instead of class_simple
  USB: move the usb hcd code to use the new class code.
  class: convert sound/* to use the new class api instead of class_simple
  CLASS: move a "simple" class logic into the class core.
  tty: move to use the new class code, instead of class_simple
  INPUT: move to use the new class code, instead of class_simple

Hannes Reinecke:
  driver core: fix error handling in bus_add_device

Jason Uhlenkott:
  Fix typo in scdrv_init()

Jon Smirl:
  SYSFS: fix PAGE_SIZE check

Keiichiro Tokunaga:
  Driver core: unregister_node() for hotplug use

long:
  use device_for_each_child() to properly access child devices.

Maneesh Soni:
  sysfs-iattr: add sysfs_setattr
  sysfs-iattr: set inode attributes
  sysfs-iattr: attach sysfs_dirent before new inode

Mark M. Hoffman:
  USB: trivial error path fix

Patrick Mochel:
  Fix up bogus comment.
  Use a klist for device child lists.
  Use device_for_each_child() to unregister devices in scsi_remove_target().
  Call klist_del() instead of klist_remove().
  Don't reference NULL klist pointer in klist_remove().
  Remove struct device::bus_list.
  Fix up bus code and remove use of rwsem.
  Remove struct device::driver_list.
  Fix up USB to use klist_node_attached() instead of list_empty() on lists that will go away.
  add klist_node_attached() to determine if a node is on a list or not.
  Use bus_for_each_{dev,drv} for driver binding.
  Remove the unused device_find().
  Add a klist to struct device_driver for the devices bound to it.
  Add initial implementation of klist helpers.
  Add a klist to struct bus_type for its devices.
  Add a klist to struct bus_type for its drivers.
  Add driver_for_each_device().
  Use driver_for_each_device() in drivers/pnp/driver.c instead of manually walking list.
  Use driver_for_each_device() instead of manually walking list.
  Move device/driver code to drivers/base/dd.c
  Add a semaphore to struct device to synchronize calls to its driver.
  sn: fixes due to driver core changes
  usb: klist_node_attached() fix
  Driver Core: fix bk-driver-core kills ppc64

Yani Ioannou:
  I2C: add i2c sensor_device_attribute and macros
  I2C: drivers/i2c/chips/adm1026.c: use dynamic sysfs callbacks
  Driver Core: include: update device attribute callbacks
  Driver Core: drivers/s390/net/qeth_sys.c - drivers/usb/gadget/pxa2xx_udc.c: update device attribute callbacks
  Driver Core: drivers/usb/input/aiptek.c - drivers/zorro/zorro-sysfs.c: update device attribute callbacks
  Driver Core: drivers/i2c/chips/w83781d.c - drivers/s390/block/dcssblk.c: update device attribute callbacks
  Driver Core: drivers/char/raw3270.c - drivers/net/netiucv.c: update device attribute callbacks
  Driver Core: drivers/i2c/chips/pc87360.c - w83627hf.c: update device attribute callbacks
  Driver Core: drivers/i2c/chips/lm77.c - max1619.c: update device attribute callbacks
  Driver Core: drivers/i2c/chips/adm1031.c - lm75.c: update device attribute callbacks
  Driver Core: arch: update device attribute callbacks
  Driver Core: drivers/base - drivers/i2c/chips/adm1026.c: update device attribute callbacks
  Driver core: Documentation: update device attribute callbacks
  Driver core: change device_attribute callbacks

