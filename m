Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWI2WxM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWI2WxM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 18:53:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWI2WxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 18:53:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:17559 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964785AbWI2WxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 18:53:10 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: girish <girishvg@gmail.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       William Pitcock <nenolod@atheme.org>
Subject: Re: [PATCH] include children count, in Threads: field present in /proc/<pid>/status (take-3)
References: <0635847A-C149-412C-92B1-A974230381F8@dts.local>
	<F2F2C98F-6AFB-4E19-BEE9-D32652E2F478@atheme.org>
	<EE7C757E-E2CE-4617-A1D4-3B8F5E3E8240@gmail.com>
	<Pine.LNX.4.61.0609291905550.27518@yvahk01.tjqt.qr>
	<CF74CE5D-42A1-4FF9-8C9B-682C5D6DEAE1@gmail.com>
	<Pine.LNX.4.61.0609292011190.634@yvahk01.tjqt.qr>
	<BEC70F7E-6143-4D8D-9800-A8538A152A18@gmail.com>
Date: Fri, 29 Sep 2006 16:51:24 -0600
In-Reply-To: <BEC70F7E-6143-4D8D-9800-A8538A152A18@gmail.com>
	(girishvg@gmail.com's message of "Sat, 30 Sep 2006 03:24:41 +0900")
Message-ID: <m1mz8ii8wj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This conflicts with the /proc changes in -mm.
Where we have manged to remove the use of the tasklist_lock.

The information in Children: is racy as it may change immediately
after you drop the lock.

Why is it interesting to report this information?
A process that cares can keep track of this in user space?

Eric

> Signed-off-by: Girish V. Gulawani <girishvg@gmail.com>
>
> --- linux-vanilla/fs/proc/array.c	2006-09-20 12:42:06.000000000 +0900
> +++ linux/fs/proc/array.c	2006-09-30 03:18:28.000000000 +0900
> @@ -248,6 +248,8 @@ static inline char * task_sig(struct tas
>  	int num_threads = 0;
>  	unsigned long qsize = 0;
>  	unsigned long qlim = 0;
> +	int num_children = 0;
> +	struct list_head *_p;
>
>  	sigemptyset(&pending);
>  	sigemptyset(&shpending);
> @@ -268,9 +270,13 @@ static inline char * task_sig(struct tas
>  		qlim = p->signal->rlim[RLIMIT_SIGPENDING].rlim_cur;
>  		spin_unlock_irq(&p->sighand->siglock);
>  	}
> +	list_for_each(_p, &p->children)
> +		++num_children;
>  	read_unlock(&tasklist_lock);
>
>  	buffer += sprintf(buffer, "Threads:\t%d\n", num_threads);
> +	if (num_children)
> +		buffer += sprintf(buffer, "Children:\t%d\nTotal:\t%d\n",
> num_children, num_threads + num_children);
>  	buffer += sprintf(buffer, "SigQ:\t%lu/%lu\n", qsize, qlim);
>
>  	/* render them all */
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
