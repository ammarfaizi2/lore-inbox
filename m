Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319317AbSHVKoQ>; Thu, 22 Aug 2002 06:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319318AbSHVKoQ>; Thu, 22 Aug 2002 06:44:16 -0400
Received: from gra-lx1.iram.es ([150.214.224.41]:53515 "EHLO gra-lx1.iram.es")
	by vger.kernel.org with ESMTP id <S319317AbSHVKoO>;
	Thu, 22 Aug 2002 06:44:14 -0400
Message-ID: <3D64BB45.4020907@iram.es>
Date: Thu, 22 Aug 2002 10:21:57 +0000
From: Gabriel Paubert <paubert@iram.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yoann Vandoorselaere <yoann@prelude-ids.org>
CC: cpufreq@lists.arm.linux.org, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org,
       "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH]: fix 32bits integer overflow in loops_per_jiffy calculation
References: <1030009840.15429.109.camel@alph>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoann Vandoorselaere wrote:
> Hi,
> 
> The "low_part * mult" multiplication of the old function may overflow a
> 32bits integer...
> 
> This patch both fix the overflow issue (tested with frequencies up to
> 20Ghz), and make the result of the function lose less precision.
> 
> Please apply, 
> 
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-benh/kernel/cpufreq.c	2002-08-21 17:27:52.000000000 +0200
> +++ linux-yoann/kernel/cpufreq.c	2002-08-22 11:27:09.000000000 +0200
> @@ -78,14 +78,16 @@ static unsigned int             cpufreq_
>   */
>  static unsigned long scale(unsigned long old, u_int div, u_int mult)
>  {
> -	unsigned long low_part, high_part;
> -
> -	high_part  = old / div;
> -	low_part   = (old % div) / 100;
> -	high_part *= mult;
> -	low_part   = low_part * mult / div;
> -
> -	return high_part + low_part * 100;
> +        unsigned long val, carry = 0;
> +        
> +        mult /= 100;
> +        div  /= 100;

if(abs(div)<100) div=0;

> +        val = old / div * mult;

Now happily divide by zero.

> +
> +        carry = old % div;

Again.

> +        carry = carry * mult / div;

Again.

> +                
> +        return val + carry;
>  }
>  

And I can't see how it can be more precise, you divide the numerator and
denominator of the fraction by 100 and then proceed forgetting 
everything about the rest. Basically this looses about 7 bits of precision.

Now altogether I believe that such a function pertains to a per arch 
optimized routine.






