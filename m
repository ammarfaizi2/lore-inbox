Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261785AbSIXUmT>; Tue, 24 Sep 2002 16:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261789AbSIXUmT>; Tue, 24 Sep 2002 16:42:19 -0400
Received: from [195.39.17.254] ([195.39.17.254]:1796 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261785AbSIXUmS>;
	Tue, 24 Sep 2002 16:42:18 -0400
Date: Sun, 22 Sep 2002 00:48:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: torvalds@transmeta.com, akpm@zip.com.au, ingo@redhat.com,
       linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] de-xchg fork.c
Message-ID: <20020922004825.A35@toy.ucw.cz>
References: <20020923011053.436B22C12D@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020923011053.436B22C12D@lists.samba.org>; from rusty@rustcorp.com.au on Mon, Sep 23, 2002 at 11:06:14AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Don't know who put this in for 2.5.38.
> 
> I realize that using xchg() makes you 'leet.  But doing an atomic op
> where none is required is suboptimal and confusing.

Well, atomic op is also more expensive. i think ingo did this. Ingo, is
patch below safe? It is faster *and* it works on 386.
								Pavel 

> diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.38/kernel/fork.c working-2.5.38-unxchg/kernel/fork.c
> --- linux-2.5.38/kernel/fork.c	2002-09-21 13:55:19.000000000 +1000
> +++ working-2.5.38-unxchg/kernel/fork.c	2002-09-23 11:00:31.000000000 +1000
> @@ -64,11 +64,12 @@ void __put_task_struct(struct task_struc
>  	} else {
>  		int cpu = smp_processor_id();
>  
> -		tsk = xchg(task_cache + cpu, tsk);
> +		tsk = task_cache[cpu];
>  		if (tsk) {
>  			free_thread_info(tsk->thread_info);
>  			kmem_cache_free(task_struct_cachep,tsk);
>  		}
> +		task_cache[cpu] = current;
>  	}
>  }

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

