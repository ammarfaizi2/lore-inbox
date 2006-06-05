Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932416AbWFEFX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWFEFX1 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 01:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbWFEFX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 01:23:27 -0400
Received: from wx-out-0102.google.com ([66.249.82.206]:13574 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932416AbWFEFXZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 01:23:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=RvAVZLRp0l/qfFDxC4o/Ty5WdiHpACICW28VX8aD+fEMWoMyLWMvl48607ckqBZPRdO3SfIv7hAhIjDk4yglJ6gd4LsJWfjwnql/JrDOxmleAbadgIWjyZERNXG9cdOdP500MXtG53Ck7rdB/qHXodNgCKQ7UiFGGqHESRiKX8E=
Message-ID: <986ed62e0606042223l2381d877g4bc798ec64804d43@mail.gmail.com>
Date: Sun, 4 Jun 2006 22:23:24 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
        "Arjan van de Ven" <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: 2.6.17-rc5-mm3: "BUG: scheduling while atomic" flood when resuming from disk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
X-Google-Sender-Auth: d09bfd489f535f97
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting myself from another recent e-mail:

> BTW, I also tried 2.6.17-rc5-mm3 (with no other patches) on another
> box of mine, running Ubuntu Dapper Drake. (It was installed with one
> of the flights but has been updated to the final release.) It got hit
> with a flood of scheduling-while-atomic BUGs when either suspending to
> disk or resuming, and eth0 didn't come back up automatically as usual
> -- I had to manually modprobe r8169 and then run
> "/etc/init.d/networking restart" to get to the outside world again. I
> might not be able to provide a more detailed report on this box for
> another day or two.

The messages definitely happen while resuming. My screen is blank
during suspend-to-disk so I have no way to know what's going on
then...

I forgot to mention, the box also usually switches back to the X VC
after it resumes, but with this kernel it just stays on a text console
(with the top line line displaying a "scheduling while atomic" message
-- the screen floods with them at one point, but then gets cleared
before resume finishes). Once I manually switch back to X, modprobe
r8169, and run /etc/init.d/networking restart, I think I also have to
reset the master volume on the sound card (but I'm not 100% certain).
After I do all that, everything seems to work properly.

I've reproduced this on straight 2.6.17-rc5-mm3 as well as with the
latest lockdep combo & tracer patches. It's 100% reproducible on the
first suspend after a fresh boot. /proc/latency_trace is empty after
resume. The .config I used for -mm3 is the same one I posted in the
following message, except with the sisusbvga module disabled:
http://marc.theaimsgroup.com/?l=linux-kernel&m=114948250602350&w=2

The .config I used for -mm3-lockdep + tracer is the same, except I
accepted default answers for all the new questions asked by make
oldconfig.

I've only tried suspending a second time once, and on the resume from
the second suspend, there were no messages and eth0 came back up
automatically as it should.

The dmesg output from -mm3-lockdep + tracer follows. Please let me
know what other information to provide, and whether to collect it
before or after resume (or both).
-- 
-Barry K. Nathan <barryn@pobox.com>

[    0.000000] Linux version 2.6.17-rc5-mm3-lockdep (barryn@ubuntu)
(gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #3 PREEMPT Sun Jun 4
19:00:51 PDT 2006
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] sanitize start
[    0.000000] sanitize end
[    0.000000] copy_e820_map() start: 0000000000000000 size:
000000000009fc00 end: 000000000009fc00 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000000000, 000000000009fc00, 1)
[    0.000000] copy_e820_map() start: 000000000009fc00 size:
0000000000000400 end: 00000000000a0000 type: 2
[    0.000000] add_memory_region(000000000009fc00, 0000000000000400, 2)
[    0.000000] copy_e820_map() start: 00000000000f0000 size:
0000000000010000 end: 0000000000100000 type: 2
[    0.000000] add_memory_region(00000000000f0000, 0000000000010000, 2)
[    0.000000] copy_e820_map() start: 0000000000100000 size:
000000001fef0000 end: 000000001fff0000 type: 1
[    0.000000] copy_e820_map() type is E820_RAM
[    0.000000] add_memory_region(0000000000100000, 000000001fef0000, 1)
[    0.000000] copy_e820_map() start: 000000001fff0000 size:
0000000000008000 end: 000000001fff8000 type: 3
[    0.000000] add_memory_region(000000001fff0000, 0000000000008000, 3)
[    0.000000] copy_e820_map() start: 000000001fff8000 size:
0000000000008000 end: 0000000020000000 type: 4
[    0.000000] add_memory_region(000000001fff8000, 0000000000008000, 4)
[    0.000000] copy_e820_map() start: 00000000fec00000 size:
0000000000001000 end: 00000000fec01000 type: 2
[    0.000000] add_memory_region(00000000fec00000, 0000000000001000, 2)
[    0.000000] copy_e820_map() start: 00000000fee00000 size:
0000000000001000 end: 00000000fee01000 type: 2
[    0.000000] add_memory_region(00000000fee00000, 0000000000001000, 2)
[    0.000000] copy_e820_map() start: 00000000fff80000 size:
0000000000080000 end: 0000000100000000 type: 2
[    0.000000] add_memory_region(00000000fff80000, 0000000000080000, 2)
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000] found SMP MP-table at 000fba70
[    0.000000] On node 0 totalpages: 131056
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 126960 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 AMI
) @ 0x000fa0c0
[    0.000000] ACPI: RSDT (v001 AMIINT VIA_K8   0x00000010 MSFT
0x00000097) @ 0x1fff0000
[    0.000000] ACPI: FADT (v001 AMIINT VIA_K8   0x00000011 MSFT
0x00000097) @ 0x1fff0030
[    0.000000] ACPI: MADT (v001 AMIINT VIA_K8   0x00000009 MSFT
0x00000097) @ 0x1fff00c0
[    0.000000] ACPI: DSDT (v001    VIA   VIA_K8 0x00001000 MSFT
0x0100000d) @ 0x00000000
[    0.000000] ACPI: PM-Timer IO Port: 0x808
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
[    0.000000] Processor #0 15:12 APIC version 16
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] Allocating PCI resources starting at 30000000 (gap:
20000000:dec00000)
[    0.000000] Detected 1800.231 MHz processor.
[   24.138083] Built 1 zonelists
[   24.138094] Kernel command line: root=/dev/sda1 ro quiet elevator=cfq
[   24.139549] mapped APIC to ffffd000 (fee00000)
[   24.139565] mapped IOAPIC to ffffc000 (fec00000)
[   24.139581] Enabling fast FPU save and restore... done.
[   24.139599] Enabling unmasked SIMD FPU exception support... done.
[   24.139620] Initializing CPU#0
[   24.139813] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   24.141507] Console: colour VGA+ 80x25
[   24.141618] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[   24.141636] ... MAX_LOCKDEP_SUBTYPES:    8
[   24.141649] ... MAX_LOCK_DEPTH:          30
[   24.141662] ... MAX_LOCKDEP_KEYS:        2048
[   24.141675] ... TYPEHASH_SIZE:           1024
[   24.141688] ... MAX_LOCKDEP_ENTRIES:     8192
[   24.141701] ... MAX_LOCKDEP_CHAINS:      8192
[   24.141714] ... CHAINHASH_SIZE:          4096
[   24.141727]  memory used by lock dependency info: 696 kB
[   24.141742]  per task-struct memory footprint: 1080 bytes
[   24.141756] starting custom tracer.
[   24.141770] ------------------------
[   24.141782] | Locking API testsuite:
[   24.141794] ----------------------------------------------------------------------------
[   24.141846]                                  | spin |wlock |rlock
|mutex | wsem | rsem |
[   24.141865]
--------------------------------------------------------------------------
[   24.141905]                      A-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.143744]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.145676]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.147679]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.149680]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.151761]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.153871]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.155949]                     double unlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.157769]                  bad unlock order:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   24.159668]
--------------------------------------------------------------------------
[   24.159687]               recursive read-lock:             |  ok  |
            |  ok  |
[   24.160343]
--------------------------------------------------------------------------
[   24.160362]                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
[   24.161632]   ------------------------------------------------------------
[   24.161649]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   24.162589]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   24.163536]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   24.164477]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   24.165422]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   24.166370]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   24.167316]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   24.168258]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   24.169209]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   24.170153]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   24.171102]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   24.172075]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   24.173051]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   24.174022]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   24.174996]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   24.175970]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   24.176946]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   24.177910]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   24.178878]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   24.179832]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   24.180791]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   24.181720]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   24.182691]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   24.183661]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   24.184640]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   24.185607]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   24.186586]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   24.187555]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   24.188533]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   24.189498]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   24.190474]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   24.191440]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   24.192418]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   24.193384]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   24.194347]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   24.195316]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   24.196295]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   24.197262]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   24.198241]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   24.199210]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   24.200188]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   24.201154]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   24.202129]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   24.203097]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   24.204076]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   24.205042]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   24.206018]       hard-irq read-recursion/123:  ok  |
[   24.206342]       soft-irq read-recursion/123:  ok  |
[   24.206669]       hard-irq read-recursion/132:  ok  |
[   24.207027]       soft-irq read-recursion/132:  ok  |
[   24.207354]       hard-irq read-recursion/213:  ok  |
[   24.207678]       soft-irq read-recursion/213:  ok  |
[   24.208040]       hard-irq read-recursion/231:  ok  |
[   24.208364]       soft-irq read-recursion/231:  ok  |
[   24.208691]       hard-irq read-recursion/312:  ok  |
[   24.209049]       soft-irq read-recursion/312:  ok  |
[   24.209377]       hard-irq read-recursion/321:  ok  |
[   24.209735]       soft-irq read-recursion/321:  ok  |
[   24.210062] -------------------------------------------------------
[   24.210079] Good, all 210 testcases passed! |
[   24.210092] ---------------------------------
[   24.210333] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   24.210581] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   24.248824] Memory: 494444k/524224k available (2314k kernel code,
29196k reserved, 1064k data, 336k init, 0k highmem)
[   24.248848] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   24.309562] Calibrating delay using timer specific routine..
3611.85 BogoMIPS (lpj=1805929)
[   24.309942] Security Framework v1.0.0 initialized
[   24.309961] SELinux:  Disabled at boot.
[   24.310060] Mount-cache hash table entries: 512
[   24.311470] CPU: After generic identify, caps: 078bfbff c1d3fbff
00000000 00000000 00000000 00000000 00000001
[   24.311571] CPU: After vendor identify, caps: 078bfbff c1d3fbff
00000000 00000000 00000000 00000000 00000001
[   24.311632] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   24.311650] CPU: L2 Cache: 256K (64 bytes/line)
[   24.311664] CPU: After all inits, caps: 078bfbff c1d3fbff 00000000
00000410 00000000 00000000 00000001
[   24.311723] Intel machine check architecture supported.
[   24.311738] Intel machine check reporting enabled on CPU#0.
[   24.311771] CPU: AMD Sempron(tm) Processor 3100+ stepping 00
[   24.311799] Checking 'hlt' instruction... OK.
[   24.315647] SMP alternatives: switching to UP code
[   24.315661] Freeing SMP alternatives: 0k freed
[   24.339204] lockdep: disabled NMI watchdog.
[   24.339782] ENABLING IO-APIC IRQs
[   24.340231] ..TIMER: vector=0x31 apic1=0 pin1=2 apic2=0 pin2=0
[   24.454476] checking if image is initramfs... it is
[   25.354146] Freeing initrd memory: 6389k freed
[   25.358050] NET: Registered protocol family 16
[   25.358698] EISA bus registered
[   25.358727] ACPI: bus type pci registered
[   25.359143] PCI: PCI BIOS revision 2.10 entry at 0xfdab1, last bus=1
[   25.359159] Setting up standard PCI resources
[   25.369124] ACPI: Subsystem revision 20060310
[   25.418335] ACPI: Interpreter enabled
[   25.418351] ACPI: Using IOAPIC for interrupt routing
[   25.424122] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   25.424156] PCI: Probing PCI hardware (bus 00)
[   25.457410] PCI: Quirk-MSI-K8T Soundcard On
[   25.457431] PCI: Unexpected Value in PCI-Register: no Change!
[   25.459785] Boot video device is 0000:01:00.0
[   25.460245] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   25.714869] ACPI: Power Resource [URP1] (off)
[   25.715733] ACPI: Power Resource [URP2] (off)
[   25.716618] ACPI: Power Resource [FDDP] (off)
[   25.717490] ACPI: Power Resource [LPTP] (off)
[   25.740345] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[   25.743407] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
[   25.746452] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[   25.749461] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 *12 14 15)
[   25.752485] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   25.755578] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   25.758620] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   25.761841] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 11
12 14 15) *0, disabled.
[   25.764012] Linux Plug and Play Support v0.97 (c) Adam Belay
[   25.764305] pnp: PnP ACPI init
[   25.790778] pnp: PnP ACPI: found 8 devices
[   25.790796] PnPBIOS: Disabled by ACPI PNP
[   25.791884] PCI: Using ACPI for IRQ routing
[   25.791901] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   25.802390] PCI: Bridge: 0000:00:01.0
[   25.802412]   IO window: a000-afff
[   25.802447]   MEM window: cfe00000-cfefffff
[   25.802475]   PREFETCH window: bfd00000-cfcfffff
[   25.802581] PCI: Setting latency timer of device 0000:00:01.0 to 64
[   25.802730] NET: Registered protocol family 2
[   25.811391] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   25.812252] TCP established hash table entries: 16384 (order: 8,
1376256 bytes)
[   25.820104] TCP bind hash table entries: 8192 (order: 7, 720896 bytes)
[   25.824059] TCP: Hash tables configured (established 16384 bind 8192)
[   25.824098] TCP reno registered
[   25.827943] Machine check exception polling timer started.
[   25.837330] audit: initializing netlink socket (disabled)
[   25.837406] audit(1149457568.892:1): initialized
[   25.839156] VFS: Disk quotas dquot_6.5.1
[   25.839273] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   25.839863] Initializing Cryptographic API
[   25.839902] io scheduler noop registered
[   25.839942] io scheduler anticipatory registered
[   25.840018] io scheduler deadline registered
[   25.840130] io scheduler cfq registered (default)
[   25.843718] isapnp: Scanning for PnP cards...
[   26.202230] isapnp: No Plug & Play device found
[   26.493657] Real Time Clock Driver v1.12ac
[   26.494201] Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports,
IRQ sharing enabled
[   26.511185] RAMDISK driver initialized: 16 RAM disks of 65536K size
1024 blocksize
[   26.512793] Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
[   26.512814] ide: Assuming 33MHz system bus speed for PIO modes;
override with idebus=xx
[   26.515141] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[   26.515159] PNP: PS/2 controller doesn't have AUX irq; using default 12
[   26.516432] serio: i8042 AUX port at 0x60,0x64 irq 12
[   26.517522] serio: i8042 KBD port at 0x60,0x64 irq 1
[   26.519538] mice: PS/2 mouse device common for all mice
[   26.521800] EISA: Probing bus 0 at eisa.0
[   26.522067] EISA: Detected 0 cards.
[   26.522440] TCP bic registered
[   26.522479] NET: Registered protocol family 1
[   26.522525] NET: Registered protocol family 8
[   26.522541] NET: Registered protocol family 20
[   26.522724] Using IPI Shortcut mode
[   26.522822] Time: tsc clocksource has been installed.
[   26.523443] ACPI: (supports S0 S1 S3 S4 S5)
[   26.524401] Freeing unused kernel memory: 336k freed
[   26.524706] Write protecting the kernel read-only data: 326k
[   26.954484] input: AT Translated Set 2 keyboard as /class/input/input0
[   27.000175] input: AT Translated Set 2 keyboard as /class/input/input1
[   32.370656] SCSI subsystem initialized
[   32.379682] libata version 1.30 loaded.
[   32.387729] sata_via 0000:00:0f.0: version 1.2
[   32.387801] ACPI (acpi_bus-0192): Device `IDE1]is not power
manageable [20060310]
[   32.387861] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level,
low) -> IRQ 169
[   32.387932] sata_via 0000:00:0f.0: routed to hard irq line 10
[   32.388459] ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma
0xDC00 irq 169
[   32.388802] ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma
0xDC08 irq 169
[   32.588673] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   32.741461] ata1.00: cfg 49:2f00 82:306a 83:4201 84:4000 85:3068
86:0201 87:4000 88:203f
[   32.741484] ata1.00: ATA-4, max UDMA/100, 40011300 sectors: LBA
[   32.741500] ata1.00: applying bridge limits
[   32.743529] ata1.00: configured for UDMA/100
[   32.743543] scsi0 : sata_via
[   32.946058] ata2: SATA link down (SStatus 0 SControl 300)
[   32.946079] scsi1 : sata_via
[   32.949449]   Vendor: ATA       Model: ST320413A         Rev: 3.05
[   32.949613]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   33.019753] SCSI device sda: 40011300 512-byte hdwr sectors (20486 MB)
[   33.020028] sda: Write Protect is off
[   33.020042] sda: Mode Sense: 00 3a 00 00
[   33.020436] SCSI device sda: drive cache: write back
[   33.021737] SCSI device sda: 40011300 512-byte hdwr sectors (20486 MB)
[   33.022038] sda: Write Protect is off
[   33.022052] sda: Mode Sense: 00 3a 00 00
[   33.022514] SCSI device sda: drive cache: write back
[   33.022532]  sda: sda1 sda2 < sda5 >
[   33.123417] sd 0:0:0:0: Attached scsi disk sda
[   33.711303] VP_IDE: IDE controller at PCI slot 0000:00:0f.1
[   33.711377] ACPI (acpi_bus-0192): Device `IDE0]is not power
manageable [20060310]
[   33.711422] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level,
low) -> IRQ 169
[   33.711454] PCI: VIA IRQ fixup for 0000:00:0f.1, from 255 to 9
[   33.711520] VP_IDE: chipset revision 6
[   33.711532] VP_IDE: not 100% native mode: will probe irqs later
[   33.711594] VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on
pci0000:00:0f.1
[   33.711634]     ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings:
hda:pio, hdb:pio
[   33.711711]     ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings:
hdc:DMA, hdd:pio
[   33.711818] Probing IDE interface ide0...
[   34.229911] Probing IDE interface ide1...
[   35.026655] hdc: TSSTcorpCD/DVDW SH-W162Z, ATAPI CD/DVD-ROM drive
[   35.638662] ide1 at 0x170-0x177,0x376 on irq 15
[   35.722777] hdc: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB
Cache, UDMA(33)
[   35.722837] Uniform CD-ROM driver Revision: 3.20
[   36.121194] usbcore: registered new driver usbfs
[   36.121878] usbcore: registered new driver hub
[   36.125337] USB Universal Host Controller Interface driver v3.0
[   36.125780] ACPI (acpi_bus-0192): Device `USB1]is not power
manageable [20060310]
[   36.125838] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level,
low) -> IRQ 177
[   36.125870] PCI: VIA IRQ fixup for 0000:00:10.0, from 11 to 1
[   36.125933] uhci_hcd 0000:00:10.0: UHCI Host Controller
[   36.127273] uhci_hcd 0000:00:10.0: new USB bus registered, assigned
bus number 1
[   36.127380] uhci_hcd 0000:00:10.0: irq 177, io base 0x0000c000
[   36.127871] usb usb1: new device found, idVendor=0000, idProduct=0000
[   36.127888] usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
[   36.127906] usb usb1: Product: UHCI Host Controller
[   36.127920] usb usb1: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hcd
[   36.127937] usb usb1: SerialNumber: 0000:00:10.0
[   36.129401] usb usb1: configuration #1 chosen from 1 choice
[   36.130241] hub 1-0:1.0: USB hub found
[   36.130330] hub 1-0:1.0: 2 ports detected
[   36.232567] ACPI (acpi_bus-0192): Device `USB2]is not power
manageable [20060310]
[   36.232613] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level,
low) -> IRQ 177
[   36.232645] PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 1
[   36.232708] uhci_hcd 0000:00:10.1: UHCI Host Controller
[   36.233418] uhci_hcd 0000:00:10.1: new USB bus registered, assigned
bus number 2
[   36.233525] uhci_hcd 0000:00:10.1: irq 177, io base 0x0000c400
[   36.233946] usb usb2: new device found, idVendor=0000, idProduct=0000
[   36.233963] usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
[   36.233980] usb usb2: Product: UHCI Host Controller
[   36.233995] usb usb2: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hcd
[   36.234012] usb usb2: SerialNumber: 0000:00:10.1
[   36.235431] usb usb2: configuration #1 chosen from 1 choice
[   36.236073] hub 2-0:1.0: USB hub found
[   36.236150] hub 2-0:1.0: 2 ports detected
[   36.337990] ACPI (acpi_bus-0192): Device `USB3]is not power
manageable [20060310]
[   36.338036] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level,
low) -> IRQ 177
[   36.338068] PCI: VIA IRQ fixup for 0000:00:10.2, from 10 to 1
[   36.338131] uhci_hcd 0000:00:10.2: UHCI Host Controller
[   36.338700] uhci_hcd 0000:00:10.2: new USB bus registered, assigned
bus number 3
[   36.338768] uhci_hcd 0000:00:10.2: irq 177, io base 0x0000c800
[   36.339203] usb usb3: new device found, idVendor=0000, idProduct=0000
[   36.339220] usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
[   36.339237] usb usb3: Product: UHCI Host Controller
[   36.339252] usb usb3: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hcd
[   36.339269] usb usb3: SerialNumber: 0000:00:10.2
[   36.340884] usb usb3: configuration #1 chosen from 1 choice
[   36.341653] hub 3-0:1.0: USB hub found
[   36.341728] hub 3-0:1.0: 2 ports detected
[   36.443835] ACPI (acpi_bus-0192): Device `USB4]is not power
manageable [20060310]
[   36.443880] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level,
low) -> IRQ 177
[   36.443912] PCI: VIA IRQ fixup for 0000:00:10.3, from 10 to 1
[   36.443976] uhci_hcd 0000:00:10.3: UHCI Host Controller
[   36.444715] uhci_hcd 0000:00:10.3: new USB bus registered, assigned
bus number 4
[   36.444784] uhci_hcd 0000:00:10.3: irq 177, io base 0x0000cc00
[   36.445267] usb usb4: new device found, idVendor=0000, idProduct=0000
[   36.445284] usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
[   36.445302] usb usb4: Product: UHCI Host Controller
[   36.445316] usb usb4: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep uhci_hcd
[   36.445333] usb usb4: SerialNumber: 0000:00:10.3
[   36.446875] usb usb4: configuration #1 chosen from 1 choice
[   36.447601] hub 4-0:1.0: USB hub found
[   36.447677] hub 4-0:1.0: 2 ports detected
[   36.552513] ACPI (acpi_bus-0192): Device `EHCI]is not power
manageable [20060310]
[   36.552561] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level,
low) -> IRQ 177
[   36.552617] ehci_hcd 0000:00:10.4: EHCI Host Controller
[   36.553453] ehci_hcd 0000:00:10.4: new USB bus registered, assigned
bus number 5
[   36.553660] ehci_hcd 0000:00:10.4: irq 177, io mem 0xcfffbd00
[   36.553681] ehci_hcd 0000:00:10.4: USB 2.0 started, EHCI 1.00,
driver 10 Dec 2004
[   36.554089] usb usb5: new device found, idVendor=0000, idProduct=0000
[   36.554106] usb usb5: new device strings: Mfr=3, Product=2, SerialNumber=1
[   36.554123] usb usb5: Product: EHCI Host Controller
[   36.554138] usb usb5: Manufacturer: Linux 2.6.17-rc5-mm3-lockdep ehci_hcd
[   36.554155] usb usb5: SerialNumber: 0000:00:10.4
[   36.555658] usb usb5: configuration #1 chosen from 1 choice
[   36.556466] hub 5-0:1.0: USB hub found
[   36.556547] hub 5-0:1.0: 8 ports detected
[   37.028583] Probing IDE interface ide0...
[   37.503437] usb 4-2: new low speed USB device using uhci_hcd and address 2
[   37.668978] usb 4-2: new device found, idVendor=0a81, idProduct=0205
[   37.668996] usb 4-2: new device strings: Mfr=1, Product=2, SerialNumber=0
[   37.669014] usb 4-2: Product: PS2 to USB Converter
[   37.669028] usb 4-2: Manufacturer: CHESEN
[   37.670130] usb 4-2: configuration #1 chosen from 1 choice
[   37.725526] usbcore: registered new driver hiddev
[   37.772372] input: CHESEN PS2 to USB Converter as /class/input/input2
[   37.772495] input: USB HID v1.10 Keyboard [CHESEN PS2 to USB
Converter] on usb-0000:00:10.3-2
[   37.799469] input: CHESEN PS2 to USB Converter as /class/input/input3
[   37.801212] input: USB HID v1.10 Mouse [CHESEN PS2 to USB
Converter] on usb-0000:00:10.3-2
[   37.801311] usbcore: registered new driver usbhid
[   37.801334] drivers/usb/input/hid-core.c: v2.6:USB HID core driver
[   38.093260] Attempting manual resume
[   38.161377] kjournald starting.  Commit interval 5 seconds
[   38.161609] EXT3-fs: mounted filesystem with ordered data mode.
[   55.046126] ts: Compaq touchscreen protocol output
[   57.856250] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   97.317715] Linux agpgart interface v0.101 (c) Dave Jones
[   97.330643] agpgart: Detected AGP bridge 0
[   97.337374] agpgart: AGP aperture is 128M @ 0xd0000000
[   97.356918] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   97.384484] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   97.811441] r8169 Gigabit Ethernet driver 2.2LK loaded
[   97.811546] ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 16 (level,
low) -> IRQ 185
[   97.814067] eth0: Identified chip type is 'RTL8169s/8110s'.
[   97.814088] eth0: RTL8169 at 0xe0834f00, 00:0c:76:e6:28:b2, IRQ 185
[   98.502501] input: PC Speaker as /class/input/input4
[   99.053587] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level,
low) -> IRQ 193
[   99.419727] Floppy drive(s): fd0 is 1.44M
[   99.436978] FDC 0 is a post-1991 82077
[  103.474271] r8169: eth0: link up
[  104.641582] lp: driver loaded but no devices found
[  104.690836] NET: Registered protocol family 17
[  104.934392] Adding 843372k swap on /dev/sda5.  Priority:-1
extents:1 across:843372k
[  105.266019] EXT3 FS on sda1, internal journal
[  106.384683] md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
[  106.384701] md: bitmap version 4.39
[  108.233527] device-mapper: 4.6.0-ioctl (2006-02-17) initialised:
dm-devel@redhat.com
[  109.748091] device-mapper: dm-linear: Device lookup failed
[  109.748252] device-mapper: error adding target to table
[  109.773376] device-mapper: dm-linear: Device lookup failed
[  109.773490] device-mapper: error adding target to table
[  109.798559] device-mapper: dm-linear: Device lookup failed
[  109.798676] device-mapper: error adding target to table
[  109.824510] device-mapper: dm-linear: Device lookup failed
[  109.824625] device-mapper: error adding target to table
[  109.850440] device-mapper: dm-linear: Device lookup failed
[  109.850555] device-mapper: error adding target to table
[  109.875461] device-mapper: dm-linear: Device lookup failed
[  109.875576] device-mapper: error adding target to table
[  109.885963] device-mapper: dm-linear: Device lookup failed
[  109.886076] device-mapper: error adding target to table
[  109.891721] device-mapper: dm-linear: Device lookup failed
[  109.891834] device-mapper: error adding target to table
[  110.621512] NET: Registered protocol family 10
[  110.622403] lo: Disabled Privacy Extensions
[  110.624779] IPv6 over IPv4 tunneling driver
[  119.663131] ACPI: Power Button (FF) [PWRF]
[  119.663251] ACPI: Power Button (CM) [PWRB]
[  119.663373] ACPI: Sleep Button (CM) [SLPB]
[  119.970129] Using specific hotkey driver
[  120.066655] ibm_acpi: ec object not found
[  120.295368] toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
[  121.444258] eth0: no IPv6 routers present
[  121.647122] powernow-k8: Found 1 AMD Athlon 64 / Opteron processors
(version 1.60.2)
[  121.648452] ACPI Warning (acpi_utils-0063): Invalid package
argument [20060310]
[  121.648486] ACPI Exception (acpi_processor-0269): AE_BAD_PARAMETER,
Invalid _PSS data [20060310]
[  121.652233] powernow-k8:    0 : fid 0x2 (1000 MHz), vid 0x12 (1100 mV)
[  121.652251] powernow-k8:    1 : fid 0xa (1800 MHz), vid 0x6 (1400 mV)
[  121.652270] cpu_init done, current fid 0xa, vid 0x6
[  135.297388] ppdev: user-space parallel port driver
[  140.558333] apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
[  140.563939] apm: overridden by ACPI.
[  143.505269] Bluetooth: Core ver 2.8
[  143.505295] NET: Registered protocol family 31
[  143.505309] Bluetooth: HCI device and connection manager initialized
[  143.505712] Bluetooth: HCI socket layer initialized
[  143.621951] Bluetooth: L2CAP ver 2.8
[  143.621972] Bluetooth: L2CAP socket layer initialized
[  143.771978] Bluetooth: RFCOMM socket layer initialized
[  143.772035] Bluetooth: RFCOMM TTY layer initialized
[  143.772049] Bluetooth: RFCOMM ver 1.7
[  128.340000] Time: acpi_pm clocksource has been installed.
[  350.502000] ACPI: PCI interrupt for device 0000:00:0b.0 disabled
[  354.364000] Stopping tasks:
============================================================================|
[  354.408000] Shrinking memory...  -\done (17603 pages freed)
[  354.998000] Suspending device floppy.0
[  354.998000] Suspending device i2c-0
[  354.998000] Suspending device 4-2:1.1
[  354.999000] Suspending device 4-2:1.0
[  355.000000] Suspending device 4-2
[  355.000000] Suspending device 5-0:1.0
[  355.000000] Suspending device usb5
[  355.000000] Suspending device 4-0:1.0
[  355.000000] Suspending device usb4
[  355.000000] Suspending device 3-0:1.0
[  355.000000] Suspending device usb3
[  355.001000] Suspending device 2-0:1.0
[  355.001000] Suspending device usb2
[  355.001000] Suspending device 1-0:1.0
[  355.001000] Suspending device usb1
[  355.001000] Suspending device 1.0
[  355.001000] Suspending device ide1
[  355.001000] Suspending device 0:0:0:0
[  355.001000] Suspending device target0:0:0
[  355.001000] Suspending device host1
[  355.001000] Suspending device host0
[  355.001000] Suspending device eisa.0
[  355.001000] Suspending device serio1
[  355.001000] Suspending device serio0
[  355.001000] Suspending device i8042
[  355.001000] Suspending device serial8250
[  355.001000] Suspending device pnp1
[  355.001000] Suspending device vesafb.0
[  355.001000] Suspending device pcspkr
[  355.001000] Suspending device 00:07
[  355.001000] Suspending device 00:06
[  355.001000] Suspending device 00:05
[  355.001000] Suspending device 00:04
[  355.001000] Suspending device 00:03
[  355.001000] Suspending device 00:02
[  355.001000] Suspending device 00:01
[  355.001000] Suspending device 00:00
[  355.001000] Suspending device pnp0
[  355.001000] Suspending device 0000:01:00.0
[  355.001000] Suspending device 0000:00:18.3
[  355.001000] Suspending device 0000:00:18.2
[  355.002000] Suspending device 0000:00:18.1
[  355.002000] Suspending device 0000:00:18.0
[  355.002000] Suspending device 0000:00:11.0
[  355.002000] Suspending device 0000:00:10.4
[  355.013000] ACPI: PCI interrupt for device 0000:00:10.4 disabled
[  355.024000] ACPI (acpi_bus-0192): Device `EHCI]is not power
manageable [20060310]
[  355.024000] Suspending device 0000:00:10.3
[  355.024000] ACPI: PCI interrupt for device 0000:00:10.3 disabled
[  355.035000] ACPI (acpi_bus-0192): Device `USB4]is not power
manageable [20060310]
[  355.035000] Suspending device 0000:00:10.2
[  355.035000] ACPI: PCI interrupt for device 0000:00:10.2 disabled
[  355.046000] ACPI (acpi_bus-0192): Device `USB3]is not power
manageable [20060310]
[  355.046000] Suspending device 0000:00:10.1
[  355.046000] ACPI: PCI interrupt for device 0000:00:10.1 disabled
[  355.057000] ACPI (acpi_bus-0192): Device `USB2]is not power
manageable [20060310]
[  355.057000] Suspending device 0000:00:10.0
[  355.057000] ACPI: PCI interrupt for device 0000:00:10.0 disabled
[  355.068000] ACPI (acpi_bus-0192): Device `USB1]is not power
manageable [20060310]
[  355.068000] Suspending device 0000:00:0f.1
[  355.068000] Suspending device 0000:00:0f.0
[  355.068000] Suspending device 0000:00:0b.0
[  355.069000] Suspending device 0000:00:06.0
[  355.080000] ACPI: PCI interrupt for device 0000:00:06.0 disabled
[  355.080000] Suspending device 0000:00:01.0
[  355.080000] Suspending device 0000:00:00.0
[  355.081000] pci_set_power_state(): 0000:00:00.0: state=3, current state=5
[  355.081000] Suspending device pci0000:00
[  355.081000] Suspending device acpi
[  355.081000] Suspending device platform
[  355.081000]
[  355.081000] swsusp: Need to copy 59004 pages
[  355.081000] Intel machine check architecture supported.
[  355.081000] Intel machine check reporting enabled on CPU#0.
[  355.081000] swsusp: Restoring Highmem
[  487.081000] APIC error on CPU0: 00(00)
[  487.203000] ACPI Exception (acpi_bus-0070): AE_NOT_FOUND, No
context for object [c174d620] [20060310]
[  487.203000] PM: Writing back config space on device 0000:00:00.0 at
offset 1 (was 22300006, writing 32300006)
[  487.203000] PCI: Setting latency timer of device 0000:00:01.0 to 64
[  487.204000] PM: Writing back config space on device 0000:00:06.0 at
offset 1 (was 2100005, writing 2100000)
[  487.204000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.204000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.205000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.205000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.205000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.205000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.205000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.206000]  [<c012aada>] msleep+0x2a/0x50
[  487.206000]  [<c022e55d>] pci_set_power_state+0x1bd/0x250
[  487.208000]  [<c022e617>] pci_enable_device_bars+0x27/0x80
[  487.209000]  [<c022e6a0>] pci_enable_device+0x30/0x40
[  487.211000]  [<e0a36ee0>] snd_cmipci_resume+0x30/0x110 [snd_cmipci]
[  487.211000]  [<c023045a>] pci_device_resume+0x2a/0x80
[  487.213000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.215000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.217000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.219000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.220000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.220000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.221000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.222000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.223000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.224000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.225000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.225000]  [<b7f40410>] 0xb7f40410
[  487.227000] PCI: Enabling device 0000:00:06.0 (0000 -> 0001)
[  487.227000] ACPI: PCI Interrupt 0000:00:06.0[A] -> GSI 17 (level,
low) -> IRQ 193
[  487.227000] PM: Writing back config space on device 0000:00:0b.0 at
offset 3 (was 2008, writing 2010)
[  487.227000] PM: Writing back config space on device 0000:00:0b.0 at
offset 1 (was 2b00017, writing 2b00010)
[  487.227000] ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level,
low) -> IRQ 169
[  487.229000] ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level,
low) -> IRQ 169
[  487.229000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.230000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.230000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.230000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.230000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.230000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.231000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.231000]  [<c012aada>] msleep+0x2a/0x50
[  487.231000]  [<c022e55d>] pci_set_power_state+0x1bd/0x250
[  487.233000]  [<c022e617>] pci_enable_device_bars+0x27/0x80
[  487.235000]  [<c022e6a0>] pci_enable_device+0x30/0x40
[  487.236000]  [<e08e0cd8>] usb_hcd_pci_resume+0x48/0x150 [usbcore]
[  487.237000]  [<c023045a>] pci_device_resume+0x2a/0x80
[  487.239000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.241000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.244000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.246000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.247000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.247000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.248000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.249000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.251000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.252000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.252000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.252000]  [<b7f40410>] 0xb7f40410
[  487.252000] ACPI (acpi_bus-0192): Device `USB1]is not power
manageable [20060310]
[  487.253000] PCI: Enabling device 0000:00:10.0 (0010 -> 0011)
[  487.253000] ACPI: PCI Interrupt 0000:00:10.0[A] -> GSI 21 (level,
low) -> IRQ 177
[  487.253000] PM: Writing back config space on device 0000:00:10.0 at
offset 1 (was 2100015, writing 2100017)
[  487.253000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.254000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.254000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.254000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.254000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.254000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.255000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.255000]  [<c012aada>] msleep+0x2a/0x50
[  487.256000]  [<c022e55d>] pci_set_power_state+0x1bd/0x250
[  487.257000]  [<c022e617>] pci_enable_device_bars+0x27/0x80
[  487.259000]  [<c022e6a0>] pci_enable_device+0x30/0x40
[  487.261000]  [<e08e0cd8>] usb_hcd_pci_resume+0x48/0x150 [usbcore]
[  487.261000]  [<c023045a>] pci_device_resume+0x2a/0x80
[  487.263000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.266000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.268000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.271000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.272000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.272000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.273000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.274000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.275000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.276000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.277000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.277000]  [<b7f40410>] 0xb7f40410
[  487.277000] ACPI (acpi_bus-0192): Device `USB2]is not power
manageable [20060310]
[  487.277000] PCI: Enabling device 0000:00:10.1 (0010 -> 0011)
[  487.277000] ACPI: PCI Interrupt 0000:00:10.1[A] -> GSI 21 (level,
low) -> IRQ 177
[  487.278000] PM: Writing back config space on device 0000:00:10.1 at
offset 1 (was 2100015, writing 2100017)
[  487.278000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.279000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.279000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.279000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.279000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.279000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.279000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.280000]  [<c012aada>] msleep+0x2a/0x50
[  487.280000]  [<c022e55d>] pci_set_power_state+0x1bd/0x250
[  487.282000]  [<c022e617>] pci_enable_device_bars+0x27/0x80
[  487.284000]  [<c022e6a0>] pci_enable_device+0x30/0x40
[  487.286000]  [<e08e0cd8>] usb_hcd_pci_resume+0x48/0x150 [usbcore]
[  487.286000]  [<c023045a>] pci_device_resume+0x2a/0x80
[  487.288000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.290000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.293000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.296000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.296000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.297000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.297000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.299000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.300000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.301000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.302000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.302000]  [<b7f40410>] 0xb7f40410
[  487.302000] ACPI (acpi_bus-0192): Device `USB3]is not power
manageable [20060310]
[  487.302000] PCI: Enabling device 0000:00:10.2 (0010 -> 0011)
[  487.302000] ACPI: PCI Interrupt 0000:00:10.2[B] -> GSI 21 (level,
low) -> IRQ 177
[  487.302000] PM: Writing back config space on device 0000:00:10.2 at
offset 1 (was 2100015, writing 2100017)
[  487.303000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.303000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.303000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.303000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.303000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.304000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.304000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.305000]  [<c012aada>] msleep+0x2a/0x50
[  487.305000]  [<c022e55d>] pci_set_power_state+0x1bd/0x250
[  487.307000]  [<c022e617>] pci_enable_device_bars+0x27/0x80
[  487.309000]  [<c022e6a0>] pci_enable_device+0x30/0x40
[  487.311000]  [<e08e0cd8>] usb_hcd_pci_resume+0x48/0x150 [usbcore]
[  487.311000]  [<c023045a>] pci_device_resume+0x2a/0x80
[  487.313000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.315000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.318000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.320000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.321000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.321000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.322000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.323000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.325000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.326000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.326000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.327000]  [<b7f40410>] 0xb7f40410
[  487.327000] ACPI (acpi_bus-0192): Device `USB4]is not power
manageable [20060310]
[  487.327000] PCI: Enabling device 0000:00:10.3 (0010 -> 0011)
[  487.327000] ACPI: PCI Interrupt 0000:00:10.3[B] -> GSI 21 (level,
low) -> IRQ 177
[  487.327000] PM: Writing back config space on device 0000:00:10.3 at
offset 1 (was 2100015, writing 2100017)
[  487.327000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.328000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.328000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.328000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.328000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.328000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.329000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.329000]  [<c012aada>] msleep+0x2a/0x50
[  487.330000]  [<c022e55d>] pci_set_power_state+0x1bd/0x250
[  487.332000]  [<c022e617>] pci_enable_device_bars+0x27/0x80
[  487.333000]  [<c022e6a0>] pci_enable_device+0x30/0x40
[  487.335000]  [<e08e0cd8>] usb_hcd_pci_resume+0x48/0x150 [usbcore]
[  487.335000]  [<c023045a>] pci_device_resume+0x2a/0x80
[  487.337000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.340000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.342000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.345000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.346000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.346000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.347000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.348000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.349000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.350000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.351000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.351000]  [<b7f40410>] 0xb7f40410
[  487.351000] ACPI (acpi_bus-0192): Device `EHCI]is not power
manageable [20060310]
[  487.351000] PCI: Enabling device 0000:00:10.4 (0010 -> 0012)
[  487.351000] ACPI: PCI Interrupt 0000:00:10.4[C] -> GSI 21 (level,
low) -> IRQ 177
[  487.352000] PM: Writing back config space on device 0000:00:10.4 at
offset 1 (was 2100016, writing 2100017)
[  487.353000] pnp: Failed to activate device 00:07.
[  487.353000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.354000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.354000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.354000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.354000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.355000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.355000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.358000]  [<c02a516f>] ps2_command+0xff/0x3f0
[  487.361000]  [<c02aa54c>] atkbd_probe+0x3c/0x130
[  487.363000]  [<c02ac038>] atkbd_reconnect+0xb8/0x130
[  487.366000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.369000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.372000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.374000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.377000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.379000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.380000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.381000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.381000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.383000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.384000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.385000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.386000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.386000]  [<b7f40410>] 0xb7f40410
[  487.386000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.387000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.387000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.387000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.387000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.387000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.388000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.390000]  [<c02a516f>] ps2_command+0xff/0x3f0
[  487.393000]  [<c02aa7cf>] atkbd_activate+0x2f/0xa0
[  487.396000]  [<c02ac06d>] atkbd_reconnect+0xed/0x130
[  487.399000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.401000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.404000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.407000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.409000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.412000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.412000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.413000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.414000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.415000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.416000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.417000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.418000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.418000]  [<b7f40410>] 0xb7f40410
[  487.418000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.419000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.419000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.419000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.419000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.419000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.420000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.423000]  [<c02a540e>] ps2_command+0x39e/0x3f0
[  487.425000]  [<c02aa7cf>] atkbd_activate+0x2f/0xa0
[  487.428000]  [<c02ac06d>] atkbd_reconnect+0xed/0x130
[  487.431000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.433000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.436000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.438000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.441000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.443000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.444000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.444000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.445000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.446000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.447000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.448000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.449000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.449000]  [<b7f40410>] 0xb7f40410
[  487.449000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.450000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.450000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.450000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.450000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.451000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.451000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.454000]  [<c02a516f>] ps2_command+0xff/0x3f0
[  487.457000]  [<c02aa7fa>] atkbd_activate+0x5a/0xa0
[  487.459000]  [<c02ac06d>] atkbd_reconnect+0xed/0x130
[  487.462000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.465000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.467000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.470000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.473000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.475000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.476000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.476000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.477000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.478000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.480000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.481000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.481000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.482000]  [<b7f40410>] 0xb7f40410
[  487.482000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.482000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.482000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.482000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.483000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.483000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.483000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.486000]  [<c02a540e>] ps2_command+0x39e/0x3f0
[  487.489000]  [<c02aa7fa>] atkbd_activate+0x5a/0xa0
[  487.492000]  [<c02ac06d>] atkbd_reconnect+0xed/0x130
[  487.494000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.497000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.500000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.502000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.505000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.507000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.508000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.509000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.509000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.511000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.512000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.513000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.514000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.514000]  [<b7f40410>] 0xb7f40410
[  487.514000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.515000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.515000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.515000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.515000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.515000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.516000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.518000]  [<c02a516f>] ps2_command+0xff/0x3f0
[  487.521000]  [<c02aa816>] atkbd_activate+0x76/0xa0
[  487.524000]  [<c02ac06d>] atkbd_reconnect+0xed/0x130
[  487.527000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.529000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.532000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.535000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.537000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.540000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.540000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.541000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.542000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.543000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.544000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.545000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.546000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.546000]  [<b7f40410>] 0xb7f40410
[  487.546000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.547000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.547000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.547000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.547000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.547000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.548000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.551000]  [<c02a516f>] ps2_command+0xff/0x3f0
[  487.553000]  [<c02ac084>] atkbd_reconnect+0x104/0x130
[  487.556000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.558000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.561000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.563000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.566000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.568000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.569000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.570000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.570000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.571000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.573000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.574000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.574000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.575000]  [<b7f40410>] 0xb7f40410
[  487.575000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.575000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.575000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.575000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.576000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.576000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.576000]  [<c02a4eef>] ps2_sendbyte+0xdf/0x130
[  487.579000]  [<c02a540e>] ps2_command+0x39e/0x3f0
[  487.582000]  [<c02ac084>] atkbd_reconnect+0x104/0x130
[  487.585000]  [<c02a19cd>] serio_reconnect_driver+0x4d/0x60
[  487.587000]  [<c02a2b0d>] serio_resume+0x1d/0x40
[  487.590000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.593000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.595000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.598000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.598000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.599000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.600000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.601000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.602000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.603000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.604000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.604000]  [<b7f40410>] 0xb7f40410
[  487.605000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.606000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.606000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.606000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.606000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.606000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.607000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.607000]  [<c012aada>] msleep+0x2a/0x50
[  487.608000]  [<e085b8b1>] wakeup_rh+0x71/0xf0 [uhci_hcd]
[  487.608000]  [<e085b98c>] uhci_rh_resume+0x5c/0xb0 [uhci_hcd]
[  487.608000]  [<e08d6371>] hcd_bus_resume+0x41/0x80 [usbcore]
[  487.608000]  [<e08d2969>] hub_resume+0x49/0x60 [usbcore]
[  487.608000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.608000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.608000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.608000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.610000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.613000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.616000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.616000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.617000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.617000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.619000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.620000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.621000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.622000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.622000]  [<b7f40410>] 0xb7f40410
[  487.626000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.626000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.626000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.626000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.626000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.627000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.627000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.628000]  [<c012aada>] msleep+0x2a/0x50
[  487.628000]  [<e08d2979>] hub_resume+0x59/0x60 [usbcore]
[  487.628000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.628000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.628000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.628000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.631000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.633000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.636000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.636000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.637000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.638000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.639000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.640000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.641000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.642000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.642000]  [<b7f40410>] 0xb7f40410
[  487.642000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.643000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.643000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.643000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.643000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.643000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.644000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.644000]  [<c012aada>] msleep+0x2a/0x50
[  487.645000]  [<e085b8b1>] wakeup_rh+0x71/0xf0 [uhci_hcd]
[  487.645000]  [<e085b98c>] uhci_rh_resume+0x5c/0xb0 [uhci_hcd]
[  487.645000]  [<e08d6371>] hcd_bus_resume+0x41/0x80 [usbcore]
[  487.645000]  [<e08d2969>] hub_resume+0x49/0x60 [usbcore]
[  487.645000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.645000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.645000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.645000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.648000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.650000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.653000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.653000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.654000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.655000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.656000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.657000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.658000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.659000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.659000]  [<b7f40410>] 0xb7f40410
[  487.663000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.663000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.663000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.663000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.663000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.664000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.664000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.665000]  [<c012aada>] msleep+0x2a/0x50
[  487.665000]  [<e08d2979>] hub_resume+0x59/0x60 [usbcore]
[  487.665000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.665000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.665000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.665000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.668000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.670000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.673000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.673000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.674000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.675000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.676000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.677000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.678000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.679000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.679000]  [<b7f40410>] 0xb7f40410
[  487.679000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.680000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.680000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.680000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.680000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.680000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.681000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.681000]  [<c012aada>] msleep+0x2a/0x50
[  487.682000]  [<e085b8b1>] wakeup_rh+0x71/0xf0 [uhci_hcd]
[  487.682000]  [<e085b98c>] uhci_rh_resume+0x5c/0xb0 [uhci_hcd]
[  487.682000]  [<e08d6371>] hcd_bus_resume+0x41/0x80 [usbcore]
[  487.682000]  [<e08d2969>] hub_resume+0x49/0x60 [usbcore]
[  487.682000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.682000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.682000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.682000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.685000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.687000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.689000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.690000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.691000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.691000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.692000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.694000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.695000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.695000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.696000]  [<b7f40410>] 0xb7f40410
[  487.700000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.700000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.700000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.700000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.700000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.701000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.701000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.702000]  [<c012aada>] msleep+0x2a/0x50
[  487.702000]  [<e08d2979>] hub_resume+0x59/0x60 [usbcore]
[  487.702000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.702000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.702000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.702000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.705000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.707000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.710000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.710000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.711000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.712000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.713000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.714000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.715000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.716000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.716000]  [<b7f40410>] 0xb7f40410
[  487.716000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.717000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.717000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.717000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.717000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.717000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.718000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.718000]  [<c012aada>] msleep+0x2a/0x50
[  487.719000]  [<e085b8b1>] wakeup_rh+0x71/0xf0 [uhci_hcd]
[  487.719000]  [<e085b98c>] uhci_rh_resume+0x5c/0xb0 [uhci_hcd]
[  487.719000]  [<e08d6371>] hcd_bus_resume+0x41/0x80 [usbcore]
[  487.719000]  [<e08d2969>] hub_resume+0x49/0x60 [usbcore]
[  487.719000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.719000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.719000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.719000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.722000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.724000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.727000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.727000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.728000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.729000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.730000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.731000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.732000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.733000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.733000]  [<b7f40410>] 0xb7f40410
[  487.737000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.737000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.737000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.737000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.737000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.738000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.738000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.739000]  [<c012aada>] msleep+0x2a/0x50
[  487.739000]  [<e08d2979>] hub_resume+0x59/0x60 [usbcore]
[  487.739000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.739000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.739000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.739000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.742000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.744000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.747000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.747000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.748000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.749000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.750000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.751000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.752000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.753000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.753000]  [<b7f40410>] 0xb7f40410
[  487.754000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  487.755000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.755000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.755000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.755000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.756000]  [<c033e111>] schedule_timeout+0x51/0xc0
[  487.756000]  [<c033e19f>] schedule_timeout_uninterruptible+0x1f/0x30
[  487.756000]  [<c012aada>] msleep+0x2a/0x50
[  487.757000]  [<e08d2979>] hub_resume+0x59/0x60 [usbcore]
[  487.757000]  [<e08d1885>] usb_generic_resume+0x75/0x120 [usbcore]
[  487.757000]  [<e08d2ad9>] usb_resume_device+0x159/0x1a0 [usbcore]
[  487.757000]  [<e08d1906>] usb_generic_resume+0xf6/0x120 [usbcore]
[  487.757000]  [<c02909a9>] resume_device+0x59/0xd0
[  487.760000]  [<c0290b5e>] dpm_resume+0x9e/0xb0
[  487.762000]  [<c0290b85>] device_resume+0x15/0x1f
[  487.765000]  [<c014d085>] pm_suspend_disk+0xb5/0x109
[  487.765000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.766000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.767000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.768000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.769000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.770000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.771000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.771000]  [<b7f40410>] 0xb7f40410
[  487.771000] Restarting tasks...<3>BUG: scheduling while atomic:
hibernate.sh/0x00000001/4681
[  487.772000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  487.772000]  [<c0105c3c>] show_trace+0x2c/0x30
[  487.772000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  487.773000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  487.773000]  [<c014bfa2>] thaw_processes+0xb2/0xe0
[  487.773000]  [<c014ce79>] unprepare_processes+0x19/0x50
[  487.774000]  [<c014d08a>] pm_suspend_disk+0xba/0x109
[  487.775000]  [<c014bcd5>] enter_state+0x145/0x190
[  487.775000]  [<c014bdb9>] state_store+0x99/0xb0
[  487.776000]  [<c01d1413>] subsys_attr_store+0x33/0x40
[  487.777000]  [<c01d1d14>] sysfs_write_file+0xa4/0xf0
[  487.778000]  [<c0182361>] vfs_write+0x101/0x1f0
[  487.779000]  [<c0182fec>] sys_write+0x4c/0x90
[  487.780000]  [<c0341a0a>] sysenter_past_esp+0x63/0xa1
[  487.780000]  [<b7f40410>] 0xb7f40410
[  489.444000]  done
[  489.444000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  489.444000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  489.444000]  [<c0105c3c>] show_trace+0x2c/0x30
[  489.444000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  489.444000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  489.444000]  [<c0341b46>] work_resched+0x5/0x25
[  489.444000]  [<b7f40410>] 0xb7f40410
[  489.447000] BUG: scheduling while atomic: hibernate.sh/0x00000001/4681
[  489.447000]  [<c010465a>] show_trace_log_lvl+0x18a/0x190
[  489.447000]  [<c0105c3c>] show_trace+0x2c/0x30
[  489.447000]  [<c0105c6b>] dump_stack+0x2b/0x30
[  489.447000]  [<c033d4fa>] schedule+0x6fa/0xa30
[  489.447000]  [<c0341b46>] work_resched+0x5/0x25
[  489.447000]  [<b7f40410>] 0xb7f40410
[  489.451000] note: hibernate.sh[4681] exited with preempt_count 1
[  496.633000] hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
[  496.633000] hdc: drive_cmd: error=0x04 { AbortedCommand }
[  496.633000] ide: failed opcode was: 0xec
