Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279782AbRJ0GWG>; Sat, 27 Oct 2001 02:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279784AbRJ0GVr>; Sat, 27 Oct 2001 02:21:47 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:11509 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S279782AbRJ0GV0>; Sat, 27 Oct 2001 02:21:26 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sat, 27 Oct 2001 00:21:42 -0600
To: =?unknown-8bit?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
Subject: Re: [PATCH] random.c bugfix
Message-ID: <20011027002142.D23590@turbolinux.com>
Mail-Followup-To: =?unknown-8bit?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>, Alan Cox <alan@redhat.com>
In-Reply-To: <m15xL0J-007qTxC@smtp.web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15xL0J-007qTxC@smtp.web.de>
User-Agent: Mutt/1.3.22i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 27, 2001  06:21 +0200, Ren? Scharfe wrote:
> there's a bug in random.c, I think. The third argument of
> extract_entropy() is supposed to be the number of _bytes_ to extract,
> while nwords contains the number of _bytes_ we want. This seems to lead
                                       ^^^^^ words, I think you mean ;-)
> us to transfer n bytes of entropy and credit for n*4 bytes.

OK, my bad.  At least the random variable-name cleanups let you SEE where
we are supposed to be using word sizes and byte sizes.  Even you were
confused about it ;-)

> --- linux-2.4.14-pre2/drivers/char/random.c	Fri Oct 26 23:07:16 2001
> +++ linux-2.4.14-pre2-rs/drivers/char/random.c	Sat Oct 27 05:36:23 2001
> @@ -1253,7 +1253,7 @@
>  			  r == sec_random_state ? "secondary" : "unknown",
>  			  r->entropy_count, nbytes * 8);
>  
> -		extract_entropy(random_state, tmp, nwords, 0);
> +		extract_entropy(random_state, tmp, nwords * 4, 0);
>  		add_entropy_words(r, tmp, nwords);
>  		credit_entropy_store(r, nwords * 32);
>  	}

The patch looks correct, though.

> The rest of the patch is just there for consistency and because it just
> looks better to me. Those sizeof()s were introduced in kernel 2.4.13, I
> just can't imagine why. Care to explain anyone?

> @@ -1260,9 +1260,9 @@
>  	if (r->extract_count > 1024) {
>  		DEBUG_ENT("reseeding %s with %d from primary\n",
>  			  r == sec_random_state ? "secondary" : "unknown",
> -			  sizeof(tmp) * 8);
> -		extract_entropy(random_state, tmp, sizeof(tmp), 0);
> -		add_entropy_words(r, tmp, sizeof(tmp) / 4);
> +			  TMP_BUF_SIZE * 32);
> +		extract_entropy(random_state, tmp, TMP_BUF_SIZE * 4, 0);
> +		add_entropy_words(r, tmp, TMP_BUF_SIZE);
>  		r->extract_count = 0;
>  	}
>  }

Well, this is a matter of taste.  With my code, it is correct regardless
of how tmp is declared, while with your code you assume tmp is TMP_BUF_SIZE
words, and that it is declared with a 4-byte type.  Both ways are resolved
at compile time, so using "sizeof(tmp)/4" or "sizeof(tmp)*8" doesn't add
any run-time overhead.

I don't have a strong opinion either way, if Linus and/or Alan have a
preference to do it one way or the other.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

