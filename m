Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263233AbSJFCgL>; Sat, 5 Oct 2002 22:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263192AbSJFCgL>; Sat, 5 Oct 2002 22:36:11 -0400
Received: from derive.ecn.ulaval.ca ([132.203.59.17]:23683 "EHLO condorito.org")
	by vger.kernel.org with ESMTP id <S263233AbSJFCgH>;
	Sat, 5 Oct 2002 22:36:07 -0400
Date: Sat, 5 Oct 2002 22:43:59 +0500 (GMT)
From: Nicolas Beaulieu <gulliver@condorito.org>
Reply-To: Nicolas Beaulieu <gulliver@condorito.org>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.19, Tyan Tiger, Dual Athlon, diskless nodes, rootnfs and fsck.ext2
 problems
Message-ID: <Pine.GSO.4.10.10210052241280.2804-100000@condorito.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I've been browsing the lists for 1 week now but I cannot manage to get rid of my problem.  
I have posted this message to the nfs mailing list too, just in case they
could help me...

I have a Beowulf cluster running RH 7.2 on ext3 filesystem: 1 master with Mylex AcceleRaid 
170 and 4 Quantum Ultra SCSI 10,000 RPM, exporting NFS partitions for 12 diskless nodes 
booting with PXE/Etherboot/tftp images and a simple Intel Ether Express Pro NIC.  The master and 
the nodes all have a Tyan Tiger MP motherboard (Tiger MP S2460 with AMD 760 chipset) and Dual 
Athlon 1800 MP with, among other things, a 3COM 3C996B-T Gigabit NIC. 

They have been running vanilla 2.4.18 for the past 4 months with the bcm5700 driver, and with
RH's 2.4.9-** a couple of months before. The bcm5700 driver, it seems, produces some kernel oops 
and hangs the machine.  I then need to reboot everything.  This is the same hardware/problem 
discussed in an earlier thread on the kernel list and many others.(See, for instance, 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.0/0069.html)  But these hardware issues 
solely deserve another post :-)


Now I want to upgrade the whole system to 2.4.19 to use the Tigon tg3 driver included. I 
use the same kernel config than vanilla 2.4.18's for both the master (with SCSI support and so on)
and the nodes (almost nothing).  The master works great with 2.4.19 and tg3 support compiled as module 
or into the kernel. It's been working like a champ since 3 weeks now without any problem.  However, 
the nodes cannot go further than the nfsroot mounting stage.  A node is able to get its IP address 
through PXE, uncompress its image, and then complains about ext2 fs issues:


******************

Checking root filesystem

fsck.ext2: Is a directory while trying to open / 
/:

The superblock could not be read or does not describe a correct ext2
filesystem.  If the device is valid and it really contains an ext2
filesystem (and not a swap or ufs or something else), then the superblock
is corrupt, and you might try running e2fsck with an alternate superblock:
   e2fsck -b 8193 <device>

******************

...and the it drops me to a shell to make a fsck on the nfsroot.


Well, I'm no kernel hacker, nor a linux expert, but how can it be possible?  I can boot 
any nodes successfully with vanilla 2.4.18, I can't with 2.4.19, switch it back to 2.4.18 
and it works ?

Am I missing something here ? The exact same setup and kernel configs work great with
RH's 2.4.9 and vanilla 2.4.18, but not with 2.4.19 &+ ??!! I even tried with 2.4.10 and 
2.4.14 this morning, work great too.  2.5.40 does the same error message though. Also,
RH's 2.4.18-3 produces the same error. It doesn't even work if I try to compile it without 
any gigabit support. So I'm not 100% sure if it's hardware/BIOS related or if it's some new 
feature or bug in 2.4.19 NFS' support...

I upgraded to nfs-utils-1.0.1, e2fsprogs-1.29, mknbi-1.2-9.

Any hints or suggestions?


The remaining part of this message gives some config files and logs from my system. You can
find complete dmesg, lspci, kernel config and rpcinfo files from both the master and the nodes 
at:

http://frisch.ecn.ulaval.ca/nfs



1) diskless node boots kernel (PXE / Etherboot) and mounts its rootnfs partition / as 
specified by mknbi-linux through 10/100 NIC (eepro100):

eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corp. 82557 [Ethernet Pro 100], 00:02:B3:87:F5:03, IRQ 11.
  Board assembly 751767-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
    Secondary interface chip i82555.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x3258698e).


2) master is running dhcpd and tftpd, assigns IP address and kernel image to diskless nodes: 


2.a) node's kernel image is created with standard bzImage and then with mknbi-linux:

cp /usr/src/linux/arch/i386/boot/bzImage /home/tftpboot/vmlinuz-2.4.19-node

mknbi-linux --rootdir='/home/rootdir/%s' --ip=rom 
   --output=/home/tftpboot/vmlinuz-2.4.19-node-nbi /home/tftpboot/vmlinuz-2.4.19-node


2.b) master's dhcpd.conf:

[...]

group {
	default-lease-time 600000;
	max-lease-time 720000;
	option subnet-mask 255.255.255.0;
	option broadcast-address 192.168.0.255;
	option routers 192.168.0.1;
	option domain-name-servers aaa.bbb.ccc.ddd, aaa.bbb.ccc.eee;

	if substring (option vendor-class-identifier, 0, 9) = "PXEClient" { 
		filename "eb-5.0.5-eepro100.lzpxe";
		}
	else if substring (option vendor-class-identifier, 0, 9) = "Etherboot" {   
#		filename  "vmlinuz-2.4.18-node-nbi";
		filename  "vmlinuz-2.4.19-node-nbi";
#		filename  "vmlinuz-2.5.40-node-nbi";
		}

[...]

        host node5 {
                hardware ethernet 00:02:B3:87:F5:3a;
                fixed-address 192.168.0.55;
                option host-name "node5";
                }
[...]
	}

group {
        default-lease-time 600000;
        max-lease-time 720000;
	option routers 0.0.0.0;
        option subnet-mask 255.255.255.0;
	option domain-name-servers aaa.bbb.ccc.ddd, aaa.bbb.ccc.eee;

[...]
        host node5hs {
                hardware ethernet 00:04:76:dd:2d:3a;
                fixed-address 192.168.1.55;
                option host-name "node5hs";
                }
[...]
	}




3) node then receives IP address for its 3COM 3C996B Gigabit NIC (bcm5700) by dhcpd (see above):

Broadcom Gigabit Ethernet Driver bcm5700 with Broadcom NIC Extension (NICE) ver. 2.0.28 (11/05/01)
eth1: 3Com 3C996B Gigabit Server NIC found at mem fa000000, IRQ 5, node addr 000476dd2d37
eth1: Broadcom BCM5701 Integrated Copper transceiver found
eth1: Scatter-gather ON, 64-bit DMA ON, Tx Checksum ON, Rx Checksum ON
bcm5700: eth1 NIC Link is UP, 1000 Mbps full duplex
bcm5700: eth1 NIC Link is Down
bcm5700: eth1 NIC Link is Up, 1000 Mbps full duplex


4) diskless node mounts data partitions through NFS:

fstab:
/dev/ram1	        /proc			proc    defaults	0 0
192.168.0.1:/home/rhs	/home/rhs		nfs     defaults	0 0
192.168.0.1:/home/share	/home/share		nfs	defaults	0 0
192.168.0.1:/root	/root			nfs	defaults        0 0
192.168.0.1:/home/users	/home/users		nfs	defaults	0 0
192.168.0.1:/opt	/opt			nfs     defaults	0 0


5) master's messages if the node boots kernel 2.4.9 to 2.4.18:

Oct  5 07:17:24 master dhcpd: DHCPDISCOVER from 00:02:b3:87:f5:3a via eth1
Oct  5 07:17:24 master dhcpd: DHCPOFFER on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 07:17:25 master dhcpd: DHCPREQUEST for 192.168.0.55 (192.168.0.1) from 00:02:b3:87:f5:3a via eth1
Oct  5 07:17:25 master dhcpd: DHCPACK on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 11:17:25 master in.tftpd[12874]: tftp: client does not accept options 
Oct  5 07:17:28 master dhcpd: DHCPDISCOVER from 00:02:b3:87:f5:3a via eth1
Oct  5 07:17:28 master dhcpd: DHCPOFFER on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 07:17:28 master dhcpd: DHCPREQUEST for 192.168.0.55 (192.168.0.1) from 00:02:b3:87:f5:3a via eth1
Oct  5 07:17:28 master dhcpd: DHCPACK on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 07:17:31 master rpc.mountd: authenticated mount request from node5:800 for /home/rootdir/node5 (/home/rootdir/node5) 
Oct  5 07:18:01 master dhcpd: DHCPREQUEST for 192.168.1.55 from 00:04:76:dd:2d:3a via eth0
Oct  5 07:18:01 master dhcpd: DHCPACK on 192.168.1.55 to 00:04:76:dd:2d:3a via eth0
Oct  5 07:18:18 master rpc.mountd: authenticated mount request from node5:743 for /home/rhs (/home/rhs) 
Oct  5 07:18:18 master rpc.mountd: authenticated mount request from node5:747 for /home/share (/home/share) 
Oct  5 07:18:18 master rpc.mountd: authenticated mount request from node5:751 for /root (/root) 
Oct  5 07:18:18 master rpc.mountd: authenticated mount request from node5:755 for /home/users (/home/users) 
Oct  5 07:18:18 master rpc.mountd: authenticated mount request from node5:759 for /opt (/opt) 


6) from node's dmesg:
Kernel command line: rw root=/dev/nfs nfsroot=/home/rootdir/%s ip=192.168.0.55:192.168.0.1:192.168.0.1:255.255.255.0:node5
[...]
IP-Config: Complete:
      device=eth0, addr=192.168.0.56, mask=255.255.255.0, gw=192.168.0.1,
     host=node6, domain=, nis-domain=(none),
     bootserver=192.168.0.1, rootserver=192.168.0.1, rootpath=
[...]
VFS: Mounted root (nfs filesystem).
[...]



7) Now, master's messages if the node boots kernel 2.4.19:

Oct  5 07:32:53 master rpc.mountd: authenticated unmount request from node5:993 for /opt (/opt) 
Oct  5 07:32:53 master rpc.mountd: authenticated unmount request from node5:995 for /home/users (/home/users) 
Oct  5 07:32:53 master rpc.mountd: authenticated unmount request from node5:997 for /root (/root) 
Oct  5 07:32:53 master rpc.mountd: authenticated unmount request from node5:999 for /home/share (/home/share) 
Oct  5 07:32:53 master rpc.mountd: authenticated unmount request from node5:1001 for /home/rhs (/home/rhs) 
Oct  5 07:33:20 master dhcpd: DHCPDISCOVER from 00:02:b3:87:f5:3a via eth1
Oct  5 07:33:20 master dhcpd: DHCPOFFER on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 07:33:21 master dhcpd: DHCPREQUEST for 192.168.0.55 (192.168.0.1) from 00:02:b3:87:f5:3a via eth1
Oct  5 07:33:21 master dhcpd: DHCPACK on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 11:33:21 master in.tftpd[12897]: tftp: client does not accept options 
Oct  5 07:33:24 master dhcpd: DHCPDISCOVER from 00:02:b3:87:f5:3a via eth1
Oct  5 07:33:24 master dhcpd: DHCPOFFER on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 07:33:24 master dhcpd: DHCPREQUEST for 192.168.0.55 (192.168.0.1) from 00:02:b3:87:f5:3a via eth1
Oct  5 07:33:24 master dhcpd: DHCPACK on 192.168.0.55 to 00:02:b3:87:f5:3a via eth1
Oct  5 07:33:28 master rpc.mountd: authenticated mount request from node5:800 for /home/rootdir/node5 (/home/rootdir/node5)

and it stops there, with the above error message at console.



8) I can ping the node correctly on the 10/100 NIC...

[root@master etc]# ping node5
PING node5 (192.168.0.55) from 192.168.0.1 : 56(84) bytes of data.
64 bytes from node5 (192.168.0.55): icmp_seq=0 ttl=64 time=231 usec
64 bytes from node5 (192.168.0.55): icmp_seq=1 ttl=64 time=146 usec
64 bytes from node5 (192.168.0.55): icmp_seq=2 ttl=64 time=142 usec
64 bytes from node5 (192.168.0.55): icmp_seq=3 ttl=64 time=125 usec

--- node5 ping statistics ---
4 packets transmitted, 4 packets received, 0% packet loss
round-trip min/avg/max/mdev = 0.125/0.161/0.231/0.041 ms

....but not on the Gigabit NIC:

[root@master etc]# ping node5hs
PING node5hs (192.168.1.55) from 192.168.1.1 : 56(84) bytes of data.
>From masterhs (192.168.1.1): Destination Host Unreachable
>From masterhs (192.168.1.1): Destination Host Unreachable
>From masterhs (192.168.1.1): Destination Host Unreachable

--- node5hs ping statistics ---
4 packets transmitted, 0 packets received, +3 errors, 100% packet loss




I hope this will be enough.  If not, tell me what you need.


Thanks for any help you could provide.







