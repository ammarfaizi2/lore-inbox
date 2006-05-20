Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWETJ5q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWETJ5q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 05:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964790AbWETJ5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 05:57:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:24288 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964785AbWETJ5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 05:57:45 -0400
Date: Sat, 20 May 2006 10:57:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Phillip Hellewell <phillip@hellewell.homeip.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mhalcrow@us.ibm.com, mcthomps@us.ibm.com, toml@us.ibm.com,
       yoder1@us.ibm.com, James Morris <jmorris@namei.org>,
       "Stephen C. Tweedie" <sct@redhat.com>, Erez Zadok <ezk@cs.sunysb.edu>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 0/13: eCryptfs] eCryptfs Patch Set
Message-ID: <20060520095740.GA12237@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Phillip Hellewell <phillip@hellewell.homeip.net>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk,
	mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
	toml@us.ibm.com, yoder1@us.ibm.com,
	James Morris <jmorris@namei.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Erez Zadok <ezk@cs.sunysb.edu>, David Howells <dhowells@redhat.com>
References: <20060513033742.GA18598@hellewell.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060513033742.GA18598@hellewell.homeip.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I gave the code in -mm a quick look, and it still needs a lot of work.

 - please kill ASSERT and always use BUG_ON.
 - you don't need semaphore.h anymore
 - please always use <linux/scatterlist.h> instead of <asm/scatterlist.h>
 - please kill ECRYPTFS_SET_FLAG, ECRYPTFS_CLEAR_FLAG and ECRYPTFS_CHECK_FLAG
   and just opencode them, it'll make the code a whole lot more readable
 - why are so many fields on your data structures signed?
 - please kill the reaming uint*_t uses
 - there's definitly too many ifndefs in ecryptfs_kernel.h.  Either
   remove the or provide a good explanation why the macros could have
   been defined already
( - you need endianess annotations and conversion for your ondisk data
   structure.  it's totally unacceptable a encrypted filesystem from a BE
   machine can't be read on a LE one)
 - pleaese get rid of the horrible (NULL == something) style, it makes
   the code really hard to read
 
 
 - in ecryptfs_d_revalidate just replacing the vfsmount/dentry in the
   nameidata is dangerous, after that they aren't coherent with the
   lookup data anymore.  Either find a way to get a real nameidata that's
   valid for a lookup on your filesystem or find away to get rid of passing
   down the nameidata everywhere and replace it by a real lookup intent
   structure.  (or even better restructure the code to allow for a high-level
   method replacing the lookup intents)
   (ditto for various namespace operations in inode.c)
 - please make sure touch_atime goes down to ->setattr for atime updates,
   that way you don't need all that mess in your read/write.  and in -mm
   those routines need update for vectored and aio support
 - in read_inode_size_from_header please do the kmap after calling ->readpage.
   that also allows to swwitch to the more efficien kmap_atomic.  also instead
   of the memcpy just do 

      u64  *data_size == kmap_atomic(page, ..)

   as kmap_atomic returns a void * (and even if it didn't you could cast
   the return value) also you don't need i_size_write there since the inode
   isn't life yet.

 - ecryptfs_fsync is good sign for various issues all over the code:

     o if the various _to_private methods could fail you have much worse
       problems, they shouldn't return errors.
     o the lower_* are too long and hurt the eye, just use l*
     o file->f_op and inode->i_fop for a file instances of a file are
       always the same, no need to duplicate all the code
     o i_fop can't be NULL ever
   
   With all that fixed the code in this case should look something like:

----------------- snip -----------------
static int
stackfs_fsync(struct file *file, struct dentry *dentry, int datasync)
{
	struct file *lfile = file ? lower_file(file) : NULL;
	struct dentry *ldentry = lower_dentry(dentry);
	struct inode *linode = ldentry->d_inode;
	int rc = -EINVAL;

	if (linode->i_fop->fsync) {
		mutex_lock(&linode->i_mutex);
		rc = linode->i_fop->fsync(lfile, ldentry, datasync);
		mutex_unlock(&ldentry->d_inode->i_mutex);
	}

	return rc;
}
----------------- snip -----------------

 - NEVER EVER do things like copying locks_delete_block and
   posix_lock_file_wait (as ecryptfs_posix_lock and based on a previous
   version) to you code.  It will get stale and create a maintaince nightmare.
   talk with the subsystem maintainers on how to make the core functionality
   accesible to you.
 - similarly ecryptfs_setlk is totally non-acceptable.  find a way with the
   maintainer to reuse things from fcntl_setlk with a common helper
 - copying things like lock_parent, unlock_parent and unlock_dir

 - please split all the generic stackable filesystem passthorugh routines
   into a separated stackfs layer, in a few files in fs/stackfs/ that
   you depend on.  They'll get _GPL exported to all possible stackable
   filesystem.  They'll need their own store underlying object helpers,
   but that can be made to work by embedding the generic stackfs data
   as first thing in the ecryptfs object.

that's how far I got today, that's not even half-through yet.
