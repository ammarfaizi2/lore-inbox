Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281715AbRKULKv>; Wed, 21 Nov 2001 06:10:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281711AbRKULKg>; Wed, 21 Nov 2001 06:10:36 -0500
Received: from ns.suse.de ([213.95.15.193]:65296 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281703AbRKULKW> convert rfc822-to-8bit;
	Wed, 21 Nov 2001 06:10:22 -0500
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <01112112401703.01961@nemo>
X-Yow: ...It's REAL ROUND..  And it's got a POINTY PART right in the MIDDLE!!
 The shape is SMOOTH..  ..And COLD.. It feels very COMFORTABLE on my
 CHEEK..  I'm getting EMOTIONAL..
From: Andreas Schwab <schwab@suse.de>
Date: 21 Nov 2001 12:10:17 +0100
In-Reply-To: <01112112401703.01961@nemo> (vda's message of "Wed, 21 Nov 2001 12:40:17 +0000")
Message-ID: <jeu1vobcrq.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1.30
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda <vda@port.imtp.ilyichevsk.odessa.ua> writes:

|> Upon random browsing in the kernel tree I noticed in accel.c:
|>     *a++ = byte_rev[*a]
|> which isn't 100% correct C AFAIK. At least Stroustrup in his C++ book
|> warns that this kind of code has to be avoided.

This is definitely causing undefined behaviour.  AFAIK, gcc 3.1 (current
CVS version) can warn about such errors (-Wsequence-point).

|> ======= bad_c.diff =======
|> diff -u --recursive linux-2.4.13-old/arch/mips/lib/tinycon.c 
|> linux-2.4.13-new/arch/mips/lib/tinycon.c
|> --- linux-2.4.13-old/arch/mips/lib/tinycon.c	Thu Jun 26 17:33:37 1997
|> +++ linux-2.4.13-new/arch/mips/lib/tinycon.c	Wed Nov 21 00:54:05 2001
|> @@ -83,14 +83,18 @@
|>    register int i;
|>  
|>    caddr = vram_addr;
|> -  for(i=0; i<size_x * (size_y-1); i++)
|> -    *(caddr++) = *(caddr + size_x);
|> +  for(i=0; i<size_x * (size_y-1); i++) {
|> +    *caddr = *(caddr + size_x);
|> +    caddr++;
|> +  }

Alternatively you can write:

  for(i=0; i<size_x * (size_y-1); i++, caddr++)
    *caddr = *(caddr + size_x);

or even:

  for(i=0; i<size_x * (size_y-1); i++, caddr++)
    *caddr = caddr[size_x];

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
