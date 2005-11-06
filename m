Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVKFVu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVKFVu3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 16:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbVKFVu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 16:50:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20384 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932225AbVKFVu2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 16:50:28 -0500
Date: Sun, 6 Nov 2005 13:49:45 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: paulmck@us.ibm.com, linux-kernel@vger.kernel.org, oleg@tv-sign.ru,
       dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
Message-Id: <20051106134945.0e10cb60.akpm@osdl.org>
In-Reply-To: <20051031140459.GA5664@elte.hu>
References: <20051031020535.GA46@us.ibm.com>
	<20051031140459.GA5664@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> ...
> 
> RCU signal handling: send signals RCU-read-locked instead of 
> tasklist_lock read-locked. This is a scalability improvement on SMP and 
> a preemption-latency improvement under PREEMPT_RCU.
> 
> Signed-off-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> ...
> +static inline int get_task_struct_rcu(struct task_struct *t)
> +{
> +	int oldusage;
> +
> +	do {
> +		oldusage = atomic_read(&t->usage);
> +		if (oldusage == 0) {
> +			return 0;
> +		}
> +	} while (cmpxchg(&t->usage.counter,
> +		 oldusage, oldusage + 1) != oldusage);
> +	return 1;
> +}

arm (at least) does not implement cmpxchg.

I think Nick is working on patches which implement cmpxchg on all
architectures?
