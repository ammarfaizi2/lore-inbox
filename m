Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUCRAiy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:38:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUCRAiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:38:54 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:51699 "EHLO
	orion.mvista.com") by vger.kernel.org with ESMTP id S261500AbUCRAip
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:38:45 -0500
Date: Wed, 17 Mar 2004 16:38:41 -0800
From: Jun Sun <jsun@mvista.com>
To: linux-kernel@vger.kernel.org
Cc: jsun@mvista.com
Subject: O(1) issue - new processes should start with interrupts disabled?
Message-ID: <20040318003841.GE19033@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


About a year ago I was working on a MIPS 2.4 kernel with O(1) and hit
the following bug.  See the back trace below.  The interrupt that triggered
do_IRQ() happened exactly after switch_to() (switching to a newly forked 
process) but before the new process calls schedule_tail().

As a result try_to_take_up() goes into infinite loop because it can't
grap this_rq()->lock as it is already locked at the beginning of schedule().

The fix was trivial.  I simply turned off interrupt for newly forked processes.
Interrupts are turned on again during schedule_tail() call, which seems to be
the right place.

Right now I am trying to get this issue straighten out in 2.6 tree.  I am curious 
why this bug does not show on other architectures?  Because switch_to() does 
not change the interrupt status of CPU on other arches?  

Jun

(gdb) bt
#0  try_to_wake_up (p=0x8fe5a000, sync=0) at spinlock.h:38
#1  0x80112e6c in __wake_up (q=0x8fe5bc30, mode=3, nr_exclusive=1)
    at sched.c:1121
#2  0x80236ecc in rpc_make_runnable (task=0x8fe5bbc8) at sched.c:278
#3  0x80234b98 in __rpc_wake_up_task (task=0x8fe5bbc8) at sched.c:393
#4  0x80234cf8 in rpc_wake_up_task (task=0x1) at sched.c:418
#5  0x80231f38 in xprt_complete_rqst (xprt=0x813ffa8c, req=0x813e7198,
    copied=96) at xprt.c:575
#6  0x80232374 in udp_data_ready (sk=0x8fe4b080, len=-2144948192) at xprt.c:690
#7  0x80218194 in udp_queue_rcv_skb (sk=0x0, skb=0x8f8893c0) at sock.h:1176
#8  0x80218778 in udp_rcv (skb=0x8f8893c0) at udp.c:921
#9  0x801f2cc8 in ip_local_deliver_finish (skb=0x8f8893c0) at ip_input.c:262
#10 0x801f284c in ip_local_deliver (skb=0x8026b020) at ip_input.c:302
#11 0x801f2f6c in ip_rcv_finish (skb=0x8f8893c0) at ip_input.c:367
#12 0x801f2aac in ip_rcv (skb=0x8f8893c0, dev=0x8026b020, pt=0x1)
    at ip_input.c:437
#13 0x801df6e0 in netif_receive_skb (skb=0x8f8893c0) at dev.c:1496
#14 0x801df8f8 in process_backlog (blog_dev=0x8027f1cc, budget=0x8f8a3e00)
    at dev.c:1529
#15 0x801dfb60 in net_rx_action (h=0x10005f00) at dev.c:1591
#16 0x8011ed20 in do_softirq () at softirq.c:103
#17 0x80102de8 in do_IRQ (irq=19, regs=0x8f8a3e80) at irq.c:492

