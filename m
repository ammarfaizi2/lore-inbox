Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVE3Onh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVE3Onh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVE3Onh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:43:37 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:4040 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261618AbVE3Omf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:42:35 -0400
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
cc: davem@davemloft.net, Steven.Hand@cl.cam.ac.uk
Subject: Bug in 2.6.11.11 - udp_poll(), fragments + CONFIG_HIGHMEM
Date: Mon, 30 May 2005 15:42:30 +0100
From: Steven Hand <Steven.Hand@cl.cam.ac.uk>
Message-Id: <E1DclTK-0002qE-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary: with CONFIG_HIGHMEM set, net/ipv4/udp.c::udp_poll() 
         fails when rx'ing an skb with fragments. 

         Present in [at least] 2.6.11.*, 2.6.10 


Details: 

User space code polling on a blocking socket fd receives an
skb with fragments -- this is very unlikely in the common 
case but can happen with encapsulation etc; however its pretty
much guaranteed to happen under Xen 2.x when communicating 
between dom0 and domU. 


Example backtrace from console: 

 kernel: Badness in local_bh_enable at kernel/softirq.c:140
 kernel:  [local_bh_enable+130/144] local_bh_enable+0x82/0x90
 kernel:  [skb_checksum+317/704] skb_checksum+0x13d/0x2c0
 kernel:  [udp_poll+154/352] udp_poll+0x9a/0x160
 kernel:  [sock_poll+41/64] sock_poll+0x29/0x40
 kernel:  [do_pollfd+149/160] do_pollfd+0x95/0xa0
 kernel:  [do_poll+106/208] do_poll+0x6a/0xd0
 kernel:  [sys_poll+353/576] sys_poll+0x161/0x240
 kernel:  [sys_gettimeofday+60/144] sys_gettimeofday+0x3c/0x90
 kernel:  [__pollwait+0/208] __pollwait+0x0/0xd0
 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb


Reconstructed forward trace: 

   net/ipv4/udp.c:1334   spin_lock_irq() 
   net/ipv4/udp.c:1336   udp_checksum_complete() 
net/core/skbuff.c:1069   skb_shinfo(skb)->nr_frags > 1
net/core/skbuff.c:1086   kunmap_skb_frag()
net/core/skbuff.h:1087   local_bh_enable()
 kernel/softirq.c:0140   WARN_ON(irqs_disabled());







