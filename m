Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272668AbTG1Gqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 02:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272678AbTG1Gqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 02:46:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:14264 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S272668AbTG1Gqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 02:46:44 -0400
Date: Mon, 28 Jul 2003 09:01:50 +0200
From: Jens Axboe <axboe@suse.de>
To: Lou Langholtz <ldl@aros.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>, NeilBrown <neilb@cse.unsw.edu.au>,
       Steven Whitehouse <steve@chygwyn.com>
Subject: Re: blk_stop_queue/blk_start_queue confusion, problem, or bug???
Message-ID: <20030728070150.GA25356@suse.de>
References: <3F2418D9.1020703@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2418D9.1020703@aros.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27 2003, Lou Langholtz wrote:
> I've been trying to use the blk_start_queue and blk_stop_queue functions 
> in the network block device driver branch I'm working on. The stop works 
> as expected, but the start doesn't. Processes that have tried to read or 
> write to the device (after the queue was stopped) stay blocked in 
> io_schedule instead of getting woken up (after blk_start_queue was 
> called). Do I need to follow the call to blk_start_queue() with a call 
> to wake_up() on the correct wait queues? Why not have that functionality 
> be part of blk_start_queue()? Or was this an oversight/bug?

blk_start_queue() should be enough. What kind of behaviour are you
seeing? Is the request_fn() never called again?

> The reason I'm using blk_stop_queue and blk_start_queue is to stop the 
> request handling function (installed from blk_init_queue), from being 
> re-invoked and to return when the network block device server goes down. 
> That way, the driver doesn't need to block indefinately within the 
> request handling function - which seems like it'd likely block other 
> block drivers if it did this - and doesn't need to be handled by 

It will, you should never block in your request function/

> yet-another seperate kernel thread. Anyways... the stop is called from 
> either the request handling function context or from an ioctl call 
> context. If then a process tries to read or write to the device it 
> blocks - just as I'd like (more like NFS behavior that way). When my 
> code detects that the server has come back up again from the ioctl call 
> context it calls blk_start_queue(). But the I/O blocked process stays 
> blocked.

aaaaand what happens? You are not giving a lot of info. What kernel?
It's pretty trivial to put printks in stop/start_queue and start doing
some tracking, since none of the core drivers use it yet.

> Am I using these calls incorrectly or is something else going on? 
> Insights, examples, very much appreciated.

Hard to say, as you didn't post the code. But it sounds correct.

> BTW: LKML has had a related thread on this some years ago in discussing 
> how the block layer system handles request functions that must drop the 
> spinlock and may block indefinately. That never seemed to get resolved 
> though and makes me believe that's why Steven Whitehouse opted to use a 
> multi-threaded approach to the NBD driver at one point.

That has never really been allowed, in that it is a Bad Thing to do
something like that.

-- 
Jens Axboe

