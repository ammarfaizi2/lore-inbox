Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284931AbRLMTOK>; Thu, 13 Dec 2001 14:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284917AbRLMTNu>; Thu, 13 Dec 2001 14:13:50 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:35337 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S284857AbRLMTNr>;
	Thu, 13 Dec 2001 14:13:47 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wayne Whitney <whitney@math.berkeley.edu>
Date: Thu, 13 Dec 2001 20:13:23 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Repost: could ia32 mmap() allocations grow downward?
CC: LKML <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.40
Message-ID: <BE5C85A263E@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Dec 01 at 10:03, Wayne Whitney wrote:
> On Thu, 13 Dec 2001, Petr Vandrovec wrote:
> 
> > Maybe we should move to bug-glibc instead, as there is no way to force
> > stdio to not ignore mallopt() parameters, it still insist on using
> > mmap, and I think that it is a glibc2.2 bug.
> 
> OK, that makes sense for the glibc2 subthread of this discussion.  Would
> you mind submitting the bug report, as you have a better command of the
> issues than I do?  Or if you want, I can do it and just quote you.  :-)

If you can complain yourself...
 
> > P.S.: I did some testing, and about 95% of mremap() allocations is
> > targeted to last VMA, so no VMA move is needed for them. But no Java
> > was part of picture, only c/c++ programs I use - gcc, mc, perl.
> 
> Ah, so this is important data.  It shows that the mmap() grows downward
> strategy will hurt the common case.  I don't have any handle on the
> magnitude of this effect, but if it is significant, then I would have to
> agree that supporting the legacy brk() apps is not as important as keeping
> mremap() of the last VMA cheap.  How expensive is moving a VMA, and how
> often do programs mremap()?

It is not that bad, as only PTEs are moved, but ... currently code calls
mremap(), and in 95% of cases same address is returned, while after
change mremap() changes address in 100% of cases, so couple of bugs 
can be discovered due to this change.
 
> How about the idea of modifying brk() (or adding an alternative) to move
> VMAs out of the way as necessary?  This way the negative impact (of moving
> VMAs) is only borne by the legacy brk() using app.  Or is there some other
> downside that I am missing?

You cannot move VMAs when app does not request mremap(), as you must notify
app about new location of area - app can have couple of pointers to this
memory, so you cannot move it around without app being informed.

And unfortunately you also cannot just skip existing VMAs by brk(), as
userspace remebers latest value returned by brk(), add size to it, and 
calls brk() to grow data segment. As apps decides about new brk() value, 
and app does not know that there is some VMA somewhere, kernel cannot 
do anything about it too - unfortunately.
                                                Petr Vandrovec
                                                vandrove@vc.cvut.cz
                                                
