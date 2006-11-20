Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966438AbWKTS5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966438AbWKTS5W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966440AbWKTS5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:57:22 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:39850 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S966438AbWKTS5V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:57:21 -0500
Date: Mon, 20 Nov 2006 21:57:12 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] cpufreq: mark cpufreq_tsc() as core_initcall_sync
Message-ID: <20061120185712.GA95@oleg>
References: <20061119214315.GI4427@us.ibm.com> <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0611201212040.3224-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20, Alan Stern wrote:
>
> @@ -158,6 +199,11 @@ void synchronize_srcu(struct srcu_struct
>
> [... snip ...]
>
> +#ifdef	SMP__STORE_MB_LOAD_WORKS	/* The fast path */
> +	if (srcu_readers_active_idx(sp, idx) == 0)
> +		goto done;
> +#endif

I guess this is connected to another message from you,

> But of course it _is_ needed for the fastpath to work.  In fact, it might
> not be good enough, depending on the architecture.  Here's what the
> fastpath ends up looking like (using c[idx] is essentially the same as
> using hardluckref):
> 
>         WRITER                          READER
>         ------                          ------
>         dataptr = &(new data)           atomic_inc(&hardluckref)
>         mb                              mb
>         while (hardluckref > 0) ;       access *dataptr
> 
> Notice the pattern: Each CPU does store-mb-load.  It is known that on
> some architectures each CPU can end up loading the old value (the value
> from before the other CPU's store).  This would mean the writer would see
> hardluckref == 0 right away and the reader would see the old dataptr.

So, if we have global A == B == 0,

	CPU_0		CPU_1

	A = 1;		B = 2;
	mb();		mb();
	b = B;		a = A;

It could happen that a == b == 0, yes? Isn't this contradicts with definition
of mb?

By definition, when CPU_0 issues 'b = B', 'A = 1' should be visible to other
CPUs, yes? Now, b == 0 means that CPU_1 did not read 'a = A' yet, otherwise
'B = 2' should be visible to all CPUs (by definition again).

Could you please clarify this?

Btw, this is funny, but I was going to suggest _exactly_ same cleanup for
srcu_read_lock :)

Oleg.

