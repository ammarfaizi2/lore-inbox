Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263741AbUDVIBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUDVIBG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 04:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263740AbUDVIBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 04:01:05 -0400
Received: from p4.ensae.fr ([195.6.240.202]:40656 "EHLO pc809.ensae.fr")
	by vger.kernel.org with ESMTP id S263853AbUDVH7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:59:18 -0400
From: Guillaume =?iso-8859-1?q?Lac=F4te?= <Guillaume@Lacote.name>
Reply-To: Guillaume@Lacote.name
Organization: Guillaume@Lacote.name
To: =?iso-8859-1?q?J=F6rn=20Engel?= <joern@wohnheim.fh-wedel.de>
Subject: Re: Using compression before encryption in device-mapper
Date: Thu, 22 Apr 2004 09:59:14 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Linux@glacote.com
References: <200404131744.40098.Guillaume@Lacote.name> <20040415092854.GA28721@wohnheim.fh-wedel.de>
In-Reply-To: <20040415092854.GA28721@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404220959.14440.Guillaume@Lacote.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your feed-back and sorry for my late answer (just back from 
holidays).
> Btw, looks like the whole idea is broken.  Consider a block of
> known-plaintext.  The known plaintext happens to be at the beginning
> of the block and has more entropy than the blocksize of your block
> cypher.  Bang, you're dead.
I am sorry but I failed to understand this problem; could you elaborate on it 
? Are you saying that if I have known plaintext that compreses to at least on 
full block, the problem remains ?

- Now (with dm-crypt) = basically the first 512 bytes are known (apart from 
iv, see discussion in dm-crypt threads). This termendously helps a 
brute-force attack (use a cluster to pre-calculate all possible encryptions 
of these 512 bytes and you are done).

- What I suggest = 1) grow entropy (this does not solve the above problem)
2) interleave random bytes _before_ each (plain) block of data. Bytes are 
drawn as to make the distribution on Huffman encodings uniform.
Thus even if you know the plain text, even if it would compress to more than 
4kB, since the block starts with random bytes you know nothing about, and 
since these random bytes have changed the Huffman encoding used to encode the 
known plain text, I claim that you know about nothing (?).

Other way to say the same: start by chosing one Huffman encoding among all 
possible 8bit encodings; "write" this encoding, and then write your 
(eventually known) data with this encoding. To "write" the encoding, just 
draw one particular random sequence whose Huffman encoding is the one you 
want (this avoids having a "dictionnary" and any other meta-data in the 
encrypted data).

>
> Your whole approach depends on the fact, that any known plaintext in
> the device is either not at the beginning of the block or has very
> little entropy.  1k of zeroes already has too much entropy if you use
> any form of huffman, so without RLE you're not frequently dead, but
> practically always.
You are perfectly right that Huffman is a poor redundancy fighter and will not 
always drive the size of data down to its Kolmogorov complexity. The "1k of 
zeroes" might still be a problem. I agree that a better compression algorithm 
would be nice, but the problem is that i _need_ to know how draw random bytes 
so as to make the _compressed_ encoding uniformly distributed.
>
> Does the idea still sound sane to you?
I hope so; what is your opinion ?
Guillaume.

