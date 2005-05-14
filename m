Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVENAnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVENAnI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262642AbVENAmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:42:00 -0400
Received: from twinlark.arctic.org ([207.7.145.18]:14976 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP id S262651AbVENAj3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:39:29 -0400
Date: Fri, 13 May 2005 17:39:25 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andy Isaacson <adi@hexapodia.org>
cc: Andi Kleen <ak@muc.de>, "Richard F. Rebel" <rrebel@whenu.com>,
       Gabor MICSKO <gmicsko@szintezis.hu>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, tytso@mit.edu
Subject: Re: Hyper-Threading Vulnerability
In-Reply-To: <20050513212620.GA12522@hexapodia.org>
Message-ID: <Pine.LNX.4.62.0505131701450.31431@twinlark.arctic.org>
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

i think your wild guess is way off.  i can think of several approaches to 
fix these problems which won't be anywhere near 5x.

the problem is that an attacker can observe which cache indices (rows) are 
in use.  one workaround is to overload the possible secrets which each 
index represents.

you can overload the secrets in each cache line:  for example when doing 
exponentiation there is an array of bignums x**(2*n).  bignums themselves 
are arrays (which span multiple cache lines).  do a "row/column transpose" 
on this array of arrays -- suddenly each cache line contains a number of 
possible secrets.  if you're operating with 32-bit words in a 64 byte line 
then you've achieved a 16-fold reduction in exposed information by this 
transpose.  there'll be almost no performance penalty.

you can overload the secrets in each cache index:  abuse the associativity 
of the cache.  the affected processors are all 8-way associative.  
ideally you'd want to arrange your data so that it all collides within the 
same cache index -- and get an 8-fold reduction in exposure.  the trick 
here is the L2 is physically indexed, and userland code can perform only 
virtual allocations.  but it's not too hard to discover physical conflicts 
if you really want to (using rdtsc) -- it would be done early in the 
initialization of the program because it involves asking for enough memory 
until the kernel gives you enough colliding pages.  (a system call could 
help with this if we really wanted it.)

my not-so-wild guess is a 128-fold reduction for less than 10% perf hit...

i think there's possibly another approach involving a permuted array of 
indirection pointers... which is going to affect perf a bit due to the 
extra indirection required, but we're talking <10% here.  (i'm just not 
convinced yet you can select a permutation in a manner which doesn't leak 
information when the attacker can view multiple invocations of the crypto 
for example.)


> If SHA has plaintext-dependent memory references, Colin's technique
> would enable an adversary to extract the contents of the /dev/random
> pools.  I don't *think* SHA does, based on a quick reading of
> lib/sha1.c, but someone with an actual clue should probably take a look.

the SHA family do not have any data-dependencies in their memory access 
patterns.

-dean
