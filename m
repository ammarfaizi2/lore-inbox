Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132817AbRAQUkK>; Wed, 17 Jan 2001 15:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135431AbRAQUkA>; Wed, 17 Jan 2001 15:40:00 -0500
Received: from chaos.analogic.com ([204.178.40.224]:29060 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S132817AbRAQUjr>; Wed, 17 Jan 2001 15:39:47 -0500
Date: Wed, 17 Jan 2001 15:39:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.0.4 has FS corruption (not IDE) 
Message-ID: <Pine.LNX.3.95.1010117153603.9079A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I lost my root file-system last night to massive corruption
occurring while doing a automatic `tar` backup to tape.
Some corruption probably occurred while the ATIME was being
updated because most of the tape was good. Basically, e2fsck
could not recognize a valid file system.  `od /dev/sdc1`
showed a repeated pattern, consisting of a repeated file-name
plus some junk, propigated throughout much of the disk.

I built a new file-system a restored stuff from the previous
night's backup. I will restore yesterday's work later. I started
to check for some kind of race and found one.

Linux kernel version 2.4.0 SMP has an easily duplicated race
of some kind:

cat /dev/zero >/tmp/foo            # Fill up a disk
cat /dev/zero >/another/disk/foo & # Let another fill up
rm /tmp/foo                        #  Locks in 'D' state forever.

There is no I/O to either disk. The 'D' state processes can't be
killed, and the disk can't be unmounted.

Upon reboot, the file-system is okay, `e2fsck` was able to put all
the junk from /tmp/foo into "lost+found", etc. So this was not the
cause of the FS corruption. However, this points out some kind of
deadlock where a task attempting to delete a file from a full disk
remains in 'D' state and no actual Disk I/O occurs.

grep =y /usr/src/linux/.config

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_KMOD=y
CONFIG_M486=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_USE_STRING_486=y
CONFIG_X86_ALIGNMENT_16=y
CONFIG_NOHIGHMEM=y
CONFIG_SMP=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT_OTHER=y
CONFIG_PNP=y
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IPV6_EUI64=y
CONFIG_IPX_INTERN=y
CONFIG_AIC7XXX_TCQ_ON_BY_DEFAULT=y
CONFIG_AIC7XXX_PROC_STATS=y
CONFIG_SCSI_OMIT_FLASHPOINT=y
CONFIG_SCSI_EATA_TAGGED_QUEUE=y
CONFIG_SCSI_G_NCR5380_PORT=y
CONFIG_IEEE1394_PCILYNX_LOCALRAM=y
CONFIG_NETDEVICES=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_NET_ISA=y
CONFIG_NET_PCI=y
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
CONFIG_UNIX98_PTYS=y
CONFIG_RTC=y
CONFIG_FT_NORMAL_DEBUG=y
CONFIG_FT_STD_FDC=y
CONFIG_QUOTA=y
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_JOLIET=y
CONFIG_NTFS_RW=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_RW=y
CONFIG_EXT2_FS=y
CONFIG_NCPFS_PACKET_SIGNING=y
CONFIG_NCPFS_IOCTL_LOCKING=y
CONFIG_NCPFS_STRONG=y
CONFIG_NCPFS_NFS_NS=y
CONFIG_NCPFS_OS2_NS=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_MAGIC_SYSRQ=y

grep =m /usr/src/linux/.config
CONFIG_TOSHIBA=m
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_MISC=m
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_BLK_DEV_XD=m
CONFIG_PARIDE=m
CONFIG_PARIDE_PARPORT=m
CONFIG_PARIDE_PD=m
CONFIG_PARIDE_PCD=m
CONFIG_PARIDE_PF=m
CONFIG_PARIDE_PT=m
CONFIG_PARIDE_PG=m
CONFIG_PARIDE_ATEN=m
CONFIG_PARIDE_BPCK=m
CONFIG_PARIDE_COMM=m
CONFIG_PARIDE_DSTR=m
CONFIG_PARIDE_FIT2=m
CONFIG_PARIDE_FIT3=m
CONFIG_PARIDE_EPAT=m
CONFIG_PARIDE_EPIA=m
CONFIG_PARIDE_FRIQ=m
CONFIG_PARIDE_FRPW=m
CONFIG_PARIDE_KBIC=m
CONFIG_PARIDE_KTTI=m
CONFIG_PARIDE_ON20=m
CONFIG_PARIDE_ON26=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_IPV6=m
CONFIG_IPX=m
CONFIG_X25=m
CONFIG_LAPB=m
CONFIG_ECONET=m
CONFIG_WAN_ROUTER=m
CONFIG_PHONE=m
CONFIG_PHONE_IXJ=m
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_3W_XXXX_RAID=m
CONFIG_SCSI_7000FASST=m
CONFIG_SCSI_ACARD=m
CONFIG_SCSI_AHA152X=m
CONFIG_SCSI_AHA1542=m
CONFIG_SCSI_AHA1740=m
CONFIG_SCSI_AIC7XXX=m
CONFIG_SCSI_ADVANSYS=m
CONFIG_SCSI_IN2000=m
CONFIG_SCSI_AM53C974=m
CONFIG_SCSI_BUSLOGIC=m
CONFIG_SCSI_DTC3280=m
CONFIG_SCSI_EATA=m
CONFIG_SCSI_EATA_DMA=m
CONFIG_SCSI_EATA_PIO=m
CONFIG_SCSI_FUTURE_DOMAIN=m
CONFIG_SCSI_GDTH=m
CONFIG_SCSI_GENERIC_NCR5380=m
CONFIG_SCSI_INITIO=m
CONFIG_SCSI_INIA100=m
CONFIG_SCSI_PPA=m
CONFIG_SCSI_IMM=m
CONFIG_SCSI_NCR53C406A=m
CONFIG_SCSI_NCR53C7xx=m
CONFIG_SCSI_NCR53C8XX=m
CONFIG_SCSI_PAS16=m
CONFIG_SCSI_QLOGIC_FAS=m
CONFIG_SCSI_QLOGIC_ISP=m
CONFIG_SCSI_QLOGIC_FC=m
CONFIG_SCSI_SEAGATE=m
CONFIG_SCSI_SYM53C416=m
CONFIG_SCSI_DC390T=m
CONFIG_SCSI_T128=m
CONFIG_SCSI_U14_34F=m
CONFIG_SCSI_ULTRASTOR=m
CONFIG_SCSI_DEBUG=m
CONFIG_IEEE1394=m
CONFIG_IEEE1394_PCILYNX=m
CONFIG_IEEE1394_OHCI1394=m
CONFIG_IEEE1394_RAWIO=m
CONFIG_ARCNET=m
CONFIG_ARCNET_COM90xx=m
CONFIG_ARCNET_COM90xxIO=m
CONFIG_ARCNET_RIM_I=m
CONFIG_ARCNET_COM20020=m
CONFIG_DUMMY=m
CONFIG_EQUALIZER=m
CONFIG_ETHERTAP=m
CONFIG_EL2=m
CONFIG_ELPLUS=m
CONFIG_EL16=m
CONFIG_EL3=m
CONFIG_3C515=m
CONFIG_VORTEX=m
CONFIG_LANCE=m
CONFIG_DEPCA=m
CONFIG_HP100=m
CONFIG_E2100=m
CONFIG_EEXPRESS=m
CONFIG_EEXPRESS_PRO=m
CONFIG_HPLAN_PLUS=m
CONFIG_HPLAN=m
CONFIG_ETH16I=m
CONFIG_NE2000=m
CONFIG_PCNET32=m
CONFIG_PCNET32_SEEPROM=m
CONFIG_ADAPTEC_STARFIRE=m
CONFIG_AC3200=m
CONFIG_APRICOT=m
CONFIG_CS89x0=m
CONFIG_TULIP=m
CONFIG_DE4X5=m
CONFIG_DGRS=m
CONFIG_DM9102=m
CONFIG_EEPRO100=m
CONFIG_NATSEMI=m
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m
CONFIG_RTL8129=m
CONFIG_SIS900=m
CONFIG_EPIC100=m
CONFIG_SUNDANCE=m
CONFIG_TLAN=m
CONFIG_VIA_RHINE=m
CONFIG_WINBOND_840=m
CONFIG_ACENIC=m
CONFIG_HAMACHI=m
CONFIG_YELLOWFIN=m
CONFIG_PLIP=m
CONFIG_PPP=m
CONFIG_SLIP=m
CONFIG_RCPCI=m
CONFIG_SHAPER=m
CONFIG_PRINTER=m
CONFIG_QIC02_TAPE=m
CONFIG_NVRAM=m
CONFIG_FTAPE=m
CONFIG_ZFTAPE=m
CONFIG_ZFT_COMPRESSOR=m
CONFIG_AUTOFS_FS=m
CONFIG_ADFS_FS=m
CONFIG_AFFS_FS=m
CONFIG_VFAT_FS=m
CONFIG_EFS_FS=m
CONFIG_ISO9660_FS=m
CONFIG_MINIX_FS=m
CONFIG_NTFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_QNX4FS_FS=m
CONFIG_ROMFS_FS=m
CONFIG_SYSV_FS=m
CONFIG_UFS_FS=m
CONFIG_CODA_FS=m
CONFIG_NFS_FS=m
CONFIG_NFSD=m
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_SMB_FS=m
CONFIG_NCP_FS=m
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_MDA_CONSOLE=m

cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST32171W         Rev: 0484
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: Quantum  Model: XP32150W         Rev: L912
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST39102LW        Rev: 0005
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: EXABYTE  Model: EXB-82058VQANXR1 Rev: 07T0
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: YAMAHA   Model: CRW6416S         Rev: 1.0b
  Type:   CD-ROM                           ANSI SCSI revision: 02

cat /proc/scsi/BusLogic/0
***** BusLogic SCSI Driver Version 2.1.15 of 17 August 1998 *****
Copyright 1995-1998 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring BusLogic Model BT-958 PCI Wide Ultra SCSI Host Adapter
  Firmware Version: 5.06J, I/O Address: 0xB800, IRQ Channel: 11/Level
  PCI Bus: 0, Device: 12, Address: 0xE1000000, Host Adapter SCSI ID: 7
  Parity Checking: Enabled, Extended Translation: Enabled
  Synchronous Negotiation: UUUUUUF#UUUUUUUU, Wide Negotiation: Enabled
  Disconnect/Reconnect: Enabled, Tagged Queuing: Enabled
  Scatter/Gather Limit: 128 of 8192 segments, Mailboxes: 211
  Driver Queue Depth: 211, Host Adapter Queue Depth: 192
  Tagged Queue Depth: Automatic, Untagged Queue Depth: 3
  Error Recovery Strategy: Default, SCSI Bus Reset: Enabled
  SCSI Bus Termination: High Enabled, SCAM: Disabled
*** BusLogic BT-958 Initialized Successfully ***

Target 0: Queue Depth 28, Wide Synchronous at 40.0 MB/sec, offset 15
Target 1: Queue Depth 28, Wide Synchronous at 20.0 MB/sec, offset 15
Target 2: Queue Depth 28, Wide Synchronous at 40.0 MB/sec, offset 15
Target 3: Queue Depth 3, Synchronous at 5.00 MB/sec, offset 11
Target 4: Queue Depth 3, Synchronous at 10.0 MB/sec, offset 15

Current Driver Queue Depth:	211
Currently Allocated CCBs:	98


			   DATA TRANSFER STATISTICS

Target	Tagged Queuing	Queue Depth  Active  Attempted	Completed
======	==============	===========  ======  =========	=========
   0	    Active	     28         0        60810	    60810
   1	  Permitted	     28         0           20	       20
   2	    Active	     28         0      1603717	  1603717
   3	Not Supported	      3         0       152448	   152448
   4	Not Supported	      3         0          847	      847

Target  Read Commands  Write Commands   Total Bytes Read    Total Bytes Written
======  =============  ==============  ===================  ===================
   0	      59753	      1051		333621248	       8158720
   1	         13	         1		    73728	          1024
   2	    1395658	    208053            15693033472           1544245248
   3	          0	    152354		        0           4680273920
   4	          0	       683		        0	      22368256

Target  Command    0-1KB      1-2KB      2-4KB      4-8KB     8-16KB
======  =======  =========  =========  =========  =========  =========
   0	 Read	     24838       7541       7674       9057       4353
   0	 Write	       361        289        160         86         43
   1	 Read	         0         12          0          0          0
   1	 Write	         0          1          0          0          0
   2	 Read	         0          4          0     989203     140729
   2	 Write	         0          0          0     163796      35065
   3	 Read	         0          0          0          0          0
   3	 Write	         0          0          0          0          0
   4	 Read	         0          0          0          0          0
   4	 Write	         0          0          0          0          0

Target  Command   16-32KB    32-64KB   64-128KB   128-256KB   256KB+
======  =======  =========  =========  =========  =========  =========
   0	 Read	      4598       1123        569          0          0
   0	 Write	        47         21         44          0          0
   1	 Read	         0          1          0          0          0
   1	 Write	         0          0          0          0          0
   2	 Read	    186670      36420      42632          0          0
   2	 Write	      4198       1443       3551          0          0
   3	 Read	         0          0          0          0          0
   3	 Write	    152354          0          0          0          0
   4	 Read	         0          0          0          0          0
   4	 Write	         1        682          0          0          0


			   ERROR RECOVERY STATISTICS

	  Command Aborts      Bus Device Resets	  Host Adapter Resets
Target	Requested Completed  Requested Completed  Requested Completed
  ID	\\\\ Attempted ////  \\\\ Attempted ////  \\\\ Attempted ////
======	 ===== ===== =====    ===== ===== =====	   ===== ===== =====
   0	     0     0     0        0     0     0	       0     0     0
   1	     0     0     0        0     0     0	       0     0     0
   2	     0     0     0        0     0     0	       0     0     0
   3	     0     0     0        0     0     0	       0     0     0
   4	     0     0     0        0     0     0	       0     0     0

External Host Adapter Resets: 0
Host Adapter Internal Errors: 0

cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 400.916
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 799.53

processor	: 1
vendor_id	: GenuineIntel
cpu family	: 6
model		: 5
model name	: Pentium II (Deschutes)
stepping	: 1
cpu MHz		: 400.916
cache size	: 512 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 801.17

cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Class 0600: PCI device 8086:7190 (rev 2).
      Master Capable.  Latency=64.  
      Prefetchable 32 bit memory at 0xe6000000 [0xe7ffffff].
  Bus  0, device   1, function  0:
    Class 0604: PCI device 8086:7191 (rev 2).
      Master Capable.  Latency=64.  Min Gnt=128.
  Bus  0, device   4, function  0:
    Class 0601: PCI device 8086:7110 (rev 2).
  Bus  0, device   4, function  1:
    Class 0101: PCI device 8086:7111 (rev 1).
      Master Capable.  Latency=32.  
      I/O at 0xd800 [0xd80f].
  Bus  0, device   4, function  2:
    Class 0c03: PCI device 8086:7112 (rev 1).
      IRQ 12.
      Master Capable.  Latency=32.  
      I/O at 0xd400 [0xd41f].
  Bus  0, device   4, function  3:
    Class 0680: PCI device 8086:7113 (rev 2).
  Bus  0, device   9, function  0:
    Class 0300: PCI device 5333:88f0 (rev 0).
      IRQ 12.
      Non-prefetchable 32 bit memory at 0x14000000 [0x17ffffff].
  Bus  0, device  11, function  0:
    Class 0200: PCI device 10b7:9055 (rev 100).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0xd000 [0xd07f].
      Non-prefetchable 32 bit memory at 0xe1800000 [0xe180007f].
  Bus  0, device  12, function  0:
    Class 0100: PCI device 104b:1040 (rev 8).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=8.
      I/O at 0xb800 [0xb803].
      Non-prefetchable 32 bit memory at 0xe1000000 [0xe1000fff].

cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  328060928 324210688  3850240        0 13541376 213356544
Swap: 139821056        0 139821056
MemTotal:       320372 kB
MemFree:          3760 kB
MemShared:           0 kB
Buffers:         13224 kB
Cached:         208356 kB
Active:           6556 kB
Inact_dirty:    211536 kB
Inact_clean:      3488 kB
Inact_target:        0 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       320372 kB
LowFree:          3760 kB
SwapTotal:      136544 kB
SwapFree:       136544 kB


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
