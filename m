Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317415AbSIIPsm>; Mon, 9 Sep 2002 11:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317402AbSIIPsl>; Mon, 9 Sep 2002 11:48:41 -0400
Received: from dsl-213-023-039-209.arcor-ip.net ([213.23.39.209]:41917 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317415AbSIIPsk>;
	Mon, 9 Sep 2002 11:48:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: [BK-PATCH 1/3] Introduce fs/inode.c::ilookup().
Date: Mon, 9 Sep 2002 17:55:27 +0200
X-Mailer: KMail [version 1.3.2]
Cc: torvalds@transmeta.com (Linus Torvalds),
       linux-kernel@vger.kernel.org (Linux Kernel),
       viro@math.psu.edu (Alexander Viro)
References: <E17ngYk-00025C-00@storm.christs.cam.ac.uk> <5.1.0.14.2.20020909095209.03fe4ec0@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20020909095209.03fe4ec0@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17oQsq-0006p6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 September 2002 10:59, Anton Altaparmakov wrote:
> At 18:04 08/09/02, Daniel Phillips wrote:
> >On Saturday 07 September 2002 16:27, Anton Altaparmakov wrote:
> > > The second and third patch have the small disadvantage to the previous
> > > code in that in the case that ilookup() fails in iget_locked() and
> > > get_new_inode_fast() is called the inode hash is calculated twice.
> > > But that is the slow path so I don't think it is a problem.
> >
> >It doesn't make sense to introduce even this small inefficiency when
> >all you need to do is wrap an __ilookup inline that takes the hash
> >list, and is called both from ilookup and iget.  The inline costs
> >nothing, the hidden inefficiency costs cycles, however few.
> 
> True. It is not in fast path though. The fast path is ilookup() succeeding. 
> If the inode is not in cache, then the fs will have to read it from disk at 
> which point the additional hash calculation goes down in the noise on the 
> cpu cycles front.

The inode block may be (probably is) in cache, so the hash doesn't get as
lost as you'd think.  Granted, it's an efficient hash, but actually, we'd
like to make it a little less efficient to get better distribution, and the 
efficiency argument re that improvement has dribbled on for *years*, even
though the improved hash would not be as much as twice as expensive.

That slow path is still very important.  Many loads always hit the slow
path (find).

> But if you think it is so important, then yeah, I can 
> make an inline wrapper. No problem.

Thanks, then I'll be able to sleep tonight ;-)

While you're in there, feast your eyes on hash() and meditate on how much
it sucks.  Bill Irwin did some lovely work a while back on sparse
multiplicative hashes, which ought to be dressed up and incorporated.

-- 
Daniel
