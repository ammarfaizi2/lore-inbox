Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289107AbSAGDyg>; Sun, 6 Jan 2002 22:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289109AbSAGDy0>; Sun, 6 Jan 2002 22:54:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:25618 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289107AbSAGDyH>; Sun, 6 Jan 2002 22:54:07 -0500
Message-ID: <3C391A96.63FDBA8@zip.com.au>
Date: Sun, 06 Jan 2002 19:48:38 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>,
		<3C36DEA9.AEA2A402@zip.com.au>; from akpm@zip.com.au on Sat, Jan 05, 2002 at 03:08:25AM -0800 <20020107043236.J1561@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sat, Jan 05, 2002 at 03:08:25AM -0800, Andrew Morton wrote:
> >       }
> >       return 0;
> >  out:
> > +     bh = head;
> > +     block_start = 0;
> > +     do {
> > +             if (buffer_new(bh) && !buffer_uptodate(bh)) {
> > +                     memset(kaddr+block_start, 0, bh->b_size);
> > +                     set_bit(BH_Uptodate, &bh->b_state);
> > +                     mark_buffer_dirty(bh);
> > +             }
> > +             block_start += bh->b_size;
> > +             bh = bh->b_this_page;
> > +     } while (bh != head);
> >       return err;
> >  }
> 
> the above code will end marking uptodate (zeroed) buffers relative to
> blocks that cannot be read from disk. So a read-retry won't hit the disk
> and that's wrong.
> 
> I think that will be fixed by additionally also return -EIO in the
> wait_on_buffer loop (instead of goto out), so we won't generate zeroed
> uptodate cache in case of read failure.
> 

Right.  There's also the case where get_block() returns -EIO when,
for example, it fails on reading an indirect block.  We end up
writing zeroes into some of the blocks.  But I think that behaviour
is correct.

(I think I'll add a buffer_mapped() test to this code as well.  It's
a bit redundant because the fs shouldn't go setting BH_New and not
BH_Mapped, but this code is _very_ rarely executed, and I haven't
tested all filesystems...)

@@ -1633,12 +1660,22 @@ static int __block_prepare_write(struct 
         */
        while(wait_bh > wait) {
                wait_on_buffer(*--wait_bh);
-               err = -EIO;
                if (!buffer_uptodate(*wait_bh))
-                       goto out;
+                       return -EIO;
        }
        return 0;
 out:
+       bh = head;
+       block_start = 0;
+       do {
+               if (buffer_new(bh) && buffer_mapped(bh) && !buffer_uptodate(bh)) {
+                       memset(kaddr+block_start, 0, bh->b_size);
+                       set_bit(BH_Uptodate, &bh->b_state);
+                       mark_buffer_dirty(bh);
+               }
+               block_start += bh->b_size;
+               bh = bh->b_this_page;
+       } while (bh != head);
        return err;
 }
 
I'll retest this, including the -EIO path.
