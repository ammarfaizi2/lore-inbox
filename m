Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSKYTmV>; Mon, 25 Nov 2002 14:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265581AbSKYTmV>; Mon, 25 Nov 2002 14:42:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265578AbSKYTmU>; Mon, 25 Nov 2002 14:42:20 -0500
Date: Mon, 25 Nov 2002 11:48:18 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
cc: linux-kernel@vger.kernel.org, <anton@samba.org>, <davem@redhat.com>,
       <ak@muc.de>
Subject: Re: [PATCH] Beginnings of conpat 32 code cleanups
In-Reply-To: <20021123112814.0d315c56.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.44.0211251136530.11666-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 23 Nov 2002, Stephen Rothwell wrote:
> 
> Once more I AM NOT MAKING ANYTHING UP.  I am consolidating existing
> practise.

It's _still_ crap.

The fact is, that a

	unsigned int xxxx

in a <asm-i386/xxxxx.h> file is fine. On asm-i386, "unsigned int" has 
well-defined behaviour, and is a well-defined type within that world.

However, if you consolidate different files from different architectures,
what is acceptable in some random architecture header file is _not_ any
more acceptable in a "consolidated" entry. Suddenly, "unsigned int" has no
well-defined meaning any more, and certainly not something like "long"  
which will sometimes change even on the same architecture depending on
compiler options etc.

THAT is what I'm complaining about. Code sharing without thinking is BAD. 

Get rid of made-up types and clean them up to use well-defined types. The
whole point of your patch was to clan stuff up, no?

In other words: for something like this, don't even bother with strange
types like "__kernel_loffset_t32". The type simply does not make sense.
The only reason we have __kernel_xxxx types is to export architecture-
specific stuff to user space through "types.h", without polluting the
POSIX- mandated namespaces.

For the 32-bit compatibility stuff, that simply doesn't make sense:

 - the types should never be exposed to user space at all on a source 
   level. It's a ABI compatibility thing, not an API compatibility.

   So the "__kernel_xxx" stuff makes no sense, and only shows that 
   somebody was lazy and did some cut-and-paste followed by adding crud
   instead of doing it right (and yeah, that crap was there from before, 
   but don't sell it as a cleanup)

 - the types aren't even architechure-specific any more, since the whole 
   _point_ of your cleanups is to make the compat32 layer generic. So they 
   shouldn't be things like "loff_t" at _all_ (never mind the __kernel_ 
   prefix), they should just be the architecture-independent "u32" or
   "s64" or whatever the compat code uses.

This is why I think the whole file makes zero sense. Yes, people have 
copied crap before. But that doesn't make it any better.

		Linus

