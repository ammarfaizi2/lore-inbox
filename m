Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131076AbRBWDno>; Thu, 22 Feb 2001 22:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRBWDne>; Thu, 22 Feb 2001 22:43:34 -0500
Received: from hermes.mixx.net ([212.84.196.2]:5138 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131076AbRBWDnX>;
	Thu, 22 Feb 2001 22:43:23 -0500
Message-ID: <3A95DC21.A2DFAD3@innominate.de>
Date: Fri, 23 Feb 2001 04:42:25 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <UTC200102230249.DAA252851.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
>     Just looking at R5 I knew it wasn't going to do well in this application
>     because it's similar to a number of hash functions I tried with the same
>     idea in mind: to place similar names together in the same leaf block.
>     That turned out to be not very important compared to achieving a
>     relatively high fullness of leaf blocks.  The problem with R5 when used
>     with my htree is, it doesn't give very uniform dispersal.
> 
>     The bottom line: dx_hack_hash is still the reigning champion.
> 
> Now that you provide source for r5 and dx_hack_hash, let me feed my
> collections to them.
> r5: catastrophic
> dx_hack_hash: not bad, but the linear hash is better.

I never expected dx_hack_hash to be particularly good at anything, but
we might as well test the version without the mistake in it - I was
previously using < 0 to test the sign bit - on an unsigned variable :-/

unsigned dx_hack_hash (const char *name, int len)
{
	u32 hash0 = 0x12a3fe2d, hash1 = 0x37abe8f9;
	while (len--)
	{
		u32 hash = hash1 + (hash0 ^ (*name++ * 71523));
		if (hash & 0x80000000) hash -= 0x7fffffff;
		hash1 = hash0;
		hash0 = hash;
	}
	return hash0;
}


The correction gained me another 1% in the leaf block fullness measure. 
I will try your hash with the htree index code tomorrow.

--
Daniel
