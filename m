Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbTEaHtR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 03:49:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264203AbTEaHtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 03:49:17 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:36876 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S264200AbTEaHtP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 03:49:15 -0400
Date: Sat, 31 May 2003 10:02:05 +0200
From: Willy TARREAU <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: scrosby@cs.rice.edu, alexander.riesen@synopsys.COM,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
Message-ID: <20030531080205.GA776@pcw.home.local>
References: <20030530085901.GB11885@Synopsys.COM> <20030530.020040.52897577.davem@redhat.com> <oydd6i04gq8.fsf@bert.cs.rice.edu> <20030530.231813.59666274.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030530.231813.59666274.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, May 30, 2003 at 11:18:13PM -0700, David S. Miller wrote:
> It turns out to not be the case at all.  There is too much work
> involved in the main loop just maintaining the 3-word + curbyte
> state.
> 
> It needs to be optimized a bit.

With this simple change, jhash_mix is *exactly* three times faster for me
on athlon-xp, whatever gcc I use (2.95.3 or 3.2.3), on the following do_hash()
function, and about 40% faster when used on local variables. I think that
gcc is not always smart enough to avoid assignments, and consumes memory
bandwidth and perhaps prevents better optimizations.

void do_hash(unsigned *a, unsigned *b, unsigned *c) {
   __jhash_mix(*a, *b, *c);
}

This function is 189 bytes long, and takes about 72 cycles to complete with the
original macro, and is now 130 bytes long for about 24 cycles, which means about
1.5 operation/cycle... not bad :-)

I've just tested on other architectures, it's even more interesting :

- On a sparc ultra2/400, 100 million hashes drop from 38.8 seconds to 8.28 s (4.68x)
- And the best win : on Alpha EV6/466, it goes from 51.5 secs to 5.75 s (8.96x) !!!

I've checked that the results are the same on every arch, before and after the
modification.

I believe it's trivial enough to go into 2.4.21, don't you think ?

Regards,
Willy

--- linux-2.4/include/linux/jhash.h	Sat May 10 11:36:02 2003
+++ /tmp/jhash.h	Sat May 31 09:38:17 2003
@@ -23,15 +23,15 @@
 /* NOTE: Arguments are modified. */
 #define __jhash_mix(a, b, c) \
 { \
-  a -= b; a -= c; a ^= (c>>13); \
-  b -= c; b -= a; b ^= (a<<8); \
-  c -= a; c -= b; c ^= (b>>13); \
-  a -= b; a -= c; a ^= (c>>12);  \
-  b -= c; b -= a; b ^= (a<<16); \
-  c -= a; c -= b; c ^= (b>>5); \
-  a -= b; a -= c; a ^= (c>>3);  \
-  b -= c; b -= a; b ^= (a<<10); \
-  c -= a; c -= b; c ^= (b>>15); \
+  a = (a - b - c) ^ (c>>13); \
+  b = (b - c - a) ^ (a<<8); \
+  c = (c - a - b) ^ (b>>13); \
+  a = (a - b - c) ^ (c>>12);  \
+  b = (b - c - a) ^ (a<<16); \
+  c = (c - a - b) ^ (b>>5); \
+  a = (a - b - c) ^ (c>>3);  \
+  b = (b - c - a) ^ (a<<10); \
+  c = (c - a - b) ^ (b>>15); \
 }
 
 /* The golden ration: an arbitrary value */
