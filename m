Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317701AbSHaQ2T>; Sat, 31 Aug 2002 12:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317628AbSHaQ2S>; Sat, 31 Aug 2002 12:28:18 -0400
Received: from mons.uio.no ([129.240.130.14]:34229 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317616AbSHaQ2P>;
	Sat, 31 Aug 2002 12:28:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15728.61345.184030.293634@charged.uio.no>
Date: Sat, 31 Aug 2002 18:32:33 +0200
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux FSdevel <linux-fsdevel@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Initial support for struct vfs_cred   [0/1]
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

  I hope this addresses all the issues that you raised (minus
user_struct, as I explained). Changes w.r.t.  previous patches are as
follows:

  1) Dropped current_fsuid(), current_fsgid(), current_ngroups().
     => had to merge patches [1/3] & [3/3]. Makes for a rather large
     initial patch (see diffstat output below) 8-(

  2) 'struct ucred' renamed to 'struct vfs_cred'. Renamed the
     helper routines to reflect the new struct name.

  3) Moved #ifdef __KERNEL__

  4) Renamed the remaining current_* routines so as to drop the
     'current_' prefix where appropriate (e.g. setfsuid() instead of
     current_setfsuid(), ...).
     Hopefully the naming scheme will be seen as an improvement.

  5) Dropped patch [2/3]. There is no longer a namespace conflict
     to justify renaming the networking code's 'struct ucred'.

Cheers,
  Trond

 arch/s390x/kernel/linux32.c        |    9 
 arch/sparc64/kernel/sys_sparc32.c  |    9 
 drivers/hotplug/pci_hotplug_core.c |    4 
 drivers/isdn/capi/capifs.c         |    4 
 drivers/usb/core/inode.c           |    4 
 fs/affs/inode.c                    |    4 
 fs/attr.c                          |    6 
 fs/bfs/dir.c                       |    4 
 fs/coda/coda_linux.c               |    6 
 fs/devpts/inode.c                  |    4 
 fs/dquot.c                         |    2 
 fs/driverfs/inode.c                |    4 
 fs/exec.c                          |    6 
 fs/ext2/balloc.c                   |    2 
 fs/ext2/ialloc.c                   |    4 
 fs/ext2/ioctl.c                    |    4 
 fs/ext3/balloc.c                   |    2 
 fs/ext3/ialloc.c                   |    4 
 fs/ext3/ioctl.c                    |    4 
 fs/file_table.c                    |    8 
 fs/hpfs/namei.c                    |   24 -
 fs/intermezzo/file.c               |   13 -
 fs/intermezzo/journal.c            |   54 ++--
 fs/intermezzo/kml_reint.c          |   12 
 fs/intermezzo/upcall.c             |    2 
 fs/intermezzo/vfs.c                |    4 
 fs/jffs/inode-v23.c                |   28 +-
 fs/jffs2/fs.c                      |    4 
 fs/jfs/jfs_inode.c                 |    4 
 fs/lockd/host.c                    |    7 
 fs/locks.c                         |    2 
 fs/minix/bitmap.c                  |    4 
 fs/namei.c                         |    8 
 fs/nfsd/auth.c                     |   11 
 fs/nfsd/vfs.c                      |    4 
 fs/open.c                          |   17 -
 fs/pipe.c                          |    4 
 fs/proc/array.c                    |   11 
 fs/proc/base.c                     |    4 
 fs/ramfs/inode.c                   |    4 
 fs/reiserfs/namei.c                |    4 
 fs/sysv/ialloc.c                   |    4 
 fs/udf/ialloc.c                    |    4 
 fs/udf/namei.c                     |    2 
 fs/ufs/ialloc.c                    |    4 
 fs/umsdos/namei.c                  |    8 
 include/linux/cred.h               |   88 ++++++
 include/linux/init_task.h          |    1 
 include/linux/sched.h              |    8 
 init/main.c                        |    1 
 kernel/Makefile                    |    5 
 kernel/cred.c                      |  468 +++++++++++++++++++++++++++++++++++++
 kernel/fork.c                      |   17 +
 kernel/kmod.c                      |    6 
 kernel/sys.c                       |   65 ++---
 kernel/uid16.c                     |    9 
 mm/shmem.c                         |    8 
 net/socket.c                       |    4 
 net/sunrpc/auth_unix.c             |   55 ++--
 net/sunrpc/sched.c                 |    2 
 security/capability.c              |    4 
 security/dummy.c                   |    5 
 62 files changed, 835 insertions(+), 252 deletions(-)
