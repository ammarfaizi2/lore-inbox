Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbUCAWGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 17:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbUCAWGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 17:06:31 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35482 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261447AbUCAWG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 17:06:28 -0500
Date: Mon, 1 Mar 2004 23:06:24 +0100
From: Jens Axboe <axboe@suse.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: per-cpu blk_plug_list
Message-ID: <20040301220624.GA5033@suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB501F2AB4C@scsmsx401.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01 2004, Chen, Kenneth W wrote:
> We were surprised to find global lock in I/O path still exists on 2.6
> kernel.  This global lock triggers unacceptable lock contention and
> prevents 2.6 kernel to scale on the I/O side.
> 
> blk_plug_list/blk_plug_lock manages plug/unplug action.  When you have
> lots of cpu simultaneously submits I/O, there are lots of movement with
> the device queue on and off that global list.  Our measurement showed
> that blk_plug_lock contention prevents linux-2.6.3 kernel to scale pass
> beyond 40 thousand I/O per second in the I/O submit path.
> 
> Looking at the vmstat and readprofile output with vanilla 2.6.3 kernel:
> 
> procs -----------memory---------- -----io---- -system-- ----cpu----
>  r  b  swpd   free   buff  cache    bi    bo   in    cs   us sy id wa
> 409 484  0 22470560  10160 181792  89456  5867 46899 26383 7 93  0  0
> 427 488  0 22466176  10160 181792  90307  6057 46818 26155 7 93  0  0
> 448 469  0 22462208  10160 181792  84076  5769 48217 26782 7 93  0  0
> 
> 575324 total                                      0.0818
> 225342 blk_run_queues                           391.2188
> 140164 __make_request                            38.4221
> 131765 scsi_request_fn                           55.6440
>  21566 generic_unplug_device                     61.2670
>   6050 get_request                                3.7812
> 
> All cpus are pegged at 93% kernel time spinning on the lock.
> blk_plug_device() and blk_remove_plug() didn't show up in readprofile
> because they spin with irq disabled and readprofile is based on timer
> interrupt.  Nevertheless, it's obvious from blk_run_queues().

Yep doesn't look too good...

> The plug management need to be converted into per-cpu.  The idea here
> is to manage device queue on per-cpu plug list.  This would also allows
> optimal queue kick-off since submit/kick-off typically occurs within
> same system call. With our proof-of-concept patch, here are the results,
> again vmstat and readprofile output:
> 
> procs -----------memory---------- -----io----   -system--    ----cpu----
>  r  b  swpd   free   buff  cache    bi    bo     in    cs    us sy id wa
> 30 503  0 22506176   9536 172096  212849 20251 102537 177093 27 20  0 53
> 11 532  0 22505792   9536 172096  209073 21235 103374 177183 29 20  0 51
> 27 499  0 22505408   9536 172096  205334 21943 103883 176649 30 20  0 50
> 
> 1988800 total                                      0.2828
> 1174759 cpu_idle                                2447.4146
> 156385 default_idle                             4887.0312
>  72586 do_softirq                                108.0149
>  62463 schedule                                   12.0492
>  51913 scsi_request_fn                            21.9227
>  34351 __make_request                              9.4164
>  24370 dio_bio_end_io                             63.4635
>  22652 scsi_end_request                           44.2422
> 
> It clearly relieves the global lock contention and the kernel time is
> now in the expected range.  I/O has been improved to 110K random I/O
> per second and is now only limited by the disks instead of kernel.
> 
> The workload that triggers this scalability issue is an I/O intensive
> database workload running on a 32P system.
> 
> Comments on the patch are welcome, I'm sure there will be a couple of
> iterations on the solution.

(you should inline patches, or at least make sure they have the proper
mimetype so one can comment on them inlined).

The patch doesn't look all bad, I like the per-cpu plug lists. The
fs-directio.c change looks really buggy though, what prevents io from
going to other cpus?! There's also some "cosmetic" stuff, like why
aren't you using the per-cpu helpers?

-- 
Jens Axboe

