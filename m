Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161251AbWJRSWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161251AbWJRSWk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 14:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161256AbWJRSWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 14:22:40 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:60804 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161251AbWJRSWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 14:22:39 -0400
Subject: Re: 2.6.19-rc2-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Chris Mason <chris.mason@oracle.com>, ak@suse.de
In-Reply-To: <45366F08.6050903@yahoo.com.au>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	 <1161185599.18117.1.camel@dyn9047017100.beaverton.ibm.com>
	 <45364CE9.7050002@yahoo.com.au>
	 <1161191747.18117.9.camel@dyn9047017100.beaverton.ibm.com>
	 <45366515.4050308@yahoo.com.au>
	 <1161194303.18117.17.camel@dyn9047017100.beaverton.ibm.com>
	 <45366F08.6050903@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 11:22:20 -0700
Message-Id: <1161195740.18117.28.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-19 at 04:14 +1000, Nick Piggin wrote:
> Badari Pulavarty wrote:
> > On Thu, 2006-10-19 at 03:32 +1000, Nick Piggin wrote:
> 
> >>Sorry. Can you try with ext2? Alternatively, try with ext3 or reiserfs
> >>and change the line in mm/filemap.c:generic_file_buffered_write from
> >>
> >>		status = a_ops->commit_write(file, page, offset, offset+copied);
> >>to
> >>		status = a_ops->commit_write(file, page, offset, offset+bytes);
> >>
> >>and see if that solves your problem (that will result in rubbish being
> >>temporarily visible, but there is a similar problem upstream anyway, so it
> >>shouldn't cause other failures in your test).
> > 
> > 
> > No. Above change didn't help either :(
> 
> OK, so it isn't due to passing in a short / zero length to commit_write.
> 
> It is more likely to be a subtle bug when retrying the write after having
> faulted on the first page. Hmm, you wouldn't be deadlocking on i_mutex,
> due to faulting in fault_in_pages_readable (that is against the documented
> lock ordering, but thank god it looks like the documentation is incorrect
> as msync doesn't hold mmap_sem over do_fsync).
> 
> I can't see anything yet, but I'll keep looking (and try to reproduce
> if I can get TLP working).
> 

I realized that, I am not using STACK_UNWIND - so traces may be fishing
on the stack. I enabled unwinder, traces got worse :( unwinder problems
again ?

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#1!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]

BUG: soft lockup detected on CPU#2!

Call Trace:
 [<ffffffff8020b481>] show_trace+0x41/0x70
 [<ffffffff8020b4c2>] dump_stack+0x12/0x20
 [<ffffffff8024bbca>] softlockup_tick+0xfa/0x120
 [<ffffffff802322e7>] update_process_times+0x57/0x90
 [<ffffffff80218104>] smp_local_timer_interrupt+0x34/0x60
 [<ffffffff8021885b>] smp_apic_timer_interrupt+0x4b/0x80
 [<ffffffff8020a7e6>] apic_timer_interrupt+0x66/0x70
 [<0000000000000010>]



