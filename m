Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270645AbRHSS67>; Sun, 19 Aug 2001 14:58:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270646AbRHSS6j>; Sun, 19 Aug 2001 14:58:39 -0400
Received: from nbd.it.uc3m.es ([163.117.139.192]:5124 "EHLO nbd.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S270645AbRHSS6b>;
	Sun, 19 Aug 2001 14:58:31 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108191858.UAA01216@nbd.it.uc3m.es>
Subject: Re: scheduling with io_lock held in 2.4.6
X-ELM-OSV: (Our standard violations) hdr-charset=US-ASCII
In-Reply-To: "from (env: ptb) at Aug 19, 2001 06:38:18 pm"
To: ptb@it.uc3m.es
Date: Sun, 19 Aug 2001 20:58:40 +0200 (CEST)
CC: akpm@zip.com.au, linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

More info ..

"A month of sundays ago ptb wrote:"
> What puzzles me is the sequence shown in the second oops of
> blkdev_release_request leading to a schedule. Possibly via an
> interrupt? You yourself said that the function cannot sleep. The oops
> was triggered my my detection code placed in schedule which fires
> on just such an event.
> 
> >>EIP; c011426a <schedule+142/8f4>   <=====
> Trace; c011b064 <exit_notify+178/2a8>
> Trace; c011b548 <do_exit+3b4/3d4>
> Trace; c0107a38 <do_divide_error+0/9c>
> Trace; c0113683 <do_page_fault+3f3/510>
> Trace; c0113290 <do_page_fault+0/510>
> Trace; c01d91ad <memcpy_toiovec+35/64>
> Trace; c01d7c4c <skb_release_data+68/74>
> Trace; c0113cc3 <reschedule_idle+63/214>
> Trace; c01ef15d <tcp_recvmsg+839/a58>                 <-- urr?
> Trace; c0107304 <error_code+34/3c>                    <-- huh?
> Trace; c01a3c17 <blkdev_release_request+df/1b4>
> Trace; c01a4807 <end_that_request_last+a3/130>
> Trace; c0134176 <__free_pages+1e/24>
> Trace; c01341a3 <free_pages+27/2c>
> Trace; c014c51d <do_select+1e5/1fc>
> Trace; c0122071 <sys_rt_sigaction+89/d8>
> Trace; c0143842 <blkdev_ioctl+2e/34>
> Trace; c014b9a9 <sys_ioctl+1f9/280>
> Trace; c010721b <system_call+33/38>

I am now fairly certain that the schedule occured while
blkdev_release_request was in a completely innocuous line

              if (waitqueue_active(&blk_buffers_wait)
                    && atomic_read(&queued_sectors) < low_queued_sectors)
                        wake_up(&blk_buffers_wait);
                /*
                 * Add to pending free list and batch wakeups
                 */
                list_add(&req->table, &q->pending_freelist[rw]);   <- HERE
                if (++q->pending_free[rw] >= batch_requests) {
                        int wake_up = q->pending_free[rw];

 
so I suppose that this is an interrupt. But IRQs are supposed to be
masked when blkdev_release_request is called, and I call it only from
end_that_request_last, with spin_lock_irqsave(&io_request_lock) held.

I'll check if IRQs are really masked (how?). But how on earth
could somebody else release the IRQs on the same CPU while the io
spinlock is held? We'd have to schedule once to allow somebody else to
release IRQs first .. (infinite mental regress follows).

Or is this a NMI?  do_divide_error looks distinctly hardware level!

At any rate, this kernel (2.4.6) is fairly unstable on this smp box
(dell poweredge) even before I started debugging. I had several
lockups just now when running e2fsck at reboot. Even when I rebooted
with noapic (I seem to recall). Booting back to 2.4.3 cured it.

I daresay it's time to see if 2.4.8 or 9 solves anything.

Peter
