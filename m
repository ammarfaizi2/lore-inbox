Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWENQof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWENQof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 May 2006 12:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWENQof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 May 2006 12:44:35 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:57814 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751493AbWENQoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 May 2006 12:44:34 -0400
Date: Sun, 14 May 2006 12:44:25 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Daniel Walker <dwalker@mvista.com>
cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -rt] scheduling while atomic in fs/file.c 
In-Reply-To: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com>
Message-ID: <Pine.LNX.4.58.0605141241320.25158@gandalf.stny.rr.com>
References: <200605141545.k4EFj6Cv001901@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 14 May 2006, Daniel Walker wrote:

> Quite the smp_processor_id() wanrings. I don't see any SMP
> concerns here . It just adds to a percpu list, so it shouldn't
> matter if it switches after sampling fdtable_defer_list .

I'm not so sure that there isn't SMP concerns here. I have to catch a
train in a few minutes, otherwise I would look deeper into this. But this
might be a candidate to turn fdtable_defer_list into a per_cpu_locked.

-- Steve

>
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>
>
> Index: linux-2.6.16/fs/file.c
> ===================================================================
> --- linux-2.6.16.orig/fs/file.c
> +++ linux-2.6.16/fs/file.c
> @@ -138,6 +138,8 @@ static void free_fdtable_rcu(struct rcu_
>  		kfree(fdt);
>  	} else {
>  		fddef = &get_cpu_var(fdtable_defer_list);
> +		put_cpu_var(fdtable_defer_list);
> +
>  		spin_lock(&fddef->lock);
>  		fdt->next = fddef->next;
>  		fddef->next = fdt;
> @@ -149,7 +151,6 @@ static void free_fdtable_rcu(struct rcu_
>  		if (!schedule_work(&fddef->wq))
>  			mod_timer(&fddef->timer, 5);
>  		spin_unlock(&fddef->lock);
> -		put_cpu_var(fdtable_defer_list);
>  	}
>  }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
