Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSIIIxt>; Mon, 9 Sep 2002 04:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316674AbSIIIxt>; Mon, 9 Sep 2002 04:53:49 -0400
Received: from plum.csi.cam.ac.uk ([131.111.8.3]:60128 "EHLO
	plum.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S316672AbSIIIxs>; Mon, 9 Sep 2002 04:53:48 -0400
Message-Id: <5.1.0.14.2.20020909095209.03fe4ec0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 09 Sep 2002 09:59:17 +0100
To: Daniel Phillips <phillips@arcor.de>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK-PATCH 1/3] Introduce fs/inode.c::ilookup().
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
In-Reply-To: <E17oGD2-0006lL-00@starship>
References: <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
 <E17ngYk-00025C-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:04 08/09/02, Daniel Phillips wrote:
>On Saturday 07 September 2002 16:27, Anton Altaparmakov wrote:
> > The second and third patch have the small disadvantage to the previous
> > code in that in the case that ilookup() fails in iget_locked() and
> > get_new_inode_fast() is called the inode hash is calculated twice.
> > But that is the slow path so I don't think it is a problem.
>
>It doesn't make sense to introduce even this small inefficiency when
>all you need to do is wrap an __ilookup inline that takes the hash
>list, and is called both from ilookup and iget.  The inline costs
>nothing, the hidden inefficiency costs cycles, however few.

True. It is not in fast path though. The fast path is ilookup() succeeding. 
If the inode is not in cache, then the fs will have to read it from disk at 
which point the additional hash calculation goes down in the noise on the 
cpu cycles front. But if you think it is so important, then yeah, I can 
make an inline wrapper. No problem.

>Thanks for actually documenting what the functions do in the inline
>documentation, it's nice to see such a break from tradition.

You are welcome. (-:

>One nano point: it would read better with the functional description
>before the ancilliary notes, i.e.:
>
>+ * The inode specified by @ino is looked up in the inode cache and if present
>+ * it is returned with an increased reference count.
>+ *
>+ * This is a fast version of iget5_locked() for file systems where the inode
>+ * number is sufficient for unique identification of an inode.

Ok.

>While I'm picking nits, it's more accurate to say that iget5_locked is
>a generalized version of iget_locked than that the latter is a fast
>version of the former.

Hrm. True. Althought it didn't evolve that way. iget5_locked came first and 
iget_locked was done later on as a speed optimization for simple file 
systems. Al wanted to keep the _fast paths separate...

>And I still like ifind* more than ilookup*.  It's shorter and is a
>better match with the existing page cache terminology.  Why add
>entropy when you don't have to?

radix_tree_lookup(), d_lookup(), path_lookup(), ... Fits in nicely. (-:

find_inode{_fast} exist already, why add confusion when you don't have to? (-;

Best regards,

         Anton


-- 
   "I haven't lost my mind... it's backed up on tape." - Peter da Silva
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

