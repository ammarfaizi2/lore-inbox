Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVGPTzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGPTzV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 15:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVGPTzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 15:55:21 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:26810 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261393AbVGPTzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 15:55:18 -0400
Message-ID: <42D9658B.7020907@gentoo.org>
Date: Sat, 16 Jul 2005 20:52:43 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.5 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>, Ayaz Abdulla <AAbdulla@nvidia.com>
Subject: Re: [PATCH] forcedeth: TX handler changes (experimental)
References: <42D913D6.5050902@colorfullife.com>
In-Reply-To: <42D913D6.5050902@colorfullife.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Manfred Spraul wrote:
> Attached is a patch that modifies the tx interrupt handling of the 
> nForce nic. It's part of the attempts to figure out what causes the nic 
> hangs (see bug 4552).
> The change is experimental: It affects all nForce versions. I've tested 
> it on my nForce 250-Gb.
> 
> Please test it. And especially: If you experince a nic hang, please send 
> me the debug output. That's the block starting with
> 
> <<
> NETDEV WATCHDOG: eth1: transmit timed out
> eth1: Got tx_timeout. irq: 00000000
> eth1: Ring at  ...
> <<

After applying the v0.38 patch, I can't get any network at all. DHCP fails to 
get an IP. v0.37 works fine.

I enabled debugging, and I get this failure for every packet being 
transmitted: ( i masked out part of my MAC addr with XX )

Jul 16 20:06:28 dsd eth0: nv_start_xmit: packet packet 3 queued for transmission.
Jul 16 20:06:28 dsd
Jul 16 20:06:28 dsd 000: ff ff ff ff ff ff 00 50 8d XX XX XX 08 00 45 00
Jul 16 20:06:28 dsd 010: 02 40 75 a0 00 00 40 11 03 0e 00 00 00 00 ff ff
Jul 16 20:06:28 dsd 020: ff ff 00 44 00 43 02 2c 13 0a 01 01 06 00 d2 76
Jul 16 20:06:28 dsd 030: bc 10 00 0a 00 00 00 00 00 00 00 00 00 00 00 00
Jul 16 20:06:28 dsd eth0: nv_nic_irq
Jul 16 20:06:28 dsd eth0: irq: 00000008
Jul 16 20:06:28 dsd eth0: nv_tx_done: looking at packet 3, Flags 0x6000024d.
Jul 16 20:06:28 dsd eth0: received irq with events 0x8. Probably TX fail.
Jul 16 20:06:28 dsd eth0: irq: 00000000
Jul 16 20:06:28 dsd eth0: nv_nic_irq completed

My hardware:

0000:00:04.0 Class 0200: 10de:0066 (rev a1)

0000:00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
         Subsystem: ABIT Computer Corp.: Unknown device 1c00
         Flags: bus master, 66Mhz, fast devsel, latency 0, IRQ 17
         Memory at e0087000 (32-bit, non-prefetchable) [size=4K]
         I/O ports at b000 [size=8]
         Capabilities: [44] Power Management version 2

Here's the start of the logs:


Jul 16 20:05:27 dsd forcedeth.c: Reverse Engineered nForce ethernet driver. 
Version 0.38.
Jul 16 20:05:27 dsd ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [APCH] -> GSI 
21 (level, high) -> IRQ 17
Jul 16 20:05:27 dsd PCI: Setting latency timer of device 0000:00:04.0 to 64
Jul 16 20:05:27 dsd 0000:00:04.0: resource 0 start e0087000 len 4096 flags 
0x00000200.
Jul 16 20:05:27 dsd 0000:00:04.0: MAC Address 00:50:8d:XX:XX:XX
Jul 16 20:05:27 dsd 0000:00:04.0: link timer on.
Jul 16 20:05:27 dsd eth%d: mii_rw read from reg 2 at PHY 1: 0x0.
Jul 16 20:05:27 dsd eth%d: mii_rw read from reg 3 at PHY 1: 0x8201.
Jul 16 20:05:27 dsd 0000:00:04.0: open: Found PHY 0000:0020 at address 1.
Jul 16 20:05:27 dsd eth%d: mii_rw read from reg 4 at PHY 1: 0x1e1.
Jul 16 20:05:27 dsd eth%d: mii_rw wrote 0xde1 to reg 4 at PHY 1
Jul 16 20:05:27 dsd eth%d: mii_rw read from reg 1 at PHY 1: 0x786d.
Jul 16 20:05:27 dsd eth%d: mii_rw read from reg 0 at PHY 1: 0x3100.
Jul 16 20:05:27 dsd eth%d: mii_rw wrote 0xb100 to reg 0 at PHY 1
Jul 16 20:05:28 dsd eth%d: mii_rw read from reg 0 at PHY 1: 0x3000.
Jul 16 20:05:28 dsd eth%d: mii_rw read from reg 0 at PHY 1: 0x3000.
Jul 16 20:05:28 dsd eth%d: mii_rw wrote 0x3200 to reg 0 at PHY 1
Jul 16 20:05:28 dsd eth0: forcedeth.c: subsystem: 0147b:1c00 bound to 0000:00:04.0
Jul 16 20:05:28 dsd rc-scripts: Configuration not set for eth0 - assuming dhcp
Jul 16 20:05:28 dsd nv_open: begin
Jul 16 20:05:28 dsd eth0: nv_alloc_rx: Packet 0 marked as Available
Jul 16 20:05:28 dsd eth0: nv_alloc_rx: Packet 1 marked as Available
Jul 16 20:05:28 dsd eth0: nv_alloc_rx: Packet 2 marked as Available

<snip>

Jul 16 20:05:28 dsd eth0: nv_alloc_rx: Packet 125 marked as Available
Jul 16 20:05:28 dsd eth0: nv_alloc_rx: Packet 126 marked as Available
Jul 16 20:05:28 dsd eth0: nv_alloc_rx: Packet 127 marked as Available
Jul 16 20:05:28 dsd eth0: nv_txrx_reset
Jul 16 20:05:28 dsd startup: got 0x00000010.
Jul 16 20:05:28 dsd eth0: mii_rw read from reg 1 at PHY 1: 0x7849.
Jul 16 20:05:28 dsd eth0: mii_rw read from reg 1 at PHY 1: 0x7849.
Jul 16 20:05:28 dsd eth0: no link detected by phy - falling back to 10HD.
Jul 16 20:05:28 dsd eth0: nv_start_rx
Jul 16 20:05:28 dsd eth0: nv_start_rx to duplex 0, speed 0x000103e8.
Jul 16 20:05:28 dsd eth0: nv_start_tx
Jul 16 20:05:28 dsd eth0: no link during initialization.
Jul 16 20:05:28 dsd eth0: nv_stop_rx
Jul 16 20:05:28 dsd eth0: reconfiguration for multicast lists.
Jul 16 20:05:28 dsd eth0: nv_start_rx
Jul 16 20:05:28 dsd eth0: nv_start_rx to duplex 0, speed 0x000103e8.
Jul 16 20:05:28 dsd eth0: nv_stop_rx
Jul 16 20:05:28 dsd eth0: reconfiguration for multicast lists.
Jul 16 20:05:28 dsd eth0: nv_start_rx
Jul 16 20:05:28 dsd eth0: nv_start_rx to duplex 0, speed 0x000103e8.
Jul 16 20:05:28 dsd eth0: nv_stop_rx
Jul 16 20:05:28 dsd eth0: reconfiguration for multicast lists.
Jul 16 20:05:28 dsd eth0: nv_start_rx
Jul 16 20:05:28 dsd eth0: nv_start_rx to duplex 0, speed 0x000103e8.

Let me know if full logs would be useful (they are big, and it just shows a 
lot of interrupts, some packets being queued up, and 5 or so TX failures like 
the ones above).

Daniel
