Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUAAUsD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 15:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265466AbUAAUqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 15:46:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:29617 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264947AbUAAUoa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 15:44:30 -0500
Date: Thu, 1 Jan 2004 12:45:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: joneskoo@derbian.org, linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
Message-Id: <20040101124504.69c80a14.akpm@osdl.org>
In-Reply-To: <20040101130147.GM28023@krispykreme>
References: <20040101093553.GA24788@derbian.org>
	<20040101101541.GJ28023@krispykreme>
	<20040101022553.2be5f043.akpm@osdl.org>
	<20040101130147.GM28023@krispykreme>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
> 
> > So sure, ratelimit it, make it KERN_INFO and maybe add a dump_stack()?
> 
> Sounds good, I always end up adding a dump_stack there when debugging
> these problems anyway.
> 
> > (printk_ratelimit() may be a suitable name)
> 
> How does this look?

Good.  I guess we need to make net_ratelimit() use this sometime.

> +/* 
> + * printk rate limiting, lifted from the networking subsystem.
> + *
> + * This enforces a rate limit: not more than one kernel message
> + * every printk_ratelimit_jiffies to make a denial-of-service 
> + * attack impossible.
> + */ 
> +int printk_ratelimit(void)
> +{
> +	static spinlock_t ratelimit_lock = SPIN_LOCK_UNLOCKED;
> +	static unsigned long toks = 10*5*HZ;
> +	static unsigned long last_msg; 
> +	static int missed;
> +	unsigned long flags;
> +	unsigned long now = jiffies;
> +
> +	spin_lock_irqsave(&ratelimit_lock, flags);
> +	toks += now - last_msg;
> +	last_msg = now;
> +	if (toks > (printk_ratelimit_burst * printk_ratelimit_jiffies))
> +		toks = printk_ratelimit_burst * printk_ratelimit_jiffies;
> +	if (toks >= printk_ratelimit_jiffies) {
> +		int lost = missed;
> +		missed = 0;
> +		toks -= printk_ratelimit_jiffies;
> +		spin_unlock_irqrestore(&ratelimit_lock, flags);
> +		if (lost)
> +			printk(KERN_WARNING "printk: %d messages suppressed.\n", lost);
> +		return 1;
> +	}
> +	missed++;
> +	spin_unlock_irqrestore(&ratelimit_lock, flags);
> +	return 0;
> +}

This seems a bit odd.  It means that the further apart the message bursts
are, the longer they are allowed to be.  Or something.

Wouldn't it be better to say "after each greater-than-five second window,
allow up to ten printk's as long as they happen in the next five
milliseconds"?

