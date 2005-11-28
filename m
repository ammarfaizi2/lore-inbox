Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVK1P7v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVK1P7v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 10:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVK1P7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 10:59:51 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41680 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932117AbVK1P7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 10:59:50 -0500
Date: Mon, 28 Nov 2005 21:31:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051128160129.GA8478@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20051128133757.GQ20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128133757.GQ20775@brahms.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 02:37:57PM +0100, Andi Kleen wrote:
> 
> As discussed in other thread.
> 
> Just needed an additional write barrier, so that a parallel
> running lockup can never see inconsistent state. As long as there
> is no unregistration or the unregistration is done using
> locking or RCU in the caller they should be ok now.
> 
> This only makes a difference on non i386/x86-64 architectures.
> x86 was already ok because it never reorders writes.
> 
>   *
>   *	Currently always returns zero.
>   */
> @@ -116,6 +119,7 @@
>  		list= &((*list)->next);
>  	}
>  	n->next = *list;
> +	wmb();
>  	*list=n;
>  	write_unlock(&notifier_lock);

Shouldn't this be smp_wmb() ?

Also, not all archs have strong ordering for data dependent reads.
So, you would probably need an smp_read_barrier_depends() between
the load of the pointer and actual dereferencing.

Thanks
Dipankar
