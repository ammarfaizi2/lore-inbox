Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbTISUpg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 16:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbTISUpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 16:45:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:64174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261710AbTISUpd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 16:45:33 -0400
Subject: Re: 2.6.0-test5-mm3 as-iosched Oops running dbt2 workload
From: Mary Edie Meredith <maryedie@osdl.org>
To: Dave Olien <dmo@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au
In-Reply-To: <20030919185621.GA18666@osdl.org>
References: <20030919185621.GA18666@osdl.org>
Content-Type: text/plain
Organization: Open Source Development Lab
Message-Id: <1064004331.5730.4617.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 19 Sep 2003 13:45:31 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found one more data point about this event.  

The hang seems to have occurred at precisely when a "SAVEPOINT"
(basically a checkpoint) started .  That is, the database started to
write its dirty 8k pages from the database buffer cache (mmaps) to the
11 datafiles (raw devices) randomly.  So that activity would be added to
the synchronous sequential 8k writes (logging) to a 12th raw device.

On Fri, 2003-09-19 at 11:56, Dave Olien wrote:
> Andrew,
> 
> Attached is console output containing a stack trace from an Oops, followed
> by a Fatal exception, and LOTS of APIC errors.  The machine was hung,
> printing APIC error messages forever.
> 
> This looks like another as-iosched problem.  So, I'm copying Nick Piggin
> on this email.  But the Fatal exception and APIC errors following
> that are a mystery to me.
> 
> Mary encountered this running the sapdb dbt2 cached database workload on her
> project machine.  The project machine was running 2.6.0-test5-mm3.
> This same test passes on the stp machines.  But Mary's project machine
> has more processors, and more disks, and a different disk controller type.
> 
> At this stage, the database has gotten past the database restore phase.
> That's where it was failing prior to last night's mm3 patch.  Now, the
> database itself has been running for about 30 minutes.  In the cached
> case, much of that first 30 minutes is spent loading the cache.
> 
> This Oops seems to have occurred at about the time the database is
> transitioning to using its cache.  Most of the I/O after this point
> is to the log, doing LOTS of sequential writes, with the occasional
> random read/write.
> 
> Since this machine has more processors, it's doing transactions
> more quickly than the same workload on STP machines.  So the log write
> traffic is probably a lot heavier.
> 
> 
> ------------[ cut here ]------------
> kernel BUG at drivers/block/as-iosched.c:1230!
> invalid operand: 0000 [#1]
> SMP 
> CPU:    3
> EIP:    0060:[<c0228146>]    Not tainted VLI
> EFLAGS: 00010046
> EIP is at as_dispatch_request+0x236/0x2f0
> eax: 00000000   ebx: f7a451a0   ecx: 00000000   edx: 00000000
> esi: 00000000   edi: 00000001   ebp: 00000000   esp: f5f67ef8
> ds: 007b   es: 007b   ss: 0068
> Process kernel (pid: 2283, threadinfo=f5f66000 task=f62760a0)
> Stack: f7a451a0 f5900820 f7a28000 f7a02600 c0235c23 f7a451a0 00000000 f7836000 
>        f5f67fc4 c0228238 f7a451a0 f7a08420 f7836000 c021fbb6 f7836000 f77e0000 
>        f7a28000 f7a08420 f7a28000 c023a128 f7836000 f5f02de0 f77e0090 0000000a 
> Call Trace:
>  [<c0235c23>] DAC960_BA_QueueCommand+0x43/0xb0
>  [<c0228238>] as_next_request+0x38/0x50
>  [<c021fbb6>] elv_next_request+0x16/0x110
>  [<c023a128>] DAC960_ProcessRequest+0x38/0x190
>  [<c023cd40>] DAC960_BA_InterruptHandler+0x90/0xb0
>  [<c010e899>] handle_IRQ_event+0x49/0x80
>  [<c010ec0f>] do_IRQ+0x9f/0x150
>  [<c030cb0c>] common_interrupt+0x18/0x20
>  [<c030007b>] rpcauth_free_credcache+0xbb/0x100
> 
> Code: 43 50 00 00 00 00 8b 43 54 8b 6b 1c c7 43 5c 00 00 00 00 89 43 58 e9 95 fe ff ff c7 43 48 01 00 00 00 c7 43 4c 00 00 00 00 eb d4 <0f> 0b ce 04 fd da 32 c0 eb c7 8b 43 50 e9 61 ff ff ff 0f 0b b6 
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
>  <6>APIC error on CPU3: 00(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
> APIC error on CPU3: 08(08)
-- 
Mary Edie Meredith <maryedie@osdl.org>
Open Source Development Lab

