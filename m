Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264922AbUF1MTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbUF1MTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 08:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbUF1MTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 08:19:32 -0400
Received: from tx1-3.intrameta.com ([69.13.51.3]:14826 "EHLO
	tx1-3.intrameta.com") by vger.kernel.org with ESMTP id S264922AbUF1MSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 08:18:15 -0400
Reply-To: <bvaughan@mindspring.com>
From: "Bill Vaughan" <bvaughan@mindspring.com>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Oops, nfsd, networking 
Date: Mon, 28 Jun 2004 08:18:05 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_008C_01C45CE8.70580040"
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcRdBmJ95P/VicdGQd+goFsUa/rM6AAAm3Kw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S264922AbUF1MSP/20040628121815Z+10@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_008C_01C45CE8.70580040
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

NFSD crash at large MTU and odd wsize/rsize.
 
Hi,
 
I have discovered a reproducible NFSD crash.  My application is very obscure, so
you may not be able to re-produce it. I am writing an NFS V3 client for an
embedded project (our own OS).  We are writing about 250 Mbps of media traffic
over NFS to a Linux NFS server.  At the same time I am reading about 70 Mbps
sustained. Our product is essentially a high end media server that takes in up to
2 Gbps of mpeg2 or mjpeg and load balances the traffic across several direct
attached NFS servers.
 
At this traffic level, I was getting a significant amount of traffic dropped by
the driver/NIC on the Linux box.  (underruns in ifconfig eth1, probably due to
interrupt not being serviced). This was with a 9000 MTU and an 8192 wsize and
rsize.  What I did to reduce the interrupt rate is increase the MTU to 16000 (we
are directly attached, so this is not an issue), and changed rsize and wsize to
15500 (so it will fit in the MTU without frags).  This cut the interrupts almost
in half and greatly reduced the number of overruns.  Everything was looking
great. However, after about 10 minutes of sustained traffic (250 write, 70 read),
the NFS server crashes (see dmesg).  All 128 of them go away. One other note, I
am retransmitting read requests that do not respond within 25 msecs. I do this
because if a packet is dropped due to underruns, I cannot wait for a long
time-out to re-transmit because my read rate will drop too low.
 
I'll just have to go back to an MTU of 9000 and rsize/wsize of 8192 and just put
more Linux servers behind us if I can't get this resolved.
 
General:
Linux: Fedora Core 2 with no updates (kernel 2.6.5)
XFS file system.
750 GB Software Raid0 over 3 drives.
Hardware: Dual Xeon 1U rackmount with 4 250 GB SATA drives.
Changed rmem_max and rmem_default to 262140 (see sysctl).
Running on eth1 (Intel Gig interface). MTU set at 16000.
Running 128 NFSD servers as NFSV3.  WSIZE=15500, RSIZE=15500
 
 
dmesg:
Code: 8b 00 f6 c4 01 75 19 2b 1d 0c d9 3f 02 c1 fb 05 c1 e3 0c 8d
 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000000
 
 printing eip:
0213f951
*pde = 00003001
Oops: 0000 [#128]
SMP
CPU:    1
EIP:    0060:[<0213f951>]    Not tainted
EFLAGS: 00010202   (2.6.5-1.358smp)
EIP is at page_address+0x6/0x77
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 764dfc00
esi: 0000000b   edi: 94171691   ebp: 764de000   esp: 76355f3c
ds: 007b   es: 007b   ss: 0068
Process nfsd (pid: 2375, threadinfo=76355000 task=813ad410)
Stack: 003e06e8 0000000b 94171691 764de000 82b56b28 764dfc00 764dfc00 82b56a30
       82b6b138 82b6af1c 82b4c5a9 0e606014 764dfc64 764dfc00 82b6b138 0e606014
       82b0e5f1 764dfc00 0000003d 000000f4 00000190 000186a3 764dfc40 82b6af1c
Call Trace:
 [<82b56b28>] nfs3svc_decode_writeargs+0xf8/0x149 [nfsd]
 [<82b56a30>] nfs3svc_decode_writeargs+0x0/0x149 [nfsd]
 [<82b4c5a9>] nfsd_dispatch+0x6f/0x162 [nfsd]
 [<82b0e5f1>] svc_process+0x323/0x55f [sunrpc]
 [<82b4c3d5>] nfsd+0x1c6/0x32b [nfsd]
 [<82b4c20f>] nfsd+0x0/0x32b [nfsd]
 [<021041f1>] kernel_thread_helper+0x5/0xb
 
Code: 8b 00 f6 c4 01 75 19 2b 1d 0c d9 3f 02 c1 fb 05 c1 e3 0c 8d
 
[root@localhost root]#
 
eth0      Link encap:Ethernet  HWaddr 00:0C:F1:DC:A0:A6
          inet addr:192.168.1.61  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:f1ff:fedc:a0a6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3344 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1591 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:322870 (315.3 Kb)  TX bytes:331102 (323.3 Kb)
 
eth1      Link encap:Ethernet  HWaddr 00:0C:F1:DC:A0:A3
          inet addr:13.0.0.26  Bcast:13.0.0.255  Mask:255.255.255.0
          inet6 addr: fe80::20c:f1ff:fedc:a0a3/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:16000  Metric:1
          RX packets:5259815 errors:514953 dropped:514953 overruns:508817 frame:
0
          TX packets:5172108 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4047084198 (3859.6 Mb)  TX bytes:2817892640 (2687.3 Mb)
          Base address:0x9c00 Memory:fc9e0000-fca00000
 
lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:1122 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1122 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:1088676 (1.0 Mb)  TX bytes:1088676 (1.0 Mb)

[root@localhost root]# /usr/sbin/nfsstat -a
Server packet stats:
packets    udp        tcp        tcpconn
5172374    5172369    0          0
Server rpc stats:
calls      badcalls   badauth    badclnt    xdrcall
5172362    0          0          0          0
Server reply cache:
hits       misses     nocache
2          3941601    1230770
Server file handle cache:
lookup     anon       ncachedir ncachedir  stale
0          0          0          0          0
Server nfs v2:
null       getattr    setattr    root       lookup     readlink
0       0% 0       0% 0       0% 0       0% 0       0% 0       0%
read       wrcache    write      create     remove     rename
0       0% 0       0% 0       0% 0       0% 0       0% 0       0%
link       symlink    mkdir      rmdir      readdir    fsstat
0       0% 0       0% 0       0% 0       0% 0       0% 0       0%
 
Server nfs v3:
null       getattr    setattr    lookup     access     readlink
0       0% 0       0% 0       0% 49      0% 0       0% 0       0%
read       write      create     mkdir      symlink    mknod
1230484 23% 3940984 76% 301     0% 0       0% 0       0% 0       0%
remove     rmdir      rename     link       readdir    readdirplus
314     0% 0       0% 0       0% 0       0% 0       0% 97      0%
fsstat     fsinfo     pathconf   commit
137     0% 3       0% 0       0% 0       0%

[root@localhost root]# cat /proc/net/rpc/nfsd
rc 2 3941601 1230770
fh 0 0 0 0 0
io 1889770924 3191644084
th 128 174137 159.717 65.060 22.263 14.312 14.197 13.116 14.113 14.803 12.698 22
3.272
ra 256 1230468 0 0 0 0 0 0 0 0 0 19
net 5172374 5172369 0 0
rpc 5172362 0 0 0 0
proc2 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
proc3 22 0 0 0 49 0 0 1230484 3940984 301 0 0 0 314 0 0 0 0 97 137 3 0 0
proc4 2 0 0
 
[root@localhost root]# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3192.790
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6324.22
 
processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 3.20GHz
stepping        : 9
cpu MHz         : 3192.790
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
bogomips        : 6373.37

[root@localhost root]# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
02f8-02ff : serial
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #02
  9c00-9c1f : 0000:02:01.0
    9c00-9c1f : e1000
ac00-ac3f : 0000:03:08.0
  ac00-ac3f : e100
b000-b07f : 0000:03:07.0
  b000-b07f : sata_promise
b400-b40f : 0000:03:07.0
  b400-b40f : sata_promise
b800-b8ff : 0000:03:06.0
bc00-bc3f : 0000:03:07.0
  bc00-bc3f : sata_promise
c800-c81f : 0000:00:1f.3
cc00-cc1f : 0000:00:1d.0
  cc00-cc1f : uhci_hcd
d000-d01f : 0000:00:1d.1
  d000-d01f : uhci_hcd
d400-d41f : 0000:00:1d.2
  d400-d41f : uhci_hcd
d800-d81f : 0000:00:1d.3
  d800-d81f : uhci_hcd
dc00-dc0f : 0000:00:1f.2
  dc00-dc0f : libata
e000-e003 : 0000:00:1f.2
  e000-e003 : libata
e400-e407 : 0000:00:1f.2
  e400-e407 : libata
e800-e803 : 0000:00:1f.2
  e800-e803 : libata
ec00-ec07 : 0000:00:1f.2
  ec00-ec07 : libata
ffa0-ffaf : 0000:00:1f.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
 
[root@localhost root]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-7fe2ffff : System RAM
  00100000-002a2fff : Kernel code
  002a3000-003542ff : Kernel data
7fe30000-7fe414a9 : ACPI Non-volatile Storage
7fe414aa-7ff2ffff : System RAM
7ff30000-7ff3ffff : ACPI Tables
7ff40000-7ffeffff : ACPI Non-volatile Storage
7fff0000-7fffffff : reserved
80000000-800003ff : 0000:00:1f.1
f8000000-fbffffff : 0000:00:00.0
fc900000-fc9fffff : PCI Bus #02
  fc9e0000-fc9fffff : 0000:02:01.0
    fc9e0000-fc9fffff : e1000
fd000000-fdffffff : 0000:03:06.0
feaa0000-feabffff : 0000:03:07.0
  feaa0000-feabffff : sata_promise
feafd000-feafdfff : 0000:03:08.0
  feafd000-feafdfff : e100
feafe000-feafefff : 0000:03:07.0
  feafe000-feafefff : sata_promise
feaff000-feafffff : 0000:03:06.0
febffc00-febfffff : 0000:00:1d.7
  febffc00-febfffff : ehci_hcd
fecf0000-fecf0fff : reserved
fed20000-fed9ffff : reserved
 
[root@localhost root]# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD2500JD-32H Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD2500JD-32H Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD2500JD-32H Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
Host: scsi3 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: WDC WD2500JD-32H Rev: 1.02
  Type:   Direct-Access                    ANSI SCSI revision: 05
 
 
[root@localhost root]# cat /etc/fstab
LABEL=/                 /                       xfs     defaults        1 1
LABEL=/boot             /boot                   ext3    defaults        1 2
/dev/md0                /Raid0                  xfs     noatime         1 2
none                    /dev/pts                devpts  gid=5,mode=620  0 0
none                    /dev/shm                tmpfs   defaults        0 0
none                    /proc                   proc    defaults        0 0
none                    /sys                    sysfs   defaults        0 0
/dev/sda3               swap                    swap    defaults        0 0
/dev/cdrom              /mnt/cdrom              udf,iso9660 noauto,owner,kudzu,r
o 0 0
/dev/fd0                /mnt/floppy             auto    noauto,owner,kudzu 0 0
 
[root@localhost root]# cat /etc/exports
/Raid0          *(no_wdelay,insecure,rw,async)
 
-Bill Vaughan
bvaughan@mindspring.com

------=_NextPart_000_008C_01C45CE8.70580040
Content-Type: text/plain;
	name="sysctl.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sysctl.txt"

sunrpc.tcp_slot_table_entries =3D 16=0A=
sunrpc.udp_slot_table_entries =3D 16=0A=
sunrpc.nlm_debug =3D 0=0A=
sunrpc.nfsd_debug =3D 0=0A=
sunrpc.nfs_debug =3D 0=0A=
sunrpc.rpc_debug =3D 0=0A=
abi.fake_utsname =3D 0=0A=
abi.trace =3D 0=0A=
abi.defhandler_libcso =3D 68157441=0A=
abi.defhandler_lcall7 =3D 68157441=0A=
abi.defhandler_elf =3D 0=0A=
abi.defhandler_coff =3D 117440515=0A=
dev.scsi.logging_level =3D 0=0A=
dev.raid.speed_limit_max =3D 200000=0A=
dev.raid.speed_limit_min =3D 1000=0A=
dev.cdrom.check_media =3D 0=0A=
dev.cdrom.lock =3D 1=0A=
dev.cdrom.debug =3D 0=0A=
dev.cdrom.autoeject =3D 0=0A=
dev.cdrom.autoclose =3D 1=0A=
dev.cdrom.info =3D CD-ROM information, Id: cdrom.c 3.20 2003/12/17=0A=
dev.cdrom.info =3D =0A=
dev.cdrom.info =3D drive name:		hda=0A=
dev.cdrom.info =3D drive speed:		24=0A=
dev.cdrom.info =3D drive # of slots:	1=0A=
dev.cdrom.info =3D Can close tray:		1=0A=
dev.cdrom.info =3D Can open tray:		1=0A=
dev.cdrom.info =3D Can lock tray:		1=0A=
dev.cdrom.info =3D Can change speed:	1=0A=
dev.cdrom.info =3D Can select disk:	0=0A=
dev.cdrom.info =3D Can read multisession:	1=0A=
dev.cdrom.info =3D Can read MCN:		1=0A=
dev.cdrom.info =3D Reports media changed:	1=0A=
dev.cdrom.info =3D Can play audio:		1=0A=
dev.cdrom.info =3D Can write CD-R:		0=0A=
dev.cdrom.info =3D Can write CD-RW:	0=0A=
dev.cdrom.info =3D Can read DVD:		0=0A=
dev.cdrom.info =3D Can write DVD-R:	0=0A=
dev.cdrom.info =3D Can write DVD-RAM:	0=0A=
dev.cdrom.info =3D Can read MRW:		0=0A=
dev.cdrom.info =3D Can write MRW:		0=0A=
dev.cdrom.info =3D Can write RAM:		0=0A=
dev.cdrom.info =3D =0A=
dev.cdrom.info =3D =0A=
dev.rtc.max-user-freq =3D 64=0A=
net.ipv6.conf.eth1.max_addresses =3D 16=0A=
net.ipv6.conf.eth1.max_desync_factor =3D 600=0A=
net.ipv6.conf.eth1.regen_max_retry =3D 5=0A=
net.ipv6.conf.eth1.temp_prefered_lft =3D 86400=0A=
net.ipv6.conf.eth1.temp_valid_lft =3D 604800=0A=
net.ipv6.conf.eth1.use_tempaddr =3D 0=0A=
net.ipv6.conf.eth1.force_mld_version =3D 0=0A=
net.ipv6.conf.eth1.router_solicitation_delay =3D 1=0A=
net.ipv6.conf.eth1.router_solicitation_interval =3D 4=0A=
net.ipv6.conf.eth1.router_solicitations =3D 3=0A=
net.ipv6.conf.eth1.dad_transmits =3D 1=0A=
net.ipv6.conf.eth1.autoconf =3D 1=0A=
net.ipv6.conf.eth1.accept_redirects =3D 1=0A=
net.ipv6.conf.eth1.accept_ra =3D 1=0A=
net.ipv6.conf.eth1.mtu =3D 16000=0A=
net.ipv6.conf.eth1.hop_limit =3D 64=0A=
net.ipv6.conf.eth1.forwarding =3D 0=0A=
net.ipv6.conf.eth0.max_addresses =3D 16=0A=
net.ipv6.conf.eth0.max_desync_factor =3D 600=0A=
net.ipv6.conf.eth0.regen_max_retry =3D 5=0A=
net.ipv6.conf.eth0.temp_prefered_lft =3D 86400=0A=
net.ipv6.conf.eth0.temp_valid_lft =3D 604800=0A=
net.ipv6.conf.eth0.use_tempaddr =3D 0=0A=
net.ipv6.conf.eth0.force_mld_version =3D 0=0A=
net.ipv6.conf.eth0.router_solicitation_delay =3D 1=0A=
net.ipv6.conf.eth0.router_solicitation_interval =3D 4=0A=
net.ipv6.conf.eth0.router_solicitations =3D 3=0A=
net.ipv6.conf.eth0.dad_transmits =3D 1=0A=
net.ipv6.conf.eth0.autoconf =3D 1=0A=
net.ipv6.conf.eth0.accept_redirects =3D 1=0A=
net.ipv6.conf.eth0.accept_ra =3D 1=0A=
net.ipv6.conf.eth0.mtu =3D 1500=0A=
net.ipv6.conf.eth0.hop_limit =3D 64=0A=
net.ipv6.conf.eth0.forwarding =3D 0=0A=
net.ipv6.conf.default.max_addresses =3D 16=0A=
net.ipv6.conf.default.max_desync_factor =3D 600=0A=
net.ipv6.conf.default.regen_max_retry =3D 5=0A=
net.ipv6.conf.default.temp_prefered_lft =3D 86400=0A=
net.ipv6.conf.default.temp_valid_lft =3D 604800=0A=
net.ipv6.conf.default.use_tempaddr =3D 0=0A=
net.ipv6.conf.default.force_mld_version =3D 0=0A=
net.ipv6.conf.default.router_solicitation_delay =3D 1=0A=
net.ipv6.conf.default.router_solicitation_interval =3D 4=0A=
net.ipv6.conf.default.router_solicitations =3D 3=0A=
net.ipv6.conf.default.dad_transmits =3D 1=0A=
net.ipv6.conf.default.autoconf =3D 1=0A=
net.ipv6.conf.default.accept_redirects =3D 1=0A=
net.ipv6.conf.default.accept_ra =3D 1=0A=
net.ipv6.conf.default.mtu =3D 1280=0A=
net.ipv6.conf.default.hop_limit =3D 64=0A=
net.ipv6.conf.default.forwarding =3D 0=0A=
net.ipv6.conf.all.max_addresses =3D 16=0A=
net.ipv6.conf.all.max_desync_factor =3D 600=0A=
net.ipv6.conf.all.regen_max_retry =3D 5=0A=
net.ipv6.conf.all.temp_prefered_lft =3D 86400=0A=
net.ipv6.conf.all.temp_valid_lft =3D 604800=0A=
net.ipv6.conf.all.use_tempaddr =3D 0=0A=
net.ipv6.conf.all.force_mld_version =3D 0=0A=
net.ipv6.conf.all.router_solicitation_delay =3D 1=0A=
net.ipv6.conf.all.router_solicitation_interval =3D 4=0A=
net.ipv6.conf.all.router_solicitations =3D 3=0A=
net.ipv6.conf.all.dad_transmits =3D 1=0A=
net.ipv6.conf.all.autoconf =3D 1=0A=
net.ipv6.conf.all.accept_redirects =3D 1=0A=
net.ipv6.conf.all.accept_ra =3D 1=0A=
net.ipv6.conf.all.mtu =3D 1280=0A=
net.ipv6.conf.all.hop_limit =3D 64=0A=
net.ipv6.conf.all.forwarding =3D 0=0A=
net.ipv6.conf.lo.max_addresses =3D 16=0A=
net.ipv6.conf.lo.max_desync_factor =3D 600=0A=
net.ipv6.conf.lo.regen_max_retry =3D 5=0A=
net.ipv6.conf.lo.temp_prefered_lft =3D 86400=0A=
net.ipv6.conf.lo.temp_valid_lft =3D 604800=0A=
net.ipv6.conf.lo.use_tempaddr =3D -1=0A=
net.ipv6.conf.lo.force_mld_version =3D 0=0A=
net.ipv6.conf.lo.router_solicitation_delay =3D 1=0A=
net.ipv6.conf.lo.router_solicitation_interval =3D 4=0A=
net.ipv6.conf.lo.router_solicitations =3D 3=0A=
net.ipv6.conf.lo.dad_transmits =3D 1=0A=
net.ipv6.conf.lo.autoconf =3D 1=0A=
net.ipv6.conf.lo.accept_redirects =3D 1=0A=
net.ipv6.conf.lo.accept_ra =3D 1=0A=
net.ipv6.conf.lo.mtu =3D 16436=0A=
net.ipv6.conf.lo.hop_limit =3D 64=0A=
net.ipv6.conf.lo.forwarding =3D 0=0A=
net.ipv6.neigh.eth1.locktime =3D 0=0A=
net.ipv6.neigh.eth1.proxy_delay =3D 80=0A=
net.ipv6.neigh.eth1.anycast_delay =3D 100=0A=
net.ipv6.neigh.eth1.proxy_qlen =3D 64=0A=
net.ipv6.neigh.eth1.unres_qlen =3D 3=0A=
net.ipv6.neigh.eth1.gc_stale_time =3D 60=0A=
net.ipv6.neigh.eth1.delay_first_probe_time =3D 5=0A=
net.ipv6.neigh.eth1.base_reachable_time =3D 30=0A=
net.ipv6.neigh.eth1.retrans_time =3D 1000=0A=
net.ipv6.neigh.eth1.app_solicit =3D 0=0A=
net.ipv6.neigh.eth1.ucast_solicit =3D 3=0A=
net.ipv6.neigh.eth1.mcast_solicit =3D 3=0A=
net.ipv6.neigh.eth0.locktime =3D 0=0A=
net.ipv6.neigh.eth0.proxy_delay =3D 80=0A=
net.ipv6.neigh.eth0.anycast_delay =3D 100=0A=
net.ipv6.neigh.eth0.proxy_qlen =3D 64=0A=
net.ipv6.neigh.eth0.unres_qlen =3D 3=0A=
net.ipv6.neigh.eth0.gc_stale_time =3D 60=0A=
net.ipv6.neigh.eth0.delay_first_probe_time =3D 5=0A=
net.ipv6.neigh.eth0.base_reachable_time =3D 30=0A=
net.ipv6.neigh.eth0.retrans_time =3D 1000=0A=
net.ipv6.neigh.eth0.app_solicit =3D 0=0A=
net.ipv6.neigh.eth0.ucast_solicit =3D 3=0A=
net.ipv6.neigh.eth0.mcast_solicit =3D 3=0A=
net.ipv6.neigh.lo.locktime =3D 0=0A=
net.ipv6.neigh.lo.proxy_delay =3D 80=0A=
net.ipv6.neigh.lo.anycast_delay =3D 100=0A=
net.ipv6.neigh.lo.proxy_qlen =3D 64=0A=
net.ipv6.neigh.lo.unres_qlen =3D 3=0A=
net.ipv6.neigh.lo.gc_stale_time =3D 60=0A=
net.ipv6.neigh.lo.delay_first_probe_time =3D 5=0A=
net.ipv6.neigh.lo.base_reachable_time =3D 30=0A=
net.ipv6.neigh.lo.retrans_time =3D 1000=0A=
net.ipv6.neigh.lo.app_solicit =3D 0=0A=
net.ipv6.neigh.lo.ucast_solicit =3D 3=0A=
net.ipv6.neigh.lo.mcast_solicit =3D 3=0A=
net.ipv6.neigh.default.gc_thresh3 =3D 1024=0A=
net.ipv6.neigh.default.gc_thresh2 =3D 512=0A=
net.ipv6.neigh.default.gc_thresh1 =3D 128=0A=
net.ipv6.neigh.default.gc_interval =3D 30=0A=
net.ipv6.neigh.default.locktime =3D 0=0A=
net.ipv6.neigh.default.proxy_delay =3D 80=0A=
net.ipv6.neigh.default.anycast_delay =3D 100=0A=
net.ipv6.neigh.default.proxy_qlen =3D 64=0A=
net.ipv6.neigh.default.unres_qlen =3D 3=0A=
net.ipv6.neigh.default.gc_stale_time =3D 60=0A=
net.ipv6.neigh.default.delay_first_probe_time =3D 5=0A=
net.ipv6.neigh.default.base_reachable_time =3D 30=0A=
net.ipv6.neigh.default.retrans_time =3D 1000=0A=
net.ipv6.neigh.default.app_solicit =3D 0=0A=
net.ipv6.neigh.default.ucast_solicit =3D 3=0A=
net.ipv6.neigh.default.mcast_solicit =3D 3=0A=
net.ipv6.mld_max_msf =3D 10=0A=
net.ipv6.ip6frag_secret_interval =3D 600=0A=
net.ipv6.ip6frag_time =3D 60=0A=
net.ipv6.ip6frag_low_thresh =3D 196608=0A=
net.ipv6.ip6frag_high_thresh =3D 262144=0A=
net.ipv6.bindv6only =3D 0=0A=
net.ipv6.icmp.ratelimit =3D 1000=0A=
net.ipv6.route.min_adv_mss =3D 1=0A=
net.ipv6.route.mtu_expires =3D 600=0A=
net.ipv6.route.gc_elasticity =3D 0=0A=
net.ipv6.route.gc_interval =3D 30=0A=
net.ipv6.route.gc_timeout =3D 60=0A=
net.ipv6.route.gc_min_interval =3D 0=0A=
net.ipv6.route.max_size =3D 4096=0A=
net.ipv6.route.gc_thresh =3D 1024=0A=
net.unix.max_dgram_qlen =3D 10=0A=
net.ipv4.conf.eth1.force_igmp_version =3D 0=0A=
net.ipv4.conf.eth1.disable_policy =3D 0=0A=
net.ipv4.conf.eth1.disable_xfrm =3D 0=0A=
net.ipv4.conf.eth1.arp_ignore =3D 0=0A=
net.ipv4.conf.eth1.arp_announce =3D 0=0A=
net.ipv4.conf.eth1.arp_filter =3D 0=0A=
net.ipv4.conf.eth1.tag =3D 0=0A=
net.ipv4.conf.eth1.log_martians =3D 0=0A=
net.ipv4.conf.eth1.bootp_relay =3D 0=0A=
net.ipv4.conf.eth1.medium_id =3D 0=0A=
net.ipv4.conf.eth1.proxy_arp =3D 0=0A=
net.ipv4.conf.eth1.accept_source_route =3D 1=0A=
net.ipv4.conf.eth1.send_redirects =3D 1=0A=
net.ipv4.conf.eth1.rp_filter =3D 1=0A=
net.ipv4.conf.eth1.shared_media =3D 1=0A=
net.ipv4.conf.eth1.secure_redirects =3D 1=0A=
net.ipv4.conf.eth1.accept_redirects =3D 1=0A=
net.ipv4.conf.eth1.mc_forwarding =3D 0=0A=
net.ipv4.conf.eth1.forwarding =3D 0=0A=
net.ipv4.conf.eth0.force_igmp_version =3D 0=0A=
net.ipv4.conf.eth0.disable_policy =3D 0=0A=
net.ipv4.conf.eth0.disable_xfrm =3D 0=0A=
net.ipv4.conf.eth0.arp_ignore =3D 0=0A=
net.ipv4.conf.eth0.arp_announce =3D 0=0A=
net.ipv4.conf.eth0.arp_filter =3D 0=0A=
net.ipv4.conf.eth0.tag =3D 0=0A=
net.ipv4.conf.eth0.log_martians =3D 0=0A=
net.ipv4.conf.eth0.bootp_relay =3D 0=0A=
net.ipv4.conf.eth0.medium_id =3D 0=0A=
net.ipv4.conf.eth0.proxy_arp =3D 0=0A=
net.ipv4.conf.eth0.accept_source_route =3D 1=0A=
net.ipv4.conf.eth0.send_redirects =3D 1=0A=
net.ipv4.conf.eth0.rp_filter =3D 1=0A=
net.ipv4.conf.eth0.shared_media =3D 1=0A=
net.ipv4.conf.eth0.secure_redirects =3D 1=0A=
net.ipv4.conf.eth0.accept_redirects =3D 1=0A=
net.ipv4.conf.eth0.mc_forwarding =3D 0=0A=
net.ipv4.conf.eth0.forwarding =3D 0=0A=
net.ipv4.conf.lo.force_igmp_version =3D 0=0A=
net.ipv4.conf.lo.disable_policy =3D 1=0A=
net.ipv4.conf.lo.disable_xfrm =3D 1=0A=
net.ipv4.conf.lo.arp_ignore =3D 0=0A=
net.ipv4.conf.lo.arp_announce =3D 0=0A=
net.ipv4.conf.lo.arp_filter =3D 0=0A=
net.ipv4.conf.lo.tag =3D 0=0A=
net.ipv4.conf.lo.log_martians =3D 0=0A=
net.ipv4.conf.lo.bootp_relay =3D 0=0A=
net.ipv4.conf.lo.medium_id =3D 0=0A=
net.ipv4.conf.lo.proxy_arp =3D 0=0A=
net.ipv4.conf.lo.accept_source_route =3D 1=0A=
net.ipv4.conf.lo.send_redirects =3D 1=0A=
net.ipv4.conf.lo.rp_filter =3D 0=0A=
net.ipv4.conf.lo.shared_media =3D 1=0A=
net.ipv4.conf.lo.secure_redirects =3D 1=0A=
net.ipv4.conf.lo.accept_redirects =3D 1=0A=
net.ipv4.conf.lo.mc_forwarding =3D 0=0A=
net.ipv4.conf.lo.forwarding =3D 0=0A=
net.ipv4.conf.default.force_igmp_version =3D 0=0A=
net.ipv4.conf.default.disable_policy =3D 0=0A=
net.ipv4.conf.default.disable_xfrm =3D 0=0A=
net.ipv4.conf.default.arp_ignore =3D 0=0A=
net.ipv4.conf.default.arp_announce =3D 0=0A=
net.ipv4.conf.default.arp_filter =3D 0=0A=
net.ipv4.conf.default.tag =3D 0=0A=
net.ipv4.conf.default.log_martians =3D 0=0A=
net.ipv4.conf.default.bootp_relay =3D 0=0A=
net.ipv4.conf.default.medium_id =3D 0=0A=
net.ipv4.conf.default.proxy_arp =3D 0=0A=
net.ipv4.conf.default.accept_source_route =3D 1=0A=
net.ipv4.conf.default.send_redirects =3D 1=0A=
net.ipv4.conf.default.rp_filter =3D 1=0A=
net.ipv4.conf.default.shared_media =3D 1=0A=
net.ipv4.conf.default.secure_redirects =3D 1=0A=
net.ipv4.conf.default.accept_redirects =3D 1=0A=
net.ipv4.conf.default.mc_forwarding =3D 0=0A=
net.ipv4.conf.default.forwarding =3D 0=0A=
net.ipv4.conf.all.force_igmp_version =3D 0=0A=
net.ipv4.conf.all.disable_policy =3D 0=0A=
net.ipv4.conf.all.disable_xfrm =3D 0=0A=
net.ipv4.conf.all.arp_ignore =3D 0=0A=
net.ipv4.conf.all.arp_announce =3D 0=0A=
net.ipv4.conf.all.arp_filter =3D 0=0A=
net.ipv4.conf.all.tag =3D 0=0A=
net.ipv4.conf.all.log_martians =3D 0=0A=
net.ipv4.conf.all.bootp_relay =3D 0=0A=
net.ipv4.conf.all.medium_id =3D 0=0A=
net.ipv4.conf.all.proxy_arp =3D 0=0A=
net.ipv4.conf.all.accept_source_route =3D 0=0A=
net.ipv4.conf.all.send_redirects =3D 1=0A=
net.ipv4.conf.all.rp_filter =3D 0=0A=
net.ipv4.conf.all.shared_media =3D 1=0A=
net.ipv4.conf.all.secure_redirects =3D 1=0A=
net.ipv4.conf.all.accept_redirects =3D 1=0A=
net.ipv4.conf.all.mc_forwarding =3D 0=0A=
net.ipv4.conf.all.forwarding =3D 0=0A=
net.ipv4.neigh.eth1.locktime =3D 100=0A=
net.ipv4.neigh.eth1.proxy_delay =3D 80=0A=
net.ipv4.neigh.eth1.anycast_delay =3D 100=0A=
net.ipv4.neigh.eth1.proxy_qlen =3D 64=0A=
net.ipv4.neigh.eth1.unres_qlen =3D 3=0A=
net.ipv4.neigh.eth1.gc_stale_time =3D 60=0A=
net.ipv4.neigh.eth1.delay_first_probe_time =3D 5=0A=
net.ipv4.neigh.eth1.base_reachable_time =3D 30=0A=
net.ipv4.neigh.eth1.retrans_time =3D 100=0A=
net.ipv4.neigh.eth1.app_solicit =3D 0=0A=
net.ipv4.neigh.eth1.ucast_solicit =3D 3=0A=
net.ipv4.neigh.eth1.mcast_solicit =3D 3=0A=
net.ipv4.neigh.eth0.locktime =3D 100=0A=
net.ipv4.neigh.eth0.proxy_delay =3D 80=0A=
net.ipv4.neigh.eth0.anycast_delay =3D 100=0A=
net.ipv4.neigh.eth0.proxy_qlen =3D 64=0A=
net.ipv4.neigh.eth0.unres_qlen =3D 3=0A=
net.ipv4.neigh.eth0.gc_stale_time =3D 60=0A=
net.ipv4.neigh.eth0.delay_first_probe_time =3D 5=0A=
net.ipv4.neigh.eth0.base_reachable_time =3D 30=0A=
net.ipv4.neigh.eth0.retrans_time =3D 100=0A=
net.ipv4.neigh.eth0.app_solicit =3D 0=0A=
net.ipv4.neigh.eth0.ucast_solicit =3D 3=0A=
net.ipv4.neigh.eth0.mcast_solicit =3D 3=0A=
net.ipv4.neigh.lo.locktime =3D 100=0A=
net.ipv4.neigh.lo.proxy_delay =3D 80=0A=
net.ipv4.neigh.lo.anycast_delay =3D 100=0A=
net.ipv4.neigh.lo.proxy_qlen =3D 64=0A=
net.ipv4.neigh.lo.unres_qlen =3D 3=0A=
net.ipv4.neigh.lo.gc_stale_time =3D 60=0A=
net.ipv4.neigh.lo.delay_first_probe_time =3D 5=0A=
net.ipv4.neigh.lo.base_reachable_time =3D 30=0A=
net.ipv4.neigh.lo.retrans_time =3D 100=0A=
net.ipv4.neigh.lo.app_solicit =3D 0=0A=
net.ipv4.neigh.lo.ucast_solicit =3D 3=0A=
net.ipv4.neigh.lo.mcast_solicit =3D 3=0A=
net.ipv4.neigh.default.gc_thresh3 =3D 1024=0A=
net.ipv4.neigh.default.gc_thresh2 =3D 512=0A=
net.ipv4.neigh.default.gc_thresh1 =3D 128=0A=
net.ipv4.neigh.default.gc_interval =3D 30=0A=
net.ipv4.neigh.default.locktime =3D 100=0A=
net.ipv4.neigh.default.proxy_delay =3D 80=0A=
net.ipv4.neigh.default.anycast_delay =3D 100=0A=
net.ipv4.neigh.default.proxy_qlen =3D 64=0A=
net.ipv4.neigh.default.unres_qlen =3D 3=0A=
net.ipv4.neigh.default.gc_stale_time =3D 60=0A=
net.ipv4.neigh.default.delay_first_probe_time =3D 5=0A=
net.ipv4.neigh.default.base_reachable_time =3D 30=0A=
net.ipv4.neigh.default.retrans_time =3D 100=0A=
net.ipv4.neigh.default.app_solicit =3D 0=0A=
net.ipv4.neigh.default.ucast_solicit =3D 3=0A=
net.ipv4.neigh.default.mcast_solicit =3D 3=0A=
net.ipv4.tcp_vegas_gamma =3D 2=0A=
net.ipv4.tcp_vegas_beta =3D 6=0A=
net.ipv4.tcp_vegas_alpha =3D 2=0A=
net.ipv4.tcp_vegas_cong_avoid =3D 0=0A=
net.ipv4.tcp_westwood =3D 0=0A=
net.ipv4.tcp_no_metrics_save =3D 0=0A=
net.ipv4.ipfrag_secret_interval =3D 600=0A=
net.ipv4.tcp_low_latency =3D 0=0A=
net.ipv4.tcp_frto =3D 0=0A=
net.ipv4.tcp_tw_reuse =3D 0=0A=
net.ipv4.icmp_ratemask =3D 6168=0A=
net.ipv4.icmp_ratelimit =3D 1000=0A=
net.ipv4.tcp_adv_win_scale =3D 2=0A=
net.ipv4.tcp_app_win =3D 31=0A=
net.ipv4.tcp_rmem =3D 4096	87380	174760=0A=
net.ipv4.tcp_wmem =3D 4096	16384	131072=0A=
net.ipv4.tcp_mem =3D 195584	196096	196608=0A=
net.ipv4.tcp_dsack =3D 1=0A=
net.ipv4.tcp_ecn =3D 0=0A=
net.ipv4.tcp_reordering =3D 3=0A=
net.ipv4.tcp_fack =3D 1=0A=
net.ipv4.tcp_orphan_retries =3D 0=0A=
net.ipv4.inet_peer_gc_maxtime =3D 120=0A=
net.ipv4.inet_peer_gc_mintime =3D 10=0A=
net.ipv4.inet_peer_maxttl =3D 600=0A=
net.ipv4.inet_peer_minttl =3D 120=0A=
net.ipv4.inet_peer_threshold =3D 65664=0A=
net.ipv4.igmp_max_msf =3D 10=0A=
net.ipv4.igmp_max_memberships =3D 20=0A=
net.ipv4.route.secret_interval =3D 600=0A=
net.ipv4.route.min_adv_mss =3D 256=0A=
net.ipv4.route.min_pmtu =3D 552=0A=
net.ipv4.route.mtu_expires =3D 600=0A=
net.ipv4.route.gc_elasticity =3D 8=0A=
net.ipv4.route.error_burst =3D 5000=0A=
net.ipv4.route.error_cost =3D 1000=0A=
net.ipv4.route.redirect_silence =3D 20480=0A=
net.ipv4.route.redirect_number =3D 9=0A=
net.ipv4.route.redirect_load =3D 20=0A=
net.ipv4.route.gc_interval =3D 60=0A=
net.ipv4.route.gc_timeout =3D 300=0A=
net.ipv4.route.gc_min_interval =3D 0=0A=
net.ipv4.route.max_size =3D 262144=0A=
net.ipv4.route.gc_thresh =3D 16384=0A=
net.ipv4.route.max_delay =3D 10=0A=
net.ipv4.route.min_delay =3D 2=0A=
net.ipv4.icmp_ignore_bogus_error_responses =3D 0=0A=
net.ipv4.icmp_echo_ignore_broadcasts =3D 0=0A=
net.ipv4.icmp_echo_ignore_all =3D 0=0A=
net.ipv4.ip_local_port_range =3D 32768	61000=0A=
net.ipv4.tcp_max_syn_backlog =3D 1024=0A=
net.ipv4.tcp_rfc1337 =3D 0=0A=
net.ipv4.tcp_stdurg =3D 0=0A=
net.ipv4.tcp_abort_on_overflow =3D 0=0A=
net.ipv4.tcp_tw_recycle =3D 0=0A=
net.ipv4.tcp_syncookies =3D 0=0A=
net.ipv4.tcp_fin_timeout =3D 60=0A=
net.ipv4.tcp_retries2 =3D 15=0A=
net.ipv4.tcp_retries1 =3D 3=0A=
net.ipv4.tcp_keepalive_intvl =3D 75=0A=
net.ipv4.tcp_keepalive_probes =3D 9=0A=
net.ipv4.tcp_keepalive_time =3D 7200=0A=
net.ipv4.ipfrag_time =3D 30=0A=
net.ipv4.ip_dynaddr =3D 0=0A=
net.ipv4.ipfrag_low_thresh =3D 196608=0A=
net.ipv4.ipfrag_high_thresh =3D 262144=0A=
net.ipv4.tcp_max_tw_buckets =3D 180000=0A=
net.ipv4.tcp_max_orphans =3D 32768=0A=
net.ipv4.tcp_synack_retries =3D 5=0A=
net.ipv4.tcp_syn_retries =3D 5=0A=
net.ipv4.ip_nonlocal_bind =3D 0=0A=
net.ipv4.ip_no_pmtu_disc =3D 0=0A=
net.ipv4.ip_autoconfig =3D 0=0A=
net.ipv4.ip_default_ttl =3D 64=0A=
net.ipv4.ip_forward =3D 0=0A=
net.ipv4.tcp_retrans_collapse =3D 1=0A=
net.ipv4.tcp_sack =3D 1=0A=
net.ipv4.tcp_window_scaling =3D 1=0A=
net.ipv4.tcp_timestamps =3D 1=0A=
net.core.somaxconn =3D 128=0A=
net.core.divert_version =3D 0.46=0A=
net.core.optmem_max =3D 10240=0A=
net.core.message_burst =3D 10=0A=
net.core.message_cost =3D 5=0A=
net.core.mod_cong =3D 290=0A=
net.core.lo_cong =3D 100=0A=
net.core.no_cong =3D 20=0A=
net.core.no_cong_thresh =3D 10=0A=
net.core.netdev_max_backlog =3D 300=0A=
net.core.dev_weight =3D 64=0A=
net.core.rmem_default =3D 262140=0A=
net.core.wmem_default =3D 110592=0A=
net.core.rmem_max =3D 262140=0A=
net.core.wmem_max =3D 131071=0A=
vm.block_dump =3D 0=0A=
vm.laptop_mode =3D 0=0A=
vm.max_map_count =3D 65536=0A=
vm.min_free_kbytes =3D 1447=0A=
vm.lower_zone_protection =3D 0=0A=
vm.nr_hugepages =3D 0=0A=
vm.swappiness =3D 60=0A=
vm.nr_pdflush_threads =3D 2=0A=
vm.dirty_expire_centisecs =3D 3000=0A=
vm.dirty_writeback_centisecs =3D 500=0A=
vm.dirty_ratio =3D 40=0A=
vm.dirty_background_ratio =3D 10=0A=
vm.page-cluster =3D 3=0A=
vm.overcommit_ratio =3D 50=0A=
vm.overcommit_memory =3D 0=0A=
kernel.ngroups_max =3D 65536=0A=
kernel.printk_ratelimit_burst =3D 10=0A=
kernel.printk_ratelimit =3D 5=0A=
kernel.panic_on_oops =3D 0=0A=
kernel.pid_max =3D 32768=0A=
kernel.overflowgid =3D 65534=0A=
kernel.overflowuid =3D 65534=0A=
kernel.pty.nr =3D 3=0A=
kernel.pty.max =3D 4096=0A=
kernel.random.uuid =3D 5b2410fd-9c2a-4c80-94bb-f09a7f9594dc=0A=
kernel.random.boot_id =3D 7df17365-a536-41d8-ad8e-6728cec60a0b=0A=
kernel.random.write_wakeup_threshold =3D 128=0A=
kernel.random.read_wakeup_threshold =3D 64=0A=
kernel.random.entropy_avail =3D 3712=0A=
kernel.random.poolsize =3D 512=0A=
kernel.threads-max =3D 65510=0A=
kernel.cad_pid =3D 1=0A=
kernel.sysrq =3D 0=0A=
kernel.sem =3D 250	32000	32	128=0A=
kernel.msgmnb =3D 16384=0A=
kernel.msgmni =3D 16=0A=
kernel.msgmax =3D 8192=0A=
kernel.shmmni =3D 4096=0A=
kernel.shmall =3D 2097152=0A=
kernel.shmmax =3D 33554432=0A=
kernel.rtsig-max =3D 1024=0A=
kernel.rtsig-nr =3D 0=0A=
kernel.acct =3D 4	2	30=0A=
kernel.hotplug =3D /sbin/hotplug=0A=
kernel.modprobe =3D /sbin/modprobe=0A=
kernel.printk =3D 15	4	1	7=0A=
kernel.ctrl-alt-del =3D 0=0A=
kernel.real-root-dev =3D 256=0A=
kernel.cap-bound =3D -257=0A=
kernel.tainted =3D 0=0A=
kernel.core_pattern =3D core=0A=
kernel.core_uses_pid =3D 1=0A=
kernel.vdso =3D 1=0A=
kernel.print-fatal-signals =3D 0=0A=
kernel.exec-shield-randomize =3D 1=0A=
kernel.exec-shield =3D 1=0A=
kernel.panic =3D 0=0A=
kernel.domainname =3D (none)=0A=
kernel.hostname =3D localhost.localdomain=0A=
kernel.version =3D #1 SMP Sat May 8 09:25:36 EDT 2004=0A=
kernel.osrelease =3D 2.6.5-1.358smp=0A=
kernel.ostype =3D Linux=0A=
fs.nfs.nlm_tcpport =3D 0=0A=
fs.nfs.nlm_udpport =3D 0=0A=
fs.nfs.nlm_timeout =3D 10=0A=
fs.nfs.nlm_grace_period =3D 0=0A=
fs.xfs.stats_clear =3D 0=0A=
fs.xfs.age_buffer =3D 1500=0A=
fs.xfs.flush_interval =3D 100=0A=
fs.xfs.inherit_noatime =3D 1=0A=
fs.xfs.inherit_nodump =3D 1=0A=
fs.xfs.inherit_sync =3D 1=0A=
fs.xfs.sync_interval =3D 3000=0A=
fs.xfs.error_level =3D 3=0A=
fs.xfs.panic_mask =3D 0=0A=
fs.xfs.irix_symlink_mode =3D 0=0A=
fs.xfs.irix_sgid_inherit =3D 0=0A=
fs.xfs.restrict_chown =3D 1=0A=
fs.mqueue.msgsize_max =3D 16384=0A=
fs.mqueue.msg_max =3D 40=0A=
fs.mqueue.queues_max =3D 64=0A=
fs.quota.syncs =3D 20=0A=
fs.quota.free_dquots =3D 0=0A=
fs.quota.allocated_dquots =3D 0=0A=
fs.quota.cache_hits =3D 0=0A=
fs.quota.writes =3D 0=0A=
fs.quota.reads =3D 0=0A=
fs.quota.drops =3D 0=0A=
fs.quota.lookups =3D 0=0A=
fs.aio-max-nr =3D 65536=0A=
fs.aio-nr =3D 0=0A=
fs.lease-break-time =3D 45=0A=
fs.dir-notify-enable =3D 1=0A=
fs.leases-enable =3D 1=0A=
fs.overflowgid =3D 65534=0A=
fs.overflowuid =3D 65534=0A=
fs.dentry-state =3D 35478	29996	45	0	0	0=0A=
fs.file-max =3D 206310=0A=
fs.file-nr =3D 510	0	206310=0A=
fs.inode-state =3D 50429	15000	0	0	0	0	0=0A=
fs.inode-nr =3D 50429	15000=0A=

------=_NextPart_000_008C_01C45CE8.70580040
Content-Type: application/octet-stream;
	name="nfs"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="nfs"

#!/bin/sh=0A=
#=0A=
# nfs           This shell script takes care of starting and stopping=0A=
#               the NFS services.=0A=
#=0A=
# chkconfig: - 60 20=0A=
# description: NFS is a popular protocol for file sharing across TCP/IP \=0A=
#              networks. This service provides NFS server functionality, =
\=0A=
#              which is configured via the /etc/exports file.=0A=
# probe: true=0A=
# config: /etc/sysconfig/nfs=0A=
=0A=
# Source function library.=0A=
. /etc/rc.d/init.d/functions=0A=
=0A=
# Source networking configuration.=0A=
if [ ! -f /etc/sysconfig/network ]; then=0A=
    exit 0=0A=
fi=0A=
=0A=
. /etc/sysconfig/network=0A=
=0A=
# Check that networking is up.=0A=
[ ${NETWORKING} =3D "no" ] && exit 0=0A=
=0A=
[ -x /usr/sbin/rpc.nfsd ] || exit 0=0A=
[ -x /usr/sbin/rpc.mountd ] || exit 0=0A=
[ -x /usr/sbin/exportfs ] || exit 0=0A=
=0A=
# Don't fail if /etc/exports doesn't exist; create a bare-bones version =
and continue.=0A=
[ -s /etc/exports ] || \=0A=
    { echo "#" > /etc/exports && chmod u+rw,g+r,o+r /etc/exports ; } || \=0A=
    { echo "/etc/exports does not exist" ; exit 0 ; }=0A=
=0A=
# Check for and source configuration file otherwise set defaults=0A=
[ -f /etc/sysconfig/nfs ] && . /etc/sysconfig/nfs=0A=
=0A=
MOUNTD_NFS_V2=3Dno=0A=
MOUNTD_NFS_V3=3Dyes=0A=
=0A=
# Number of servers to be started by default=0A=
RPCNFSDCOUNT=3D128=0A=
=0A=
# Remote quota server=0A=
[ -z "$RQUOTAD" ] && RQUOTAD=3D`type -path rpc.rquotad`=0A=
=0A=
# See how we were called.=0A=
case "$1" in=0A=
  start)=0A=
	# Start daemons.=0A=
	action $"Starting NFS services: " /usr/sbin/exportfs -r=0A=
=0A=
	# Set the ports lockd should listen on=0A=
	if [ -n "$LOCKD_TCPPORT" ]; then=0A=
	    /sbin/sysctl -w fs.nfs.nlm_tcpport=3D$LOCKD_TCPPORT >/dev/null 2>&1=0A=
	fi=0A=
	if [ -n "$LOCKD_UDPPORT" ]; then=0A=
	    /sbin/sysctl -w fs.nfs.nlm_udpport=3D$LOCKD_UDPPORT >/dev/null 2>&1=0A=
	fi=0A=
=0A=
	if [ -n "$RQUOTAD" -a "$RQUOTAD" !=3D "no" ]; then=0A=
	    echo -n $"Starting NFS quotas: "=0A=
	    daemon rpc.rquotad=0A=
	    echo=0A=
	fi=0A=
	echo -n $"Starting NFS daemon: "=0A=
	daemon rpc.nfsd $RPCNFSDCOUNT=0A=
	echo=0A=
=0A=
	[ -n "$MOUNTD_PORT" ] \=0A=
	&& RPCMOUNTDOPTS=3D"$RPCMOUNTDOPTS -p $MOUNTD_PORT"=0A=
=0A=
	case $MOUNTD_NFS_V2 in=0A=
	auto|AUTO)=0A=
	    # Let's see if we support NFS version 2.=0A=
	    /usr/sbin/rpcinfo -u localhost nfs 2 &>/dev/null=0A=
	    if [ $? -ne 0 ]; then=0A=
		RPCMOUNTDOPTS=3D"$RPCMOUNTDOPTS --no-nfs-version 2"=0A=
	    fi=0A=
	    ;;=0A=
	no|NO)=0A=
	    RPCMOUNTDOPTS=3D"$RPCMOUNTDOPTS --no-nfs-version 2"=0A=
	    ;;=0A=
	yes|YES)=0A=
	    RPCMOUNTDOPTS=3D"$RPCMOUNTDOPTS --nfs-version 2"=0A=
	    ;;=0A=
	esac=0A=
=0A=
	case $MOUNTD_NFS_V3 in=0A=
	auto|AUTO)=0A=
	    # Let's see if we support NFS version 3.=0A=
	    /usr/sbin/rpcinfo -u localhost nfs 3 &>/dev/null=0A=
	    if [ $? -ne 0 ]; then=0A=
		RPCMOUNTDOPTS=3D"$RPCMOUNTDOPTS --no-nfs-version 3"=0A=
	    fi=0A=
	    ;;=0A=
	no|NO)=0A=
	    RPCMOUNTDOPTS=3D"$RPCMOUNTDOPTS --no-nfs-version 3"=0A=
	    ;;=0A=
	yes|YES)=0A=
	    RPCMOUNTDOPTS=3D"$RPCMOUNTDOPTS --nfs-version 3"=0A=
	    ;;=0A=
	esac=0A=
=0A=
	echo -n $"Starting NFS mountd: "=0A=
	daemon rpc.mountd $RPCMOUNTDOPTS=0A=
	echo=0A=
	touch /var/lock/subsys/nfs=0A=
=0A=
	# See if rpc.imapd and rpc.svcgssd need to be started.=0A=
	[ -x /usr/sbin/rpc.idmapd ] && /sbin/service rpcidmapd condstart=0A=
	[ -x /usr/sbin/rpc.svcgssd ] && /sbin/service rpcsvcgssd condstart=0A=
=0A=
	;;=0A=
  stop)=0A=
	# Stop daemons.=0A=
	echo -n $"Shutting down NFS mountd: "=0A=
	killproc rpc.mountd=0A=
	echo=0A=
	echo -n $"Shutting down NFS daemon: "=0A=
	killproc nfsd=0A=
	echo=0A=
	if [ -n "$RQUOTAD" ]; then=0A=
		echo -n $"Shutting down NFS quotas: "=0A=
		killproc rpc.rquotad=0A=
		echo=0A=
	fi=0A=
	# Reset the lockd ports if they were set=0A=
	if [ -n "$LOCKD_TCPPORT" ]; then=0A=
	    /sbin/sysctl -w fs.nfs.nlm_tcpport=3D0 >/dev/null 2>&1=0A=
	fi=0A=
	if [ -n "$LOCKD_UDPPORT" ]; then=0A=
	    /sbin/sysctl -w fs.nfs.nlm_udpport=3D0 >/dev/null 2>&1=0A=
	fi=0A=
	# Do it the last so that clients can still access the server=0A=
	# when the server is running.=0A=
	action $"Shutting down NFS services: " /usr/sbin/exportfs -au=0A=
	rm -f /var/lock/subsys/nfs=0A=
	;;=0A=
  status)=0A=
	status rpc.mountd=0A=
	status nfsd=0A=
	if [ -n "$RQUOTAD" ]; then=0A=
		status rpc.rquotad=0A=
	fi=0A=
	;;=0A=
  restart)=0A=
	$0 stop=0A=
	$0 start=0A=
	;;=0A=
  reload)=0A=
	/usr/sbin/exportfs -r=0A=
	touch /var/lock/subsys/nfs=0A=
	;;=0A=
  probe)=0A=
	if [ ! -f /var/lock/subsys/nfs ] ; then=0A=
	  echo $"start"; exit 0=0A=
	fi=0A=
	/sbin/pidof rpc.mountd >/dev/null 2>&1; MOUNTD=3D"$?"=0A=
	/sbin/pidof nfsd >/dev/null 2>&1; NFSD=3D"$?"=0A=
	if [ $MOUNTD =3D 1 -o $NFSD =3D 1 ] ; then=0A=
	  echo $"restart"; exit 0=0A=
	fi=0A=
	if [ /etc/exports -nt /var/lock/subsys/nfs ] ; then=0A=
	  echo $"reload"; exit 0=0A=
	fi=0A=
	;;=0A=
  condrestart)=0A=
  	[ -f /var/lock/subsys/nfs ] && {=0A=
		$0 stop=0A=
		$0 start=0A=
	}=0A=
	;;=0A=
  *)=0A=
	echo $"Usage: nfs {start|stop|status|restart|reload|condrestart}"=0A=
	exit 1=0A=
esac=0A=
=0A=
exit 0=0A=

------=_NextPart_000_008C_01C45CE8.70580040
Content-Type: text/plain;
	name="lspci.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="lspci.txt"

00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)=0A=
	Subsystem: Intel Corp. 82875P Memory Controller Hub=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort+ >SERR- <PERR-=0A=
	Latency: 0=0A=
	Region 0: Memory at f8000000 (32-bit, prefetchable)=0A=
	Capabilities: [e4] #09 [2106]=0A=
	Capabilities: [a0] AGP version 3.0=0A=
		Status: RQ=3D32 Iso- ArqSz=3D2 Cal=3D0 SBA+ ITACoh- GART64- HTrans- =
64bit- FW+ AGP3- Rate=3Dx1,x2,x4=0A=
		Command: RQ=3D1 ArqSz=3D0 Cal=3D0 SBA- AGP- GART64- 64bit- FW- =
Rate=3D<none>=0A=
=0A=
00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev =
02) (prog-if 00 [Normal decode])=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 32=0A=
	Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D32=0A=
	I/O behind bridge: 0000f000-00000fff=0A=
	Memory behind bridge: fff00000-000fffff=0A=
	Prefetchable memory behind bridge: fff00000-000fffff=0A=
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
=0A=
00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge =
(rev 02) (prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 32=0A=
	Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D0=0A=
	I/O behind bridge: 00009000-00009fff=0A=
	Memory behind bridge: fc900000-fc9fffff=0A=
	Prefetchable memory behind bridge: fff00000-000fffff=0A=
	Expansion ROM at 00009000 [disabled] [size=3D4K]=0A=
	BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-=0A=
=0A=
00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 =
(rev 02) (prog-if 00 [UHCI])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin A routed to IRQ 169=0A=
	Region 4: I/O ports at cc00 [size=3D32]=0A=
=0A=
00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 =
(rev 02) (prog-if 00 [UHCI])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin B routed to IRQ 193=0A=
	Region 4: I/O ports at d000 [size=3D32]=0A=
=0A=
00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 =
(rev 02) (prog-if 00 [UHCI])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin C routed to IRQ 185=0A=
	Region 4: I/O ports at d400 [size=3D32]=0A=
=0A=
00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 =
(rev 02) (prog-if 00 [UHCI])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin A routed to IRQ 169=0A=
	Region 4: I/O ports at d800 [size=3D32]=0A=
=0A=
00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI =
Controller (rev 02) (prog-if 20 [EHCI])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin D routed to IRQ 201=0A=
	Region 0: Memory at febffc00 (32-bit, non-prefetchable)=0A=
	Capabilities: [50] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D375mA =
PME(D0+,D1-,D2-,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
	Capabilities: [58] #0a [20a0]=0A=
=0A=
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB/ER Hub interface to PCI =
Bridge (rev c2) (prog-if 00 [Normal decode])=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D32=0A=
	I/O behind bridge: 0000a000-0000bfff=0A=
	Memory behind bridge: fca00000-feafffff=0A=
	Prefetchable memory behind bridge: fff00000-000fffff=0A=
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-=0A=
=0A=
00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev =
02)=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
=0A=
00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 =
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin A routed to IRQ 185=0A=
	Region 0: I/O ports at <unassigned>=0A=
	Region 1: I/O ports at <unassigned>=0A=
	Region 2: I/O ports at <unassigned>=0A=
	Region 3: I/O ports at <unassigned>=0A=
	Region 4: I/O ports at ffa0 [size=3D16]=0A=
	Region 5: Memory at 80000000 (32-bit, non-prefetchable) [size=3D1K]=0A=
=0A=
00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage =
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0=0A=
	Interrupt: pin A routed to IRQ 185=0A=
	Region 0: I/O ports at ec00=0A=
	Region 1: I/O ports at e800 [size=3D4]=0A=
	Region 2: I/O ports at e400 [size=3D8]=0A=
	Region 3: I/O ports at e000 [size=3D4]=0A=
	Region 4: I/O ports at dc00 [size=3D16]=0A=
=0A=
00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev =
02)=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Interrupt: pin B routed to IRQ 177=0A=
	Region 4: I/O ports at c800 [size=3D32]=0A=
=0A=
02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet =
Controller (LOM)=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping- SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 0 (63750ns min), Cache Line Size 10=0A=
	Interrupt: pin A routed to IRQ 185=0A=
	Region 0: Memory at fc9e0000 (32-bit, non-prefetchable)=0A=
	Region 2: I/O ports at 9c00 [size=3D32]=0A=
	Capabilities: [dc] Power Management version 2=0A=
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=3D0mA =
PME(D0+,D1-,D2-,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D1 PME-=0A=
=0A=
03:06.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) =
(prog-if 00 [VGA])=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- =
Stepping+ SERR- FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 32 (2000ns min), Cache Line Size 10=0A=
	Interrupt: pin A routed to IRQ 209=0A=
	Region 0: Memory at fd000000 (32-bit, non-prefetchable) =
[size=3Dfeac0000]=0A=
	Region 1: I/O ports at b800 [size=3D256]=0A=
	Region 2: Memory at feaff000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Expansion ROM at 00020000 [disabled]=0A=
	Capabilities: [5c] Power Management version 2=0A=
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
03:07.0 RAID bus controller: Promise Technology, Inc. PDC20319 (SATA150 =
TX4) (rev 02)=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 96 (1000ns min, 4500ns max), Cache Line Size 90=0A=
	Interrupt: pin A routed to IRQ 177=0A=
	Region 0: I/O ports at bc00=0A=
	Region 1: I/O ports at b400 [size=3D16]=0A=
	Region 2: I/O ports at b000 [size=3D128]=0A=
	Region 3: Memory at feafe000 (32-bit, non-prefetchable) [size=3D4K]=0A=
	Region 4: Memory at feaa0000 (32-bit, non-prefetchable) [size=3D128K]=0A=
	Capabilities: [60] Power Management version 2=0A=
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=3D0mA =
PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
		Status: D0 PME-Enable- DSel=3D0 DScale=3D0 PME-=0A=
=0A=
03:08.0 Ethernet controller: Intel Corp. 82562EZ 10/100 Ethernet =
Controller (rev 01)=0A=
	Subsystem: Intel Corp.: Unknown device 3428=0A=
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- =
Stepping- SERR+ FastB2B-=0A=
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=3Dmedium >TAbort- =
<TAbort- <MAbort- >SERR- <PERR-=0A=
	Latency: 32 (2000ns min, 14000ns max), Cache Line Size 10=0A=
	Interrupt: pin A routed to IRQ 209=0A=
	Region 0: Memory at feafd000 (32-bit, non-prefetchable)=0A=
	Region 1: I/O ports at ac00 [size=3D64]=0A=
	Capabilities: [dc] Power Management version 2=0A=
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=3D0mA =
PME(D0+,D1+,D2+,D3hot+,D3cold+)=0A=
		Status: D0 PME-Enable+ DSel=3D0 DScale=3D2 PME-=0A=
=0A=

------=_NextPart_000_008C_01C45CE8.70580040
Content-Type: text/plain;
	name="syslog.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="syslog.txt"

Jan 12 21:50:43 localhost kernel: eax: 00000000   ebx: 00000000   ecx: =
00000000   edx: 75f11a00=0A=
Jan 12 21:50:43 localhost kernel: esi: 0000000b   edi: 9cf21491   ebp: =
75f01000   esp: 75ee8f3c=0A=
Jan 12 21:50:43 localhost kernel: ds: 007b   es: 007b   ss: 0068=0A=
Jan 12 21:50:43 localhost kernel: Process nfsd (pid: 2456, =
threadinfo=3D75ee8000 task=3D75ec16b0)=0A=
Jan 12 21:50:43 localhost kernel: Stack: 003ce1f0 0000000b 9cf21491 =
75f01000 82b56b28 75f11a00 75f11a00 82b56a30 =0A=
Jan 12 21:50:43 localhost kernel:        82b6b138 82b6af1c 82b4c5a9 =
15086014 75f11a64 75f11a00 82b6b138 15086014 =0A=
Jan 12 21:50:43 localhost kernel:        82b0e5f1 75f11a00 0000003d =
000000f4 00000190 000186a3 75f11a40 82b6af1c =0A=
Jan 12 21:50:43 localhost kernel: Call Trace:=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56b28>] =
nfs3svc_decode_writeargs+0xf8/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56a30>] =
nfs3svc_decode_writeargs+0x0/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c5a9>] nfsd_dispatch+0x6f/0x162 =
[nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b0e5f1>] svc_process+0x323/0x55f =
[sunrpc]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c3d5>] nfsd+0x1c6/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c20f>] nfsd+0x0/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<021041f1>] =
kernel_thread_helper+0x5/0xb=0A=
Jan 12 21:50:43 localhost kernel: =0A=
Jan 12 21:50:43 localhost kernel: Code: 8b 00 f6 c4 01 75 19 2b 1d 0c d9 =
3f 02 c1 fb 05 c1 e3 0c 8d =0A=
Jan 12 21:50:43 localhost kernel:  <1>Unable to handle kernel NULL =
pointer dereference at virtual address 00000000=0A=
Jan 12 21:50:43 localhost kernel:  printing eip:=0A=
Jan 12 21:50:43 localhost kernel: 0213f951=0A=
Jan 12 21:50:43 localhost kernel: *pde =3D 00003001=0A=
Jan 12 21:50:43 localhost kernel: Oops: 0000 [#126]=0A=
Jan 12 21:50:43 localhost kernel: SMP =0A=
Jan 12 21:50:43 localhost kernel: CPU:    0=0A=
Jan 12 21:50:43 localhost kernel: EIP:    0060:[<0213f951>]    Not =
tainted=0A=
Jan 12 21:50:43 localhost kernel: EFLAGS: 00010202   (2.6.5-1.358smp) =0A=
Jan 12 21:50:43 localhost kernel: EIP is at page_address+0x6/0x77=0A=
Jan 12 21:50:43 localhost kernel: eax: 00000000   ebx: 00000000   ecx: =
00000000   edx: 7e4fb600=0A=
Jan 12 21:50:43 localhost kernel: esi: 0000000b   edi: cc671591   ebp: =
763a9000   esp: 76580f3c=0A=
Jan 12 21:50:43 localhost kernel: ds: 007b   es: 007b   ss: 0068=0A=
Jan 12 21:50:43 localhost kernel: Process nfsd (pid: 2373, =
threadinfo=3D76580000 task=3D812ba030)=0A=
Jan 12 21:50:43 localhost kernel: Stack: 003d5720 0000000b cc671591 =
763a9000 82b56b28 7e4fb600 7e4fb600 82b56a30 =0A=
Jan 12 21:50:43 localhost kernel:        82b6b138 82b6af1c 82b4c5a9 =
70193014 7e4fb664 7e4fb600 82b6b138 70193014 =0A=
Jan 12 21:50:43 localhost kernel:        82b0e5f1 fffffeff 0000003d =
000000f4 00000190 000186a3 7e4fb640 82b6af1c =0A=
Jan 12 21:50:43 localhost kernel: Call Trace:=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56b28>] =
nfs3svc_decode_writeargs+0xf8/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56a30>] =
nfs3svc_decode_writeargs+0x0/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c5a9>] nfsd_dispatch+0x6f/0x162 =
[nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b0e5f1>] svc_process+0x323/0x55f =
[sunrpc]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c3d5>] nfsd+0x1c6/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c20f>] nfsd+0x0/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<021041f1>] =
kernel_thread_helper+0x5/0xb=0A=
Jan 12 21:50:43 localhost kernel: =0A=
Jan 12 21:50:43 localhost kernel: Code: 8b 00 f6 c4 01 75 19 2b 1d 0c d9 =
3f 02 c1 fb 05 c1 e3 0c 8d =0A=
Jan 12 21:50:43 localhost kernel:  <1>Unable to handle kernel NULL =
pointer dereference at virtual address 00000000=0A=
Jan 12 21:50:43 localhost kernel:  printing eip:=0A=
Jan 12 21:50:43 localhost kernel: 0213f951=0A=
Jan 12 21:50:43 localhost kernel: *pde =3D 00003001=0A=
Jan 12 21:50:43 localhost kernel: Oops: 0000 [#127]=0A=
Jan 12 21:50:43 localhost kernel: SMP =0A=
Jan 12 21:50:43 localhost kernel: CPU:    0=0A=
Jan 12 21:50:43 localhost kernel: EIP:    0060:[<0213f951>]    Not =
tainted=0A=
Jan 12 21:50:43 localhost kernel: EFLAGS: 00010202   (2.6.5-1.358smp) =0A=
Jan 12 21:50:43 localhost kernel: EIP is at page_address+0x6/0x77=0A=
Jan 12 21:50:43 localhost kernel: eax: 00000000   ebx: 00000000   ecx: =
00000000   edx: 764df600=0A=
Jan 12 21:50:43 localhost kernel: esi: 0000000b   edi: fcdc1591   ebp: =
76397000   esp: 7633ef3c=0A=
Jan 12 21:50:43 localhost kernel: ds: 007b   es: 007b   ss: 0068=0A=
Jan 12 21:50:43 localhost kernel: Process nfsd (pid: 2378, =
threadinfo=3D7633e000 task=3D80e317b0)=0A=
Jan 12 21:50:43 localhost kernel: Stack: 003dcc50 0000000b fcdc1591 =
76397000 82b56b28 764df600 764df600 82b56a30 =0A=
Jan 12 21:50:43 localhost kernel:        82b6b138 82b6af1c 82b4c5a9 =
6ddbd014 764df664 764df600 82b6b138 6ddbd014 =0A=
Jan 12 21:50:43 localhost kernel:        82b0e5f1 764df600 0000003d =
000000f4 00000190 000186a3 764df640 82b6af1c =0A=
Jan 12 21:50:43 localhost kernel: Call Trace:=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56b28>] =
nfs3svc_decode_writeargs+0xf8/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56a30>] =
nfs3svc_decode_writeargs+0x0/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c5a9>] nfsd_dispatch+0x6f/0x162 =
[nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b0e5f1>] svc_process+0x323/0x55f =
[sunrpc]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c3d5>] nfsd+0x1c6/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c20f>] nfsd+0x0/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<021041f1>] =
kernel_thread_helper+0x5/0xb=0A=
Jan 12 21:50:43 localhost kernel: =0A=
Jan 12 21:50:43 localhost kernel: Code: 8b 00 f6 c4 01 75 19 2b 1d 0c d9 =
3f 02 c1 fb 05 c1 e3 0c 8d =0A=
Jan 12 21:50:43 localhost kernel:  <1>Unable to handle kernel NULL =
pointer dereference at virtual address 00000000=0A=
Jan 12 21:50:43 localhost kernel:  printing eip:=0A=
Jan 12 21:50:43 localhost kernel: 0213f951=0A=
Jan 12 21:50:43 localhost kernel: *pde =3D 00003001=0A=
Jan 12 21:50:43 localhost kernel: Oops: 0000 [#128]=0A=
Jan 12 21:50:43 localhost kernel: SMP =0A=
Jan 12 21:50:43 localhost kernel: CPU:    1=0A=
Jan 12 21:50:43 localhost kernel: EIP:    0060:[<0213f951>]    Not =
tainted=0A=
Jan 12 21:50:43 localhost kernel: EFLAGS: 00010202   (2.6.5-1.358smp) =0A=
Jan 12 21:50:43 localhost kernel: EIP is at page_address+0x6/0x77=0A=
Jan 12 21:50:43 localhost kernel: eax: 00000000   ebx: 00000000   ecx: =
00000000   edx: 764dfc00=0A=
Jan 12 21:50:43 localhost kernel: esi: 0000000b   edi: 94171691   ebp: =
764de000   esp: 76355f3c=0A=
Jan 12 21:50:43 localhost kernel: ds: 007b   es: 007b   ss: 0068=0A=
Jan 12 21:50:43 localhost kernel: Process nfsd (pid: 2375, =
threadinfo=3D76355000 task=3D813ad410)=0A=
Jan 12 21:50:43 localhost kernel: Stack: 003e06e8 0000000b 94171691 =
764de000 82b56b28 764dfc00 764dfc00 82b56a30 =0A=
Jan 12 21:50:43 localhost kernel:        82b6b138 82b6af1c 82b4c5a9 =
0e606014 764dfc64 764dfc00 82b6b138 0e606014 =0A=
Jan 12 21:50:43 localhost kernel:        82b0e5f1 764dfc00 0000003d =
000000f4 00000190 000186a3 764dfc40 82b6af1c =0A=
Jan 12 21:50:43 localhost kernel: Call Trace:=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56b28>] =
nfs3svc_decode_writeargs+0xf8/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b56a30>] =
nfs3svc_decode_writeargs+0x0/0x149 [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c5a9>] nfsd_dispatch+0x6f/0x162 =
[nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b0e5f1>] svc_process+0x323/0x55f =
[sunrpc]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c3d5>] nfsd+0x1c6/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<82b4c20f>] nfsd+0x0/0x32b [nfsd]=0A=
Jan 12 21:50:43 localhost kernel:  [<021041f1>] =
kernel_thread_helper+0x5/0xb=0A=
Jan 12 21:50:43 localhost kernel: =0A=
Jan 12 21:50:43 localhost kernel: Code: 8b 00 f6 c4 01 75 19 2b 1d 0c d9 =
3f 02 c1 fb 05 c1 e3 0c 8d =0A=
Jan 13 04:02:06 localhost logrotate: ALERT exited abnormally with [1]=0A=
Jan 13 04:58:35 localhost sshd(pam_unix)[3168]: session opened for user =
root by (uid=3D0)=0A=

------=_NextPart_000_008C_01C45CE8.70580040--



