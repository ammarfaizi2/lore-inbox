Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbWJOPUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWJOPUQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 11:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWJOPUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 11:20:16 -0400
Received: from smtp101.mail.mud.yahoo.com ([209.191.85.211]:9551 "HELO
	smtp101.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750893AbWJOPUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 11:20:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=sAPQjefSgXDEh7WDhXDWnsbpZuCfCuq0y+bJneQVcOAYSm4cMOOQb67MqjWrIm+Tub3aZPn9eBiAfBUBEe4wJ6UqDt953myPwswM7gmsFCggtPxO6UyPovL/sTi2BZIqAOgQxDLa1Di7mcTCAa5GaWY+ekFHY87iD53csI2/eT8=  ;
Message-ID: <453251A4.7060706@yahoo.com.au>
Date: Mon, 16 Oct 2006 01:20:04 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: ipslinux@adaptec.com, LKML <linux-kernel@vger.kernel.org>,
       Jack Hammer <jack_hammer@adaptec.com>
Subject: Re: ips: scheduling while atomic in 2.6.18
References: <20061014015244.GC10744@us.ibm.com>
In-Reply-To: <20061014015244.GC10744@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
> Hi all,
> 
> A server I administer just dumped three scheduling while atomics before
> (sort of) hanging hard. Still responds to ping, but ssh is now dead and
> the serial console stopped logging.
> 
> 8-way PIII, 2.6.18 with the 3:1 split. Wanted to get my report out there
> before I reset the box, though.

Thanks for the report. The messages are caused by this commit (cc'ed author):

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=15084a4a63bc300c18b28a8a9afac870c552abce

Not sure whether they are the cause of your hang, but the from the changelog
it doesn't look like the commit was strictly a bugfix so you could try
changing msleep calls in the driver back to MDELAY.

> 
> ips 0000:0d:06.0: Resetting controller.
> BUG: scheduling while atomic: ipssend/0x00000001/11199
>  [<c0352e4d>] schedule+0x8ad/0x920
>  [<c03550ef>] _spin_unlock_irqrestore+0xf/0x30
>  [<c011c443>] release_console_sem+0x203/0x220
>  [<c011caee>] vprintk+0x29e/0x380
>  [<c0126ab0>] lock_timer_base+0x20/0x50
>  [<c03550ef>] _spin_unlock_irqrestore+0xf/0x30
>  [<c0126c0c>] __mod_timer+0x9c/0xc0
>  [<c03536c7>] schedule_timeout+0x57/0xd0
>  [<c0125fb0>] process_timeout+0x0/0x10
>  [<c0126e58>] msleep+0x28/0x40
>  [<c02ba521>] ips_reset_copperhead_memio+0x21/0x60
>  [<c02b803c>] __ips_eh_reset+0x17c/0x380
>  [<c028f880>] scsi_done+0x0/0x30
>  [<c02bba2e>] ips_queue+0x17e/0x1b0
>  [<c028fdc1>] scsi_dispatch_cmd+0x161/0x260
>  [<c028f880>] scsi_done+0x0/0x30
>  [<c0292a90>] scsi_times_out+0x0/0x80
>  [<c0294ea7>] scsi_request_fn+0x187/0x2f0
>  [<c0212b0e>] blk_execute_rq_nowait+0x6e/0xc0
>  [<c0294c11>] scsi_execute_async+0x2b1/0x3c0
>  [<c0294620>] scsi_end_async+0x0/0x60
>  [<c02c7940>] sg_cmd_done+0x0/0x260
>  [<c02c7e28>] sg_common_write+0x288/0x700
>  [<c02c7940>] sg_cmd_done+0x0/0x260
>  [<c02c9aec>] sg_write+0x21c/0x300
>  [<c0350000>] sunrpc_cache_lookup+0x140/0x150
>  [<c0177837>] do_ioctl+0x87/0x90
>  [<c01638b5>] vfs_write+0xb5/0x190
>  [<c016408b>] sys_write+0x4b/0x80
>  [<c010329b>] syscall_call+0x7/0xb
> BUG: scheduling while atomic: ipssend/0x00000001/11199
>  [<c0352e4d>] schedule+0x8ad/0x920
>  [<c03550ef>] _spin_unlock_irqrestore+0xf/0x30
>  [<c011c443>] release_console_sem+0x203/0x220
>  [<c0126ab0>] lock_timer_base+0x20/0x50
>  [<c03550ef>] _spin_unlock_irqrestore+0xf/0x30
>  [<c0126c0c>] __mod_timer+0x9c/0xc0
>  [<c03536c7>] schedule_timeout+0x57/0xd0
>  [<c0125fb0>] process_timeout+0x0/0x10
>  [<c0126e58>] msleep+0x28/0x40
>  [<c02ba537>] ips_reset_copperhead_memio+0x37/0x60
>  [<c02b803c>] __ips_eh_reset+0x17c/0x380
>  [<c028f880>] scsi_done+0x0/0x30
>  [<c02bba2e>] ips_queue+0x17e/0x1b0
>  [<c028fdc1>] scsi_dispatch_cmd+0x161/0x260
>  [<c028f880>] scsi_done+0x0/0x30
>  [<c0292a90>] scsi_times_out+0x0/0x80
>  [<c0294ea7>] scsi_request_fn+0x187/0x2f0
>  [<c0212b0e>] blk_execute_rq_nowait+0x6e/0xc0
>  [<c0294c11>] scsi_execute_async+0x2b1/0x3c0
>  [<c0294620>] scsi_end_async+0x0/0x60
>  [<c02c7940>] sg_cmd_done+0x0/0x260
>  [<c02c7e28>] sg_common_write+0x288/0x700
>  [<c02c7940>] sg_cmd_done+0x0/0x260
>  [<c02c9aec>] sg_write+0x21c/0x300
>  [<c0350000>] sunrpc_cache_lookup+0x140/0x150
>  [<c0177837>] do_ioctl+0x87/0x90
>  [<c01638b5>] vfs_write+0xb5/0x190
>  [<c016408b>] sys_write+0x4b/0x80
>  [<c010329b>] syscall_call+0x7/0xb
> BUG: scheduling while atomic: ipssend/0x00000001/11199
>  [<c0352e4d>] schedule+0x8ad/0x920
>  [<c0352947>] schedule+0x3a7/0x920
>  [<c0126ab0>] lock_timer_base+0x20/0x50
>  [<c03550ef>] _spin_unlock_irqrestore+0xf/0x30
>  [<c0126c0c>] __mod_timer+0x9c/0xc0
>  [<c03536c7>] schedule_timeout+0x57/0xd0
>  [<c03550ef>] _spin_unlock_irqrestore+0xf/0x30
>  [<c0125fb0>] process_timeout+0x0/0x10
>  [<c0126e58>] msleep+0x28/0x40
>  [<c02ba5e0>] ips_init_copperhead_memio+0x20/0x150
>  [<c0125fb0>] process_timeout+0x0/0x10
>  [<c02ba542>] ips_reset_copperhead_memio+0x42/0x60
>  [<c02b803c>] __ips_eh_reset+0x17c/0x380
>  [<c028f880>] scsi_done+0x0/0x30
>  [<c02bba2e>] ips_queue+0x17e/0x1b0
>  [<c028fdc1>] scsi_dispatch_cmd+0x161/0x260
>  [<c028f880>] scsi_done+0x0/0x30
>  [<c0292a90>] scsi_times_out+0x0/0x80
>  [<c0294ea7>] scsi_request_fn+0x187/0x2f0
>  [<c0212b0e>] blk_execute_rq_nowait+0x6e/0xc0
>  [<c0294c11>] scsi_execute_async+0x2b1/0x3c0
>  [<c0294620>] scsi_end_async+0x0/0x60
>  [<c02c7940>] sg_cmd_done+0x0/0x260
>  [<c02c7e28>] sg_common_write+0x288/0x700
>  [<c02c7940>] sg_cmd_done+0x0/0x260
>  [<c02c9aec>] sg_write+0x21c/0x300
>  [<c0350000>] sunrpc_cache_lookup+0x140/0x150
>  [<c0177837>] do_ioctl+0x87/0x90
>  [<c01638b5>] vfs_write+0xb5/0x190
>  [<c016408b>] sys_write+0x4b/0x80
>  [<c010329b>] syscall_call+0x7/0xb
> 
> Thanks,
> Nish
> 


-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
