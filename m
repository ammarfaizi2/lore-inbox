Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRLQQLT>; Mon, 17 Dec 2001 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRLQQLJ>; Mon, 17 Dec 2001 11:11:09 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17200 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S281077AbRLQQK5>; Mon, 17 Dec 2001 11:10:57 -0500
Date: Mon, 17 Dec 2001 17:10:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Victor Yodaiken <yodaiken@fsmlabs.com>
Cc: Ingo Molnar <mingo@elte.hu>, Benjamin LaHaise <bcrl@redhat.com>,
        Rik van Riel <riel@conectiva.com.br>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
Message-ID: <20011217171018.D2431@athlon.random>
In-Reply-To: <20011215134711.A30548@redhat.com> <Pine.LNX.4.33.0112152235340.26748-100000@localhost.localdomain> <20011217160426.U2431@athlon.random> <20011217083802.A25219@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011217083802.A25219@hq2>; from yodaiken@fsmlabs.com on Mon, Dec 17, 2001 at 08:38:02AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2001 at 08:38:02AM -0700, Victor Yodaiken wrote:
> On Mon, Dec 17, 2001 at 04:04:26PM +0100, Andrea Arcangeli wrote:
> > If somebody wants such 1% of ram back he can buy another dimm of ram and
> > plug it into his hardware. I mean such 1% of ram lost is something that
> > can be solved by throwing a few euros into the hardware (and people buys
> > gigabyte boxes anyways so they don't need all of the 100% of ram), the
> > other complexy cannot be solved with a few euros, that can only be
> > solved with lots braincycles and it would be a maintainance work as
> > well. Abstraction and layering definitely helps cutting down the
> > complexity of the code.
> 
> I agree with all your arguments up to here. But being able to run Linux
> in 4Meg or even 8M is important to a very large class of applications. 
> Even if you are concerned mostly about bigger systems, making sure NT
> remains at a serious disadvantage in the embedded boxes is key because
> MS will certainly hope to use control of SOHO routers, set-top boxes
> etc to set "standards" that will improve their competitivity in desktop
> and beyond. It would be a delicious irony if MS were able to re-use
> against Linux the "first control low end" strategy that allowed them 
> vaporize the old line UNIXes, but irony is not as satisfying as winning.

I may been misleading mentionin a 1%, the 1% doesn't mean a 1% of ram is
wasted (otherwise adding a new dimm couldn't solve it because you would
waste even more ram :). As Ingo also mentioned, it's a fixed amount of
ram that is wasted in the mempool.

For very low end machines you can simply define a very small mempool, it
will potentially reduce scalability during heavy I/O with mem shortage
but it will waste very very little ram (potentially in the simpler case
you only need 1 entry in the pool to guarantee deadlock avoidance).  And
there's nearly nothing to worry about, we always had those mempools
since 2.0 at least, look at buffer.c and search for the async argument
to the functions allocating the bhs. Now with the bio we have more
mempools because lots of people still uses the bh, so in the short term
(before 2.6) we can waste some more byte, but once the bh and
ll_rw_block will be dead most of the bio overhead will go away and we'll
only hold the advantages of doing I/O in more than one page with a
single metadata entity (2.6). The other obvious advantage of the mempool
code is that we share it across all the mempool users, so we'll save
some byte of icache too by avoiding code duplication compared to 2.4 too :).

Infact the solution 2) cannot solve your 4M/8M boot problem either,
since such memory would need to be resrved anyways, and it could act
only as clean filesystem cache. So in short the only difference between 1) and
2) would be a little more of fs cache in solution 2) but with an huge
implementation complexity and local_save_irq all over the place in the
VM so with lower performance. It wouldn't make a difference in
functionality (boot or not boot, this is the real problem you worry
about :).

Andrea
