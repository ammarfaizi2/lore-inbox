Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272427AbTHIRdz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272437AbTHIRdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:33:55 -0400
Received: from waste.org ([209.173.204.2]:63433 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S272427AbTHIRdv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:33:51 -0400
Date: Sat, 9 Aug 2003 12:33:29 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       jmorris@intercode.com.au, davem@redhat.com
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
Message-ID: <20030809173329.GU31810@waste.org>
References: <20030809074459.GQ31810@waste.org> <20030809143314.GT31810@waste.org> <20030809171318.GD29647@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030809171318.GD29647@mail.jlokier.co.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 09, 2003 at 06:13:18PM +0100, Jamie Lokier wrote:
> Matt Mackall wrote:
> > This code is already at about 125% of baseline throughput, and can
> > probably reach 250% with some tweaking of cryptoapi's redundant
> > padding (in case anyone else cares about being able to get 120Mb/s
> > of cryptographically strong random data).
> 
> Why would the cryptoapi version be faster, I wondered?  So I had a look.
> No conclusions, just observations.
> 
>   - random.c defines a constant, SHA_CODE_SIZE.  This selects between
>     4 implementations, from smaller to (presumably) faster by
>     progressively unrolling more and more.
> 
>     This is set to SHA_CODE_SIZE == 0, for smallest code.
> 
>     In crypto/sha1.c, the code is roughly equivalent to SHA_CODE_SIZE == 3,
>     random.c's _largest_ implementation.
> 
>     So you seem to be replacing a small version with a large version,
>     albeit faster.

Yes. I've got another patch to include a non-unrolled version of SHA
in cryptolib but that depends on some config magic I haven't thought
out. Another thing I failed to mention at 3am is that most of the
speed increase actually comes from the following patch which wasn't in
baseline and isn't cryptoapi-specific. So I expect the cryptoapi
version is about 30% faster once you amortize the initialization
stuff.

>>>>
Remove folding step and double throughput.

If there was a recognizable output pattern, simply folding would make
things worse. To see why, assume bits x and y are correlated, but are
othewise random. Then x^y has a bias toward zero, meaning less entropy
than just x alone.

Best case, this is the moral equivalent of running every bit through
SHA four times rather than twice. Twice should be more than enough.

diff -urN -X dontdiff orig/drivers/char/random.c work/drivers/char/random.c
--- orig/drivers/char/random.c	2003-08-09 10:25:46.000000000 -0500
+++ work/drivers/char/random.c	2003-08-09 10:31:27.000000000 -0500
@@ -1013,20 +1013,8 @@
 			add_entropy_words(r, &tmp[x%HASH_BUFFER_SIZE], 1);
 		}
 		
-		/*
-		 * In case the hash function has some recognizable
-		 * output pattern, we fold it in half.
-		 */
-		for (i = 0; i <  HASH_BUFFER_SIZE/2; i++)
-			tmp[i] ^= tmp[i + (HASH_BUFFER_SIZE+1)/2];
-#if HASH_BUFFER_SIZE & 1	/* There's a middle word to deal with */
-		x = tmp[HASH_BUFFER_SIZE/2];
-		x ^= (x >> 16);		/* Fold it in half */
-		((__u16 *)tmp)[HASH_BUFFER_SIZE-1] = (__u16)x;
-#endif
-		
 		/* Copy data to destination buffer */
-		i = min(nbytes, HASH_BUFFER_SIZE*sizeof(__u32)/2);
+		i = min(nbytes, HASH_BUFFER_SIZE*sizeof(__u32));
 		if (flags & EXTRACT_ENTROPY_USER) {
 			i -= copy_to_user(buf, (__u8 const *)tmp, i);
 			if (!i) {

>>>>>

>   - One of the optimisations in crypto/sha1.c is:
> 
>       /* blk0() and blk() perform the initial expand. */
>       /* I got the idea of expanding during the round function from SSLeay */
> 
>     Yet, random.c has the opposite:
> 
>       /*
>        * Do the preliminary expansion of 16 to 80 words.  Doing it
>        * out-of-line line this is faster than doing it in-line on
>        * register-starved machines like the x86, and not really any
>        * slower on real processors.
>        */
> 
>     I wonder if the random.c method is faster on x86?

They're probably equal on modern machines. The random code is from 486 days.

>   - sha1_transform() in crypto/sha1.c ends with this misleading
>     comment.  Was the author trying to prevent data leakage?  If so,
>     he failed:
> 
> 	/* Wipe variables */
> 	a = b = c = d = e = 0;
> 	memset (block32, 0x00, sizeof block32);
> 
>     The second line will definitely be optimised away.  The third
>     could be, although GCC doesn't.

Preventing data leakage is the intent, though I'm not sure its worth
the trouble. If your attacker can leverage this sort of data leakage,
you probably have more important stuff to worry about.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
