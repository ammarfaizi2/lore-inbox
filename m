Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267323AbTAPXPq>; Thu, 16 Jan 2003 18:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267328AbTAPXPq>; Thu, 16 Jan 2003 18:15:46 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:34832 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267323AbTAPXPo>;
	Thu, 16 Jan 2003 18:15:44 -0500
Date: Thu, 16 Jan 2003 15:24:05 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: [BK PATCH] LSM changes for 2.5.58
Message-ID: <20030116232405.GA1860@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These changesets contain some changes to a few security hooks.  They
have all been posted recently, and changes have been made to them based
on feedback.

Please pull from:
	bk://lsm.bkbits.net/linus-2.5

thanks,

greg k-h

 fs/dcache.c              |    3 +++
 fs/exportfs/expfs.c      |    5 ++---
 fs/file_table.c          |   35 +++++++++++++++++++++++++++--------
 fs/namei.c               |    9 +++------
 fs/nfsd/vfs.c            |    9 +++------
 fs/super.c               |    8 ++++++++
 include/linux/fs.h       |    5 ++++-
 include/linux/security.h |   36 +++++++++++++++++++++---------------
 kernel/ksyms.c           |    3 ++-
 kernel/sys.c             |   21 ++++++++++++++++-----
 security/dummy.c         |   19 +++++++++++++------
 11 files changed, 102 insertions(+), 51 deletions(-)
-----

ChangeSet@1.956, 2003-01-16 14:54:42-08:00, sds@epoch.ncsc.mil
  [PATCH] Restore LSM hook calls to setpriority and setpgid
  
  This patch restores the LSM hook calls in setpriority and setpgid to
  2.5.58.  These hooks were previously added as of 2.5.27, but the hook
  calls were subsequently lost as a result of other changes to the code
  as of 2.5.37.
  
  Ingo has signed off on this patch, and no one else has objected.

 kernel/sys.c |   21 ++++++++++++++++-----
 1 files changed, 16 insertions(+), 5 deletions(-)
------

ChangeSet@1.955, 2003-01-16 14:35:24-08:00, sds@epoch.ncsc.mil
  [PATCH] allocate and free security structures for private files
  
  This patch adds a security_file_alloc call to init_private_file and
  creates a close_private_file function to encapsulate the release of
  private file structures.  These changes ensure that security
  structures for private files will be allocated and freed
  appropriately.  Per Andi Kleen's comments, the patch also renames
  init_private_file to open_private_file to force updating of all
  callers, since they will also need to be updated to use
  close_private_file to avoid a leak of the security structure.  Per
  Christoph Hellwig's comments, the patch also replaces the 'mode'
  argument with a 'flags' argument, computing the f_mode from the flags,
  and it explicitly tests f_op prior to dereferencing, as in
  dentry_open().

 fs/exportfs/expfs.c |    5 ++---
 fs/file_table.c     |   35 +++++++++++++++++++++++++++--------
 fs/nfsd/vfs.c       |    9 +++------
 include/linux/fs.h  |    5 ++++-
 kernel/ksyms.c      |    3 ++-
 5 files changed, 38 insertions(+), 19 deletions(-)
------

ChangeSet@1.954, 2003-01-16 14:23:59-08:00, sds@epoch.ncsc.mil
  [PATCH] Replace inode_post_lookup hook with d_instantiate hook
  
  This patch removes the security_inode_post_lookup hook entirely and
  adds a security_d_instantiate hook call to the d_instantiate function
  and the d_splice_alias function.  The inode_post_lookup hook was
  subject to races since the inode is already accessible through the
  dcache before it is called, didn't handle filesystems that directly
  populate the dcache, and wasn't always called in the desired context
  (e.g. for pipe, shmem, and devpts inodes).  The d_instantiate hook
  enables initialization of the inode security information.  This hook
  is used by SELinux and by DTE to setup the inode security state, and
  eliminated the need for the inode_precondition function in SELinux.

 fs/dcache.c              |    3 +++
 fs/namei.c               |    9 +++------
 include/linux/security.h |   25 ++++++++++---------------
 security/dummy.c         |   13 +++++++------
 4 files changed, 23 insertions(+), 27 deletions(-)
------

ChangeSet@1.953, 2003-01-16 14:18:05-08:00, sds@epoch.ncsc.mil
  [PATCH] Add LSM hook to do_kern_mount
  
  This patch adds a security_sb_kern_mount hook call to the do_kern_mount
  function.  This hook enables initialization of the superblock security
  information of all superblock objects.  Placing a hook in do_kern_mount
  was originally suggested by Al Viro.  This hook is used by SELinux to
  setup the superblock security state and eliminated the need for the
  superblock_precondition function.

 fs/super.c               |    8 ++++++++
 include/linux/security.h |   11 +++++++++++
 security/dummy.c         |    6 ++++++
 3 files changed, 25 insertions(+)
------

