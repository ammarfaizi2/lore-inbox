Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbUKBME5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbUKBME5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 07:04:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUKBME5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 07:04:57 -0500
Received: from wasp.net.au ([203.190.192.17]:13242 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S261203AbUKBMBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 07:01:50 -0500
Message-ID: <41877751.502@wasp.net.au>
Date: Tue, 02 Nov 2004 16:02:25 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.8+ (X11/20041029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: nfs stale filehandle issues with 2.6.10-rc1 in-kernel server
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day all,

While load testing for the page allocation failure errors, I managed to reasonably reliably 
reproduce an error that has been annoying me for a while with nfs.

I have 2 Machines. My server is running 2.6.10-rc1-BK as per a couple of days ago, but this has 
happened with 2.6.9-pre3 also.

Server :
Kernel - 2.6.10-rc1-BK
IP - 192.168.2.82
Interface - eth1 to Client. eth0 idle

Client :
Kernel - 2.4.26 (Highmem enabled)
IP - 192.168.2.81
Interface - eth0 to Server. eth1 to world

MTU == 9000
NFS mounted using tcp with w/rsize == 32768

The client boots of a usb keystick with loadlin and runs an NFS root from the server.

The issue is I randomly get files just return with "Stale NFS file handle"
merely doing a cd .. ; cd $OLDPWD will make them work again. Sometimes they come back by themselves.

I'm running Debian Sarge on both machines and using the kernel-nfs server compiled in rather than 
modular.

Using the same client, unmodified with a 2.6.5 kernel on the server, I never saw any of these issues 
in over three months of heavy use.

brad@tv:/raid2$ while true ; do dd if=/dev/zero of=test.1 bs=1M count=1000 ; done
dd: writing `test.1': Stale NFS file handle
dd: closing output file `test.1': Stale NFS file handle
dd: writing `test.1': Stale NFS file handle
dd: closing output file `test.1': Stale NFS file handle


Am I doing something stupid? Have I included all relevant information?

Regards,
Brad

--------------------Server Files-----------------------------

brad@srv:/raid/tobackup/dvd$ uname -a
Linux srv 2.6.10-rc1 #4 Tue Nov 2 14:55:49 GST 2004 i686 GNU/Linux

brad@srv:~$ cat /proc/cmdline
vga=1 console=ttyS0,38400 console=tty0 root=/dev/hda1

brad@srv:/raid/tobackup/dvd$ cat /etc/exports
# /etc/exports: the access control list for filesystems which may be exported
#               to NFS clients.  See exports(5).

/raid 192.168.2.81(rw,async,no_root_squash)
/raid 192.168.3.80(rw,async,no_root_squash)
/raid0 192.168.2.81(rw,async,no_root_squash)
/raid0/tmp 192.168.2.81(rw,async,no_root_squash)
/raid2 192.168.2.81(rw,async,no_root_squash)
/raid2 192.168.3.80(rw,async,no_root_squash)
/nfsroot 192.168.2.81(rw,async,no_root_squash)

brad@srv:~$ mount
/dev/hda1 on / type ext3 (rw,errors=remount-ro)
proc on /proc type proc (rw)
/sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
/dev/hda3 on /raid0 type ext3 (rw)
none on /proc/fs/nfsd type nfsd (rw)
none on /sysfs type sysfs (rw)
/dev/md0 on /raid type ext3 (rw)
/dev/md2 on /raid2 type ext3 (rw)

brad@srv:~$ cat /etc/hosts
127.0.0.1       srv     localhost
192.168.2.81    tv
192.168.3.80    bklaptop1

brad@srv:/raid/tobackup/dvd$ exportfs
/raid0/nfsroot  tv
/raid0/tmp      tv
/raid0          tv
/raid2          tv
/raid2          bklaptop1
/raid           tv
/raid           bklaptop1

brad@srv:/raid/tobackup/dvd$ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:0E:A6:41:45:94
           inet addr:192.168.3.82  Bcast:192.168.3.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
           Interrupt:18 Memory:de800000-0

eth1      Link encap:Ethernet  HWaddr 00:04:E2:8E:1E:AD
           inet addr:192.168.2.82  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:9000  Metric:1
           RX packets:15403785 errors:0 dropped:0 overruns:0 frame:0
           TX packets:14267922 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:1831885829 (1.7 GiB)  TX bytes:3547388866 (3.3 GiB)
           Interrupt:16 Memory:dc800000-0

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:66 errors:0 dropped:0 overruns:0 frame:0
           TX packets:66 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:4600 (4.4 KiB)  TX bytes:4600 (4.4 KiB)

brad@srv:~$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:09.0 Ethernet controller: 3Com Corporation 3c940 10/100/1000Base-T [Marvell] (rev 12)
0000:00:0b.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 12)
0000:00:0e.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:00:0f.0 RAID bus controller: VIA Technologies, Inc. VIA VT6420 SATA RAID Controller (rev 80)
0000:00:0f.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:13.0 Unknown mass storage controller: Promise Technology, Inc. PDC20318 (SATA150 TX4) (rev 02)
0000:01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 315PRO PCI/AGP VGA Display 
Adapter

brad@srv:~$ lsmod
Module                  Size  Used by
ehci_hcd               39492  0
uhci_hcd               30988  0
usbcore               118072  3 ehci_hcd,uhci_hcd
it87                   22124  0
i2c_sensor              3072  1 it87
i2c_isa                 1728  0
ohci1394               31556  0
ieee1394              307764  1 ohci1394
sk98lin               167016  2

CONFIG_X86=y
CONFIG_MMU=y
CONFIG_UID16=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_IOMAP=y
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_LOCK_KERNEL=y
CONFIG_LOCALVERSION=""
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_POSIX_MQUEUE=y
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=20
CONFIG_HOTPLUG=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_EXTRA_PASS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_MODULES=y
CONFIG_MODULE_UNLOAD=y
CONFIG_OBSOLETE_MODPARM=y
CONFIG_KMOD=y
CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_PREEMPT=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PM=y
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_BLACKLIST_YEAR=0
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
CONFIG_PCI=y
CONFIG_PCI_GOBIOS=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_LEGACY_PROC=y
CONFIG_PCI_NAMES=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_LBD=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
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
CONFIG_BLK_DEV_SR=y
CONFIG_CHR_DEV_SG=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SATA=y
CONFIG_SCSI_SATA_PROMISE=y
CONFIG_SCSI_SATA_VIA=y
CONFIG_SCSI_QLA2XXX=y
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID5=y
CONFIG_MD_RAID6=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OUI_DB=y
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_NET=y
CONFIG_PACKET=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_BRIDGE=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_SK98LIN=m
CONFIG_TIGON3=m
CONFIG_INPUT=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_RTC=y
CONFIG_HPET=y
CONFIG_HPET_MMAP=y
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_ALGOBIT=y
CONFIG_I2C_ISA=m
CONFIG_I2C_SENSOR=m
CONFIG_SENSORS_IT87=m
CONFIG_VIDEO_SELECT=y
CONFIG_VGA_CONSOLE=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_USB=m
CONFIG_USB_DEBUG=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_HCD=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_EXT2_FS=y
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_JBD=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_DNOTIFY=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_UDF_FS=y
CONFIG_UDF_NLS=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_SYSFS=y
CONFIG_DEVFS_FS=y
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
CONFIG_NLS_ISO8859_1=y
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_EARLY_PRINTK=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y
CONFIG_CRYPTO=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_DES=y
CONFIG_CRC32=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_PC=y

--------------------Client Files------------------------------

brad@tv:/raid2$ uname -a
Linux tv 2.4.26-hm #2 Mon Aug 23 18:13:02 GST 2004 i686 GNU/Linux

brad@tv:~$ cat /proc/cmdline
root=/dev/nfs 
video=matrox:xres:1024,yres:768,pixclock:15386,left:160,right:24,upper:29,lower:3,hslen:132,vslen:6,depth:8 
nfsroot=192.168.2.82:/nfsroot,rsize=32768,wsize=32768,tcp 
ip=192.168.2.81:192.168.2.82::255.255.255.0:tv clock=pit panic=15 BOOT_IMAG

brad@tv:/raid2$ cat /etc/fstab
# /etc/fstab: static file system information.
#
# <file system> <mount point>   <type>  <options>               <dump>  <pass>
192.168.2.82:/nfsroot   / nfs   rw                              1       1
proc            /proc           proc    defaults                0       0
none            /dev/devfs      devfs   defaults
192.168.2.82:/raid /raid        nfs     rsize=32768,wsize=32768,tcp     0      0
192.168.2.82:/raid0/tmp /raid0  nfs     rsize=32768,wsize=32768,tcp     0      0
none  /proc/bus/usb  usbdevfs  defaults                           0      0
192.168.2.82:/raid2 /raid2      nfs     rsize=32768,wsize=32768,tcp     0      0
none    /tmp    tmpfs   defaults,size=512M                        0      0

brad@tv:/raid2$ mount
192.168.2.82:/nfsroot on / type nfs (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw)
none on /dev/devfs type devfs (rw)
none on /proc/bus/usb type usbdevfs (rw)
none on /tmp type tmpfs (rw,size=512M)
192.168.2.82:/raid on /raid type nfs (rw,rsize=32768,wsize=32768,tcp,addr=192.168.2.82)
192.168.2.82:/raid0/tmp on /raid0 type nfs (rw,rsize=32768,wsize=32768,tcp,addr=192.168.2.82)
192.168.2.82:/raid2 on /raid2 type nfs (rw,rsize=32768,wsize=32768,tcp,addr=192.168.2.82)

brad@tv:/raid2$ ifconfig
eth0      Link encap:Ethernet  HWaddr 00:04:E2:8E:1E:65
           inet addr:192.168.2.81  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:55678032 errors:0 dropped:0 overruns:0 frame:0
           TX packets:68316272 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:4155793385 (3.8 GiB)  TX bytes:3579805141 (3.3 GiB)
           Interrupt:17 Memory:dd000000-0

eth1      Link encap:Ethernet  HWaddr 00:05:5D:5B:C5:4E
           inet addr:192.168.2.81  Bcast:192.168.2.255  Mask:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:2182660 errors:0 dropped:0 overruns:0 frame:0
           TX packets:2465204 errors:17 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:1000
           RX bytes:995104632 (949.0 MiB)  TX bytes:1197365443 (1.1 GiB)
           Interrupt:17 Memory:dd008000-dd008fff

lo        Link encap:Local Loopback
           inet addr:127.0.0.1  Mask:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:27 errors:0 dropped:0 overruns:0 frame:0
           TX packets:27 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:0
           RX bytes:1908 (1.8 KiB)  TX bytes:1908 (1.8 KiB)

brad@tv:~$ route -n
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
192.168.2.82    0.0.0.0         255.255.255.255 UH    0      0        0 eth0
192.168.2.0     0.0.0.0         255.255.255.0   U     0      0        0 eth1
0.0.0.0         192.168.2.3     0.0.0.0         UG    0      0        0 eth1

brad@tv:/usr/src/linux$ lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge (rev 80)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI Bridge
0000:00:09.0 Network controller: Intersil Corporation Prism 2.5 Wavelan chipset (rev 01)
0000:00:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:00:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 0a)
0000:00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 0a)
0000:00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture (rev 11)
0000:00:0c.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 11)
0000:00:0d.0 Ethernet controller: Marvell Technology Group Ltd. Yukon Gigabit Ethernet 
10/100/1000Base-T Adapter (rev 12)
0000:00:0f.0 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus 
Master IDE (rev 06)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 81)
0000:00:10.4 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 86)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8237 ISA bridge [K8T800 South]
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio 
Controller (rev 60)
0000:01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 82)

brad@tv:~$ lsmod
Module                  Size  Used by    Not tainted
iptable_filter          1772   0 (autoclean) (unused)
ide-cd                 32096   0 (autoclean)
cdrom                  28352   0 (autoclean) [ide-cd]
isofs                  27124   0 (autoclean)
zlib_inflate           18308   0 (autoclean) [isofs]
lirc_serial             7296   0 (unused)
ipt_MASQUERADE          1400   0 (autoclean)
iptable_nat            16814   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack           20004   0 (autoclean) [ipt_MASQUERADE iptable_nat]
ip_tables              12416   5 [iptable_filter ipt_MASQUERADE iptable_nat]
nbd                    15300   0 (autoclean) (unused)
usb-storage            26512   0 (unused)
scsi_mod               86692   1 [usb-storage]
mousedev                4148   1
uhci                   25372   0 (unused)
ehci-hcd               18156   0 (unused)
snd-via82xx            14180   0
snd-mpu401-uart         3488   0 [snd-via82xx]
tun                     4256   0 (unused)
ide-detect               288   0 (unused)
via82cxxx              10696   1
ide-core              106556   0 [ide-cd ide-detect via82cxxx]
dvb-bt8xx               4220   0 (unused)
dst                    10612   1
bt878                   5424   0 [dvb-bt8xx dst]
dvb-core               41760   0 [dvb-bt8xx dst]
tuner                  14252   1 (autoclean)
bttv                  115372   0 [dvb-bt8xx bt878]
video-buf              11888   0 [bttv]
btcx-risc               2328   0 [bttv]
i2c-algo-bit            7464   0 [bttv]
i2c-core               14820   0 [dvb-bt8xx tuner bttv i2c-algo-bit]
videodev                4416   3 [bttv]
v4l2-common             3168   0 [bttv]
lirc_streamzap          7036   0
lirc_dev                8756   2 [lirc_serial lirc_streamzap]
uinput                  4000   0
joydev                  5952   0 (unused)
keybdev                 2212   0 (unused)
hid                    21764   0 (unused)
input                   3328   0 [mousedev uinput joydev keybdev hid]
snd-usb-audio          43136   0
snd-usb-lib             8612   0 [snd-usb-audio]
usbcore                62380   1 [usb-storage uhci ehci-hcd lirc_streamzap hid snd-usb-audio 
snd-usb-lib]
snd-emu10k1            76904   0
snd-pcm-oss            37928   0
snd-mixer-oss          13688   0 [snd-pcm-oss]
snd-hwdep               5252   0 [snd-emu10k1]
snd-util-mem            1296   0 [snd-emu10k1]
snd-ac97-codec         57728   0 [snd-via82xx snd-emu10k1]
snd-pcm                59624   0 [snd-via82xx snd-usb-audio snd-emu10k1 snd-pcm-oss snd-ac97-codec]
snd-timer              14596   0 [snd-pcm]
snd-rawmidi            13572   0 [snd-mpu401-uart snd-usb-lib snd-emu10k1]
snd-seq-device          4436   0 [snd-emu10k1 snd-rawmidi]
snd                    34820   0 [snd-via82xx snd-mpu401-uart snd-usb-audio snd-usb-lib snd-emu10k1 
snd-pcm-oss snd-mixer-oss snd-hwdep snd-util-mem snd-ac97-codec snd-pcm snd-timer snd-rawmidi 
snd-seq-device]
soundcore               3780  10 [snd]
snd-page-alloc          5260   0 [snd-via82xx snd-usb-audio snd-emu10k1 snd-mixer-oss snd-hwdep 
snd-pcm snd-timer snd-rawmidi snd-seq-device snd]
orinoco_pci             3268   1
orinoco                34836   0 [orinoco_pci]
hermes                  5572   0 [orinoco_pci orinoco]
mga_vid                 9952   0 (unused)
rtc                     7048   0 (autoclean)

CONFIG_X86=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
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
CONFIG_ACPI_BUTTON=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_PACKET=y
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_PNP=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_LOCAL=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IDE=m
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_IDEDMA_AUTO=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
CONFIG_IEEE1394=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_SBP2=m
CONFIG_IEEE1394_OUI_DB=y
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_EEPRO100=y
CONFIG_SK98LIN=y
CONFIG_NET_RADIO=y
CONFIG_HERMES=m
CONFIG_PCI_HERMES=m
CONFIG_NET_WIRELESS=y
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_UINPUT=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_HW_RANDOM=y
CONFIG_RTC=m
CONFIG_AGP=y
CONFIG_AGP_VIA=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m
CONFIG_VIDEO_DEV=m
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_NTFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=m
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
CONFIG_ROOT_NFS=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_ZISOFS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G450=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_PROC=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_SOUND=m
CONFIG_SOUND_VIA82CXXX=m
CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_STORAGE=m
CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y
CONFIG_USB_USBNET=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_LOG_BUF_SHIFT=0
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=m
CONFIG_ZLIB_DEFLATE=y
CONFIG_FW_LOADER=y

