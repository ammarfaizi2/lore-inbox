Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267953AbTBRRqa>; Tue, 18 Feb 2003 12:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267952AbTBRRq3>; Tue, 18 Feb 2003 12:46:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3851 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267953AbTBRRq1>; Tue, 18 Feb 2003 12:46:27 -0500
Date: Tue, 18 Feb 2003 17:56:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: IP/ICMP networking oddity
Message-ID: <20030218175626.A9785@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing the following weird behaviour in the IP layer.  While
pinging a 2.5.62 machine with: "ping -s 16000 -f", I get a number
of:

eth0: Far too big packet error.

errors (from the smc9194.c driver.)  This message is displayed when
the transmit path encounters a packet which is too large for it to
send.  Displaying the size of these over-sized packets (skb->len),
it turns out ot be 16042 bytes, despite ifconfig reporting a MTU
of 1500 bytes for the interface.  I added a BUG() in the complaint
path and got the backtrace below.

In addition, I don't see the outgoing ICMP echo replies in tcpdump,
although I do see incoming ICMP echo requests, along with TCP, ARP
and UDP traffic in both directions.  Also, the ethernet interface
has RX, TX, link and CPU access activity indicators - despite the
RX and CPU activity LEDs being permanently lit during the flood
ping, but the TX LED is mostly off.

It seems that ICMP echo replies are somehow missing the IP
fragmentation process (despite it appearing in the backtrace.)

Please note that while this flood ping is in effect, NFS appears to
be happy on 2.5.62 accessing other machines on the network with very
little latency.

[<c031d6f4>] (smc_wait_to_send_packet+0x0/0x32c)
			from [<c035b434>] (qdisc_restart+0x9c/0x198)
[<c035b398>] (qdisc_restart+0x0/0x198)
			from [<c035296c>] (dev_queue_xmit+0x108/0x3d4)
[<c0352864>] (dev_queue_xmit+0x0/0x3d4)
			from [<c0369328>] (ip_finish_output+0x210/0x294)
[<c0369118>] (ip_finish_output+0x0/0x294)
			from [<c0367b18>] (ip_fragment+0x76c/0x870)
[<c03673ac>] (ip_fragment+0x0/0x870)
			from [<c0366b94>] (ip_output+0x78/0x300)
[<c0366b1c>] (ip_output+0x0/0x300)
			from [<c0368c34>] (ip_push_pending_frames+0x36c/0x458)
[<c03688c8>] (ip_push_pending_frames+0x0/0x458)
			from [<c038dee8>] (icmp_push_reply+0xec/0xf8)
[<c038ddfc>] (icmp_push_reply+0x0/0xf8)
			from [<c038e074>] (icmp_reply+0x180/0x1e4)
[<c038def4>] (icmp_reply+0x0/0x1e4)
			from [<c038e988>] (icmp_echo+0x5c/0x64)
[<c038e92c>] (icmp_echo+0x0/0x64)
			from [<c038ee58>] (icmp_rcv+0x17c/0x1e0)
[<c038ecdc>] (icmp_rcv+0x0/0x1e0)
			from [<c0363a7c>] (ip_local_deliver+0x154/0x260)
[<c0363928>] (ip_local_deliver+0x0/0x260)
			from [<c0363fe8>] (ip_rcv+0x460/0x504)
[<c0363b88>] (ip_rcv+0x0/0x504)
			from [<c0353288>] (netif_receive_skb+0x1c0/0x210)
[<c03530c8>] (netif_receive_skb+0x0/0x210)
			from [<c035337c>] (process_backlog+0xa4/0x17c)
[<c03532d8>] (process_backlog+0x0/0x17c)
			from [<c03534ec>] (net_rx_action+0x98/0x1b0)
[<c0353454>] (net_rx_action+0x0/0x1b0)
			from [<c02453cc>] (do_softirq+0x84/0xec)
[<c0245348>] (do_softirq+0x0/0xec)
			from [<c02222e8>] (__do_softirq+0x8/0x20)
[<c02231b0>] (asm_do_IRQ+0x0/0xd8)
			from [<c0221eb4>] (__irq_svc+0x34/0xac)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

