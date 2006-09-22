Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbWIVL1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbWIVL1M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 07:27:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWIVL1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 07:27:12 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:930 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1751024AbWIVL1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 07:27:09 -0400
Date: Fri, 22 Sep 2006 05:27:08 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Hirokazu Takata <takata@linux-m32r.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] m32r: Revise __raw_read_trylock()
Message-ID: <20060922112708.GR2585@parisc-linux.org>
References: <swfzmcse7mm.wl%takata@linux-m32r.org> <20060922074813.GA20921@localhost.Internal.Linux-SH.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922074813.GA20921@localhost.Internal.Linux-SH.ORG>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 04:48:13PM +0900, Paul Mundt wrote:
> This might be a stupid question, but why exactly are we ripping out
> generic__raw_read_trylock() if architectures are going to implement a
> generic implementation anyways, rather than just changing it to match
> the proper semantics?

Because there is no generic definition of struct spinlock.

>  int __lockfunc generic__raw_read_trylock(raw_rwlock_t *lock)
>  {
> -	__raw_read_lock(lock);
> -	return 1;
> +	atomic_t *count = (atomic_t *)lock;
> +	atomic_dec(count);
> +	if (atomic_read(count) >= 0)
> +		return 1;
> +	atomic_inc(count);
> +	return 0;
>  }

You're assuming:

 - a spinlock is an atomic_t.
 - Said atomic_t uses RW_LOCK_BIAS to indicate locked/unlocked.

This is true for m32r, but not for sparc.  SuperH looks completely
broken -- I don't see how holding a read lock prevents someone else from
getting a write lock.  The SH write_trylock uses RW_LOCK_BIAS, but
write_lock doesn't.  Are there any SMP SH machines?
