Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287347AbRL3GmD>; Sun, 30 Dec 2001 01:42:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287348AbRL3Glx>; Sun, 30 Dec 2001 01:41:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:32272 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287347AbRL3Gli>; Sun, 30 Dec 2001 01:41:38 -0500
Message-ID: <3C2EB656.10B5FF26@zip.com.au>
Date: Sat, 29 Dec 2001 22:38:14 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        torrey.hoffman@myrio.com, linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: ramdisk corruption problems - was: RE: pivot_root and initrd kern  
 el panic woes
In-Reply-To: <3C2EB208.B2BA7CBF@zip.com.au> <Pine.GSO.4.21.0112300129060.8523-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sat, 29 Dec 2001, Andrew Morton wrote:
> 
> > Would it be necessary to preallocate the holes at mmap() time?  Mad
> > hand-waving: Could we not perform the instantiation at pagefault time,
> > and give the caller SIGBUS if we cannot allocate the blocks?  Or if
> > there's an IO error, or quota exceeded.
> 
> Allocation at mmap() Is Not Going To Happen.  Consider it vetoed.
> There are applications that use mmap() on large and very sparse
> files.

I think Andrea was referring to simply reserving the necessary
amount of disk space, rather than actually instantiating the
blocks.  But even that would be a big problem for the applications
which you describe.

> > Question: can someone please define BH_New?  Its lifecycle seems
> > very vague.  We never actually seem to *clear* it anywhere for
> > ext2, and it appears that the kernel will keep on treating a
> > clearly non-new buffer as "new" all the time.  ext3 explicitly
> > clears BH_New in get_block(), if it finds the block was already
> > present in the file.  I did this because we need the newness
> > info for internal purposes.
> 
> It should be reset when we submit IO.

well...  It isn't.  And I'd like a chance to review/test any
proposed changes in this area which are outside specific filesystems...

> Breakage related to failing allocation is indeed not new, but
> that's a long story.  And no, "allocate on mmap()" is not a fix.

Yup.  But what *is* the fix?  (filemap_nopage?)

-
