Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132774AbRA2QLO>; Mon, 29 Jan 2001 11:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132957AbRA2QKz>; Mon, 29 Jan 2001 11:10:55 -0500
Received: from md.aacisd.com ([64.23.207.34]:46610 "HELO md.aacisd.com")
	by vger.kernel.org with SMTP id <S132774AbRA2QKt>;
	Mon, 29 Jan 2001 11:10:49 -0500
Message-ID: <8FED3D71D1D2D411992A009027711D671859@md>
From: Nathan Black <NBlack@md.aacisd.com>
To: linux-kernel@vger.kernel.org
Subject: Bolck Device problem or Compaq Smart array 2 problem? kernel -2.4
	.0+
Date: Mon, 29 Jan 2001 11:06:15 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C08A0D.680CC850"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C08A0D.680CC850
Content-Type: text/plain;
	charset="iso-8859-1"


Here is my scenario. I have a smart array controller 2. I have 6 logical
drives( one on it's own physical drive). I am using the one drive for data
aquisition from an atm board. To locate my problem, I removed all of the atm
stuff. and I am trying just a read/write. Both show the same symptoms. I
have tried many different kernels.

Here are my results.

2.2.18- works fine. 24 MBytes/sec at 100+ gigabytes (16GB looped many times
( lseek64(FD,SEEK_SET,0) )).

2.4.0 release SMP and Uniprocessor with NMI on-	Kernel oops. I can reproduce
if necessary( oops at about 700 MB)  sometimes more, sometime less. (In
BDFLUSH if I recall)

2.4.0 release UniProcessor NMI off- Works like the 2.2.18

2.4.1-pre10 & 11- Works but system becomes unusable(requires reboot) after
completing.

Here is my setup.

Compaq Proliant 8500R
4GB Ram
4 Hot Swap 18GB hard disk.
Compaq Smart Array Controller
Linksys Network(10/100 BT) card
8 PIII Xeon w/ 2MB cache Processors.
egcs-2.91.66
redhat 6.2 distribution
I do have a 512 MB swap partition

I am including the code that I have been playing with. It looks very ugly,
but I have tried just about everything I could without going in and trying
to learn how the kernel is written.

I am including the source code for the block write device. and the kernel
configuration from 2.4.1-pre11. 
Has anyone else see this problem.

I have tried to write a file to on the filesystem. Looks like a similar
problem. 

Nathan <<write.cpp>>  <<kernel-2.4.1-pre11-config>> 


------_=_NextPart_000_01C08A0D.680CC850
Content-Type: application/octet-stream;
	name="write.cpp"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="write.cpp"

#include <sys/resource.h>=0A=
#include <stdio.h>=0A=
#define __USE_LARGEFILE64=0A=
#define __USE_LARGE_OFFSETS=0A=
#include <sys/types.h>=0A=
#include <sys/stat.h>=0A=
#include <fcntl.h>=0A=
#include <iostream.h>=0A=
#include <stdlib.h>=0A=
=0A=
#include <unistd.h>=0A=
#define lseek lseek64=0A=
#define off_t off64_t=0A=
#define open open64=0A=
#define MAX_SIZE 32*1024   /*   Maximum Block Write Size */=0A=
=0A=
extern "C" off_t lseek(int FD,off_t offset,int whence);=0A=
=0A=
#include <stdio.h>=0A=
#include <string.h>=0A=
#include <errno.h>=0A=
#include <time.h>=0A=
#include <math.h>=0A=
int WRITE (int FD,char *buffer, int size)=0A=
{=0A=
int written=3D0,current=3DMAX_SIZE;=0A=
int writelen;=0A=
for (;written<size;)=0A=
{=0A=
	if (size-written < current)=0A=
		current =3D size-written;=0A=
	writelen =3D write(FD,&buffer[written],current);=0A=
	if (writelen < current)=0A=
		{=0A=
		if (writelen<1)=0A=
			return written;=0A=
		written+=3Dwritelen;=0A=
		break;=0A=
		}=0A=
	written+=3Dwritelen;=0A=
	=0A=
	=0A=
}=0A=
=0A=
return written;=0A=
}=0A=
=0A=
int main(int argc,char **argv)=0A=
{=0A=
time_t start,stop;=0A=
long long FileLimit =3D pow(2,30),//676*1024*1024,//pow(2,29),=0A=
	Total_Written =3D 0,Current_Total =3D 0; /* Byte Counts... Current =
loop  and total   */=0A=
int write_len =3D 0; /* Number of bytes written for current =
write(fd,...) */=0A=
int loop=3D1; /* Number of times to restart write to beginning of file =
*/=0A=
off64_t start_addr =3D 0,loc; /* Not working for something other than 0 =
yet */=0A=
char Buffer[128*1024]=3D {0};   /* Data Buffer to Write  */=0A=
char Filename[128] =3D "/dev/ida/c0d5"; /* IDA Block Device for raw =
disk */=0A=
//char Filename[128] =3D "/home/test.dat"; /* EXT2FS file  */=0A=
=0A=
int FD =3D open(Filename,O_RDWR | O_CREAT);=0A=
=0A=
if(FD <1)=0A=
	{=0A=
	perror(strerror(errno));=0A=
	exit(-1);=0A=
	}=0A=
=0A=
cout<<Filename<<" Was Successfully Opened"<<endl;=0A=
for(int i =3D 0;i<loop;++i)=0A=
{=0A=
loc =3D 0;=0A=
loc =3D lseek64(FD,SEEK_SET,start_addr);=0A=
if(loc<1)=0A=
	perror(strerror(errno));=0A=
=0A=
cout<<"Seeking to:"<<loc <<endl;=0A=
=0A=
Current_Total =3D 0;=0A=
start =3D time(NULL);=0A=
while (Current_Total < FileLimit)=0A=
	{=0A=
	write_len =3D WRITE(FD,Buffer,sizeof(Buffer));=0A=
//	fdatasync(FD);   /* Slows performance due to blocking   */=0A=
	//fsync(FD);	/* Same   */	=0A=
	//sync();       /* Same   */=0A=
	if(write_len =3D=3D -1) /*  Write Error, Print error ,Sync and Close =
*/=0A=
		{=0A=
		cout<<endl<<endl;=0A=
		perror(strerror(errno));=0A=
		fdatasync(FD);=0A=
		close(FD);=0A=
		exit(-1);=0A=
		}=0A=
	Total_Written +=3Dwrite_len;=0A=
	Current_Total +=3Dwrite_len;=0A=
	=0A=
	=0A=
	cout<<"\rLoop "<<i<<" Bytes Written:       "<<Total_Written;=0A=
	=0A=
//	sleep(1);=0A=
	}=0A=
stop =3D time(NULL);=0A=
cout<<endl<<endl<<"Rate =3D =
"<<Current_Total/(1024*1024*difftime(stop,start))<<endl;=0A=
}=0A=
/*    Sync and Close File. Writing done  */	=0A=
fdatasync(FD);=0A=
close(FD);=0A=
cout<<"File Closed"<<endl;=0A=
return 0;=0A=
}=0A=
=0A=

------_=_NextPart_000_01C08A0D.680CC850
Content-Type: application/octet-stream;
	name="kernel-2.4.1-pre11-config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="kernel-2.4.1-pre11-config"

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
CONFIG_X86=3Dy=0A=
CONFIG_ISA=3Dy=0A=
# CONFIG_SBUS is not set=0A=
CONFIG_UID16=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
CONFIG_MODVERSIONS=3Dy=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Processor type and features=0A=
#=0A=
# CONFIG_M386 is not set=0A=
# CONFIG_M486 is not set=0A=
# CONFIG_M586 is not set=0A=
# CONFIG_M586TSC is not set=0A=
# CONFIG_M586MMX is not set=0A=
# CONFIG_M686 is not set=0A=
CONFIG_MPENTIUMIII=3Dy=0A=
# CONFIG_MPENTIUM4 is not set=0A=
# CONFIG_MK6 is not set=0A=
# CONFIG_MK7 is not set=0A=
# CONFIG_MCRUSOE is not set=0A=
# CONFIG_MWINCHIPC6 is not set=0A=
# CONFIG_MWINCHIP2 is not set=0A=
# CONFIG_MWINCHIP3D is not set=0A=
CONFIG_X86_WP_WORKS_OK=3Dy=0A=
CONFIG_X86_INVLPG=3Dy=0A=
CONFIG_X86_CMPXCHG=3Dy=0A=
CONFIG_X86_BSWAP=3Dy=0A=
CONFIG_X86_POPAD_OK=3Dy=0A=
CONFIG_X86_L1_CACHE_SHIFT=3D5=0A=
CONFIG_X86_TSC=3Dy=0A=
CONFIG_X86_GOOD_APIC=3Dy=0A=
CONFIG_X86_PGE=3Dy=0A=
CONFIG_X86_USE_PPRO_CHECKSUM=3Dy=0A=
# CONFIG_TOSHIBA is not set=0A=
# CONFIG_MICROCODE is not set=0A=
CONFIG_X86_MSR=3Dy=0A=
CONFIG_X86_CPUID=3Dy=0A=
# CONFIG_NOHIGHMEM is not set=0A=
# CONFIG_HIGHMEM4G is not set=0A=
CONFIG_HIGHMEM64G=3Dy=0A=
CONFIG_HIGHMEM=3Dy=0A=
CONFIG_X86_PAE=3Dy=0A=
# CONFIG_MATH_EMULATION is not set=0A=
CONFIG_MTRR=3Dy=0A=
CONFIG_SMP=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_NET=3Dy=0A=
# CONFIG_VISWS is not set=0A=
CONFIG_X86_IO_APIC=3Dy=0A=
CONFIG_X86_LOCAL_APIC=3Dy=0A=
CONFIG_PCI=3Dy=0A=
# CONFIG_PCI_GOBIOS is not set=0A=
# CONFIG_PCI_GODIRECT is not set=0A=
CONFIG_PCI_GOANY=3Dy=0A=
CONFIG_PCI_BIOS=3Dy=0A=
CONFIG_PCI_DIRECT=3Dy=0A=
CONFIG_PCI_NAMES=3Dy=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_MCA is not set=0A=
CONFIG_HOTPLUG=3Dy=0A=
=0A=
#=0A=
# PCMCIA/CardBus support=0A=
#=0A=
# CONFIG_PCMCIA is not set=0A=
CONFIG_SYSVIPC=3Dy=0A=
CONFIG_BSD_PROCESS_ACCT=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_KCORE_ELF=3Dy=0A=
# CONFIG_KCORE_AOUT is not set=0A=
CONFIG_BINFMT_AOUT=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_BINFMT_MISC=3Dy=0A=
# CONFIG_PM is not set=0A=
# CONFIG_APM_IGNORE_USER_SUSPEND is not set=0A=
# CONFIG_APM_DO_ENABLE is not set=0A=
# CONFIG_APM_CPU_IDLE is not set=0A=
# CONFIG_APM_DISPLAY_BLANK is not set=0A=
# CONFIG_APM_RTC_IS_GMT is not set=0A=
# CONFIG_APM_ALLOW_INTS is not set=0A=
# CONFIG_APM_REAL_MODE_POWER_OFF is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
CONFIG_PNP=3Dy=0A=
# CONFIG_ISAPNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
CONFIG_BLK_DEV_FD=3Dy=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
CONFIG_BLK_CPQ_DA=3Dy=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_LOOP is not set=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_PACKET_MMAP=3Dy=0A=
CONFIG_NETLINK=3Dy=0A=
# CONFIG_RTNETLINK is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
# CONFIG_NETFILTER is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
# CONFIG_IP_PNP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_KHTTPD is not set=0A=
CONFIG_ATM=3Dy=0A=
CONFIG_ATM_CLIP=3Dy=0A=
# CONFIG_ATM_CLIP_NO_ICMP is not set=0A=
# CONFIG_ATM_LANE is not set=0A=
=0A=
#=0A=
#  =0A=
#=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Telephony Support=0A=
#=0A=
# CONFIG_PHONE is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
CONFIG_IDE=3Dy=0A=
=0A=
#=0A=
# IDE, ATA and ATAPI Block devices=0A=
#=0A=
CONFIG_BLK_DEV_IDE=3Dy=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_IDE is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
# CONFIG_BLK_DEV_IDEDISK is not set=0A=
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set=0A=
# CONFIG_BLK_DEV_COMMERIAL is not set=0A=
CONFIG_BLK_DEV_IDECD=3Dy=0A=
# CONFIG_BLK_DEV_IDETAPE is not set=0A=
# CONFIG_BLK_DEV_IDEFLOPPY is not set=0A=
=0A=
#=0A=
# IDE chipset support/bugfixes=0A=
#=0A=
# CONFIG_BLK_DEV_CMD640 is not set=0A=
# CONFIG_BLK_DEV_RZ1000 is not set=0A=
CONFIG_BLK_DEV_IDEPCI=3Dy=0A=
CONFIG_IDEPCI_SHARE_IRQ=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA_PCI=3Dy=0A=
# CONFIG_BLK_DEV_OFFBOARD is not set=0A=
CONFIG_IDEDMA_PCI_AUTO=3Dy=0A=
CONFIG_BLK_DEV_IDEDMA=3Dy=0A=
# CONFIG_IDEDMA_PCI_WIP is not set=0A=
# CONFIG_BLK_DEV_AEC62XX is not set=0A=
# CONFIG_BLK_DEV_ALI15X3 is not set=0A=
# CONFIG_BLK_DEV_AMD7409 is not set=0A=
# CONFIG_BLK_DEV_CMD64X is not set=0A=
# CONFIG_BLK_DEV_CY82C693 is not set=0A=
# CONFIG_BLK_DEV_CS5530 is not set=0A=
# CONFIG_BLK_DEV_HPT34X is not set=0A=
# CONFIG_BLK_DEV_HPT366 is not set=0A=
# CONFIG_BLK_DEV_PIIX is not set=0A=
# CONFIG_BLK_DEV_NS87415 is not set=0A=
# CONFIG_BLK_DEV_OPTI621 is not set=0A=
# CONFIG_BLK_DEV_PDC202XX is not set=0A=
CONFIG_BLK_DEV_OSB4=3Dy=0A=
# CONFIG_BLK_DEV_SIS5513 is not set=0A=
# CONFIG_BLK_DEV_SLC90E66 is not set=0A=
# CONFIG_BLK_DEV_TRM290 is not set=0A=
# CONFIG_BLK_DEV_VIA82CXXX is not set=0A=
# CONFIG_IDE_CHIPSETS is not set=0A=
CONFIG_IDEDMA_AUTO=3Dy=0A=
# CONFIG_IDEDMA_IVB is not set=0A=
# CONFIG_DMA_NONPCI is not set=0A=
CONFIG_BLK_DEV_IDE_MODES=3Dy=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# IEEE 1394 (FireWire) support=0A=
#=0A=
# CONFIG_IEEE1394 is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_AT1700 is not set=0A=
# CONFIG_DEPCA is not set=0A=
# CONFIG_HP100 is not set=0A=
# CONFIG_NET_ISA is not set=0A=
CONFIG_NET_PCI=3Dy=0A=
# CONFIG_PCNET32 is not set=0A=
# CONFIG_ADAPTEC_STARFIRE is not set=0A=
# CONFIG_AC3200 is not set=0A=
# CONFIG_APRICOT is not set=0A=
# CONFIG_CS89x0 is not set=0A=
CONFIG_TULIP=3Dy=0A=
# CONFIG_DE4X5 is not set=0A=
# CONFIG_DGRS is not set=0A=
# CONFIG_DM9102 is not set=0A=
# CONFIG_EEPRO100 is not set=0A=
# CONFIG_NATSEMI is not set=0A=
# CONFIG_NE2K_PCI is not set=0A=
# CONFIG_8139TOO is not set=0A=
# CONFIG_RTL8129 is not set=0A=
# CONFIG_SIS900 is not set=0A=
# CONFIG_EPIC100 is not set=0A=
# CONFIG_SUNDANCE is not set=0A=
# CONFIG_TLAN is not set=0A=
# CONFIG_VIA_RHINE is not set=0A=
# CONFIG_WINBOND_840 is not set=0A=
# CONFIG_HAPPYMEAL is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# ATM drivers=0A=
#=0A=
# CONFIG_ATM_TCP is not set=0A=
# CONFIG_ATM_ENI is not set=0A=
# CONFIG_ATM_FIRESTREAM is not set=0A=
# CONFIG_ATM_ZATM is not set=0A=
# CONFIG_ATM_NICSTAR is not set=0A=
# CONFIG_ATM_AMBASSADOR is not set=0A=
# CONFIG_ATM_HORIZON is not set=0A=
# CONFIG_ATM_IA is not set=0A=
CONFIG_ATM_FORE200E_MAYBE=3Dy=0A=
CONFIG_ATM_FORE200E_PCA=3Dy=0A=
CONFIG_ATM_FORE200E_PCA_DEFAULT_FW=3Dy=0A=
CONFIG_ATM_FORE200E_TX_RETRY=3D16=0A=
CONFIG_ATM_FORE200E_DEBUG=3D0=0A=
CONFIG_ATM_FORE200E=3Dy=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
# CONFIG_INPUT is not set=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_SERIAL=3Dy=0A=
# CONFIG_SERIAL_CONSOLE is not set=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
CONFIG_MOUSE=3Dy=0A=
CONFIG_PSMOUSE=3Dy=0A=
# CONFIG_82C710_MOUSE is not set=0A=
# CONFIG_PC110_PAD is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
=0A=
#=0A=
# Game port support=0A=
#=0A=
=0A=
#=0A=
# Gameport joysticks=0A=
#=0A=
=0A=
#=0A=
# Serial port support=0A=
#=0A=
=0A=
#=0A=
# Serial port joysticks=0A=
#=0A=
=0A=
#=0A=
# Parallel port joysticks=0A=
#=0A=
=0A=
#=0A=
#   Parport support is needed for parallel port joysticks=0A=
#=0A=
# CONFIG_QIC02_TAPE is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_INTEL_RNG is not set=0A=
# CONFIG_NVRAM is not set=0A=
CONFIG_RTC=3Dy=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
# CONFIG_DRM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AUTOFS4_FS is not set=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_BFS_FS is not set=0A=
CONFIG_FAT_FS=3Dy=0A=
# CONFIG_MSDOS_FS is not set=0A=
CONFIG_VFAT_FS=3Dy=0A=
# CONFIG_EFS_FS is not set=0A=
CONFIG_JFFS_FS_VERBOSE=3D0=0A=
# CONFIG_CRAMFS is not set=0A=
# CONFIG_RAMFS is not set=0A=
CONFIG_ISO9660_FS=3Dy=0A=
CONFIG_JOLIET=3Dy=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
# CONFIG_DEVFS_FS is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
CONFIG_UDF_FS=3Dy=0A=
# CONFIG_UDF_RW is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_NFS_FS is not set=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_SUNRPC is not set=0A=
# CONFIG_LOCKD is not set=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
# CONFIG_SMB_NLS is not set=0A=
CONFIG_NLS=3Dy=0A=
=0A=
#=0A=
# Native Language Support=0A=
#=0A=
CONFIG_NLS_DEFAULT=3D"iso8859-1"=0A=
CONFIG_NLS_CODEPAGE_437=3Dy=0A=
# CONFIG_NLS_CODEPAGE_737 is not set=0A=
# CONFIG_NLS_CODEPAGE_775 is not set=0A=
# CONFIG_NLS_CODEPAGE_850 is not set=0A=
# CONFIG_NLS_CODEPAGE_852 is not set=0A=
# CONFIG_NLS_CODEPAGE_855 is not set=0A=
# CONFIG_NLS_CODEPAGE_857 is not set=0A=
# CONFIG_NLS_CODEPAGE_860 is not set=0A=
# CONFIG_NLS_CODEPAGE_861 is not set=0A=
# CONFIG_NLS_CODEPAGE_862 is not set=0A=
# CONFIG_NLS_CODEPAGE_863 is not set=0A=
# CONFIG_NLS_CODEPAGE_864 is not set=0A=
# CONFIG_NLS_CODEPAGE_865 is not set=0A=
# CONFIG_NLS_CODEPAGE_866 is not set=0A=
# CONFIG_NLS_CODEPAGE_869 is not set=0A=
# CONFIG_NLS_CODEPAGE_874 is not set=0A=
# CONFIG_NLS_CODEPAGE_932 is not set=0A=
# CONFIG_NLS_CODEPAGE_936 is not set=0A=
# CONFIG_NLS_CODEPAGE_949 is not set=0A=
# CONFIG_NLS_CODEPAGE_950 is not set=0A=
# CONFIG_NLS_ISO8859_1 is not set=0A=
# CONFIG_NLS_ISO8859_2 is not set=0A=
# CONFIG_NLS_ISO8859_3 is not set=0A=
# CONFIG_NLS_ISO8859_4 is not set=0A=
# CONFIG_NLS_ISO8859_5 is not set=0A=
# CONFIG_NLS_ISO8859_6 is not set=0A=
# CONFIG_NLS_ISO8859_7 is not set=0A=
# CONFIG_NLS_ISO8859_8 is not set=0A=
# CONFIG_NLS_ISO8859_9 is not set=0A=
# CONFIG_NLS_ISO8859_14 is not set=0A=
# CONFIG_NLS_ISO8859_15 is not set=0A=
# CONFIG_NLS_KOI8_R is not set=0A=
# CONFIG_NLS_UTF8 is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
CONFIG_VGA_CONSOLE=3Dy=0A=
# CONFIG_VIDEO_SELECT is not set=0A=
# CONFIG_MDA_CONSOLE is not set=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=

------_=_NextPart_000_01C08A0D.680CC850--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
