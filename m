Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVF0UWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVF0UWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 16:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVF0UWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 16:22:36 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:58272 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261440AbVF0UTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 16:19:51 -0400
Date: Mon, 27 Jun 2005 21:19:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, ericvh@gmail.com, rminnich@lanl.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status
Message-ID: <20050627201944.GA22629@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, ericvh@gmail.com, rminnich@lanl.gov,
	linux-kernel@vger.kernel.org
References: <20050620235458.5b437274.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050620235458.5b437274.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> v9fs
> 
>     I'm not sure that this has a sufficiently high
>     usefulness-to-maintenance-cost ratio.

Personally I think this is very useful to have.  It provides a portable
way to have simple userland or remote filesystems, and it's been around
for a long time in others OSes.

That beeing said there's a few issues with the code still I'd like to
see fixed:

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
  - the last error case in v9fs_get_sb needs a dput on ->s_root

Also did you look into the VFS/NFS lookup intent bits to solve your
atomic create and open issue?
