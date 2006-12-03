Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760118AbWLCV0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760118AbWLCV0l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760129AbWLCV00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:26:26 -0500
Received: from smtp.osdl.org ([65.172.181.25]:13716 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1760127AbWLCV0W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:26:22 -0500
Date: Sun, 3 Dec 2006 13:26:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: minyard@acm.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       OpenIPMI Developers <openipmi-developer@lists.sourceforge.net>,
       Carol Hebert <cah@us.ibm.com>
Subject: Re: [Patch 2/12] IPMI: remove interface number limits
Message-Id: <20061203132605.ee8028a5.akpm@osdl.org>
In-Reply-To: <20061202042422.GB30214@localdomain>
References: <20061202042422.GB30214@localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 22:24:22 -0600
Corey Minyard <minyard@acm.org> wrote:

> 
> This patch removes the arbitrary limit of number of IPMI interfaces.
> This has been tested with 8 interfaces.
> 
> Signed-off-by: Corey Minyard <minyard@acm.org>
> Cc: Carol Hebert <cah@us.ibm.com>
> 
> ..
>
> +struct watcher_entry {
> +	struct list_head link;
> +	int intf_num;
> +};
> +
>  int ipmi_smi_watcher_register(struct ipmi_smi_watcher *watcher)
>  {
> -	int           i;
> -	unsigned long flags;
> +	ipmi_smi_t intf;
> +	struct list_head to_deliver = LIST_HEAD_INIT(to_deliver);
> +	struct watcher_entry *e, *e2;
> +
> +	mutex_lock(&ipmi_interfaces_mutex);
> +
> +	list_for_each_entry_rcu(intf, &ipmi_interfaces, link) {
> +		if (intf->intf_num == -1)
> +			continue;
> +		e = kmalloc(sizeof(*e), GFP_KERNEL);
> +		if (!e)
> +			goto out_err;

You miss a mutex_unlock(&ipmi_interfaces_mutex) here

> +		e->intf_num = intf->intf_num;
> +		list_add_tail(&e->link, &to_deliver);
> +	}
>  
>  	down_write(&smi_watchers_sem);
>  	list_add(&(watcher->link), &smi_watchers);
>  	up_write(&smi_watchers_sem);
> -	spin_lock_irqsave(&interfaces_lock, flags);
> -	for (i = 0; i < MAX_IPMI_INTERFACES; i++) {
> -		ipmi_smi_t intf = ipmi_interfaces[i];
> -		if (IPMI_INVALID_INTERFACE(intf))
> -			continue;
> -		spin_unlock_irqrestore(&interfaces_lock, flags);
> -		watcher->new_smi(i, intf->si_dev);
> -		spin_lock_irqsave(&interfaces_lock, flags);
> +
> +	mutex_unlock(&ipmi_interfaces_mutex);
> +
> +	list_for_each_entry_safe(e, e2, &to_deliver, link) {
> +		list_del(&e->link);
> +		watcher->new_smi(e->intf_num, intf->si_dev);
> +		kfree(e);
>  	}
> -	spin_unlock_irqrestore(&interfaces_lock, flags);
> +
> +
>  	return 0;
> +
> + out_err:
> +	list_for_each_entry_safe(e, e2, &to_deliver, link) {
> +		list_del(&e->link);
> +		kfree(e);
> +	}
> +	return -ENOMEM;
>  }
>  
> ...
>

