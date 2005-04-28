Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261977AbVD1JWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbVD1JWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 05:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbVD1JWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 05:22:41 -0400
Received: from mailgate.quadrics.com ([194.202.174.11]:54182 "EHLO
	qserv01.quadrics.com") by vger.kernel.org with ESMTP
	id S261946AbVD1JVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 05:21:53 -0400
Message-ID: <4270AB1E.3090000@quadrics.com>
Date: Thu, 28 Apr 2005 10:21:34 +0100
From: David Addison <addy@quadrics.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Linux VM hooks for advanced RDMA NICs
References: <426E62ED.5090803@quadrics.com> <42708EE9.3010503@ens-lyon.org>
In-Reply-To: <42708EE9.3010503@ens-lyon.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2005 09:15:32.0875 (UTC) FILETIME=[D46855B0:01C54BD2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:
>> @@ -267,6 +270,11 @@
>>  
>>      unsigned long hiwater_rss;    /* High-water RSS usage */
>>      unsigned long hiwater_vm;    /* High-water virtual memory usage */
>> +
>> +#ifdef CONFIG_IOPROC
>> +    /* hooks for io devices with advanced RDMA capabilities */
>> +    struct ioproc_ops       *ioproc_ops;
>> +#endif
>>  };
> 
>> +int
>> +ioproc_register_ops(struct mm_struct *mm, struct ioproc_ops *ip)
>> +{
>> +    ip->next = mm->ioproc_ops;
>> +    mm->ioproc_ops = ip;
>> +
>> +    return 0;
>> +}
>> +
>> +EXPORT_SYMBOL_GPL(ioproc_register_ops);
>> +
>> +int
>> +ioproc_unregister_ops(struct mm_struct *mm, struct ioproc_ops *ip)
>> +{
>> +    struct ioproc_ops **tmp;
>> +
>> +    for (tmp = &mm->ioproc_ops; *tmp && *tmp != ip; tmp= &(*tmp)->next)
>> +        ;
>> +    if (*tmp) {
>> +        *tmp = ip->next;
>> +        return 0;
>> +    }
>> +
>> +    return -EINVAL;
>> +}
>> +
>> +EXPORT_SYMBOL_GPL(ioproc_unregister_ops);
> 
> You don't seem to use any synchronization mechanism to protect the
> ioproc list from concurrent modifications, right ?
> I understand that it might be useless as long as QsNet is the only user
> of ioprocs and takes care of locking the address space somewhere in the
> driver before adding/removing hooks.
> But, if this patch is to be merged to the mainline, you probably need
> to do something here. It's not clear how other in-kernel users
> (IB, Myri, Ammasso, ...) might use ioprocs.
> And actually, I think all ioproc list traversal need to be protected
> as well.
> 
All ioproc list traversal is protected by the mm->page_table_lock which is
held at all points where the callbacks are invoked.
[Actually there is one case where this isn't true, which I'll fix
when we refresh this patch later today]

The registration/unregister functions also need to be called holding this
spinlock, our device driver does this, but perhaps we need to document
that requirement more clearly.

Cheers
David.
