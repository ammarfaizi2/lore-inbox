Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317426AbSG1WxZ>; Sun, 28 Jul 2002 18:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSG1WxY>; Sun, 28 Jul 2002 18:53:24 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:20242 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317426AbSG1WwT>; Sun, 28 Jul 2002 18:52:19 -0400
Date: Mon, 29 Jul 2002 00:55:26 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Christoph Hellwig <hch@infradead.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, <dhowells@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Patch: linux-2.5.29 __downgrade_write() for CONFIG_RWSEM_GENERIC_SPINLOCK
In-Reply-To: <20020728190851.A14392@infradead.org>
Message-ID: <Pine.LNX.4.44.0207290048070.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 28 Jul 2002, Christoph Hellwig wrote:

> -static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem)
> +static inline struct rw_semaphore *__rwsem_do_wake(struct rw_semaphore *sem, int wakewrite)
>  {
>  	struct rwsem_waiter *waiter;
>  	int woken;
> @@ -56,7 +57,14 @@ static inline struct rw_semaphore *__rws
>
>  	waiter = list_entry(sem->wait_list.next,struct rwsem_waiter,list);
>
> -	/* try to grant a single write lock if there's a writer at the front of the queue
> +	if (!wakewrite) {
> +		if (waiter->flags & RWSEM_WAITING_FOR_WRITE)
> +			goto out;
> +		goto dont_wake_writers;
> +	}
> +
> +	/* if we are allowed to wake writers try to grant a single write lock if there's a
> +	 * writer at the front of the queue
>  	 * - we leave the 'waiting count' incremented to signify potential contention
>  	 */
>  	if (waiter->flags & RWSEM_WAITING_FOR_WRITE) {

You don't really need that extra argument, testing sem->activity should do
the same job.
If you exchange the wakewrite (or sem->activity) test and the
waiter->flags you can fold it into the next test (this means all the extra
work would only be done, if we have a writer waiting at the top).

bye, Roman

