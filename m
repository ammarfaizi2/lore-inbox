Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965196AbWILKN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965196AbWILKN1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 06:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWILKN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 06:13:27 -0400
Received: from brick.kernel.dk ([62.242.22.158]:11887 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S965196AbWILKN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 06:13:26 -0400
Date: Tue, 12 Sep 2006 12:11:41 +0200
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Subject: What's in linux-2.6-block.git
Message-ID: <20060912101141.GA19018@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This lists the main features of the 'block' branch, which is bound for
Linus when 2.6.19 opens:

- Splitting of request->flags into two parts:
	- cmd type
	- modified flags
  Right now it's a bit of a mess, splitting this up invites a cleaner
  usage and also enables us to implement generic "messages" passed on
  the regular queue for the device.

- Abstract out the request back merging and put it into the core io
  scheduler layer. Cleans up all the io schedulers, and noop gets
  merging for "free".

- Abstract out the rbtree sorting. Gets rid of duplicated code in
  as/cfq/deadline.

- General shrinkage of the request structure.

- Killing dynamic rq private structures in deadline/as/cfq. This should
  speed up the io path somewhat, as we avoid allocating several
  structures (struct request + scheduler private request) for each io
  request.

- meta data io logging for blktrace.

- CFQ improvements.

- Make the block layer configurable through Kconfig (David Howells).

- Lots of cleanups.

The repo can be found here:

  git://git.kernel.dk/data/git/linux-2.6-block.git

Andrew Morton:
      CONFIG_BLOCK internal.h cleanups
      CONFIG_BLOCK: blk_congestion_wait() fix

David Howells:
      BLOCK: Move functions out of buffer code [try #6]
      BLOCK: Remove duplicate declaration of exit_io_context() [try #6]
      BLOCK: Stop fallback_migrate_page() from using page_has_buffers() [try #6]
      BLOCK: Separate the bounce buffering code from the highmem code [try #6]
      BLOCK: Don't call block_sync_page() from AFS [try #6]
      BLOCK: Move extern declarations out of fs/*.c into header files [try #6]
      BLOCK: Remove dependence on existence of blockdev_superblock [try #6]
      BLOCK: Dissociate generic_writepages() from mpage stuff [try #6]
      BLOCK: Move __invalidate_device() to block_dev.c [try #6]
      BLOCK: Move the loop device ioctl compat stuff to the loop driver [try #6]
      BLOCK: Move common FS-specific ioctls to linux/fs.h [try #6]
      BLOCK: Move the ReiserFS device ioctl compat stuff to the ReiserFS driver [try #6]
      BLOCK: Move the Ext2 device ioctl compat stuff to the Ext2 driver [try #6]
      BLOCK: Move the Ext3 device ioctl compat stuff to the Ext3 driver [try #6]
      BLOCK: Move the msdos device ioctl compat stuff to the msdos driver [try #6]
      BLOCK: Remove no-longer necessary linux/mpage.h inclusions [try #6]
      BLOCK: Remove no-longer necessary linux/buffer_head.h inclusions [try #6]
      BLOCK: Make it possible to disable the block layer [try #6]
      BLOCK: Make USB storage depend on SCSI rather than selecting it [try #6]

Jens Axboe:
      Split struct request ->flags into two parts
      elevator: move the backmerging logic into the elevator core
      rbtree: fixed reversed RB_EMPTY_NODE and rb_next/prev
      elevator: abstract out the rbtree sort handling
      as-iosched: migrate to using the elevator rb functions
      cfq-iosched: migrate to using the elevator rb functions
      deadline-iosched: migrate to using the elevator rb functions
      elevator: introduce a way to reuse rq for internal FIFO handling
      cfq-iosched: convert to using the FIFO elevator defines
      as-iosched: reuse rq for fifo
      as-iosched: remove arq->is_sync member
      deadline-iosched: remove elevator private drq request type
      cfq-iosched: remove the crq flag functions/variable
      Add one more pointer to struct request for IO scheduler usage
      cfq-iosched: kill crq
      as-iosched: kill arq
      Remove ->waiting member from struct request
      Remove struct request_list from struct request
      Remove ->rq_status from struct request
      Drop useless bio passing in may_queue/set_request API
      ll_rw_blk: cleanup __make_request()
      struct request: shrink and optimize some more
      cfq-iosched: cleanups, fixes, dead code removal
      cfq-iosched: kill cfq_exit_lock
      elevator: define ioc counting mechanism
      as-iosched: use new io context counting mechanism
      cfq-iosched: use new io context counting mechanism
      Audit block layer inlines
      Kill various deprecated/unused block layer defines/functions
      Make sure all block/io scheduler setups are node aware
      cfq-iosched: Kill O(N) runtime of cfq_resort_rr_list()
      cfq-iosched: kill the empty_list
      Add blk_start_queueing() helper
      cfq-iosched: improve queue preemption
      ll_rw_blk: allow more flexibility for read_ahead_kb store
      Allow file systems to differentiate between data and meta reads
      ext3: make meta data reads use READ_META
      cfq-iosched: use metadata read flag
      blktrace: support for logging metadata reads
      SCSI: scsi_done_q is unused
      Update axboe@suse.de email address

Martin Peschke:
      [Patch] blktrace: cleanup using on_each_cpu

Milan Broz:
      fix creating zero sized bio mempools in low memory system

Oleg Nesterov:
      exit_io_context: don't disable irqs
      Don't need to disable interrupts for tasklist_lock

 MAINTAINERS                     |    8 
 arch/frv/Kconfig                |    4 
 arch/frv/kernel/time.c          |   81 ++++
 arch/ia64/kernel/sys_ia64.c     |   28 +
 arch/sparc/kernel/sys_sparc.c   |   27 +
 arch/sparc64/kernel/sys_sparc.c |   36 +-
 arch/um/drivers/ubd_kern.c      |    2 
 block/Kconfig                   |   20 +
 block/Kconfig.iosched           |    3 
 block/Makefile                  |    2 
 block/as-iosched.c              |  672 +++++++-----------------------
 block/blktrace.c                |   26 -
 block/cfq-iosched.c             |  865 +++++++++++++--------------------------
 block/deadline-iosched.c        |  464 +++------------------
 block/elevator.c                |  315 ++++++++++++--
 block/ll_rw_blk.c               |  223 ++++------
 block/noop-iosched.c            |    2 
 block/scsi_ioctl.c              |    6 
 drivers/block/DAC960.c          |    2 
 drivers/block/Kconfig           |    4 
 drivers/block/cciss.c           |    1 
 drivers/block/cpqarray.c        |    1 
 drivers/block/floppy.c          |    4 
 drivers/block/loop.c            |  160 +++++++
 drivers/block/nbd.c             |    8 
 drivers/block/paride/pd.c       |    6 
 drivers/block/pktcdvd.c         |    8 
 drivers/block/swim3.c           |    4 
 drivers/block/swim_iop.c        |    4 
 drivers/block/xd.c              |    2 
 drivers/cdrom/Kconfig           |    2 
 drivers/cdrom/cdrom.c           |    2 
 drivers/cdrom/cdu31a.c          |    4 
 drivers/char/Kconfig            |    1 
 drivers/char/random.c           |    4 
 drivers/fc4/fc.c                |    1 
 drivers/ide/Kconfig             |    4 
 drivers/ide/ide-cd.c            |   69 ++-
 drivers/ide/ide-disk.c          |    5 
 drivers/ide/ide-dma.c           |    2 
 drivers/ide/ide-floppy.c        |   17 -
 drivers/ide/ide-io.c            |   50 +-
 drivers/ide/ide-lib.c           |    5 
 drivers/ide/ide-proc.c          |    2 
 drivers/ide/ide-tape.c          |   14 -
 drivers/ide/ide-taskfile.c      |    8 
 drivers/ide/ide.c               |    8 
 drivers/ide/legacy/hd.c         |    2 
 drivers/ide/pci/sis5513.c       |    2 
 drivers/md/Kconfig              |    3 
 drivers/md/dm-emc.c             |    3 
 drivers/message/i2o/Kconfig     |    2 
 drivers/message/i2o/i2o_block.c |    7 
 drivers/mmc/Kconfig             |    2 
 drivers/mmc/Makefile            |    3 
 drivers/mmc/mmc_queue.c         |    6 
 drivers/mtd/Kconfig             |   12 -
 drivers/mtd/devices/Kconfig     |    2 
 drivers/mtd/mtd_blkdevs.c       |    2 
 drivers/net/Kconfig             |    2 
 drivers/s390/block/Kconfig      |    2 
 drivers/s390/block/dasd_diag.c  |    2 
 drivers/s390/block/dasd_eckd.c  |    2 
 drivers/s390/block/dasd_fba.c   |    2 
 drivers/scsi/Kconfig            |    2 
 drivers/scsi/aic7xxx_old.c      |    4 
 drivers/scsi/ide-scsi.c         |   16 -
 drivers/scsi/pluto.c            |    6 
 drivers/scsi/scsi.c             |   13 -
 drivers/scsi/scsi_lib.c         |   37 +-
 drivers/scsi/sd.c               |    5 
 drivers/scsi/sun3_NCR5380.c     |    2 
 drivers/scsi/sun3_scsi.c        |    2 
 drivers/scsi/sun3_scsi_vme.c    |    2 
 drivers/usb/storage/Kconfig     |    5 
 fs/Kconfig                      |   31 +
 fs/Makefile                     |   14 -
 fs/afs/file.c                   |    2 
 fs/binfmt_elf.c                 |    1 
 fs/bio.c                        |    4 
 fs/block_dev.c                  |   23 +
 fs/buffer.c                     |  174 --------
 fs/char_dev.c                   |    1 
 fs/cifs/file.c                  |    1 
 fs/cifs/inode.c                 |    1 
 fs/cifs/ioctl.c                 |    7 
 fs/compat.c                     |    8 
 fs/compat_ioctl.c               |  208 +--------
 fs/dcache.c                     |    4 
 fs/ext2/dir.c                   |    3 
 fs/ext2/ext2.h                  |    1 
 fs/ext2/file.c                  |    6 
 fs/ext2/ioctl.c                 |   32 +
 fs/ext3/dir.c                   |    3 
 fs/ext3/file.c                  |    3 
 fs/ext3/inode.c                 |   16 -
 fs/ext3/ioctl.c                 |   55 ++
 fs/ext3/namei.c                 |    3 
 fs/fat/dir.c                    |   56 +++
 fs/fs-writeback.c               |    9 
 fs/hfsplus/hfsplus_fs.h         |    8 
 fs/hfsplus/ioctl.c              |   17 -
 fs/inode.c                      |   21 -
 fs/internal.h                   |   55 ++
 fs/ioprio.c                     |   19 +
 fs/jfs/ioctl.c                  |   15 -
 fs/mpage.c                      |    2 
 fs/namespace.c                  |   12 -
 fs/nfs/direct.c                 |   50 ++
 fs/nfs/read.c                   |   24 -
 fs/nfs/write.c                  |   38 +-
 fs/no-block.c                   |   22 +
 fs/partitions/Makefile          |    2 
 fs/proc/proc_misc.c             |   11 
 fs/quota.c                      |   44 +-
 fs/reiserfs/dir.c               |    3 
 fs/reiserfs/file.c              |    4 
 fs/reiserfs/ioctl.c             |   35 ++
 fs/splice.c                     |    2 
 fs/super.c                      |   36 ++
 fs/sync.c                       |  113 +++++
 fs/xfs/Kconfig                  |    1 
 include/asm-i386/Kbuild         |    2 
 include/asm-ia64/mman.h         |    8 
 include/asm-sh/page.h           |    2 
 include/asm-sparc/mman.h        |    8 
 include/asm-sparc64/mman.h      |    8 
 include/linux/atmdev.h          |    2 
 include/linux/bio.h             |    2 
 include/linux/blkdev.h          |  333 ++++++++-------
 include/linux/blktrace_api.h    |    3 
 include/linux/buffer_head.h     |   19 +
 include/linux/compat.h          |    1 
 include/linux/compat_ioctl.h    |    8 
 include/linux/elevator.h        |   68 +++
 include/linux/ext2_fs.h         |   66 ++-
 include/linux/ext3_fs.h         |   26 +
 include/linux/fs.h              |   67 +++
 include/linux/genhd.h           |    4 
 include/linux/hrtimer.h         |    1 
 include/linux/ktime.h           |    7 
 include/linux/mm.h              |    4 
 include/linux/mpage.h           |    7 
 include/linux/nfs_fs.h          |    6 
 include/linux/nfs_xdr.h         |    4 
 include/linux/pci_ids.h         |    2 
 include/linux/raid/md.h         |    3 
 include/linux/raid/md_k.h       |    3 
 include/linux/ramfs.h           |    1 
 include/linux/rbtree.h          |    2 
 include/linux/reiserfs_fs.h     |   37 +-
 include/linux/sched.h           |    1 
 include/linux/sysfs.h           |    9 
 include/linux/tty.h             |    3 
 include/linux/writeback.h       |    2 
 include/scsi/scsi_tcq.h         |    5 
 init/Kconfig                    |    2 
 init/do_mounts.c                |   13 +
 kernel/exit.c                   |    1 
 kernel/futex.c                  |   84 +++-
 kernel/panic.c                  |    2 
 kernel/power/Kconfig            |    6 
 kernel/spinlock.c               |    2 
 kernel/sys_ni.c                 |    5 
 lib/rbtree.c                    |    6 
 mm/Makefile                     |    4 
 mm/bounce.c                     |  302 ++++++++++++++
 mm/filemap.c                    |   34 ++
 mm/highmem.c                    |  281 -------------
 mm/migrate.c                    |    4 
 mm/mmap.c                       |   17 -
 mm/page-writeback.c             |  143 ++++++
 mm/truncate.c                   |   37 +-
 security/seclvl.c               |    4 
 174 files changed, 3127 insertions(+), 3080 deletions(-)
 create mode 100644 fs/internal.h
 create mode 100644 fs/no-block.c
 create mode 100644 mm/bounce.c

-- 
Jens Axboe

