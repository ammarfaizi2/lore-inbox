Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316186AbSEKBBu>; Fri, 10 May 2002 21:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316187AbSEKBBt>; Fri, 10 May 2002 21:01:49 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:13752 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S316186AbSEKBBt>; Fri, 10 May 2002 21:01:49 -0400
Date: Sat, 11 May 2002 02:04:02 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak
In-Reply-To: <Pine.LNX.4.33.0205101457120.22516-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0205110122430.1215-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2002, Linus Torvalds wrote:
> On Fri, 10 May 2002, Hugh Dickins wrote:
> >
> > Could we change the i386 BUG() macro slightly again?
> 
> If it wants to be changed, I'd actually personally prefer it to be changed
> to take an explicit string instead of using the filename/linenr at all.

Aaargh, rerun!  Last time I suggested a tiny mod to get BUG() working
right (not losing the registers in its message display), you had new
ideas of how it could work, saving kernel space; and Andrew implemented
that magnificently.

I thought I was the only one dissatisfied (that a disassembler cannot
make sense of this line number and filename pointer dumped into the
instruction stream after the ud2: laugh at the ingenious instructions
ksymoops shows after the ud2 these days).

> The filename/linenr one has the size problem (those absolute file names
> are _long_), and sucks when you have slight kernel version skew and 
> suddenly the information isn't obviously unambiguous at all.

Absolute filenames are long, yes, but (in 2.4 anyway) few remain:
the .c filenames never came out absolute, always just leafname,
and Andrew has dealt with the vast majority of the .h filenames
from inlines (e.g. by using out_of_line_bug for them).  Does the
2.5 build not work out like that?

It's really 2.4.19 that's worrying me, that a small tweak now
(exchanging line and file) can make the new style much more palatable
to disassemblers; once 2.4.19 is out, it'll be confusing to change
(disassemblers don't ususally need to know the version of what they
are disassembling: no problem for kdb, but a problem for objdump).

> It also sucks for inline functions or other users of BUG that would
> potentially want to have different output.
> 
> In short, I suspect it would be nicer with 
> 
> 	kernel BUG: release_task(current)

Sure there's a case for more info; but maybe that's something else
than the simple BUG() we're used to dropping in wherever; let's fix
up what we've got now, and muse at leisure on what else to provide.

> instead of
> 
> 	kernel BUG at /home/torvalds/v2.5/linux/exit.c:59

I don't see those - exit.c:59 would be all you see in 2.4.19-pre.
"strings vmlinux | grep /home" currently shows me just:

/home/hugh/1908H/include/linux/raid/md_k.h
/home/hugh/1908H/include/linux/nfs_page.h
/home/hugh/1908H/include/linux/nfs_page.h
/home/hugh/1908H/include/linux/nfs_page.h
/home/hugh/1908H/include/linux/nfs_page.h

> (the exact point where the BUG happens _is_ given by the EIP, so in that
> sense file and linenr are not actually all that useful. A descriptive
> string would be more readable, and equally useful at pinpointing at a
> source level).

Hackers have better things to concentrate upon than dreaming up
descriptive strings: the beauty of BUG() is that you can just drop
it in (oops, I was about to say "without thinking").  I don't deny
the case for assertions, but what Andrew provided last time around
is really pretty good, and slips down more easily with the line<->file.

Hugh

