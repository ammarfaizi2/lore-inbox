Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289115AbSAGEeH>; Sun, 6 Jan 2002 23:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289116AbSAGEd6>; Sun, 6 Jan 2002 23:33:58 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:2064 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289115AbSAGEdw>; Sun, 6 Jan 2002 23:33:52 -0500
Message-ID: <3C3923F5.485668AA@zip.com.au>
Date: Sun, 06 Jan 2002 20:28:37 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>, <3C36DEA9.AEA2A402@zip.com.au>; <20020107043236.J1561@athlon.random> <3C391A96.63FDBA8@zip.com.au>,
		<3C391A96.63FDBA8@zip.com.au>; from akpm@zip.com.au on Sun, Jan 06, 2002 at 07:48:38PM -0800 <20020107051259.L1561@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> > (I think I'll add a buffer_mapped() test to this code as well.  It's
> > a bit redundant because the fs shouldn't go setting BH_New and not
> > BH_Mapped, but this code is _very_ rarely executed, and I haven't
> > tested all filesystems...)
> 
> correct, it shouldn't be necessary. I wouldn't add it. if a fs breaks the
> buffer_new semantics it's the one that should be fixed methinks.

You mean "don't be lazy.  Audit all the filesystems"?  Sigh.  OK.
 
> >
> > @@ -1633,12 +1660,22 @@ static int __block_prepare_write(struct
> >          */
> >         while(wait_bh > wait) {
> >                 wait_on_buffer(*--wait_bh);
> > -               err = -EIO;
> >                 if (!buffer_uptodate(*wait_bh))
> > -                       goto out;
> > +                       return -EIO;
> >         }
> >         return 0;
> >  out:
> > +       bh = head;
> > +       block_start = 0;
> > +       do {
> > +               if (buffer_new(bh) && buffer_mapped(bh) && !buffer_uptodate(bh)) {
> > +                       memset(kaddr+block_start, 0, bh->b_size);
> > +                       set_bit(BH_Uptodate, &bh->b_state);
> > +                       mark_buffer_dirty(bh);
> > +               }
> > +               block_start += bh->b_size;
> > +               bh = bh->b_this_page;
> > +       } while (bh != head);
> 
> I found another problem,  we really need to keep track of which bh are
> been created by us during the failing prepare_write (buffer_new right
> now, not a long time ago), or we risk to corrupt data with a write
> passing over many bh, where the first bh of the page contained vaild
> data since a long time ago.  To do this: 1) we either keep track of it
> on the kernel stack with some local variable or 2) we change
> the buffer_new semantics so that they indicate an "instant buffer_new"
> to clear just after checking it

Fair enough.  How does this (untested) approach look?


@@ -1600,6 +1627,7 @@ static int __block_prepare_write(struct 
                if (block_start >= to)
                        break;
                if (!buffer_mapped(bh)) {
+                       clear_bit(BH_New, &bh->b_state);
                        err = get_block(inode, block, bh, 1);
                        if (err)
                                goto out;
@@ -1633,12 +1661,30 @@ static int __block_prepare_write(struct 
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
+       /*
+        * Zero out any newly allocated blocks to avoid exposing stale
+        * data.  If BH_New is set, we know that the block was newly
+        * allocated in the above loop.
+        */
+       bh = head;
+       block_start = 0;
+       do {
+               if (buffer_new(bh)) {
+                       if (buffer_uptodate(bh))
+                               printk(KERN_ERR __FUNCTION__
+                                       ": zeroing uptodate buffer!\n");
+                       memset(kaddr+block_start, 0, bh->b_size);
+                       set_bit(BH_Uptodate, &bh->b_state);
+                       mark_buffer_dirty(bh);
+               }
+               block_start += bh->b_size;
+               bh = bh->b_this_page;
+       } while (bh != head);
        return err;
 }
