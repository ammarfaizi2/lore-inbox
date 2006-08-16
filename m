Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWHPIaj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWHPIaj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 04:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbWHPIaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 04:30:39 -0400
Received: from wasp.net.au ([203.190.192.17]:58851 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S1751001AbWHPIah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 04:30:37 -0400
Message-ID: <44E2D7A2.9050705@wasp.net.au>
Date: Wed, 16 Aug 2006 12:30:26 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: ALSA and hardlock problems with 2.6.17-rt8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

This is going to involve a little handwaving as I've not been able to get a serial/net console on
the machine and activate the nmi oopser to debug the hardlocks yet.

<------- ALSA ISSUE HERE------->

However, the ALSA issue is dead easy to reproduce, under a very specific set of circumstances.

It involves playing a DVD with Xine using an EMU10K1 (SB Live 5.1) in SPDIF Passthrough mode playing
a dolby soundtrack (Standard PCM or DTS don't exhibit this issue).

With the vanilla kernel, everything works perfectly well for weeks at a time.

With the rt kernel within 2 or 3 minutes of starting a DVD playback the sound "just stops".
Sometimes it comes back by itself if I wait. It always comes back if I pause and resume playback.
No messages in syslog/dmesg or my verbose xine log. My external Amp/Decoder just flashes the no sync
light at me while the sound is stopped.

I have no idea how to provide any more debugging information on this issue.. any suggestions
gratefully received.

I have no extra userspace config for the rt kernel, I'm not using PAM rlimits or the realtime module
(I only load that if I want to run Ardour and Jack)

<-------- END ALSA -- START HARDLOCK -------->

The hardlocks are a different animal indeed and as yet I've seen no rhyme or reason to them, however
they are most certainly a complete hard lock as I've seen them at the console and even sysrq is
dead. I plan on setting up the nmi oopser and netconsole to try and debug this, but it's a pig to
reproduce.

I have run memtest86+ for over 72 hours, and run prime95 for 24+ hours. I've run a looping make
mrproper allyesconfig ; make for over 24 hours also.

The machine has PC3200 ram in it which is manually clocked down from 400 to 333 Mhz in the BIOS
(otherwise the machine flakes out sometimes. The installed processor only uses a 333 FSB)

Again, with a vanilla 2.6.17 kernel it's seen weeks of uptime and very heavy use with no problems.
The -rt kernel can kill it in a matter of hours.

<-------- END HARDLOCK --START CONFIG INFO--->

This box has no local storage at all and no form of swap, it boots from a USB keystick using loadlin
one of two ways.

1. I load the kernel directly from the usb keystick and give it the below command line.

2. I load a generic 2.6.15.7 kernel from usb keystick with minimal drivers, mount the nfs root and
then have it load the new kernel using kexec. (believe it or not it's faster than loading the full
kernel off usb and saves me futzin with dos when I want to try a new kenel). Either way the command 
line is the same. (Wish I could get my hands on a PXE GB PCI card)

brad@tv:~$ cat /proc/cmdline
root=/dev/nfs
video=matroxfb:xres:1024,yres:768,pixclock:15386,left:160,right:24,upper:29,lower:3,hslen:132,vslen:6,depth:8 

nfsroot=/nfsroot,rsize=8192,wsize=8192 ip=both panic=30

Please let me know if there is any other info I should provide, or anything I might try.
At the moment I use 2.6.17 when I want to actually use the machine day-to-day and 2.6.17-rt8 when I
want to do Audio work.. but I should not have to do that really.

I use 2 kernel trees to compare. Vanilla 2.6.17 and 2.6.17 with the -rt8 patch applied
Here is my config for 2.6.17

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
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INITRAMFS_SOURCE=""
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
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_KMOD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
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
CONFIG_PREEMPT=y
CONFIG_PREEMPT_BKL=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_HIGHMEM4G=y
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_HIGHMEM=y
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
CONFIG_SECCOMP=y
CONFIG_HZ_1000=y
CONFIG_HZ=1000
CONFIG_KEXEC=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
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
CONFIG_ISA_DMA_API=y
CONFIG_BINFMT_ELF=y
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
CONFIG_TCP_CONG_BIC=y
CONFIG_NETFILTER=y
CONFIG_NETFILTER_NETLINK=m
CONFIG_NETFILTER_XTABLES=m
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
CONFIG_NETFILTER_XT_TARGET_MARK=m
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
CONFIG_NETFILTER_XT_MATCH_COMMENT=m
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
CONFIG_NETFILTER_XT_MATCH_DCCP=m
CONFIG_NETFILTER_XT_MATCH_ESP=m
CONFIG_NETFILTER_XT_MATCH_HELPER=m
CONFIG_NETFILTER_XT_MATCH_LENGTH=m
CONFIG_NETFILTER_XT_MATCH_LIMIT=m
CONFIG_NETFILTER_XT_MATCH_MAC=m
CONFIG_NETFILTER_XT_MATCH_MARK=m
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
CONFIG_NETFILTER_XT_MATCH_REALM=m
CONFIG_NETFILTER_XT_MATCH_SCTP=m
CONFIG_NETFILTER_XT_MATCH_STATE=m
CONFIG_NETFILTER_XT_MATCH_STRING=m
CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_NETBIOS_NS=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_PPTP=m
CONFIG_IP_NF_H323=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_PPTP=m
CONFIG_IP_NF_NAT_H323=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=m
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_SG=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=y
CONFIG_TUN=y
CONFIG_SKGE=y
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
CONFIG_JOYSTICK_ANALOG=m
CONFIG_JOYSTICK_A3D=m
CONFIG_JOYSTICK_ADI=m
CONFIG_JOYSTICK_COBRA=m
CONFIG_JOYSTICK_GF2K=m
CONFIG_JOYSTICK_GRIP=m
CONFIG_JOYSTICK_GRIP_MP=m
CONFIG_JOYSTICK_GUILLEMOT=m
CONFIG_JOYSTICK_INTERACT=m
CONFIG_JOYSTICK_SIDEWINDER=m
CONFIG_JOYSTICK_TMDC=m
CONFIG_JOYSTICK_IFORCE=m
CONFIG_JOYSTICK_IFORCE_USB=y
CONFIG_JOYSTICK_IFORCE_232=y
CONFIG_JOYSTICK_WARRIOR=m
CONFIG_JOYSTICK_MAGELLAN=m
CONFIG_JOYSTICK_SPACEORB=m
CONFIG_JOYSTICK_SPACEBALL=m
CONFIG_JOYSTICK_STINGER=m
CONFIG_JOYSTICK_TWIDJOY=m
CONFIG_JOYSTICK_JOYDUMP=m
CONFIG_INPUT_MISC=y
CONFIG_INPUT_UINPUT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_GAMEPORT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_VIA=m
CONFIG_DRM=y
CONFIG_DRM_RADEON=m
CONFIG_DRM_MGA=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_HWMON=y
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_V4L1_COMPAT=y
CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_MSP3400=m
CONFIG_DVB=y
CONFIG_DVB_CORE=m
CONFIG_DVB_BT8XX=m
CONFIG_DVB_CX24110=m
CONFIG_DVB_SP887X=m
CONFIG_DVB_NXT6000=m
CONFIG_DVB_MT352=m
CONFIG_DVB_ZL10353=m
CONFIG_DVB_OR51211=m
CONFIG_DVB_LGDT330X=m
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_FIRMWARE_EDID=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G=y
CONFIG_FB_RADEON=m
CONFIG_FB_RADEON_I2C=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_MPU401_UART=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_ICE1712=m
CONFIG_SND_VIA82XX=m
CONFIG_SND_USB_AUDIO=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_ARCH_HAS_EHCI=y
CONFIG_USB=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_UHCI_HCD=y
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=y
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_LOGITECH_FF=y
CONFIG_THRUSTMASTER_FF=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_IPAQ=m
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_INOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_HFSPLUS_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_NLS_UTF8=m
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_KERNEL=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_FORCED_INLINING=y
CONFIG_EARLY_PRINTK=y
CONFIG_STACK_BACKTRACE_COLS=2
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_DOUBLEFAULT=y
CONFIG_CRC32=y
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_TEXTSEARCH=y
CONFIG_TEXTSEARCH_KMP=m
CONFIG_TEXTSEARCH_BM=m
CONFIG_TEXTSEARCH_FSM=m
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_KTIME_SCALAR=y

Here is the diff to my 2.6.17-rt8 config

--- config1	2006-08-16 11:53:11.000000000 +0400
+++ config2	2006-08-16 11:53:32.000000000 +0400
@@ -1,4 +1,5 @@
  CONFIG_X86_32=y
+CONFIG_GENERIC_TIME=y
  CONFIG_SEMAPHORE_SLEEPERS=y
  CONFIG_X86=y
  CONFIG_MMU=y
@@ -28,6 +29,7 @@
  CONFIG_BUG=y
  CONFIG_ELF_CORE=y
  CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
  CONFIG_FUTEX=y
  CONFIG_EPOLL=y
  CONFIG_SHMEM=y
@@ -48,7 +50,7 @@
  CONFIG_X86_CMPXCHG=y
  CONFIG_X86_XADD=y
  CONFIG_X86_L1_CACHE_SHIFT=6
-CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
  CONFIG_GENERIC_CALIBRATE_DELAY=y
  CONFIG_X86_WP_WORKS_OK=y
  CONFIG_X86_INVLPG=y
@@ -60,8 +62,13 @@
  CONFIG_X86_USE_PPRO_CHECKSUM=y
  CONFIG_X86_USE_3DNOW=y
  CONFIG_X86_TSC=y
+CONFIG_PREEMPT_RT=y
  CONFIG_PREEMPT=y
+CONFIG_PREEMPT_SOFTIRQS=y
+CONFIG_PREEMPT_HARDIRQS=y
  CONFIG_PREEMPT_BKL=y
+CONFIG_PREEMPT_RCU=y
+CONFIG_ASM_SEMAPHORES=y
  CONFIG_X86_UP_APIC=y
  CONFIG_X86_UP_IOAPIC=y
  CONFIG_X86_LOCAL_APIC=y
@@ -384,13 +391,13 @@
  CONFIG_NLS_CODEPAGE_437=y
  CONFIG_NLS_ISO8859_1=y
  CONFIG_NLS_UTF8=m
+CONFIG_PROFILE_NMI=y
  CONFIG_MAGIC_SYSRQ=y
  CONFIG_DEBUG_KERNEL=y
  CONFIG_LOG_BUF_SHIFT=17
  CONFIG_DEBUG_BUGVERBOSE=y
  CONFIG_FORCED_INLINING=y
  CONFIG_EARLY_PRINTK=y
-CONFIG_STACK_BACKTRACE_COLS=2
  CONFIG_X86_FIND_SMP_CONFIG=y
  CONFIG_X86_MPPARSE=y
  CONFIG_DOUBLEFAULT=y
@@ -401,6 +408,7 @@
  CONFIG_TEXTSEARCH_KMP=m
  CONFIG_TEXTSEARCH_BM=m
  CONFIG_TEXTSEARCH_FSM=m
+CONFIG_PLIST=y
  CONFIG_GENERIC_HARDIRQS=y
  CONFIG_GENERIC_IRQ_PROBE=y
  CONFIG_X86_BIOS_REBOOT=y

lspci

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
0000:00:09.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
0000:00:0a.0 Multimedia audio controller: VIA Technologies Inc. ICE1712 [Envy24] PCI Multi-Channel
I/O Controller (rev 02)
0000:00:0b.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 7000/VE]
0000:00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet
10/100/1000Base-T Adapter (rev 12)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus
Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio
Controller (rev 50)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

/proc/interrupts /proc/cpuinfo /proc/meminfo
            CPU0
   0:  159613615    IO-APIC-edge  timer
   1:      23259    IO-APIC-edge  i8042
   8:    6287267    IO-APIC-edge  rtc
   9:          1   IO-APIC-level  acpi
  12:     201476    IO-APIC-edge  i8042
  15:         76    IO-APIC-edge  ide1
  16:   21293749   IO-APIC-level  bttv0, bt878, mga@pci:0000:01:00.0
  17:    9612079   IO-APIC-level  skge, EMU10K1
  19:   16531091   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4
  20:          0   IO-APIC-level  ICE1712
  21:          0   IO-APIC-level  VIA8233
NMI:          0
LOC:  159316847
ERR:          0
MIS:          0

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 10
model name	: AMD Athlon(tm) XP 2800+
stepping	: 0
cpu MHz		: 2086.752
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse
syscall mmxext 3dnowext 3dnow up ts
bogomips	: 4175.84

MemTotal:      3116728 kB
MemFree:        109880 kB
Buffers:        198552 kB
Cached:        2522896 kB
SwapCached:          0 kB
Active:        1026796 kB
Inactive:      1866556 kB
HighTotal:     2228160 kB
HighFree:        21212 kB
LowTotal:       888568 kB
LowFree:         88668 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:         198728 kB
Slab:            90608 kB
CommitLimit:   1558364 kB
Committed_AS:   274368 kB
PageTables:       1156 kB
VmallocTotal:   114680 kB
VmallocUsed:     46024 kB
VmallocChunk:    68084 kB

/proc/asound/cards
brad@tv:~$ cat /proc/asound/cards
  0 [Live           ]: EMU10K1 - SB Live 5.1 Dell OEM [SB0220]
                       SB Live 5.1 Dell OEM [SB0220] (rev.10, serial:0x80661102) at 0x9000, irq 17
  1 [M1010LT        ]: ICE1712 - M Audio Delta 1010LT
                       M Audio Delta 1010LT at 0x9800, irq 20
  2 [V8235          ]: VIA8233 - VIA 8235
                       VIA 8235 with ALC655 at 0xc000, irq 21

lsmod

Module                  Size  Used by
mga                    57856  1
lirc_serial            11296  0
snd_seq_midi            5856  0
snd_seq_midi_event      5632  1 snd_seq_midi
snd_seq                42448  2 snd_seq_midi,snd_seq_midi_event
dvb_bt8xx              12036  0
nxt6000                 6212  1 dvb_bt8xx
mt352                   5444  1 dvb_bt8xx
dvb_pll                10244  1 dvb_bt8xx
sp887x                  6532  1 dvb_bt8xx
dst_ca                 14336  1 dvb_bt8xx
cx24110                 6660  1 dvb_bt8xx
or51211                 8772  1 dvb_bt8xx
lgdt330x                6748  1 dvb_bt8xx
dst                    22404  2 dvb_bt8xx,dst_ca
bt878                   8680  2 dvb_bt8xx,dst
dvb_core               65512  2 dvb_bt8xx,dst_ca
snd_via82xx            21528  0
snd_ice1712            52260  0
snd_emu10k1            98212  0
gameport               10824  1 snd_via82xx
snd_ice17xx_ak4xxx      2944  1 snd_ice1712
snd_ak4xxx_adda         5184  2 snd_ice1712,snd_ice17xx_ak4xxx
snd_cs8427              7040  1 snd_ice1712
snd_ac97_codec         80352  3 snd_via82xx,snd_ice1712,snd_emu10k1
snd_pcm                67144  4 snd_via82xx,snd_ice1712,snd_emu10k1,snd_ac97_codec
tuner                  48300  0
bttv                  153396  2 dvb_bt8xx,bt878
video_buf              19076  1 bttv
firmware_class          7360  4 dvb_bt8xx,sp887x,or51211,bttv
ir_common              23364  1 bttv
compat_ioctl32          1088  1 bttv
i2c_algo_bit            7944  1 bttv
v4l2_common            13376  2 tuner,bttv
btcx_risc               3848  1 bttv
tveeprom               12816  1 bttv
i2c_core               15696  12
dvb_bt8xx,nxt6000,mt352,sp887x,cx24110,or51211,lgdt330x,dst,tuner,bttv,i2c_algo_bit,tveeprom
snd_ac97_bus            1920  1 snd_ac97_codec
snd_i2c                 4288  2 snd_ice1712,snd_cs8427
snd_timer              18244  3 snd_seq,snd_emu10k1,snd_pcm
snd_mpu401_uart         5696  2 snd_via82xx,snd_ice1712
snd_page_alloc          7432  3 snd_via82xx,snd_emu10k1,snd_pcm
snd_util_mem            3200  1 snd_emu10k1
snd_hwdep               6084  1 snd_emu10k1
lirc_streamzap         13572  0
snd_rawmidi            16640  3 snd_seq_midi,snd_emu10k1,snd_mpu401_uart
lirc_dev               11940  2 lirc_serial,lirc_streamzap
via_agp                 7616  1
videodev                6720  1 bttv
snd_seq_device          6092  4 snd_seq_midi,snd_seq,snd_emu10k1,snd_rawmidi
snd                    37112  14
snd_seq,snd_via82xx,snd_ice1712,snd_emu10k1,snd_ak4xxx_adda,snd_cs8427,snd_ac97_codec,snd_pcm,snd_i2c,snd_timer,snd_mpu401_uart,snd_hwdep,snd_rawmidi,snd_seq_device
soundcore               7008  1 snd

dmesg of clean 2.6.17 boot

Linux version 2.6.17 (brad@srv) (gcc version 3.3.5 (Debian 1:3.3.5-13)) #3 PREEMPT Mon Aug 14
14:52:39 GST 2006
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000100 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
  BIOS-e820: 00000000bfff0000 - 00000000bfff3000 (ACPI NVS)
  BIOS-e820: 00000000bfff3000 - 00000000c0000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
2175MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4d50
On node 0 totalpages: 786416
   DMA zone: 4096 pages, LIFO batch:0
   Normal zone: 225280 pages, LIFO batch:31
   HighMem zone: 557040 pages, LIFO batch:31
DMI 2.3 present.
ACPI: RSDP (v000 GBT                                   ) @ 0x000f66e0
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0xbfff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0xbfff3040
ACPI: MADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0xbfff77c0
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c4000000 (gap: c0000000:3ec00000)
Built 1 zonelists
Kernel command line: root=/dev/nfs
video=matroxfb:xres:1024,yres:768,pixclock:15386,left:160,right:24,upper:29,lower:3,hslen:132,vslen:6,depth:8 

nfsroot=/nfsroot,rsize=8192,wsize=8192 ip=both panic=30
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 16384 bytes)
Detected 2086.752 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 3115880k/3145664k available (1986k kernel code, 28712k reserved, 788k data, 168k init,
2228160k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4175.84 BogoMIPS (lpj=2087921)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000420 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 2800+ stepping 00
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf9fd0, last bus=1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 4000-407f claimed by vt8235 PM
PCI quirk: region 5000-500f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 *10 11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 10 *11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 *7 10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *6 7 10 11 12)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK0] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 6 7 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [ALKA] (IRQs 20) *0, disabled.
ACPI: PCI Interrupt Link [ALKB] (IRQs 21) *0, disabled.
ACPI: PCI Interrupt Link [ALKC] (IRQs 22) *0, disabled.
ACPI: PCI Interrupt Link [ALKD] (IRQs 23) *0, disabled.
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
   IO window: disabled.
   MEM window: dc000000-deffffff
   PREFETCH window: d8000000-d9ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 524288 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
matroxfb: Matrox G450 detected
PInS memtype = 4
matroxfb: MTRR's turned on
matroxfb: 1024x768x8bpp (virtual: 1024x16384)
matroxfb: framebuffer at 0xD8000000, mapped to 0xf8880000, size 16777216
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
loop: loaded (max 8 devices)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 17 (level, low) -> IRQ 17
skge 1.5 addr 0xe0010000 irq 17 chip Yukon rev 1
skge eth0: addr 00:04:e2:8e:1e:65
tun: Universal TUN/TAP device driver, 1.6
tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [ALKA] BIOS reported IRQ 0, using IRQ 20
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 18
PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 2
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
     ide0: BM-DMA at 0xbc00-0xbc07, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdc: JLMS XJ-HD165H, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
ACPI: PCI Interrupt Link [ALKB] BIOS reported IRQ 0, using IRQ 21
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 19, io mem 0xe0016000
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: VIA IRQ fixup for 0000:00:10.0, from 10 to 3
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 19, io base 0x0000b000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: VIA IRQ fixup for 0000:00:10.1, from 11 to 3
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 19, io base 0x0000b400
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new high speed USB device using ehci_hcd and address 2
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [ALKB] -> GSI 21 (level, low) -> IRQ 19
PCI: VIA IRQ fixup for 0000:00:10.2, from 7 to 3
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 19, io base 0x0000b800
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-1: configuration #1 chosen from 1 choice
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
Initializing USB Mass Storage driver...
usb 3-1: new full speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
hub 3-1:1.0: USB hub found
hub 3-1:1.0: 4 ports detected
usb 1-1.1: new full speed USB device using ehci_hcd and address 4
usb 1-1.1: configuration #1 chosen from 1 choice
usb 3-1.2: new low speed USB device using uhci_hcd and address 3
usb 3-1.2: configuration #1 chosen from 1 choice
usb 3-1.3: new low speed USB device using uhci_hcd and address 4
usb 3-1.3: configuration #1 chosen from 1 choice
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver hiddev
input: Logitech USB Receiver as /class/input/input0
input: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:10.1-1.2
input: Logitech USB Receiver as /class/input/input1
input: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:10.1-1.2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices:
PCI0 USB0 USB1 USB2 USB6 USB7 USB8 USB9 LAN0 UAR1
ACPI: (supports S0 S3 S4 S5)
input: AT Translated Set 2 keyboard as /class/input/input2
input: ThinkPS/2 Kensington ThinkingMouse as /class/input/input3
skge eth0: enabling interface
Sending BOOTP requests .<6>skge eth0: Link is up at 1000 Mbps, full duplex, flow control tx and rx
.<5>  Vendor: Generic   Model: Flash Disk        Rev: 7.77
   Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 64000 512-byte hdwr sectors (33 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
SCSI device sda: 64000 512-byte hdwr sectors (33 MB)
sda: Write Protect is off
sda: Mode Sense: 03 00 00 00
sda: assuming drive cache: write through
  sda: sda1
sd 0:0:0:0: Attached scsi removable disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
usb-storage: device scan complete
. OK
IP-Config: Got BOOTP answer from 192.168.2.1, my address is 192.168.2.81
IP-Config: Complete:
       device=eth0, addr=192.168.2.81, mask=255.255.255.0, gw=192.168.2.1,
      host=192.168.2.81, domain=home, nis-domain=(none),
      bootserver=192.168.2.1, rootserver=192.168.2.1, rootpath=
Looking up port of RPC 100003/2 on 192.168.2.1
Looking up port of RPC 100005/1 on 192.168.2.1
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 168k freed
Linux video capture interface: v1.00
agpgart: Detected VIA KT400/KT400A/KT600 chipset
agpgart: AGP aperture is 32M @ 0xda000000
lirc_dev: IR Remote Control driver registered, at major 61
lirc_streamzap[-1]: Streamzap, Inc. Streamzap Remote Control on usb3:4 attached
lirc_dev: lirc_register_plugin: sample_rate: 0
usbcore: registered new driver lirc_streamzap
lirc_streamzap $Revision: 1.16 $ registered
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI Interrupt 0000:00:0c.0[A] -> GSI 16 (level, low) -> IRQ 16
bttv0: Bt878 (rev 17) at 0000:00:0c.0, irq: 16, latency: 32, mmio: 0xe0015000
bttv0: using: Twinhan DST + clones [card=113,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00f5abfd [init]
bttv0: using tuner=4
bttv0: add subdevice "dvb0"
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 17 (level, low) -> IRQ 17
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 20
ACPI: PCI Interrupt Link [ALKC] BIOS reported IRQ 0, using IRQ 22
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [ALKC] -> GSI 22 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:11.5 to 64
bt878: AUDIO driver version 0.0.0 loaded
bt878: Bt878 AUDIO function found (0).
ACPI: PCI Interrupt 0000:00:0c.1[A] -> GSI 16 (level, low) -> IRQ 16
bt878_probe: card id=[0x0],[ <NULL> ] has DVB functions.
bt878(0): Bt878 (rev 17) at 00:0c.1, irq: 16, latency: 32, memory: 0xe0014000
DVB: registering new adapter (bttv0).
dst_get_device_id: Recognise [DST-CI]

DST type flags : 0x1 newtuner 0x2 ts204 0x8 firmware version = 1
dst_get_mac: MAC Address=[00:08:ca:10:6b:00]
dst_ca_attach: registering DST-CA device
DVB: registering frontend 0 (DST DVB-S)...
lirc_serial: auto-detected active high receiver
lirc_dev: lirc_register_plugin: sample_rate: 0
mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
[drm] Initialized mga 3.2.1 20051102 on minor 0
agpgart: Found an AGP 3.5 compliant device at 0000:00:00.0.
agpgart: Device is in legacy mode, falling back to 2.x
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x1000000


Regards,
Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams

