Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263991AbUDVMP5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263991AbUDVMP5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 08:15:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263992AbUDVMP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 08:15:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:59283 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263991AbUDVMPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 08:15:49 -0400
Date: Thu, 22 Apr 2004 14:15:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040422121549.GD3691@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name> <200404220959.14440.Guillaume@Lacote.name> <20040422091829.GA3691@wohnheim.fh-wedel.de> <200404221220.08987.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404221220.08987.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 April 2004 12:20:08 +0200, Guillaume Lacôte wrote:
> 
> > After:
> > And of course it has to be at the beginning of a compression block, so
> > the offset is known in advance.
> OK, but this is not the case anymore if you insert random bytes first (?).
> Where does the encrypted non-random data start ? This depends on the huffman 
> encoding, which you know nothing about.

True.  But since the data is random, chances are it is impossible to
compress, so guessing the compressed data should be feasible.  The
guess could be off by a few bits, but again, this makes the attack
harder by just a small factor.

Yeah, in the end, all small factors can multiply so something quite
sufficient.

> a) the attacker stills knows nothing about the rest of the tree (ie what the 
> encoding of all other bits are). Basically to construct T2 you take T1, let 
> "0" be the coding of "0", and prefix the code of all other bytes with a "1".

Too complicated.  Figure out, where to find a block of encrypted
zeros, then look it up in a dictionary.  If that is successful, you
have the key, full stop.

The attacker could even look for the most common block (or the 100
most common blocks), do a dictionary attack on those and afterwards
guess if the plaintext is all zeros, all ones or something similar.

> b) the attacker does not know (?) where the real data starts in the enciphered 
> stream, since Huffman is variable-length. 

What if the known plaintext is all zeros and compressed known
plaintext is longer than two encryption blocks?  There will be one
block containing only compressed zeros.

> c) it is sufficient to ensure that not (p >> n). This is easily satistifed if 
> the expectation of n is in the order of one block size, since at most p < 
> block_size. 

Block_size is confusing.  Encryption block?  Compression block?
Either way, even with p << n, you end up with, at most, 512 different
encodings for a zero.  Again, 2, 4 or 8 are much more realistic.

> Could you detail what you mean with statistical encoding ? Thank you in 
> advance, Guillaume.

Sorry, I meant arithmetical encoding.  Statistical is the superset for
huffman (discrete) and arithmetic (continuous).

http://dogma.net/markn/articles/arith/part1.htm

Jörn

PS: To shorten this endless story, all you're trying to accomplish to
avoid dictionary attack on known plaintext.  Those attack are
meaningless, as long as the encryption key is strong enough.  So
use a true random key end be done with it.

And if you care about usability as well, store the key along with the
encrypted data, but encrypt the key with the digest of a simple
password.  That is prone to dictionary attacks, but since it only
encrypts true random data (the real key), you're safe again.

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
