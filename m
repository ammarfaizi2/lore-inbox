Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267277AbTGHMaK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267292AbTGHMaK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:30:10 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:43781 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267277AbTGHM3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:29:21 -0400
Date: Tue, 8 Jul 2003 13:43:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, Andrew Morton <akpm@osdl.org>,
       Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
Message-ID: <20030708134349.A24432@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jari Ruusu <jari.ruusu@pp.inet.fi>,
	Chris Friesen <cfriesen@nortelnetworks.com>,
	Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl,
	akpm@digeo.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl> <3F0411B9.9E11022D@pp.inet.fi> <20030703082034.5643b336.akpm@osdl.org> <3F04680D.B9703696@pp.inet.fi> <3F046A30.6080509@nortelnetworks.com> <3F05300E.AA26A021@pp.inet.fi> <20030704104134.B9740@infradead.org> <3F068F49.1883BE0D@pp.inet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F068F49.1883BE0D@pp.inet.fi>; from jari.ruusu@pp.inet.fi on Sat, Jul 05, 2003 at 11:41:45AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 11:41:45AM +0300, Jari Ruusu wrote:
> I haven't seen the modified transfer function yet, so no test data on speed
> difference yet. Notice that I said "tiny speed degration". Tiny in this
> context may well mean unmeasurable small. However, it will add mode code to
> optimized implementation. More code == tiny bit slower.

Then I'd suggest reading the suggestion carefully :)  It suggest to:

a) not perform that kmap/kunmap in loop.c before calling the transfer
   function and
b) pass the page frame + offset to the transfer function instead of the
   kernel virtual address

That means for the module implementing the transfer function either

1) a superflous kmap that it doesn't need is gone (cryptoapi case)
2) it needs to perform the kmap previously done by itself. (= no change)
3) it needs to perform the kmap itself but can use kmap_atomic now


> Loop code in loop-AES does not have any significant speed advantage over
> mainline loop. Most significant advantage that loop-AES' loop code has over
> mainline, is that it includes a ton of bug fixes still missing from mainline
> loop.

Well, we already had a discussion about that, and you haven't tried to
split your patch up so it's unacceptable for mainline.  I'm in fact pretty
sure some parts like the bio reservations are buggy but it's hard to tell
excatly with a that big patch.

> Loop-AES' speed advantage comes from optimized AES-only transfer
> function that does the CBC stuff and directly calls highly optimized AES
> implementation without any CryptoAPI overhead.

That's the good old VFS argument.  Of course we could rip out the
VFS and go directly to ext2 but in many cases abstraction have more
advantage than the tiny speed loss they impare.

> This tests only low level cipher functions aes_encrypt() and aes_decrypt()
> from linux-2.5.74/crypto/aes.c with all CryptoAPI overhead removed. In real
> use, including CryptoAPI overhead, these numbers should be a little bit
> smaller.

<snip>

The number is interesting.  It might be worthwile to try embedding your
aes implementations into the CryptoAPI.  Given your negative comments
I suppose you are not interested in something like that?

> I have posted patches to be included in mainline. Fixes are available, and
> if they are not merged, then so be it. If fixes are not merged to mainline,
> they will be maintained outside of mainline so people who need them can
> actually use them. It is not really my failt that mainline people seem to
> prefer buggy loop and slow loop crypto.

So far all loop bugs that have been reported during 2.5 have been fixed.
As for slow crypto:  yes, we prefer the cryptoapi abstraction over
directly going to a single algorithm.  And no one here said he diskliked
your AES implementation, they just haven't been offered yet.  I'm sure
your assembly implementation will be merged once the framework for
optimized crypto algorithms is in place and I'm also pretty sure
we'll find out why your C implementation is faster and either switch the
current implementation for yours or improve it.  It's just that all this
would be a lot easier if you just offered them in a form of a nicely
described do one thing patch instead of moaning from the backside..
