Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752132AbWIXGUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbWIXGUi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 02:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbWIXGUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 02:20:38 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:31149 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1752132AbWIXGUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 02:20:37 -0400
Date: Sun, 24 Sep 2006 00:20:36 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Hirokazu Takata <takata@linux-m32r.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r: Revise __raw_read_trylock()
Message-ID: <20060924062036.GB30273@parisc-linux.org>
References: <swfzmcse7mm.wl%takata@linux-m32r.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <swfzmcse7mm.wl%takata@linux-m32r.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 03:29:53PM +0900, Hirokazu Takata wrote:
>  
> -#define __raw_read_trylock(lock) generic__raw_read_trylock(lock)
> +static inline int __raw_read_trylock(raw_rwlock_t *lock)
> +{
> +	atomic_t *count = (atomic_t*)lock;
> +	atomic_dec(count);
> +	if (atomic_read(count) >= 0)
> +		return 1;
> +	atomic_inc(count);
> +	return 0;
> +}
>  

Is there a race here between __raw_read_trylock and __raw_write_trylock?

CPU A			CPU B
__raw_read_trylock
atomic_dec(count);
			__raw_write_trylock
			atomic_sub_and_test(RW_LOCK_BIAS, count)
atomic_read(count)

It'd be fairly harmless as neither would manage to get the lock.  But
I think it's not too hard to fix.  Seems to me you want to do:

static inline int __raw_read_trylock(raw_rwlock_t *lock)
{
	atomic_t *count = (atomic_t*)lock;
	if (atomic_dec_return(count) >= 0)
		return 1;
	atomic_inc(count);
	return 0;
}

eliminating the race.
