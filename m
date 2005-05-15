Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVEOO1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVEOO1B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 10:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262830AbVEOO1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 10:27:01 -0400
Received: from colin.muc.de ([193.149.48.1]:265 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262829AbVEOO0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 10:26:44 -0400
Date: 15 May 2005 16:26:43 +0200
Date: Sun, 15 May 2005 16:26:43 +0200
From: Andi Kleen <ak@muc.de>
To: Andy Isaacson <adi@hexapodia.org>
Cc: "Richard F. Rebel" <rrebel@whenu.com>, Gabor MICSKO <gmicsko@szintezis.hu>,
       linux-kernel@vger.kernel.org, mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050515142643.GC94354@muc.de>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de> <20050513212620.GA12522@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513212620.GA12522@hexapodia.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There are three places to cut off the side channel, none of which is
> obviously the right one.
> 1. The HT implementation could do the cache tricks Colin suggested in
>    his paper.  Fairly large performance hit to address a fairly small
>    problem.

As Dean pointed out that is probably not true.

> 2. The OS could do the scheduler tricks to avoid scheduling unfriendly
>    threads on the same core.  You're leaving a lot of the benefit of HT
>    on the floor by doing so.

And probably still lose badly in some workloads.

> 3. Every security-sensitive app can be rigorously audited and re-written
>    to avoid *ever* referencing memory with the address determined by
>    private data.

Sure after it was demonstrated that this attack is actually feasible
in practice. If yes then fix the crypto code, otherwise do nothing.

I have no problem with crypto people being paranoid (that is their
job after all), as long as they don't try to affect non crypto code
in the process. But the later seems to be clearly the case here :-(
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

No, just not do it frequently enough that you leak enough data.
Or add dummy memory references to blend your data.

And then nobody said writing crypto code was easy. It just got a bit
harder today.

It is basically like writing smart card code, where you need
to care about such side channels. The other crypto code writers
just need to care about this too.  They will probably avoid
other timing attacks on cache misses too with this approach. Although 
it is doubtful enough signal is leaked in this way, e.g. if you time the 
performance of a network server with RSA answering over the network -
but you see some data is always leaked - the question is just
if it is enough and accurate data to aid an attacker. The paper
has shown that it is feasible in some cases, but so far the proof
is still out this could be actually replicated in not very controlled
loads. With more noise in the data it becomes harder. And the question
is is the small amount of data with normal background workload
is really useful enough to lead to useful real world attacks. I have
severe doubts on that. Certainly the effidence is not clear enough
for a serious step like disabling an  useful performance enhancement like
HT.

-Andi

P.S.: My personal opinion is that we have a far bigger crypto security
problem on many system due to weak /dev/random seeding on many systems. 
If anything is done it would be better to attack that.


