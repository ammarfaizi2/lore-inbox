Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270757AbTHJW4f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270759AbTHJW4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 18:56:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47272 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270757AbTHJW4c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 18:56:32 -0400
Message-ID: <3F36CD93.4010704@pobox.com>
Date: Sun, 10 Aug 2003 18:56:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: ranty@debian.org, linux-kernel@vger.kernel.org, willy@debian.org
Subject: Re: [PATCH] [2.6.0-test3] request_firmware related problems.
References: <20030810210646.GA6746@ranty.pantax.net> <20030810142928.4b734e8d.akpm@osdl.org>
In-Reply-To: <20030810142928.4b734e8d.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Does this mean that we have another gaggle of kernel threads for all the
> time the system is up?
> 
> It might be better to create a custom kernel thread on-demand, or kill off
> the workqueue when its job has completed.


Thanks for mentioning this!

There is indeed an explosion of kernel threads.  I feel many of them 
fall into two categories:

* needs a one-shot kernel thread, often after a timer fires or similar 
interrupt-ish-context code runs (error handling threads also apply here)

* only needs per-cpu threads if IO(or net) load is significant

And personally, I don't think anyone would scream if 
schedule_{task,work} just created a new thread -- if needed -- and then 
did the work.  That's what the driver authors _really_ want out of the 
interface, IMO.  They don't want to wait for another keventd task, 
typically.  In other words, a thread pool, that will create new threads 
beyond the max pool size.

On the other side of the coin, a valid reason for creating kernel 
threads is when your application is constantly doing stuff in process 
context.  You might as well have dedicated kernel threads for these 
drivers, because you are assured you will need at least one.

So, in terms of concrete suggestions:

1) if schedule_work is called and no kevent thread is available, create 
a new one
2) ponder perhaps an implementation that would use generic keventd until 
a certain load is reached; then, create per-cpu kernel threads just like 
private workqueue creation occurs now.  i.e. switch from shared 
(keventd) to private at runtime.

As a tangent, I would love a simplified interface that was used in 
driver code like this:
	run_in_process_context(callback_fn, callback_data)
that eliminates the tq/workqueue struct altogether.  Combine this 
simplified interface with suggestion #1 above, and you've got something 
quite useful, and tough to screw up.

	Jeff



