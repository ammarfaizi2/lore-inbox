Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277228AbRJ0Vp2>; Sat, 27 Oct 2001 17:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277210AbRJ0VpU>; Sat, 27 Oct 2001 17:45:20 -0400
Received: from carbon.btinternet.com ([194.73.73.92]:54725 "EHLO
	carbon.btinternet.com") by vger.kernel.org with ESMTP
	id <S277188AbRJ0VpH>; Sat, 27 Oct 2001 17:45:07 -0400
Date: Sat, 27 Oct 2001 22:43:10 +0100
From: Adam Sampson <azz@gnu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.12-ac3 reiserfs oops when unlinking large file
Message-ID: <20011027224310.A831@cartman.azz.us-lot.org>
Mail-Followup-To: Adam Sampson <azz@gnu.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Homepage: http://azz.us-lot.org/
X-Message: You appear to be using Outlook.
X-Planation: RSA in 2 lines Perl: see http://dcs.ex.ac.uk/~aba/x.html
X-Munition-Export: print pack"C*",split/\D+/,`echo "16iII*o\U@{$/=$z;[(pop,pop,unpack"H*",<>)]}\EsMsKsN0[lN*1lK[d2%Sa2/d0<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<J]dsJxp"|dc`
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just got the following oops while unlinking a large file from a "full"
reiserfs partition. I'd created a large tarfile as a normal user which had
filled up the filesystem; I ran "rm backup.tar.gz", and it churned away for a
few seconds then oopsed (the rm died with a segfault). Further attempts to use
the filesystem hung. On reboot, the journal was replayed and the file
successfully removed.

Kernel version:
Linux cartman.azz.us-lot.org 2.4.12-ac3 #1 Sun Oct 21 04:41:43 BST 2001 i586
unknown

GCC 2.95.3, binutils 2.11.2.

Filesystem (after reboot and journal replay):
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hde2             18994648  18365944    628704  97% /20g

Extra modules loaded: mga_vid from MPlayer 0.50pre1, lirc_i2c from lirc 0.6.4. 

The oops, decoded with ksymoops:

ksymoops 2.4.3 on i586 2.4.12-ac3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.12-ac3/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000018
c0167cb0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0167cb0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013246
eax: c9274800   ebx: 00000000   ecx: 00000000   edx: 63d0065f
esi: 00000001   edi: 0000dae4   ebp: c9274c00   esp: c2ebbbdc
ds: 0018   es: 0018   ss: 0018
Process rm (pid: 10782, stackpage=c2ebb000)
Stack: c9274800 6d726f66 c014d436 c9274800 00000000 00000001 c2ebbf40 c9274800 
       6d726f66 c8b44e40 c147bffc 6d726f66 00000000 00006f66 c91e5840 c911e000 
       c016177c c2ebbf40 6d726f66 c2ebbcbc c2ebbe9c 000000b4 c2ebbe5c 00000001 
Call Trace: [<c014d436>] [<c016177c>] [<c01621c8>] [<c018f5fa>] [<c0162879>] 
   [<c0161e03>] [<c01528f7>] [<c013df83>] [<c013c7d8>] [<c01366a6>] [<c0136784>] 
   [<c0106b23>] 
Code: 8b 43 18 a9 00 00 10 00 74 b7 85 f6 74 06 f6 43 18 04 75 ad 

>>EIP; c0167cb0 <reiserfs_prepare_for_journal+58/70>   <=====
Trace; c014d436 <reiserfs_free_block+56/c4>
Trace; c016177c <prepare_for_delete_or_cut+734/80c>
Trace; c01621c8 <reiserfs_cut_from_item+94/430>
Trace; c018f5fa <do_rw_disk+13e/308>
Trace; c0162878 <reiserfs_do_truncate+2bc/3d8>
Trace; c0161e02 <reiserfs_delete_object+22/58>
Trace; c01528f6 <reiserfs_delete_inode+46/90>
Trace; c013df82 <iput+a2/158>
Trace; c013c7d8 <d_delete+4c/6c>
Trace; c01366a6 <vfs_unlink+f6/130>
Trace; c0136784 <sys_unlink+a4/118>
Trace; c0106b22 <system_call+32/40>
Code;  c0167cb0 <reiserfs_prepare_for_journal+58/70>
00000000 <_EIP>:
Code;  c0167cb0 <reiserfs_prepare_for_journal+58/70>   <=====
   0:   8b 43 18                  mov    0x18(%ebx),%eax   <=====
Code;  c0167cb2 <reiserfs_prepare_for_journal+5a/70>
   3:   a9 00 00 10 00            test   $0x100000,%eax
Code;  c0167cb8 <reiserfs_prepare_for_journal+60/70>
   8:   74 b7                     je     ffffffc1 <_EIP+0xffffffc1> c0167c70 <reiserfs_prepare_for_journal+18/70>
Code;  c0167cba <reiserfs_prepare_for_journal+62/70>
   a:   85 f6                     test   %esi,%esi
Code;  c0167cbc <reiserfs_prepare_for_journal+64/70>
   c:   74 06                     je     14 <_EIP+0x14> c0167cc4 <reiserfs_prepare_for_journal+6c/70>
Code;  c0167cbe <reiserfs_prepare_for_journal+66/70>
   e:   f6 43 18 04               testb  $0x4,0x18(%ebx)
Code;  c0167cc2 <reiserfs_prepare_for_journal+6a/70>
  12:   75 ad                     jne    ffffffc1 <_EIP+0xffffffc1> c0167c70 <reiserfs_prepare_for_journal+18/70>


1 warning issued.  Results may not be reliable.

My kernel configuration:

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y
CONFIG_EXPERIMENTAL=y
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y
CONFIG_MK6=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_ALIGNMENT_16=y
CONFIG_X86_TSC=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_NOHIGHMEM=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y
CONFIG_PNP=m
CONFIG_ISAPNP=m
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
CONFIG_SYN_COOKIES=y
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_COMPAT_IPCHAINS=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_COMPAT_IPFWADM=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IPX=m
CONFIG_ATALK=m
CONFIG_DECNET=m
CONFIG_ECONET=m
CONFIG_ECONET_AUNUDP=y
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_ALI15X3=y
CONFIG_IDE_CHIPSETS=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_PPA=m
CONFIG_NETDEVICES=y
CONFIG_DUMMY=m
CONFIG_TUN=m
CONFIG_ETHERTAP=m
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=m
CONFIG_AT1700=m
CONFIG_NET_ISA=y
CONFIG_NE2000=m
CONFIG_NET_PCI=y
CONFIG_8139TOO=m
CONFIG_PPP=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_SHAPER=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=m
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m
CONFIG_MOUSE=m
CONFIG_PSMOUSE=y
CONFIG_RTC=y
CONFIG_AGP=y
CONFIG_AGP_ALI=y
CONFIG_DRM=y
CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_PROC_FS=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_SAA5249=m
CONFIG_REISERFS_FS=y
CONFIG_ADFS_FS=m
CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_BFS_FS=m
CONFIG_CMS_FS=m
CONFIG_EXT3_FS=m
CONFIG_JBD=m
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
CONFIG_UMSDOS_FS=m
CONFIG_VFAT_FS=m
CONFIG_EFS_FS=m
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=m
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
CONFIG_FREEVXFS_FS=m
CONFIG_NTFS_FS=m
CONFIG_HPFS_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=m
CONFIG_ROMFS_FS=m
CONFIG_EXT2_FS=y
CONFIG_SYSV_FS=m
CONFIG_UDF_FS=m
CONFIG_UFS_FS=m
CONFIG_CODA_FS=m
CONFIG_INTERMEZZO_FS=m
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_ZISOFS_FS=m
CONFIG_ZLIB_FS_INFLATE=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
CONFIG_MINIX_SUBPARTITION=y
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
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
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=y
CONFIG_FB_MATROX_G100=y
CONFIG_FB_MATROX_I2C=m
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_MFB=y
CONFIG_FBCON_CFB2=y
CONFIG_FBCON_CFB4=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_CFB24=y
CONFIG_FBCON_CFB32=y
CONFIG_FBCON_VGA_PLANES=y
CONFIG_FBCON_VGA=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y
CONFIG_FONT_6x11=y
CONFIG_FONT_PEARL_8x8=y
CONFIG_FONT_ACORN_8x8=y
CONFIG_SOUND=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_DMAP=y
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
CONFIG_SOUND_TVMIXER=m
CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y

Modules loaded:

Module                  Size  Used by
ipt_REJECT              2784   2 (autoclean)
ipt_LOG                 3136   2 (autoclean)
iptable_filter          1728   0 (autoclean) (unused)
ipt_MASQUERADE          1216   1 (autoclean)
iptable_nat            12628   0 (autoclean) [ipt_MASQUERADE]
ip_conntrack           12812   1 (autoclean) [ipt_MASQUERADE iptable_nat]
appletalk              18540   0 (autoclean)
ipx                    14996   0 (autoclean)
lirc_i2c                2628   0 (unused)
lirc_dev                7584   1 [lirc_i2c]
mga_vid                 6560   0 (unused)
sr_mod                 12568   0 (unused)
sg                     22468   0 (unused)
ide-scsi                7392   0
scsi_mod               48460   3 [sr_mod sg ide-scsi]
floppy                 44768   0
serial                 43680   0 (unused)
parport_pc             19688   1 (autoclean)
lp                      4864   0 (unused)
parport                24960   1 [parport_pc lp]
ppp_async               6048   0 (unused)
ppp_generic            14792   0 [ppp_async]
slhc                    4384   0 [ppp_generic]
btaudio                 9184   0
tuner                   4484   1 (autoclean)
tvaudio                 8000   0 (autoclean) (unused)
msp3400                13712   1 (autoclean)
bttv                   54784   1
i2c-algo-bit            6956   1 [bttv]
i2c-core               12704   0 [lirc_i2c tuner tvaudio msp3400 bttv i2c-algo-bit]
videodev                4544   2 [bttv]
ip_tables              10272   7 [ipt_REJECT ipt_LOG iptable_filter ipt_MASQUERADE iptable_nat]
3c59x                  24232   0 (unused)
8139too                12096   1
sb                      7328   0
sb_lib                 32256   0 [sb]
uart401                 6048   0 [sb_lib]
sound                  52364   0 [sb_lib uart401]
soundcore               3460   8 [btaudio sb_lib sound]
isa-pnp                27336   0 [serial sb]
cdrom                  27328   0 (autoclean) [sr_mod]

-- 
Adam Sampson <azz@gnu.org>                  <URL:http://azz.us-lot.org/>
