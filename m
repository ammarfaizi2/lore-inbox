Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423017AbWJaJOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423017AbWJaJOJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 04:14:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423012AbWJaJOI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 04:14:08 -0500
Received: from brick.kernel.dk ([62.242.22.158]:1875 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1423017AbWJaJOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 04:14:07 -0500
Date: Tue, 31 Oct 2006 10:15:48 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Neil Brown <neilb@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-raid@vger.kernel.org,
       linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: [PATCH 002 of 6] md: Change lifetime rules for 'md' devices.
Message-ID: <20061031091547.GD14055@kernel.dk>
References: <20061031164814.4884.patches@notabene> <1061031060051.5046@suse.de> <20061031002245.dfd1bb66.akpm@osdl.org> <17735.4830.610969.866898@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17735.4830.610969.866898@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31 2006, Neil Brown wrote:
> On Tuesday October 31, akpm@osdl.org wrote:
> > On Tue, 31 Oct 2006 17:00:51 +1100
> > NeilBrown <neilb@suse.de> wrote:
> > 
> > > Currently md devices are created when first opened and remain in existence
> > > until the module is unloaded.
> > > This isn't a major problem, but it somewhat ugly.
> > > 
> > > This patch changes the lifetime rules so that an md device will
> > > disappear on the last close if it has no state.
> > 
> > This kills the G5:
> > 
> > 
> > EXT3-fs: recovery complete.
> > EXT3-fs: mounted filesystem with ordered data mode.
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > SMP NR_CPUS=4 
> > Modules linked in:
> > NIP: C0000000001A31B8 LR: C00000000018E5DC CTR: C0000000001A3404
> > REGS: c0000000017ff4a0 TRAP: 0300   Not tainted  (2.6.19-rc4-mm1)
> > MSR: 9000000000009032 <EE,ME,IR,DR>  CR: 84000048  XER: 00000000
> > DAR: 6B6B6B6B6B6B6BB3, DSISR: 0000000040000000
> > TASK = c00000000ff2b7f0[1899] 'nash' THREAD: c0000000017fc000 CPU: 1
> > GPR00: 0000000000000008 C0000000017FF720 C0000000006B26D0 6B6B6B6B6B6B6B7B 
> ..
> > NIP [C0000000001A31B8] .kobject_uevent+0xac/0x55c
> > LR [C00000000018E5DC] .__elv_unregister_queue+0x20/0x44
> > Call Trace:
> > [C0000000017FF720] [C000000000562508] read_pipe_fops+0xd0/0xd8 (unreliable)
> > [C0000000017FF840] [C00000000018E5DC] .__elv_unregister_queue+0x20/0x44
> > [C0000000017FF8D0] [C000000000195548] .blk_unregister_queue+0x58/0x9c
> > [C0000000017FF960] [C00000000019683C] .unlink_gendisk+0x1c/0x50
> > [C0000000017FF9F0] [C000000000122840] .del_gendisk+0x98/0x22c
> 
> I'm guessing we need
> 
> diff .prev/block/elevator.c ./block/elevator.c
> --- .prev/block/elevator.c	2006-10-31 20:06:22.000000000 +1100
> +++ ./block/elevator.c	2006-10-31 20:06:40.000000000 +1100
> @@ -926,7 +926,7 @@ static void __elv_unregister_queue(eleva
>  
>  void elv_unregister_queue(struct request_queue *q)
>  {
> -	if (q)
> +	if (q && q->elevator)
>  		__elv_unregister_queue(q->elevator);
>  }
> 
> 
> Jens?  md never registers and elevator for its queue.

Hmm, but blk_unregister_queue() doesn't call elv_unregister_queue()
unless q->request_fn is set. And in that case, you must have an io
scheduler attached.

-- 
Jens Axboe

