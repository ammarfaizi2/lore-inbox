Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273028AbTHFAw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 20:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273030AbTHFAw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 20:52:56 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:31237 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S273028AbTHFAwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 20:52:51 -0400
Message-ID: <3F30510A.E918924B@SteelEye.com>
Date: Tue, 05 Aug 2003 20:51:22 -0400
From: Paul Clements <Paul.Clements@SteelEye.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lou Langholtz <ldl@aros.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com> <3F303430.1080908@aros.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lou Langholtz wrote:
> 
> Paul Clements wrote:
> 
> >Lou Langholtz wrote:
> >
> >
> >>The following patch removes a race condition in the network block device
> >>driver in 2.6.0*. Without this patch, the reply receiving thread could
> >>end (and free up the memory for) the request structure before the
> >>request sending thread is completely done accessing it and would then
> >>access invalid memory.
> >>
> >>
> >
> >Indeed, there is a race condition here. It's a very small window, but it
> >looks like it could possibly be trouble on SMP/preempt kernels.
> >
> >This patch looks OK, but it appears to still leave the race window open
> >in the error case (it seems to fix the non-error case, though). We
> >probably could actually use the ref_count field of struct request to
> >better fix this problem. I'll take a look at doing this, and send a
> >patch out in a while.
> >
> >Thanks,
> >Paul
> >
> >
> Except that in the error case, the send basically didn't succeed. So no
> need to worry about recieving a reply and no race possibility in that case.

As long as the request is on the queue, it is possible for nbd-client to
die, thus freeing the request (via nbd_clear_que -> nbd_end_request),
and leaving us with a race between the free and do_nbd_request()
accessing the request structure.

--
Paul
