Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267303AbTGLAta (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 20:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267316AbTGLAta
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 20:49:30 -0400
Received: from dyn-ctb-203-221-74-60.webone.com.au ([203.221.74.60]:45828 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S267303AbTGLAtT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 20:49:19 -0400
Message-ID: <3F0F5E44.1080109@cyberone.com.au>
Date: Sat, 12 Jul 2003 11:03:00 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030618 Debian/1.3.1-3
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Andrew Morton <akpm@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>,
       axboe@suse.de, bernie@develer.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.75 as-iosched.c & asm-generic/div64.h breakage
References: <200307112048.h6BKmUQj003987@harpo.it.uu.se>	<20030711140158.0b27117e.akpm@osdl.org> <16143.23320.180064.599815@cargo.ozlabs.ibm.com>
In-Reply-To: <16143.23320.180064.599815@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Paul Mackerras wrote:

>Andrew Morton writes:
>
>
>>Mikael Pettersson <mikpe@csd.uu.se> wrote:
>>
>>>drivers/block/as-iosched.c: In function `as_update_iohist':
>>>drivers/block/as-iosched.c:840: warning: right shift count >= width of type
>>>drivers/block/as-iosched.c:840: warning: passing arg 1 of `__div64_32' from incompatible pointer type
>>>
>>You mean that code was in -mm for all those months and no ppc32 person
>>bothered testing it?  Bah.
>>
>
>We've only been getting those warnings since the changeover to the new
>asm-generic/div64.h.  Settle down. :)
>
>
>>Something like this?  (Could be sped up for 32-bit sector_t)
>>
>>diff -puN drivers/block/as-iosched.c~as-do_div-fix drivers/block/as-iosched.c
>>--- 25/drivers/block/as-iosched.c~as-do_div-fix	Fri Jul 11 14:00:55 2003
>>+++ 25-akpm/drivers/block/as-iosched.c	Fri Jul 11 14:00:58 2003
>>@@ -836,8 +836,10 @@ static void as_update_iohist(struct as_i
>> 		aic->seek_samples += 256;
>> 		aic->seek_total += 256*seek_dist;
>> 		if (aic->seek_samples) {
>>-			aic->seek_mean = aic->seek_total + 128;
>>-			do_div(aic->seek_mean, aic->seek_samples);
>>+			u64 seek_mean = aic->seek_total + 128;
>>+
>>+			do_div(seek_mean, aic->seek_samples);
>>+			aic->seek_mean = seek_mean;
>> 		}
>>
>
>There are several interesting aspects to this:
>
>1. For some reason the LBD config option in drivers/block/Kconfig
>   depends on X86.  (CONFIG_LBD is what makes sector_t an unsigned
>   long long instead of an unsigned long).  I think the LBD option
>   should be available on all 32-bit platforms.  Working out a neat
>   way to tell the config system that is left as an exercise for the
>   reader. :)
>

Not me :P

>
>2. It seems to me that seek_total is bounded above by 1024 * the
>   maximum seek distance.  I'm a bit concerned about that overflowing
>   32 bits - AFAICS I would only need a > 2GB disk (or do I mean
>   partition?) for that to happen.  Could we make seek_total be a u64
>   unconditionally please?
>

Probably a good idea. It is only the seek distance for one
process though. But it wouldn't hurt.

>
>3. I guess that adding 128 on to the seek_total is to get a
>   round-to-nearest effect in the division.  In fact you need to add
>   on (seek_samples >> 1) to get that effect.
>

You're right. Thanks.


