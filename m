Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSLHHgL>; Sun, 8 Dec 2002 02:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbSLHHgL>; Sun, 8 Dec 2002 02:36:11 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:56863 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S265171AbSLHHgI>; Sun, 8 Dec 2002 02:36:08 -0500
Date: Sun, 8 Dec 2002 02:43:36 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Reference counting in console uarts
Message-ID: <20021208024336.A23637@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Russell:

I boot my 2.5 boxes using "console=ttyS0,9600" argument,
and I noticed that something is not right with reference
counting in this case. It seems that when the console
is open by kernel initially, this is not accounted
as an open, and uart_startup is not called. This is ok,
because the serial console is set up separately. However, later
every script or a program run by init causes a startup
and shutdown, literally dozens of them. These oscillations only
stop when daemons are started and keep console open.

Do you have any idea what a fix for this may be?

-- Pete

P.S. This is how console trace looks if I add a printk to
every ->startup and ->shutdown (sorry to the garbage for completeness):

JavaStation
OpenBoot 3.12.FW14, 96 MB memory installed, Serial #9778584.
Ethernet address 08:00:20:95:35:98, Host ID: 80953598.




ok boot net console=ttyS0,9600 ip=dhcp
PROLL ID18 Espresso BOOTP+Serial+SILO
M: 0=0x0[0x2000000] 1=0x2000000[0x2000000] 2=0x4000000[0x2000000]: 96MB
Booting from network.
hme0: HAPPY MEAL 8:0:20:95:35:98
BOOTP: Sending request: ok
Command line 26 bytes
load: done 1911844(0x1D2C24) bytes
Memory used: virt 0xFFD04000:0xFFD2C000[160K] iomap 0xFFD40000:0xFFD41000
bootmem_init: Scan sp_banks,  init_bootmem(spfn[21f],bpfn[21f],mlpfn[5fc4])
free_bootmem: base[0] size[2000000]
free_bootmem: base[2000000] size[2000000]
free_bootmem: base[4000000] size[1fc4000]
reserve_bootmem: base[0] size[21f000]
reserve_bootmem: base[21f000] size[bfc]
Booting Linux...
mem_init: Calling free_all_bootmem().
PROMLIB: Sun Boot Prom Version 0 Revision 77
Linux version 2.5.50 (zaitcev@niphredil) (gcc version 2.95.3 20010315 (release)) #7 Sat Dec 7 22:42:09 PST 2002
ARCH: SUN4M
TYPE: JavaStation-E
Ethernet address: 8:0:20:95:35:98
Boot time fixup v1.6. 4/Mar/98 Jakub Jelinek (jj@ultra.linux.cz). Patching kernel for srmmu[Fujitsu Swift]/iommu
On node 0 totalpages: 23972
  DMA zone: 23972 pages, LIFO batch:5
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Found CPU 0 <node=00000003,mid=1400136052>
Found 1 CPU prom device tree node(s).
Building zonelist for node : 0
Kernel command line: ip=dhcp console=ttyS0,9600
Console: colour dummy device 80x25
Calibrating delay loop... 99.73 BogoMIPS
Memory: 93780k available (1400k kernel code, 236k data, 128k init, 0k highmem) [f0000000,05fc4000]
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
PCIC: Enabling I/O for device 00:18
PCIC: Enabling memory for device 00:18
PCIC: setting irq 9 at pin 4 for device 00:38
PCIC: Enabling I/O for device 00:80
PCIC: setting irq 11 at pin 5 for device 00:80
PCIC: Enabling I/O for device 00:88
PCIC: device ??? devfn 00:88 not found in 8
PCIC: Enabling memory for device 00:a0
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 182 entries (12 bytes)
biovec pool[1]:   4 bvecs: 182 entries (48 bytes)
biovec pool[2]:  16 bvecs: 182 entries (192 bytes)
biovec pool[3]:  64 bvecs:  91 entries (768 bytes)
biovec pool[4]: 128 bvecs:  45 entries (1536 bytes)
biovec pool[5]: 256 bvecs:  22 entries (3072 bytes)
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 31
 exit congestion at 33
aio_setup: sizeof(struct page) = 40
[f0424020] eventpoll: successfully initialized.
ttyS0 at MMIO 0xfd0132f8 (irq = 0) is a 16550A
ttyS1 at MMIO 0xfd0143f8 (irq = 0) is a 16550A
Console: ttyS0 (SU)
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.11
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
sunhme.c:v2.01 26/Mar/2002 David S. Miller (davem@redhat.com)
eth0: HAPPY MEAL (PCI/CheerIO) 10/100BaseT Ethernet 08:00:20:95:35:98
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: not ready
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
Sending DHCP requests ., OK
IP-Config: Got DHCP answer from 192.168.128.1, my address is 192.168.128.6
IP-Config: Complete:
      device=eth0, addr=192.168.128.6, mask=255.255.255.0, gw=255.255.255.255,
     host=192.168.128.6, domain=, nis-domain=(none),
     bootserver=192.168.128.1, rootserver=192.168.128.1, rootpath=/q/root/js006
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.168.128.1
Looking up port of RPC 100005/1 on 192.168.128.1
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 128k freed
sunsu_startup: count 0 line 0 port f020e360
sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
INIT: sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
version 2.74 bootingsunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360

sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
Activating swap partitions
hostname: js006
Checking root filesystems.
Parallelizing fsck version 1.12 (9-Jul-98)
[/sbin/fsck.nfs] fsck.nfs -a elanor:/q/root/js006
Turning on user and group quotas for root filesystem
Remounting root filesystem in read-write mode.
Checking filesystems.
Parallelizing fsck version 1.12 (9-Jul-98)
Checking all file systems.
----------------------------------
Mounting local filesystems.
Turning on user and group quotas for local filesystems
Setting clock (utc): Sat Dec  7 22:49:56 PST 2002
Enabling swap space.
Initializing random number generator...
sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
INIT: sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
Entering runlevel: 3sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360

sunsu_shutdown: line 0 port f020e360 count 1
sunsu_startup: count 0 line 0 port f020e360
eth0: Auto-Negotiation unsuccessful, trying force link mode
SIOCADDRT: Network is unreachable
Starting portmapper: portmap
Mounting remote filesystems.
Starting system loggers: syslogd klogd
Starting cron daemon: crond
Starting INET services: inetd
Starting sshd


Welcome to the js006.zaitcev.lan

js006 login: root
Password:
Last login: Sat Dec  7 22:21:34 on ttyS0
[root@js006 /root]#
[root@js006 /root]# cat /proc/interrupts
  6:       5617    eth0
 10:      29375  + timer
 12:          1  + rtc
 13:        158    su(serial)
[root@js006 /root]#
