Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318045AbSHTN7u>; Tue, 20 Aug 2002 09:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318191AbSHTN7u>; Tue, 20 Aug 2002 09:59:50 -0400
Received: from waste.org ([209.173.204.2]:30400 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S318045AbSHTN7t>;
	Tue, 20 Aug 2002 09:59:49 -0400
Date: Tue, 20 Aug 2002 09:03:46 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: johan.adolfsson@axis.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Message-ID: <20020820140346.GC19225@waste.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a301c2482c$51a00e40$b9b270d5@homeip.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 11:31:10AM +0200, johan.adolfsson@axis.com wrote:
> The cris architecture don't have any tsc, but it has a couple of
> timer registers that can be used to get better than jiffie resolution.
>
> I set the time to a 40 us resolution counter with a slight
> "jump" since lower 8 bit only counts from 0 to 249,
> the patch does not take wrapping of the register into account either
> to save some cycles, is that a problem or a good thing?

That should be fine. More important is actually scaling the entropy
count based on the timing granularity of the source. Keyboards and
mice tend to have a granularity of about 1khz so timestamps better
than milliseconds 'invent' entropy in the current code.

> The num is xor:d with the value from 2 timer registers,
> which in turn contains different fields breifly described below.
> 
> Does the patch below look sane?

Looks fine, but I think we want to come up with a cleaner scheme of
having per-arch high-res timestamps. I'd hate to have that grow to
several pages of ifdefs and not have it available anywhere else. 

> +++ random.c    20 Aug 2002 09:10:04 -0000
> @@ -746,6 +746,15 @@ static void add_timer_randomness(struct
>         __u32 high;
>         rdtsc(time, high);
>         num ^= high;
> +#elif defined (__CRIS__)
> +       /* R_TIMER0_DATA, 8 bit, 40 us resolution, counting down from 250 */
> +       /* R_TIMER_DATA, 4*8 bit, timer1, timer0, 38.4kHz, 7.3728MHz */
> +       /* R_PRESCALE_STATUS, upper 16 bit: 320ns resolution,
> +          lower 16 bit: 40 ns resolution, ~10 bits used,
> +          counting down from 1000 */
> +       time = jiffies << 8;
> +       time |= (TIMER0_DIV - *R_TIMER0_DATA);
> +       num ^= *R_PRESCALE_STATUS ^ *R_TIMER_DATA;
>  #else
>         time = jiffies;
>  #endif

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
