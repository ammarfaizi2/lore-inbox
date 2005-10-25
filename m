Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVJYXai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVJYXai (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVJYXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 19:30:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:35750 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932476AbVJYXah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 19:30:37 -0400
Subject: Re: Notifier chains are unsafe
From: Chandra Seetharaman <sekharan@us.ibm.com>
Reply-To: sekharan@us.ibm.com
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.0510241634410.4448-100000@iolanthe.rowland.org>
Content-Type: text/plain
Organization: IBM
Date: Tue, 25 Oct 2005 16:30:36 -0700
Message-Id: <1130283036.3586.148.camel@linuxchandra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-24 at 16:48 -0400, Alan Stern wrote:

Hi Alan,

I agree with your approach of having a notifier_head to have both the
head of the notifier_list and the corresponding lock (instead of having
a single global rwlock to protect all notifier lists).

But, I am confused about the need for three data structures and two next
pointers. I think we can achieve the same by 2 data structures:

	notifier_head {
		spinlock_t lock;
		list_head  head;
	};
	notifier_block {
		int (*notifier_call)(struct notifier_block *self,
			unsigned long, void *);
		list_head lists;
		int priority;
	};

I think that having multiple data structures make the code hard to
follow.

No. of register/unregister would be a lot lesser than a
notifier_call_chain() calls, so IMHO, rwlock would be a better option.	

<snip>
>  /**
>   *	notifier_call_chain - Call functions in a notifier chain
> - *	@n: Pointer to root pointer of notifier chain
> + *	@nh: Pointer to head of the notifier chain
>   *	@val: Value passed unmodified to notifier function
>   *	@v: Pointer passed unmodified to notifier function
>   *
> @@ -167,20 +194,28 @@ EXPORT_SYMBOL(notifier_chain_unregister)
>   *	of the last notifier function called.
>   */
>   
> -int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
> +int notifier_call_chain(struct notifier_head *nh, unsigned long val, void *v)
>  {
> -	int ret=NOTIFY_DONE;
> -	struct notifier_block *nb = *n;
> +	int ret = NOTIFY_DONE;
> +	struct notifier_caller caller;
> +	struct notifier_block *n;
>  
> -	while(nb)
> -	{
> -		ret=nb->notifier_call(nb,val,v);
> -		if(ret&NOTIFY_STOP_MASK)
> -		{
> -			return ret;
> -		}
> -		nb=nb->next;
> +	spin_lock(&nh->lock);
> +	caller.next = nh->first;
> +	list_add(&caller.node, &nh->callers);
> +
> +	while (caller.next) {
> +		n = caller.next;
> +		caller.next = n->next;
> +		spin_unlock(&nh->lock);
> +		ret = n->notifier_call(n, val, v);
> +		spin_lock(&nh->lock);
> +		if (ret & NOTIFY_STOP_MASK)
> +			break;
>  	}

Since the lock is being dropped while calling notifier_call, how are we
guaranteed caller.next is valid ? It might have been unregistered.
> +
> +	list_del(&caller.node);
> +	spin_unlock(&nh->lock);
>  	return ret;
>  }
>  

-- 

----------------------------------------------------------------------
    Chandra Seetharaman               | Be careful what you choose....
              - sekharan@us.ibm.com   |      .......you may get it.
----------------------------------------------------------------------


