Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262739AbUCJR2b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 12:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262737AbUCJR2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 12:28:31 -0500
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:12999 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262739AbUCJR2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 12:28:24 -0500
Date: Wed, 10 Mar 2004 18:28:00 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       corliss@digitalmages.com, riel@redhat.com, jerj@coplanar.net
Subject: Re: [PATCH] 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <1078936898.2232.571.camel@cube>
Message-ID: <Pine.LNX.4.53.0403101744020.15085@gockel.physik3.uni-rostock.de>
References: <1078883951.2232.501.camel@cube> 
 <Pine.LNX.4.53.0403100940240.12833@gockel.physik3.uni-rostock.de>
 <1078936898.2232.571.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2004, Albert Cahalan wrote:

> In that case, don't forget to upgrade atop.
> That's a version of top that uses BSD process
> accounting to grab the transient processes
> that wouldn't be seen in /proc before they die.

OK, thanks for the reference. I wonder what other packages use 
BSD accounting.

> 
> >> When fixing it, note that a 5-bit binary exponent
> >> with denormals would beat the current float format.
> > 
> > Yes, but only by a short head.
> 
> It's by 8 bits, with a stable 11-bit fraction
> instead of a 10-bit to 12-bit variable-size one.
> 
> old: 1xxxxxxxxxxyy000000000000000000000
> new: 1xxxxxxxxxxx000000000000000000000000000000
> 
> That's a 42-bit number instead of a 36-bit one.

Huh, are we talking about the same format? I think comp_t rather looks
like this:

  eeemmmmmmmmmmmmm

i.e., three bit (base 8) exponent, followed by 13 bits mantissa.
mantissa is right-aligned, so I don't understand why you are talking 
about denormals at all.
The base 8 exponent indeed wastes up to two bits of the mantissa, but it
saves two bits of the exponent, so it's as good in the worst case and
gains one bit of precision on average.
The largest representable number (as I see it) is only (2^13-1) * 8^7
= 0x3ffe00000, i.e. a 34 bit number.

What's wrong with my view?

> The old base-8 exponent is wasteful, plus the old
> format stores the leading 1 instead of using an
> implied 1 and special exponent for leading 0.

I really don't know which leading 1 you are talking about.

> > get more precision? (e.g. 16 bit mantissa and 4 bit base-whatever 
> > exponent?) 
> 
> a. just what I said
> b. 32-bit IEEE float (easy enough to encode by hand)

great idea - it even allows to keep source code compatibility with
(at least) the GNU acct tools!

> c. raw data -- is the space saving all that critical?

No, but I think it's just not worth expanding struct acct.

> d. raw data with gzip-style compression
> 
> (note that gzip's deflate algorithm is in the kernel)

too unpredictable, I think.

e. suddenly pops to my mind:  #define AHZ 10      /* ;-) */ 
   but b. seems superior to me as it increases precision as well and
   we can afford it.

> > Yep, but depending on architecure I think the compiler is free to insert
> > the padding either before or after ac_flags.
> 
> I doubt it. I think the C standard has something to
> say about this.

I'd guess I'll have to update my K&R to ANSI on that...

> In any case, I just checked a mix of
> big-endian and little-endian boxes:
> 
> 32-bit BE SPARC
> 64-bit BE SPARC
> 32-bit BE PowerPC
> 32-bit LE i386
> 64-bit LE x86-64
> 64-bit LE Alpha
> 
> In every case, 1-byte padding came after ac_flag.

That sounds good. A version magic at the beginning of the struct would
allow us to extend it more easily.

Tim
