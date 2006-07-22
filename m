Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWGVXid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWGVXid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 19:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbWGVXid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 19:38:33 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:13777 "EHLO smurf.noris.de")
	by vger.kernel.org with ESMTP id S1750707AbWGVXic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 19:38:32 -0400
Date: Sun, 23 Jul 2006 01:36:38 +0200
To: linux-kernel@vger.kernel.org
Cc: ohnstul@us.ibm.com, akpm@osdl.org, torvalds@osdl.org, bunk@stusta.de,
       lethal@linux-sh.org, hirofumi@mail.parknet.co.jp
Subject: REGRESSION: the new i386 timer code fails to sync CPUs
Message-ID: <20060722233638.GC27566@kiste.smurf.noris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: Matthias Urlichs <smurf@smurf.noris.de>
X-Smurf-Spam-Score: 0.0 (/)
X-Smurf-Whitelist: +relay_from_hosts
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the change 5d0cf410e94b1f1ff852c3f210d22cc6c5a27ffa
    [PATCH] Time: i386 Clocksource Drivers

    Implement the time sources for i386 (acpi_pm, cyclone, hpet, pit, and tsc).
    With this patch, the conversion of the i386 arch to the generic timekeeping
    code should be complete.

    The patch should be fairly straight forward, only adding the new clocksources.

causes the clocks of the two CPUs in my dual-Xeon server to lose
(or, maybe, never gain) sync.

Before this change, they're in sync; afterwards, they're not.

This is a problem because, as soon as the system decides to switch CPUs
while a program is sleeping (which happens quite early during boot-up),
that sleep takes a *long* time. :-/

Checked by simply running "date" repeatedly. Thanks to Linux' superb
scheduler, this command reliably runs on alternate CPUs, thereby
demonstrating the problem, and I didn't have to resort to "taskset".


Boot log:

Linux version 2.6.17-test-1.29 (root@kiste) (gcc version 4.0.3 (Ubuntu 4.0.3-1ubuntu5)) #1 SMP PREEMPT Sun Jul 23 01:05:35 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009b000 (usable)
 BIOS-e820: 000000000009b000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ca000 - 00000000000cc000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000d7f70000 (usable)
 BIOS-e820: 00000000d7f70000 - 00000000d7f7b000 (ACPI data)
 BIOS-e820: 00000000d7f7b000 - 00000000d7f80000 (ACPI NVS)
 BIOS-e820: 00000000d7f80000 - 00000000d8000000 (reserved)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 00000000fec10000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000128000000 (usable)
Warning only 4GB will be used.
Use a PAE enabled kernel.
3200MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f6700
On node 0 totalpages: 1048576
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 819200 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6750
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0xd7f75ea1
ACPI: FADT (v001 INTEL  TUMWATER 0x06040000 PTL  0x00000003) @ 0xd7f7ae35
ACPI: MADT (v001 PTLTD  	 APIC   0x06040000  LTP 0x00000000) @ 0xd7f7aea9
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0xd7f7af39
ACPI: MCFG (v001 PTLTD  	 Mcfg   0x06040000  LTP 0x00000000) @ 0xd7f7af61
ACPI: ASF! (v016   CETP     CETP 0x06040000 PTL  0x00000001) @ 0xd7f7af9d
ACPI: SSDT (v001  PmRef    CpuPm 0x00003000 INTL 0x20030224) @ 0xd7f75edd
ACPI: DSDT (v001  Intel Lindhrst 0x06040000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x06] enabled)
Processor #6 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Processor #7 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfec10000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 32, address 0xfec10000, GSI 24-47
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:0ec00000)
Detected 3000.352 MHz processor.
Built 1 zonelists.  Total pages: 1048576
Kernel command line: root=/dev/md1 ro break
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
mapped IOAPIC to ffffb000 (fec10000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3483476k/4194304k available (1724k kernel code, 53692k reserved, 982k data, 204k init, 2620864k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6004.95 BogoMIPS (lpj=12009905)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
Checking 'hlt' instruction... OK.
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060608
CPU0: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 1/1 eip 2000
Initializing CPU#1
Calibrating delay using timer specific routine.. 6000.73 BogoMIPS (lpj=12001474)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (24) available
CPU1: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 2/6 eip 2000
Initializing CPU#2
Calibrating delay using timer specific routine.. 5600.72 BogoMIPS (lpj=11201446)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (24) available
CPU2: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Booting processor 3/7 eip 2000
Initializing CPU#3
Calibrating delay using timer specific routine.. 5600.70 BogoMIPS (lpj=11201416)
CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 20100000 00000000 00000000 0000641d 00000000 00000000
monitor/mwait feature present.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU: Physical Processor ID: 3
CPU: After all inits, caps: bfebfbff 20100000 00000000 00000180 0000641d 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (24) available
CPU3: Intel(R) Xeon(TM) CPU 3.00GHz stepping 03
Total of 4 processors activated (23207.12 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 4 CPUs: 
Brought up 4 CPUs
migration_cost=93,1739
checking if image is initramfs... it is
Freeing initrd memory: 4192k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:03.0
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIX._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCIB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 4 5 6 7 10 11 14 15) *3
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *10 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 4 5 6 7 *10 11 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: da100000-da1fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:03.0
  IO window: disabled.
  MEM window: da200000-da2fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.0
  IO window: 2000-2fff
  MEM window: da300000-da3fffff
  PREFETCH window: de000000-dfffffff
PCI: Bridge: 0000:05:04.0
  IO window: 4000-4fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:02.0
  IO window: 4000-4fff
  MEM window: dc000000-dc0fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: 3000-4fff
  MEM window: da400000-dc0fffff
  PREFETCH window: f1000000-f10fffff
ACPI: PCI Interrupt 0000:00:02.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:02.0 to 64
ACPI: PCI Interrupt 0000:00:03.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:03.0 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 131072 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 8, 1572864 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Simple Boot Flag at 0x36 set to 0x1
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 204k freed
Time: tsc clocksource has been installed.


.config file (trimmed: anything not mentioned is turned off):

CONFIG_X86_32=y
CONFIG_GENERIC_TIME=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_EMBEDDED=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SLAB=y
CONFIG_TINY_SHMEM=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_DEFAULT_NOOP=y
CONFIG_DEFAULT_IOSCHED="noop"
CONFIG_SMP=y
CONFIG_X86_PC=y
CONFIG_MPENTIUMIII=y
CONFIG_X86_GENERIC=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_NR_CPUS=4
CONFIG_SCHED_SMT=y
CONFIG_SCHED_MC=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_EDD=m
CONFIG_HIGHMEM4G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MTRR=y
CONFIG_IRQBALANCE=y
CONFIG_REGPARM=y
CONFIG_SECCOMP=y
CONFIG_HZ_250=y
CONFIG_HZ=250
CONFIG_PHYSICAL_START=0x100000
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_VIDEO=m
CONFIG_ACPI_FAN=m
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_SYSTEM=y
CONFIG_X86_PM_TIMER=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_MSI=y
CONFIG_ISA_DMA_API=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_UNIX=y
CONFIG_NETWORK_SECMARK=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_PCI=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_GEN_RTC=m
CONFIG_GEN_RTC_X=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_VIDEO_V4L2=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_FIRMWARE_EDID=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_FB_VESA=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_VGACON_SOFT_SCROLLBACK=y
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_DMA_ENGINE=y
CONFIG_NET_DMA=y
CONFIG_INTEL_IOATDMA=m
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
CONFIG_INOTIFY_USER=y
CONFIG_DNOTIFY=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_CRAMFS=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_SLAB_LEAK=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_VM=y
CONFIG_FRAME_POINTER=y
CONFIG_UNWIND_INFO=y
CONFIG_FORCED_INLINING=y
CONFIG_EARLY_PRINTK=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_STACK_USAGE=y
CONFIG_STACK_BACKTRACE_COLS=2
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_RODATA=y
CONFIG_4KSTACKS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_ARC4=m
CONFIG_CRC_CCITT=m
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_PENDING_IRQ=y
CONFIG_X86_SMP=y
CONFIG_X86_HT=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_TRAMPOLINE=y
CONFIG_KTIME_SCALAR=y

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You are tricky, but never to the point of dishonesty.
