Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315421AbSFATQZ>; Sat, 1 Jun 2002 15:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316043AbSFATQZ>; Sat, 1 Jun 2002 15:16:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45829 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315421AbSFATQY>;
	Sat, 1 Jun 2002 15:16:24 -0400
Message-ID: <3CF91E48.C76B34FA@zip.com.au>
Date: Sat, 01 Jun 2002 12:19:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <3CF88933.2EC13C8F@zip.com.au> <Pine.LNX.4.44.0206010935290.10978-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sat, 1 Jun 2002, Andrew Morton wrote:
> >
> > So run __iget prior to dropping inode_lock.
> 
> This part looks horrible:
> 
> +               spin_unlock(&inode_lock);
> +               iput(inode);
> +               spin_lock(&inode_lock);

Yup.  The inode refcounting APIs are really awkward.  Note how I recently
added dopey code in ext2_put_inode() to only drop the prealloc window on
the "final" iput().

> Why not just split up the code inside iput(), and then just do
> 
>         if (atomic_dec(&inode->i_count))
>                 final_iput(inode);
> 
> where final_iput() _wants_ the spinlock held already?
> 
> That's basically what "iput()" will end up doing, except for that
> "put_inode()" thing, which is just a horrible hack anyway.
> 
> So get rid of "put_inode()", and replace it with a new one that takes the
> place of the
> 
>         if (!inode->i_nlink)  {
>                 ... delete ..
>         } else {
>                 .. free ..
>         }
> 
> and makes that one be a "i_op->drop_inode" thing that defaults to the
> current "delete if i_nlink is zero, free it if i_nlink is not zero and
> nobody uses it".
> 
> The general VFS layer really shouldn't have assigned that strogn a meaning
> to "i_nlink" anyway, it's not for the VFS layer to decide (and it only
> causes problems for any non-UNIX-on-a-disk filesystems).
> 

Yes, I suspect all the inode refcounting, locking, I_FREEING, I_LOCK, etc
could do with a spring clean. Make it a bit more conventional.  I'll 
discuss with Al when he resurfaces.

-
