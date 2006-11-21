Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934332AbWKUGUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934332AbWKUGUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 01:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934337AbWKUGUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 01:20:22 -0500
Received: from smtp.osdl.org ([65.172.181.25]:23963 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S934332AbWKUGUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 01:20:20 -0500
Date: Mon, 20 Nov 2006 22:19:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: ego@in.ibm.com
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, vatsa@in.ibm.com,
       dipankar@in.ibm.com, davej@redhat.com, mingo@elte.hu,
       kiran@scalex86.org
Subject: Re: [PATCH 1/4] Extend notifier_call_chain to count nr_calls made.
Message-Id: <20061120221941.e2c379b3.akpm@osdl.org>
In-Reply-To: <20061114122050.GB31787@in.ibm.com>
References: <20061114121832.GA31787@in.ibm.com>
	<20061114122050.GB31787@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2006 17:50:51 +0530
Gautham R Shenoy <ego@in.ibm.com> wrote:

> Provide notifier_call_chain with an option to call only a specified number of 
> notifiers and also record the number of call to notifiers made.
> 
> The need for this enhancement was identified in the post entitled 
> "Slab - Eliminate lock_cpu_hotplug from slab" 
> (http://lkml.org/lkml/2006/10/28/92) by Ravikiran G Thirumalai and 
> Andrew Morton.
> 
> This patch adds two additional parameters to notifier_call_chain API namely 
>  - int nr_to_calls : Number of notifier_functions to be called. 
>  		     The don't care value is -1.
> 
>  - unsigned int *nr_calls : Records the total number of notifier_funtions 
> 			    called by notifier_call_chain. The don't care
> 			    value is NULL.
> 
> ...
>
> +
>  static int __kprobes notifier_call_chain(struct notifier_block **nl,
> -		unsigned long val, void *v)
> +					unsigned long val, void *v,
> +					int nr_to_call,	unsigned int *nr_calls)
>  {
>  	int ret = NOTIFY_DONE;
>  	struct notifier_block *nb, *next_nb;
>  
>  	nb = rcu_dereference(*nl);
> -	while (nb) {
> +
> +	while (nb && nr_to_call) {
>  		next_nb = rcu_dereference(nb->next);
>  		ret = nb->notifier_call(nb, val, v);
> +
> +		if (nr_calls)
> +			*nr_calls ++;

This gets

kernel/sys.c: In function 'notifier_call_chain':
kernel/sys.c:164: warning: value computed is not used


And indeed, this code doesn't work.

What happened?

