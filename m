Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTJTOV7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 10:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbTJTOV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 10:21:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:11473 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262581AbTJTOVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 10:21:55 -0400
Date: Mon, 20 Oct 2003 19:57:27 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Daniel McNeil <daniel@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "linux-aio@kvack.org" <linux-aio@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: AIO and DIO testing on 2.6.0-test7-mm1
Message-ID: <20031020142727.GA4068@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066432378.2133.40.camel@ibm-c.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 04:12:58PM -0700, Daniel McNeil wrote:
> I've been doing some testing on 2.6.0-test7-mm1 with O_DIRECT and
> AIO.  I wrote some tests to check the buffered i/o verses O_DIRECT
> i/o races and O_DIRECT verses truncate.

Sounds very useful - thanks for doing this !

> 
> I still had apply suparna's direct-io.c patch to prevent oopses.
> Suparna, you said the patch was not the complete patch, do you have
> the complete patch?

Not yet.
A complete patch would need to address one more case that's rather
tricky to solve -- the case where a single dio request covers an 
allocated region followed by a hole.

Besides that there is a pending bug to address -- i.e to avoid
dropping i_sem during the actual i/o in the case where we are
extending the file (an intervening buffered write could extend
i_size, exposing uninitialized blocks). For AIO-DIO this means 
forcing the i/o to be synchronous for this case (as also for 
the case where we are overwriting an allocated region followed 
by a hole). Until we can use i/o barriers.

I was playing with a retry-based implementation for AIO-DIO,
where the first (tricky) case above becomes simple to handle ...
But didn't get a chance to work much on this during the last 
few days. I actually do have a patch, but there are occasional 
hangs with a lot of AIO-DIO writes to an ext3 filesystem in 
particular, that I can't explain as yet.

Do your testcases cover any of these cases already ?

Regards
Suparna

> 
> I wrote some simple tests to create 2 processes with one doing
> O_DIRECT i/o (of zeros) and the other doing buffered i/o and checking
> that the buffered i/o process never saw non-zero data which was
> posssible before the i_alloc_sem and other changes.  The test I
> wrote are:
> 	dio_append - use O_DIRECT to append while doing buffered reads
>  	dio_sparse - write O_DIRECT to holes while doing buffered reads
> 	dio_truncate - do O_DIRECT reads while truncating
> 	aiodio_append - same as dio_append but with AIO
> 	aiodio_sparse - same as dio_sparse but with AIO
> 
> These and a simple README are available here
> 	http://developer.osdl.org/daniel/AIO/TESTS/
> 
> The good news was I  never got any non-zero data or oops on test7-mm1
> (with the direct-io patch).
> 
> Unfortunately, when I ran these on test7, I also did not get any
> non-zero data.  On AIO test7 still gives me oopses:
> 
> Slab corruption: start=e7d9573c, expend=e7d957db, problemat=e7d95774
> Last user: [<c018b612>](__aio_put_req+0x97/0x185)
> Data: ********************************************************00 00 89 02 00 00
> 00 00 ***********************************************************************************************A5
> Next: 71 F0 2C .12 B6 18 C0 71 F0 2C .********************
> slab error in check_poison_obj(): cache `kiocb': object was modified after freeing
> Call Trace:
>  [<c0148c95>] check_poison_obj+0x106/0x18f
>  [<c0148ed4>] slab_destroy+0x1b6/0x1be
>  [<c014bf2f>] reap_timer_fnc+0x254/0x326
>  [<c014bcdb>] reap_timer_fnc+0x0/0x326
>  [<c012d80d>] run_timer_softirq+0xed/0x226
>  [<c0128dcd>] do_softirq+0xc9/0xcb
>  [<c011a165>] smp_apic_timer_interrupt+0xcd/0x135
>  [<c0108029>] default_idle+0x0/0x32
>  [<c010b0b6>] apic_timer_interrupt+0x1a/0x20
>  [<c0108029>] default_idle+0x0/0x32
>  [<c0108056>] default_idle+0x2d/0x32
>  [<c01080d4>] cpu_idle+0x3a/0x43
>  [<c0125050>] printk+0x1b4/0x258
> 
> 
> I guess this expected because it does not have the ref counting and
> other AIO fixes.
> 
> I'm planning on doing more testing and write some AIO verses truncate
> tests.
> 
> If you have any ideas on how to better test the AIO and O_DIRET changes
> in -mm, just let me know.
> 
> Daniel
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

