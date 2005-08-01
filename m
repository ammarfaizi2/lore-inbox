Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVHAIfq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVHAIfq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 04:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVHAIfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 04:35:46 -0400
Received: from smtp.ifrance.com ([82.196.5.121]:62651 "EHLO smtp.ifrance.com")
	by vger.kernel.org with ESMTP id S261238AbVHAIfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 04:35:43 -0400
Message-ID: <42EDDE50.6050800@winch-hebergement.net>
Date: Mon, 01 Aug 2005 10:33:20 +0200
From: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davem@davemloft.net
Cc: akpm@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 - kernel panic - BUG at net/ipv4/tcp_output.c:918
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 > [TCP]: Fix two TSO sizing bugs
 >
 > MSS changes can be lost since we preemptively initialize
 > the tso_segs count for an SKB before we %100 commit
 > to sending it out.
 > So, by the time we send it out, the tso_size information
 > can be stale due to PMTU events.  This mucks up all of the
 > logic in our send engine, and can even result in the BUG()
 > triggering in tcp_tso_should_defer().
 > Another problem we have is that we're storing the tp->mss_cache,
 > not the SACK block normalized MSS, as the tso_size.  That's wrong
 > too.
 >
 > Signed-off-by: David S. Miller <davem@davemloft.net>

I just tried the patch attached. :)

The bug is still here (same symptoms), with a slightly different backtrace :
------------[ cut here ]------------
kernel BUG at net/ipv4/tcp_output.c:918!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c027dd66>]    Not tainted VLI
EFLAGS: 00010297   (2.6.13-rc4-endy)
EIP is at tcp_tso_should_defer+0xd6/0xf0
eax: 00000005   ebx: f5032e80   ecx: 00000007   edx: f3b2fc00
esi: 00000006   edi: 00000006   ebp: c031fd78   esp: c031fd68
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 0, threadinfo=c031e000 task=c02dbb80)
Stack: f129b2b8 f5032e80 00000006 f3b2fc00 c031fdb0 c027de7b f3b2fc00 
f3b2fc00
        f5032e80 0000000b f3b2fc00 b7773884 00000000 00000005 00000002 
f3b2fc00
        f3b2fc00 f5a26034 c031fdd4 c027e1b2 f3b2fc00 00000564 00000001 
f5a26034
Call Trace:
  [<c0102e5f>] show_stack+0x7f/0xa0
  [<c0103002>] show_registers+0x152/0x1c0
  [<c01031f8>] die+0xc8/0x140
  [<c0103325>] do_trap+0xb5/0xc0
  [<c010366c>] do_invalid_op+0xbc/0xd0
  [<c0102aa3>] error_code+0x4f/0x54
  [<c027de7b>] tcp_write_xmit+0xfb/0x400
  [<c027e1b2>] __tcp_push_pending_frames+0x32/0xd0
  [<c027b1cc>] tcp_rcv_established+0x27c/0x860 (was 
tcp_rcv_state_process before).
  [<c0283f8a>] tcp_v4_do_rcv+0x11a/0x120
  [<c0284502>] tcp_v4_rcv+0x572/0x750
  [<c026a62b>] ip_local_deliver+0xcb/0x1d0
  [<c026aa52>] ip_rcv+0x322/0x4a0
  [<c0256a97>] netif_receive_skb+0x137/0x1a0
  [<c0256b8f>] process_backlog+0x8f/0x110
  [<c0256c82>] net_rx_action+0x72/0x100
  [<c01172dc>] __do_softirq+0x8c/0xa0
  [<c011731a>] do_softirq+0x2a/0x30
  [<c01173d5>] irq_exit+0x35/0x40
  [<c01044fc>] do_IRQ+0x3c/0x70
  [<c0102a46>] common_interrupt+0x1a/0x20
  [<c0100997>] cpu_idle+0x57/0x60
  [<c010024b>] _stext+0x2b/0x30
  [<c0320847>] start_kernel+0x147/0x170
  [<c0100199>] 0xc0100199
Code: 89 f8 0f af c2 3b 45 f0 0f 47 45 f0 31 d2 89 45 f0 f7 f3 31 d2 39 
c1 73 ce ba 01 00 00 00 eb c7 6b c2 03 31 d239 c1 77 be eb ee <0f> 0b 96 
03 ce 54 2d c0 e9 76 ff ff ff 8b ba 78 02 00 00 eb eb
  <0>Kernel panic - not syncing: Fatal exception in interrupt

I guess it's the same bug :)

Just a few more infos about the problem :
- Turning off TSO with ethtool solves the problem.
- I tried 2.6.13-rc4 on another server (with the same configuration) and 
the bug occured too (so i guess it's not due to some weird memory 
problem :) )
- The problem dont seems to be present in 2.6.12.3 (but i only tried 
2.6.12.3 during 2 days).


Best Regards,

Guillaume Pelat
