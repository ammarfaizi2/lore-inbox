Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVLMATV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVLMATV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVLMATV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:19:21 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:19824 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932226AbVLMATU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:19:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Y3SmMwmG/+HlFgWD336L7cXBpnN6Z8bmDSPYlmFm+jErDB1/37O93XCeq97xyaNRmM+r4WMyvzW3T76yiE35zx4CYfKfpl3wqCWIabgYR4HLKpNhSnrzWcJSPa1KC9Y3e3f5S/vBYuCm8PVFDYDlNQRwSK1cG7bs4UrRrg5oH+A=  ;
Message-ID: <439E1381.2060201@yahoo.com.au>
Date: Tue, 13 Dec 2005 11:19:13 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
References: <dhowells1134431145@warthog.cambridge.redhat.com>
In-Reply-To: <dhowells1134431145@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:

> +	/* set up my own style of waitqueue */
> +	waiter.task = tsk;
> +

Any reason why you're setting up your own style of waitqueue in
mutex-simple.c instead of just using the kernel's style of waitqueue?

> +
> +/*
> + * release a single token back to a mutex
> + * - entered with lock held and interrupts disabled
> + * - the queue will not be empty
> + */
> +void __up(struct mutex *mutex)
> +{
> +	struct mutex_waiter *waiter;
> +	struct task_struct *tsk;
> +
> +	/* grant the token to the process at the front of the queue */
> +	waiter = list_entry(mutex->wait_list.next, struct mutex_waiter, list);
> +
> +	/* we must be careful not to touch 'waiter' after we set ->task = NULL.
> +	 * - it is an allocated on the waiter's stack and may become invalid at
> +	 *   any time after that point (due to a wakeup from another source).
> +	 */
> +	list_del_init(&waiter->list);
> +	tsk = waiter->task;
> +#ifdef CONFIG_DEBUG_MUTEX_OWNER
> +	mutex->__owner = tsk;
> +#endif
> +	mb();

This should be smp_mb(), I think.

> +	waiter->task = NULL;
> +	wake_up_process(tsk);
> +	put_task_struct(tsk);
> +}

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
