Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVGMS2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVGMS2q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbVGMS0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:26:25 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:9882 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261483AbVGMSX7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:23:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qcWu3HC7S1JLgxdkSQCeFN8MB2QIA80J1AEyv3Iy9+oyDzsWrt6cugxhUJhZYgEv3Fl5PbM2H3X2YICZn6LzvDPXIlA19qJthvf+pBio9K2usqtS9CLlnZW7PAF/SQy8CEB/9n6xhkNhXIiaM4zt0DDcU+EB2YG1EHOBTwixQpY=
Message-ID: <a4e6962a050713112363010124@mail.gmail.com>
Date: Wed, 13 Jul 2005 13:23:24 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       ericvh@gmail.com, rminnich@lanl.gov, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net
Subject: Re: (v9fs) -mm -> 2.6.13 merge status
In-Reply-To: <20050627201944.GA22629@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050620235458.5b437274.akpm@osdl.org>
	 <20050627201944.GA22629@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/05, Christoph Hellwig <hch@infradead.org> wrote:
> 
> That beeing said there's a few issues with the code still I'd like to
> see fixed:
>

Sorry I didn't get to these quicker - was on vacation and basically
off-line for the past week and a half.  I've made 90% of the changes
suggested and committed them to my git tree, I'll combine the changes
into a single patch and then split them by file-group before sending
them to akpm to more closely match the existing patches.  The 10% I
didn't address I'll comment on below, most of them represent harder
problems that I'd like to think about a bit more.

>
>   - there's three sparse warnings still.  Two of them are easily fixed
>     by moving externs to headers, one doesn't look fixable until we get
>     a sane in-kernel api for socket operations

done

>   - some dentry handling looks rather odd.  Why are you for example
>     calling d_drop in v9fs_vfs_symlink, v9fs_vfs_mknod and v9fs_vfs_link?
>     Shouldn't all these call d_instantatiate to actually reuse the
>     dentry as in v9fs_vfs_create?  Also what's the issue with
>     v9fs_fid_insert?  It would seem better and more logical to me to
>     always set d_fsdata in create/mknod/symlink/open before hashing it
>     and then beeing able to rely on it beeing non-NULL.

All of this is kind of tricky due to the association of fids with
dentry elements and the special way we handle certain features (such
as special files and symlinks).  The current code aggressively
invalidates fids to prevent the dcache from masking operations that
may be semantically important to synthetic file systems.  If you look
in v9fs_create we actually d_drop the dentry for created directories
as well.  The only reason we don't d_drop normal files is because we
are trying to preserve the atomic create/open semantics.

I'm not 100% confident this is the right solution, but its the closest
I've been able to come so far -- there's actually been a fair amount
of discussion on this in the v9fs-developer's list.  If you want more
details, it's probably worth a separate thread to discuss the reasons
behind why we want to aggressively invalidate the dcache and how we
have tried to accomplish this -- or we could just catch up at OLS.

>   - buf_check_sizep, buf_check_size and buf_check_sizev should be made
>     inlines, and lose the implict return.  Please don't hide such
>     things in macros

done

>   - please avoid using hlist_for_each, usually hlist_for_each_entry is
>     a much better choice
>   - dito for list_for_each_safe vs list_for_each_entry_safe

done

>   - can you please check whether lib/idr.c fullfills your needs so we
>     can get rid of idpool.c?

Last time I looked idr didn't do exactly what I wanted, but looking
over it again I realize its just doing more than I want -- so I've
eliminated idpool.*, but still have wrapper functions to encapsulate
locking and retry -- it strikes me that there may be a case for
generalizing these wrapper functions and putting them in lib/idr.c,
but figured that could wait.

>   - v9fs_inode2v9ses has lots of useless checks, inode->i_sb can never
>     be NULL, and inode->i_sb->s_fs_info can't be either once set in
>     fill_inode, which is before the first inode on the filesystem is
>     created.  Also the argument is never NULL.  Because of that you
>     can also kill all the return value checks in the callers.
>   - do you really need to keep v9fs_dentry_delete just for the dprintk?
>   - no need to check for a NULL file in v9fs_dir_readdir, the VFS gurantees
>     it's not.  And if it was you'd better be off panic because something
>     is enormously fscked.
>   - Dito for v9fs_file_open
>   - And the inode in v9fs_file_lock
>   - And dir, file, file->d_inode, sb, v9ses in v9fs_remove.
>   - And dir, sb and v9ses in v9fs_vfs_lookup
>   - And dir, sb and v9ses in v9fs_vfs_symlink
>   - And dir, sb and v9ses in v9fs_vfs_link
>   - And dir, sb and v9ses in v9fs_vfs_mknod

Yeah, all of these were sanity checks during initial development while
I was still understanding the VFS API.  I think I got most of them
this time.

>   - copy_from_user returns the bytes actually copied in the failure case,
>     but you should return -EFAULT instead of that number in v9fs_file_write

fixed

>   - No need to implement v9fs_file_mmap, do_mmap_pgoff makes sure to error
>     out if it's not present (and actually returns the correct errno)
>   - I think it's pretty similar for all these checks for fid (=private_data)
>     checks.  You always set them in open, so they can't be NULL
>   - kfree can be called with a NULL argument just fine, you can remove
>     lots of ifs for that. You also often set pointers to NULL just before
>     freeing a structure - that's pretty useless as slab debugging will
>     catch bugs with stary references very well, and overwrites these NULLs
>     ASAP.
>   - The call to ->put_inode in the error case of v9fs_get_inode is very
>     wrong.  You'd actually panic if you ever hit this as v9fs doesn't
>     implement a ->put_inode :-)
>   - All the ISDIR checks in v9fs_remove can go, VFS makes sure to only
>     call ->remove and ->rmdir on directories, and only the right one
>     for each kind of child.

done

>   - Please try to use generic_readlink instead of your own
>     v9fs_vfs_readlink, as you're implemting ->follow_link and ->put_link
>     that should just work

I tried this and the kernel crashed - which may mean I've done
something wrong in follow_link or put_link.  I'll revisit this and try
to figure out what happened, but for now I've left my readlink in.

>   - the last error case in v9fs_get_sb needs a dput on ->s_root

done

> 
> Also did you look into the VFS/NFS lookup intent bits to solve your
> atomic create and open issue?
> 

I had considered the lookup intent bits to solve several different
problems associated with our fid handling - but never really felt
confident in my understanding of how the intent stuff was supposed to
work.  It is certainly worth revisiting now that things have calmed
down a bit.

           -eric
