Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289118AbSAGFI6>; Mon, 7 Jan 2002 00:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289121AbSAGFIs>; Mon, 7 Jan 2002 00:08:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:14692 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289118AbSAGFIg>; Mon, 7 Jan 2002 00:08:36 -0500
Date: Mon, 7 Jan 2002 06:09:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
Message-ID: <20020107060900.A2481@athlon.random>
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>, <3C36DEA9.AEA2A402@zip.com.au>; <20020107043236.J1561@athlon.random> <3C391A96.63FDBA8@zip.com.au>, <3C391A96.63FDBA8@zip.com.au>; <20020107051259.L1561@athlon.random> <3C3923F5.485668AA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C3923F5.485668AA@zip.com.au>; from akpm@zip.com.au on Sun, Jan 06, 2002 at 08:28:37PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 08:28:37PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > > (I think I'll add a buffer_mapped() test to this code as well.  It's
> > > a bit redundant because the fs shouldn't go setting BH_New and not
> > > BH_Mapped, but this code is _very_ rarely executed, and I haven't
> > > tested all filesystems...)
> > 
> > correct, it shouldn't be necessary. I wouldn't add it. if a fs breaks the
> > buffer_new semantics it's the one that should be fixed methinks.
> 
> You mean "don't be lazy.  Audit all the filesystems"?  Sigh.  OK.

actually I meant more "don't care about filesystems that are broken
anwways" :) but since we're changing the semantincs ourself below in the
mainstream we'll have to check for the other internal usages of
buffer_new, should be very easy though.

>  
> > >
> > > @@ -1633,12 +1660,22 @@ static int __block_prepare_write(struct
> > >          */
> > >         while(wait_bh > wait) {
> > >                 wait_on_buffer(*--wait_bh);
> > > -               err = -EIO;
> > >                 if (!buffer_uptodate(*wait_bh))
> > > -                       goto out;
> > > +                       return -EIO;
> > >         }
> > >         return 0;
> > >  out:
> > > +       bh = head;
> > > +       block_start = 0;
> > > +       do {
> > > +               if (buffer_new(bh) && buffer_mapped(bh) && !buffer_uptodate(bh)) {
> > > +                       memset(kaddr+block_start, 0, bh->b_size);
> > > +                       set_bit(BH_Uptodate, &bh->b_state);
> > > +                       mark_buffer_dirty(bh);
> > > +               }
> > > +               block_start += bh->b_size;
> > > +               bh = bh->b_this_page;
> > > +       } while (bh != head);
> > 
> > I found another problem,  we really need to keep track of which bh are
> > been created by us during the failing prepare_write (buffer_new right
> > now, not a long time ago), or we risk to corrupt data with a write
> > passing over many bh, where the first bh of the page contained vaild
> > data since a long time ago.  To do this: 1) we either keep track of it
> > on the kernel stack with some local variable or 2) we change
> > the buffer_new semantics so that they indicate an "instant buffer_new"
> > to clear just after checking it
> 
> Fair enough.  How does this (untested) approach look?
> 
> 
> @@ -1600,6 +1627,7 @@ static int __block_prepare_write(struct 
>                 if (block_start >= to)
>                         break;
>                 if (!buffer_mapped(bh)) {
> +                       clear_bit(BH_New, &bh->b_state);
>                         err = get_block(inode, block, bh, 1);
>                         if (err)
>                                 goto out;
> @@ -1633,12 +1661,30 @@ static int __block_prepare_write(struct 
>          */
>         while(wait_bh > wait) {
>                 wait_on_buffer(*--wait_bh);
> -               err = -EIO;
>                 if (!buffer_uptodate(*wait_bh))
> -                       goto out;
> +                       return -EIO;
>         }
>         return 0;
>  out:
> +       /*
> +        * Zero out any newly allocated blocks to avoid exposing stale
> +        * data.  If BH_New is set, we know that the block was newly
> +        * allocated in the above loop.
> +        */
> +       bh = head;
> +       block_start = 0;
> +       do {
> +               if (buffer_new(bh)) {
> +                       if (buffer_uptodate(bh))
> +                               printk(KERN_ERR __FUNCTION__
> +                                       ": zeroing uptodate buffer!\n");
> +                       memset(kaddr+block_start, 0, bh->b_size);
> +                       set_bit(BH_Uptodate, &bh->b_state);
> +                       mark_buffer_dirty(bh);
> +               }
> +               block_start += bh->b_size;
> +               bh = bh->b_this_page;
> +       } while (bh != head);
>         return err;

this is 2) and it looks fine, but we need to update write_full_page too
to clear the bit (that's pagecache). Anybody else checking for
buffer_new on visible pagecache bhs should be updated as well.

And also generic_direct_IO needs somehow to write something if get_block
fails during a write. But I guess there it is simpler to let brw_kiovec
to go ahead before the get_block failure, otherwise we've nothing to
write (patching the iobuf->length for the duration of the brw_kiovec
should be enough, so we do a short write and we notify about the error
only if we couldn't write anything, of course it would be better to
restore the length later even if probably not needed). This will also
allow to use all the blocks of the fs and it's what the userspace expects.
For the o_direct writes in my tree the ->truncate is just in place
(truncate_inode_pages isn't needed there).

Andrea
