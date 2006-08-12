Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWHLVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWHLVTp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 17:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422706AbWHLVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 17:19:45 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:33548 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1422699AbWHLVTo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 17:19:44 -0400
To: linux-kernel@vger.kernel.org
Cc: Neil Brown <neilb@suse.de>, netdev@vger.kernel.org
Subject: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
From: Nix <nix@esperi.org.uk>
X-Emacs: impress your (remaining) friends and neighbors.
Date: Sat, 12 Aug 2006 22:19:19 +0100
Message-ID: <87zme9fy94.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc:ed to l-k and plausible maintainers: I'm not subscribed to netdev
 so, please, if you prune l-k, leave me in the Cc]

I just upgraded to 2.6.17.8 (built with GCC 4.1.1 on x86 / Athlon IV).

As luck would have it I made a bunch of other changes at the same time,
namely that I LVMed my root filesystem and migrated to an initramfs (see
<http://linux-raid.osdl.org/index.php/RAID_Boot> for a slightly outdated
version of the init script I'm using, I must bring it up to date; among
other things it works on non-RAID boxes now, indeed the machine
experiencing the problems is not using md at all).

While I doubt these changes have caused this problem, they make it
tricky to back down to an earlier kernel, as older kernels I've already
compiled won't boot anymore (I'd have to rebuild one with the initramfs
in it). So I haven't tried to reproduce this on earlier kernels yet.

About half an hour after booting (while bootstrapping OCaml over NFSv3
as it happens), I started to notice long lags (~10s) accessing NFS-
mounted stuff. I was in XEmacs at the time so I wrote it off to a
malfunctioning itimer and decided to fix it later.

Then the build froze. I couldn't very well ignore *that*. Perhaps I
couldn't blame XEmacs after all.


The kernel log showed a heap of BUGs from somewhere inside the skb
management layer, somewhere in UDP fragment processing while
handling NFS requests. It starts like this:

Aug 12 21:31:08 hades warning: kernel: BUG: warning at include/linux/skbuff.h:975/__skb_trim()
Aug 12 21:31:08 hades warning: kernel: <c030ed39> ip_append_data+0x5b3/0x951  <c030fc18> ip_generic_getfrag+0x0/0x96
Aug 12 21:31:08 hades warning: kernel: <c030fc18> ip_generic_getfrag+0x0/0x96  <c0326307> udp_sendmsg+0x42e/0x51d
Aug 12 21:31:08 hades warning: kernel: <c032632f> udp_sendmsg+0x456/0x51d  <c032b8f5> inet_sendmsg+0x3b/0x45
Aug 12 21:31:08 hades warning: kernel: <c02f309c> sock_sendmsg+0xbd/0xd5  <c02f309c> sock_sendmsg+0xbd/0xd5
Aug 12 21:31:08 hades warning: kernel: <c0122cac> autoremove_wake_function+0x0/0x35  <c0122cac> autoremove_wake_function+0x0/0x35
Aug 12 21:31:08 hades warning: kernel: <c03264e6> udp_sendpage+0xf0/0xfa  <c02f4ad6> kernel_sendmsg+0x26/0x2c
Aug 12 21:31:08 hades warning: kernel: <c033bdff> xs_send_tail+0x4b/0x52  <c033d2b3> xs_udp_send_request+0x1f4/0x295
Aug 12 21:31:08 hades warning: kernel: <c032b8ff> inet_sendpage+0x0/0x83  <c033aed0> xprt_transmit+0xcc/0x1fb
Aug 12 21:31:08 hades warning: kernel: <c033e9b3> rpcauth_wrap_req+0x6c/0x74  <c033ea58> rpcauth_marshcred+0x4b/0x52
Aug 12 21:31:08 hades warning: kernel: <c033b1cb> xprt_prepare_transmit+0x80/0x89  <c01dcd10> nfs3_xdr_writeargs+0x0/0x7f
Aug 12 21:31:08 hades warning: kernel: <c033a20b> call_transmit+0x1ac/0x1e9  <c033dfab> __rpc_execute+0x82/0x1af
Aug 12 21:31:08 hades warning: kernel: <c011b62d> sigprocmask+0x86/0xa3  <c01d8466> nfs_execute_write+0x34/0x48
Aug 12 21:31:08 hades warning: kernel: <c01d9874> nfs_flush_one+0xc1/0x102  <c01d86e3> nfs_flush_list+0x87/0xcf
Aug 12 21:31:08 hades warning: kernel: <c01d97b3> nfs_flush_one+0x0/0x102  <c01d96d8> nfs_sync_inode_wait+0x9a/0x112
Aug 12 21:31:08 hades warning: kernel: <c01d1d17> nfs_file_flush+0x7b/0xb4  <c0144955> filp_close+0x33/0x59
Aug 12 21:31:08 hades warning: kernel: <c01026af> sysenter_past_esp+0x54/0x75

... and then goes on like this, as the system tries to flush out the
data that Just Won't Go:

Aug 12 21:31:08 hades warning: kernel: BUG: warning at include/linux/skbuff.h:975/__skb_trim()
Aug 12 21:31:08 hades warning: kernel: <c030ed39> ip_append_data+0x5b3/0x951  <c030fc18> ip_generic_getfrag+0x0/0x96
Aug 12 21:31:08 hades warning: kernel: <c030fc18> ip_generic_getfrag+0x0/0x96  <c0326307> udp_sendmsg+0x42e/0x51d
Aug 12 21:31:08 hades warning: kernel: <c032632f> udp_sendmsg+0x456/0x51d  <c032b8f5> inet_sendmsg+0x3b/0x45
Aug 12 21:31:08 hades warning: kernel: <c02f309c> sock_sendmsg+0xbd/0xd5  <c02f309c> sock_sendmsg+0xbd/0xd5
Aug 12 21:31:08 hades warning: kernel: <c0122cac> autoremove_wake_function+0x0/0x35  <c0122cac> autoremove_wake_function+0x0/0x35
Aug 12 21:31:08 hades warning: kernel: <c03264e6> udp_sendpage+0xf0/0xfa  <c02f4ad6> kernel_sendmsg+0x26/0x2c
Aug 12 21:31:08 hades warning: kernel: <c033bdff> xs_send_tail+0x4b/0x52  <c033d2b3> xs_udp_send_request+0x1f4/0x295
Aug 12 21:31:08 hades warning: kernel: <c032b8ff> inet_sendpage+0x0/0x83  <c01dcd10> nfs3_xdr_writeargs+0x0/0x7f
Aug 12 21:31:08 hades warning: kernel: <c033aed0> xprt_transmit+0xcc/0x1fb  <c033e9b3> rpcauth_wrap_req+0x6c/0x74
Aug 12 21:31:08 hades warning: kernel: <c033ea58> rpcauth_marshcred+0x4b/0x52  <c033b1cb> xprt_prepare_transmit+0x80/0x89
Aug 12 21:31:08 hades warning: kernel: <c01dcd10> nfs3_xdr_writeargs+0x0/0x7f  <c033a20b> call_transmit+0x1ac/0x1e9
Aug 12 21:31:08 hades warning: kernel: <c033dfab> __rpc_execute+0x82/0x1af  <c0347c70> schedule+0x47a/0x519
Aug 12 21:31:08 hades warning: kernel: <c01203bd> run_workqueue+0x9d/0xfc  <c033e0d8> rpc_async_schedule+0x0/0x5
Aug 12 21:31:08 hades warning: kernel: <c0120758> worker_thread+0x0/0x10c  <c0120833> worker_thread+0xdb/0x10c
Aug 12 21:31:08 hades warning: kernel: <c0110d1f> default_wake_function+0x0/0xc  <c0122bea> kthread+0x91/0xbd
Aug 12 21:31:08 hades warning: kernel: <c0122b59> kthread+0x0/0xbd  <c0100ba5> kernel_thread_helper+0x5/0xb

This latter BUG then repeated every second or two: eventually NFS
stalled (perhaps all UDP traffic was stalled: I didn't check.)


Possibly-interesting network parameters:

1: gordianet: <BROADCAST,MULTICAST,UP,10000> mtu 1458 qdisc pfifo_fast qlen 100
    link/ether 00:50:04:32:9e:2f brd ff:ff:ff:ff:ff:ff
    inet 192.168.14.18/24 brd 192.168.14.255 scope global gordianet

The NFS mounts I was accessing at the time, obviously hitting the UDP
fragment processing layer rather hard given an MTU of 1458:

/home/.loki.wkstn.nix from loki:/home/.loki.wkstn.nix
 Flags: rw,vers=3,rsize=32768,wsize=32768,hard,intr,proto=udp,timeo=7,retrans=3,addr=loki

/usr/packages from package:/usr/packages
 Flags: rw,vers=3,rsize=32768,wsize=32768,hard,intr,proto=udp,timeo=7,retrans=3,addr=package

(`package' is a CNAME for `loki', so these are the same machine.)


Loaded modules:

Module                  Size  Used by
radeon                101152  2
drm                    58836  3 radeon

The .config:

CONFIG_X86_32=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_DMI=y
CONFIG_EXPERIMENTAL=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_RELAY=y
CONFIG_INITRAMFS_SOURCE="usr/initramfs.hades"
CONFIG_INITRAMFS_ROOT_UID=99
CONFIG_INITRAMFS_ROOT_GID=101
CONFIG_UID16=y
CONFIG_VM86=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_KALLSYMS=y
CONFIG_HOTPLUG=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_SLAB=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_KMOD=y
CONFIG_BLK_DEV_IO_TRACE=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=m
CONFIG_IOSCHED_DEADLINE=m
CONFIG_IOSCHED_CFQ=y
CONFIG_DEFAULT_CFQ=y
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
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
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_TSC=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_PROC_MM=y
CONFIG_ARCH_FLATMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SELECT_MEMORY_MODEL=y
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_SPARSEMEM_STATIC=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_MTRR=y
CONFIG_REGPARM=y
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_PHYSICAL_START=0x100000
CONFIG_PM=y
CONFIG_PM_LEGACY=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA_DMA_API=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_FIB_HASH=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_1284=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=16
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_IDE_GENERIC=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_OFFBOARD=y
CONFIG_BLK_DEV_GENERIC=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
CONFIG_MD=y
CONFIG_BLK_DEV_DM=y
CONFIG_DM_CRYPT=y
CONFIG_DM_SNAPSHOT=y
CONFIG_DM_MIRROR=y
CONFIG_DM_ZERO=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_MII=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y
CONFIG_INPUT_MISC=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_PRINTER=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=m
CONFIG_DRM_RADEON=m
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ISA=y
CONFIG_I2C_VIAPRO=y
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
CONFIG_SENSORS_W83627HF=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_SOUND=y
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_HWDEP=y
CONFIG_SND_RAWMIDI=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_PCM_OSS_PLUGINS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=y
CONFIG_SND_AC97_BUS=y
CONFIG_SND_MPU401=m
CONFIG_SND_EMU10K1=y
CONFIG_SND_INTEL8X0=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y
CONFIG_USB_DYNAMIC_MINORS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_FS_POSIX_ACL=y
CONFIG_INOTIFY=y
CONFIG_QUOTA=y
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_DNOTIFY=y
CONFIG_FUSE_FS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=m
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_RAMFS=y
CONFIG_CONFIGFS_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFSD=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_ISO8859_15=m
CONFIG_PROFILING=y
CONFIG_OPROFILE=y
CONFIG_LOG_BUF_SHIFT=14
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_FS=y
CONFIG_UNWIND_INFO=y
CONFIG_EARLY_PRINTK=y
CONFIG_STACK_BACKTRACE_COLS=2
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
CONFIG_CRYPTO=y
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y
