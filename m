Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWHVNDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWHVNDm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWHVNDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:03:42 -0400
Received: from brick.kernel.dk ([62.242.22.158]:24580 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932219AbWHVNDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:03:41 -0400
Date: Tue, 22 Aug 2006 15:05:56 +0200
From: Jens Axboe <axboe@suse.de>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: [PATCH] elv_unregister: fix possible crash on module unload
Message-ID: <20060822130556.GJ4290@suse.de>
References: <20060820204345.GA5750@oleg> <20060820205034.GA5755@oleg> <20060821154841.e6ea500a.akpm@osdl.org> <20060822172213.GA401@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060822172213.GA401@oleg>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22 2006, Oleg Nesterov wrote:
> An exiting task or process which didn't do I/O yet have no io context,
> elv_unregister() should check it is not NULL.
> 
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
> 
> --- 2.6.18-rc4/block/elevator.c~8_crash	2006-07-16 01:53:08.000000000 +0400
> +++ 2.6.18-rc4/block/elevator.c	2006-08-22 21:13:06.000000000 +0400
> @@ -765,7 +765,8 @@ void elv_unregister(struct elevator_type
>  		read_lock(&tasklist_lock);
>  		do_each_thread(g, p) {
>  			task_lock(p);
> -			e->ops.trim(p->io_context);
> +			if (p->io_context)
> +				e->ops.trim(p->io_context);
>  			task_unlock(p);
>  		} while_each_thread(g, p);
>  		read_unlock(&tasklist_lock);

Good catch, applied. Thanks! I wonder why this hasn't been seen on
switching io schedulers, which makes me a little suspicious. Did you see
it trigger?

-- 
Jens Axboe

