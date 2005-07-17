Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263078AbVGNSbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263078AbVGNSbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 14:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263076AbVGNSbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 14:31:25 -0400
Received: from ms-smtp-05.texas.rr.com ([24.93.47.44]:42197 "EHLO
	ms-smtp-05-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S263072AbVGNSbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 14:31:13 -0400
Message-Id: <200507141830.j6EIUcRh020367@ms-smtp-05-eri0.texas.rr.com>
From: ericvh@gmail.com
Date: Sun, 17 Jul 2005 08:53:40 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc2-mm2 0/7] v9fs: Changes in response to hch comments (2.0.2)
Cc: v9fs-developer@lists.sourceforge.net, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part [0/7] of the v9fs-2.0.2 patch against Linux 2.6.13-rc2-mm2.

The changes in this patch-set are primarily motivated by comments from
Chistoph Hellwig (hch):

"there's a few issues with the code still I'd like to see fixed: 
 - there's three sparse warnings still.  Two of them are easily fixed
   by moving externs to headers, one doesn't look fixable until we get
   a sane in-kernel api for socket operations
 - some dentry handling looks rather odd.  Why are you for example
   calling d_drop in v9fs_vfs_symlink, v9fs_vfs_mknod and v9fs_vfs_link?
   Shouldn't all these call d_instantatiate to actually reuse the
   dentry as in v9fs_vfs_create?  Also what's the issue with
   v9fs_fid_insert?  It would seem better and more logical to me to
   always set d_fsdata in create/mknod/symlink/open before hashing it
   and then beeing able to rely on it beeing non-NULL.
 - buf_check_sizep, buf_check_size and buf_check_sizev should be made
   inlines, and lose the implict return.  Please don't hide such
   things in macros
 - please avoid using hlist_for_each, usually hlist_for_each_entry is
   a much better choice
 - dito for list_for_each_safe vs list_for_each_entry_safe
 - can you please check whether lib/idr.c fullfills your needs so we
   can get rid of idpool.c?
 - v9fs_inode2v9ses has lots of useless checks, inode->i_sb can never
   be NULL, and inode->i_sb->s_fs_info can't be either once set in
   fill_inode, which is before the first inode on the filesystem is
   created.  Also the argument is never NULL.  Because of that you
   can also kill all the return value checks in the callers.
 - do you really need to keep v9fs_dentry_delete just for the dprintk?
 - no need to check for a NULL file in v9fs_dir_readdir, the VFS gurantees
   it's not.  And if it was you'd better be off panic because something
   is enormously fscked.
 - Dito for v9fs_file_open
 - And the inode in v9fs_file_lock
 - And dir, file, file->d_inode, sb, v9ses in v9fs_remove.
 - And dir, sb and v9ses in v9fs_vfs_lookup
 - And dir, sb and v9ses in v9fs_vfs_symlink
 - And dir, sb and v9ses in v9fs_vfs_link
 - And dir, sb and v9ses in v9fs_vfs_mknod
 - copy_from_user returns the bytes actually copied in the failure case,
   but you should return -EFAULT instead of that number in v9fs_file_write
 - No need to implement v9fs_file_mmap, do_mmap_pgoff makes sure to error
   out if it's not present (and actually returns the correct errno)
 - I think it's pretty similar for all these checks for fid (=private_data)
   checks.  You always set them in open, so they can't be NULL
 - kfree can be called with a NULL argument just fine, you can remove
   lots of ifs for that. You also often set pointers to NULL just before
   freeing a structure - that's pretty useless as slab debugging will
   catch bugs with stary references very well, and overwrites these NULLs
   ASAP.
 - The call to ->put_inode in the error case of v9fs_get_inode is very
   wrong.  You'd actually panic if you ever hit this as v9fs doesn't
   implement a ->put_inode :-)
 - All the ISDIR checks in v9fs_remove can go, VFS makes sure to only
   call ->remove and ->rmdir on directories, and only the right one
   for each kind of child.
 - Please try to use generic_readlink instead of your own
   v9fs_vfs_readlink, as you're implemting ->follow_link and ->put_link
   that should just work
 - the last error case in v9fs_get_sb needs a dput on ->s_root"

Signed-off-by: Eric Van Hensbergen

---
commit c3ec873681d43c48a335c802cc7113e8fb763732
tree fe4e81f965c974b31d832dbae3d81391df9ca792
parent 4a0c531abb39dadce4837a8e9c29ae013fd8b4c5
author Eric Van Hensbergen <ericvh@gmail.com> Thu, 14 Jul 2005 11:21:33 -0500
committer Eric Van Hensbergen <ericvh@gmail.com> Thu, 14 Jul 2005 11:21:33 -0500

 fs/9p/9p.c         |    2 -
 fs/9p/Makefile     |    1 
 fs/9p/conv.c       |   54 ++++++------------
 fs/9p/error.c      |    3 -
 fs/9p/error.h      |    3 +
 fs/9p/fid.c        |   14 +++--
 fs/9p/idpool.c     |  152 ----------------------------------------------------
 fs/9p/idpool.h     |   42 --------------
 fs/9p/mux.c        |   44 +++++----------
 fs/9p/trans_sock.c |    2 -
 fs/9p/v9fs.c       |  103 ++++++++++++++++++++---------------
 fs/9p/v9fs.h       |   27 +++++++--
 fs/9p/vfs_dentry.c |   21 +------
 fs/9p/vfs_dir.c    |   21 +------
 fs/9p/vfs_file.c   |   35 ++----------
 fs/9p/vfs_inode.c  |   69 ++----------------------
 fs/9p/vfs_super.c  |   45 ++++++++++++++-
 17 files changed, 188 insertions(+), 450 deletions(-)

