Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVEMVdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVEMVdk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 17:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVEMVbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 17:31:31 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:19318 "EHLO
	straum.hexapodia.org") by vger.kernel.org with ESMTP
	id S261527AbVEMV0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 17:26:43 -0400
Date: Fri, 13 May 2005 14:26:20 -0700
From: Andy Isaacson <adi@hexapodia.org>
To: Andi Kleen <ak@muc.de>
Cc: "Richard F. Rebel" <rrebel@whenu.com>, Gabor MICSKO <gmicsko@szintezis.hu>,
       linux-kernel@vger.kernel.org, mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
Message-ID: <20050513212620.GA12522@hexapodia.org>
References: <1115963481.1723.3.camel@alderaan.trey.hu> <m164xnatpt.fsf@muc.de> <1116009483.4689.803.camel@rebel.corp.whenu.com> <20050513190549.GB47131@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513190549.GB47131@muc.de>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 09:05:49PM +0200, Andi Kleen wrote:
> On Fri, May 13, 2005 at 02:38:03PM -0400, Richard F. Rebel wrote:
> > Why?  It's certainly reasonable to disable it for the time being and
> > even prudent to do so.
> 
> No, i strongly disagree on that. The reasonable thing to do is
> to fix the crypto code which has this vulnerability, not break
> a useful performance enhancement for everybody else.

Pardon me for saying so, but that's bullshit.  You're asking the crypto
guys to give up a 5x performance gain (that's my wild guess) by giving
up all their data-dependent algorithms and contorting their code wildly,
to avoid a microarchitectural problem with Intel's HT implementation.

There are three places to cut off the side channel, none of which is
obviously the right one.
1. The HT implementation could do the cache tricks Colin suggested in
   his paper.  Fairly large performance hit to address a fairly small
   problem.
2. The OS could do the scheduler tricks to avoid scheduling unfriendly
   threads on the same core.  You're leaving a lot of the benefit of HT
   on the floor by doing so.
3. Every security-sensitive app can be rigorously audited and re-written
   to avoid *ever* referencing memory with the address determined by
   private data.

(3) is a complete non-starter.  It's just not feasible to rewrite all
that code.  Furthermore, there's no way to know what code needs to be
rewritten!  (Until someone publishes an advisory, that is...)

Hmm, I can't think of any reason that this technique wouldn't work to
extract information from kernel secrets, as well... 

If SHA has plaintext-dependent memory references, Colin's technique
would enable an adversary to extract the contents of the /dev/random
pools.  I don't *think* SHA does, based on a quick reading of
lib/sha1.c, but someone with an actual clue should probably take a look.

Andi, are you prepared to *require* that no code ever make a memory
reference as a function of a secret?  Because that's what you're
suggesting the crypto people should do.

-andy
