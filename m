Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275272AbTHGKv6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 06:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275275AbTHGKv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 06:51:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:61140 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S275272AbTHGKvz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 06:51:55 -0400
Date: Thu, 7 Aug 2003 12:51:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, NeilBrown <neilb@cse.unsw.edu.au>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: blk_stop_queue/blk_start_queue confusion, problem, or bug???
Message-ID: <20030807105137.GL858@suse.de>
References: <3F2418D9.1020703@aros.net> <20030728070150.GA25356@suse.de> <3F24D5E9.3090901@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F24D5E9.3090901@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28 2003, Lou Langholtz wrote:
> Jens Axboe wrote:
> 
> >On Sun, Jul 27 2003, Lou Langholtz wrote:
> > 
> >
> >>I've been trying to use the blk_start_queue and blk_stop_queue functions 
> >>in the network block device driver branch I'm working on. The stop works 
> >>as expected, but the start doesn't. Processes that have tried to read or 
> >>write to the device (after the queue was stopped) stay blocked in 
> >>io_schedule instead of getting woken up (after blk_start_queue was 
> >>called). Do I need to follow the call to blk_start_queue() with a call 
> >>to wake_up() on the correct wait queues? Why not have that functionality 
> >>be part of blk_start_queue()? Or was this an oversight/bug?
> >>   
> >>
> >
> >blk_start_queue() should be enough. What kind of behaviour are you
> >seeing? Is the request_fn() never called again?
> >
> Sorry. I've been so burried in this problem, I forgot others probably 
> can't read my mind ;-) The behavior I was seeing was that processes 
> blocked on I/O and in io_schedule, don't get woken up. After tracking 
> the problem down, I realized that once the queue was stopped (using 
> blk_stop_queue) any I/O requests against an empty request queue would 
> plug the device. After the short timeout, generic_unplug would get 
> called and would first try removing the plug then if it succeeded check 
> QUEUE_FLAG_STOPPED. In my case QUEUE_FLAG_STOPPED hadn't gotten cleared 
> by the time generic_unplug had gotten invoked. So the queue was left in 
> a state where it wasn't plugged any more but the request_fn wasn't 
> running either and things hung that way (locked in io_schedule). 
> Hopefully the patch I just sent out will make sense if my explanation 
> doesn't again this time. ;-)

Your diagnosis is correct and the patch you sent was too.

> >>The reason I'm using blk_stop_queue and blk_start_queue is to stop the 
> >>request handling function (installed from blk_init_queue), from being 
> >>re-invoked and to return when the network block device server goes down. 
> >>That way, the driver doesn't need to block indefinately within the 
> >>request handling function - which seems like it'd likely block other 
> >>block drivers if it did this - and doesn't need to be handled by 
> >>   
> >>
> >
> >It will, you should never block in your request function/
> > 
> >
> With the network block device driver, the only way to ensure the request 
> function *never* blocks is to have a seperate dedicated kernel thread 
> handling the actual network I/O. At best otherwise, I can use 

Correct

> >That has never really been allowed, in that it is a Bad Thing to do
> >something like that.
> > 
> >
> Want to make sure I don't misunderstand... you mean that dropping the 
> queue spin lock is a Bad Thing correct? Is it bad enough to warrant 
> using a seperate kernel thread for handling network sends to avoid this 
> then? This would have to be a seperate thread per network block device 
> then to ensure the devices don't impede each other.

I snipped your paragraph above, since this is essentially the same. It
doesn't matter that you drop the lock, that just makes it legal from a
general kernel perspective (must not schedule with spinlock held, that's
a hard rule). However, you are still pinning plugged queues "behind" you
so they can't run until you finish.

So yes, typically the correct thing is to offload such work from the
request_fn and do it in some sort of thread. Your request_fn then
becomes something ala

void my_rfn(request_queue_t *q)
{
	struct my_dev *dev = q->queuedata;

	wake_up(&dev->request_wqueue);
}

or something like that.

-- 
Jens Axboe

