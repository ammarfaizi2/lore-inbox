Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317334AbSG3WwG>; Tue, 30 Jul 2002 18:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317345AbSG3WwG>; Tue, 30 Jul 2002 18:52:06 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:7942 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317334AbSG3Wv6>;
	Tue, 30 Jul 2002 18:51:58 -0400
Date: Tue, 30 Jul 2002 15:54:00 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: [BK PATCH] devfs cleanups for 2.5.29
Message-ID: <20020730225359.GA17826@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When devfs came alone, it created devfs_[un]register_chrdev and
devfs_[un]register_blkdev, which required that all drivers be changed to
be compatible with devfs. This change has been bothering a lot of people
for quite some time :)

These two small changesets (patches to follow this email) fix that
problem by removing these functions, and having the original
[un]register_chrdev and [un]register_blkdev ask devfs if the operation
should be performed _if_ devfs is currently compiled into the kernel.
No functionality is changed, but the kernel code base is reduced, and we
are back to a common API.

If people want me to, I'd be glad to make up a patch for 2.4 that does
this same thing.

Linus, please pull from:
	bk://linuxusb.bkbits.net/devfs-2.5

thanks,

greg k-h


 arch/m68k/atari/joystick.c              |    2 
 arch/sparc64/solaris/socksys.c          |    4 -
 drivers/block/DAC960.c                  |    4 -
 drivers/block/acsi.c                    |    7 +-
 drivers/block/acsi_slm.c                |    6 +-
 drivers/block/floppy.c                  |   10 ++--
 drivers/block/loop.c                    |    4 -
 drivers/block/paride/pd.c               |    6 +-
 drivers/block/paride/pg.c               |    4 -
 drivers/block/paride/pt.c               |    4 -
 drivers/block/ps2esdi.c                 |    7 +-
 drivers/block/swim3.c                   |    2 
 drivers/block/xd.c                      |    6 +-
 drivers/cdrom/aztcd.c                   |    4 -
 drivers/cdrom/cdu31a.c                  |    6 +-
 drivers/cdrom/cm206.c                   |    4 -
 drivers/cdrom/gscd.c                    |    4 -
 drivers/cdrom/mcd.c                     |    4 -
 drivers/cdrom/mcdx.c                    |    4 -
 drivers/cdrom/optcd.c                   |    5 --
 drivers/cdrom/sbpcd.c                   |    6 +-
 drivers/cdrom/sjcd.c                    |    4 -
 drivers/cdrom/sonycd535.c               |   14 ++---
 drivers/char/dsp56k.c                   |    4 -
 drivers/char/dtlk.c                     |    4 -
 drivers/char/ftape/zftape/zftape-init.c |    4 -
 drivers/char/ip2main.c                  |   14 -----
 drivers/char/istallion.c                |    4 -
 drivers/char/lp.c                       |    4 -
 drivers/char/mem.c                      |    2 
 drivers/char/misc.c                     |    2 
 drivers/char/ppdev.c                    |    4 -
 drivers/char/stallion.c                 |    4 -
 drivers/char/tpqic02.c                  |    4 -
 drivers/char/tty_io.c                   |    6 +-
 drivers/char/vc_screen.c                |    2 
 drivers/i2c/i2c-dev.c                   |    8 ---
 drivers/ide/hd.c                        |    3 -
 drivers/ide/ide-tape.c                  |    6 +-
 drivers/ide/probe.c                     |    2 
 drivers/input/input.c                   |    4 -
 drivers/isdn/capi/capi.c                |    6 +-
 drivers/isdn/i4l/isdn_common.c          |    8 +--
 drivers/macintosh/adb.c                 |    2 
 drivers/md/lvm.c                        |   22 ++++----
 drivers/md/md.c                         |    5 --
 drivers/media/video/videodev.c          |    5 --
 drivers/mtd/mtdblock.c                  |   18 +------
 drivers/mtd/mtdchar.c                   |   17 +-----
 drivers/net/ppp_generic.c               |    4 -
 drivers/net/wan/cosa.c                  |    8 +--
 drivers/s390/block/dasd_genhd.c         |    5 --
 drivers/s390/block/xpram.c              |    4 -
 drivers/s390/char/tapeblock.c           |   12 ----
 drivers/s390/char/tapechar.c            |    8 ---
 drivers/s390/char/tubfs.c               |   11 ----
 drivers/sbus/audio/audio.c              |    4 -
 drivers/sbus/char/bpp.c                 |    4 -
 drivers/sbus/char/sunkbd.c              |    2 
 drivers/sbus/char/vfc_dev.c             |    4 -
 drivers/scsi/osst.c                     |   16 ------
 drivers/scsi/sd.c                       |    7 +-
 drivers/scsi/sg.c                       |    5 --
 drivers/scsi/sr.c                       |   10 ++--
 drivers/scsi/st.c                       |    4 -
 drivers/sgi/char/shmiq.c                |    2 
 drivers/usb/core/file.c                 |    4 -
 drivers/usb/misc/tiglusb.c              |    6 +-
 drivers/video/fbmem.c                   |    2 
 fs/block_dev.c                          |    4 +
 fs/coda/psdev.c                         |    6 +-
 fs/devfs/base.c                         |   80 ++++++++++++--------------------
 fs/devices.c                            |    5 ++
 include/linux/devfs_fs_kernel.h         |   30 +++++-------
 net/netlink/netlink_dev.c               |    4 -
 sound/core/sound.c                      |    8 ---
 sound/sound_core.c                      |    5 --
 77 files changed, 218 insertions(+), 331 deletions(-)
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

