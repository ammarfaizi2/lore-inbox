Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132894AbQL3DtV>; Fri, 29 Dec 2000 22:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132887AbQL3DtM>; Fri, 29 Dec 2000 22:49:12 -0500
Received: from mail.zmailer.org ([194.252.70.162]:31749 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S132862AbQL3DtF>;
	Fri, 29 Dec 2000 22:49:05 -0500
Date: Sat, 30 Dec 2000 05:18:25 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Dave Gilbert <gilbertd@treblig.org>, linux-alpha@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        Richard Henderson <rth@twiddle.net>
Subject: Re: memmove broken on alpha - was Re: NFS oddity (2.4.0test13pre4ac2 server, 2.0.36/2.2.14 clients)
Message-ID: <20001230051825.Z28963@mea-ext.zmailer.org>
In-Reply-To: <14925.12964.995179.63899@notabene.cse.unsw.edu.au> <Pine.LNX.4.10.10012300105100.26235-100000@tardis.home.dave> <14925.16964.875883.863169@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14925.16964.875883.863169@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Sat, Dec 30, 2000 at 01:02:44PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 30, 2000 at 01:02:44PM +1100, Neil Brown wrote:
> [ extra detail included because I have added linux-alpha and lins to
> the cc list] 
> 
> It appears that memmove is broken on the alpha architecture.

  Indeed it is, and your observation/patch isn't the first one:

Date:   Thu, 21 Dec 2000 18:40:46 +0300
From:   Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To:     Alexander Zarochentcev <zam@namesys.com>
Cc:     Richard Henderson <rth@twiddle.net>, linux-kernel@vger.kernel.org
Subject: Re: memmove() in 2.4.0-test12, alpha platform

  As the patch by mr. Kokshaysky is quite different doing more work
  (and not only label name changes), I would prefer Richard Henderson
  to act as an umpire to tell if your patch is sufficient, or if that
  big thing by Kokshaysky is needed.

  Full email (and patch) by Kokshaysky is at:
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0012.2/0712.html

> memmove is used by net/sunrpc/xdr.c:xdr_decode_string
> to move a string 4 bytes down in memory.
> memmove(X-4, X, 8) should change
>     
>  X:  00 00 00 08  67 69 6c 62 65 72 74 64
> to
>  X:  67 69 6c 62  65 72 74 64 65 72 74 64
> 
> Instead it changes it to
> 
>  X:  65 72 74 64  65 72 74 64 65 72 74 64
> 
> This is my first time in alpha assembler, but it looks fairly readable
> and the comments help....
> 
> Working from 
>   arch/alpha/lib/memmove.S
.... 
> which I think translates to the following patch:
> 
> --- arch/alpha/lib/memmove.S	2000/12/30 01:59:28	1.1
> +++ arch/alpha/lib/memmove.S	2000/12/30 01:59:49
> @@ -17,7 +17,7 @@
>  memmove:
>  	addq $16,$18,$4
>  	addq $17,$18,$5
> -	cmpule $4,$17,$1		/*  dest + n <= src  */
> +	cmpule $16,$17,$1		/*  dest <= src  */
>  	cmpule $5,$16,$2		/*  dest >= src + n  */
>  
>  	bis $1,$2,$1
> 
> NeilBrown

/Matti Aarnio
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
