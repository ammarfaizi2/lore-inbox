Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbTI3ItW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 04:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTI3ItW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 04:49:22 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:44677 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261223AbTI3ItU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 04:49:20 -0400
Date: Tue, 30 Sep 2003 09:48:53 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Klaus Dittrich <kladit@t-online.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>, akpm@zip.com.au,
       "Hu, Boris" <boris.hu@intel.com>, Hugh Dickins <hugh@veritas.com>,
       Ulrich Drepper <drepper@redhat.com>, Jamie Lokier <jamie@shareable.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.0-test6 oops futex"
Message-ID: <20030930084853.GD26649@mail.jlokier.co.uk>
References: <20030929092308.GA4189@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030929092308.GA4189@xeon2.local.here>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Dittrich wrote:
> With linux-2.6.0-test6 I got several times this oops.
> I had no problems with linux-2.6.0-test5 before. (absolute stable for me)

This oops is in the first store in the __list_del() of
list_del_init(), inside the loop of futex_wake.

The "next" link of the current futex in the loop is corrupt.  More
precisely, the iterator list node contains { LIST_POISON1, LIST_POISON2 }
which means it must have been earlier deleted using list_del().

The only call to list_del() in the futex code is in unqueue_me(),
where it is protected against the same spinlock as all the other
queuing and dequeuing operations.

The one possibility I can think of is that the hash function isn't
consistent, either because of a hashing bug or because the hash
function argument is being changed.  Then different locks would be
used between one place and another, permitting the lists to become
corrupt.  That would explain the oops appearing only in test6, which
is when the new hashing scheme and split locks appeared.

I don't see any obvious flaw.  Rusty, Hugh, anyone else see it?

Ulrich, could you try a favourite futex stress test on vanilla
2.6.0-test6, to see if you can reliably trigger this oops?

Thanks,
-- Jamie

> Sep 29 11:06:36 xeon2 kernel: Unable to handle kernel paging request at virtual address 00100104
> Sep 29 11:06:36 xeon2 kernel:  printing eip:
> Sep 29 11:06:36 xeon2 kernel: c013522d
> Sep 29 11:06:36 xeon2 kernel: *pde = 00000000
> Sep 29 11:06:36 xeon2 kernel: Oops: 0002 [#1]
> Sep 29 11:06:36 xeon2 kernel: CPU:    3
> Sep 29 11:06:36 xeon2 kernel: EIP:    0060:[<c013522d>]    Not tainted
> Sep 29 11:06:36 xeon2 kernel: EFLAGS: 00010246
> Sep 29 11:06:36 xeon2 kernel: EIP is at futex_wake+0xe4/0x140
> Sep 29 11:06:36 xeon2 kernel: eax: 00200200   ebx: f6e4deec   ecx: 00000000   edx: 00100100
> Sep 29 11:06:36 xeon2 kernel: esi: c054cbc0   edi: 00000000   ebp: c054cbc0   esp: f626df3c
> Sep 29 11:06:36 xeon2 kernel: ds: 007b   es: 007b   ss: 0068
> Sep 29 11:06:36 xeon2 kernel: Process MozillaFirebird (pid: 967, threadinfo=f626c000 task=f6cdc080)
> Sep 29 11:06:36 xeon2 kernel: Stack: f626df4c f626df4c 00000fe8 c054cbbc 0819c000 f7472c80 00000fe8 e75d6008
> Sep 29 11:06:36 xeon2 kernel:        0819cfe8 00000001 0819cfe8 00000001 c0135c77 0819cfe8 00000001 00000000
> Sep 29 11:06:36 xeon2 kernel:        00000001 c0135d85 0819cfe8 00000001 00000001 7fffffff 0819cfe8 00000000
> Sep 29 11:06:36 xeon2 kernel: Call Trace:
> Sep 29 11:06:36 xeon2 kernel:  [<c0135c77>] do_futex+0x7e/0x80
> Sep 29 11:06:36 xeon2 kernel:  [<c0135d85>] sys_futex+0x10c/0x124
> Sep 29 11:06:36 xeon2 kernel:  [<c0124d8b>] sys_gettimeofday+0x53/0xa8
> Sep 29 11:06:36 xeon2 kernel:  [<c010aba9>] sysenter_past_esp+0x52/0x71
> Sep 29 11:06:36 xeon2 kernel:
> Sep 29 11:06:36 xeon2 kernel: Code: 89 42 04 89 10 89 5b 04 8d 43 08 89 1b ba 03 00 00 00 e8 3b
> Sep 29 11:06:36 xeon2 kernel:  <6>note: MozillaFirebird[967] exited with preempt_count 1
> 
> -- 
> Klaus 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
