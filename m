Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbTE3G0z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 02:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTE3G0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 02:26:55 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.131.34]:51383 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S263298AbTE3G0p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 02:26:45 -0400
Date: Fri, 30 May 2003 02:40:02 -0400
From: Scott McDermott <vaxerdec@frontiernet.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-rc5-ac2, kernel BUG at ide-iops.c:1262 (burning CD on IBM T30)
Message-ID: <20030530024002.A11224@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While trying to use xcdroast with my IBM T30's CD-RW drive, I get about
99% done, then there is a long pause, followed by:

    scsi: aborting command due to timeout: pid 2581, scsi0, channel 0, id0, lun 0 Test Unit Ready 00 00 00 00 00
    SCSI host 0 abort (pid 2581) timed out - resetting
    SCSI bus is being reset for host 0 channel 0.

then I get blinking LEDs and the machine locks up (although sysrq
appears to still work)

the following BUG is emitted on the console:

    Code: 0f 0b ee 04 9e 64 26 c0 80 bf fd 00 00 00 20 74 0c 8b 74 24
     <0>Kernel panic: Aiee, killing interrupt handler!
    In interrupt handler - not syncing

    ksymoops 2.4.9 on i686 2.4.21+rc5+ac2+benh-041103.  Options used
         -V (default)
         -k /proc/ksyms (default)
         -l /proc/modules (default)
         -o /lib/modules/2.4.21+rc5+ac2+benh-041103/ (default)
         -m /usr/src/linux/System.map (specified)

    kernel BUG at ide-iops.c:1262!
    invalid operand: 0000
    CPU:    0
    EIP:    0010:[<c01c8d94>]       Not tainted
    Using defaults from ksymoops -t elf32-i386 -a i386
    EFLAGS: 00010086
    eax: e1873660   ebx: 00000000   ecx: 00000032   edx: 00000002
    esi: deb3c600   edi: c02fe20c   ebp: c02fe16c   esp: c02bfec4
    ds: 0018   es: 0018   ss: 0018
    Process swapper (pid: 0, stackpage=c02bf000)
    Stack: 00000046 0000002e 00000086 deb3c600 c1594280 00000082 00000000 deb3c600
           00000000 debc7500 c01c8f97 c02f320c 00000000 e18748c9 c02fe20c e185ef5d
           deb3c600 00000002 00000000 deb3c600 00000286 fffffffe 00000046 e185e3d5
    Call Trace:    [<c01c8f97>] [<e18748c9>] [<e185ef5d>] [<e185e3d5>] [<e185e360>]
      [<c01214cb>] [<c011d0e2>] [<c011cff6>] [<c011ce35>] [<c02089ee>] [<c0105350>]
      [<c0105000>] [<c010b058>] [<c0105350>] [<c0105350>] [<c0105000>] [<c0105373>]
      [<c01053d4>]
    Code: 0f 0b ee 04 9e 64 26 c0 80 bf fd 00 00 00 20 74 0c 8b 74 24


    >>EIP; c01c8d94 <do_reset1+24/210>   <=====

    >>eax; e1873660 <[ide-scsi]idescsi_pc_intr+0/360>
    >>esi; deb3c600 <_end+1e82f7b0/204f8210>
    >>edi; c02fe20c <ide_hwifs+50c/2b98>
    >>ebp; c02fe16c <ide_hwifs+46c/2b98>
    >>esp; c02bfec4 <init_task_union+1ec4/2000>

    Trace; c01c8f97 <ide_do_reset+17/20>
    Trace; e18748c9 <[ide-scsi]idescsi_reset+19/20>
    Trace; e185ef5d <[scsi_mod]scsi_reset+fd/350>
    Trace; e185e3d5 <[scsi_mod]scsi_old_times_out+75/140>
    Trace; e185e360 <[scsi_mod]scsi_old_times_out+0/140>
    Trace; c01214cb <run_timer_list+10b/170>
    Trace; c011d0e2 <bh_action+22/40>
    Trace; c011cff6 <tasklet_hi_action+46/70>
    Trace; c011ce35 <do_softirq+95/a0>
    Trace; c02089ee <netlink_set_err+6e/70>
    Trace; c0105350 <default_idle+0/40>
    Trace; c0105000 <_stext+0/0>
    Trace; c010b058 <call_do_IRQ+5/d>
    Trace; c0105350 <default_idle+0/40>
    Trace; c0105350 <default_idle+0/40>
    Trace; c0105000 <_stext+0/0>
    Trace; c0105373 <default_idle+23/40>
    Trace; c01053d4 <cpu_idle+24/30>

    Code;  c01c8d94 <do_reset1+24/210>
    00000000 <_EIP>:
    Code;  c01c8d94 <do_reset1+24/210>   <=====
       0:   0f 0b                     ud2a      <=====
    Code;  c01c8d96 <do_reset1+26/210>
       2:   ee                        out    %al,(%dx)
    Code;  c01c8d97 <do_reset1+27/210>
       3:   04 9e                     add    $0x9e,%al
    Code;  c01c8d99 <do_reset1+29/210>
       5:   64 26 c0 80 bf fd 00      rolb   $0x0,%es:%fs:0xfdbf(%eax)
    Code;  c01c8da0 <do_reset1+30/210>
       c:   00 00 
    Code;  c01c8da2 <do_reset1+32/210>
       e:   20 74 0c 8b               and    %dh,0xffffff8b(%esp,%ecx,1)
    Code;  c01c8da6 <do_reset1+36/210>
      12:   74 24                     je     38 <_EIP+0x38>

     <0>Kernel panic: Aiee, killing interrupt handler!

here is dmesg output on this machine:

    Linux version 2.4.21+rc5+ac2+benh-041103 (smcdermott@newlaptop.localdomain) (gcc version 3.2.2 20030222 (Red Hat Linux 3.2.2-5)) #2 Fri May 30 01:54:19 EDT 2003
    BIOS-provided physical RAM map:
     BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
     BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
     BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
     BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
     BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
     BIOS-e820: 000000001ff60000 - 000000001ff7a000 (ACPI data)
     BIOS-e820: 000000001ff7a000 - 000000001ff7c000 (ACPI NVS)
     BIOS-e820: 000000001ff7c000 - 0000000020000000 (reserved)
     BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
    511MB LOWMEM available.
    ACPI: have wakeup address 0xc0001000
    On node 0 totalpages: 130912
    zone(0): 4096 pages.
    zone(1): 126816 pages.
    zone(2): 0 pages.
    ACPI: RSDP (v002 IBM                        ) @ 0x000f7000
    ACPI: XSDT (v001 IBM    TP-1I    00000.08226) @ 0x1ff6f3a4
    ACPI: FADT (v001 IBM    TP-1I    00000.08226) @ 0x1ff6f3f0
    ACPI: SSDT (v001 IBM    TP-1I    00000.08226) @ 0x1ff6f4a4
    ACPI: ECDT (v001 IBM    TP-1I    00000.08226) @ 0x1ff79f55
    ACPI: TCPA (v001 IBM    TP-1I    00000.08226) @ 0x1ff79fa6
    ACPI: BOOT (v001 IBM    TP-1I    00000.08226) @ 0x1ff79fd8
    ACPI: DSDT (v001 IBM    TP-1I    00000.08226) @ 0x00000000
    ACPI: BIOS passes blacklist
    IBM machine detected. Enabling interrupts during APM calls.
    Kernel command line: ro root=/dev/hda2 video=radeon:1280x1024-32@85,font:SUN12x22 hdc=ide-scsi
    ide_setup: hdc=ide-scsi
    Initializing CPU#0
    Detected 1794.233 MHz processor.
    Console: colour VGA+ 80x25
    Calibrating delay loop... 3578.26 BogoMIPS
    Memory: 515484k/523648k available (1281k kernel code, 7776k reserved, 498k data, 96k init, 0k highmem)
    Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
    Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
    Mount cache hash table entries: 512 (order: 0, 4096 bytes)
    Buffer cache hash table entries: 32768 (order: 5, 131072 bytes)
    Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
    CPU: Trace cache: 12K uops, L1 D cache: 8K
    CPU: L2 cache: 512K
    Intel machine check architecture supported.
    Intel machine check reporting enabled on CPU#0.
    CPU:     After generic, caps: bfebf9ff 00000000 00000000 00000000
    CPU:             Common caps: bfebf9ff 00000000 00000000 00000000
    CPU: Intel Mobile Intel(R) Pentium(R) 4 - M CPU 1.80GHz stepping 07
    Enabling fast FPU save and restore... done.
    Enabling unmasked SIMD FPU exception support... done.
    Checking 'hlt' instruction... OK.
    POSIX conformance testing by UNIFIX
    mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
    mtrr: detected mtrr type: Intel
    ACPI: Subsystem revision 20030509
    PCI: PCI BIOS revision 2.10 entry at 0xfd8fe, last bus=8
    PCI: Using configuration type 1
    ACPI: Found ECDT
    ACPI: Could not use ECDT
    PCI: Probing PCI hardware
    PCI: ACPI tables contain no PCI IRQ routing entries
    PCI: Probing PCI hardware (bus 00)
    PCI: Ignoring BAR0-3 of IDE controller 00:1f.1
    Transparent bridge - Intel Corp. 82801BAM/CAM PCI Bridge
    PCI: Discovered primary peer bus 09 [IRQ]
    PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
    PCI: Found IRQ 11 for device 00:1f.1
    PCI: Sharing IRQ 11 with 00:1d.2
    Linux NET4.0 for Linux 2.4
    Based upon Swansea University Computer Society NET3.039
    Initializing RT netlink socket
    cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available
    Starting kswapd
    VFS: Disk quotas vdquot_6.5.1
    Journalled Block Device driver loaded
    PCI: Found IRQ 11 for device 01:00.0
    PCI: Sharing IRQ 11 with 00:1d.0
    PCI: Sharing IRQ 11 with 02:00.0
    radeonfb: ref_clk=2700, ref_div=12, xclk=18300 from BIOS
    radeonfb: panel ID string: SXGA+ Single (85MHz)    
    radeonfb: detected LCD panel size from BIOS: 1400x1050
    Console: switching to colour frame buffer device 106x46
    radeonfb: ATI Radeon M7 LW DDR SGRAM 16 MB
    radeonfb: DVI port LCD monitor connected
    radeonfb: CRT port no monitor connected
    pty: 256 Unix98 ptys configured
    Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
    ttyS00 at 0x03f8 (irq = 4) is a 16550A
    PCI: Found IRQ 5 for device 00:1f.6
    PCI: Sharing IRQ 5 with 00:1f.3
    PCI: Sharing IRQ 5 with 00:1f.5
    PCI: Sharing IRQ 5 with 02:00.1
    Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
    ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
    ICH3M: IDE controller at PCI slot 00:1f.1
    PCI: Enabling device 00:1f.1 (0005 -> 0007)
    PCI: Found IRQ 11 for device 00:1f.1
    PCI: Sharing IRQ 11 with 00:1d.2
    ICH3M: chipset revision 2
    ICH3M: not 100% native mode: will probe irqs later
        ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
        ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
    hda: IC25N040ATCS05-0, ATA DISK drive
    blk: queue c02fddc0, I/O limit 4095Mb (mask 0xffffffff)
    hdc: HL-DT-STCD-RW/DVD DRIVE GCC-4240N, ATAPI CD/DVD-ROM drive
    ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
    ide1 at 0x170-0x177,0x376 on irq 15
    hda: attached ide-disk driver.
    hda: host protected area => 1
    hda: 78140160 sectors (40008 MB) w/7898KiB Cache, CHS=5168/240/63, UDMA(100)
    Partition check:
     hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
    md: raid1 personality registered as nr 3
    md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
    md: Autodetecting RAID arrays.
    md: autorun ...
    md: ... autorun DONE.
    NET4: Linux TCP/IP 1.0 for NET4.0
    IP Protocols: ICMP, UDP, TCP, IGMP
    IP: routing cache hash table of 4096 buckets, 32Kbytes
    TCP: Hash tables configured (established 32768 bind 65536)
    NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
    EXT3-fs: INFO: recovery required on readonly filesystem.
    EXT3-fs: write access will be enabled during recovery.
    kjournald starting.  Commit interval 5 seconds
    EXT3-fs: recovery complete.
    EXT3-fs: mounted filesystem with ordered data mode.
    VFS: Mounted root (ext3 filesystem) readonly.
    Freeing unused kernel memory: 96k freed
    Real Time Clock Driver v1.10e
    EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,2), internal journal
    LVM version 1.0.5+(22/07/2002) module loaded
    loop: loaded (max 8 devices)
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,4), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,1), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,0), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,2), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    kjournald starting.  Commit interval 5 seconds
    EXT3 FS 2.4-0.9.19, 19 August 2002 on lvm(58,3), internal journal
    EXT3-fs: mounted filesystem with ordered data mode.
    SCSI subsystem driver Revision: 1.00
    hdc: attached ide-scsi driver.
    scsi0 : SCSI host adapter emulation for IDE ATAPI devices
      Vendor: HL-DT-ST  Model: RW/DVD GCC-4240N  Rev: 0211
      Type:   CD-ROM                             ANSI SCSI revision: 02
    IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
    microcode: CPU0 no microcode found! (sig=f27, pflags=8)
    Intel(R) PRO/100 Network Driver - version 2.2.21-k1
    Copyright (c) 2003 Intel Corporation

    PCI: Found IRQ 11 for device 02:08.0
    e100: selftest OK.
    e100: eth0: Intel(R) PRO/100 Network Connection
      Hardware receive checksums enabled

and kernel config:

    CONFIG_X86=y
    CONFIG_UID16=y
    CONFIG_EXPERIMENTAL=y
    CONFIG_MODULES=y
    CONFIG_KMOD=y
    CONFIG_MPENTIUM4=y
    CONFIG_X86_WP_WORKS_OK=y
    CONFIG_X86_INVLPG=y
    CONFIG_X86_CMPXCHG=y
    CONFIG_X86_XADD=y
    CONFIG_X86_BSWAP=y
    CONFIG_X86_POPAD_OK=y
    CONFIG_RWSEM_XCHGADD_ALGORITHM=y
    CONFIG_X86_L1_CACHE_SHIFT=7
    CONFIG_X86_HAS_TSC=y
    CONFIG_X86_GOOD_APIC=y
    CONFIG_X86_PGE=y
    CONFIG_X86_USE_PPRO_CHECKSUM=y
    CONFIG_X86_F00F_WORKS_OK=y
    CONFIG_X86_MCE=y
    CONFIG_CPU_FREQ=y
    CONFIG_CPU_FREQ_24_API=y
    CONFIG_X86_P4_CLOCKMOD=y
    CONFIG_MICROCODE=m
    CONFIG_X86_CPUID=m
    CONFIG_EDD=m
    CONFIG_NOHIGHMEM=y
    CONFIG_MTRR=y
    CONFIG_X86_TSC=y
    CONFIG_NET=y
    CONFIG_PCI=y
    CONFIG_PCI_GOANY=y
    CONFIG_PCI_BIOS=y
    CONFIG_PCI_DIRECT=y
    CONFIG_PCI_NAMES=y
    CONFIG_HOTPLUG=y
    CONFIG_PCMCIA=m
    CONFIG_CARDBUS=y
    CONFIG_SYSVIPC=y
    CONFIG_BSD_PROCESS_ACCT=y
    CONFIG_SYSCTL=y
    CONFIG_KCORE_ELF=y
    CONFIG_BINFMT_AOUT=m
    CONFIG_BINFMT_ELF=y
    CONFIG_BINFMT_MISC=m
    CONFIG_IKCONFIG=y
    CONFIG_PM=y
    CONFIG_ACPI=y
    CONFIG_ACPI_BOOT=y
    CONFIG_ACPI_BUS=y
    CONFIG_ACPI_INTERPRETER=y
    CONFIG_ACPI_EC=y
    CONFIG_ACPI_POWER=y
    CONFIG_ACPI_PCI=y
    CONFIG_ACPI_SLEEP=y
    CONFIG_ACPI_SYSTEM=y
    CONFIG_ACPI_AC=y
    CONFIG_ACPI_BATTERY=y
    CONFIG_ACPI_BUTTON=y
    CONFIG_ACPI_FAN=y
    CONFIG_ACPI_PROCESSOR=y
    CONFIG_ACPI_THERMAL=y
    CONFIG_PARPORT=m
    CONFIG_PARPORT_PC=m
    CONFIG_PARPORT_PC_CML1=m
    CONFIG_PARPORT_PC_FIFO=y
    CONFIG_PARPORT_1284=y
    CONFIG_BLK_DEV_FD=m
    CONFIG_PARIDE=m
    CONFIG_PARIDE_PARPORT=m
    CONFIG_PARIDE_PD=m
    CONFIG_PARIDE_PCD=m
    CONFIG_PARIDE_PF=m
    CONFIG_PARIDE_PT=m
    CONFIG_PARIDE_PG=m
    CONFIG_BLK_DEV_LOOP=m
    CONFIG_BLK_DEV_NBD=m
    CONFIG_BLK_DEV_RAM=m
    CONFIG_BLK_DEV_RAM_SIZE=4096
    CONFIG_BLK_STATS=y
    CONFIG_MD=y
    CONFIG_BLK_DEV_MD=y
    CONFIG_MD_RAID1=y
    CONFIG_BLK_DEV_LVM=m
    CONFIG_PACKET=m
    CONFIG_PACKET_MMAP=y
    CONFIG_NETLINK_DEV=m
    CONFIG_FILTER=y
    CONFIG_UNIX=y
    CONFIG_INET=y
    CONFIG_IP_MULTICAST=y
    CONFIG_NET_IPIP=m
    CONFIG_NET_IPGRE=m
    CONFIG_INET_ECN=y
    CONFIG_SYN_COOKIES=y
    CONFIG_NET_SCHED=y
    CONFIG_NET_QOS=y
    CONFIG_NET_CLS=y
    CONFIG_NET_CLS_POLICE=y
    CONFIG_NET_PKTGEN=m
    CONFIG_IDE=y
    CONFIG_BLK_DEV_IDE=y
    CONFIG_BLK_DEV_IDEDISK=y
    CONFIG_IDEDISK_MULTI_MODE=y
    CONFIG_BLK_DEV_IDECS=m
    CONFIG_BLK_DEV_IDECD=m
    CONFIG_BLK_DEV_IDEFLOPPY=m
    CONFIG_BLK_DEV_IDESCSI=m
    CONFIG_BLK_DEV_IDEPCI=y
    CONFIG_BLK_DEV_GENERIC=y
    CONFIG_IDEPCI_SHARE_IRQ=y
    CONFIG_BLK_DEV_IDEDMA_PCI=y
    CONFIG_IDEDMA_PCI_AUTO=y
    CONFIG_BLK_DEV_IDEDMA=y
    CONFIG_BLK_DEV_PIIX=y
    CONFIG_IDEDMA_AUTO=y
    CONFIG_BLK_DEV_IDE_MODES=y
    CONFIG_SCSI=m
    CONFIG_BLK_DEV_SR=m
    CONFIG_SR_EXTRA_DEVS=6
    CONFIG_CHR_DEV_SG=m
    CONFIG_SCSI_DEBUG_QUEUES=y
    CONFIG_SCSI_MULTI_LUN=y
    CONFIG_SCSI_CONSTANTS=y
    CONFIG_SCSI_PPA=m
    CONFIG_SCSI_IMM=m
    CONFIG_SCSI_PCMCIA=y
    CONFIG_I2O=m
    CONFIG_I2O_PROC=m
    CONFIG_NETDEVICES=y
    CONFIG_DUMMY=m
    CONFIG_TUN=m
    CONFIG_ETHERTAP=m
    CONFIG_NET_ETHERNET=y
    CONFIG_NET_PCI=y
    CONFIG_EEPRO100=m
    CONFIG_E100=m
    CONFIG_PPP=m
    CONFIG_PPP_ASYNC=m
    CONFIG_PPP_DEFLATE=m
    CONFIG_PPP_BSDCOMP=m
    CONFIG_NET_PCMCIA=y
    CONFIG_PCMCIA_3C589=m
    CONFIG_PCMCIA_3C574=m
    CONFIG_INPUT=m
    CONFIG_INPUT_KEYBDEV=m
    CONFIG_INPUT_MOUSEDEV=m
    CONFIG_INPUT_MOUSEDEV_SCREEN_X=1400
    CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1050
    CONFIG_INPUT_JOYDEV=m
    CONFIG_INPUT_EVDEV=m
    CONFIG_VT=y
    CONFIG_VT_CONSOLE=y
    CONFIG_SERIAL=y
    CONFIG_SERIAL_CONSOLE=y
    CONFIG_UNIX98_PTYS=y
    CONFIG_UNIX98_PTY_COUNT=256
    CONFIG_PRINTER=m
    CONFIG_LP_CONSOLE=y
    CONFIG_I2C=m
    CONFIG_I2C_ALGOBIT=m
    CONFIG_SCx200_ACB=m
    CONFIG_I2C_CHARDEV=m
    CONFIG_I2C_PROC=m
    CONFIG_MOUSE=y
    CONFIG_PSMOUSE=y
    CONFIG_WATCHDOG=y
    CONFIG_I810_TCO=m
    CONFIG_SOFT_WATCHDOG=m
    CONFIG_INTEL_RNG=m
    CONFIG_NVRAM=m
    CONFIG_RTC=m
    CONFIG_AGP=m
    CONFIG_AGP_INTEL=y
    CONFIG_AGP_I810=y
    CONFIG_DRM=y
    CONFIG_DRM_NEW=y
    CONFIG_DRM_RADEON=m
    CONFIG_PCMCIA_SERIAL_CS=m
    CONFIG_MWAVE=m
    CONFIG_QUOTA=y
    CONFIG_QFMT_V2=m
    CONFIG_AUTOFS4_FS=m
    CONFIG_REISERFS_FS=m
    CONFIG_REISERFS_PROC_INFO=y
    CONFIG_EXT3_FS=y
    CONFIG_JBD=y
    CONFIG_FAT_FS=m
    CONFIG_MSDOS_FS=m
    CONFIG_VFAT_FS=m
    CONFIG_CRAMFS=m
    CONFIG_TMPFS=y
    CONFIG_RAMFS=y
    CONFIG_ISO9660_FS=m
    CONFIG_JOLIET=y
    CONFIG_ZISOFS=y
    CONFIG_NTFS_FS=m
    CONFIG_PROC_FS=y
    CONFIG_DEVPTS_FS=y
    CONFIG_ROMFS_FS=m
    CONFIG_EXT2_FS=y
    CONFIG_NFS_FS=m
    CONFIG_NFS_V3=y
    CONFIG_NFS_DIRECTIO=y
    CONFIG_NFSD=m
    CONFIG_NFSD_V3=y
    CONFIG_NFSD_TCP=y
    CONFIG_SUNRPC=m
    CONFIG_LOCKD=m
    CONFIG_LOCKD_V4=y
    CONFIG_SMB_FS=m
    CONFIG_SMB_NLS_DEFAULT=y
    CONFIG_SMB_NLS_REMOTE="cp437"
    CONFIG_ZISOFS_FS=m
    CONFIG_PARTITION_ADVANCED=y
    CONFIG_MSDOS_PARTITION=y
    CONFIG_BSD_DISKLABEL=y
    CONFIG_LDM_PARTITION=y
    CONFIG_SMB_NLS=y
    CONFIG_NLS=y
    CONFIG_NLS_DEFAULT="iso8859-1"
    CONFIG_NLS_CODEPAGE_437=y
    CONFIG_NLS_ISO8859_1=y
    CONFIG_NLS_UTF8=y
    CONFIG_VGA_CONSOLE=y
    CONFIG_VIDEO_SELECT=y
    CONFIG_FB=y
    CONFIG_DUMMY_CONSOLE=y
    CONFIG_VIDEO_SELECT=y
    CONFIG_FB_RADEON=y
    CONFIG_FBCON_ADVANCED=y
    CONFIG_FBCON_CFB8=y
    CONFIG_FBCON_CFB16=y
    CONFIG_FBCON_CFB24=y
    CONFIG_FBCON_CFB32=y
    CONFIG_FBCON_FONTS=y
    CONFIG_FONT_8x8=y
    CONFIG_FONT_8x16=y
    CONFIG_FONT_SUN8x16=y
    CONFIG_FONT_SUN12x22=y
    CONFIG_SOUND=y
    CONFIG_SOUND_ICH=m
    CONFIG_USB=m
    CONFIG_USB_EHCI_HCD=m
    CONFIG_USB_UHCI_ALT=m
    CONFIG_USB_ACM=m
    CONFIG_USB_HID=m
    CONFIG_USB_HIDINPUT=y
    CONFIG_USB_HIDDEV=y
    CONFIG_USB_KBD=m
    CONFIG_USB_MOUSE=m
    CONFIG_USB_SERIAL=m
    CONFIG_USB_SERIAL_GENERIC=y
    CONFIG_DEBUG_KERNEL=y
    CONFIG_MAGIC_SYSRQ=y
    CONFIG_CRC32=m
    CONFIG_ZLIB_INFLATE=m
    CONFIG_ZLIB_DEFLATE=m

let me know if I can provide anything else that might be useful.
