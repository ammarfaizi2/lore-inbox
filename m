Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWACNZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWACNZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWACNZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:10 -0500
Received: from smtp105.plus.mail.mud.yahoo.com ([68.142.206.238]:54384 "HELO
	smtp105.plus.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751400AbWACNZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=ZTHza2tQzKuhzWKXI/dZyqOgbnylYozpN4DISAGT0y2vAzJsxximNrhYcLeAzzvNWfI0Y132B4yc7Pd0p7jbjh43+95KYhdCLEm/XjMPmV2457FZ3E6zHQOd7U2tS79EVMz5yPjYSOVp1/UDr1UKeBFGfgL18HzZ7FMHU/vNBvw=  ;
Message-ID: <43BA7B2E.4070101@yahoo.com.au>
Date: Wed, 04 Jan 2006 00:25:02 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Nicolas Pitre <nico@cam.org>, Jes Sorensen <jes@trained-monkey.org>,
       Al Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [patch 04/19] mutex subsystem, add include/asm-i386/mutex.h
References: <20060103100737.GD23289@elte.hu>
In-Reply-To: <20060103100737.GD23289@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> From: Arjan van de Ven <arjan@infradead.org>
> 
> add the i386 version of mutex.h, optimized in assembly.
> 

> +static inline int
> +__mutex_fastpath_trylock(atomic_t *count, int (*fail_fn)(atomic_t *))
> +{
> +	/*
> +	 * We have two variants here. The cmpxchg based one is the best one
> +	 * because it never induce a false contention state.  It is included
> +	 * here because architectures using the inc/dec algorithms over the
> +	 * xchg ones are much more likely to support cmpxchg natively.
> +	 *
> +	 * If not we fall back to the spinlock based variant - that is
> +	 * just as efficient (and simpler) as a 'destructive' probing of
> +	 * the mutex state would be.
> +	 */
> +#ifdef __HAVE_ARCH_CMPXCHG
> +	if (likely(atomic_cmpxchg(count, 1, 0)) == 1)
> +		return 1;
> +	return 0;
> +#else
> +	return fail_fn(count);
> +#endif
> +}

asm-i386 version I think really should just use atomic_cmpxchg unconditionally,
because otherwise an i386 compatible kernel will not use cmpxchg even when
running on 486+ (not sure how important that is these days, but still...).

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
