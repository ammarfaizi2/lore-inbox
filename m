Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135890AbRD0AKo>; Thu, 26 Apr 2001 20:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135923AbRD0AKe>; Thu, 26 Apr 2001 20:10:34 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31328 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135890AbRD0AKU>; Thu, 26 Apr 2001 20:10:20 -0400
Date: Fri, 27 Apr 2001 02:05:24 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
Message-ID: <20010427020524.A678@athlon.random>
In-Reply-To: <20010426230751.J819@athlon.random> <Pine.GSO.4.21.0104261924080.15385-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0104261924080.15385-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 26, 2001 at 07:25:23PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 07:25:23PM -0400, Alexander Viro wrote:
> 
> 
> On Thu, 26 Apr 2001, Andrea Arcangeli wrote:
> 
> > > How about adding
> > > 	if (!buffer_uptodate(bh)) {
> > > 		printk(KERN_ERR "IO error or racy use of wait_on_buffer()");
> > > 		show_task(current);
> > > 	}
> > > in the end of wait_on_buffer() for a while?
> > 
> > At the _top_ of wait_on_buffer would be better then at the end.
> 
> In that case ll_rw_block() + wait_on_buffer() (absolutely legitimate
> combination) will scream at you.

--- 2.4.4pre7/include/linux/locks.h	Thu Apr 26 05:22:11 2001
+++ 2.4.4pre7aa1/include/linux/locks.h	Fri Apr 27 01:52:31 2001
@@ -18,6 +18,11 @@
 {
 	if (test_bit(BH_Lock, &bh->b_state))
 		__wait_on_buffer(bh);
+	else if (!buffer_uptodate(bh)) {
+		__label__ here; 
+	here:
+		printk(KERN_ERR "IO error or racy use of wait_on_buffer() from %p\n", &&here);
+	}
 }
 
 extern inline void lock_buffer(struct buffer_head * bh)

Andrea
