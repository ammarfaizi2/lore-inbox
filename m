Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWIXKTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWIXKTl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 06:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWIXKTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 06:19:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751904AbWIXKTj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 06:19:39 -0400
Date: Sun, 24 Sep 2006 03:19:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Weiske <cweiske@cweiske.de>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: 2.6.18 BUG: unable to handle kernel NULL pointer dereference at
 virtual address 000,0000a
Message-Id: <20060924031923.76886810.akpm@osdl.org>
In-Reply-To: <45164BA6.60200@cweiske.de>
References: <45155915.7080107@cweiske.de>
	<20060923134244.e7b73826.akpm@osdl.org>
	<45164BA6.60200@cweiske.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2006 11:11:02 +0200
Christian Weiske <cweiske@cweiske.de> wrote:

> Andrew,
> 

You keep on losing Cc:s.  Please preserve them all with care when replying.

> 
> >> I have a reproducible BUG on my server that occurs whenever disk usage
> >> gets too high / too much swapping occurs (at least I think that is). The
> >> box has one reiserfs filesystem of about 187GB size, the disk is on an
> >> Epia 5000 board, between them is a Promise Ultra 100 PCI IDE controller
> >> card.
> > Do you think this bug is due to the 2.6.18 upgrade?
> 
> No. I already had it in 2.6.17.6.
> 
> > Have you run fsck across the filesystem(s)?
> fsck at boot turns up
> > ReiserFS: hde3: checking transaction log (hde3)
> > ReiserFS: hde3: replayed 22 transactions in 0 seconds
> > ReiserFS: hde3: Using r5 hash to sort names
> nothing more
> 
> > Does the oops always look the same as this one?
> No, not exactly the same. I attach three log files. If you diff them,
> there will be about 30% of the lines different.
> 
> One thing I have to note is that the second Oops appears about 10
> seconds after the first one.
> 
> > Please turn on the various CONFIG_DEBUG_* options, see if that turns up
> > anything.
> That indeed turns up something. The debug messages indicate that java
> wants to lock something and gets stuck. Note that the messages until
> "slab corruption" are printed first, and the others about a minute or
> two later.
> 
> And I still can ping and do everything until the slab corruption occurs.
> (Thus the other messages some minute later)
> 
> 
> > It would be interesting to find out if enabling CONFIG_4KSTACKS makes this
> > go away (although I'm not sure why).
> Didn't try this yet, but will.
> 
> I put the logs in a tar.bz2 because I didn't want to flood the list with
> a 200k message.
> 

OK, you have crashes in the scheduler and one crash when accessing a
reiserfs structure.

You have tcp_v6 lockdep warnings.  They're in
http://xml.cweiske.de/dojo%20kernelpanic%20+%20debug.tar.bz2 is anyone is
keen.  (I've largely lost interest in lockdep warnings - many of them are
false positives and require make-lockdep-shut-up patches).

You have what claims to be a netfilter-related memory corruption:

Slab corruption: start=c608a42c, len=172
Redzone: 0x6b6b6b6b/0xc0411958.
Last user: [<170fc2a5>](0x170fc2a5)
0a0: 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=c608a2c1, len=172
Redzone: 0xec0410f/0x1170fc2.
Last user: [<30000000>](0x30000000)
000: 00 00 00 10 a2 08 c6 a8 a5 08 c6 46 3a 00 00 10
010: 10 41 c0 bc a2 08 c6 20 d3 60 c0 00 00 00 00 00
slab error in cache_alloc_debugcheck_after(): cache `ip_conntrack': double freen
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0160c11>] __slab_error+0x21/0x30
 [<c0162ca1>] cache_alloc_debugcheck_after+0x121/0x1a0
 [<c0162ffb>] kmem_cache_alloc+0x6b/0xc0
 [<c041184c>] ip_conntrack_alloc+0x3c/0x130
 [<c041198a>] init_conntrack+0x2a/0x110
 [<c0411c4e>] ip_conntrack_in+0x1de/0x230
BUG: unable to handle kernel NULL pointer dereference at virtual address 0000008
 printing eip:



And another in what appears to be core ipv4:

Slab corruption: start=c3aff608, len=240
Redzone: 0x6b6b6b6b/0x0.
Last user: [<170fc2a5>](0x170fc2a5)
0e0: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=c3aff48f, len=240
Redzone: 0x6b6b6b6b/0x6b6b6b6b.
Last user: [<6b6b6b6b>](0x6b6b6b6b)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
slab error in cache_alloc_debugcheck_after(): cache `ip_dst_cache': double freen
 [<c01034b9>] show_trace+0x19/0x20
 [<c01035ba>] dump_stack+0x1a/0x20
 [<c0160c11>] __slab_error+0x21/0x30
 [<c0162ca1>] cache_alloc_debugcheck_after+0x121/0x1a0
 [<c0162ffb>] kmem_cache_alloc+0x6b/0xc0
 [<c03ca3c4>] dst_alloc+0x24/0x90
 [<c03da865>] ip_route_input_slow+0x295/0x8c0
 [<c03daf92>] ip_route_input+0x102/0x1d0
 [<c03dd29a>] ip_rcv+0x27a/0x440
 [<c03c6d41>] netif_receive_skb+0x1b1/0x1f0
 [<c03c6e10>] process_backlog+0x90/0x120
 [<c03c6f0d>] net_rx_action+0x6d/0x100
 [<c011d4af>] __do_softirq+0x6f/0x100
 [<c011d59f>] do_softirq+0x5f/0x70
 [<c011d603>] irq_exit+0x53/0x60
 [<c0104c28>] do_IRQ+0x38/0x70
 [<c0103145>] common_interrupt+0x25/0x30
 [<c028e19b>] memcpy+0x3b/0x50
 [<c028e208>] memmove+0x38/0x50
 [<c01bf85d>] leaf_paste_in_buffer+0x7d/0x320
 [<c01a862c>] balance_leaf+0x24c/0x27d0
 [<c01aaee0>] do_balance+0x60/0xf0
 [<c01c56e4>] reiserfs_paste_into_item+0x164/0x190
 [<c01b3ab5>] reiserfs_allocate_blocks_for_region+0x925/0x12e0
 [<c01b5b2c>] reiserfs_file_write+0x72c/0x7c0
 [<c0166768>] vfs_write+0x88/0x170
 [<c01668fc>] sys_write+0x3c/0x70
 [<c0102e77>] syscall_call+0x7/0xb


And another networking-related scribble:


Slab corruption: start=c64159ec, len=156
Redzone: 0x6b6b6b6b/0xc03c048a.
Last user: [<170fc2a5>](0x170fc2a5)
090: 6b 6b 6b 6b 6b 6b 6b a5 71 f0 2c 5a
Prev obj: start=c64158ec, len=156
Redzone: 0x6b6b6b6b/0x6b6b6b6b.
Last user: [<6b6b6b6b>](0x6b6b6b6b)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
slab error in cache_alloc_debugcheck_after(): cache `skbuff_head_cache': doublen
BUG: unable to handle kernel paging request at virtual address b2724e87
 printing eip:
c028bf49
*pde = 00000000
Oops: 0000 [#1]


A lot of your oopses seem to point at the hrtimer code:


BUG: unable to handle kernel paging request at virtual address b2724e87
 printing eip:
c028bf49
*pde = 00000000
Oops: 0000 [#1]
PREEMPT
Modules linked in:
CPU:    0
EIP:    0060:[<c028bf49>]    Not tainted VLI
EFLAGS: 00010086   (2.6.18 #2)
EIP is at __rb_erase_color+0x59/0x180
eax: b2724e87   ebx: c69c1f64   ecx: cdbcdf64   edx: 00000000
esi: c69c1f64   edi: c05137d8   ebp: c6405390   esp: c6405384
ds: 007b   es: 007b   ss: 0068
Process Øc.{.J.. (pid: 0, ti=c6404000 task=c0511b40 task.ti=c01174d0)
Stack: c69c1f64 00000000 c05137d8 c64053b4 c028c17b 00000000 c69c1f64 c0513804
       00000001 cdbcdf64 c05137d8 c05137d8 c64053cc c012f4ba cdbcdf64 c0513804
       c012f7f0 cdbcdf64 c64053f0 c012f777 cdbcdf64 c05137d8 c05137dc 00000001
Call Trace:
 [<c010354e>] show_stack_log_lvl+0x8e/0xb0
 [<c010370a>] show_registers+0x14a/0x1d0
 [<c0103987>] die+0x167/0x210
 [<c010ed13>] do_page_fault+0x173/0x580
 [<c0103199>] error_code+0x39/0x40
 [<c028c17b>] rb_erase+0x10b/0x140
 [<c012f4ba>] __remove_hrtimer+0x1a/0x40
 [<c012f777>] hrtimer_run_queues+0x77/0xf0
 [<c0121f46>] run_timer_softirq+0x16/0x1a0
 [<c011d4af>] __do_softirq+0x6f/0x100
 [<c011d59f>] do_softirq+0x5f/0x70



What a mess.

