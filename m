Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbVALBgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbVALBgS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 20:36:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262978AbVALBgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 20:36:18 -0500
Received: from web52610.mail.yahoo.com ([206.190.39.148]:5526 "HELO
	web52610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262974AbVALBgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 20:36:10 -0500
Message-ID: <20050112013610.20873.qmail@web52610.mail.yahoo.com>
Date: Wed, 12 Jan 2005 12:36:10 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [PROBLEM] Badness in cfq_account_completion at drivers/block/cfq-iosched.c:916
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, sriharivijayaraghavan@yahoo.com.au
In-Reply-To: <20050111090421.GG4551@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Jens Axboe <axboe@suse.de> wrote: 
> ... 
> Does this fix it?
> 
> ===== drivers/block/cfq-iosched.c 1.17 vs edited
> =====
> --- 1.17/drivers/block/cfq-iosched.c	2004-12-24
> 09:12:58 +01:00
> +++ edited/drivers/block/cfq-iosched.c	2005-01-11
> 10:03:17 +01:00
> @@ -622,8 +622,10 @@
>  			cfq_sort_rr_list(cfqq, 0);
>  		}
>  
> -		crq->accounted = 0;
> -		cfqq->cfqd->rq_in_driver--;
> +		if (crq->accounted) {
> +			crq->accounted = 0;
> +			cfqq->cfqd->rq_in_driver--;
> +		}
>  	}
>  	list_add(&rq->queuelist, &q->queue_head);
>  }

Yes, it does fix the problem with cfq, and the system
works fine. No more "Badness" error messages. Thanks
Jens.

While you are at it, is this acceptable?:
--- test/drivers/block/elevator.c.orig	2005-01-11
15:47:07.000000000 +1100
+++ test/drivers/block/elevator.c	2005-01-12
12:16:19.365813400 +1100
@@ -170,8 +170,6 @@
 #else
 #error "You must build at least 1 IO scheduler into
the kernel"
 #endif
-	printk(KERN_INFO "elevator: using %s as default io
scheduler\n",
-							chosen_elevator);
 }
 
 static int __init elevator_setup(char *str)
@@ -516,6 +514,9 @@
 	spin_unlock_irq(&elv_list_lock);
 
 	printk(KERN_INFO "io scheduler %s registered\n",
e->elevator_name);
+	if (!strcmp(e->elevator_name, chosen_elevator))
+		printk(KERN_INFO "elevator: using %s as default io
scheduler\n",
+                                                     
  e->elevator_name);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(elv_register);

It has an advantage of working even when one uses
"elevator=" kernel boot parameter. If it is wrong
completely, I am sorry about it.

Thank you.
Hari

PS: I am using web email interface, if things appear
funny, sorry about that.


Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
