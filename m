Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751510AbWGaKgk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751510AbWGaKgk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 06:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751512AbWGaKgk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 06:36:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:15862 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751510AbWGaKgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 06:36:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GVyZpMqbM/S6dAV4lty4jc0jaidRu/QnraQ92X26+j/gyVBUu+ypShbr6PinFFwwg7ERhioKal20pZAdU4FVoqLoWqIIS2zRY5+8DYR/SdGY8VluTrKBiXlpsEE0WEu8p8U4wepzvIaeRkaDKsRqu+HXp/DL1W7/3CtOJtibOGY=
Message-ID: <6e0cfd1d0607310336o355693a5l939db098b9210d81@mail.gmail.com>
Date: Mon, 31 Jul 2006 12:36:38 +0200
From: "Martin Schwidefsky" <schwidefsky@googlemail.com>
To: "Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64 aliasing problem)
Cc: johnstul@us.ibm.com, akpm@osdl.org, zippel@linux-m68k.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, ak@muc.de
In-Reply-To: <20060730.235403.108306254.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060302190408.1e754f12.akpm@osdl.org>
	 <1141417048.9727.60.camel@cog.beaverton.ibm.com>
	 <20060305.021542.126141997.anemo@mba.ocn.ne.jp>
	 <20060730.235403.108306254.anemo@mba.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/06, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> index 7a9b182..298027f 100644
> --- a/arch/x86_64/kernel/time.c
> +++ b/arch/x86_64/kernel/time.c
> @@ -423,7 +423,8 @@ #endif
>
>         if (lost > 0) {
>                 handle_lost_ticks(lost, regs);
> -               jiffies += lost;
> +               while (lost--)
> +                       do_timer(regs);
>         }
>
>  /*

I think that this is going into the wrong direction. There are a
number of architectures that call do_timer(regs) in a while loop. It
would be much nicer if do_timer would get the number of passed ticks
as an argument. And the "regs" argument to do_timer is just useless.

> diff --git a/kernel/timer.c b/kernel/timer.c
> index 05809c2..3981cae 100644
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -1267,12 +1267,9 @@ void run_local_timers(void)
>   */
>  static inline void update_times(void)
>  {
> -       unsigned long ticks;
> -
> -       ticks = jiffies - wall_jiffies;
> -       wall_jiffies += ticks;
> +       wall_jiffies++;
>         update_wall_time();
> -       calc_load(ticks);
> +       calc_load(1);
>  }
>
>  /*

Pass "ticks" from do_timer and do "wall_jiffies += ticks". To make
calc_load work correctly the  "if (count < 0)" in calc_load needs to
be replaced with "while (count < 0)".

> @@ -1284,8 +1281,6 @@ static inline void update_times(void)
>  void do_timer(struct pt_regs *regs)
>  {
>         jiffies_64++;
> -       /* prevent loading jiffies before storing new jiffies_64 value. */
> -       barrier();
>         update_times();
>  }
>

Change do_timer and make architectures to pass "ticks", do "jiffies64
+= ticks" and add ticks to the call of update_times.

-- 
blue skies,
  Martin
