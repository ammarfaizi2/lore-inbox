Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271245AbTHHG7W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 02:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271272AbTHHG7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 02:59:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7626 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S271245AbTHHG7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 02:59:13 -0400
Date: Fri, 8 Aug 2003 08:59:08 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: Paul Clements <Paul.Clements@SteelEye.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
Message-ID: <20030808065908.GB18823@suse.de>
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net> <3F332ED7.712DFE5D@SteelEye.com> <3F334396.7030008@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F334396.7030008@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 08 2003, Lou Langholtz wrote:
> >@@ -499,12 +508,14 @@ static void do_nbd_request(request_queue
> >					lo->disk->disk_name);
> >			spin_lock(&lo->queue_lock);
> >			list_del_init(&req->queuelist);
> >+			req->ref_count--;
> >			spin_unlock(&lo->queue_lock);
> >			nbd_end_request(req);
> >			spin_lock_irq(q->queue_lock);
> >			continue;
> >		}
> >
> >+		req->ref_count--;
> >		spin_lock_irq(q->queue_lock);
> >
> Since ref_count isn't atomic, shouldn't ref_count only be changed while 
> the queue_lock is held???

Indeed, needs to be done after regrabbing the lock.

-- 
Jens Axboe

