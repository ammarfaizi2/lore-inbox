Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263885AbUDVJSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbUDVJSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 05:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbUDVJSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 05:18:42 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:30082 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263885AbUDVJS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 05:18:29 -0400
Date: Thu, 22 Apr 2004 11:18:29 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040422091829.GA3691@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name> <20040415092854.GA28721@wohnheim.fh-wedel.de> <200404220959.14440.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404220959.14440.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 April 2004 09:59:14 +0200, Guillaume Lacôte wrote:
> > Btw, looks like the whole idea is broken.  Consider a block of
> > known-plaintext.  The known plaintext happens to be at the beginning
> > of the block and has more entropy than the blocksize of your block
> > cypher.  Bang, you're dead.
> I am sorry but I failed to understand this problem; could you elaborate on it 
> ? Are you saying that if I have known plaintext that compreses to at least on 
> full block, the problem remains ?

Before: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=107419912024246&w=2
The described attack works against user-friendly passwords.  People
who can remember long strings from /dev/random are safe.

After:
You compressed the known plaintext.  But the compressed known
plaintext remains known plaintext, just shorter.  If it remains longer
than one block of the block cypher, it is still sufficient for a
dictionary attack.  Nothing gained.

And of course it has to be at the beginning of a compression block, so
the offset is known in advance.

> - Now (with dm-crypt) = basically the first 512 bytes are known (apart from 
> iv, see discussion in dm-crypt threads). This termendously helps a 
> brute-force attack (use a cluster to pre-calculate all possible encryptions 
> of these 512 bytes and you are done).
> 
> - What I suggest = 1) grow entropy (this does not solve the above problem)
> 2) interleave random bytes _before_ each (plain) block of data. Bytes are 
> drawn as to make the distribution on Huffman encodings uniform.
> Thus even if you know the plain text, even if it would compress to more than 
> 4kB, since the block starts with random bytes you know nothing about, and 
> since these random bytes have changed the Huffman encoding used to encode the 
> known plain text, I claim that you know about nothing (?).

Ok, that makes the attack a little harder (but not much).  After any
amount of random data, you end up with a random huffman tree, agreed.
Compress another 1k of zeros and see what the huffman tree looks like
now.  There are not too many options, what the compressed data could
look like, right?  Somewhere in the ballpark of 2, 4 or maybe 8.

So now the attack takes twice as long.  Yeah, it helps a little, but
is it really worth the trouble?

> You are perfectly right that Huffman is a poor redundancy fighter and will not 
> always drive the size of data down to its Kolmogorov complexity. The "1k of 
> zeroes" might still be a problem. I agree that a better compression algorithm 
> would be nice, but the problem is that i _need_ to know how draw random bytes 
> so as to make the _compressed_ encoding uniformly distributed.
> >
> > Does the idea still sound sane to you?
> I hope so; what is your opinion ?

I doubt it.  Maybe with a statistical encoding or even with block
sorting followed by statistical encoding, you increase the complexity
by much more than 8.  But without changes, the idea looks pretty
futile.

Jörn

-- 
When in doubt, punt.  When somebody actually complains, go back and fix it...
The 90% solution is a good thing.
-- Rob Landley
