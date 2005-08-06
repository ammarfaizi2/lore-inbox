Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263164AbVHFFHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263164AbVHFFHE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 01:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263168AbVHFFHD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 01:07:03 -0400
Received: from digitalimplant.org ([64.62.235.95]:59109 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S263164AbVHFFHC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 01:07:02 -0400
Date: Fri, 5 Aug 2005 22:06:49 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Nigel Cunningham <ncunningham@cyclades.com>
cc: Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] Workqueue freezer support.
In-Reply-To: <1123243967.3266.2.camel@localhost>
Message-ID: <Pine.LNX.4.50.0508052148280.19501-100000@monsoon.he.net>
References: <1121923059.2936.224.camel@localhost> 
 <Pine.LNX.4.50.0507211221550.12779-100000@monsoon.he.net>
 <1123243967.3266.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Aug 2005, Nigel Cunningham wrote:

> Hi.
>
> I finally found some time to finish this off. I don't really like the
> end result - the macros looked clearer to me - but here goes. If it
> looks okay, I'll seek sign offs from each of the affected driver
> maintainers and from Ingo. Anyone else?

What are your feelings about this: http://lwn.net/Articles/145417/ ?

It seems like a cleaner way to do things. How would these patches change
if that were merged?

Concerning the patch specifically:

> diff -ruNp 400-workthreads.patch-old/include/linux/kthread.h 400-workthreads.patch-new/include/linux/kthread.h
> --- 400-workthreads.patch-old/include/linux/kthread.h	2004-11-03 21:51:12.000000000 +1100
> +++ 400-workthreads.patch-new/include/linux/kthread.h	2005-08-03 11:52:01.000000000 +1000
> @@ -23,10 +23,20 @@
>   *
>   * Returns a task_struct or ERR_PTR(-ENOMEM).
>   */
> +struct task_struct *__kthread_create(int (*threadfn)(void *data),
> +				   void *data,
> +				   unsigned long freezer_flags,
> +				   const char namefmt[],
> +				   va_list * args);
> +

When comparing this to this:

> diff -ruNp 400-workthreads.patch-old/include/linux/workqueue.h 400-workthreads.patch-new/include/linux/workqueue.h
> --- 400-workthreads.patch-old/include/linux/workqueue.h	2005-06-20 11:47:30.000000000 +1000
> +++ 400-workthreads.patch-new/include/linux/workqueue.h	2005-08-03 11:49:34.000000000 +1000
> @@ -51,9 +51,12 @@ struct work_struct {
>  	} while (0)
>
>  extern struct workqueue_struct *__create_workqueue(const char *name,
> -						    int singlethread);
> -#define create_workqueue(name) __create_workqueue((name), 0)
> -#define create_singlethread_workqueue(name) __create_workqueue((name), 1)
> +						    int singlethread,
> +						    unsigned long freezer_flag);
> +#define create_workqueue(name) __create_workqueue((name), 0, 0)
> +#define create_nofreeze_workqueue(name) __create_workqueue((name), 0, PF_NOFREEZE)
> +#define create_singlethread_workqueue(name) __create_workqueue((name), 1, 0)
> +#define create_nofreeze_singlethread_workqueue(name) __create_workqueue((name), 1, PF_NOFREEZE)

And to this:


>  static struct task_struct *create_workqueue_thread(struct workqueue_struct *wq,
> -						   int cpu)
> +						   int cpu,
> +						   unsigned long freezer_flags)
>  {

There is a slight discrepancy in the API changes. Obviously, we don't want
to change every caller of create_workqueue() to support this. But, perhaps
you could standardize the handling of the freezer flags (by e.g. creating
a separate _nofreeze version for each).

Also, functions that take a va_list parameter pass the structure (array)
rather than the pointer. See the definition of vprintk() in
include/linux/kernel.h for an example.


Thanks,


	Pat
