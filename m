Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261486AbSIZUWH>; Thu, 26 Sep 2002 16:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261488AbSIZUWH>; Thu, 26 Sep 2002 16:22:07 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:17419 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261486AbSIZUWD>;
	Thu, 26 Sep 2002 16:22:03 -0400
Date: Thu, 26 Sep 2002 13:25:52 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [RFC] LSM changes for 2.5.38
Message-ID: <20020926202552.GA6908@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are some patches against the latest 2.5 BK tree that add some
further LSM hooks and documentation to the tree.  There is also one
minor change to fs/inode.c to allow security modules more information
about newly created inodes.

These changesets can be found at bk://lsm.bkbits.net/linus-2.5 and I'll
be attaching the individual patches as responses to this email for those
who don't want to mess with bitkeeper.

If anyone has any questions or comments on these patches, please let us
know.  Otherwise I'll be sending them off to Linus in a few days.

thanks,

greg k-h


 Documentation/DocBook/Makefile        |    2 
 Documentation/DocBook/kernel-api.tmpl |    5 
 Documentation/DocBook/lsm.tmpl        |  285 +++++++++++++++++++++++++++++++++
 arch/i386/kernel/ioport.c             |   14 +
 arch/ia64/ia32/sys_ia32.c             |    7 
 fs/inode.c                            |    2 
 include/linux/ipc.h                   |    1 
 include/linux/msg.h                   |    1 
 include/linux/security.h              |  291 ++++++++++++++++++++++++++++++++++
 ipc/msg.c                             |   57 ++++++
 ipc/sem.c                             |   43 ++++-
 ipc/shm.c                             |   55 ++++++
 ipc/util.c                            |    3 
 kernel/printk.c                       |    4 
 kernel/sys.c                          |   35 ++--
 kernel/sysctl.c                       |    5 
 kernel/time.c                         |    6 
 mm/oom_kill.c                         |    6 
 mm/swapfile.c                         |   10 +
 security/capability.c                 |  210 ++++++++++++++++++++++++
 security/dummy.c                      |  210 ++++++++++++++++++++++++
 21 files changed, 1227 insertions(+), 25 deletions(-)
-----

ChangeSet@1.615, 2002-09-26 13:13:36-07:00, greg@kroah.com
  LSM: added the LSM documentation to the tree.

 Documentation/DocBook/Makefile        |    2 
 Documentation/DocBook/kernel-api.tmpl |    5 
 Documentation/DocBook/lsm.tmpl        |  285 ++++++++++++++++++++++++++++++++++
 3 files changed, 291 insertions(+), 1 deletion(-)
------

ChangeSet@1.614, 2002-09-26 13:05:47-07:00, sds@tislabs.com
  [PATCH] LSM: inode.c init modification
  
  On Thu, 19 Sep 2002, Greg KH wrote:
  
  > Yes, and explaining the fine points of inode_init() and
  > inode_alloc_security() and why they are different, might be a bit tough.
  >
  > {sigh}, well if there's no other way (and I can't think of one right
  > now), but I really don't like it...
  
  Here's a patch that attempt to support the same functionality without
  inserting hooks into filesystem-specific code.  This patch permits the
  security module to perform initialization of the inode security state
  based on the superblock information, enabling SELinux to initialize
  pipe, devpts, and shm inodes without relying on inode_precondition to
  catch them on first use.
  
  This is achieved simply by moving the initialization of inode->i_sb
  before the call to inode_alloc_security, enabling the
  inode_alloc_security hook function to perform the allocation and
  initialization for such inodes.  No new hooks are required.

 fs/inode.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
------

ChangeSet@1.613, 2002-09-26 11:56:46-07:00, sds@tislabs.com
  [PATCH] LSM: misc hooks addition
  
  The patch below (relative to the LSM IPC hooks patch) adds the LSM hooks
  for miscellaneous system operations (module_*, sethostname, setdomainname,
  reboot, ioperm/iopl, sysctl, swapon/swapoff, syslog, settime).  It also
  replaces the hardcoded capability tests in the OOM killer code with
  appropriate calls to the LSM capable hook, preserving the original behavior
  as long as the capabilities module is enabled.

 arch/i386/kernel/ioport.c |   14 +++++-
 arch/ia64/ia32/sys_ia32.c |    7 +++
 include/linux/security.h  |  106 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/printk.c           |    4 +
 kernel/sys.c              |   35 ++++++++++-----
 kernel/sysctl.c           |    5 ++
 kernel/time.c             |    6 ++
 mm/oom_kill.c             |    6 +-
 mm/swapfile.c             |   10 ++++
 security/capability.c     |   79 ++++++++++++++++++++++++++++++++++
 security/dummy.c          |   79 ++++++++++++++++++++++++++++++++++
 11 files changed, 337 insertions(+), 14 deletions(-)
------

ChangeSet@1.612, 2002-09-26 11:56:14-07:00, sds@tislabs.com
  [PATCH] LSM: SysV IPC hooks addition
  
  The patch below adds the LSM hooks for System V IPC to the 2.5.38 kernel.

 include/linux/ipc.h      |    1 
 include/linux/msg.h      |    1 
 include/linux/security.h |  185 +++++++++++++++++++++++++++++++++++++++++++++++
 ipc/msg.c                |   57 +++++++++++++-
 ipc/sem.c                |   43 ++++++++++
 ipc/shm.c                |   55 +++++++++++++
 ipc/util.c               |    3 
 security/capability.c    |  131 +++++++++++++++++++++++++++++++++
 security/dummy.c         |  131 +++++++++++++++++++++++++++++++++
 9 files changed, 598 insertions(+), 9 deletions(-)
------

