Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBXFff>; Sat, 24 Feb 2001 00:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129252AbRBXFfZ>; Sat, 24 Feb 2001 00:35:25 -0500
Received: from smtp2.ihug.co.nz ([203.109.252.8]:63493 "EHLO smtp2.ihug.co.nz")
	by vger.kernel.org with ESMTP id <S129197AbRBXFfX>;
	Sat, 24 Feb 2001 00:35:23 -0500
Message-Id: <200102240534.f1O5YlG08147@sucky.fish>
Subject: Re: [rfc] Near-constant time directory index for Ext2
From: Ralph Loader <suckfish@ihug.co.nz>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Linux-kernel@vger.kernel.org, kaih@khms.westfalen.de
In-Reply-To: <20010223233717.B13627@win.tue.nl>
In-Reply-To: <UTC200102230152.CAA138669.aeb@vlet.cwi.nl>
	<200102232143.f1NLhG202360@sucky.fish>  <20010223233717.B13627@win.tue.nl>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 24 Feb 2001 18:34:47 +1300
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries,


> > int hash_fn (char * p)
> > {
> >   int hash = 0;
> >   while (*p) {
> >      hash = hash + *p;
> >      // Rotate a 31 bit field 7 bits:
> >      hash = ((hash << 7) | (hash >> 24)) & 0x7fffffff;
> >   }
> >   return hash;
> > }

> 

> Hmm. This one goes in the "catastrophic" category.

> 
> For actual names:
> 
> N=557398, m=51 sz=2048, min 82, max 4002, av 272.17, stddev 45122.99
> 
> For generated names:
> 
> N=557398, m=51 sz=2048, min 0, max 44800, av 272.17, stddev 10208445.83
> 

Instead of masking the hash value down to 11 bits you could try:

index = (hash ^ (hash >> 11) ^ (hash >> 22)) & 0x7ff;

I ran a quick test which gave fairly good results with that: 12871
identifiers
from a source tree) gave a mean square bucket size of 45.65, expected
value for a random function is 45.78.

That change might improve some of your other hashes as well - there
doesn't
seem to be much point in computing a 32 bit value only to throw 20 bits
away -
stirring in the extra bits makes much more sense to me.

> > The rotate is equivalent to a multiplication by x**7 in Z_2[P=0],

> > where P is the polynomial x**31 - 1 (over Z_2).
> > Presumably the "best" P would be irreducible - but that would have more
> > bits set in the polynomial, making reduction harder.  A compromise is to
> > choose P in the form x**N - 1 but with relatively few factors.
> > X**31 - 1 is such a P.
> 
> It has seven irreducible factors. Hardly "almost irreducible".

I didn't say it was.  "almost irreducible" polynomials with Hamming
weight two are pretty rare...  Relative to say, x**32 - 1 or x**24 - 1,
having 7 factors is good.

Ralph.


