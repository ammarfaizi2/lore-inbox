Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbVD1HVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbVD1HVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 03:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVD1HVf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 03:21:35 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:20876 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261837AbVD1HVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 03:21:25 -0400
Message-ID: <42708EE9.3010503@ens-lyon.org>
Date: Thu, 28 Apr 2005 09:21:13 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: David Addison <addy@quadrics.com>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
References: <426E62ED.5090803@quadrics.com>
In-Reply-To: <426E62ED.5090803@quadrics.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -267,6 +270,11 @@
>  
>  	unsigned long hiwater_rss;	/* High-water RSS usage */
>  	unsigned long hiwater_vm;	/* High-water virtual memory usage */
> +
> +#ifdef CONFIG_IOPROC
> +	/* hooks for io devices with advanced RDMA capabilities */
> +	struct ioproc_ops       *ioproc_ops;
> +#endif
>  };

> +int
> +ioproc_register_ops(struct mm_struct *mm, struct ioproc_ops *ip)
> +{
> +	ip->next = mm->ioproc_ops;
> +	mm->ioproc_ops = ip;
> +
> +	return 0;
> +}
> +
> +EXPORT_SYMBOL_GPL(ioproc_register_ops);
> +
> +int
> +ioproc_unregister_ops(struct mm_struct *mm, struct ioproc_ops *ip)
> +{
> +	struct ioproc_ops **tmp;
> +
> +	for (tmp = &mm->ioproc_ops; *tmp && *tmp != ip; tmp= &(*tmp)->next)
> +		;
> +	if (*tmp) {
> +		*tmp = ip->next;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +EXPORT_SYMBOL_GPL(ioproc_unregister_ops);

You don't seem to use any synchronization mechanism to protect the
ioproc list from concurrent modifications, right ?
I understand that it might be useless as long as QsNet is the only user
of ioprocs and takes care of locking the address space somewhere in the
driver before adding/removing hooks.
But, if this patch is to be merged to the mainline, you probably need
to do something here. It's not clear how other in-kernel users
(IB, Myri, Ammasso, ...) might use ioprocs.
And actually, I think all ioproc list traversal need to be protected
as well.

A spinlock_t ioproc_lock is probably appropriate here.
I don't know whether any of the existing locks in the task_struct
might be used instead.

Regards,
Brice
