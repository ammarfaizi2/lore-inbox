Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBTBQr>; Mon, 19 Feb 2001 20:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129243AbRBTBQi>; Mon, 19 Feb 2001 20:16:38 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:41223 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129170AbRBTBQV>; Mon, 19 Feb 2001 20:16:21 -0500
Date: Mon, 19 Feb 2001 20:15:46 -0500
From: Chris Mason <mason@suse.com>
To: Neil Brown <neilb@cse.unsw.edu.au>, Alan Cox <alan@redhat.com>
cc: dek_ml@konerding.com, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4
Message-ID: <1633680000.982631746@tiny>
In-Reply-To: <14993.48376.203279.390285@notabene.cse.unsw.edu.au>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, February 20, 2001 11:40:24 AM +1100 Neil Brown
<neilb@cse.unsw.edu.au> wrote:
> 
>   When reiserfs came along, it abused this, and re-interpreted the
>   opaque datum to contain information for recalling (locating) an
>   inode - if read_inode2 was defined.  I think this is wrong.
>

I suggested to Al Viro a while ago to break iget up into two calls, and
then got sucked into something else and didn't follow up.  Independently,
he came up with the below message during a thread on fs-devel about
read_inode.  I think it is very similar to what you've described, and it
should work.  I'm willing to help integrate/code once things settle down
for 2.4.

His last paragraph is also important, I'd rather see this as a new
call...BTW, I believe XFS and GFS actually have 64 bit inode numbers, while
reiserfs has a unique 32 bit inode number (objectid) and a unique 32 bit
packing locality that are both required to find the object.

Cut n' paste from Viro's mail, beware of newline munging:

> From: Alexander Viro <viro@math.psu.edu>
> To: Steve Whitehouse <Steve@ChyGwyn.com>
> cc: linux-fsdevel@vger.kernel.org
> Subject: Re: read_inode() extra argument ?
> Date-Sent: Tuesday, December 19, 2000 06:41:42 AM -0500
>
[snip]
> Basically, read_inode() (and iget()) is _not_ a universal API. It's
> a conveniency thing for filesystems that are comfortable with it. Notice
> that quite a few filesystems do not have ->read_inode() at all.
> 
> If you need more than just an inumber to fill the inode - don't use
> iget() at all. It's just a wrong API for that kind of situations.
> 
> In all fairness, ->read_inode() should not be a method. Correct way to
> deal with that would be along the lines
> 
> --- fs/inode.c	Tue Dec 19 09:42:41 2000
> +++ fs/inode.c.new	Tue Dec 19 09:59:37 2000
> @@ -661,22 +661,10 @@
> 			 inode->i_ino = ino;
> 			 inode->i_flags = 0;
> 			 atomic_set(&inode->i_count, 1);
> -			inode->i_state = I_LOCK;
> +			inode->i_state = I_LOCK | I_NEW;
> 			 spin_unlock(&inode_lock);
>  
> 			 clean_inode(inode);
> -			sb->s_op->read_inode(inode);
> -
> -			/*
> -			 * This is special!  We do not need the spinlock
> -			 * when clearing I_LOCK, because we're guaranteed
> -			 * that nobody else tries to do anything about the
> -			 * state of the inode when it is locked, as we
> -			 * just created it (so there can be no old holders
> -			 * that haven't tested I_LOCK).
> -			 */
> -			inode->i_state &= ~I_LOCK;
> -			wake_up(&inode->i_wait);
>  
> 			 return inode;
> 		 }
> @@ -693,6 +681,20 @@
> 		 wait_on_inode(inode);
> 	 }
> 	 return inode;
> +}
> +
> +void unlock_new_inode(struct inode *inode)
> +{
> +	/*
> +	 * This is special!  We do not need the spinlock
> +	 * when clearing I_LOCK, because we're guaranteed
> +	 * that nobody else tries to do anything about the
> +	 * state of the inode when it is locked, as we
> +	 * just created it (so there can be no old holders
> +	 * that haven't tested I_LOCK).
> +	 */
> +	inode->i_state &= ~(I_LOCK|I_NEW);
> +	wake_up(&inode->i_wait);
>  }
>  
>  static inline unsigned long hash(struct super_block *sb, unsigned long
>  i_ino) --- fs/ext2/namei.c	Tue Dec 19 09:59:54 2000
> +++ fs/ext2/namei.c.new	Tue Dec 19 10:01:22 2000
> @@ -175,9 +175,12 @@
> 		 unsigned long ino = le32_to_cpu(de->inode);
> 		 brelse (bh);
> 		 inode = iget(dir->i_sb, ino);
> -
> 		 if (!inode)
> 			 return ERR_PTR(-EACCES);
> +		if (inode->i_state & I_NEW) {
> +			ext2_read_inode(inode);
> +			unlock_new_inode(inode);
> +		}
> 	 }
> 	 d_add(dentry, inode);
> 	 return NULL;
> 
> (modulo obvious changes to fs.h, exporting (or inlining)
> unlock_new_inode(), etc.)
> 
> The point being: allow filesystems to use whatever means they find
> convenient for filling the inode. All we really need from icache is an
> analog of iget() that would leave new struct inode locked, recognizable
> as new and would _not_ do anything fs-specific. Quite possibly we want a
> new function for that leaving iget() as-is so that existing callers would
> stay intact - patch above just describes the general idea.




