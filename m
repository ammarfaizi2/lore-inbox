Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264166AbTCXMA1>; Mon, 24 Mar 2003 07:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264168AbTCXMA1>; Mon, 24 Mar 2003 07:00:27 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:12930 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S264166AbTCXMAX>; Mon, 24 Mar 2003 07:00:23 -0500
Date: Mon, 24 Mar 2003 13:10:55 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Finn Arne Gangstad <Finn.Gangstad@fast.no>
cc: Andrew Morton <akpm@digeo.com>, Vitezslav Samel <samel@mail.cz>,
       Matthew Wilcox <willy@debian.org>, Eric Piel <Eric.Piel@Bull.Net>,
       <davidm@hpl.hp.com>, <linux-ia64@linuxia64.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix nanosleep() granularity bumps
In-Reply-To: <20030324120604.GA3004@fast.no>
Message-ID: <Pine.LNX.4.33.0303241309180.5492-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 18, 2003 at 10:05:56AM +0100, Tim Schmielau wrote:
[...]
> Suggest the attached patch as a fix instead - easier to understand I
> think and works for every possible start value. This is what I made for
> Andrea Arcangeli many years ago...
>
> diff -ur linux-2.5.65/kernel/timer.c linux-2.5.65-new/kernel/timer.c
> --- linux-2.5.65/kernel/timer.c	2003-03-17 22:44:41.000000000 +0100
> +++ linux-2.5.65-new/kernel/timer.c	2003-03-24 12:57:31.000000000 +0100
> @@ -1182,11 +1182,14 @@
>  		INIT_LIST_HEAD(base->tv1.vec + j);
>
>  	base->timer_jiffies = INITIAL_JIFFIES;
> -	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
> -	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
> -	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
> -	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
> -	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
> +	base->tv1.index = (1 + (INITIAL_JIFFIES - 1)) & TVR_MASK;
> +	base->tv2.index = (1 + ((INITIAL_JIFFIES - 1) >> TVR_BITS)) & TVN_MASK;
> +	base->tv3.index = (1 + ((INITIAL_JIFFIES - 1)
> +				>> (TVR_BITS + TVN_BITS))) & TVN_MASK;
> +	base->tv4.index = (1 + ((INITIAL_JIFFIES - 1)
> +				>> (TVR_BITS + 2 * TVN_BITS))) & TVN_MASK;
> +	base->tv5.index = (1 + ((INITIAL_JIFFIES - 1)
> +				>> (TVR_BITS + 3 * TVN_BITS))) & TVN_MASK;
>  }
>
>  static int __devinit timer_cpu_notify(struct notifier_block *self,

Too late - the whole tv[1-5].index duplication is gone already after a
cleanup done by George Anzinger.

Tim

