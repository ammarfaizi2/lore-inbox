Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129291AbRBWVpz>; Fri, 23 Feb 2001 16:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129382AbRBWVpq>; Fri, 23 Feb 2001 16:45:46 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:522 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129291AbRBWVpg>;
	Fri, 23 Feb 2001 16:45:36 -0500
Message-Id: <200102232143.f1NLhG202360@sucky.fish>
Subject: Re: [rfc] Near-constant time directory index for Ext2
From: Ralph Loader <suckfish@ihug.co.nz>
To: Andries.Brouwer@cwi.nl
Cc: Linux-kernel@vger.kernel.org, kaih@khms.westfalen.de
In-Reply-To: <UTC200102230152.CAA138669.aeb@vlet.cwi.nl>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 24 Feb 2001 10:43:16 +1300
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I while ago I did some experimentation with simple bit-op based string
hash
functions.  I.e., no multiplications / divides in the hash loop.

The best I found was:

int hash_fn (char * p)
{
  int hash = 0;
  while (*p) {
     hash = hash + *p;
     // Rotate a 31 bit field 7 bits:
     hash = ((hash << 7) | (hash >> 24)) & 0x7fffffff;
  }
  return hash;
}

[I haven't kept my test program / data set - if anyone compares the
above
 to the others functions mentioned on the list, let me know.]

The 31 and 7 were determined experimentally.  But the 31 has a
theoretical
explanation (which might even be valid):

The rotate is equivalent to a multiplication by x**7 in Z_2[P=0],
where P is the polynomial x**31 - 1 (over Z_2).
Presumably the "best" P would be irreducible - but that would have more
bits set in the polynomial, making reduction harder.  A compromise is to
choose P in the form x**N - 1 but with relatively few factors.
X**31 - 1 is such a P.

Also, a 32 bit rotate (modulo X**32 - 1, which is equal
to (X - 1) ** 32 over Z_2), came out pretty badly.

One thing that shouldn't be forgotten about hashing for hash tables
is that you have to reduce the hash value to the required range - doing
that well greatly reduces the difference between various hash functions.

Ralph.


