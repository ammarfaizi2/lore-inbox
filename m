Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261260AbVALHmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbVALHmg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 02:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVALHmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 02:42:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:32919 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261260AbVALHmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 02:42:32 -0500
Date: Wed, 12 Jan 2005 08:42:29 +0100
From: Jens Axboe <axboe@suse.de>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] Badness in cfq_account_completion at drivers/block/cfq-iosched.c:916
Message-ID: <20050112074225.GF2793@suse.de>
References: <20050111090421.GG4551@suse.de> <20050112013610.20873.qmail@web52610.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112013610.20873.qmail@web52610.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12 2005, Srihari Vijayaraghavan wrote:
>  --- Jens Axboe <axboe@suse.de> wrote: 
> > ... 
> > Does this fix it?
> > 
> > ===== drivers/block/cfq-iosched.c 1.17 vs edited
> > =====
> > --- 1.17/drivers/block/cfq-iosched.c	2004-12-24
> > 09:12:58 +01:00
> > +++ edited/drivers/block/cfq-iosched.c	2005-01-11
> > 10:03:17 +01:00
> > @@ -622,8 +622,10 @@
> >  			cfq_sort_rr_list(cfqq, 0);
> >  		}
> >  
> > -		crq->accounted = 0;
> > -		cfqq->cfqd->rq_in_driver--;
> > +		if (crq->accounted) {
> > +			crq->accounted = 0;
> > +			cfqq->cfqd->rq_in_driver--;
> > +		}
> >  	}
> >  	list_add(&rq->queuelist, &q->queue_head);
> >  }
> 
> Yes, it does fix the problem with cfq, and the system
> works fine. No more "Badness" error messages. Thanks
> Jens.

Super, thanks.

> While you are at it, is this acceptable?:
> --- test/drivers/block/elevator.c.orig	2005-01-11
> 15:47:07.000000000 +1100
> +++ test/drivers/block/elevator.c	2005-01-12
> 12:16:19.365813400 +1100
> @@ -170,8 +170,6 @@
>  #else
>  #error "You must build at least 1 IO scheduler into
> the kernel"
>  #endif
> -	printk(KERN_INFO "elevator: using %s as default io
> scheduler\n",
> -							chosen_elevator);
>  }
>  
>  static int __init elevator_setup(char *str)
> @@ -516,6 +514,9 @@
>  	spin_unlock_irq(&elv_list_lock);
>  
>  	printk(KERN_INFO "io scheduler %s registered\n",
> e->elevator_name);
> +	if (!strcmp(e->elevator_name, chosen_elevator))
> +		printk(KERN_INFO "elevator: using %s as default io
> scheduler\n",
> +                                                     
>   e->elevator_name);
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(elv_register);
> 
> It has an advantage of working even when one uses
> "elevator=" kernel boot parameter. If it is wrong
> completely, I am sorry about it.

Yes that's a good idea, perhaps just adding "(default)" at the end of
the default io scheduler is better so we save that extra line.

-- 
Jens Axboe

