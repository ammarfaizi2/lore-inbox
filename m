Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVFJGXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVFJGXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 02:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbVFJGXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 02:23:50 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42378 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262492AbVFJGXr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 02:23:47 -0400
Date: Fri, 10 Jun 2005 08:24:53 +0200
From: Jens Axboe <axboe@suse.de>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: andrea@suse.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Real-time problem due to IO congestion.
Message-ID: <20050610062452.GK5140@suse.de>
References: <42A91D36.8090506@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A91D36.8090506@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10 2005, Takashi Ikebe wrote:
> Hello,
> I have been encountering big real-time problem due to IO congestion, and
> I want some advices.
> 
> -The problem description-
> There are 2 type processes in test environment.
> 1. The real-time needed process (run on with high static priority)
>     The process wake up every 10ms, and wake up, write some log (the
> test case is current CPU clock via tsc) to the file.
> 
> 2. The process which make IO load
>     The process have large memory size, and kill the process with dumping.
>     The process's memory area exceeds 70% of whole physical
> RAM.(Actually 1.5GB memory area while whole RAM is 2GB)
> 
> Whenever during dumping, the real-time needed process sometimes stop for
> long time during write system call. (sometimes exceeds 1000ms)
> I tested every IO scheduler but the same problem occurs.
> I also seek this problem into the code, and find that the stops are
> mainly occurring on blk_congestion_wait/get_request/get_request_wait
> functions located on drivers/block/ll_rw_blk.c.
> 
> -My assumption-
> The design of IO(read/write) queue and queuing is not well match to
> real-time needed processes.
> If there are many IO requests by low priority processes already, then
> the IO request by high priority process should wait until queue goes
> clean, and this cause some kind of priority inversions.
> 
> -My suggestion-
> Add the new IO scheduler or change current IO scheduler to reflect
> process's priority on queuing.
> 
> I don't know my assumption and suggestion are correct and you like,
> would you give me some advices?

This basically needs io priorities to work, so that request allocation
is prioritized as well. I didn't actually add request allocation groups
in the cfq-ts posted with priority support, however I have some patches
from years ago that did so. I'll see if I can find the time to brush
those off.

-- 
Jens Axboe

