Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268906AbRHFR3S>; Mon, 6 Aug 2001 13:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268910AbRHFR3I>; Mon, 6 Aug 2001 13:29:08 -0400
Received: from [63.209.4.196] ([63.209.4.196]:12037 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268906AbRHFR2y>; Mon, 6 Aug 2001 13:28:54 -0400
Date: Mon, 6 Aug 2001 10:27:33 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: "David S. Miller" <davem@redhat.com>, Chris Wedgwood <cw@f00f.org>,
        David Luyer <david_luyer@pacific.net.au>,
        <linux-kernel@vger.kernel.org>
Subject: Re: /proc/<n>/maps growing...
In-Reply-To: <20010806152919.H20837@athlon.random>
Message-ID: <Pine.LNX.4.33.0108061020430.8972-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 6 Aug 2001, Andrea Arcangeli wrote:
>
> On Mon, Aug 06, 2001 at 06:06:14AM -0700, David S. Miller wrote:
> > I wouldn't classify it as a horrible hack... but.
>
> The part I find worse is that we just walk the tree two times.

Try it without doing it - the code grows quite nasty without completely
getting rid of "insert_vm_struct()".

Which I considered, but decided that 2.4.x is not the time to do so.

> I believe the best way is to allocate always the new vma, and to hide
> the merging into the lowlevel of a new insert_vm_struct (with a special
> function ala merge_segments that we can share with mprotect like in 2.2).

Oh, and THAT is going to speed things up?

Hint: the merging actually happens at a fairly high percentage for the
common cases. We win more by walking the tree twice and avoiding the
unnecessary allocation/free.

Now, if you _really_ want to do this right, you can:
 - hold the write lock on the semaphore. Nobody is going to change the
   list.

 - walk the table just once, remembering what the previous entry was.

   NOTE! You ahve to do this _anyway_, as part of checking the "do I need
   to unmap anything?" Right now we just call "do_munmap()", but done
   right we would walk the tree _once_, noticing whether we need to unmap
   or not, and keep track of what the previous one was.

 - just expand the previous entry when you notice that it's doable.

 - allocate and insert a new entry if needed.

However, this absolutely means getting rid of "insert_vm_struct()", and
moving a large portion of it into the caller.

It also means doing the same for "do_munmap()".

Try it. I'd love to see the code. I didn't want to do it myself.

And remember: optimize for _well_written applications. Not for stupid
glibc code that can be fixed.

		Linus

