Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVKDXRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVKDXRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 18:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbVKDXRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 18:17:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25551 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750917AbVKDXRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 18:17:52 -0500
Date: Fri, 4 Nov 2005 15:17:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk
Subject: Re: [patch] collie: enable frontlight
Message-Id: <20051104151751.32c1abe7.akpm@osdl.org>
In-Reply-To: <20051101232122.GA27107@elf.ucw.cz>
References: <20051101232122.GA27107@elf.ucw.cz>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> +static spinlock_t fl_lock = SPIN_LOCK_UNLOCKED;
> +
> +#define LCM_ALC_EN	0x8000
> +
> +void frontlight_set(struct locomo *lchip, int duty, int vr, int bpwf)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fl_lock, flags);
> +	locomo_writel(bpwf, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
> +	udelay(100);
> +	locomo_writel(duty, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALD);
> +	locomo_writel(bpwf | LCM_ALC_EN, lchip->base + LOCOMO_FRONTLIGHT + LOCOMO_ALS);
> +	spin_unlock_irqrestore(&fl_lock, flags);
> +}

ick, a 100 microsecond glitch, quite unnecessary.  Why not use a semaphore
here, if any locking is actually needed?  (It's called from device probe -
there's higher-level serialisation, no?)
