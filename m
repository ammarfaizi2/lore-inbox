Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264372AbUDVQJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264372AbUDVQJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 12:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUDVQF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 12:05:26 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:22451 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264284AbUDVQB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 12:01:26 -0400
Date: Thu, 22 Apr 2004 18:00:33 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040422160033.GB23746@wohnheim.fh-wedel.de>
References: <200404131744.40098.Guillaume@Lacote.name> <200404221220.08987.Guillaume@Lacote.name> <20040422121549.GD3691@wohnheim.fh-wedel.de> <200404221506.43017.Guillaume@Lacote.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200404221506.43017.Guillaume@Lacote.name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignoring most of your reply...

On Thu, 22 April 2004 15:06:43 +0200, Guillaume Lacôte wrote:
> >
> > The attacker could even look for the most common block (or the 100
> > most common blocks), do a dictionary attack on those and afterwards
> > guess if the plaintext is all zeros, all ones or something similar.
> I do not understand this assertion. What does "look for the most common bloc" 
> mean if you have no clue on which Huffman tree was used to encode them (all 
> Huffman trees are made equi-probable) ? In some of the trees, '0x0' => 
> '00000000', in some other trees '0x0' => '0011', in some others, it gets 
> '00011110100100', etc.

1. Cut up the complete device into chunks of 16 bytes (or whatever your
cipher uses).
2. Add all of those chunks to a huge hash, counting how often they
occur.
3. For the most common ones, try a dictionary attack.

Yeah, sure, the attacker has no idea what the plaintext of those
blocks is, but if they appear often enough, it has to be something
quite common.  Something like, say, all ones or all zeros.  Or like
one of those 48 common huffman encodings thereof.

> OK, maybe I should have made clear that the drawing of random bytes is to be 
> done _at the beginning of each and every block_ (as is done in 
> http://jsam.sourceforge.net).

So what!  You end up with maybe three bits per zero (assuming all
zeros).  Depending on the size of random data up front, they start
with bit 1, 2 or 3.  Makes 3*2^3 or 24 possibilities.  Same for all
ones, give a total of 48.  Great, a dictionary attack is 48x slower
now!

> > > c) it is sufficient to ensure that not (p >> n). This is easily
> > > satistifed if the expectation of n is in the order of one block size,
> > > since at most p < block_size.
> >
> > Block_size is confusing.  Encryption block?  Compression block?
> Sorry about that: I meant plain data block (ie your 4kB of real data).
> This will be written to 5kB of data or so : about 1kB of random bytes, then 
> the data (possibly compressed), everything being encrypted at the end.

Still, towards the end of all-ones or all-zeros, each byte will be
encoded with the same 1-3bit value.

> > Either way, even with p << n, you end up with, at most, 512 different
> > encodings for a zero.  Again, 2, 4 or 8 are much more realistic.
> I fail to understand this: assume I want to encode one huge 4GB file full of 
> zeros. This will lead to 10^6 blocks of size 4kB. On writing each block will 
> be preceeded by its own sequence of random bytes, thus have its own uniformly 
> drawn Huffman encoding. Thus the data feed to the cipher will be different 
> for each block. What have I missed ?

That huffman encodings are discrete, not contiguous.  Towards the end
of each 4k block of zeros, you end up with very few likely encodings.
And those are also stable for quite a while.

> The idea to use a partition of (0,1) to represent codes is that of Kraft; so 
> is the idea to use a real number range to represent the code. However the 
> remark that inside such a range (e.g. [0.43046721  ; 0.4782969[ ) , there are
> numbers that have a low Kolmogorov complexity (eg. 0.45) is neat, though.
> 
> But whatever happens, the optimal length of the encoding will be exactly equal 
> to the total entropy of the message, up to a constant of 1. (see Li and 
> Vitanyi, and Introduction to Kolmogorov complexity, Th. 1.11.2 p 75).
> 
> It can happen than arithmetic encoding comes closer to the optimal encoding 
> than Huffman, but I fail to understand why this should always be the case.

That's just a minor point for you, although still valid.  In almost
all cases, perfect number of bits is not 1, 2, 3, etc. but 2.54, 1.78
and such.  Huffman is unable to do so, which explains why all-ones
compresses to horribly with huffman and so well with just about
anything else.  In almost every case, huffman is worse, just usually
not by that much.

> > PS: To shorten this endless story, all you're trying to accomplish to
> > avoid dictionary attack on known plaintext.  Those attack are
> > meaningless, as long as the encryption key is strong enough.  So
> > use a true random key end be done with it.
> Could you please point me to the relevant litterature on this subject ? I have 
> read the NIST-AES site on this question, but still: if the entropy of the 
> plain text is low, the entropy of the encoded text _will_ be low. I believe 
> entropy is an orthogonal concept. And the lower the entropy, the higher the 
> information. Wether dividing the search space by 4 leads to any practicable 
> speed up in the key search is another matter I believe you. But if I can 
> prevent it alltogether in the first place, why not ?

Sorry, I don't have a document for common sense.  What you are
protecting against is easy guessing of bad keys.  Make the key better
and your whole point is void.

> > And if you care about usability as well, store the key along with the
> > encrypted data, but encrypt the key with the digest of a simple
> > password.  That is prone to dictionary attacks, but since it only
> > encrypts true random data (the real key), you're safe again.
> This is what SuSe has been doing for some time I believe. But this is just 
> another matter. I already assume that the key is random. However the known 
> text is not, and this is my whole problem.

In that case, what's your point.  If the key is strong and the
encryption is strong (I sure hope, AES is), nothing short of brute
force can be successful.  What are you protecting against?

Jörn

-- 
A defeated army first battles and then seeks victory.
-- Sun Tzu
