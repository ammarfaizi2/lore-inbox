Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315260AbSDWQgv>; Tue, 23 Apr 2002 12:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315261AbSDWQgu>; Tue, 23 Apr 2002 12:36:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:11425 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315260AbSDWQgu>;
	Tue, 23 Apr 2002 12:36:50 -0400
Date: Tue, 23 Apr 2002 09:36:34 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] task cpu affinity syscalls for 2.4-O(1)
Message-ID: <20020423093634.A1904@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <1019504054.939.108.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 03:34:13PM -0400, Robert Love wrote:
> 
> I have a request for comments:
> 
> The locking is no good in this patch.  set_cpus_allowed is not atomic
> and it is certainly not safe to hold a spinlock across a call to it. 
> However, before we call set_cpus_allowed we need a valid reference to
> the task and assurance the task won't slip away out from under us.
> 

Robert,

I don't have a suggestion for the locking yet, but rather a question
about the current code that you may be able to answer.  At the end
of set_cpus_allowed(), there is this block of code:

        init_MUTEX_LOCKED(&req.sem);
        req.task = p;
        list_add(&req.list, &rq->migration_queue);
        task_rq_unlock(rq, &flags);
        wake_up_process(rq->migration_thread);

        down(&req.sem);

After releasing the runqueue lock, what prevents p from moving to
(and running on) another CPU via the load_balance() mechanism
before the migration thread is scheduled?  I couldn't find anything
in the code to prevent this, and it looks like bad things would
happen if it did.  Of course, this assumes we are not running in
the context of p while calling set_cpus_allowed() for p.

P.S. Thanks for porting O(1) to 2.4!
-- 
Mike
