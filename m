Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbTIVUiU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbTIVUiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:38:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:26509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263197AbTIVUiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:38:09 -0400
Subject: Re: 2.6.0-test5-mm3 as-iosched Oops running dbt2 workload
From: Mary Edie Meredith <maryedie@osdl.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Dave Olien <dmo@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <3F6BAC5F.503@cyberone.com.au>
References: <20030919185621.GA18666@osdl.org> <3F6BAC5F.503@cyberone.com.au>
Content-Type: text/plain
Organization: Open Source Development Lab
Message-Id: <1064263080.29354.262.camel@ibm-e.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 22 Sep 2003 13:38:00 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your patch applied to 2.6.0-test5-mm3 and running the same test
conditions unfortunately panics at the same time in the run with the
following:


------------[ cut here ]------------
^Mkernel BUG at drivers/block/as-iosched.c:1091!
^Minvalid operand: 0000 [#1]
^MSMP
^MCPU:    3
^MEIP:    0060:[<c0227ef8>]    Not tainted VLI
^MEFLAGS: 00010046
^MEIP is at as_move_to_dispatch+0x1b8/0x1d0
^Meax: 00000000   ebx: 00000000   ecx: 00000000   edx: ffffff45
^Mesi: 00000000   edi: f7a1b6c0   ebp: d36a8660   esp: e7ce5ed0
^Mds: 007b   es: 007b   ss: 0068
^MProcess driver.jan14_pr (pid: 2204, threadinfo=e7ce4000 task=e7e8e0a0)
^MStack: 000f41a8 00000000 c3868bc0 00009572 e7ce5f68 f7a1b6c0 00000000
00000001
^M       d36a8660 c022804b f7a1b6c0 d36a8660 e7ce5f68 01f5f956 00000000
f7a1b6c0
^M       00000000 f77fc800 e7ce5fc4 c0228238 f7a1b6c0 f79e8c38 f77fc800
c021fbb6
^MCall Trace:
^M [<c022804b>] as_dispatch_request+0x13b/0x2f0
^M [<c0228238>] as_next_request+0x38/0x50
^M [<c021fbb6>] elv_next_request+0x16/0x110
^M [<c023a198>] DAC960_ProcessRequest+0x38/0x190
^M [<c023cdb0>] DAC960_BA_InterruptHandler+0x90/0xb0
^M [<c010e899>] handle_IRQ_event+0x49/0x80
^M [<c010ec0f>] do_IRQ+0x9f/0x150
^M [<c030cb7c>] common_interrupt+0x18/0x20
^M [<c030007b>] rpcauth_free_credcache+0x4b/0x100
^M
^MCode: f6 e8 bd b7 ff ff 89 b7 c4 00 00 00 e9 ba fe ff ff 8d 45 1c 89
44 24 04 8d 87 c4 00 00 00 89 04 24 e8 1d b9 ff ff e9 ab fe ff ff <0f>
0b 43 04 5
d db 32 c0 e9 57 fe ff ff 8d 74 26 00 8d bc 27 00
^M <0>Kernel panic: Fatal exception in interrupt
^MIn interrupt handler - not syncing
^M <6>APIC error on CPU3: 00(08)
^MAPIC error on CPU3: 08(08)
------------------------------------
...




On Fri, 2003-09-19 at 18:24, Nick Piggin wrote:
> Sigh. Sorry, I'm an idiot...
> 
> If a request is merged with another, it sometimes has to be repositioned
> on the rbtree - you just do a delete then an add. This is a quite
> uncommon case though.
> 
> I changed the way adding works, so collisions must be handled by the
> caller instead of being dumbly fixed by the add routine. Unfortunately
> the uncommon callers weren't handling it properly. Try this please.
> 
> 
> 
> Dave Olien wrote:
> 
> >Andrew,
> >
> >Attached is console output containing a stack trace from an Oops, followed
> >by a Fatal exception, and LOTS of APIC errors.  The machine was hung,
> >printing APIC error messages forever.
> >
> >This looks like another as-iosched problem.  So, I'm copying Nick Piggin
> >on this email.  But the Fatal exception and APIC errors following
> >that are a mystery to me.
> >
> >Mary encountered this running the sapdb dbt2 cached database workload on her
> >project machine.  The project machine was running 2.6.0-test5-mm3.
> >This same test passes on the stp machines.  But Mary's project machine
> >has more processors, and more disks, and a different disk controller type.
> >
> >At this stage, the database has gotten past the database restore phase.
> >That's where it was failing prior to last night's mm3 patch.  Now, the
> >database itself has been running for about 30 minutes.  In the cached
> >case, much of that first 30 minutes is spent loading the cache.
> >
> >This Oops seems to have occurred at about the time the database is
> >transitioning to using its cache.  Most of the I/O after this point
> >is to the log, doing LOTS of sequential writes, with the occasional
> >random read/write.
> >
> >Since this machine has more processors, it's doing transactions
> >more quickly than the same workload on STP machines.  So the log write
> >traffic is probably a lot heavier.
> >

> _
-- 
Mary Edie Meredith <maryedie@osdl.org>
Open Source Development Lab

