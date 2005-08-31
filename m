Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbVHaTQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbVHaTQm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 15:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVHaTQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 15:16:42 -0400
Received: from mailout01.sul.t-online.com ([194.25.134.80]:28644 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932531AbVHaTQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 15:16:41 -0400
Message-ID: <431602CC.1030008@t-online.de>
Date: Wed, 31 Aug 2005 21:19:40 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be> <43149E5B.7040006@t-online.de> <Pine.LNX.4.61.0508302039160.3743@scrub.home> <4314DD2E.7060901@t-online.de> <Pine.LNX.4.61.0508310159290.3728@scrub.home> <4315A6AB.5090108@t-online.de> <Pine.LNX.4.61.0508311750140.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0508311750140.3728@scrub.home>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: SOkMwMZlrewXN-ayRh8atnW3-2UyHgWUeDnGBpAudGr2qxsPonuGUn@t-dialin.net
X-TOI-MSGID: 9adbd55c-8235-43ad-aa7e-8d889c596ebd
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi Roman!

>>+static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, +
>>u32 s_pitch, u32 height)
>>+{
>>+	int i, j;
>>+
>>+	if (likely(s_pitch==1))
>>+		for(i=0; i < height; i++)
>>+			dst[d_pitch*i] = src[i];
>>    
>>

I added the multiply back because gcc (v. 3.3.4) does generate the 
fastest code
if I write it this way. I compiled, inspected the generated assembly and 
benchmarked
about a  dozend variations of the code (benchmark as previously described).

The special case for s_pitch == 1 saves about 10 ms system time (770 ms 
-> 760 ms)

The special case for s_pitch == 2 saves about 270 ms system time (2120 
-> 1850ms)
with a 16x30 font.

The third case is for even bigger fonts ... I believe that it will not 
often be used but
something like that must be present.

>You have now 3 slightly different variants of the same, which isn't really 
>an improvement. In my example I showed you how to generate the first and 
>last version from the same source.
>
The first version will only be generated when gcc can be sure that 
s_pitch is 1.
Therefore you had to explicitly call __fb_pad_aligned_buffer with that 
value:

	if (likely(idx == 1))
		__fb_pad_aligned_buffer(dst, pitch, src, 1, image.height);
	else
		fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);
 
With the version I propose it큦 enough to write

		__fb_pad_aligned_buffer(dst, pitch, src, idx, image.height);

instead, and you will get good performance for all cases. If the value of
idx/s_pitch is know at compile time, the compiler can and will ignore the
other cases.

>If you also want to optimize for other sizes, you might want to always 
>inline the function, if the function call overhead is the largest part 
>anyway, the special case for 2 bytes might not be needed anymore.
>  
>
fb_pad_aligned_buffer() is  usefull to save some space in cases like 
softcursor.
It큦 also used by some  drivers (nvidia and riva), but the authors of 
those drivers
have to decide if they prefer the inlined version or the version fixed 
in fbmem.

>BTW this version saves another condition:
>
>static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u32 height)
>{
>	int i, j;
>
>	d_pitch -= s_pitch;
>	i = height;
>	do {
>		/* s_pitch is a few bytes at the most, memcpy is suboptimal */
>		j = s_pitch;
>		do
>			*dst++ = *src++;
>		while (--j > 0);
>		dst += d_pitch;
>	} while (--i > 0);
>}
>
I tested that code, together with the followig code in but_putcs():

             if(idx==1)
                    __fb_pad_aligned_buffer(dst, pitch, src, 1, 
image.height);
             else if (idx==2)
                    __fb_pad_aligned_buffer(dst, pitch, src, 2, 
image.height);
             else
                    fb_pad_aligned_buffer(dst, pitch, src, idx, 
image.height);
             dst += width;

It큦 as fast/slow as your previous version, the measurements are almost 
identical.

Let큦 summarize:

Your version of __fb_pad_aligned_buffer looks much better, but it needs 
not so nice
conditionals when used. My version looks bad, but it is easier to use 
and it is
_faster_.

cu,
 knut



