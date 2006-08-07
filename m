Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932331AbWHGT7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbWHGT7y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWHGT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:59:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3762 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932331AbWHGT7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:59:53 -0400
Date: Mon, 7 Aug 2006 12:58:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: schwidefsky@googlemail.com, johnstul@us.ibm.com, zippel@linux-m68k.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, ak@muc.de, schwidefsky@de.ibm.com
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
Message-Id: <20060807125810.e021c91b.akpm@osdl.org>
In-Reply-To: <20060807.011319.41196590.anemo@mba.ocn.ne.jp>
References: <6e0cfd1d0608020550k7ae2c44dg94afbe56d66b@mail.gmail.com>
	<20060804.005352.128616651.anemo@mba.ocn.ne.jp>
	<6e0cfd1d0608040702h15371d31q1c3d1c305c3da424@mail.gmail.com>
	<20060807.011319.41196590.anemo@mba.ocn.ne.jp>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 01:13:19 +0900 (JST)
Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:

> On Fri, 4 Aug 2006 16:02:43 +0200, "Martin Schwidefsky" <schwidefsky@googlemail.com> wrote:
> > Good start, now you only have the change the 30+ calls to do_timer in
> > the various architecture backends.
> 
> OK, then this is a patch contains the changes.
> Adding S390 maintainer Martin Schwidefsky to CC.
> 
> This patch is against current git tree, so does not contains a change
> to arch/avr32 which is in mm tree.  I can create a patch against mm
> tree if expected.
> 
> 
> [PATCH] cleanup do_timer and update_times
> 
> Pass ticks to do_timer() and update_times().
> 
> This also make a barrier added by
> 5aee405c662ca644980c184774277fc6d0769a84 needless.
> 
> Also adjust x86_64 and s390 timer interrupt handler with this change.
> 

This is a rather terse description for a change of this nature..

Why was this patch created?  What problem is it solving?  etcetera.

> ...
>
> --- a/kernel/timer.c
> +++ b/kernel/timer.c
> @@ -1218,7 +1218,7 @@ static inline void calc_load(unsigned lo
>  	static int count = LOAD_FREQ;
>  
>  	count -= ticks;
> -	if (count < 0) {
> +	while (count < 0) {
>  		count += LOAD_FREQ;
>  		active_tasks = count_active_tasks();
>  		CALC_LOAD(avenrun[0], EXP_1, active_tasks);

OK, we do need the loop here to get the arithmetic in CALC_LOAD to work
correctly.

But I don't think the expensive count_active_tasks() needs to be evaluated
each time around.

