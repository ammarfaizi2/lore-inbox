Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266017AbRGCVMn>; Tue, 3 Jul 2001 17:12:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266016AbRGCVMe>; Tue, 3 Jul 2001 17:12:34 -0400
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:62932 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S266017AbRGCVMY>; Tue, 3 Jul 2001 17:12:24 -0400
Message-Id: <5.1.0.14.2.20010703215031.00ae2660@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 03 Jul 2001 22:12:34 +0100
To: "Samium Gromoff" <_deepfire@mail.ru>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: O_DIRECT! or O_DIRECT?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15HWsV-0000lM-00@f12.port.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 21:34 03/07/2001, Samium Gromoff wrote:
[snip]
>        One more problem i see here, and i think it is an
>     *extremely* important one, that making open( ... ,
>     BLA_BLA_BLA | O_DIRECT) is a thing some people may
>     overspeculate with. I mean that implementing O_DIRECT
>     in cp(1), wins the prize, but in the case of, say,

Why should it? It is very well possible that the file(s) being copied have 
been accessed beforehand and hence are already in the page/buffer cache. 
Using O_DIRECT would not only completely bypass the page/buffer cache but 
it would also cause the cache to be flushed (if dirty) and the cache 
buffers/pages invalidated (otherwise you lose coherency). This is going to 
be _slower_ than not using O_DIRECT.

>     find(1) it is definitely not a wise move. The problem
>     may be determined as "poisoning" software with this
>     godblessed O_DIRECT, to the state, when 70% of code
>     on an average machine will use it, thus *completely*
>     killing the advantages of buffered access, and
>     suddenly *bang!*: the overall performance is died.

Er. Using O_DIRECT means you are doing _unbuffered_ access. - Maybe I am 
misunderstanding your comments, but is seems to me you have the whole 
concept of O_DIRECT the wrong way round.

>        But the worst thing, is what the process of
>     poisoning is completely uncontrollable: each
>     stupid doodie can think, that His shitful piece of Code,
>     is Especially Important, ant that in his case O_DIRECT
>     is perfectly suitable. And in the case His code is
>     someway performance critical, then most likely O_DIRECT
>     will really improve his Code benchmarks, and that is
>     making things really awful, leading to the hell large
>     crowd of pig happy dudes thinking their useless code
>     is life critical, and thus dooming linux.

O_DIRECT _decreases_ performance drastically in most cases. So nobody in 
their right mind would use it for normal applications. - The people who 
would use it and would actually experience a speed _increase_ would be 
programmers of large databases which perform their own caching in user 
space (thus making the normal fs level caching unnecessary, and in fact, 
worse than the unbuffered case) and programmers of multi media streaming 
applications (e.g. video/audio streaming including DVD playback[1] for 
example) which know that A) the data is not in the cache and B) the data 
will never be accessed again in the near future so caching the data is not 
only pointless but causes actually useful (other, unrelated) data present 
in the cache to be displaced out of the cache.

>        Maybe i`m stupid, as these potential dudes, and
>     painting things in too dark colors, but O_DIRECT,
>     i think, is a dangerous thing to play with.

It is indeed. It is only useful in very special circumstances as described 
above. Using it in "normal" applications is stupid and will lead to 
degradation of performance of the application using it.

>        Maybe i`m missing the whole point, and thus i want to
>     hear what other people will tell about it.

I think you do... I hope I managed to explain what O_DIRECT actually is above.

Shame you didn't attend the Linux Developers Conference (in Manchester) 
last weekend as Andrea Arcangeli gave a very nice talk explaining O_DIRECT 
in depth.

Best regards,

         Anton

[1] Actually DVD players make use or raw i/o to access the DVD disk device 
as a whole, thus bypassing file system code altogether, which is even 
faster, but if you were to copy a DVD to your hard drive than O_DIRECT 
would give you the described benefits.


-- 
   "Nothing succeeds like success." - Alexandre Dumas
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

