Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964866AbVHYHvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964866AbVHYHvU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 03:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964867AbVHYHvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 03:51:19 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:17553 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964866AbVHYHvT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 03:51:19 -0400
Date: Thu, 25 Aug 2005 09:52:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Axboe <axboe@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: CFQ + 2.6.13-rc4-RT-V0.7.52-02 = BUG: scheduling with irqs disabled
Message-ID: <20050825075205.GB30650@elte.hu>
References: <1124899329.3855.12.camel@mindpipe> <20050824174702.GL28272@suse.de> <20050825060958.GB26398@elte.hu> <20050825062207.GO28272@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825062207.GO28272@suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Axboe <axboe@suse.de> wrote:

> There can quite easily be lots of pending IO for the io_context (and, 
> in CFQ's case, below cfq_io_contexts), task exiting is completely 
> decoupled from any pending io.

yes, but that only affects the io_context reference count. Actual new 
use of tsk->io_context should only be possible on the IO-submission 
side, which should all have stopped by the time we execute do_exit().  
(and it's synchronous anyway, so the fact that we are executing in the 
kernel prevents the same thread from submitting new IO, in this case.)

i.e. the removal of tsk->io_context can be done without locking out 
interrupts. No interrupt or io_context is supposed to access 
current->io_context at that point.

> Then there's the cfq_exit_io_context() locking. I have to ponder this 
> a bit, I cannot even convince myself that it is currently safe right 
> now.

i think it should be mostly safe already - it seems to be overlocking a 
bit. E.g. the read_lock_irq(&tasklist_lock) could be a simple 
read_lock() i think.

	Ingo
