Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUAAWME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUAAWJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:09:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:18661 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265466AbUAAWFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:05:20 -0500
Date: Thu, 1 Jan 2004 14:05:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Henne <metalhen@metalhen.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [2.6.0] sleeping function called from invalid context at
 include/asm/semaphore.h:119
Message-Id: <20040101140555.33c59532.akpm@osdl.org>
In-Reply-To: <3FF41888.1070005@metalhen.de>
References: <3FF41888.1070005@metalhen.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Henne <metalhen@metalhen.de> wrote:
>
> I tested Kernel 2.6.0 on my Fujitsu-Siemens E7110 notebook. Seemed to 
> work first, but I always get this message when trying to call programs 
> with networking like "ifconfig DEV up", ping IP, dhclient DEV, route.
> I found that messages in this list
>   but never at the non-test-Kernel 2.6.0
> 

Thanks for the report.  ether1394_tx() calls hpsb_guid_get_entry() under
spin_lock_irqsave(), but hpsb_guid_get_entry() does down().

> 
> 15:50:15 mobile kernel: Debug: sleeping function called from invalid 
> context at include/asm/semaphore.h:119
> 
> 15:50:15 mobile kernel: in_atomic():1, irqs_disabled():0
> 15:50:15 mobile kernel: Call Trace:
> 15:50:15 mobile kernel:  [<c011ebae>] __might_sleep+0xab/0xc9
> 15:50:15 mobile kernel:  [<c0299758>] hpsb_guid_get_entry+0x2e/0x63
> 15:50:15 mobile kernel:  [<c02a1916>] ether1394_tx+0x110/0x70d
> 15:50:15 mobile kernel:  [<c02a84c3>] accel_clear+0x73/0x7b
> 15:50:15 mobile kernel:  [<c010ff05>] do_gettimeofday+0x29/0xbd
> 15:50:15 mobile kernel:  [<c032e6b1>] dev_queue_xmit_nit+0x1d/0x117
> 15:50:15 mobile kernel:  [<c033aa1b>] qdisc_restart+0x67/0x12a
> 15:50:15 mobile kernel:  [<c032eb65>] dev_queue_xmit+0x1fb/0x2a8
> 15:50:15 mobile kernel:  [<c038c5fe>] packet_sendmsg_spkt+0x188/0x1fc
> 15:50:15 mobile kernel:  [<c0326dcf>] sock_sendmsg+0x92/0xaf
> 15:50:15 mobile kernel:  [<c0326873>] move_addr_to_kernel+0x7e/0xa7
> 15:50:15 mobile kernel:  [<c032829d>] sys_sendto+0xe8/0x107
> 15:50:15 mobile kernel:  [<c011ec12>] free_task+0x28/0x2f
> 15:50:15 mobile kernel:  [<c011bc44>] do_page_fault+0x35c/0x582
> 15:50:15 mobile kernel:  [<c023c720>] tty_write+0x183/0x284
> 15:50:15 mobile kernel:  [<c02412ff>] write_chan+0x0/0x218
> 15:50:15 mobile kernel:  [<c023c59d>] tty_write+0x0/0x284
> 15:50:15 mobile kernel:  [<c0328c99>] sys_socketcall+0x1b3/0x28e
> 15:50:15 mobile kernel:  [<c010a223>] syscall_call+0x7/0xb
> 15:50:15 mobile kernel:
> 
> 
> and
> 
> 
> 15:51:43 mobile kernel: Debug: sleeping function called from invalid 
> context at include/asm/semaphore.h:119
> 
> 15:51:43 mobile kernel: in_atomic():1, irqs_disabled():0
> 15:51:43 mobile kernel: Call Trace:
> 15:51:43 mobile kernel:  [<c011ebae>] __might_sleep+0xab/0xc9
> 15:51:43 mobile kernel:  [<c0299758>] hpsb_guid_get_entry+0x2e/0x63
> 15:51:43 mobile kernel:  [<c02a1916>] ether1394_tx+0x110/0x70d
> 15:51:43 mobile kernel:  [<c0372f9c>] fn_hash_lookup+0xd6/0x102
> 15:51:43 mobile kernel:  [<c033aa1b>] qdisc_restart+0x67/0x12a
> 15:51:43 mobile kernel:  [<c032eb65>] dev_queue_xmit+0x1fb/0x2a8
> 15:51:43 mobile kernel:  [<c036674e>] arp_send+0x1d9/0x294
> 15:51:43 mobile kernel:  [<c03661ac>] arp_solicit+0xaa/0x11a
> 15:51:43 mobile kernel:  [<c0335326>] __neigh_event_send+0xe0/0x1d3
> 15:51:43 mobile kernel:  [<c0335baa>] neigh_resolve_output+0x1bf/0x1ee
> 15:51:43 mobile kernel:  [<c0377e82>] ip_refrag+0x3b/0x87
> 15:51:43 mobile kernel:  [<c0346e6d>] ip_finish_output2+0x0/0x1b3
> 15:51:43 mobile kernel:  [<c0346f5f>] ip_finish_output2+0xf2/0x1b3
> 15:51:43 mobile kernel:  [<c0338e45>] nf_hook_slow+0xee/0x139
> 15:51:43 mobile kernel:  [<c0346e6d>] ip_finish_output2+0x0/0x1b3
> 15:51:43 mobile kernel:  [<c0344c2c>] ip_finish_output+0x206/0x20b
> 15:51:43 mobile kernel:  [<c0346e6d>] ip_finish_output2+0x0/0x1b3
> 15:51:43 mobile kernel:  [<c0346e55>] dst_output+0x15/0x2d
> 15:51:43 mobile kernel:  [<c0338e45>] nf_hook_slow+0xee/0x139
> 15:51:43 mobile kernel:  [<c0346e40>] dst_output+0x0/0x2d
> 15:51:43 mobile kernel:  [<c0346990>] ip_push_pending_frames+0x398/0x3f6
> 15:51:43 mobile kernel:  [<c0346e40>] dst_output+0x0/0x2d
> 15:51:43 mobile kernel:  [<c03636c1>] udp_push_pending_frames+0x130/0x23c
> 15:51:43 mobile kernel:  [<c0363c76>] udp_sendmsg+0x474/0x9c2
> 15:51:43 mobile kernel:  [<c0340089>] ip_route_output_slow+0x401/0x7eb
> 15:51:43 mobile kernel:  [<c036c2c9>] inet_sendmsg+0x4b/0x56
> 15:51:43 mobile kernel:  [<c0326dcf>] sock_sendmsg+0x92/0xaf
> 15:51:43 mobile kernel:  [<c03405df>] ip_route_output_flow+0x2a/0x63
> 15:51:43 mobile kernel:  [<c0326b92>] sockfd_lookup+0x1a/0x72
> 15:51:43 mobile kernel:  [<c032829d>] sys_sendto+0xe8/0x107
> 15:51:43 mobile kernel:  [<c032805e>] sys_connect+0x86/0x99
> 15:51:43 mobile kernel:  [<c011bc44>] do_page_fault+0x35c/0x582
> 15:51:43 mobile kernel:  [<c03282f2>] sys_send+0x36/0x3a
> 15:51:43 mobile kernel:  [<c0328c4d>] sys_socketcall+0x167/0x28e
> 15:51:43 mobile kernel:  [<c014a773>] sys_munmap+0x57/0x75
> 15:51:43 mobile kernel:  [<c010a223>] syscall_call+0x7/0xb
> 
> 
> or
> 
> 
> 15:52:10 mobile kernel: Debug: sleeping function called from invalid 
> context at include/asm/semaphore.h:119
> 
> 15:52:10 mobile kernel: in_atomic():1, irqs_disabled():0
> 15:52:10 mobile kernel: Call Trace:
> 15:52:10 mobile kernel:  [<c011ebae>] __might_sleep+0xab/0xc9
> 15:52:10 mobile kernel:  [<c0299758>] hpsb_guid_get_entry+0x2e/0x63
> 15:52:10 mobile kernel:  [<c02a1916>] ether1394_tx+0x110/0x70d
> 15:52:10 mobile kernel:  [<c0341b97>] ip_local_deliver+0x22d/0x24b
> 15:52:10 mobile kernel:  [<c0372f9c>] fn_hash_lookup+0xd6/0x102
> 15:52:10 mobile kernel:  [<c033aa1b>] qdisc_restart+0x67/0x12a
> 15:52:10 mobile kernel:  [<c032eb65>] dev_queue_xmit+0x1fb/0x2a8
> 15:52:10 mobile kernel:  [<c036674e>] arp_send+0x1d9/0x294
> 15:52:10 mobile kernel:  [<c03661ac>] arp_solicit+0xaa/0x11a
> 15:52:10 mobile kernel:  [<c03351e7>] neigh_timer_handler+0x1ed/0x24c
> 15:52:10 mobile kernel:  [<c0334ffa>] neigh_timer_handler+0x0/0x24c
> 15:52:10 mobile kernel:  [<c0128e31>] run_timer_softirq+0xcb/0x1ab
> 15:52:10 mobile kernel:  [<c0124bb8>] do_softirq+0x98/0x9a
> 15:52:10 mobile kernel:  [<c010c5ff>] do_IRQ+0x10f/0x144
> 15:52:10 mobile kernel:  [<c010ab90>] common_interrupt+0x18/0x20
> 15:52:10 mobile kernel:  [<c0231c1c>] acpi_processor_idle+0x13e/0x1e5
> 15:52:10 mobile kernel:  [<c0105000>] rest_init+0x0/0x60
> 15:52:10 mobile kernel:  [<c0105000>] rest_init+0x0/0x60
> 15:52:10 mobile kernel:  [<c01080b7>] cpu_idle+0x2f/0x38
> 15:52:10 mobile kernel:  [<c04a06f8>] start_kernel+0x183/0x1af
> 15:52:10 mobile kernel:  [<c04a044a>] unknown_bootoption+0x0/0xf8
> 
> 
> an second thing I wanted to report, is that when I do a reboot with the 
> new kernel at my notebook systems hangs at boottime between memory-check 
> and Harddisk-Check of Bios. I only gotthis with 2.6.0
> 
> Is there some solution or thing I did not see?
> If you want more information about my system, tell me what you want/need.
> 
> 
> 
> 
> lspci:
> 
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
> Bridge (rev 04)
> 	Subsystem: Fujitsu Limited.: Unknown device 1176
> 	Flags: bus master, fast devsel, latency 0
> 	Memory at ec000000 (32-bit, prefetchable) [size=64M]
> 	Capabilities: [e4] #09 [d104]
> 	Capabilities: [a0] AGP version 2.0
> 
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
> (rev 04) (prog-if 00 [Normal decode])
> 	Flags: bus master, 66Mhz, fast devsel, latency 96
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
> 	I/O behind bridge: 00002000-00002fff
> 	Memory behind bridge: e8100000-e81fffff
> 	Prefetchable memory behind bridge: f0000000-f7ffffff
> 
> 00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) 
> (prog-if 00 [UHCI])
> 	Subsystem: Fujitsu Limited.: Unknown device 113d
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	I/O ports at 18c0 [size=32]
> 
> 00:1d.2 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #3) (rev 02) 
> (prog-if 00 [UHCI])
> 	Subsystem: Fujitsu Limited.: Unknown device 113d
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	I/O ports at 18e0 [size=32]
> 
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) 
> (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=02, subordinate=04, sec-latency=64
> 	I/O behind bridge: 00003000-00003fff
> 	Memory behind bridge: e8200000-e82fffff
> 	Prefetchable memory behind bridge: f8000000-f80fffff
> 
> 00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
> 	Flags: bus master, medium devsel, latency 0
> 
> 00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 
> 8a [Master SecP PriP])
> 	Subsystem: Fujitsu Limited.: Unknown device 113d
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	I/O ports at <ignored>
> 	I/O ports at <ignored>
> 	I/O ports at <ignored>
> 	I/O ports at <ignored>
> 	I/O ports at 1c20 [size=16]
> 	Memory at e8000000 (32-bit, non-prefetchable) [size=1K]
> 
> 00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus Controller (rev 02)
> 	Subsystem: Fujitsu Limited.: Unknown device 113d
> 	Flags: medium devsel, IRQ 11
> 	I/O ports at 1c00 [size=32]
> 
> 00:1f.5 Multimedia audio controller: Intel Corp. 82801CA/CAM AC'97 Audio 
> Controller (rev 02)
> 	Subsystem: Fujitsu Limited.: Unknown device 1177
> 	Flags: bus master, medium devsel, latency 0, IRQ 11
> 	I/O ports at 1000 [size=256]
> 	I/O ports at 1880 [size=64]
> 
> 00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem Controller (rev 02) 
> (prog-if 00 [Generic])
> 	Subsystem: Fujitsu Limited.: Unknown device 10d1
> 	Flags: medium devsel, IRQ 11
> 	I/O ports at 1400 [size=256]
> 	I/O ports at 1800 [size=128]
> 
> 01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility 
> M7 LW [Radeon Mobility 7500] (prog-if 00 [VGA])
> 	Subsystem: Fujitsu Limited.: Unknown device 117b
> 	Flags: stepping, fast Back2Back, 66Mhz, medium devsel, IRQ 11
> 	Memory at f0000000 (32-bit, prefetchable) [size=128M]
> 	I/O ports at 2000 [size=256]
> 	Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
> 	Expansion ROM at <unassigned> [disabled] [size=128K]
> 	Capabilities: [58] AGP version 2.0
> 	Capabilities: [50] Power Management version 2
> 
> 02:0a.0 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 02)
> 	Subsystem: Fujitsu Limited.: Unknown device 10e6
> 	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
> 	Memory at 10000000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
> 	Memory window 0: 10400000-107ff000 (prefetchable)
> 	Memory window 1: 10800000-10bff000
> 	I/O window 0: 00004000-000040ff
> 	I/O window 1: 00004400-000044ff
> 	16-bit legacy interface ports at 0001
> 
> 02:0a.1 CardBus bridge: O2 Micro, Inc. OZ6933 Cardbus Controller (rev 02)
> 	Subsystem: Fujitsu Limited.: Unknown device 10e6
> 	Flags: bus master, stepping, slow devsel, latency 168, IRQ 11
> 	Memory at 10001000 (32-bit, non-prefetchable) [size=4K]
> 	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
> 	Memory window 0: 10c00000-10fff000 (prefetchable)
> 	Memory window 1: 11000000-113ff000
> 	I/O window 0: 00004800-000048ff
> 	I/O window 1: 00004c00-00004cff
> 	16-bit legacy interface ports at 0001
> 
> 02:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
> RTL-8139/8139C/8139C+ (rev 10)
> 	Subsystem: Fujitsu Limited.: Unknown device 111c
> 	Flags: bus master, medium devsel, latency 64, IRQ 11
> 	I/O ports at 3000 [size=256]
> 	Memory at e8204800 (32-bit, non-prefetchable) [size=256]
> 	Capabilities: [50] Power Management version 2
> 
> 02:0d.0 Network controller: Harris Semiconductor Prism 2.5 Wavelan 
> chipset (rev 01)
> 	Subsystem: Fujitsu Limited.: Unknown device 1169
> 	Flags: bus master, medium devsel, latency 64, IRQ 11
> 	Memory at f8000000 (32-bit, prefetchable) [size=4K]
> 	Capabilities: [dc] Power Management version 2
> 
> 02:0e.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 
> IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
> 	Subsystem: Fujitsu Limited.: Unknown device 1162
> 	Flags: bus master, medium devsel, latency 64, IRQ 11
> 	Memory at e8204000 (32-bit, non-prefetchable) [size=2K]
> 	Memory at e8200000 (32-bit, non-prefetchable) [size=16K]
> 	Capabilities: [44] Power Management version 2
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
