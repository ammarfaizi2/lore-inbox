Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSJQVUo>; Thu, 17 Oct 2002 17:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262106AbSJQVUn>; Thu, 17 Oct 2002 17:20:43 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47630 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262100AbSJQVUl>;
	Thu, 17 Oct 2002 17:20:41 -0400
Date: Thu, 17 Oct 2002 14:26:21 -0700
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.43
Message-ID: <20021017212620.GA1125@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are a set of patches that change the way the current LSM hooks
operate.  This patch creates CONFIG_SECURITY and disables it by default
for now.  When CONFIG_SECURITY is disabled, all security hooks are
disabled, and compile away to nothing, with the exception of the default
capability functions, which are compiled into the kernel.

If CONFIG_SECURITY is set to y, the old way of having the security hooks
happens (a big table of function pointers.)  I'll introduce a Config.in
change to allow this to happen when the first security module is
submitted for inclusion in the kernel tree (there are a number that
should be submitted soon.)

This should appease the people who don't want the additional overhead of
having the ability to load different types of security modules.

In creating these patches, I tried to use a #define approach, as some
people pointed out.  The main detraction from doing this was the need to
allow the capability functions to be enabled if CONFIG_SECURITY=n.
Chris Wright proposed a way around this, but that forced all of the
"dummy" capability hooks to be enabled, and built into the kernel, which
the "size overhead" people would not appreciate.

If anyone comes up with a clean way to use a #define for these hooks,
and implement the existing functionality as shown in these patches, I'll
be glad to change them at a later time.

Linus, please pull from:
	bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h
 arch/arm/kernel/ptrace.c          |    3 
 arch/i386/kernel/ptrace.c         |    3 
 arch/ia64/kernel/ptrace.c         |    3 
 arch/ppc/kernel/ptrace.c          |    3 
 arch/ppc64/kernel/ptrace.c        |    3 
 arch/ppc64/kernel/ptrace32.c      |    3 
 arch/ppc64/kernel/sys_ppc32.c     |    8 
 arch/s390/kernel/ptrace.c         |    3 
 arch/s390x/kernel/ptrace.c        |    4 
 arch/sparc/kernel/ptrace.c        |    3 
 arch/sparc64/kernel/ptrace.c      |    3 
 arch/sparc64/kernel/sys_sparc32.c |    7 
 arch/um/kernel/ptrace.c           |    3 
 arch/x86_64/kernel/ptrace.c       |    3 
 drivers/base/fs/class.c           |    2 
 drivers/base/fs/intf.c            |    2 
 fs/attr.c                         |    5 
 fs/dquot.c                        |    4 
 fs/exec.c                         |   16 
 fs/fcntl.c                        |   11 
 fs/file_table.c                   |    6 
 fs/inode.c                        |    6 
 fs/ioctl.c                        |    3 
 fs/locks.c                        |   13 
 fs/namei.c                        |   58 --
 fs/namespace.c                    |   23 
 fs/open.c                         |    3 
 fs/proc/base.c                    |    3 
 fs/quota.c                        |    2 
 fs/read_write.c                   |   12 
 fs/readdir.c                      |    4 
 fs/stat.c                         |    6 
 fs/super.c                        |    6 
 fs/xattr.c                        |   14 
 include/linux/sched.h             |    8 
 include/linux/security.h          | 1032 +++++++++++++++++++++++++++++++++++++-
 init/do_mounts.c                  |    3 
 ipc/msg.c                         |    7 
 ipc/sem.c                         |    7 
 ipc/shm.c                         |    7 
 ipc/util.c                        |    2 
 kernel/acct.c                     |    4 
 kernel/capability.c               |   11 
 kernel/exit.c                     |    6 
 kernel/fork.c                     |    7 
 kernel/kmod.c                     |    3 
 kernel/ptrace.c                   |    4 
 kernel/sched.c                    |   15 
 kernel/signal.c                   |    4 
 kernel/sys.c                      |   49 -
 kernel/uid16.c                    |    3 
 mm/mmap.c                         |    3 
 mm/mprotect.c                     |    3 
 net/core/scm.c                    |    3 
 net/decnet/af_decnet.c            |    2 
 security/Config.help              |    7 
 security/Config.in                |    2 
 security/Makefile                 |   10 
 security/capability.c             |  328 ++++++------
 59 files changed, 1380 insertions(+), 401 deletions(-)
-----

ChangeSet@1.803, 2002-10-17 14:08:43-07:00, greg@kroah.com
  LSM: convert over the remaining security calls to the new format.

 ipc/msg.c              |    7 +++----
 ipc/sem.c              |    7 +++----
 ipc/shm.c              |    7 +++----
 ipc/util.c             |    2 +-
 kernel/acct.c          |    3 +--
 kernel/capability.c    |   10 +++++-----
 kernel/exit.c          |    6 +++---
 kernel/fork.c          |    7 +++----
 kernel/kmod.c          |    2 +-
 kernel/sched.c         |   15 +++++----------
 kernel/signal.c        |    3 +--
 kernel/sys.c           |   49 ++++++++++++++++++-------------------------------
 kernel/uid16.c         |    3 +--
 net/decnet/af_decnet.c |    2 +-
 14 files changed, 49 insertions(+), 74 deletions(-)
------

ChangeSet@1.802, 2002-10-17 14:06:57-07:00, greg@kroah.com
  LSM: change all of the VFS related security calls to the new format.

 fs/attr.c        |    5 +---
 fs/dquot.c       |    3 --
 fs/fcntl.c       |   11 +++-------
 fs/file_table.c  |    6 ++---
 fs/inode.c       |    6 ++---
 fs/ioctl.c       |    3 --
 fs/locks.c       |   12 +++--------
 fs/namei.c       |   58 +++++++++++++++++++++----------------------------------
 fs/namespace.c   |   22 ++++++++------------
 fs/open.c        |    3 --
 fs/proc/base.c   |    2 -
 fs/quota.c       |    2 -
 fs/read_write.c  |   12 +++--------
 fs/readdir.c     |    3 --
 fs/stat.c        |    6 +----
 fs/super.c       |    4 +--
 fs/xattr.c       |   13 +++---------
 init/do_mounts.c |    2 -
 mm/mmap.c        |    3 --
 mm/mprotect.c    |    3 --
 net/core/scm.c   |    3 --
 21 files changed, 70 insertions(+), 112 deletions(-)
------

ChangeSet@1.801, 2002-10-17 14:05:48-07:00, greg@kroah.com
  LSM: change all security bprm related calls to the new format.

 arch/ppc64/kernel/sys_ppc32.c     |    7 +++----
 arch/sparc64/kernel/sys_sparc32.c |    7 +++----
 fs/exec.c                         |   15 ++++++---------
 3 files changed, 12 insertions(+), 17 deletions(-)
------

ChangeSet@1.800, 2002-10-17 14:04:04-07:00, greg@kroah.com
  LSM: change all usages of security_ops->ptrace() to security_ptrace()

 arch/arm/kernel/ptrace.c     |    3 +--
 arch/i386/kernel/ptrace.c    |    3 +--
 arch/ia64/kernel/ptrace.c    |    3 +--
 arch/ppc/kernel/ptrace.c     |    3 +--
 arch/ppc64/kernel/ptrace.c   |    3 +--
 arch/ppc64/kernel/ptrace32.c |    3 +--
 arch/s390/kernel/ptrace.c    |    3 +--
 arch/s390x/kernel/ptrace.c   |    3 +--
 arch/sparc/kernel/ptrace.c   |    3 +--
 arch/sparc64/kernel/ptrace.c |    3 +--
 arch/um/kernel/ptrace.c      |    3 +--
 arch/x86_64/kernel/ptrace.c  |    3 +--
 kernel/ptrace.c              |    3 +--
 13 files changed, 13 insertions(+), 26 deletions(-)
------

ChangeSet@1.799, 2002-10-17 13:47:59-07:00, greg@kroah.com
  LSM:  Create CONFIG_SECURITY and disable it by default for now.
  
  This allows the security hooks to be compiled away into nothingness if CONFIG_SECURITY
  is disabled.  When disabled, the default capabilities functionality is preserved.
  When enabled, security modules are allowed to be loaded.

 include/linux/sched.h    |    8 
 include/linux/security.h | 1032 ++++++++++++++++++++++++++++++++++++++++++++++-
 security/Config.help     |    7 
 security/Config.in       |    2 
 security/Makefile        |   10 
 security/capability.c    |  328 +++++++-------
 6 files changed, 1216 insertions(+), 171 deletions(-)
------

ChangeSet@1.798, 2002-10-17 13:16:54-07:00, greg@kroah.com
  LSM: add #include <linux/security.h> to a lot of files as they all have security calls in them.
  
  This is needed for the next patches that change the way the security calls work.

 arch/ppc64/kernel/sys_ppc32.c |    1 +
 arch/s390x/kernel/ptrace.c    |    1 +
 drivers/base/fs/class.c       |    2 ++
 drivers/base/fs/intf.c        |    2 ++
 fs/dquot.c                    |    1 +
 fs/exec.c                     |    1 +
 fs/locks.c                    |    1 +
 fs/namespace.c                |    1 +
 fs/proc/base.c                |    1 +
 fs/readdir.c                  |    1 +
 fs/super.c                    |    2 +-
 fs/xattr.c                    |    1 +
 init/do_mounts.c              |    1 +
 kernel/acct.c                 |    1 +
 kernel/capability.c           |    1 +
 kernel/kmod.c                 |    1 +
 kernel/ptrace.c               |    1 +
 kernel/signal.c               |    1 +
 18 files changed, 20 insertions(+), 1 deletion(-)
------

