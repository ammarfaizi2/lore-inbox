Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbUDIR4r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 13:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUDIR4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 13:56:47 -0400
Received: from prime.hereintown.net ([141.157.132.3]:32654 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S261528AbUDIR4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 13:56:04 -0400
Subject: 2.6.x oops on x86_64 server
From: Chris Meadors <clubneon@hereintown.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-OJL3/4CaupEqMAvh4NoF"
Message-Id: <1081533077.229.32.camel@clubneon.priv.hereintown.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Fri, 09 Apr 2004 13:51:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-OJL3/4CaupEqMAvh4NoF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ever since I put this server into production I've been seeing oops on
average once or twice a week.  During testing with the last of the 2.5
series, and the first two 2.6s, the machine seemed stable.  But the
first night live it oopsed.  While I did put a pretty good load on it
during testing, I think the real world is a bit more rough.  It sees
about 10 e-mails every second, and runs SpamAssassin and ClamAV on each.

I run just a plain kernel plus the current patch from
ftp://ftp.x86-64.org/pub/linux/v2.6/ .  I've tried without the x86_64
patch, and it still oopses just the same.

I've attatched the two most recent back traces that made it into the
syslog, the final oops doesn't make it to disk.  The backtraces are
always very similar, with the bad state in free_hot_cold_page and
prep_new_page. I've also included my current config that the machine is
running with 2.6.5+x86_64.

I've posted to the x86-64.org discussion list.  I was asking if they
thought it could be a hardware problem, or if it was more likely to be
software.  Andi Kleen said that is wasn't likely to be hardware since it
always seems to be a corrupted mem_map.

I do run the LSI Logic MegaRAID 320-0 controller, which I believe still
has some issues with 64-bit machines.  But I thought the problems were
limited to machines with greater than 2 GB of RAM.  This machine has
just 2.

A bit more information on the hardware:  The motherboard is a Tyan
S2880, with 2 Opteron 240s.  4 512 MB Corsair PC2700 registered ECC
DIMMs.  And the MegaRAID 320-0.  That card being the ZCR (Zero Channel
RAID), which makes use of the two SCSI channels present on the
motherboard.  Each channel is connected to a SCA backplane with 4
Seagate Cheetah 36ES drives, for a total of 8 drives (2, 1 from each
channel, in RAID1 (system), and the other six in RAID5 (home)).

As I said this is a production server now, but I am able to take it down
for short periods of time for testing.  If anyone has any ideas, I'm
willing to give them a shot.  If you think it is hardware, say so, I'll
try to get things swapped out.  If there is anything else you want to
know about the machine or the kernel running on it, let me know I'll get
the info to you.

Thanks.

-- 
Chris

--=-OJL3/4CaupEqMAvh4NoF
Content-Disposition: attachment; filename=0406-backtrace.txt
Content-Type: text/plain; name=0406-backtrace.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Apr  6 19:02:15 prime kernel: Bad page state at free_hot_cold_page (in process 'spamd', page 00000100032d7168)
Apr  6 19:02:15 prime kernel: flags:0x20000014 mapping:0000000000000000 mapped:1 count:0
Apr  6 19:02:15 prime kernel: Backtrace:
Apr  6 19:02:15 prime kernel:
Apr  6 19:02:15 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013ec5f>{free_hot_cold_page+111}
Apr  6 19:02:15 prime kernel:        <ffffffff8013f2f0>{__pagevec_free+32} <ffffffff8014435b>{release_pages+331}
Apr  6 19:02:15 prime kernel:        <ffffffff80153674>{free_pages_and_swap_cache+116} <ffffffff8014827e>{zap_pte_range+462}
Apr  6 19:02:15 prime kernel:        <ffffffff801483a6>{zap_pmd_range+198} <ffffffff80148410>{unmap_page_range+80}
Apr  6 19:02:15 prime kernel:        <ffffffff80148571>{unmap_vmas+305} <ffffffff8014cab2>{exit_mmap+290}
Apr  6 19:02:15 prime kernel:        <ffffffff801234e8>{mmput+88} <ffffffff8012790c>{do_exit+476}
Apr  6 19:02:15 prime kernel:        <ffffffff80127c1b>{do_group_exit+235} <ffffffff8010ec64>{system_call+124}
Apr  6 19:02:15 prime kernel:
Apr  6 19:02:15 prime kernel: Trying to fix it up, but a reboot is needed
Apr  6 19:02:19 prime kernel: Bad page state at prep_new_page (in process 'spamd', page 00000100032d7168)
Apr  6 19:02:19 prime kernel: flags:0x20000004 mapping:0000000000000000 mapped:1 count:2
Apr  6 19:02:19 prime kernel: Backtrace:
Apr  6 19:02:19 prime kernel:
Apr  6 19:02:19 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013e87f>{prep_new_page+47}
Apr  6 19:02:19 prime kernel:        <ffffffff8013eec3>{buffered_rmqueue+419} <ffffffff8013ef81>{__alloc_pages+161}
Apr  6 19:02:19 prime kernel:        <ffffffff80149372>{do_wp_page+242} <ffffffff8014a340>{handle_mm_fault+336}
Apr  6 19:02:19 prime kernel:        <ffffffff8011e11d>{do_page_fault+381} <ffffffff80121120>{thread_return+0}
Apr  6 19:02:19 prime kernel:        <ffffffff8010f5d1>{error_exit+0}
Apr  6 19:02:19 prime kernel: Trying to fix it up, but a reboot is needed
Apr  6 19:02:20 prime kernel: Bad page state at free_hot_cold_page (in process 'spamd', page 00000100032d7168)
Apr  6 19:02:20 prime kernel: flags:0x20000010 mapping:0000000000000000 mapped:1 count:0
Apr  6 19:02:20 prime kernel: Backtrace:
Apr  6 19:02:20 prime kernel:
Apr  6 19:02:20 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013ec5f>{free_hot_cold_page+111}
Apr  6 19:02:20 prime kernel:        <ffffffff8013f2f0>{__pagevec_free+32} <ffffffff8014435b>{release_pages+331}
Apr  6 19:02:20 prime kernel:        <ffffffff80153674>{free_pages_and_swap_cache+116} <ffffffff8014827e>{zap_pte_range+462}
Apr  6 19:02:20 prime kernel:        <ffffffff801483a6>{zap_pmd_range+198} <ffffffff80148410>{unmap_page_range+80}
Apr  6 19:02:20 prime kernel:        <ffffffff80148571>{unmap_vmas+305} <ffffffff8014cab2>{exit_mmap+290}
Apr  6 19:02:20 prime kernel:        <ffffffff801234e8>{mmput+88} <ffffffff8012790c>{do_exit+476}
Apr  6 19:02:20 prime kernel:        <ffffffff80127c1b>{do_group_exit+235} <ffffffff8010ec64>{system_call+124}
Apr  6 19:02:20 prime kernel:
Apr  6 19:02:20 prime kernel: Trying to fix it up, but a reboot is needed
Apr  6 19:02:20 prime kernel: Bad page state at prep_new_page (in process 'spamd', page 00000100032d7168)
Apr  6 19:02:20 prime kernel: flags:0x20000000 mapping:0000000000000000 mapped:1 count:1
Apr  6 19:02:20 prime kernel: Backtrace:
Apr  6 19:02:20 prime kernel:
Apr  6 19:02:20 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013e87f>{prep_new_page+47}
Apr  6 19:02:20 prime kernel:        <ffffffff8013eec3>{buffered_rmqueue+419} <ffffffff8013ef81>{__alloc_pages+161}
Apr  6 19:02:20 prime kernel:        <ffffffff80149372>{do_wp_page+242} <ffffffff8014a340>{handle_mm_fault+336}
Apr  6 19:02:20 prime kernel:        <ffffffff8011e11d>{do_page_fault+381} <ffffffff80164925>{permission+37}
Apr  6 19:02:20 prime kernel:        <ffffffff801649bc>{path_release+12} <ffffffff80128800>{do_setitimer+320}
Apr  6 19:02:20 prime kernel:        <ffffffff8010f5d1>{error_exit+0}
Apr  6 19:02:20 prime kernel: Trying to fix it up, but a reboot is needed
Apr  6 19:02:21 prime kernel: Bad page state at free_hot_cold_page (in process 'spamd', page 00000100032d7168)
Apr  6 19:02:21 prime kernel: flags:0x20000010 mapping:0000000000000000 mapped:1 count:0
Apr  6 19:02:21 prime kernel: Backtrace:
Apr  6 19:02:21 prime kernel:
Apr  6 19:02:21 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013ec5f>{free_hot_cold_page+111}
Apr  6 19:02:21 prime kernel:        <ffffffff8013f2f0>{__pagevec_free+32} <ffffffff8014435b>{release_pages+331}
Apr  6 19:02:21 prime kernel:        <ffffffff80153674>{free_pages_and_swap_cache+116} <ffffffff8014827e>{zap_pte_range+462}
Apr  6 19:02:21 prime kernel:        <ffffffff801483a6>{zap_pmd_range+198} <ffffffff80148410>{unmap_page_range+80}

--=-OJL3/4CaupEqMAvh4NoF
Content-Disposition: attachment; filename=0409-backtrace.txt
Content-Type: text/plain; name=0409-backtrace.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

Apr  9 11:39:57 prime kernel: Bad page state at free_hot_cold_page (in process 'spamd', page 0000010003293068)
Apr  9 11:39:57 prime kernel: flags:0x20000010 mapping:0000000000000000 mapped:1 count:0
Apr  9 11:39:57 prime kernel: Backtrace:
Apr  9 11:39:57 prime kernel:
Apr  9 11:39:57 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013ec5f>{free_hot_cold_page+111}
Apr  9 11:39:57 prime kernel:        <ffffffff8013f2f0>{__pagevec_free+32} <ffffffff8014435b>{release_pages+331}
Apr  9 11:39:57 prime kernel:        <ffffffff80153674>{free_pages_and_swap_cache+116} <ffffffff8014827e>{zap_pte_range+462}
Apr  9 11:39:57 prime kernel:        <ffffffff801483a6>{zap_pmd_range+198} <ffffffff80148410>{unmap_page_range+80}
Apr  9 11:39:57 prime kernel:        <ffffffff80148571>{unmap_vmas+305} <ffffffff8014cab2>{exit_mmap+290}
Apr  9 11:39:57 prime kernel:        <ffffffff801234e8>{mmput+88} <ffffffff8012790c>{do_exit+476}
Apr  9 11:39:57 prime kernel:        <ffffffff80127c1b>{do_group_exit+235} <ffffffff8010ec64>{system_call+124}
Apr  9 11:39:57 prime kernel:
Apr  9 11:39:57 prime kernel: Trying to fix it up, but a reboot is needed
Apr  9 11:39:57 prime kernel: Bad page state at prep_new_page (in process 'authdaemon', page 0000010003293068)
Apr  9 11:39:57 prime kernel: flags:0x20000000 mapping:0000000000000000 mapped:1 count:0
Apr  9 11:39:57 prime kernel: Backtrace:
Apr  9 11:39:57 prime kernel:
Apr  9 11:39:57 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013e87f>{prep_new_page+47}
Apr  9 11:39:58 prime kernel:        <ffffffff8013eec3>{buffered_rmqueue+419} <ffffffff8013ef81>{__alloc_pages+161}
Apr  9 11:39:58 prime kernel:        <ffffffff80149caa>{do_anonymous_page+330} <ffffffff80149e64>{do_no_page+100}
Apr  9 11:39:58 prime kernel:        <ffffffff8014a2dd>{handle_mm_fault+237} <ffffffff8011e11d>{do_page_fault+381}
Apr  9 11:39:58 prime kernel:        <ffffffff80158a42>{__fput+162} <ffffffff8014c15c>{unmap_vma_list+28}
Apr  9 11:39:58 prime kernel:        <ffffffff8010f5d1>{error_exit+0}
Apr  9 11:39:58 prime kernel: Trying to fix it up, but a reboot is needed
Apr  9 11:39:58 prime kernel: Bad page state at free_hot_cold_page (in process 'authdaemon', page 0000010003293068)
Apr  9 11:39:58 prime kernel: flags:0x20000014 mapping:0000000000000000 mapped:1 count:0
Apr  9 11:39:58 prime kernel: Backtrace:
Apr  9 11:39:58 prime kernel:
Apr  9 11:39:58 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013ec5f>{free_hot_cold_page+111}
Apr  9 11:39:58 prime kernel:        <ffffffff8013f2f0>{__pagevec_free+32} <ffffffff8014435b>{release_pages+331}
Apr  9 11:39:58 prime kernel:        <ffffffff80153674>{free_pages_and_swap_cache+116} <ffffffff8014cb32>{exit_mmap+418}
Apr  9 11:39:58 prime kernel:        <ffffffff801234e8>{mmput+88} <ffffffff80161edc>{exec_mmap+668}
Apr  9 11:39:58 prime kernel:        <ffffffff801ef1bd>{linvfs_open+45} <ffffffff80156fbc>{dentry_open+188}
Apr  9 11:39:58 prime kernel:        <ffffffff801625f1>{flush_old_exec+1761} <ffffffff80157ac0>{vfs_read+240}
Apr  9 11:39:59 prime kernel:        <ffffffff8017f04c>{load_elf_binary+1180} <ffffffff80162bc8>{search_binary_handler+120}
Apr  9 11:39:59 prime kernel:        <ffffffff8010ec64>{system_call+124} <ffffffff80162e28>{do_execve+408}
Apr  9 11:39:59 prime kernel:        <ffffffff8010d501>{sys_execve+65} <ffffffff8010f05e>{stub_execve+106}
Apr  9 11:39:59 prime kernel:
Apr  9 11:39:59 prime kernel: Trying to fix it up, but a reboot is needed
Apr  9 11:39:59 prime kernel: Bad page state at prep_new_page (in process 'exim', page 0000010003293068)
Apr  9 11:39:59 prime kernel: flags:0x20000004 mapping:0000000000000000 mapped:1 count:0
Apr  9 11:39:59 prime kernel: Backtrace:
Apr  9 11:39:59 prime kernel:
Apr  9 11:39:59 prime kernel: Call Trace:<ffffffff8013e4bd>{bad_page+93} <ffffffff8013e87f>{prep_new_page+47}
Apr  9 11:39:59 prime kernel:        <ffffffff8013eec3>{buffered_rmqueue+419} <ffffffff8013ef81>{__alloc_pages+161}
Apr  9 11:39:59 prime kernel:        <ffffffff80149caa>{do_anonymous_page+330} <ffffffff80149e64>{do_no_page+100}
Apr  9 11:39:59 prime kernel:        <ffffffff8014a2dd>{handle_mm_fault+237} <ffffffff8011e11d>{do_page_fault+381}
Apr  9 11:39:59 prime kernel:        <ffffffff802ff533>{unix_release_sock+675} <ffffffff8016fce2>{destroy_inode+50}
Apr  9 11:39:59 prime kernel:        <ffffffff8016dd81>{dput+33} <ffffffff8010f5d1>{error_exit+0}
Apr  9 11:39:59 prime kernel:
Apr  9 11:39:59 prime kernel: Trying to fix it up, but a reboot is needed

--=-OJL3/4CaupEqMAvh4NoF
Content-Disposition: attachment; filename=prime_config.txt
Content-Type: text/plain; name=prime_config.txt; charset=UTF-8
Content-Transfer-Encoding: 7bit

CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_HOTPLUG=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_MK8=y
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=2
CONFIG_GART_IOMMU=y
CONFIG_X86_MCE=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_TASK_IOCTL=y
CONFIG_IDE_TASKFILE_IO=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_SPI_ATTRS=y
CONFIG_SCSI_MEGARAID=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NETDEVICES=y
CONFIG_TIGON3=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_EVDEV=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_ACPI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_WATCHDOG=y
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_HANGCHECK_TIMER=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_OHCI_HCD=y
CONFIG_EDD=y
CONFIG_XFS_FS=y
CONFIG_XFS_QUOTA=y
CONFIG_QUOTACTL=y
CONFIG_ISO9660_FS=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS_XATTR=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_MAGIC_SYSRQ=y

--=-OJL3/4CaupEqMAvh4NoF--

