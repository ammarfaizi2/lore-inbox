Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317749AbSGKD1d>; Wed, 10 Jul 2002 23:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317751AbSGKD1d>; Wed, 10 Jul 2002 23:27:33 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:39114 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317749AbSGKD1b>;
	Wed, 10 Jul 2002 23:27:31 -0400
Date: Wed, 10 Jul 2002 23:30:12 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "David S. Miller" <davem@redhat.com>
cc: rusty@rustcorp.com.au, adam@yggdrasil.com, R.E.Wolff@BitWizard.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Rusty's module talk at the Kernel Summit
In-Reply-To: <20020710.194555.88475708.davem@redhat.com>
Message-ID: <Pine.GSO.4.21.0207102311290.6250-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Jul 2002, David S. Miller wrote:

>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Thu, 11 Jul 2002 12:48:30 +1000
> 
>    For God's sake, WHY?  Look at what you're doing to your TLB (and if you
>    made IPv4 a removable module, I'll bet real money you have a bug unless
>    you are *very* *very* clever).
> 
> Modules can be mapped using a large PTE mapping.
> I've been meaning to do this on sparc64 for a long
> time.
> 
> So this TLB argument alone is not sufficient :-)
> I do concur on the "ipv4 as module is difficult to
> get correct" argument however.

Sure, but consider the amount of tricky modules and amount of easy ones.
net/ipv4/*.c _is_ tricky; so much that having system with many parts of
such complexity would be extremely painful.

IOW, yes, we have some very tricky interfaces between the parts of kernel;
and their trickiness alone guarantees that we don't want to have them
breeding.  Stuff that genuinely needs complex interfaces is *not* something
you want to be mass-produced.

Do we need to disable rmmod when
	a) 90-odd percents of modules can be handled safely and
	b) any module that wants to prevent rmmod on itself can do that
with one line in its init_module() (add MOD_INC_USE_COUNT; and that's it)?

Notice that generic netfilter module and, say it, driver that provides
a character device are very different beasts.  The latter can be easily
handled in safe way; it has simple use model and very few places in
core code that need to take care of the things - at once for all such
modules.  The former is much trickier.  The thing being, there are
hundreds of simple modules and a dozen or so tricky ones.  And as the
time goes the ratio will only increase, presuming that we want some
sanity for the tree.  With complex interfaces .text is not the only
thing that needs nontrivial protection, to put it mildly.

I'd rather get the simple (== large) classes into decent shape and then
deal with what's left.  FVO "deal" possibly including "no rmmod for these
guys".

