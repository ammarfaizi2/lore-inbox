Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbTIUWr5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 18:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262596AbTIUWr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 18:47:57 -0400
Received: from aneto.able.es ([212.97.163.22]:27389 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262594AbTIUWr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 18:47:56 -0400
Date: Mon, 22 Sep 2003 00:47:53 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Chad Talbott <ctalbott@google.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ide-io.c, kernel 2.4.22 Fix for IO stats in /proc/partitions, was Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
Message-ID: <20030921224753.GA4548@werewolf.able.es>
References: <vfxk789refm.fsf@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <vfxk789refm.fsf@sgi.com>; from ctalbott@google.com on Mon, Sep 15, 2003 at 22:21:01 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.15, Chad Talbott wrote:
> I found the cause of ide disks' ios_in_flight going negative in
> /proc/partitions.
[...]
> 
> --- linux-2.4.18-old/drivers/ide/ide-io.c	15 Sep 2003 17:41:32 -0000
> +++ linux-2.4.18-new/drivers/ide/ide-io.c	15 Sep 2003 20:11:12 -0000
> @@ -148,6 +148,7 @@
>  	ide_hwif_t *hwif = HWIF(drive);
>  	unsigned long flags;
>  	struct request *rq;
> +	struct completion *waiting;
>  
>  	spin_lock_irqsave(&io_request_lock, flags);
>  	rq = HWGROUP(drive)->rq;
> @@ -221,7 +222,13 @@
>  	spin_lock_irqsave(&io_request_lock, flags);
>  	blkdev_dequeue_request(rq);
>  	HWGROUP(drive)->rq = NULL;
> -	end_that_request_last(rq);
> +
> +	waiting = req->waiting;
> +	req_finished_io(req);
> +	blkdev_release_request(req);
> +	if (waiting)
> +		complete(waiting);
> +
>  	spin_unlock_irqrestore(&io_request_lock, flags);
>  }
>  

Did you ever built this ? req -> rq ?

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre4-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-2mdk))
