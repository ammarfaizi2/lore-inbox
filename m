Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbTFGJHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 05:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262824AbTFGJHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 05:07:10 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:41613 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262657AbTFGJHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 05:07:03 -0400
Date: Sat, 7 Jun 2003 11:20:27 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch] 2.5.70-bk11 zlib merge #4 pure magic
Message-ID: <20030607092027.GA24694@wohnheim.fh-wedel.de>
References: <20030606201306.GJ10487@wohnheim.fh-wedel.de> <Pine.SOL.4.30.0306062228140.13809-100000@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.SOL.4.30.0306062228140.13809-100000@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 June 2003 22:36:07 +0200, Bartlomiej Zolnierkiewicz wrote:
> On Fri, 6 Jun 2003, [iso-8859-1] Jörn Engel wrote:
> 
> > This one is pure magic, really.  No comment and inspection of the code
> > doesn't show much either.  But judging from the other changes, this
> > should also fix a real problem, at least a theoretical one.
> 
> Eee, no magic here :-).
> 
> from 1.1.4 ChangeLog:
> "- force windowBits > 8 to avoid a bug in the encoder for a window size
>    of 256 bytes. (A complete fix will be available in 1.1.5)."

So there IS a ChangeLog.  :)

> I guess complete fix is here:
> http://www.cs.toronto.edu/~cosmin/pngtech/zlib-256win-bug.html

> --- deflate.c	Thu Jul 09 18:06:12 1998
> +++ deflate.c.fixed	Thu Apr 12 04:02:36 2001
> @@ -242,7 +242,7 @@
>          windowBits = -windowBits;
>      }
>      if (memLevel < 1 || memLevel > MAX_MEM_LEVEL || method !=
> Z_DEFLATED ||
> -        windowBits < 8 || windowBits > 15 || level < 0 || level > 9 ||
> +        windowBits > 15 || level < 0 || level > 9 ||
>  	strategy < 0 || strategy > Z_HUFFMAN_ONLY) {
>          return Z_STREAM_ERROR;
>      }

Completely removes the check.

> @@ -252,7 +252,11 @@
>      s->strm = strm;
> 
>      s->noheader = noheader;
> -    s->w_bits = windowBits;
> +#if MIN_LOOKAHEAD < 256
> +    s->w_bits = (windowBits >= 8) ? windowBits : 8;
> +#else
> +    s->w_bits = (windowBits >= 9) ? windowBits : 9;
> +#endif
>      s->w_size = 1 << s->w_bits;
>      s->w_mask = s->w_size - 1;

Now we don't check and inform the user anymore, instead we change the
value internally.  So now overly smart users can set the windowBits to
a stupid value and we correct their mistake instead of telling them.
Not my preferred style.

> @@ -460,7 +464,12 @@
>      /* Write the zlib header */
>      if (s->status == INIT_STATE) {
> 
> +#if MIN_LOOKAHEAD < 256
>          uInt header = (Z_DEFLATED + ((s->w_bits-8)<<4)) << 8;
> +#else
> +        uInt optimized_cinfo = (s->w_bits > 9) ? s->w_bits - 8 : 0;
> +        uInt header = (Z_DEFLATED + (optimized_cinfo<<4)) << 8;
> +#endif
>          uInt level_flags = (s->level-1) >> 1;
> 
>          if (level_flags > 3) level_flags = 3;

This changes one corner case where windowBits == 9.  Even if the fix
is correct (too lazy to check), it costs us four new conditionals, of
which two were moved into the preprocessor.  And the gain over patch
#4 is zero, since we waste the memory anyway, where windowBits is
too small for decent compression or not.  Rejected.


Still, thanks for the two pointers, Bartlomiej!  Not quite as magic
anymore. :)

Jörn

-- 
With a PC, I always felt limited by the software available. On Unix, 
I am limited only by my knowledge.
-- Peter J. Schoenster
