Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132898AbQLRBlR>; Sun, 17 Dec 2000 20:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132910AbQLRBlI>; Sun, 17 Dec 2000 20:41:08 -0500
Received: from storm.ca ([209.87.239.69]:14063 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S132898AbQLRBk4>;
	Sun, 17 Dec 2000 20:40:56 -0500
Message-ID: <3A3D6399.C213729E@storm.ca>
Date: Sun, 17 Dec 2000 20:08:41 -0500
From: Sandy Harris <sandy@storm.ca>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en,fr
MIME-Version: 1.0
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: random.c patch
In-Reply-To: <20001217224452.A8635@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy wrote:
> 
> There are several places where the rotation yields garbage according to ANSI
> C definition when called with 0 bit position argument.
> 
> diff -Pur linux_reference/drivers/char/random.c linux/drivers/char/random.c
> --- linux_reference/drivers/char/random.c       Wed Jul 19 00:58:13 2000
> +++ linux/drivers/char/random.c Sun Dec 17 22:42:59 2000
> @@ -411,7 +411,7 @@
>  #if (!defined (__i386__))
>  extern inline __u32 rotate_left(int i, __u32 word)
>  {
> -       return (word << i) | (word >> (32 - i));
> +       return (word << i) | (word >> ((-i)&31));
> 
If the calling code guarantees 0 < i < 32, then the patch is unnecessary.
In the kernel I have to hand (2.2.6), grepping gives:

	r->input_rotate = j & 31 ;

and then both calls to the function use r->input_rotate as the first argument,
so the guarantee from higher level code seems to be 0 <= i < 32, in which case
your patch seems needed.

On the other hand, why not put the &= inside the function with something
like:

 extern inline __u32 rotate_left(int i, __u32 word)
{
	switch( i &= 31 )	{ /* cheap version of i %= 32 */
		case 0 :
			return word ;
		default :
			return (word << i) | (word >> (32 - i)) ;
	}

or some faster alternative along the lines of:

{
	i &= 31 ;
	return( i ? ((word << i) | (word >> (32 - i))) : word ) ;

This works right for any i. Yours fails for i >= 32 unless you make it:

       return (word << (i&31)) | (word >> ((-i)&31));

Whichever way is fastest is fine, but I'd advocate doing the range
manipulation inside the function in any case. Why trust the caller?
If the code is maintained or modified, you're almost guaranteed to
be called with bad argumantes in some version.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
