Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbSAUMDP>; Mon, 21 Jan 2002 07:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285023AbSAUMDG>; Mon, 21 Jan 2002 07:03:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:5380 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284902AbSAUMC6>;
	Mon, 21 Jan 2002 07:02:58 -0500
Date: Mon, 21 Jan 2002 10:02:41 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Adam Kropelin <akropel1@rochester.rr.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18pre3-ac1
In-Reply-To: <m1zo38faql.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.33L.0201210945350.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Jan 2002, Eric W. Biederman wrote:

> Currently the rmap patch triples the size of the page tables which is
> also an issue.  Though it is relatively straight forward to reduce
> that to simply double the page table size with a order(1) allocation,
> so we can remove one pointer.

Actually most processes seem to be much smaller than 4 MB
_and_ have their pages spread out over their address space.

This means the page tables are sparsely populated and the
pte_chain mechanism should use less memory than doubling
the size of the page tables.

> Unless I am mistaken an every day shell script is fairly fork/exec/exit
> intensive operation.  And there are probably more shell scripts for
> unix than every other kind of program put together.

Bash and gcc seem to use vfork, not sure about make...

> An additional possible strike against rmap is that walking through
> page tables in virtual address order is fairly cache friendly, while a
> random walk has more of a cache penalty.

In theory. In practice however kswapd seems to use less CPU
with the -rmap VM, most notably in doesn't seem to get lost
in the worst case behaviour of the normal VM where it scans
hundreds of megabytes of normal memory because it has a DMA
zone shortage...

> One more case that is difficult for rmap is the highly mapped case of
> something like glibc.  You can easily get to a thousand entries or
> more for a single page.  In which case a doubly linked list may be
> more appropriate then a singly linked list (for add/insert), but this
> again tripples or quadruples the page table size.  And none of it
> solves having to walk very long lists in some circumstances.   The
> best you can do is periodically unmapping pages, and then you only
> have very long lists for highly active pages.

I admit this could be an issue. It would be interesting to see
if it is an issue in practice though...

> And to be fair rmap has some advantages over the current system.  VM
> algorithms are some simpler to code when you can code them however
> you want to, instead of being constrained by other parts of the
> implementation.
>
> To the true sceptic what remains to be shown is

Well, you could download the patch and look for yourself ;)

	http://surriel.com/patches/
	http://linuxvm.bkbits.net/

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

