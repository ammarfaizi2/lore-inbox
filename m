Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUDVNHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUDVNHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 09:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264025AbUDVNHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 09:07:04 -0400
Received: from p4.ensae.fr ([195.6.240.202]:3743 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S264019AbUDVNGr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 09:06:47 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Using compression before encryption in device-mapper
Date: Thu, 22 Apr 2004 15:06:43 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <200404221220.08987.Guillaume@Lacote.name> <20040422121549.GD3691@wohnheim.fh-wedel.de>
In-Reply-To: <20040422121549.GD3691@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404221506.43017.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for continuing this discussion.
>
> True.  But since the data is random, chances are it is impossible to
> compress, so guessing the compressed data should be feasible.  The
> guess could be off by a few bits, but again, this makes the attack
> harder by just a small factor.
Not exactly; the random bytes are _not_ drawn uniformly; they are drawn so as 
to make the distribution on Huffman trees uniform.

The rough algorithm is as follows:

1) set up the weight of each of the 256 possible bytes. If you want byte x to 
have a Huffman code of length k, let its weight be 2^k .

2) now draw a sequence of n bytes with these weights; have n be sufficiently 
high so that with high probability the empirical distribution of the bytes 
you have actually drawn is close to the theoretical one. This ensures that 
the resulting Huffman tree will be close to the one you wanted. This is done 
through the Central Limit Theorem.

So the actual random sequence _will_ most often be highly compressible. The 
point is that all binary sequences that correspond to a possible Huffman tree 
are equiprobable. This maximizes the entropy (ie this minimizes the 
information known to the attacker).

>
> > a) the attacker stills knows nothing about the rest of the tree (ie what
> > the encoding of all other bits are). Basically to construct T2 you take
> > T1, let "0" be the coding of "0", and prefix the code of all other bytes
> > with a "1".
>
> Too complicated.  Figure out, where to find a block of encrypted
> zeros, then look it up in a dictionary.  If that is successful, you
> have the key, full stop.
OK; my whole point is that it is difficult to "figure out, where to find a 
block of encrypted zeros". I hope to make this as difficult as to first crack 
the preceding sequence of random bytes. Which is, by design, only feasible by 
brute force.
I may be wrong on this. So assume I have stored 4kB of zeros.
What you have is the following:
L1 =  n bytes of random bytes
L2 = the 4kB of zeros, compressed with the dynamic Huffman tree after L1, then 
enciphered.
You do not know n, nor the actual sequence of bytes I have drawn, nor the 
secret key. How do you do (I do not claim this is not possible although I 
hope so, I just would like to understand) ?

>
> The attacker could even look for the most common block (or the 100
> most common blocks), do a dictionary attack on those and afterwards
> guess if the plaintext is all zeros, all ones or something similar.
I do not understand this assertion. What does "look for the most common bloc" 
mean if you have no clue on which Huffman tree was used to encode them (all 
Huffman trees are made equi-probable) ? In some of the trees, '0x0' => 
'00000000', in some other trees '0x0' => '0011', in some others, it gets 
'00011110100100', etc.

>
> > b) the attacker does not know (?) where the real data starts in the
> > enciphered stream, since Huffman is variable-length.
>
> What if the known plaintext is all zeros and compressed known
> plaintext is longer than two encryption blocks?  There will be one
> block containing only compressed zeros.
OK, maybe I should have made clear that the drawing of random bytes is to be 
done _at the beginning of each and every block_ (as is done in 
http://jsam.sourceforge.net).

> > c) it is sufficient to ensure that not (p >> n). This is easily
> > satistifed if the expectation of n is in the order of one block size,
> > since at most p < block_size.
>
> Block_size is confusing.  Encryption block?  Compression block?
Sorry about that: I meant plain data block (ie your 4kB of real data).
This will be written to 5kB of data or so : about 1kB of random bytes, then 
the data (possibly compressed), everything being encrypted at the end.

> Either way, even with p << n, you end up with, at most, 512 different
> encodings for a zero.  Again, 2, 4 or 8 are much more realistic.
I fail to understand this: assume I want to encode one huge 4GB file full of 
zeros. This will lead to 10^6 blocks of size 4kB. On writing each block will 
be preceeded by its own sequence of random bytes, thus have its own uniformly 
drawn Huffman encoding. Thus the data feed to the cipher will be different 
for each block. What have I missed ?

>
> > Could you detail what you mean with statistical encoding ? Thank you in
> > advance, Guillaume.
>
> Sorry, I meant arithmetical encoding.  Statistical is the superset for
> huffman (discrete) and arithmetic (continuous).
>
> http://dogma.net/markn/articles/arith/part1.htm
Thank you for the link.
The idea to use a partition of (0,1) to represent codes is that of Kraft; so 
is the idea to use a real number range to represent the code. However the 
remark that inside such a range (e.g. [0.43046721  ; 0.4782969[ ) , there are
numbers that have a low Kolmogorov complexity (eg. 0.45) is neat, though.

But whatever happens, the optimal length of the encoding will be exactly equal 
to the total entropy of the message, up to a constant of 1. (see Li and 
Vitanyi, and Introduction to Kolmogorov complexity, Th. 1.11.2 p 75).

It can happen than arithmetic encoding comes closer to the optimal encoding 
than Huffman, but I fail to understand why this should always be the case.

But it holds for sure that Huffman encoding, especially adaptive, will _not_ 
always achieve it either.
>
> Jörn
>
> PS: To shorten this endless story, all you're trying to accomplish to
> avoid dictionary attack on known plaintext.  Those attack are
> meaningless, as long as the encryption key is strong enough.  So
> use a true random key end be done with it.
Could you please point me to the relevant litterature on this subject ? I have 
read the NIST-AES site on this question, but still: if the entropy of the 
plain text is low, the entropy of the encoded text _will_ be low. I believe 
entropy is an orthogonal concept. And the lower the entropy, the higher the 
information. Wether dividing the search space by 4 leads to any practicable 
speed up in the key search is another matter I believe you. But if I can 
prevent it alltogether in the first place, why not ?

>
> And if you care about usability as well, store the key along with the
> encrypted data, but encrypt the key with the digest of a simple
> password.  That is prone to dictionary attacks, but since it only
> encrypts true random data (the real key), you're safe again.
This is what SuSe has been doing for some time I believe. But this is just 
another matter. I already assume that the key is random. However the known 
text is not, and this is my whole problem.

Thank you for your time, and feel free not to answer if you feel bored ...
Guillaume.

