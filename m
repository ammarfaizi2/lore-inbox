Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271394AbTHHPCm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 11:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271395AbTHHPCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 11:02:42 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:3077 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S271394AbTHHPCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 11:02:40 -0400
Message-ID: <3F33BB2A.94599C5C@SteelEye.com>
Date: Fri, 08 Aug 2003 11:00:58 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>, Lou Langholtz <ldl@aros.net>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net> <3F30510A.E918924B@SteelEye.com> <3F30AF81.4070308@aros.net> <3F332ED7.712DFE5D@SteelEye.com> <3F334396.7030008@aros.net> <20030808065908.GB18823@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Fri, Aug 08 2003, Lou Langholtz wrote:
> > >@@ -499,12 +508,14 @@ static void do_nbd_request(request_queue
> > >                                     lo->disk->disk_name);
> > >                     spin_lock(&lo->queue_lock);
> > >                     list_del_init(&req->queuelist);
> > >+                    req->ref_count--;
> > >                     spin_unlock(&lo->queue_lock);
> > >                     nbd_end_request(req);
> > >                     spin_lock_irq(q->queue_lock);
> > >                     continue;
> > >             }
> > >
> > >+            req->ref_count--;
> > >             spin_lock_irq(q->queue_lock);
> > >
> > Since ref_count isn't atomic, shouldn't ref_count only be changed while
> > the queue_lock is held???
> 
> Indeed, needs to be done after regrabbing the lock.

But req is pulled off of nbd's main request queue at this point, so I
don't think anyone else could be touching it, could they?

--
Paul
