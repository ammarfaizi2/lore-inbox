Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbTG0SJO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 14:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270925AbTG0SJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 14:09:14 -0400
Received: from dm4-178.slc.aros.net ([66.219.220.178]:36741 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S270882AbTG0SJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 14:09:13 -0400
Message-ID: <3F2418D9.1020703@aros.net>
Date: Sun, 27 Jul 2003 12:24:25 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>,
       Andrea Arcangeli <andrea@suse.de>, NeilBrown <neilb@cse.unsw.edu.au>
Cc: Steven Whitehouse <steve@chygwyn.com>
Subject: blk_stop_queue/blk_start_queue confusion, problem, or bug???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been trying to use the blk_start_queue and blk_stop_queue functions 
in the network block device driver branch I'm working on. The stop works 
as expected, but the start doesn't. Processes that have tried to read or 
write to the device (after the queue was stopped) stay blocked in 
io_schedule instead of getting woken up (after blk_start_queue was 
called). Do I need to follow the call to blk_start_queue() with a call 
to wake_up() on the correct wait queues? Why not have that functionality 
be part of blk_start_queue()? Or was this an oversight/bug?

The reason I'm using blk_stop_queue and blk_start_queue is to stop the 
request handling function (installed from blk_init_queue), from being 
re-invoked and to return when the network block device server goes down. 
That way, the driver doesn't need to block indefinately within the 
request handling function - which seems like it'd likely block other 
block drivers if it did this - and doesn't need to be handled by 
yet-another seperate kernel thread. Anyways... the stop is called from 
either the request handling function context or from an ioctl call 
context. If then a process tries to read or write to the device it 
blocks - just as I'd like (more like NFS behavior that way). When my 
code detects that the server has come back up again from the ioctl call 
context it calls blk_start_queue(). But the I/O blocked process stays 
blocked.

Am I using these calls incorrectly or is something else going on? 
Insights, examples, very much appreciated.

BTW: LKML has had a related thread on this some years ago in discussing 
how the block layer system handles request functions that must drop the 
spinlock and may block indefinately. That never seemed to get resolved 
though and makes me believe that's why Steven Whitehouse opted to use a 
multi-threaded approach to the NBD driver at one point.

