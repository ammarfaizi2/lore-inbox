Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWIMVfM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWIMVfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 17:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWIMVfM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 17:35:12 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:15720 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751126AbWIMVfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 17:35:10 -0400
Date: Wed, 13 Sep 2006 14:35:07 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: ocfs2-devel@oss.oracle.com
Subject: What's in ocfs2.git
Message-ID: <20060913213507.GK8792@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following describes the contents of the ALL branch of

git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git

* The usual set of cleanups and fixes.
   - a #include cleanup
   - some nlink check fixes
   - a heartbeat sector math fix

* OCFS2 now supports ext2 file attributes. Thanks to Herbert Poetzl for that
  feature.

* Shared writeable mmap support. This just make use of the ->page_mkwrite()
  callback to take write locks on pages. It works quite well, though there's
  one unresolved issue I'd like to work out first.

* Fix mtime updates on buffered writes so that they always happen.

* An old directory readahead patch which I had never pushed upstream. IMHO,
  it's actually more interesting in that it provides the code to do readahead
  of other fs structures in the future.

* A patch series which removes the "dentry" vote, in favor of a locking
  scheme which achieves the same thing (cluster-wide dentry delete on
  unlink/rename) using fewer network messages in the average case. This
  series also includes two interesting changes:
   - An OCFS2 DLM API update, needed to get this going.
   - A small patch to the VFS to enable a file system to manually d_move()
     during rename. This also updates NFS for the behavior.

* A configfs fix - it was previously possible to create duplicate subsystem
  names.


Most of this will be queued up for 2.6.19. Diffstat and shortlog are below.  

Broken out patches can be found at:

http://www.kernel.org/pub/linux/kernel/people/mfasheh/ocfs2/ocfs2_git_patches/ocfs2-all-20060913/
	--Mark

 fs/configfs/dir.c               |   32 ++
 fs/namei.c                      |    6 
 fs/nfs/dir.c                    |    3 
 fs/nfs/super.c                  |   10 
 fs/ocfs2/Makefile               |    1 
 fs/ocfs2/alloc.c                |   28 +-
 fs/ocfs2/aops.c                 |   83 ++----
 fs/ocfs2/buffer_head_io.c       |   95 +++++--
 fs/ocfs2/buffer_head_io.h       |    2 
 fs/ocfs2/cluster/heartbeat.c    |    8 
 fs/ocfs2/cluster/tcp_internal.h |    5 
 fs/ocfs2/dcache.c               |  380 +++++++++++++++++++++++++++++-
 fs/ocfs2/dcache.h               |   27 ++
 fs/ocfs2/dir.c                  |   28 +-
 fs/ocfs2/dlm/dlmapi.h           |    1 
 fs/ocfs2/dlm/dlmast.c           |    6 
 fs/ocfs2/dlm/dlmcommon.h        |    1 
 fs/ocfs2/dlm/dlmlock.c          |   10 
 fs/ocfs2/dlm/dlmmaster.c        |    4 
 fs/ocfs2/dlm/dlmrecovery.c      |    3 
 fs/ocfs2/dlm/userdlm.c          |   81 ++----
 fs/ocfs2/dlm/userdlm.h          |    1 
 fs/ocfs2/dlmglue.c              |  497 +++++++++++++++++++++++++++++++---------
 fs/ocfs2/dlmglue.h              |   16 +
 fs/ocfs2/export.c               |    4 
 fs/ocfs2/file.c                 |    3 
 fs/ocfs2/inode.c                |   42 ++-
 fs/ocfs2/inode.h                |    3 
 fs/ocfs2/ioctl.c                |  136 ++++++++++
 fs/ocfs2/ioctl.h                |   16 +
 fs/ocfs2/mmap.c                 |  100 ++++++--
 fs/ocfs2/namei.c                |  148 +++++++----
 fs/ocfs2/ocfs2_fs.h             |   24 +
 fs/ocfs2/ocfs2_lockid.h         |   25 ++
 fs/ocfs2/super.c                |    2 
 fs/ocfs2/sysfile.c              |    4 
 fs/ocfs2/uptodate.c             |   21 +
 fs/ocfs2/uptodate.h             |    2 
 fs/ocfs2/vote.c                 |  180 --------------
 fs/ocfs2/vote.h                 |    5 
 include/linux/fs.h              |    7 
 41 files changed, 1479 insertions(+), 571 deletions(-)

Adrian Bunk:
      fs/ocfs2/ioctl.c should #include "ioctl.h"

Herbert Poetzl:
      ocfs2: add ext2 attributes

Joel Becker:
      configfs: Prevent duplicate subsystem names.

Mark Fasheh:
      ocfs2: implement directory read-ahead
      ocfs2: Shared writeable mmap
      ocfs2: properly update i_mtime on buffered write
      ocfs2: move nlink check in ocfs2_mknod()
      ocfs2: Remove overzealous BUG_ON()
      ocfs2: Silence dlm error print
      ocfs2: Allow binary names in the DLM
      ocfs2: Update dlmfs for new dlmlock() API
      ocfs2: Update dlmglue for new dlmlock() API
      ocfs2: Add new cluster lock type
      ocfs2: Add dentry tracking API
      ocfs2: Hook rest of the file system into dentry locking API
      ocfs2: Remove the dentry vote
      Allow file systems to manually d_move() inside of ->rename()
      ocfs2: manually d_move() during ocfs2_rename()

Mathieu Avila:
      ocfs2: Fix heartbeat sector calculation

Tiger Yang:
      ocfs2: Fix directory link count checks in ocfs2_link()
