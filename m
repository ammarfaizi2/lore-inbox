Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbTF2OXL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 10:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265690AbTF2OXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 10:23:11 -0400
Received: from mail.cs.Virginia.EDU ([128.143.137.19]:18849 "EHLO
	ares.cs.Virginia.EDU") by vger.kernel.org with ESMTP
	id S265681AbTF2OXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 10:23:03 -0400
Date: Sun, 29 Jun 2003 10:37:12 -0400 (EDT)
From: Ronghua Zhang <rz5b@cs.virginia.edu>
To: linux-net@vger.kernel.org
cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: How to send multiple TCP packets from a kernel thread ASAP?
Message-ID: <Pine.GSO.4.51.0306291023170.12980@mamba.cs.Virginia.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I came to a situation that requires to send multiple TCP packets (one
for each connection) from a kernel thread as soon as possible. The
following is the skeleton of my code:

kernel_thread()
{
    foreach sk in (alive connections){
        tp = &(sk->tp_pinfo.af_tcp);

        skb = alloc_skb(xxx, GFP_ATOMIC);
        /* build TCP header */
        tcp_build_and_update_options(.....);
        tp->af_specific->send_check(sk, th, skb->len, skb);

        tp->af_specific->queue_xmit(skb);
        printk("packet send out for sk %p, at %lu\n", sk, jiffies);
    }
}

the output is always like this:
packet send out for sk 1 at 1000
packet send out for sk 2 at 1001
packet send out for sk 3 at 1002
...

It looks like this kernel thread get rescheduled after it has sent out 1
packet. But why? each iteration certainly does not need 10ms, why it get
rescheduled? Is it because af_specific->queue_xmit() is blocking
operation? but I notice that tcp_transmit_skb() also call it, and
tcp_transmit_skb() should not call any blockalbe operation. I try to
increase its priority or change its schedule policy,but has no effect
at all. Any suggestion is appreciated! This is really urgent.


Ronghua
