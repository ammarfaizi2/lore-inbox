Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289108AbSAGEND>; Sun, 6 Jan 2002 23:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289111AbSAGEMy>; Sun, 6 Jan 2002 23:12:54 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:28000 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289108AbSAGEMj>; Sun, 6 Jan 2002 23:12:39 -0500
Date: Mon, 7 Jan 2002 05:12:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
Message-ID: <20020107051259.L1561@athlon.random>
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>, <3C36DEA9.AEA2A402@zip.com.au>; <20020107043236.J1561@athlon.random> <3C391A96.63FDBA8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C391A96.63FDBA8@zip.com.au>; from akpm@zip.com.au on Sun, Jan 06, 2002 at 07:48:38PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2002 at 07:48:38PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Sat, Jan 05, 2002 at 03:08:25AM -0800, Andrew Morton wrote:
> > >       }
> > >       return 0;
> > >  out:
> > > +     bh = head;
> > > +     block_start = 0;
> > > +     do {
> > > +             if (buffer_new(bh) && !buffer_uptodate(bh)) {
> > > +                     memset(kaddr+block_start, 0, bh->b_size);
> > > +                     set_bit(BH_Uptodate, &bh->b_state);
> > > +                     mark_buffer_dirty(bh);
> > > +             }
> > > +             block_start += bh->b_size;
> > > +             bh = bh->b_this_page;
> > > +     } while (bh != head);
> > >       return err;
> > >  }
> > 
> > the above code will end marking uptodate (zeroed) buffers relative to
> > blocks that cannot be read from disk. So a read-retry won't hit the disk
> > and that's wrong.
> > 
> > I think that will be fixed by additionally also return -EIO in the
> > wait_on_buffer loop (instead of goto out), so we won't generate zeroed
> > uptodate cache in case of read failure.
> > 
> 
> Right.  There's also the case where get_block() returns -EIO when,
> for example, it fails on reading an indirect block.  We end up
> writing zeroes into some of the blocks.  But I think that behaviour
> is correct.

yes, in such case again we've to giveup with the writes so we've to
cleanup the leftovers first.

> 
> (I think I'll add a buffer_mapped() test to this code as well.  It's
> a bit redundant because the fs shouldn't go setting BH_New and not
> BH_Mapped, but this code is _very_ rarely executed, and I haven't
> tested all filesystems...)

correct, it shouldn't be necessary. I wouldn't add it. if a fs breaks the
buffer_new semantics it's the one that should be fixed methinks.

> 
> @@ -1633,12 +1660,22 @@ static int __block_prepare_write(struct 
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
> +       bh = head;
> +       block_start = 0;
> +       do {
> +               if (buffer_new(bh) && buffer_mapped(bh) && !buffer_uptodate(bh)) {
> +                       memset(kaddr+block_start, 0, bh->b_size);
> +                       set_bit(BH_Uptodate, &bh->b_state);
> +                       mark_buffer_dirty(bh);
> +               }
> +               block_start += bh->b_size;
> +               bh = bh->b_this_page;
> +       } while (bh != head);

I found another problem,  we really need to keep track of which bh are
been created by us during the failing prepare_write (buffer_new right
now, not a long time ago), or we risk to corrupt data with a write
passing over many bh, where the first bh of the page contained vaild
data since a long time ago.  To do this: 1) we either keep track of it
on the kernel stack with some local variable or 2) we change
the buffer_new semantics so that they indicate an "instant buffer_new"
to clear just after checking it

>         return err;
>  }
>  
> I'll retest this, including the -EIO path.


Andrea
