Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbULBLJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbULBLJb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 06:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbULBLJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 06:09:31 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:9088
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S261578AbULBLJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 06:09:24 -0500
Subject: Re: [PATCH] oom killer (Core)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       LKML <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <20041202033619.GA32635@dualathlon.random>
References: <20041201104820.1.patchmail@tglx>
	 <20041201211638.GB4530@dualathlon.random>
	 <1101938767.13353.62.camel@tglx.tec.linutronix.de>
	 <20041202033619.GA32635@dualathlon.random>
Content-Type: text/plain
Date: Thu, 02 Dec 2004 12:09:19 +0100
Message-Id: <1101985759.13353.102.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-12-02 at 04:36 +0100, Andrea Arcangeli wrote:
> Could you please test this? Perhaps it won't be as effective as the
> hacks I nuked, but it fixed basic things for me in a quick test so I
> like it more. It's important to use pages_high to avoid livelocks.
> 

Sorry man. The behaviour is worse than before, but I expected that :)

It kills sshd, the application, the controlling terminal and some other
innocent processes like hotplug. 

Take a decent UP machine enable PREEMPT and start # hackbench NN , where
NN is a number of processes, which exhausts the memory of the machine
and see yourself.

If there is the point where memory is exhausted you have to kill a
process _and_ wait until the memory is freed before even thinking about
another invocation of oom_kill().

There is usually more than one process on a machine which requests
memory. So as long as the first kill did not proceed to the point where
the memory is actually freed, you will call out_of_memory() from
different processes or kernel functions and make the machine less usable
than neccecary.

The oom_kill is invoked about 100 times. It ends up killing hotplug when
already 112MB memory are available. See below.

I agree, that the timed hack stuff in out_of_memory is ugly, but we need
some mechanism to avoid 

	1. reentrancy into oom_kill
	2. invocation of oom_kill until the already killed process
	   has finally released memory.

Further we need a better selection of whom to kill. 

tglx

<SNIP>
Free pages:      112360kB (0kB HighMem)
<SNIP>
 [<c0132151>] out_of_memory+0x21/0x30
 [<c0132f96>] __alloc_pages+0x2f6/0x380
 [<c013303f>] __get_free_pages+0x1f/0x40
 [<c013665f>] kmem_getpages+0x1f/0xd0
 [<c0137339>] cache_grow+0xb9/0x180
 [<c0137573>] cache_alloc_refill+0x173/0x220
 [<c01378d4>] __kmalloc+0x74/0x80
 [<c02534d7>] alloc_skb+0x47/0xf0
 [<c0252717>] sock_alloc_send_pskb+0xc7/0x1d0
 [<c025284d>] sock_alloc_send_skb+0x2d/0x40
 [<c02ad466>] unix_stream_sendmsg+0x196/0x400
 [<c012f987>] filemap_nopage+0x207/0x3a0
 [<c024fa66>] sock_aio_write+0xf6/0x120
 [<c014c967>] do_sync_write+0xb7/0xf0
 [<c016048b>] do_pollfd+0x5b/0xa0
 [<c0126f90>] autoremove_wake_function+0x0/0x60
 [<c016053a>] do_poll+0x6a/0xd0
 [<c014ca9f>] vfs_write+0xff/0x130
 [<c014cba1>] sys_write+0x51/0x80
 [<c01027cb>] syscall_call+0x7/0xb
Out of Memory: Killed process 3037 (hotplug).



