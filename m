Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318436AbSGaScI>; Wed, 31 Jul 2002 14:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318439AbSGaScI>; Wed, 31 Jul 2002 14:32:08 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:62727 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318436AbSGaScF>;
	Wed, 31 Jul 2002 14:32:05 -0400
Date: Wed, 31 Jul 2002 11:33:59 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: [BK PATCH] devfs cleanups for 2.5.29 - take 2
Message-ID: <20020731183358.GA21793@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

First off, I've added one more small patch to this series, that removes
all of the devfs_should* functions that I created, with a simple
devfs_only() call that is much easier to understand what is happening.

Secondly, as to Richard's assertion that this patch will break things,
here are a list of the block and then character drivers that "might"
break if "devfs=only" is enabled, and this patch is applied:

    Block drivers whose usage in "devfs=only" mode will be affected:
	cpqarray.c	- actually this driver looks broken for devfs anyway
	stram.c
	fd177d.c
	mfmhd.c
	amiflop.c
	cciss.c
	pf.c
	swim_iop.c
	z2ram.c
	ataraid.c
	i20_block.c
	ftl.c
	ntflcore.c
	jsflash.c

   Char drivers whose usage in "devfs=only" mode will be affected:
	ds1302.c	- arch/cris driver
	eeprom.c	- arch/cris driver
	gpio.c		- arch/cris driver
	i2c.c		- arch/cris driver
	sync_serial.c	- arch/cris driver
	cpuid.c
	msr.c
	drm_stub.c
	raw.c
	pcilynx.c
	lincfg.c
	ds.c
	dpt_i2o.c
	megaraid.c
	phonedev.c
	psdev.c		- fs/intermesso driver

As you can see, this list is _much_ smaller than the list of drivers
that have had to have the "devfs_*" function change to them.  Please do
not penalize all of the kernel because these few drivers have not been
"fixed".  If "devfs=only" mode is important enough to users of these
drivers, they will be fixed.

Thirdly, I got a machine up and running with devfs, and this patch does
not effect it at all.  To be fair, I could not boot _any_ recent 2.5
kernel without this patch in "devfs=only" mode, but that must be because
the Gentoo people are not crazy enough to set up their distro to run in
this devfs mode.  And these people are pretty dedicated to devfs, so I
can't test "devfs=only" mode myself with this patch.  But from looking
at the above list of drivers, I don't see anything preventing this from
happening with my (and most everyone else's) hardware.

So Linus, please take these changesets.  A large number of driver
authors have told me they would like this patch into the kernel, and it
cleans up the driver API to be much saner (as well as making devfs less
intrusive to all drivers).

Please pull from:
	bk://linuxusb.bkbits.net/devfs-2.5

thanks,

greg k-h

Overall diffstat for these changesets:

 arch/m68k/atari/joystick.c              |    2 
 arch/sparc64/solaris/socksys.c          |    4 
 drivers/block/DAC960.c                  |    4 
 drivers/block/acsi.c                    |    7 -
 drivers/block/acsi_slm.c                |    6 -
 drivers/block/floppy.c                  |   10 +-
 drivers/block/loop.c                    |    4 
 drivers/block/paride/pd.c               |    6 -
 drivers/block/paride/pg.c               |    4 
 drivers/block/paride/pt.c               |    4 
 drivers/block/ps2esdi.c                 |    7 -
 drivers/block/swim3.c                   |    2 
 drivers/block/xd.c                      |    6 -
 drivers/cdrom/aztcd.c                   |    4 
 drivers/cdrom/cdu31a.c                  |    6 -
 drivers/cdrom/cm206.c                   |    4 
 drivers/cdrom/gscd.c                    |    4 
 drivers/cdrom/mcd.c                     |    4 
 drivers/cdrom/mcdx.c                    |    4 
 drivers/cdrom/optcd.c                   |    5 -
 drivers/cdrom/sbpcd.c                   |    6 -
 drivers/cdrom/sjcd.c                    |    4 
 drivers/cdrom/sonycd535.c               |   14 +--
 drivers/char/dsp56k.c                   |    4 
 drivers/char/dtlk.c                     |    4 
 drivers/char/ftape/zftape/zftape-init.c |    4 
 drivers/char/ip2main.c                  |   14 ---
 drivers/char/istallion.c                |    4 
 drivers/char/lp.c                       |    4 
 drivers/char/mem.c                      |    2 
 drivers/char/misc.c                     |    2 
 drivers/char/ppdev.c                    |    4 
 drivers/char/stallion.c                 |    4 
 drivers/char/tpqic02.c                  |    4 
 drivers/char/tty_io.c                   |    6 -
 drivers/char/vc_screen.c                |    2 
 drivers/i2c/i2c-dev.c                   |    8 -
 drivers/ide/hd.c                        |    3 
 drivers/ide/ide-tape.c                  |    6 -
 drivers/ide/probe.c                     |    2 
 drivers/input/input.c                   |    4 
 drivers/isdn/capi/capi.c                |    6 -
 drivers/isdn/i4l/isdn_common.c          |    8 -
 drivers/macintosh/adb.c                 |    2 
 drivers/md/lvm.c                        |   22 ++---
 drivers/md/md.c                         |    5 -
 drivers/media/video/videodev.c          |    5 -
 drivers/mtd/mtdblock.c                  |   18 ----
 drivers/mtd/mtdchar.c                   |   17 ----
 drivers/net/ppp_generic.c               |    4 
 drivers/net/wan/cosa.c                  |    8 -
 drivers/s390/block/dasd_genhd.c         |    5 -
 drivers/s390/block/xpram.c              |    4 
 drivers/s390/char/tapeblock.c           |   12 --
 drivers/s390/char/tapechar.c            |    8 -
 drivers/s390/char/tubfs.c               |   11 --
 drivers/sbus/audio/audio.c              |    4 
 drivers/sbus/char/bpp.c                 |    4 
 drivers/sbus/char/sunkbd.c              |    2 
 drivers/sbus/char/vfc_dev.c             |    4 
 drivers/scsi/osst.c                     |   16 ---
 drivers/scsi/sd.c                       |    7 -
 drivers/scsi/sg.c                       |    5 -
 drivers/scsi/sr.c                       |   10 +-
 drivers/scsi/st.c                       |    4 
 drivers/sgi/char/shmiq.c                |    2 
 drivers/usb/core/file.c                 |    4 
 drivers/usb/misc/tiglusb.c              |    6 -
 drivers/video/fbmem.c                   |    2 
 fs/block_dev.c                          |    8 +
 fs/coda/psdev.c                         |    6 -
 fs/devfs/base.c                         |  130 ++++++++------------------------
 fs/devices.c                            |    9 +-
 include/linux/devfs_fs_kernel.h         |   49 +++---------
 net/netlink/netlink_dev.c               |    4 
 sound/core/sound.c                      |    8 -
 sound/sound_core.c                      |    5 -
 77 files changed, 228 insertions(+), 398 deletions(-)
------

ChangeSet@1.546, 2002-07-30 21:46:34-07:00, greg@kroah.com
  Remove the devfs_should* functions I added, and replace them with one devfs_only() call
  
  This now explains what is really going on much better than before.

 fs/block_dev.c                  |    4 +--
 fs/devfs/base.c                 |   50 +++-------------------------------------
 fs/devices.c                    |    4 +--
 include/linux/devfs_fs_kernel.h |   19 +--------------
 4 files changed, 10 insertions(+), 67 deletions(-)
------

ChangeSet@1.545, 2002-07-30 15:40:49-07:00, greg@kroah.com
  Removed devfs_register_blkdev and devfs_unregister_blkdev.
  
  Use register_blkdev and unregister_blkdev as before, and everything will work just fine.

 drivers/block/DAC960.c          |    4 ++--
 drivers/block/acsi.c            |    7 +++----
 drivers/block/floppy.c          |   10 +++++-----
 drivers/block/loop.c            |    4 ++--
 drivers/block/paride/pd.c       |    6 +++---
 drivers/block/ps2esdi.c         |    7 +++----
 drivers/block/swim3.c           |    2 +-
 drivers/block/xd.c              |    6 +++---
 drivers/cdrom/aztcd.c           |    4 ++--
 drivers/cdrom/cdu31a.c          |    6 +++---
 drivers/cdrom/cm206.c           |    4 ++--
 drivers/cdrom/gscd.c            |    4 ++--
 drivers/cdrom/mcd.c             |    4 ++--
 drivers/cdrom/mcdx.c            |    4 ++--
 drivers/cdrom/optcd.c           |    5 ++---
 drivers/cdrom/sbpcd.c           |    6 +++---
 drivers/cdrom/sjcd.c            |    4 ++--
 drivers/cdrom/sonycd535.c       |   14 +++++++-------
 drivers/ide/hd.c                |    3 +--
 drivers/ide/probe.c             |    2 +-
 drivers/md/lvm.c                |   10 ++++------
 drivers/md/md.c                 |    5 ++---
 drivers/mtd/mtdblock.c          |   18 ++++--------------
 drivers/s390/block/dasd_genhd.c |    5 ++---
 drivers/s390/block/xpram.c      |    4 ++--
 drivers/s390/char/tapeblock.c   |   12 ------------
 drivers/scsi/sd.c               |    7 +++----
 drivers/scsi/sr.c               |   10 +++++-----
 fs/block_dev.c                  |    4 ++++
 fs/devfs/base.c                 |   40 ++++++++++++++++------------------------
 include/linux/devfs_fs_kernel.h |   16 +++++++---------
 31 files changed, 100 insertions(+), 137 deletions(-)
------

ChangeSet@1.544, 2002-07-30 14:38:11-07:00, greg@kroah.com
  Removed devfs_register_chrdev and devfs_unregister_chrdev.
  
  Use register_chrdev and unregister_chrdev as before, and everything will work.

except that the repository that you are pushing to is 5 changesets
ahead of your repository. Please do a "bk pull" to get 
these changes or do a "bk pull -nl" to see what they are.
 arch/m68k/atari/joystick.c              |    2 -
 arch/sparc64/solaris/socksys.c          |    4 +--
 drivers/block/acsi_slm.c                |    6 ++--
 drivers/block/paride/pg.c               |    4 +--
 drivers/block/paride/pt.c               |    4 +--
 drivers/char/dsp56k.c                   |    4 +--
 drivers/char/dtlk.c                     |    4 +--
 drivers/char/ftape/zftape/zftape-init.c |    4 +--
 drivers/char/ip2main.c                  |   14 +----------
 drivers/char/istallion.c                |    4 +--
 drivers/char/lp.c                       |    4 +--
 drivers/char/mem.c                      |    2 -
 drivers/char/misc.c                     |    2 -
 drivers/char/ppdev.c                    |    4 +--
 drivers/char/stallion.c                 |    4 +--
 drivers/char/tpqic02.c                  |    4 +--
 drivers/char/tty_io.c                   |    6 ++--
 drivers/char/vc_screen.c                |    2 -
 drivers/i2c/i2c-dev.c                   |    8 ------
 drivers/ide/ide-tape.c                  |    6 ++--
 drivers/input/input.c                   |    4 +--
 drivers/isdn/capi/capi.c                |    6 ++--
 drivers/isdn/i4l/isdn_common.c          |    8 +++---
 drivers/macintosh/adb.c                 |    2 -
 drivers/md/lvm.c                        |   12 ++++-----
 drivers/media/video/videodev.c          |    5 +---
 drivers/mtd/mtdchar.c                   |   17 ++-----------
 drivers/net/ppp_generic.c               |    4 +--
 drivers/net/wan/cosa.c                  |    8 +++---
 drivers/s390/char/tapechar.c            |    8 ------
 drivers/s390/char/tubfs.c               |   11 +-------
 drivers/sbus/audio/audio.c              |    4 +--
 drivers/sbus/char/bpp.c                 |    4 +--
 drivers/sbus/char/sunkbd.c              |    2 -
 drivers/sbus/char/vfc_dev.c             |    4 +--
 drivers/scsi/osst.c                     |   16 ------------
 drivers/scsi/sg.c                       |    5 +---
 drivers/scsi/st.c                       |    4 +--
 drivers/sgi/char/shmiq.c                |    2 -
 drivers/usb/core/file.c                 |    4 +--
 drivers/usb/misc/tiglusb.c              |    6 ++--
 drivers/video/fbmem.c                   |    2 -
 fs/coda/psdev.c                         |    6 ++--
 fs/devfs/base.c                         |   40 +++++++++++---------------------
 fs/devices.c                            |    5 ++++
 include/linux/devfs_fs_kernel.h         |   14 ++++-------
 net/netlink/netlink_dev.c               |    4 +--
 sound/core/sound.c                      |    8 ------
 sound/sound_core.c                      |    5 +---
 49 files changed, 118 insertions(+), 194 deletions(-)
------
