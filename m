Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRKUMha>; Wed, 21 Nov 2001 07:37:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281793AbRKUMhU>; Wed, 21 Nov 2001 07:37:20 -0500
Received: from mail1.dexterus.com ([212.95.255.99]:29704 "EHLO
	mail1.dexterus.com") by vger.kernel.org with ESMTP
	id <S281779AbRKUMhF>; Wed, 21 Nov 2001 07:37:05 -0500
Message-ID: <3BFB9FAE.DB9B6003@dexterus.com>
Date: Wed, 21 Nov 2001 12:35:58 +0000
From: Vincent Sweeney <v.sweeney@dexterus.com>
Organization: Dexterus
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
In-Reply-To: <01112112401703.01961@nemo>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vda wrote:
> 
> Hi,
> 
> Upon random browsing in the kernel tree I noticed in accel.c:
>     *a++ = byte_rev[*a]
> which isn't 100% correct C AFAIK. At least Stroustrup in his C++ book
> warns that this kind of code has to be avoided.

It looks perferctly okay to me. Anyway, whenever would you listen to a
C++ book talking about good C coding :p

> Wrote a script to catch similar things all over the tree (attached).
> Found some buglets. Here they are:
> 
> drivers/message/i2o/i2o_config.c:#define MODINC(x,y) (x = x++ % y)
> ---------------------------------------------------
> Bad code style. Bad name (sounds like 'module inc').
> I can't even tell from this define what the hell it is trying to do:
> x++ will return unchanged x, then we obtain (x mod y),
> then we store it into x... and why x++ then??!
> Alan, seems like you can help here...

Go read up on C operator precedence. Unary ++ comes before %, so if we
rewrite the #define to make it more "readable" it would be #define
MODINC(x,y) (x = (x+1) % y)


> drivers/isdn/isdn_audio.c:     *buff++ = table[*(unsigned char *)buff];
> drivers/video/riva/accel.c:     *a++ = byte_rev[*a];
> drivers/video/riva/accel.c:/*   *a++ = byte_rev[*a];
> drivers/video/riva/accel.c:     *a++ = byte_rev[*a];*/
> drivers/usb/se401.c:
> *frame++=(((*frame^255)*(*frame^255))/255)^255;
> arch/mips/lib/tinycon.c:    *(caddr++) = *(caddr + size_x);
> arch/mips/lib/tinycon.c:    *(caddr++) = (*caddr & 0xff00) | (unsigned short)
> ' ';
>     (btw, tinycon.c seriously needs Lindenting)
> ------------------------------------------------------------------
> Undefined behavior by C std: inc/dec may happen before dereference.
> Probably GCC is doing inc after right side eval, but standards say nothing
> about it AFAIK. Move ++ out of the statement to be safe:
>     *a++ = byte_rev[*a]; => *a = byte_rev[*a]; a++;

C std says *always* evaluate from right to left for = operators, so this
will always make perfect sense.

> Patch is attached.
> 
> drivers/block/paride/pf.c:      if (l==0x20) j--; targ[j]=0;
> drivers/block/paride/pg.c:      if (l==0x20) j--; targ[j]=0;
> drivers/block/paride/pt.c:      if (l==0x20) j--; targ[j]=0;
>     (these files need Lindenting too)
> ----------
> Missing {}
> Either a bug or a very bad style (so bad that I can even imagine
> that it is NOT a bug). Please double check before applying the patch!
> --
> vda

C std says IFF you have one expression after the for() then you can omit
the {}'s. So this is NOT a bug or bad coding style its just saving some
bytes in the source code :)

Vince.
