Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135920AbRDTNuZ>; Fri, 20 Apr 2001 09:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135921AbRDTNuQ>; Fri, 20 Apr 2001 09:50:16 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:39442 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S135920AbRDTNuK>; Fri, 20 Apr 2001 09:50:10 -0400
Date: Fri, 20 Apr 2001 16:11:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Takanori Kawano <t-kawano@ebina.hitachi.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panics on raw I/O stress test
Message-ID: <20010420161158.P752@athlon.random>
In-Reply-To: <20010419210153Z.t-kawano@ebina.hitachi.co.jp> <20010419193322.F752@athlon.random> <20010420204435M.t-kawano@ebina.hitachi.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010420204435M.t-kawano@ebina.hitachi.co.jp>; from t-kawano@ebina.hitachi.co.jp on Fri, Apr 20, 2001 at 08:44:35PM +0900
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2001 at 08:44:35PM +0900, Takanori Kawano wrote:
> 
> > Could you try again with 2.4.4pre4 plus the below patch?
> > 
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.4/2.4.4pre2/rawio-3
> 
> I suppose that 2.4.4-pre4 + rawio-3 patch still has SMP-unsafe
> raw i/o code and can cause the same panic I reported.

I just fixed that as well last week and 2.4.4-pre4 + rawio-3 should be just SMP
safe, faster and my patch is racommended for integration.

> I think the following scenario is possible if there are 3 or more CPUs.
> 
> (1) CPU0 enter rw_raw_dev()
> (2) CPU0 execute alloc_kiovec(1, &iobuf)    // drivers/char/raw.c line 309
> (3) CPU0 enter brw_kiovec(rw, 1, &iobuf,..) // drivers/char/raw.c line 362
> (4) CPU0 enter __wait_on_buffer()

With my patch applied the kernel doesn't execute wait_on_buffer from wait_kio
here, it first executes kiobuf_wait_for_io and that is also a performance
optimization because kiobuf_wait_for_io will sleep only once and it will
get only 1 wakeup once the whole kiobuf I/O completed.

> (5) CPU0 execute run_task_queue() and wait
>     while buffer_locked(bh) is true.        // fs/buffer.c line 152-158
> (6) CPU1 enter end_buffer_io_kiobuf() with
>      iobuf allocated at (2)
> (7) CPU1 execute unlock_buffer()            // fs/buffer.c line 1994
> (8) CPU0 exit __wait_on_buffer()
> (9) CPU0 exit brw_kiovec(rw, 1, &iobuf,..)
> (10) CPU0 execute free_kiovec(1, &iobuf)     // drivers/char/raw.c line 388
> (11) The task on CPU2 reused the area freed
>      at (10).
> (12) CPU1 enter end_kio_request() and touch
>      the corrupted iobuf, then panic.

The end_kio_request in CPU1 with my patch applied is executed before CPU0 can
execute wait_kio so it cannot race the above way.

Thanks for your comments (and yes you are right that the above race can happen
in all 2.4 kernels out there except in the aa latest ones).

Andrea
