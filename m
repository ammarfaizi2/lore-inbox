Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbREHNq6>; Tue, 8 May 2001 09:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132553AbREHNqr>; Tue, 8 May 2001 09:46:47 -0400
Received: from mail1.bna.bellsouth.net ([205.152.150.13]:47316 "EHLO
	mail1.bna.bellsouth.net") by vger.kernel.org with ESMTP
	id <S132547AbREHNqe>; Tue, 8 May 2001 09:46:34 -0400
From: volodya@mindspring.com
Date: Tue, 8 May 2001 09:46:19 -0400 (EDT)
Reply-To: volodya@mindspring.com
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Alexander Viro <viro@math.psu.edu>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200105041820.f44IKec11204@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.20.0105080941010.1137-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tried this approach too a couple of years ago. I came to the idea
that I want some kind of "event reporting" mechanism to know when
application faults and when other events (like I/O) occurs. Booting is
just the tip of the iceberg. MOST big apps are seeking on startup because
   a) their code is spread out all over executable 
   b) don't forget shared libraries..
   c) the practice of keeping configuration files in ~/.filename
      implies - read a little, seek a little.
   d) GUI apps tend to have a ton of icons.

I wonder - is it possible to get this via ptrace ? - could not find this
in the manpage.

                                Vladimir Dergachev

On Fri, 4 May 2001, Richard Gooch wrote:

> Linus Torvalds writes:
> > Now, if you want to speed up accesses, there are things you can
> > do. You can lay out the filesystem in the access order - trace the
> > IO accesses at bootup ("which file, which offset, which metadata
> > block?") and lay out the blocks of the files in exactly the right
> > order. Then you will get linear reads _without_ doing any "dd" at
> > all.
> 
> A year ago I came up with an alternative approach for cache warming,
> but I see that it wouldn't work with our current infrastructure.
> However, maybe there is still a way to use the basic technique. If so,
> please make suggestions.
> 
> The idea I had (motivated by the desire to eliminate random disc
> seeks, which is the limiting factor in how fast my boxes boot) was:
> 
> - init(8) issues an ioctl(2) on the root FS block device which turns
>   on recording of block reads (it records block numbers)
> 
> - at the end of the bootup process, init(8) issues another ioctl(2) to
>   grab the buffered block numbers, and turn off recording
> 
> - init(8) then sorts this list in ascending order and saves the result
>   in a file
> 
> - next boot, init(8) checks the file, and if it exists, opens the root
>   FS block device and reads in each block listed in the file. The
>   effect is to warm the buffer cache extremely quickly. The head will
>   move in one direction, grabbing data as it flys by. I expect this
>   will take around 1 second
> 
> - init(8) now continues the boot process (starting the magic ioctl(2)
>   again so as to get a fresh list of blocks, in case something has
>   changed)
> 
> - booting is now super fast, thanks to no disc activity.
> 
> The advantage of this scheme over blindly reading the first 50 MB is
> that it only reads in what you *need*, and thus will work better on
> low memory systems. It's also useful for other applications, not just
> speeding up the boot process.
> 
> However, doing an ioctl(2) on the block device won't help. So the
> question is, where to add the hook? One possibility is the FS, and
> record inum,bnum pairs. But of course we don't have a way of accessing
> via inum in user-space. So that's no good. Besides, we want to get
> block numbers on the block device, because that's the only meaningful
> number to resort.
> 
> So, what, then? Some kind of hook on the page cache? Ideas?
> 
> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

