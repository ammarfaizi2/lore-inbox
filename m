Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272627AbTHFXma (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274968AbTHFXm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:42:29 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:44716 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S272627AbTHFXkt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:40:49 -0400
Date: Thu, 7 Aug 2003 01:40:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: cb-lkml@fish.zetnet.co.uk, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Disk priority dependend on nice level...
Message-ID: <20030806234036.GA209@elf.ucw.cz>
References: <20030806232810.GA1623@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806232810.GA1623@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
> but it compiles ;-).

It compiles, it event boots, but it does not seem to have much effect
:-(.

Test was like this:

bench:
#!/bin/bash
doit() {
    echo Unloaded system:
    time ./$1
    echo No nice:
    ./$1 loadonly &
    time ./$1
    killall $1
    killall bench_cat
    echo Nice -19:
    nice -n 19 ./$1 loadonly &
    time ./$1
    killall $1
    killall bench_cat
}

doit diskload


diskload:
#!/bin/bash
if [ "a$1" == aloadonly ]; then
	./bench_cat /usr/{bin,lib,lib/*}/* > /dev/null 2> /dev/null
	exit
fi
umount /suse
mount /suse
./bench_cat /suse/usr/bin/* > /dev/null 2> /dev/null


bench_cat is copy of /bin/cat.
									Pavel

> 
> --- clean/drivers/block/deadline-iosched.c	2003-07-27 22:31:10.000000000 +0200
> +++ linux/drivers/block/deadline-iosched.c	2003-08-07 01:26:47.000000000 +0200
> @@ -17,6 +17,7 @@
>  #include <linux/compiler.h>
>  #include <linux/hash.h>
>  #include <linux/rbtree.h>
> +#include <linux/sched.h>
>  
>  /*
>   * See Documentation/deadline-iosched.txt
> @@ -106,6 +107,19 @@
>  #define RQ_DATA(rq)	((struct deadline_rq *) (rq)->elevator_private)
>  
>  /*
> + * scale_deadline
> + */
> +static int scale_deadline(int default_deadline)
> +{
> +	int prio = current->static_prio - MAX_RT_PRIO;
> +	/* make priorities higher than nice -10 equal to nice -10 */
> +	if (prio < 10)
> +		prio = 10;
> +	/* scale the deadline according to priority */
> +	return default_deadline * prio/20;
> +}
> +
> +/*
>   * the back merge hash support functions
>   */
>  static inline void __deadline_del_drq_hash(struct deadline_rq *drq)
> @@ -303,7 +317,7 @@
>  	/*
>  	 * set expire time (only used for reads) and add to fifo list
>  	 */
> -	drq->expires = jiffies + dd->fifo_expire[data_dir];
> +	drq->expires = jiffies + scale_deadline(dd->fifo_expire[data_dir]);
>  	list_add_tail(&drq->fifo, &dd->fifo_list[data_dir]);
>  }
>  
>  

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
