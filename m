Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUAPASC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 19:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUAPASC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 19:18:02 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:60107 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263522AbUAPARu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 19:17:50 -0500
Date: Thu, 15 Jan 2004 16:17:32 -0800
From: Paul Jackson <pj@sgi.com>
To: joe.korty@ccur.com
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115161732.458159f5.pj@sgi.com>
In-Reply-To: <20040115181525.GA31086@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch captures what I am looking for in bitmap display and input.

Interesting.  I appear to have provoked Joe into a burst of coding.
Now, if I had any smarts, I would stand aside and let Joe own this,
just as Bill Irwin did when I posted my initial lib/mask.c patch a
couple months ago.


Andrew:

    If you find Joe's coding more to your liking than my "Gad" style,
    I will bless this, and after tossing in a few parting shots, will
    stand aside.  It meets my essential needs, which were:
     - chunked output (a comma every 16 or 32 bits),
     - symmetric input and output formats, and
     - display and parsing code generic to diverse bitmap sizes.

    My actual recommendation, if however you are still undecided, is:
     - my patch of last night (with the M32X() 64 bit big endian fix),
     - Joe's recommended format, zero-filling to chunksize each word,
     - Joe's renaming/refactoring from lib/mask.c to lib/bitmap.h, and
     - a chunksize of 16 rather than 32 (Joe likes 16, I don't care).

The essential differences between Joe's and my proposals that I see are:
    - Joe's has more code, especially in the parsing routine,
    - Joe's bitmap size resolution is bits, not words, and
    - I use an implied alloca of 4 x sizeof(mask) bytes.


Comments on Joe's patch:

> ChangeLog:

  Good job of summarizing for the Changelog the changes.

> o move into the bitmap.h family, rename and refactor interface to match

  I think I like this - good.

>  o bitmap size resolution changed from byte to bit

  Why?  This adds a fair bit of complexity to the code, I suspect.
  I am not aware of a need for this, but if there is one, ok.

> o chunking (digits between commas) changed from 8 to 4 digits

  Ok - either 8 or 4 works for me.  This detail should be decided
  by those working on 16 to 32 cpu systems, who will notice this
  choice the most.  Those of us on larger or smaller systems are
  going to see, or not see, separators in either case.

>  o display no longer affected by sizeof(unsigned long).

  A bit of a misstatement.  The display was only affected by the
  chunksize, one of 32 (sizeof(u32)*8) or 16 (CHUNKSZ).

>  o no alloca usage

  True.  Though on the other hand, you need to roll your own parsing
  code of comma-separated chunks, instead of getting by with using
  strsep().  So you trade alloca usage for code complexity.  Either
  way works - coders choice.  I agree that we disagree on this tradeoff.

>  o works correctly independent of the size of an unsigned long.

  And my version doesn't?

>  o works on big and little endian machine.

  With my M32X() eor-1 fix, so did mine.

> + * lib/bitmask.c - bitmask manipulation routines too big to go into bitmask.h

  Typo?  Did you mean bitmap.c and bitmap.h, not bitmask?

> +int bitmap_parse(const char __user *ubuf, unsigned int ubuflen,
> +        unsigned long *maskp, unsigned int nmaskbits)

  This routine has quite a bit more code detail than my corresponding
  parsing routine.  I hope that:
    (1) providing bit-level resolution, and
    (2) removing the implied alloca
  justifies this increase in code detail.

> +			if (isspace(c))
> +				continue;

  So a space embedded in a hex number is skipped?  That is, your code
  parses "dead,beef" and "de a d, bee  f" the same?  This seems strange.
  Perhaps you would prefer to suppress only leading spaces in each chunk:

			if (!n && isspace(c))
				continue;

> +			for (j = 0; j < 32; j++) {

  What's this "32", an unrepentant CHUNKSZ?

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
