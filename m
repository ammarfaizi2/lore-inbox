Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282099AbRLLUsr>; Wed, 12 Dec 2001 15:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282092AbRLLUs2>; Wed, 12 Dec 2001 15:48:28 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:61702 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S282082AbRLLUsZ>;
	Wed, 12 Dec 2001 15:48:25 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wayne Whitney <whitney@math.berkeley.edu>
Date: Wed, 12 Dec 2001 21:47:49 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <BCF5AF03A80@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 01 at 12:02, Wayne Whitney wrote:

> o Pick a maximum stack size S and change the kernel so the "mmap()
>   without MAP_FIXED" region starts at 0xC0000000 - S and grows downwards. 

How you'll pick S? 8MB? 128MB? Now you can have 1GB brk + 2GB (stack+mmap),
after change you have 2.9GB (brk+mmap), but only 128MB stack. And if you'll
change your malloc implementation, you can have up to 2GB stack now, or
up to 3GB of mmap. After your change your stack is limited to 128MB, and
you cannot do anything around that except moving stack somewhere else
during libc startup - and in this case couple of argv[] assumptions
setproctitle and other do are no longer valid.

Another problem is mremap. Due to way how apps works, you'll have
to move VMAs around much more because of you cannot grow your last
VMA up without move. And if you shrink your last block, you'll get
a gap.
 
> This seems ideal, as it allows the balance between the mmap() region and
> the brk() region to vary for each process, automatically.  What changes
> would be required to the kernel to implement this properly and
> efficiently?  Is there some downside I am missing?

Nobody can call brk() directly from app, as libc may use brk() for
implementing malloc(), and libraries can call malloc. So you have to
create your own allocator on the top of brk() results, and this
allocator must not release memory back to system, as this could
release also chunks you do not own. Writting your allocator on the
top of malloc()ed areas is much better idea.
                                                Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
P.S.: I do not think that your app calls directly brk(). I think that
your app calls malloc with some small number, and libc decides to use
brk() instead of mmap(). And in such case it is bug in your libc that 
it does not use mmap() after brk() fails.
