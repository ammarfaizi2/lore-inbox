Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCZSwc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCZSwc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 13:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVCZSwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 13:52:32 -0500
Received: from evtexc08.relay.danahertm.com ([129.196.229.155]:21313 "EHLO
	evtexc08.relay.danahertm.com") by vger.kernel.org with ESMTP
	id S261228AbVCZSwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 13:52:07 -0500
Date: Sat, 26 Mar 2005 10:52:30 -0800 (PST)
From: David Dyck <david.dyck@fluke.com>
To: linux-kernel@vger.kernel.org
Subject: unresolved symbols still in 2.4.30-rc2 (usbserial needs symbol
 tty_ldisc_ref and tty_ldisc_deref which are EXPORT_SYMBOL_GPL)
Message-ID: <Pine.LNX.4.62.0503261052050.1495@dd.tc.fluke.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-OriginalArrivalTime: 26 Mar 2005 18:57:06.0533 (UTC) FILETIME=[9B044150:01C53235]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I've been noticing that I'm still getting some "unresolved symbols"
with the 2.4.30 pre and rc series.

# insmod /lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o
/lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o: unresolved 
symbol tty_ldisc_ref
/lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o: unresolved 
symbol tty_ldisc_deref

I see that the symbols are defined in the system.map

grep -i  ' T .*tty_ldisc_.*ref' System.map
c01daae8 T tty_ldisc_ref_wait
c01dab6c T tty_ldisc_ref
c01dab8c T tty_ldisc_deref

grep  'tty_ldisc_.*ref' /proc/ksyms
shows that the name changes in /proc/ksyms to:
c01daae8 tty_ldisc_ref_wait_R__ver_tty_ldisc_ref_wait
c01dab6c tty_ldisc_ref_R__ver_tty_ldisc_ref
c01dab8c tty_ldisc_deref_R__ver_tty_ldisc_deref


# nm -og /lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o | grep 
'tty_ldisc_.*ref'
/lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o:         U 
tty_ldisc_deref
/lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o:         U 
tty_ldisc_ref

If I just look at the symbol tty_ldisc_deref I find that
usbserial is the only module I am using that is referencing in.
  find $PWD -name '*.o' | xargs nm -og | grep  tty_ldisc_dere
/lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o:         U 
tty_ldisc_deref

grepping around in the kernel tree I see it exported from  tty_io.c as:
EXPORT_SYMBOL_GPL(tty_ldisc_deref);

Why are some of the tty_ symbols exported _GPL, and others not?

Shouldn't I be able to build the usbserial driver as a module?
 	CONFIG_USB_SERIAL=m

I just checked and ALL the modules I'm loading are GPL
  find /lib/modules/2.4.30-rc2 -name '*.o' | xargs modinfo -f 
'%{license}:%{filename}\n'

  ....
GPL:/lib/modules/2.4.30-rc2/kernel/drivers/usb/serial/usbserial.o
  ...


cat /proc/version
Linux version 2.4.30-rc2 (dcd@dd) (gcc version egcs-2.91.66.1 19990314/Linux 
(egcs-1.1.2 release)) #1 Sat Mar 26 08:52:31 PST 2005

ver_linux reports:
Gnu C                  egcs-2.91.66.1
Gnu make               3.79.1
binutils               2.10
util-linux             2.10o
mount                  2.10o
modutils               2.4.2
e2fsprogs              1.25
Linux C Library        5.4.44
ldd: version 1.9.9
Linux C++ Library      27.2.1
Linux C++ Library      27.2.1
Procps                 1.01
Net-tools              1.51
Kbd                    0.89
Sh-utils               2.0
Modules Loaded         usb-uhci usbcore 3c59x


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 397.333
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 mmx fxsr
bogomips	: 792.98


# grep = .config

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_NOHIGHMEM=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_STATS=y
CONFIG_PACKET=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_PHONE=m
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
CONFIG_BLK_DEV_CMD640=y
CONFIG_BLK_DEV_CMD640_ENHANCED=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_RZ1000=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_EL3=y
CONFIG_VORTEX=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_NONSTANDARD=y
CONFIG_CYCLADES=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_NVRAM=m
CONFIG_RTC=m
CONFIG_VIDEO_DEV=m
CONFIG_AUTOFS_FS=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_JBD_DEBUG=y
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_JFS_FS=y
CONFIG_JFS_DEBUG=y
CONFIG_JFS_STATISTICS=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_UNIX=y
CONFIG_ZISOFS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_CS4232=m
CONFIG_SOUND_VMIDI=m
CONFIG_SOUND_SB=m
CONFIG_SOUND_YM3812=m
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_STV680=m
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
CONFIG_USB_SERIAL_BELKIN=m
CONFIG_USB_SERIAL_VISOR=m
CONFIG_USB_SERIAL_PL2303=m
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=0
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=m
