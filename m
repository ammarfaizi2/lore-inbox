Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311577AbSDIVIO>; Tue, 9 Apr 2002 17:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311594AbSDIVIN>; Tue, 9 Apr 2002 17:08:13 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33328 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311577AbSDIVIM>; Tue, 9 Apr 2002 17:08:12 -0400
Date: Tue, 9 Apr 2002 22:50:16 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andrey Nekrasov <andy@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.19-pre6aa1
Message-ID: <20020409225016.M15656@dualathlon.random>
In-Reply-To: <20020409084335.GA10890@spylog.ru> <3CB2B09C.DF1A0AC2@zip.com.au> <20020409182200.E15656@dualathlon.random> <3CB3380F.FA9456D8@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 11:50:55AM -0700, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Tue, Apr 09, 2002 at 02:13:00AM -0700, Andrew Morton wrote:
> > > Andrey Nekrasov wrote:
> > > >
> > > > ..
> > > > >>EIP; e0115c1c <out_of_line_bug+0/14>   <=====
> > > > Trace; e012069a <copy_page_range+1da/334>
> > > > Trace; e0114caa <copy_mm+222/2bc>
> > > > Trace; e01154b6 <do_fork+42e/744>
> > > > Trace; e0107270 <sys_fork+14/1c>
> > >
> > > hmm.  That out-of-line stuff has obfuscated the trace
> > > a bit.  It died in kunmap_atomic or kmap_atomic, part
> > > of Andrea's pte-highmem additions.
> > >
> > > I guess the out-of-line bug should be if !CONFIG_DEBUG_KERNEL.
> > 
> > I didn't complained yet but the whole point of the BUG() was to get such
> > a printk in the right place. Now the above report is trivial and the
> > debugging check triggered a false positive bugcheck due
> > CONFIG_DEBUG_HIGHMEM=y (I always compile with =n and that's why I didn't
> > triggered it here), but sometime it isn't that easy to find it out, in
> > particular when there are plenty of BUG()s in a row like in
> > page_alloc.c, so I disagree with the merger of the out_of_line_bug in
> > mainline.
> 
> No, you misunderstand.  All the BUG()s in .c files are unchanged.
> 
> out_of_line_bug() is used in one place only:  in inline functions
> which appear in commonly-included header files.

This precise case of oops, was one that could be bitten by more than one
out_of_line_bug in the same function, copy_page_range. I found the
problem by re-reading the source code, certainly not by looking at the C
line where the out_of_line_bug was.

> There are only ten or fifteen out_of_line_bug()s.  We just happened
> to hit one here.  They were added by a process of peering at the 
> kernel image and asking "why does the same string appear 120 times?".

The string duplication is ugly, but dropping the bug line is even
uglier. For embedded systems there was just a "turn off the strings"
compile time switch, for embedded systems the other strings matters as
well.

> Yeah, it's all a bit sad.  It's a workaround for a toolchain shortcoming,
> and it does save 100 to 200 kbytes.  If I'd been smarter I'd have
> passed __LINE__ into out_of_line_bug().  It's only the string which
> is a problem.

that would been much better indeed, the probability of a line collision
in a non obvious place is very low and a push on the stack before
calling the extern function won't grow the size of the kernel image
significantly.

> There is a sneaky new featurette, btw.  We sometimes see BUG
> reports where the reporter failed to report the file-and-line.
> But it's still available in the oops record:
> 
> Code: 0f 0b c2 05 d8 36 92 f0 83 c4 14 5b 5e 5f 5d c3 8d 76 00 8d
>             ^^^^^

Cute, I'll sure make use of this featurette in the future :). (offtopic
with the out-of-line bug though, it still doesn't help there)

Andrea
