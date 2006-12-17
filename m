Return-Path: <linux-kernel-owner+w=401wt.eu-S1752752AbWLQO5S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbWLQO5S (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 09:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbWLQO5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 09:57:18 -0500
Received: from yumi.tdiedrich.de ([85.10.210.183]:3964 "EHLO yumi.tdiedrich.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbWLQO5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 09:57:17 -0500
Date: Sun, 17 Dec 2006 15:57:14 +0100
From: Tobias Diedrich <ranma@tdiedrich.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Tobias Diedrich <ranma+kernel@tdiedrich.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: IO-APIC + timer doesn't work (was: Linux 2.6.20-rc1)
Message-ID: <20061217145714.GA2987@melchior.yamamaya.is-a-geek.org>
Mail-Followup-To: Tobias Diedrich <ranma@tdiedrich.de>,
	Linus Torvalds <torvalds@osdl.org>,
	Tobias Diedrich <ranma+kernel@tdiedrich.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andi Kleen <ak@suse.de>, Yinghai Lu <yinghai.lu@amd.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <20061216174536.GA2753@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612160955370.3557@woody.osdl.org> <20061216225338.GA2616@melchior.yamamaya.is-a-geek.org> <20061216230605.GA2789@melchior.yamamaya.is-a-geek.org> <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612161518080.3479@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Your dmesg is kind of interesting:
> 
> ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 enabled(7)APIC error on CPU0: 04(40)
>  .. failed
> 
> where that APIC error on CPU0 seems to be a "Send accept error" and "Send 
> illegal vector" thing. I think we actually got the interrupt there, but 
> because we had some APIC setup bug, we didn't accept it properly, and it 
> resulted in that "APIC error" thing. Maybe. 

I just tried changing the code so the "8259 IRQ0 enabled" case is
tested first and with that it boots fine.


Index: linux-2.6.20-rc1/arch/x86_64/kernel/io_apic.c
===================================================================
--- linux-2.6.20-rc1.orig/arch/x86_64/kernel/io_apic.c	2006-12-17 00:45:57.000000000 +0100
+++ linux-2.6.20-rc1/arch/x86_64/kernel/io_apic.c	2006-12-17 15:39:40.000000000 +0100
@@ -1615,6 +1615,7 @@
 	 */
 	apic_write(APIC_LVT0, APIC_LVT_MASKED | APIC_DM_EXTINT);
 	init_8259A(1);
+	enable_8259A_irq(0);
 
 	pin1  = find_isa_irq_pin(0, mp_INT);
 	apic1 = find_isa_irq_apic(0, mp_INT);



[    0.000000] Linux version 2.6.20-rc1-amd64 (ranma@melchior) (gcc version 4.1.2 20061028 (prerelease) (Debian 4.1.1-19)) #28 Sun Dec 17 15:40:22 CET 2006
[    0.000000] Command line: root=/dev/sda5 resume=/dev/sda6 vga=6 apic=verbose apic=verbose ro netconsole=@192.168.8.241/,514@255.255.255.255/
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
[    0.000000]  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000003fee0000 (usable)
[    0.000000]  BIOS-e820: 000000003fee0000 - 000000003fee3000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000003fee3000 - 000000003fef0000 (ACPI data)
[    0.000000]  BIOS-e820: 000000003fef0000 - 000000003ff00000 (reserved)
[    0.000000]  BIOS-e820: 00000000f0000000 - 00000000f4000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 261856) 1 entries of 256 used
[    0.000000] end_pfn_map = 1048576
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7ce0
[    0.000000] ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee3040
[    0.000000] ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003fee30c0
[    0.000000] ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000003feec2c0
[    0.000000] ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec400
[    0.000000] ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000003feec200
[    0.000000] ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
[    0.000000] Entering add_active_range(0, 0, 159) 0 entries of 256 used
[    0.000000] Entering add_active_range(0, 256, 261856) 1 entries of 256 used
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA             0 ->     4096
[    0.000000]   DMA32        4096 ->  1048576
[    0.000000]   Normal    1048576 ->  1048576
[    0.000000] early_node_map[2] active PFN ranges
[    0.000000]     0:        0 ->      159
[    0.000000]     0:      256 ->   261856
[    0.000000] On node 0 totalpages: 261759
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 1356 pages reserved
[    0.000000]   DMA zone: 2587 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 3524 pages used for memmap
[    0.000000]   DMA32 zone: 254236 pages, LIFO batch:31
[    0.000000]   Normal zone: 0 pages used for memmap
[    0.000000] Nvidia board detected. Ignoring ACPI timer override.
[    0.000000] If you got timer trouble try acpi_use_timer_override
[    0.000000] ACPI: PM-Timer IO Port: 0x1008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] Processor #0 (Bootup-CPU)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] disabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ14 used by override.
[    0.000000] ACPI: IRQ15 used by override.
[    0.000000] Setting APIC routing to flat
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] mapped APIC to ffffffffff5fd000 (        fee00000)
[    0.000000] mapped IOAPIC to ffffffffff5fc000 (00000000fec00000)
[    0.000000] Nosave address range: 000000000009f000 - 00000000000a0000
[    0.000000] Nosave address range: 00000000000a0000 - 00000000000f0000
[    0.000000] Nosave address range: 00000000000f0000 - 0000000000100000
[    0.000000] Allocating PCI resources starting at 40000000 (gap: 3ff00000:b0100000)
[    0.000000] Built 1 zonelists.  Total pages: 256823
[    0.000000] Kernel command line: root=/dev/sda5 resume=/dev/sda6 vga=6 apic=verbose apic=verbose ro netconsole=@192.168.8.241/,514@255.255.255.255/
[    0.000000] netconsole: local port 6665
[    0.000000] netconsole: local IP 192.168.8.241
[    0.000000] netconsole: interface eth0
[    0.000000] netconsole: remote port 514
[    0.000000] netconsole: remote IP 255.255.255.255
[    0.000000] netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
[    0.000000] Initializing CPU#0
[    0.000000] PID hash table entries: 4096 (order: 12, 32768 bytes)
[   27.616056] time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
[   27.616058] time.c: Detected 2009.285 MHz processor.
[   27.621535] Console: colour VGA+ 80x60
[   27.624157] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[   27.624996] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[   27.625240] Checking aperture...
[   27.625347] CPU 0: aperture @ b2c2000000 size 32 MB
[   27.625454] Aperture too small (32 MB)
[   27.630247] No AGP bridge found
[   27.638099] Memory: 1025356k/1047424k available (3261k kernel code, 21436k reserved, 1445k data, 200k init)
[   27.719244] Calibrating delay using timer specific routine.. 4022.22 BogoMIPS (lpj=6701161)
[   27.719489] Mount-cache hash table entries: 256
[   27.719665] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   27.719774] CPU: L2 Cache: 512K (64 bytes/line)
[   27.719899] CPU: AMD Athlon(tm) 64 Processor 3200+ stepping 02
[   27.720052] ACPI: Core revision 20060707
[   27.727794] enabled ExtINT on CPU#0
[   27.727901] ESR value after enabling vector: 00000000, after 00000004
[   27.728238] ENABLING IO-APIC IRQs
[   27.728345] init IO_APIC IRQs
[   27.728417]  IO-APIC (apicid-pin) 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
[   27.728548] ..TIMER: trying IO-APIC=0 PIN=0 with 8259 IRQ0 disabled<6>Using local APIC timer interrupts.
                                                              ^^^^^^^^
                                                              really
                                                              enabled
[   27.811447] result 12558047
[   27.811553] Detected 12.558 MHz APIC timer.

HTH,

-- 
Tobias						PGP: http://9ac7e0bc.uguu.de
This mail is made of 100% recycled bits
