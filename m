Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263274AbSIPWnu>; Mon, 16 Sep 2002 18:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263280AbSIPWnu>; Mon, 16 Sep 2002 18:43:50 -0400
Received: from cibs9.sns.it ([192.167.206.29]:27664 "EHLO cibs9.sns.it")
	by vger.kernel.org with ESMTP id <S263274AbSIPWns>;
	Mon, 16 Sep 2002 18:43:48 -0400
Date: Tue, 17 Sep 2002 00:48:30 +0200 (CEST)
From: venom@sns.it
To: Robert Love <rml@tech9.net>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <linux-kernel@vger.kernel.org>,
       <spstarr@sh0n.net>
Subject: Re: BUG(): sched.c: Line 944 - 2.5.35
In-Reply-To: <1032201735.1010.7.camel@phantasy>
Message-ID: <Pine.LNX.4.43.0209170048150.8244-100000@cibs9.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I will try this tomorrow morning

Luigi

On 16 Sep 2002, Robert Love wrote:

> Date: 16 Sep 2002 14:42:13 -0400
> From: Robert Love <rml@tech9.net>
> To: Adam J. Richter <adam@yggdrasil.com>
> Cc: linux-kernel@vger.kernel.org, spstarr@sh0n.net, venom@sns.it
> Subject: Re: BUG(): sched.c: Line 944 - 2.5.35
>
> On Mon, 2002-09-16 at 12:36, Adam J. Richter wrote:
>
> > 	When I see this problem at boot, preempt_count() returns 0x4000000
> > (PREEMPT_ACTIVE) and kernel_locked() returns 0.
> >
> > 	I don't understand the semantics of PREEMPT_ACTIVE to know
> > whether to
> >
> > 	(1) change the test back to using in_interrupt instead of in_atomic, or
> > 	(2) change the definition of in_atomic(), or
> > 	(3) look for a bug somewhere else.
>
> There are two problems: First, PREEMPT_ACTIVE is indeed set on entry to
> schedule() from preempt_schedule() so we need to check for that too.
> Second, the BUG() is catching a bit of issues... you want something
> like:
>
> -	if (unlikely(in_atomic()))
> -		BUG();
> +	if (unlikely(in_atomic() && preempt_count() != PREEMPT_ACTIVE)) {
> +		printk(KERN_ERR "schedule() called while non-atomic!\n");
> +		show_stack(NULL);
> +	}
>
> I will send a patch to Linus.
>
> > 	However, I know experimentally that changing the test back to
> > using in_interrupt() results in a possibly unrelated BUG() at line 279
> > of rmap.c:
>
> This is unrelated.
>
> 	Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

