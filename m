Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274617AbRITTOa>; Thu, 20 Sep 2001 15:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274618AbRITTOU>; Thu, 20 Sep 2001 15:14:20 -0400
Received: from [195.223.140.107] ([195.223.140.107]:37876 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274617AbRITTOG>;
	Thu, 20 Sep 2001 15:14:06 -0400
Date: Thu, 20 Sep 2001 21:13:45 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Chris Mason <mason@suse.com>,
        Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Beau Kuiper <kuib-kl@ljbc.wa.edu.au>,
        Andrew Morton <andrewm@uow.edu.au>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
Message-ID: <20010920211345.X729@athlon.random>
In-Reply-To: <20010920170812.CCCACE641B@ns1.suse.com> <773660000.1001006393@tiny>, <773660000.1001006393@tiny>; <20010920204712.T729@athlon.random> <3BAA3C6D.AC20D953@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BAA3C6D.AC20D953@zip.com.au>; from akpm@zip.com.au on Thu, Sep 20, 2001 at 11:58:53AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 11:58:53AM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > ...
> > --- 2.4.10pre12aa2/fs/buffer.c.~1~      Thu Sep 20 20:14:19 2001
> > +++ 2.4.10pre12aa2/fs/buffer.c  Thu Sep 20 20:45:58 2001
> > @@ -2506,7 +2506,7 @@
> >         spin_unlock(&free_list[isize].lock);
> > 
> >         page->buffers = bh;
> > -       page->flags &= ~(1 << PG_referenced);
> > +       page->flags |= 1 << PG_referenced;
> 
> I don't see how this can change anything - getblk() calls
> touch_buffer() shortly afterwards, which does the same
> thing?

I'm worried the page is freed before it has a chance to be found in the
freelist in smp. The refill_freelist logic is broken too and right fix
would be much more invasive than the above one liner, we should return
one bh with b_count just set to 1 to be sure it's not collected away
under us and we have to try again. But this one probably will do the
trick too for now. and maybe it really doesn't matter as you say.

And also the get_hash_table need to touch the buffer since reiserfs
makes heavy use if it.

just a few ideas.

--- 2.4.10pre12aa2/fs/buffer.c.~1~	Thu Sep 20 20:14:19 2001
+++ 2.4.10pre12aa2/fs/buffer.c	Thu Sep 20 21:06:16 2001
@@ -598,8 +598,10 @@
 		    bh->b_size    == size	&&
 		    bh->b_dev     == dev)
 			break;
-	if (bh)
+	if (bh) {
 		get_bh(bh);
+		touch_buffer(bh);
+	}
 
 	return bh;
 }
@@ -1181,10 +1183,10 @@
 
 		/* Insert the buffer into the regular lists */
 		__insert_into_queues(bh);
+		touch_buffer(bh);
 	out:
 		write_unlock(&hash_table_lock);
 		spin_unlock(&lru_list_lock);
-		touch_buffer(bh);
 		return bh;
 	}
 

Andrea
