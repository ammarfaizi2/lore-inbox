Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbTDNJ4H (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTDNJ4H (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:56:07 -0400
Received: from [12.47.58.203] ([12.47.58.203]:61811 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262933AbTDNJ4G (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 05:56:06 -0400
Date: Mon, 14 Apr 2003 03:07:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: Jens Axboe <axboe@suse.de>
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre7 ide request races
Message-Id: <20030414030751.7bf17b04.akpm@digeo.com>
In-Reply-To: <20030414093418.GQ9776@suse.de>
References: <20030414093418.GQ9776@suse.de>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 10:07:50.0707 (UTC) FILETIME=[B4F3C030:01C3026D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> We've had some problems with request corruption on IDE in the past, IBM
> traced these to stack corruption. In various places, the IDE code does
> something ala:
> 
> submission:
> 	struct request rq;
> 
> 	...
> 	ide_do_drive_cmd(drive, &rq, ide_wait);
> 
> ide_end_request:
> 	...
> 	blkdev_release_request()
> 
> which works fine, as long as the stack persists for the
> blkdev_release_request() call, but it may not if the task has already
> exited (CPU0 may be waiting in ide_do_drive_cmd(), CPU1 gets the
> completion interrupt, task is woken, and exits, CPU0 now calls
> blkdev_release_request()). The result is random stack corruption (or
> request list corruption, rq->q may have been scrippled!), not good.
> 

Those locally allocated requests are foul, and the patch is a good cleanup,
but is a simpler fix more appropriate?

The bug is in end_that_request_last(), yes?

void end_that_request_last(struct request *req)
{
	if (req->waiting != NULL)
		complete(req->waiting);
	req_finished_io(req);

	blkdev_release_request(req);
}

Wouldn't it be simpler to just do:

void end_that_request_last(struct request *req)
{
	struct completion *c = req->waiting;

	req_finished_io(req);
	blkdev_release_request(req);
	if (c)
		complete(c);
}


I vaguely seem to remember being told months ago why this wasn't right ;)

