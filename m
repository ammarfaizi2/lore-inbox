Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265146AbUBINBn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 08:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUBINBm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 08:01:42 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:14720 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S265146AbUBINBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 08:01:41 -0500
Date: Mon, 9 Feb 2004 14:01:34 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.2 crash after network link failure
Message-ID: <20040209130134.GA14136@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  on Saturday our network switch lost power due to scheduled
Power outage, and unfortunately one of systems connected to the switch
(mine :-( ) did not survive it. When I came to the system's console today, 
I found (written by hand, made a bit shorter...) on screen:

e100: eth0 NIC Link is Up 100Mbps Full Duplex
kernel/sched.c:1802: spin_is_locked on uninitialized spinlock d6e74e18
Unable to handle NULL kernel pointer dereference at virtual address 00000000
...
EIP: C0120AF1  <__wake_up_common + 0x17/0x57>
...
EAX: D6E74E30   EBX: D6E74E18    ECX: 00000001    EDX: 00000000
ESI: 00000001   EDI: 00000001    EBP: C9F3DEDC    ESP: C9F3DEC0
...
Call Trace:
   __wake_up + 0x7B/0x139
   sock_def_write_space + 0x8C/0x94
   sock_wfree + 0x4B/0x4D
   __kfree_skb + 0x5C/0xD9
   net_tx_action + 0x3E/0x210
   do_softirq + 0x92/0x94
   do_IRQ + 0x207/0x360
   common_interrupt + 0x18/0x20


It looks to me like that we've got skb on completion_queue which was connected
to a bit unhappy socket - one which had sk->sk_sleep uninitialized. Only problem 
is that only af_unix sets skb->destructor to sock_wfree, so I somehow miss how 
this could be triggered by e100 link change.

Kernel is approx 2.6.2-bk2, UP, APIC, IOAPIC, no-preempt, all DEBUG options except
CONFIG_FRAME_POINTER enabled.

System is 1.6GHz P4/512MB RAM.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz
