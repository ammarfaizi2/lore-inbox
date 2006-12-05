Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967866AbWLEACH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967866AbWLEACH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967868AbWLEACH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:02:07 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:25307 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967866AbWLEACE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:02:04 -0500
Date: Mon, 4 Dec 2006 16:01:50 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, ocfs2-devel@oss.oracle.com,
       linux-kernel@vger.kernel.org, joel.becker@oracle.com
Subject: [git patches] ocfs2 and configfs updates
Message-ID: <20061205000150.GE19617@ca-server1.us.oracle.com>
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

Hi Linus,

  This patch set comprises the bulk of my 2.6.20 features which need to be
pushed upstream. My description of the changes is below:


* Various ocfs2 cleanups, including a patchset by me intended to clean up
  some of the internal ocfs2 journal api. Mostly this revolves around
  removing the ocfs2_journal_handle wrapper around handle_t. The immediate
  benefits are better readability and a slightly smaller memory footprint
  for open journal transactions.


* Configfs gets some small cleanups and some mutex annotations.


* Atime updates - thanks to Tiger Yang <tiger.yang@oracle.com>, ocfs2 now
  writes to the inode atime field. This doesn't require any disk changes,
  and is completely backwards compatible with older ocfs2 versions. An
  inodes Atime is only updated if it hasn't changed within a certain
  quantum. The user can define their own value at mount time, with 0
  indicating that atime should always be updated. This is very similar to
  the scheme implemented by gfs2.


* Sys_splice - ocfs2 now has splice read and write support. Thanks again to
  Tiger for the bulk of this functionality. Mostly we make use of the
  generic_splice_read() and generic_file_splice_write_nolock() functions
  provided already in fs/splice.c.

 - There is one patch in the ocfs2 splice() series external to fs/ocfs2 - a
   simple export of should_remove_suid(). This is done for code reuse
   purposes. That particular patch can be seen at:

http://ftp.kernel.org/pub/linux/kernel/people/mfasheh/ocfs2/ocfs2_git_patches/ocfs2-upstream-linus-20061201/0025-Export-should_remove_suid.txt

   I'll also attach it to this mail for review purposes.


* Not included in this set of patches are the following updates, which I
  think need a few more days before they're ready (I'll push them early next
  week if they make the cut):

  - A lock migration fix within the ocfs2 dlm.

  - Some patches to make ocfs2 network timeout values user-adjustable.

  - A "local mount" patch which will give ocfs2 the ability to act as a
    local file system (no cluster configuration needed, no dlm locking,
    etc).


Please pull from 'upstream-linus' branch of
git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2.git upstream-linus

to receive the following updates:

 fs/configfs/dir.c        |    9 -
 fs/ocfs2/alloc.c         |   90 +++++-------
 fs/ocfs2/alloc.h         |    2 
 fs/ocfs2/aops.c          |   22 +--
 fs/ocfs2/aops.h          |    2 
 fs/ocfs2/dir.c           |   33 ++--
 fs/ocfs2/dir.h           |    2 
 fs/ocfs2/dlm/dlmdomain.c |    3 
 fs/ocfs2/dlmglue.c       |   60 ++++++--
 fs/ocfs2/dlmglue.h       |    9 -
 fs/ocfs2/export.c        |    2 
 fs/ocfs2/file.c          |  343 ++++++++++++++++++++++++++++++++---------------
 fs/ocfs2/file.h          |   11 +
 fs/ocfs2/inode.c         |   33 +---
 fs/ocfs2/inode.h         |    9 -
 fs/ocfs2/ioctl.c         |   10 -
 fs/ocfs2/journal.c       |  271 ++++---------------------------------
 fs/ocfs2/journal.h       |   78 +---------
 fs/ocfs2/localalloc.c    |  126 +++++++----------
 fs/ocfs2/localalloc.h    |    3 
 fs/ocfs2/mmap.c          |   11 +
 fs/ocfs2/namei.c         |  296 +++++++++++++++++++++-------------------
 fs/ocfs2/namei.h         |    2 
 fs/ocfs2/ocfs2.h         |    4 
 fs/ocfs2/suballoc.c      |  174 ++++++++++-------------
 fs/ocfs2/suballoc.h      |   16 --
 fs/ocfs2/super.c         |   32 ++--
 fs/ocfs2/symlink.c       |    4 
 mm/filemap.c             |    1 
 29 files changed, 760 insertions(+), 898 deletions(-)

Adrian Bunk:
      [2.6 patch] make ocfs2_create_new_lock() static
      configfs: make configfs_dirent_exists() static

Mark Fasheh:
      ocfs2: fix format warnings in dlm_alloc_pagevec()
      ocfs2: remove unused ocfs2_journal_handle field
      ocfs2: have ocfs2_extend_trans() take handle_t
      ocfs2: remove ocfs2_journal_handle flags field
      ocfs2: don't pass handle to ocfs2_meta_lock() in localalloc.c
      ocfs2: don't pass handle to ocfs2_meta_lock() in __ocfs2_flush_truncate_log()
      ocfs2: don't pass handle to ocfs2_meta_lock() in ocfs2_mknod()
      ocfs2: don't pass handle to ocfs2_meta_lock() in ocfs2_link()
      ocfs2: don't pass handle to ocfs2_meta_lock() in orphan dir code
      ocfs2: don't pass handle to ocfs2_meta_lock in ocfs2_unlink()
      ocfs2: don't pass handle to ocfs2_meta_lock in ocfs2_symlink()
      ocfs2: don't pass handle to ocfs2_meta_lock in ocfs2_rename()
      ocfs2: don't use handle for locking in allocation functions
      ocfs2: Don't allocate handle early in ocfs2_rename()
      ocfs2: remove unused ocfs2_handle_add_inode()
      ocfs2: remove unused ocfs2_handle_add_lock()
      ocfs2: make ocfs2_alloc_handle() static
      ocfs2: remove unused handle argument from ocfs2_meta_lock_full()
      ocfs2: pass ocfs2_super * into ocfs2_commit_trans()
      ocfs2: remove ocfs2_journal_handle journal field
      ocfs2: remove handle argument to ocfs2_start_trans()
      ocfs2: Remove struct ocfs2_journal_handle in favor of handle_t
      configfs: mutex_lock_nested() fix
      Export should_remove_suid()
      ocfs2: Remove ocfs2_write_should_remove_suid()

Tiger Yang:
      ocfs2: Add splice support
      ocfs2: core atime update functions
      ocfs2: update file system paths to set atime
      ocfs2: implement i_op->permission


From: Mark Fasheh <mark.fasheh@oracle.com>
Date: Tue, 17 Oct 2006 17:05:18 -0700
Subject: [PATCH] Export should_remove_suid()

This helps us avoid replicating the same logic within file system drivers.

Signed-off-by: Mark Fasheh <mark.fasheh@oracle.com>

---

 mm/filemap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

d23a147bb6e8d467e8df73b6589888717da3b9ce
diff --git a/mm/filemap.c b/mm/filemap.c
index 7b84dc8..13df01c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1893,6 +1893,7 @@ int should_remove_suid(struct dentry *de
 
 	return 0;
 }
+EXPORT_SYMBOL(should_remove_suid);
 
 int __remove_suid(struct dentry *dentry, int kill)
 {
-- 
1.3.3

