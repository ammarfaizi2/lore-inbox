Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315182AbSEGWno>; Tue, 7 May 2002 18:43:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315192AbSEGWnn>; Tue, 7 May 2002 18:43:43 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:40693 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315182AbSEGWnm>; Tue, 7 May 2002 18:43:42 -0400
Date: Tue, 7 May 2002 15:43:22 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rwhron@earthlink.net, mingo@elte.hu, gh@us.ibm.com,
        linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: O(1) scheduler gives big boost to tbench 192
Message-ID: <20020507154322.F1537@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20020507151356.A18701@w-mikek.des.beaverton.ibm.com> <E175DhD-0000HF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 11:44:35PM +0100, Alan Cox wrote:
> > BEFORE
> > ------
> > Pipe latency:    6.5185 microseconds
> > Pipe bandwidth: 86.35 MB/sec
> > 
> > AFTER
> > -----
> > Pipe latency:     6.5723 microseconds
> > Pipe bandwidth: 540.13 MB/sec
> > 
> > Comments?  If anyone would like to see/test the code (pretty simple
> > really) let me know.
> 
> Are you doing prefetches on the pipe data in your system. Im curious if
> this is an SMP cross processor pipe issue or simply cache behaviour ?

I'm not doing any prefetches in the code (if that is what you are
talking about).  The code just moves the pipe reader to the same
CPU as the pipe writer (which is about to block).  Certainly, the
pipe reader could take advantage of any data written by the writer
still being in the cache.

The code added to 'try_to_wake_up' looks something like this:

        if (unlikely(synchronous)){
                rq = lock_task_rq(p, &flags);
                if (p->array || p->state == TASK_RUNNING) {
			/* We're too late */
                        unlock_task_rq(rq, &flags);
                        return success;
                }
                p->cpu = smp_processor_id(); /* Change CPU id */
                unlock_task_rq(rq, &flags);
                rq = lock_task_rq(p, &flags);
                p->state = TASK_RUNNING;
                if (!p->array) {
                        activate_task(p, rq);
                }
                unlock_task_rq(rq, &flags);
		return success;
	}

I'm not sure if 'synchronous' is still being passed all the way
down to try_to_wake_up in your tree (since it was removed in 2.5).
This is based off a back port of O(1) to 2.4.18 that Robert Love
did.  The rest of try_to_wake_up (the normal/common path) remains
the same.

-- 
Mike
