Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292328AbSCDMm0>; Mon, 4 Mar 2002 07:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292330AbSCDMmQ>; Mon, 4 Mar 2002 07:42:16 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:40714 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292328AbSCDMl6>;
	Mon, 4 Mar 2002 07:41:58 -0500
Date: Mon, 4 Mar 2002 09:41:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020304032535.F20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203040934100.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Andrea Arcangeli wrote:

> > having to scan two page tables to unmap it.  In theory.  Do you see a hole
> > in that?
>
> Just the fact you never need the reverse lookup during lots of
> important production usages (first that cames to mind is when you have
> enough ram to do your job, all number crunching/fileserving, and most
> servers are setup that way).  This is the whole point. Note that this
> has nothing to do with the "cache" part, this is only about the
> pageout/swapout stage, only a few servers really needs heavy swapout.

Ahhh, but it's not necessarily about making this common case
better. It's about making sure Linux doesn't die horribly in
some worst cases.

The case of "system has more than enough memory" won't suffer
with -rmap anyway since the amount of activity in the VM part
of the system will be relatively low.


> And on the other case (heavy swapout/pageouts like in some hard DBMS
> usage, simualtions and laptops or legacy desktops) we would mostly save
> CPU and reduce complexity, but I really don't see system load during
> heavy pageouts/swapouts yet, so I don't see an obvious need of save cpu
> there either.

The thing here is that -rmap is able to easily balance the
reclaiming of cache with the swapout of anonymous pages.

Even though you tried to get rid of the magic numbers in
the old VM when you introduced your changes, you're already
back up to 4 magic numbers for the cache/swapout balancing.

This is not your fault, being difficult to balance is just
a fundamental property of the partially physical, partially
virtual scanning.


> Infact it maybe rmap will be more useful for things like enabling the full
> pagetable sharing you're suggesting above, rather than for replacing the
> swap_out round robing cycle over the VM. so it might be used only for MM
> internals rather than for VM internals.

Sharing is quite a can of worms, it might be easier to just use
4MB (or 2MB) pages for database shared memory segments and VMAs
where programs want large pages. That will get rid of both the
page tables (and associated locking) and the alignment constraints.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

