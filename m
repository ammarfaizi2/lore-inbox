Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266007AbTGEJAJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 05:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266023AbTGEJAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 05:00:09 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:18444
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S266007AbTGEJAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 05:00:02 -0400
Date: Sat, 5 Jul 2003 02:10:00 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Jari Ruusu <jari.ruusu@pp.inet.fi>
cc: Christoph Hellwig <hch@infradead.org>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Andrew Morton <akpm@osdl.org>, Andries.Brouwer@cwi.nl, akpm@digeo.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
In-Reply-To: <3F068F49.1883BE0D@pp.inet.fi>
Message-ID: <Pine.LNX.4.10.10307050202100.21771-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jari,

Word of advice from somebody who has been down this road.
Repatch and add in a dual path select, this will provide a security
blanket for the folks who do not understand the entire scope.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Sat, 5 Jul 2003, Jari Ruusu wrote:

> Christoph Hellwig wrote:
> > On Fri, Jul 04, 2003 at 10:43:10AM +0300, Jari Ruusu wrote:
> > > Changing transfer function prototype may be a tiny speed improvement for one
> > > implementation that happens to use unoptimal API, but at same time be tiny
> > > speed degration to other implementations that use more saner APIs. I am
> > > unhappy with that change, because I happen to maintain four such transfers
> > > that would be subject to tiny speed degration.
> > 
> > You've so far only made ubacked claims in this thread.  Show the
> > numbers and tell us why your implementation is faster and show the
> > numbers and explain why this change should make your module slower.
> 
> I haven't seen the modified transfer function yet, so no test data on speed
> difference yet. Notice that I said "tiny speed degration". Tiny in this
> context may well mean unmeasurable small. However, it will add mode code to
> optimized implementation. More code == tiny bit slower.
> 
> Loop code in loop-AES does not have any significant speed advantage over
> mainline loop. Most significant advantage that loop-AES' loop code has over
> mainline, is that it includes a ton of bug fixes still missing from mainline
> loop. Loop-AES' speed advantage comes from optimized AES-only transfer
> function that does the CBC stuff and directly calls highly optimized AES
> implementation without any CryptoAPI overhead. IOW, it does loop -> transfer
> -> AES with all unnecessary crap removed. I am complaining because you guys
> are about to add unnecessary crap to loop -> transfer interface.
> 
> Following tests were run in userspace on my 300 MHz Pentium-2 test box, and
> were compiled using Debian woody gcc "version 2.95.4 20011002 (Debian
> prerelease)" with these compiler flags: -O2 -Wall -march=i686
> -mpreferred-stack-boundary=2 -fomit-frame-pointer
> 
> This tests only low level cipher functions aes_encrypt() and aes_decrypt()
> from linux-2.5.74/crypto/aes.c with all CryptoAPI overhead removed. In real
> use, including CryptoAPI overhead, these numbers should be a little bit
> smaller.
> 
> key length 128 bits, encrypt speed 68.5 Mbits/sec
> key length 128 bits, decrypt speed 58.9 Mbits/sec
> key length 192 bits, encrypt speed 58.3 Mbits/sec
> key length 192 bits, decrypt speed 50.3 Mbits/sec
> key length 256 bits, encrypt speed 51.0 Mbits/sec
> key length 256 bits, decrypt speed 43.8 Mbits/sec
> 
> This tests aes_encrypt() and aes_decrypt() from loop-AES-v1.7d/aes-i586.S
> Most users running loop-AES on modern x86 boxes get to use this code
> automatically.
> 
> key length 128 bits, encrypt speed 129.6 Mbits/sec
> key length 128 bits, decrypt speed 131.3 Mbits/sec
> key length 192 bits, encrypt speed 113.0 Mbits/sec
> key length 192 bits, decrypt speed 111.7 Mbits/sec
> key length 256 bits, encrypt speed 96.2 Mbits/sec
> key length 256 bits, decrypt speed 97.5 Mbits/sec
> 
> This tests aes_encrypt() and aes_decrypt() from loop-AES-v1.7d/aes.c
> Loop-AES users running non-x86 kernels or x86 configured for i386/i486 will
> run this version.
> 
> key length 128 bits, encrypt speed 81.2 Mbits/sec
> key length 128 bits, decrypt speed 83.4 Mbits/sec
> key length 192 bits, encrypt speed 68.5 Mbits/sec
> key length 192 bits, decrypt speed 70.6 Mbits/sec
> key length 256 bits, encrypt speed 58.9 Mbits/sec
> key length 256 bits, decrypt speed 60.9 Mbits/sec
> 
> > Either try to help improving what's in the tree or shut up.
> 
> I have posted patches to be included in mainline. Fixes are available, and
> if they are not merged, then so be it. If fixes are not merged to mainline,
> they will be maintained outside of mainline so people who need them can
> actually use them. It is not really my failt that mainline people seem to
> prefer buggy loop and slow loop crypto.
> 
> Regards,
> Jari Ruusu <jari.ruusu@pp.inet.fi>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

