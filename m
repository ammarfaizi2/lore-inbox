Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750897AbVJTWpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbVJTWpu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 18:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJTWpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 18:45:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750889AbVJTWpt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 18:45:49 -0400
Date: Thu, 20 Oct 2005 15:44:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, arjan@infradead.org, dada1@cosmosbay.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 spinlocks should use the full 32 bits, not only 8
 bits
Message-Id: <20051020154457.100b5565.akpm@osdl.org>
In-Reply-To: <20051020222703.GA28221@elte.hu>
References: <Pine.LNX.4.64.0510110740050.14597@g5.osdl.org>
	<434BDB1C.60105@cosmosbay.com>
	<Pine.LNX.4.64.0510110902130.14597@g5.osdl.org>
	<434BEA0D.9010802@cosmosbay.com>
	<20051017000343.782d46fc.akpm@osdl.org>
	<1129533603.2907.12.camel@laptopd505.fenrus.org>
	<20051020215047.GA24178@elte.hu>
	<Pine.LNX.4.64.0510201455030.10477@g5.osdl.org>
	<20051020220228.GA26247@elte.hu>
	<Pine.LNX.4.64.0510201512480.10477@g5.osdl.org>
	<20051020222703.GA28221@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> +/*
>  + * We inline the unlock functions in the nondebug case:
>  + */
>  +#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT)
>  +# define spin_unlock(lock)		_spin_unlock(lock)
>  +# define read_unlock(lock)		_read_unlock(lock)
>  +# define write_unlock(lock)		_write_unlock(lock)
>  +#else
>  +# define spin_unlock(lock)		__raw_spin_unlock(&(lock)->raw_lock)
>  +# define read_unlock(lock)		__raw_read_unlock(&(lock)->raw_lock)
>  +# define write_unlock(lock)		__raw_write_unlock(&(lock)->raw_lock)
>  +#endif
>   

spin_lock is still uninlined.

static inline __attribute__((always_inline)) struct dentry *dget_parent(struct dentry *dentry)
{
 struct dentry *ret;

 _spin_lock(&dentry->d_lock);
 ret = dget(dentry->d_parent);
 __raw_spin_unlock(&(&dentry->d_lock)->raw_lock);
 return ret;
}

as is spin_lock_irqsave() and spin_lock_irq()

uninlining spin_lock will probably increase overall text size, but mainly in
the out-of-line section.

<looks>

we removed the out-of-line section :(


read_lock is out-of-line.   read_unlock is inlined

write_lock is out-of-line.  write_unlock is out-of-line.


Needs work ;)
