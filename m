Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262464AbSJ2XHs>; Tue, 29 Oct 2002 18:07:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSJ2XHs>; Tue, 29 Oct 2002 18:07:48 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:4366 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262464AbSJ2XHk>;
	Tue, 29 Oct 2002 18:07:40 -0500
Date: Tue, 29 Oct 2002 15:11:27 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.44
Message-ID: <20021029231126.GA29560@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a resend of my previous series of LSM patches for 2.5.43 that
change the way the LSM hooks operate (now they can be compiled away into
nothing).  I've also added the sys_security removal patch from Christoph
Hellwig as everyone agrees that the idea of sys_security is good, but
the current implementation sucks.

	bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h

 Documentation/DocBook/lsm.tmpl    |   23 
 arch/alpha/kernel/systbls.S       |    2 
 arch/arm/kernel/calls.S           |    2 
 arch/arm/kernel/ptrace.c          |    3 
 arch/i386/kernel/entry.S          |    2 
 arch/i386/kernel/ptrace.c         |    3 
 arch/ia64/kernel/entry.S          |    2 
 arch/ia64/kernel/ptrace.c         |    3 
 arch/ppc/kernel/misc.S            |    2 
 arch/ppc/kernel/ptrace.c          |    3 
 arch/ppc64/kernel/misc.S          |    4 
 arch/ppc64/kernel/ptrace.c        |    3 
 arch/ppc64/kernel/ptrace32.c      |    3 
 arch/ppc64/kernel/sys_ppc32.c     |   16 
 arch/s390/kernel/entry.S          |    2 
 arch/s390/kernel/ptrace.c         |    3 
 arch/s390x/kernel/entry.S         |    2 
 arch/s390x/kernel/ptrace.c        |    4 
 arch/sparc/kernel/ptrace.c        |    3 
 arch/sparc/kernel/systbls.S       |    2 
 arch/sparc64/kernel/ptrace.c      |    3 
 arch/sparc64/kernel/sys_sparc32.c |   14 
 arch/sparc64/kernel/systbls.S     |    4 
 arch/um/kernel/ptrace.c           |    3 
 arch/um/kernel/sys_call_table.c   |    2 
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
 fs/open.c                         |    6 
 fs/proc/base.c                    |    3 
 fs/quota.c                        |    2 
 fs/read_write.c                   |   12 
 fs/readdir.c                      |    4 
 fs/stat.c                         |    6 
 fs/super.c                        |   12 
 fs/xattr.c                        |   14 
 include/asm-alpha/unistd.h        |    2 
 include/asm-arm/unistd.h          |    2 
 include/asm-cris/unistd.h         |    2 
 include/asm-i386/unistd.h         |    2 
 include/asm-ia64/unistd.h         |    2 
 include/asm-ppc/unistd.h          |    2 
 include/asm-ppc64/unistd.h        |    2 
 include/asm-s390/unistd.h         |    4 
 include/asm-s390x/unistd.h        |    4 
 include/asm-sparc/unistd.h        |    2 
 include/asm-sparc64/unistd.h      |    2 
 include/asm-x86_64/unistd.h       |    3 
 include/linux/sched.h             |   16 
 include/linux/security.h          | 1049 +++++++++++++++++++++++++++++++++++++-
 init/do_mounts.c                  |    3 
 ipc/msg.c                         |    7 
 ipc/sem.c                         |    7 
 ipc/shm.c                         |    7 
 ipc/util.c                        |    2 
 kernel/acct.c                     |    4 
 kernel/capability.c               |   11 
 kernel/exit.c                     |    6 
 kernel/fork.c                     |   14 
 kernel/kmod.c                     |    3 
 kernel/ptrace.c                   |    4 
 kernel/sched.c                    |   15 
 kernel/signal.c                   |    4 
 kernel/sys.c                      |   50 -
 kernel/uid16.c                    |    3 
 mm/mmap.c                         |    6 
 mm/mprotect.c                     |    3 
 net/core/scm.c                    |    3 
 net/decnet/af_decnet.c            |    4 
 security/Config.help              |    7 
 security/Config.in                |    2 
 security/Makefile                 |   10 
 security/capability.c             |  335 ++++++------
 security/dummy.c                  |    7 
 security/security.c               |   18 
 85 files changed, 1428 insertions(+), 525 deletions(-)
-----

ChangeSet@1.853, 2002-10-29 15:02:47-08:00, greg@kroah.com
  LSM: remove last remanants of sys_security missed by last patch.

 kernel/sys.c          |    1 -
 security/capability.c |    7 -------
 2 files changed, 8 deletions(-)
------

ChangeSet@1.852, 2002-10-29 14:04:23-08:00, hch@infradead.org
  [PATCH] remove sys_security
  
  I've been auditing the LSM stuff a bit more..
  
  They have registered an implemented a syscall, sys_security
  that does nothing but switch into the individual modules
  based on the first argument, i.e. it's ioctl() switching
  on the security module instead of device node.  Yuck.
  
  Patch below removes it (no intree users), maybe selinux/etc
  folks should send their actual syscall for review instead..

 Documentation/DocBook/lsm.tmpl  |   23 -----------------------
 arch/alpha/kernel/systbls.S     |    2 +-
 arch/arm/kernel/calls.S         |    2 +-
 arch/i386/kernel/entry.S        |    2 +-
 arch/ia64/kernel/entry.S        |    2 +-
 arch/ppc/kernel/misc.S          |    2 +-
 arch/ppc64/kernel/misc.S        |    4 ++--
 arch/s390/kernel/entry.S        |    2 +-
 arch/s390x/kernel/entry.S       |    2 +-
 arch/sparc/kernel/systbls.S     |    2 +-
 arch/sparc64/kernel/systbls.S   |    4 ++--
 arch/um/kernel/sys_call_table.c |    2 --
 include/asm-alpha/unistd.h      |    2 +-
 include/asm-arm/unistd.h        |    2 +-
 include/asm-cris/unistd.h       |    2 +-
 include/asm-i386/unistd.h       |    2 +-
 include/asm-ia64/unistd.h       |    2 +-
 include/asm-ppc/unistd.h        |    2 +-
 include/asm-ppc64/unistd.h      |    2 +-
 include/asm-s390/unistd.h       |    4 +++-
 include/asm-s390x/unistd.h      |    4 +++-
 include/asm-sparc/unistd.h      |    2 +-
 include/asm-sparc64/unistd.h    |    2 +-
 include/asm-x86_64/unistd.h     |    3 +--
 include/linux/security.h        |   17 -----------------
 security/dummy.c                |    7 -------
 security/security.c             |   18 ------------------
 27 files changed, 28 insertions(+), 92 deletions(-)
------

ChangeSet@1.851, 2002-10-29 13:30:34-08:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/lsm-2.5

 fs/open.c     |    3 +--
 fs/super.c    |    6 +++---
 kernel/fork.c |    7 +++----
 mm/mmap.c     |    3 +--
 4 files changed, 8 insertions(+), 11 deletions(-)
------

ChangeSet@1.808.16.1, 2002-10-25 14:52:30-07:00, greg@kroah.com
  Merge kroah.com:/home/greg/linux/BK/bleeding_edge-2.5
  into kroah.com:/home/greg/linux/BK/lsm-2.5

 arch/ppc64/kernel/sys_ppc32.c     |    8 ++++----
 arch/sparc64/kernel/sys_sparc32.c |    7 +++----
 include/linux/sched.h             |    8 ++++----
 net/decnet/af_decnet.c            |    2 +-
 4 files changed, 12 insertions(+), 13 deletions(-)
------

ChangeSet@1.791.12.6, 2002-10-17 14:08:43-07:00, greg@kroah.com
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

ChangeSet@1.791.12.5, 2002-10-17 14:06:57-07:00, greg@kroah.com
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

ChangeSet@1.791.12.4, 2002-10-17 14:05:48-07:00, greg@kroah.com
  LSM: change all security bprm related calls to the new format.

 arch/ppc64/kernel/sys_ppc32.c     |    7 +++----
 arch/sparc64/kernel/sys_sparc32.c |    7 +++----
 fs/exec.c                         |   15 ++++++---------
 3 files changed, 12 insertions(+), 17 deletions(-)
------

ChangeSet@1.791.12.3, 2002-10-17 14:04:04-07:00, greg@kroah.com
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

ChangeSet@1.791.12.2, 2002-10-17 13:47:59-07:00, greg@kroah.com
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

ChangeSet@1.791.12.1, 2002-10-17 13:16:54-07:00, greg@kroah.com
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

