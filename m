Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVEOOBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVEOOBI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVEOOBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:01:07 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:1202 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261634AbVEOOAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:00:52 -0400
Date: Sun, 15 May 2005 16:00:52 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <20050513212620.GA12522@hexapodia.org>
Message-ID: <Pine.LNX.4.58.0505151551161.8633@artax.karlin.mff.cuni.cz>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de>
 <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de>
 <20050513212620.GA12522@hexapodia.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 May 2005, Andy Isaacson wrote:

> On Fri, May 13, 2005 at 09:05:49PM +0200, Andi Kleen wrote:
> > On Fri, May 13, 2005 at 02:38:03PM -0400, Richard F. Rebel wrote:
> > > Why?  It's certainly reasonable to disable it for the time being and
> > > even prudent to do so.
> >
> > No, i strongly disagree on that. The reasonable thing to do is
> > to fix the crypto code which has this vulnerability, not break
> > a useful performance enhancement for everybody else.
>
> Pardon me for saying so, but that's bullshit.  You're asking the crypto
> guys to give up a 5x performance gain (that's my wild guess) by giving
> up all their data-dependent algorithms and contorting their code wildly,
> to avoid a microarchitectural problem with Intel's HT implementation.

That information leak can be exploited not only on HT or SMP, but on any
CPU with L2 cache. Without HT it's much harder to get information about L2
cache footprint, but it's still possible. If an attacker can make
unlimited number of connections to ssh or http server and manages to get 1
bit in 100 connections, it's still a problem.

Possible solutions:
1) don't use branches and data-dependent memory accesses depending on
secret data
2) flush cache completely when switching to process with different EUID
(0.2ms on Pentium 4 with 1M cache, even worse on CPUs with more cache).

Disabling HT/SMP is not a solution. A year later someone may come with
something like this:
* prefill L2 cache with known pattern
* sleep on some precious timer
* make connection to security application (ssh, https)
* on wakeup, read what's in L2 cache --- get one bit with small
probability --- but when repeated many times, it's still a problem

Mikulas

> There are three places to cut off the side channel, none of which is
> obviously the right one.
> 1. The HT implementation could do the cache tricks Colin suggested in
>    his paper.  Fairly large performance hit to address a fairly small
>    problem.
> 2. The OS could do the scheduler tricks to avoid scheduling unfriendly
>    threads on the same core.  You're leaving a lot of the benefit of HT
>    on the floor by doing so.
> 3. Every security-sensitive app can be rigorously audited and re-written
>    to avoid *ever* referencing memory with the address determined by
>    private data.
>
> (3) is a complete non-starter.  It's just not feasible to rewrite all
> that code.  Furthermore, there's no way to know what code needs to be
> rewritten!  (Until someone publishes an advisory, that is...)
>
> Hmm, I can't think of any reason that this technique wouldn't work to
> extract information from kernel secrets, as well...
>
> If SHA has plaintext-dependent memory references, Colin's technique
> would enable an adversary to extract the contents of the /dev/random
> pools.  I don't *think* SHA does, based on a quick reading of
> lib/sha1.c, but someone with an actual clue should probably take a look.
>
> Andi, are you prepared to *require* that no code ever make a memory
> reference as a function of a secret?  Because that's what you're
> suggesting the crypto people should do.
>
> -andy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
