Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTDNKGK (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 06:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTDNKGK (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 06:06:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:57036 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262934AbTDNKGJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 06:06:09 -0400
Date: Mon, 14 Apr 2003 12:17:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-pre7 ide request races
Message-ID: <20030414101747.GR9776@suse.de>
References: <20030414093418.GQ9776@suse.de> <20030414030751.7bf17b04.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414030751.7bf17b04.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14 2003, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > We've had some problems with request corruption on IDE in the past, IBM
> > traced these to stack corruption. In various places, the IDE code does
> > something ala:
> > 
> > submission:
> > 	struct request rq;
> > 
> > 	...
> > 	ide_do_drive_cmd(drive, &rq, ide_wait);
> > 
> > ide_end_request:
> > 	...
> > 	blkdev_release_request()
> > 
> > which works fine, as long as the stack persists for the
> > blkdev_release_request() call, but it may not if the task has already
> > exited (CPU0 may be waiting in ide_do_drive_cmd(), CPU1 gets the
> > completion interrupt, task is woken, and exits, CPU0 now calls
> > blkdev_release_request()). The result is random stack corruption (or
> > request list corruption, rq->q may have been scrippled!), not good.
> > 
> 
> Those locally allocated requests are foul, and the patch is a good cleanup,
> but is a simpler fix more appropriate?
> 
> The bug is in end_that_request_last(), yes?
> 
> void end_that_request_last(struct request *req)
> {
> 	if (req->waiting != NULL)
> 		complete(req->waiting);
> 	req_finished_io(req);
> 
> 	blkdev_release_request(req);
> }
> 
> Wouldn't it be simpler to just do:
> 
> void end_that_request_last(struct request *req)
> {
> 	struct completion *c = req->waiting;
> 
> 	req_finished_io(req);
> 	blkdev_release_request(req);
> 	if (c)
> 		complete(c);
> }
> 
> 
> I vaguely seem to remember being told months ago why this wasn't right ;)

How would that solve the problem? The request could be gone even before
end_that_request_last() is run, that is the issue.

-- 
Jens Axboe

