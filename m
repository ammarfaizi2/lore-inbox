Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbTGEI1P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jul 2003 04:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266305AbTGEI1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jul 2003 04:27:15 -0400
Received: from hank-fep8-0.inet.fi ([194.251.242.203]:16019 "EHLO
	fep08.tmt.tele.fi") by vger.kernel.org with ESMTP id S266304AbTGEI1N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jul 2003 04:27:13 -0400
Message-ID: <3F068F49.1883BE0D@pp.inet.fi>
Date: Sat, 05 Jul 2003 11:41:45 +0300
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Chris Friesen <cfriesen@nortelnetworks.com>, Andrew Morton <akpm@osdl.org>,
       Andries.Brouwer@cwi.nl, akpm@digeo.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] cryptoloop
References: <UTC200307021844.h62IiIQ19914.aeb@smtp.cwi.nl> <3F0411B9.9E11022D@pp.inet.fi> <20030703082034.5643b336.akpm@osdl.org> <3F04680D.B9703696@pp.inet.fi> <3F046A30.6080509@nortelnetworks.com> <3F05300E.AA26A021@pp.inet.fi> <20030704104134.B9740@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Jul 04, 2003 at 10:43:10AM +0300, Jari Ruusu wrote:
> > Changing transfer function prototype may be a tiny speed improvement for one
> > implementation that happens to use unoptimal API, but at same time be tiny
> > speed degration to other implementations that use more saner APIs. I am
> > unhappy with that change, because I happen to maintain four such transfers
> > that would be subject to tiny speed degration.
> 
> You've so far only made ubacked claims in this thread.  Show the
> numbers and tell us why your implementation is faster and show the
> numbers and explain why this change should make your module slower.

I haven't seen the modified transfer function yet, so no test data on speed
difference yet. Notice that I said "tiny speed degration". Tiny in this
context may well mean unmeasurable small. However, it will add mode code to
optimized implementation. More code == tiny bit slower.

Loop code in loop-AES does not have any significant speed advantage over
mainline loop. Most significant advantage that loop-AES' loop code has over
mainline, is that it includes a ton of bug fixes still missing from mainline
loop. Loop-AES' speed advantage comes from optimized AES-only transfer
function that does the CBC stuff and directly calls highly optimized AES
implementation without any CryptoAPI overhead. IOW, it does loop -> transfer
-> AES with all unnecessary crap removed. I am complaining because you guys
are about to add unnecessary crap to loop -> transfer interface.

Following tests were run in userspace on my 300 MHz Pentium-2 test box, and
were compiled using Debian woody gcc "version 2.95.4 20011002 (Debian
prerelease)" with these compiler flags: -O2 -Wall -march=i686
-mpreferred-stack-boundary=2 -fomit-frame-pointer

This tests only low level cipher functions aes_encrypt() and aes_decrypt()
from linux-2.5.74/crypto/aes.c with all CryptoAPI overhead removed. In real
use, including CryptoAPI overhead, these numbers should be a little bit
smaller.

key length 128 bits, encrypt speed 68.5 Mbits/sec
key length 128 bits, decrypt speed 58.9 Mbits/sec
key length 192 bits, encrypt speed 58.3 Mbits/sec
key length 192 bits, decrypt speed 50.3 Mbits/sec
key length 256 bits, encrypt speed 51.0 Mbits/sec
key length 256 bits, decrypt speed 43.8 Mbits/sec

This tests aes_encrypt() and aes_decrypt() from loop-AES-v1.7d/aes-i586.S
Most users running loop-AES on modern x86 boxes get to use this code
automatically.

key length 128 bits, encrypt speed 129.6 Mbits/sec
key length 128 bits, decrypt speed 131.3 Mbits/sec
key length 192 bits, encrypt speed 113.0 Mbits/sec
key length 192 bits, decrypt speed 111.7 Mbits/sec
key length 256 bits, encrypt speed 96.2 Mbits/sec
key length 256 bits, decrypt speed 97.5 Mbits/sec

This tests aes_encrypt() and aes_decrypt() from loop-AES-v1.7d/aes.c
Loop-AES users running non-x86 kernels or x86 configured for i386/i486 will
run this version.

key length 128 bits, encrypt speed 81.2 Mbits/sec
key length 128 bits, decrypt speed 83.4 Mbits/sec
key length 192 bits, encrypt speed 68.5 Mbits/sec
key length 192 bits, decrypt speed 70.6 Mbits/sec
key length 256 bits, encrypt speed 58.9 Mbits/sec
key length 256 bits, decrypt speed 60.9 Mbits/sec

> Either try to help improving what's in the tree or shut up.

I have posted patches to be included in mainline. Fixes are available, and
if they are not merged, then so be it. If fixes are not merged to mainline,
they will be maintained outside of mainline so people who need them can
actually use them. It is not really my failt that mainline people seem to
prefer buggy loop and slow loop crypto.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>

