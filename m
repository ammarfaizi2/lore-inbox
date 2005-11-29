Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751318AbVK2GJ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbVK2GJ3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 01:09:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVK2GJ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 01:09:29 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:62351 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751318AbVK2GJ2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 01:09:28 -0500
Date: Tue, 29 Nov 2005 11:41:06 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051129061106.GD4359@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20051128133757.GQ20775@brahms.suse.de> <20051128160129.GA8478@in.ibm.com> <20051128160547.GA20775@brahms.suse.de> <20051128161747.GA4359@in.ibm.com> <20051128162709.GC20775@brahms.suse.de> <20051128174203.GB4359@in.ibm.com> <20051129000158.GE7209@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051129000158.GE7209@brahms.suse.de>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2005 at 01:01:58AM +0100, Andi Kleen wrote:
> On Mon, Nov 28, 2005 at 11:12:03PM +0530, Dipankar Sarma wrote:
> 
> Ok third version, hopefully Dipankar proof now. 
> 

Not quite. I spoke without looking at the code of the whole
notifier_call_chain() function.

> + * 	against parallel traversals.
>   *
>   *	Returns zero on success, or %-ENOENT on failure.
>   */
> @@ -171,10 +177,12 @@
>  int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
>  {
>  	int ret=NOTIFY_DONE;
> -	struct notifier_block *nb = *n;
> -
> +	struct notifier_block *nb;
> +	smp_read_barrier_depends();
> +	nb = *n;
>  	while(nb)
>  	{
> +		smp_read_barrier_depends();
>  		ret=nb->notifier_call(nb,val,v);
>  		if(ret&NOTIFY_STOP_MASK)
>  		{

Looking at the full code, it seems to me that we dereference
the first notifier block only inside the while(nb) loop.
That means the smp_read_barrier_depends() in the while(nb)
loop should be sufficient - IOW, the previous version of
the patch with one smp_read_barrier_depends() was good. 
Sorry about the confusion.

Thanks
Dipankar
