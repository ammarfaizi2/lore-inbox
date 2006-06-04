Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751493AbWFDOAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWFDOAs (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 10:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWFDOAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 10:00:48 -0400
Received: from wx-out-0102.google.com ([66.249.82.194]:44055 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751493AbWFDOAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 10:00:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=DAvVtFkY3iTRnHX+YYFS6DnpzH107gbRQw7mzyHJMvdRO7/n8noWbicEZZcvuOzWnDwNmE+C4hxQwvOvg0dUEN0hbyp8SAzsda/jd2lcmbZ8+f/S/INtLfmaGyXTSDyHCLLUhV7CdE3UfWbMLwdWyjCltyjH4MwuQCd/NUry+ho=
Message-ID: <986ed62e0606040700t7afc83ffl2c56de8c2e95f190@mail.gmail.com>
Date: Sun, 4 Jun 2006 07:00:47 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
        "Arjan van de Ven" <arjan@linux.intel.com>
Subject: Re: 2.6.17-rc5-mm3: bad unlock ordering (reiser4?)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <986ed62e0606040504n148bf744x77bd0669a5642dd0@mail.gmail.com>
X-Google-Sender-Auth: 74e44f7f2f832ed0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/06, Barry K. Nathan <barryn@pobox.com> wrote:
> This is 2.6.17-rc5-mm3 + the 3 ns83820 patches. I have no idea what I
> did to cause this to happen (i.e. it claims that mv is the culprit,
> but I don't think I was running mv myself -- I guess it was spawned by
> another process, but I have *no* idea what would have done it). I'm
> including the full dmesg.

Ok, I got another similar-looking one, with 2.6.17-rc5-mm3 plus
lockdep-combo and lockdep-tracer. (Again, the full dmesg is at the
bottom of this message.) This time I know what I was doing. The
reiser4 filesystem was being served using Samba, and I mounted it from
another Linux box using cifs. I was copying a single, large
(multi-hundred-MB) file from the cifs client to the Samba server.
However, the morning cronjobs were probably running at the same time.
Anyway, my gut feeling is that I will be able to reproduce this easily
(although I haven't tried again yet).

The /proc/latency_trace, in case it helps, is here:
http://members.cox.net/barrykn/linux/trace/latency_trace_reiser4-2.bz2

It's about the same size as the previous latency_trace (both
compressed and decompressed).

BTW, I also tried 2.6.17-rc5-mm3 (with no other patches) on another
box of mine, running Ubuntu Dapper Drake. (It was installed with one
of the flights but has been updated to the final release.) It got hit
with a flood of scheduling-while-atomic BUGs when either suspending to
disk or resuming, and eth0 didn't come back up automatically as usual
-- I had to manually modprobe r8169 and then run
"/etc/init.d/networking restart" to get to the outside world again. I
might not be able to provide a more detailed report on this box for
another day or two.
-- 
-Barry K. Nathan <barryn@pobox.com>

[    0.000000] Linux version 2.6.17-rc5-mm3-lockdep (barryn@nserv)
(gcc version 4.1.1) #1 Sun Jun 4 05:47:13 PDT 2006
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
[    0.000000] copy_e820_map() start: 00000000ffff0000 size:
0000000000010000 end: 0000000100000000 type: 2
[    0.000000] add_memory_region(00000000ffff0000, 0000000000010000, 2)
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
[    0.000000]  BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] 511MB LOWMEM available.
[    0.000000] On node 0 totalpages: 131056
[    0.000000]   DMA zone: 4096 pages, LIFO batch:0
[    0.000000]   Normal zone: 126960 pages, LIFO batch:31
[    0.000000] DMI 2.3 present.
[    0.000000] ACPI: RSDP (v000 AMI
) @ 0x000fa8f0
[    0.000000] ACPI: RSDT (v001 AMIINT          0x00000010 MSFT
0x00000097) @ 0x1fff0000
[    0.000000] ACPI: FADT (v001 AMIINT          0x00000010 MSFT
0x00000097) @ 0x1fff0030
[    0.000000] ACPI: DSDT (v001 AMD75X IRONGATE 0x00001000 MSFT
0x0100000b) @ 0x00000000
[    0.000000] Allocating PCI resources starting at 30000000 (gap:
20000000:dfff0000)
[    0.000000] Detected 805.703 MHz processor.
[   76.535150] Built 1 zonelists
[   76.535189] Kernel command line: BOOT_IMAGE=bzimage lapic
root=/dev/sdc1 vga=6
[   76.540794] Local APIC disabled by BIOS -- reenabling.
[   76.540848] Found and enabled local APIC!
[   76.540896] mapped APIC to ffffd000 (fee00000)
[   76.540952] Enabling fast FPU save and restore... done.
[   76.541019] Initializing CPU#0
[   76.541506] CPU 0 irqstacks, hard=c0440000 soft=c043f000
[   76.541561] PID hash table entries: 2048 (order: 11, 8192 bytes)
[   76.544932] Console: colour VGA+ 80x60
[   76.549033] Lock dependency validator: Copyright (c) 2006 Red Hat,
Inc., Ingo Molnar
[   76.549273] ... MAX_LOCKDEP_SUBTYPES:    8
[   76.549428] ... MAX_LOCK_DEPTH:          30
[   76.549582] ... MAX_LOCKDEP_KEYS:        2048
[   76.549739] ... TYPEHASH_SIZE:           1024
[   76.549897] ... MAX_LOCKDEP_ENTRIES:     8192
[   76.550055] ... MAX_LOCKDEP_CHAINS:      8192
[   76.550215] ... CHAINHASH_SIZE:          4096
[   76.550372]  memory used by lock dependency info: 696 kB
[   76.550536]  per task-struct memory footprint: 1080 bytes
[   76.550699] starting custom tracer.
[   76.550858] ------------------------
[   76.551012] | Locking API testsuite:
[   76.551167] ----------------------------------------------------------------------------
[   76.551406]                                  | spin |wlock |rlock
|mutex | wsem | rsem |
[   76.551785]
--------------------------------------------------------------------------
[   76.552097]                      A-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.555608]                  A-B-B-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.559221]              A-B-B-C-C-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.563227]              A-B-C-A-B-C deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.567053]          A-B-B-C-C-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.571173]          A-B-C-D-B-D-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.575341]          A-B-C-D-B-C-D-A deadlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.579436]                     double unlock:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.582972]                  bad unlock order:  ok  |  ok  |  ok  |
 ok  |  ok  |  ok  |
[   76.586516]
--------------------------------------------------------------------------
[   76.586758]               recursive read-lock:             |  ok  |
            |  ok  |
[   76.588229]
--------------------------------------------------------------------------
[   76.588463]                 non-nested unlock:  ok  |  ok  |  ok  |  ok  |
[   76.590926]   ------------------------------------------------------------
[   76.591108]      hard-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   76.593023]      soft-irqs-on + irq-safe-A/12:  ok  |  ok  |  ok  |
[   76.594856]      hard-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   76.596658]      soft-irqs-on + irq-safe-A/21:  ok  |  ok  |  ok  |
[   76.598482]        sirq-safe-A => hirqs-on/12:  ok  |  ok  |  ok  |
[   76.600323]        sirq-safe-A => hirqs-on/21:  ok  |  ok  |  ok  |
[   76.602260]          hard-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   76.604064]          soft-safe-A + irqs-on/12:  ok  |  ok  |  ok  |
[   76.605908]          hard-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   76.607713]          soft-safe-A + irqs-on/21:  ok  |  ok  |  ok  |
[   76.609549]     hard-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   76.611588]     soft-safe-A + unsafe-B #1/123:  ok  |  ok  |  ok  |
[   76.613517]     hard-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   76.615419]     soft-safe-A + unsafe-B #1/132:  ok  |  ok  |  ok  |
[   76.617337]     hard-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   76.619248]     soft-safe-A + unsafe-B #1/213:  ok  |  ok  |  ok  |
[   76.621177]     hard-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   76.623177]     soft-safe-A + unsafe-B #1/231:  ok  |  ok  |  ok  |
[   76.625070]     hard-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   76.626916]     soft-safe-A + unsafe-B #1/312:  ok  |  ok  |  ok  |
[   76.628781]     hard-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   76.630668]     soft-safe-A + unsafe-B #1/321:  ok  |  ok  |  ok  |
[   76.632648]     hard-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   76.634562]     soft-safe-A + unsafe-B #2/123:  ok  |  ok  |  ok  |
[   76.636490]     hard-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   76.638387]     soft-safe-A + unsafe-B #2/132:  ok  |  ok  |  ok  |
[   76.640337]     hard-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   76.642356]     soft-safe-A + unsafe-B #2/213:  ok  |  ok  |  ok  |
[   76.644281]     hard-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   76.646175]     soft-safe-A + unsafe-B #2/231:  ok  |  ok  |  ok  |
[   76.648122]     hard-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   76.650013]     soft-safe-A + unsafe-B #2/312:  ok  |  ok  |  ok  |
[   76.652052]     hard-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   76.653938]     soft-safe-A + unsafe-B #2/321:  ok  |  ok  |  ok  |
[   76.655872]       hard-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   76.657795]       soft-irq lock-inversion/123:  ok  |  ok  |  ok  |
[   76.659723]       hard-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   76.661740]       soft-irq lock-inversion/132:  ok  |  ok  |  ok  |
[   76.663685]       hard-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   76.665599]       soft-irq lock-inversion/213:  ok  |  ok  |  ok  |
[   76.667557]       hard-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   76.669433]       soft-irq lock-inversion/231:  ok  |  ok  |  ok  |
[   76.671355]       hard-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   76.673369]       soft-irq lock-inversion/312:  ok  |  ok  |  ok  |
[   76.675316]       hard-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   76.677235]       soft-irq lock-inversion/321:  ok  |  ok  |  ok  |
[   76.679157]       hard-irq read-recursion/123:  ok  |
[   76.679950]       soft-irq read-recursion/123:  ok  |
[   76.680754]       hard-irq read-recursion/132:  ok  |
[   76.681667]       soft-irq read-recursion/132:  ok  |
[   76.682475]       hard-irq read-recursion/213:  ok  |
[   76.683275]       soft-irq read-recursion/213:  ok  |
[   76.684081]       hard-irq read-recursion/231:  ok  |
[   76.684869]       soft-irq read-recursion/231:  ok  |
[   76.685674]       hard-irq read-recursion/312:  ok  |
[   76.686456]       soft-irq read-recursion/312:  ok  |
[   76.687245]       hard-irq read-recursion/321:  ok  |
[   76.688023]       soft-irq read-recursion/321:  ok  |
[   76.688823] -------------------------------------------------------
[   76.688997] Good, all 210 testcases passed! |
[   76.689153] ---------------------------------
[   76.690197] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[   76.692043] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[   76.835269] Memory: 501872k/524224k available (1649k kernel code,
21764k reserved, 912k data, 164k init, 0k highmem)
[   76.835541] Checking if this processor honours the WP bit even in
supervisor mode... Ok.
[   76.981271] Calibrating delay using timer specific routine..
1630.05 BogoMIPS (lpj=8150286)
[   76.982966] Mount-cache hash table entries: 512
[   76.987564] CPU: After generic identify, caps: 0183fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
[   76.987783] CPU: After vendor identify, caps: 0183fbff c1c3fbff
00000000 00000000 00000000 00000000 00000000
[   76.988001] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[   76.988183] CPU: L2 Cache: 512K (64 bytes/line)
[   76.988335] CPU: After all inits, caps: 0183fbff c1c3fbff 00000000
00000420 00000000 00000000 00000000
[   76.988545] Intel machine check architecture supported.
[   76.988716] Intel machine check reporting enabled on CPU#0.
[   76.988901] Compat vDSO mapped to ffffe000.
[   76.989092] CPU: AMD Athlon(tm) Processor stepping 01
[   76.989401] Checking 'hlt' instruction... OK.
[   77.021381] SMP alternatives: switching to UP code
[   77.021540] Freeing SMP alternatives: 0k freed
[   77.070957] ACPI: setting ELCR to 0010 (from 0e00)
[   77.073064] lockdep: disabled NMI watchdog.
[   77.201147] spurious 8259A interrupt: IRQ7.
[   77.211879] NET: Registered protocol family 16
[   77.213689] ACPI: bus type pci registered
[   77.225846] PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
[   77.228501] Setting up standard PCI resources
[   77.246716] ACPI: Subsystem revision 20060310
[   77.368439] ACPI: Interpreter enabled
[   77.368609] ACPI: Using PIC for interrupt routing
[   77.386424] ACPI: PCI Root Bridge [PCI0] (0000:00)
[   77.386649] PCI: Probing PCI hardware (bus 00)
[   77.461011] Boot video device is 0000:01:05.0
[   77.462264] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[   77.544169] ACPI: Power Resource [URP1] (off)
[   77.547068] ACPI: Power Resource [URP2] (off)
[   77.549694] ACPI: Power Resource [FDDP] (off)
[   77.552692] ACPI: Power Resource [LPTP] (off)
[   77.565425] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10
11 12 14 15)
[   77.575014] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10
*11 12 14 15)
[   77.584216] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10
11 12 14 15)
[   77.593666] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11
12 14 15) *0, disabled.
[   77.597972] Linux Plug and Play Support v0.97 (c) Adam Belay
[   77.598827] pnp: PnP ACPI init
[   77.648262] pnp: PnP ACPI: found 8 devices
[   77.648443] PnPBIOS: Disabled by ACPI PNP
[   77.653805] SCSI subsystem initialized
[   77.655803] PCI: Using ACPI for IRQ routing
[   77.655964] PCI: If a device doesn't work, try "pci=routeirq".  If
it helps, post a report
[   77.682073] PCI: Bridge: 0000:00:01.0
[   77.682275]   IO window: 9000-9fff
[   77.682518]   MEM window: e7d00000-efdfffff
[   77.682734]   PREFETCH window: e3b00000-e3bfffff
[   77.683554] NET: Registered protocol family 2
[   77.771843] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   77.774955] TCP established hash table entries: 16384 (order: 8,
1376256 bytes)
[   77.812319] TCP bind hash table entries: 8192 (order: 7, 720896 bytes)
[   77.831296] TCP: Hash tables configured (established 16384 bind 8192)
[   77.831546] TCP reno registered
[   77.844893] Machine check exception polling timer started.
[   77.880040] Initializing Cryptographic API
[   77.880301] io scheduler noop registered
[   77.881456] io scheduler cfq registered (default)
[   77.883887] ACPI: Power Button (FF) [PWRF]
[   77.884205] ACPI: Sleep Button (FF) [SLPF]
[   77.884462] ACPI: Power Button (CM) [PWRB]
[   77.887221] isapnp: Scanning for PnP cards...
[   78.251873] isapnp: No Plug & Play device found
[   78.358986] Floppy drive(s): fd0 is 1.44M
[   78.373335] FDC 0 is a post-1991 82077
[   78.386355] libata version 1.30 loaded.
[   78.388082] pata_pdc2027x 0000:00:0a.0: version 0.74
[   78.393944] ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
[   78.394133] PCI: setting IRQ 11 as level-triggered
[   78.394184] ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKB] ->
GSI 11 (level, low) -> IRQ 11
[   78.496118] pata_pdc2027x 0000:00:0a.0: PLL input clock 17028 kHz
[   78.527655] ata1: PATA max UDMA/133 cmd 0xE08097C0 ctl 0xE0809FDA
bmdma 0xE0809000 irq 11
[   78.528764] ata2: PATA max UDMA/133 cmd 0xE08095C0 ctl 0xE0809DDA
bmdma 0xE0809008 irq 11
[   78.681066] ata1.00: cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69
86:3e01 87:4003 88:407f
[   78.681145] ata1.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48
[   78.682645] ata1.00: configured for UDMA/133
[   78.682815] scsi0 : pata_pdc2027x
[   78.840984] ata2.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469
86:3c01 87:4003 88:203f
[   78.841060] ata2.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48
[   78.842694] ata2.00: configured for UDMA/100
[   78.842859] scsi1 : pata_pdc2027x
[   78.848704]   Vendor: ATA       Model: Maxtor 6Y250P0    Rev: YAR4
[   78.851042]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   78.858736]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   78.861130]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   78.868271] sata_sil 0000:00:0d.0: version 1.0
[   78.874050] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[   78.874255] PCI: setting IRQ 10 as level-triggered
[   78.874308] ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKA] ->
GSI 10 (level, low) -> IRQ 10
[   78.874845] sata_sil 0000:00:0d.0: Applying R_ERR on DMA activate
FIS errata fix
[   78.876328] ata3: SATA max UDMA/100 cmd 0xE080E480 ctl 0xE080E48A
bmdma 0xE080E400 irq 10
[   78.877438] ata4: SATA max UDMA/100 cmd 0xE080E4C0 ctl 0xE080E4CA
bmdma 0xE080E408 irq 10
[   78.878493] ata5: SATA max UDMA/100 cmd 0xE080E680 ctl 0xE080E68A
bmdma 0xE080E600 irq 10
[   78.879554] ata6: SATA max UDMA/100 cmd 0xE080E6C0 ctl 0xE080E6CA
bmdma 0xE080E608 irq 10
[   79.249539] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   79.250836] ata3.00: cfg 49:2f00 82:7c6b 83:7f09 84:4003 85:7c69
86:3e01 87:4003 88:207f
[   79.250916] ata3.00: ATA-7, max UDMA/133, 585940320 sectors: LBA48
[   79.251092] ata3.00: applying bridge limits
[   79.252719] ata3.00: configured for UDMA/100
[   79.252881] scsi2 : sata_sil
[   79.619232] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   79.620859] ata4.00: cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469
86:3c01 87:4023 88:203f
[   79.620936] ata4.00: ATA-7, max UDMA/100, 781422768 sectors: LBA48
[   79.621108] ata4.00: applying bridge limits
[   79.623020] ata4.00: configured for UDMA/100
[   79.623185] scsi3 : sata_sil
[   79.988934] ata5: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[   79.990275] ata5.00: cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469
86:3e01 87:4003 88:203f
[   79.990350] ata5.00: ATA-6, max UDMA/100, 625142448 sectors: LBA48
[   79.990528] ata5.00: applying bridge limits
[   79.992177] ata5.00: configured for UDMA/100
[   79.992336] scsi4 : sata_sil
[   80.198745] ata6: SATA link down (SStatus 0 SControl 310)
[   80.198948] scsi5 : sata_sil
[   80.204337]   Vendor: ATA       Model: Maxtor 4A300J0    Rev: RAMB
[   80.206515]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   80.214517]   Vendor: ATA       Model: ST3400832A        Rev: 3.01
[   80.216702]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   80.224985]   Vendor: ATA       Model: WDC WD3200JB-00K  Rev: 08.0
[   80.227156]   Type:   Direct-Access                      ANSI SCSI
revision: 05
[   80.237964] SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
[   80.238870] sda: Write Protect is off
[   80.239039] sda: Mode Sense: 00 3a 00 00
[   80.240146] SCSI device sda: drive cache: write back
[   80.243111] SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
[   80.243940] sda: Write Protect is off
[   80.244099] sda: Mode Sense: 00 3a 00 00
[   80.245426] SCSI device sda: drive cache: write back
[   80.245611]  sda: unknown partition table
[   80.256731] sd 0:0:0:0: Attached scsi disk sda
[   80.260179] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   80.260912] sdb: Write Protect is off
[   80.261069] sdb: Mode Sense: 00 3a 00 00
[   80.262194] SCSI device sdb: drive cache: write back
[   80.265003] SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
[   80.265826] sdb: Write Protect is off
[   80.265982] sdb: Mode Sense: 00 3a 00 00
[   80.267291] SCSI device sdb: drive cache: write back
[   80.267472]  sdb: unknown partition table
[   80.285352] sd 1:0:0:0: Attached scsi disk sdb
[   80.288855] SCSI device sdc: 585940320 512-byte hdwr sectors (300001 MB)
[   80.289591] sdc: Write Protect is off
[   80.289746] sdc: Mode Sense: 00 3a 00 00
[   80.290850] SCSI device sdc: drive cache: write back
[   80.293698] SCSI device sdc: 585940320 512-byte hdwr sectors (300001 MB)
[   80.294522] sdc: Write Protect is off
[   80.294690] sdc: Mode Sense: 00 3a 00 00
[   80.296010] SCSI device sdc: drive cache: write back
[   80.296195]  sdc: sdc1
[   80.311462] sd 2:0:0:0: Attached scsi disk sdc
[   80.314639] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[   80.315380] sdd: Write Protect is off
[   80.315543] sdd: Mode Sense: 00 3a 00 00
[   80.316657] SCSI device sdd: drive cache: write back
[   80.319566] SCSI device sdd: 781422768 512-byte hdwr sectors (400088 MB)
[   80.320398] sdd: Write Protect is off
[   80.320550] sdd: Mode Sense: 00 3a 00 00
[   80.321844] SCSI device sdd: drive cache: write back
[   80.322036]  sdd: unknown partition table
[   80.349634] sd 3:0:0:0: Attached scsi disk sdd
[   80.352706] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   80.353444] sde: Write Protect is off
[   80.353597] sde: Mode Sense: 00 3a 00 00
[   80.354702] SCSI device sde: drive cache: write back
[   80.357583] SCSI device sde: 625142448 512-byte hdwr sectors (320073 MB)
[   80.358587] sde: Write Protect is off
[   80.358751] sde: Mode Sense: 00 3a 00 00
[   80.360080] SCSI device sde: drive cache: write back
[   80.360264]  sde: sde1 sde2
[   80.385363] sd 4:0:0:0: Attached scsi disk sde
[   80.389764] PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at
0x60,0x64 irq 1,12
[   80.394116] serio: i8042 AUX port at 0x60,0x64 irq 12
[   80.394449] serio: i8042 KBD port at 0x60,0x64 irq 1
[   80.406094] mice: PS/2 mouse device common for all mice
[   80.407876] NET: Registered protocol family 1
[   80.408210] Using IPI Shortcut mode
[   80.408443] Time: tsc clocksource has been installed.
[   80.412694] ACPI: (supports S0 S1 S4 S5)
[   80.415370] Freeing unused kernel memory: 164k freed
[   80.416526] Write protecting the kernel read-only data: 315k
[   80.487193] ReiserFS: sdc1: found reiserfs format "3.6" with standard journal
[   80.537005] input: AT Translated Set 2 keyboard as /class/input/input0
[   80.736743] logips2pp: Detected unknown logitech mouse model 0
[   81.273027] input: PS/2 Logitech Mouse as /class/input/input1
[   99.653150] ReiserFS: sdc1: using ordered data mode
[   99.686429] ReiserFS: sdc1: journal params: device sdc1, size 8192,
journal first block 18, max trans len 1024, max batch 900, max commit
age 30, max trans age 30
[   99.691304] ReiserFS: sdc1: checking transaction log (sdc1)
[   99.797532] ReiserFS: sdc1: Using r5 hash to sort names
[  110.888668] Real Time Clock Driver v1.12ac
[  114.404370] Linux Tulip driver version 1.1.13-NAPI (December 15, 2004)
[  114.413359] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 9
[  114.413559] PCI: setting IRQ 9 as level-triggered
[  114.413611] ACPI: PCI Interrupt 0000:00:0b.0[A] -> Link [LNKC] ->
GSI 9 (level, low) -> IRQ 9
[  114.447805] tulip0:  EEPROM default media type Autosense.
[  114.447986] tulip0:  Index #0 - Media MII (#11) described by a
21142 MII PHY (3) block.
[  114.454699] tulip0:  MII transceiver #1 config 1000 status 782d
advertising 01e1.
[  114.470799] eth0: Digital DS21143 Tulip rev 65 at 0001d000,
00:C0:F0:4A:0C:46, IRQ 9.
[  114.542173] pcnet32.c:v1.32 18.Mar.2006 tsbogend@alpha.franken.de
[  114.680479] NET: Registered protocol family 5
[  114.888557] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
[  114.892246] ACPI: PCI Interrupt 0000:00:09.0[A] -> Link [LNKA] ->
GSI 10 (level, low) -> IRQ 10
[  114.892872] eth1: ns83820.c: 0x22c: 00000000, subsystem: 0000:0000
[  114.920733] eth1: ns83820 v0.23: DP83820 v1.2: 00:4f:4a:00:13:5a
io=0xefffb000 irq=10 f=sg
[  116.447861] Loading Reiser4. See www.namesys.com for a description
of Reiser4.
[  156.772409] JFS: nTxBlock = 3923, nTxLock = 31389
[  177.328211] Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
[  181.900651] eth1: link now 1000 mbps, full duplex and up.
[  184.486739] 0000:00:0b.0: tulip_stop_rxtx() failed (CSR5 0xf0660000
CSR6 0xb20e2202)
[  184.486819] eth0: Setting full-duplex based on MII#1 link partner
capability of cde1.
[  206.152537] NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state
recovery directory
[  206.160050] NFSD: starting 90-second grace period
[  418.772720] (            smbd-932  |#0): new 342307229 us user-latency.
[  418.772909] stopped custom tracer.
[  418.773058]
[  418.773072] ======================================
[  418.773345] [ BUG: bad unlock ordering detected! ]
[  418.773505] --------------------------------------
[  418.773667] smbd/932 is trying to release lock (&mgr->tmgr_lock) at:
[  418.773964]  [<e09a7c3e>] try_capture+0x309/0x9b6 [reiser4]
[  418.774349] but the next lock to release is:
[  418.774503]  (&atom->alock){--..}, at: [<e09a7c02>]
try_capture+0x2cd/0x9b6 [reiser4]
[  418.775040]
[  418.775054] other info that might help us debug this:
[  418.775326] 3 locks held by smbd/932:
[  418.775480]  #0:  (&inode->i_mutex){--..}, at: [<c0299d58>]
mutex_lock+0xd/0xf
[  418.776037]  #1:  (&mgr->tmgr_lock){--..}, at: [<e09a7ad5>]
try_capture+0x1a0/0x9b6 [reiser4]
[  418.776643]  #2:  (&txnh->hlock){--..}, at: [<e09a7add>]
try_capture+0x1a8/0x9b6 [reiser4]
[  418.777261]
[  418.777275] stack backtrace:
[  418.779285]  [<c01032ab>] show_trace_log_lvl+0x64/0x125
[  418.779723]  [<c01038bd>] show_trace+0x1b/0x20
[  418.780133]  [<c0103914>] dump_stack+0x1f/0x24
[  418.780545]  [<c012f4b9>] lockdep_release+0x192/0x35e
[  418.782293]  [<c029b6dc>] _spin_unlock+0x19/0x27
[  418.784047]  [<e09a7c3e>] try_capture+0x309/0x9b6 [reiser4]
[  418.784832]  [<e09a214d>] longterm_lock_znode+0x2fc/0x415 [reiser4]
[  418.785337]  [<e09af864>] coord_by_handle+0x142/0xb76 [reiser4]
[  418.786144]  [<e09b03ac>] coord_by_key+0x55/0x5a [reiser4]
[  418.786920]  [<e09a3ca5>] insert_by_key+0x31/0x5c [reiser4]
[  418.787443]  [<e09bb75d>] write_sd_by_inode_common+0x117/0x502 [reiser4]
[  418.788644]  [<e09bbb75>] create_object_common+0x2d/0x37 [reiser4]
[  418.789774]  [<e09b8f37>] create_vfs_object+0x376/0x551 [reiser4]
[  418.790870]  [<e09b919b>] create_common+0x44/0x4b [reiser4]
[  418.791979]  [<c0167a6e>] vfs_create+0x67/0xad
[  418.795287]  [<c016a832>] open_namei+0x19b/0x6cd
[  418.798452]  [<c0158d64>] do_filp_open+0x2b/0x42
[  418.800948]  [<c0158ddc>] do_sys_open+0x61/0xef
[  418.803640]  [<c0158e9d>] sys_open+0x18/0x1a
[  418.806315]  [<c029b8cc>] syscall_call+0x7/0xb
