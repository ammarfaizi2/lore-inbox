Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbTI1CBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 22:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTI1CBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 22:01:09 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:19084
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262314AbTI1CBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 22:01:00 -0400
Message-ID: <3F7640C6.9080203@redhat.com>
Date: Sat, 27 Sep 2003 19:00:38 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20030924 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: virtualize access to uid, euid, ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It has been discussed here before, that the user and group IDs as well
as the auxiliary groups are a process property in POSIX and therefore a
process group property in Linux.  There has been some disagreement on
how to implement this.  As a first step I therefore created a patch
which virtualizes access to the IDs and group informatin in the task
struct.  Andrew described the function names and from then on everything
was straight forward.  The changes are numerous (98k patch) and all over
the place.  But I think I caught most of the changes.  Failures to do
this will show up right away since the task structure element has been
renamed.

The patch is at

  http://people.redhat.com/drepper/d-task-xid

since it's too large to post.  This is the list of modified files:

 drivers/block/loop.c          |    4 -
 drivers/char/agp/frontend.c   |    2
 drivers/net/tun.c             |    2
 drivers/usb/core/inode.c      |    4 -
 fs/affs/inode.c               |    4 -
 fs/affs/super.c               |    4 -
 fs/attr.c                     |    7 +
 fs/autofs/inode.c             |    4 -
 fs/autofs4/inode.c            |    4 -
 fs/bfs/dir.c                  |    4 -
 fs/binfmt_elf.c               |   12 +--
 fs/cifs/cifsproto.h           |    2
 fs/cifs/connect.c             |    4 -
 fs/cifs/dir.c                 |    2
 fs/cifs/misc.c                |    4 -
 fs/coda/cache.c               |    6 -
 fs/coda/upcall.c              |    2
 fs/devpts/inode.c             |    4 -
 fs/dquot.c                    |    2
 fs/eventpoll.c                |    4 -
 fs/exec.c                     |   29 ++++---
 fs/ext2/acl.c                 |    4 -
 fs/ext2/balloc.c              |    2
 fs/ext2/ialloc.c              |    4 -
 fs/ext2/ioctl.c               |    4 -
 fs/ext3/acl.c                 |    4 -
 fs/ext3/balloc.c              |    2
 fs/ext3/ialloc.c              |    4 -
 fs/ext3/ioctl.c               |    4 -
 fs/fat/inode.c                |    4 -
 fs/fcntl.c                    |    6 -
 fs/file_table.c               |    8 +-
 fs/hfs/super.c                |    4 -
 fs/hpfs/namei.c               |   24 +++---
 fs/hpfs/super.c               |    4 -
 fs/hugetlbfs/inode.c          |   18 ++--
 fs/intermezzo/dir.c           |    6 -
 fs/intermezzo/file.c          |   10 +-
 fs/intermezzo/intermezzo_fs.h |   26 +++---
 fs/intermezzo/journal.c       |   48 ++++++------
 fs/intermezzo/upcall.c        |    2
 fs/intermezzo/vfs.c           |    4 -
 fs/jfs/acl.c                  |    2
 fs/jfs/jfs_inode.c            |    4 -
 fs/jfs/xattr.c                |    2
 fs/locks.c                    |    2
 fs/minix/bitmap.c             |    4 -
 fs/namei.c                    |    8 +-
 fs/ncpfs/ioctl.c              |   30 +++----
 fs/nfsd/auth.c                |   12 +--
 fs/nfsd/vfs.c                 |    2
 fs/open.c                     |   19 ++--
 fs/pipe.c                     |    4 -
 fs/posix_acl.c                |    4 -
 fs/proc/array.c               |    8 +-
 fs/proc/base.c                |   16 ++--
 fs/proc/inode.c               |    4 -
 fs/quota.c                    |    2
 fs/ramfs/inode.c              |    4 -
 fs/reiserfs/ioctl.c           |    4 -
 fs/reiserfs/namei.c           |    4 -
 fs/smbfs/dir.c                |    4 -
 fs/smbfs/inode.c              |    2
 fs/smbfs/proc.c               |    2
 fs/sysfs/inode.c              |    4 -
 fs/sysv/ialloc.c              |    4 -
 fs/udf/ialloc.c               |    4 -
 fs/udf/namei.c                |    2
 fs/ufs/ialloc.c               |    4 -
 fs/xfs/linux/xfs_iops.c       |    2
 fs/xfs/xfs_acl.c              |    6 -
 fs/xfs/xfs_dfrag.c            |    4 -
 fs/xfs/xfs_inode.c            |    6 -
 fs/xfs/xfs_vnodeops.c         |   11 +-
 include/linux/sched.h         |  103 ++++++++++++++++++++++++-
 include/net/scm.h             |    4 -
 ipc/msg.c                     |    4 -
 ipc/sem.c                     |    4 -
 ipc/shm.c                     |    8 +-
 ipc/util.c                    |    6 -
 kernel/ptrace.c               |   12 +--
 kernel/sched.c                |    8 +-
 kernel/signal.c               |   20 ++---
 kernel/sys.c                  |  168 ++++++++++++++++++----------------
 kernel/sysctl.c               |    2
 kernel/timer.c                |    8 +-
 kernel/uid16.c                |   28 +++----
 mm/oom_kill.c                 |    2
 mm/shmem.c                    |    8 +-
 net/core/scm.c                |   10 +-
 net/ipv6/ip6_flowlabel.c      |    2
 net/socket.c                  |    4 -
 net/sunrpc/auth.c             |   16 ++--
 net/sunrpc/auth_unix.c        |    8 +-
 net/sunrpc/sched.c            |    3
 net/unix/af_unix.c            |   12 +--
 security/commoncap.c          |   17 ++--
 security/dummy.c              |   19 ++--
 98 files changed, 547 insertions(+), 421 deletions(-)


-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

