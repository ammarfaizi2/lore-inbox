Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966146AbWKTQuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966146AbWKTQuO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966135AbWKTQuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:50:14 -0500
Received: from mail.dys1.com ([213.56.82.114]:64689 "EHLO delphes.dys1.net")
	by vger.kernel.org with ESMTP id S966146AbWKTQuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:50:11 -0500
Message-ID: <4561DCB3.9020706@plessis.info>
Date: Mon, 20 Nov 2006 17:49:55 +0100
From: Benoit Plessis <benoit@plessis.info>
Reply-To: benoit@plessis.info
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange network routing behaviour when routing locally generated
 packets
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

Strange network routing behaviour when routing locally generated packets

[2.] Full description of the problem/report:

I  encountered two linked weird behavior of the network paquet routing 
process
when used in conjonction with iptables' MARK-ing capabilities.

First it's impossible for a local process to send packets to a 
destination that is not
available appart from a routing table selected by a 'ip rule add fwmark'.
ping process reply 'Network Unreachable' for example.

I must say that all does not occur when routing packet generated from 
another computer.

And second, which is somehow related, if there is an available route 
entry for a destination
that will be MARK'ed by iptables and then routed using a special routing 
table the
source ip address for the packet will be the source generated from the 
first route entry
even if the second entry specify another output device and source ip.


[3.] Keywords (i.e., modules, networking, kernel):

networking, advenced routing, iptables, local process

[4.] Kernel version (from /proc/version):
Linux version 2.4.27-3-686-smp (pbuilder@dl360-g3) (gcc version 3.3.5 
(Debian 1:3.3.5-13)) #1 SMP Thu Sep 14 07:44:00 UTC 2006
Linux version 2.6.17-2-686 (Debian 2.6.17-9) (waldi@debian.org) (gcc 
version 4.1.2 20060901 (prerelease) (Debian 4.1.1-13)) #1 SMP Wed Sep 13 
16:34:10 UTC 2006

[5.] Most recent kernel version which did not have the bug:
none known
[6.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)
[7.] A small shell script or example program which triggers the
     problem (if possible)

# ip route show table 200
192.168.2.0/24 via 192.168.1.65 dev eth0 src 192.168.1.1
0:      from all lookup local
32765:  from all fwmark 0x1 lookup 200
32766:  from all lookup main
32767:  from all lookup default

# ip route show
172.31.254.0/28 dev eth1  proto kernel  scope link  src 172.31.254.2
192.168.1.0/24 dev eth0  proto kernel  scope link  src 192.168.1.1
172.24.16.0/21 dev eth0  proto kernel  scope link  src 172.24.16.1

# iptables -t mangle -A OUTPUT --dest 192.168.2.0/24 -j MARK --set-mark 1

# ping 192.168.2.65
connect: Network is unreachable

# ip route add default via 172.31.254.1 dev eth1
# ping 192.168.2.65
PING 192.168.2.65 (192.168.2.65) 56(84) bytes of data.

--- 192.168.2.65 ping statistics ---
1 packets transmitted, 0 received, 100% packet loss, time 0ms

at this point using a tcpdump icmp on host 192.168.1.65 show the following:

17:19:10.409085 IP 172.31.254.2 > 192.168.2.65: ICMP echo request, id 
18957, seq 1, length 64

in other term the packet was correctly send to the wanted gateway but 
using wrong
source ip address ( ip address derived from the default rule)

[8.] Environment
[8.1.] Software (add the output of the ver_linux script here)

Linux fw1-bzr-lt1 2.6.17-2-686 #1 SMP Wed Sep 13 16:34:10 UTC 2006 i686 
GNU/Linux
 
Gnu C                  18:
/root/ver_linux: line 24: ld: command not found
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.97
udev                   100
Modules Loaded         iptable_nat ip_nat ip_conntrack nfnetlink 
xt_tcpudp iptable_mangle xt_MARK iptable_filter ip_tables x_tables tun 
ipv6 deflate zlib_deflate twofish serpent aes blowfish des sha256 sha1 
crypto_null af_key dm_snapshot dm_mirror dm_mod mousedev usbkbd usbcore 
intel_agp agpgart psmouse sg i2c_i801 i82875p_edac edac_mc i2c_core 
serio_raw shpchp pci_hotplug evdev sr_mod 8250_pnp cdrom rtc floppy 
pcspkr ext3 jbd mbcache sd_mod ata_piix libata scsi_mod generic ide_core 
e1000 thermal processor fan

[8.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 3
model name      : Intel(R) Pentium(R) 4 CPU 2.80GHz
stepping        : 4
cpu MHz         : 2800.697
cache size      : 1024 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
constant_tsc up pni monitor ds_cpl cid xtpr
bogomips        : 5606.20

[8.3.] Module information (from /proc/modules):
iptable_nat 6980 0 - Live 0xf0bf5000
ip_nat 16748 1 iptable_nat, Live 0xf0bef000
ip_conntrack 48320 2 iptable_nat,ip_nat, Live 0xf0bf9000
nfnetlink 6552 2 ip_nat,ip_conntrack, Live 0xf0ba4000
xt_tcpudp 3104 1 - Live 0xf0be1000
iptable_mangle 2848 1 - Live 0xf0bdf000
xt_MARK 2432 2 - Live 0xf0ba9000
iptable_filter 3072 0 - Live 0xf0ba7000
ip_tables 12932 3 iptable_nat,iptable_mangle,iptable_filter, Live 0xf0bda000
x_tables 13252 4 iptable_nat,xt_tcpudp,xt_MARK,ip_tables, Live 0xf0bc9000
tun 10208 1 - Live 0xf0bc5000
ipv6 222304 26 - Live 0xf0c1d000
deflate 3808 0 - Live 0xf09c4000
zlib_deflate 18552 1 deflate, Live 0xf0bbf000
twofish 42880 0 - Live 0xf0bce000
serpent 19232 0 - Live 0xf0bb9000
aes 28160 0 - Live 0xf0bb1000
blowfish 9312 0 - Live 0xf0b7a000
des 17376 0 - Live 0xf0bab000
sha256 11040 0 - Live 0xf0b66000
sha1 2624 0 - Live 0xf09c6000
crypto_null 2624 0 - Live 0xf08be000
af_key 31568 2 - Live 0xf0b9b000
dm_snapshot 16032 0 - Live 0xf0b5c000
dm_mirror 18928 0 - Live 0xf097d000
dm_mod 50424 2 dm_snapshot,dm_mirror, Live 0xf0b6c000
mousedev 10788 0 - Live 0xf09c0000
usbkbd 6784 0 - Live 0xf0814000
usbcore 111616 1 usbkbd, Live 0xf0b7e000
intel_agp 21116 0 - Live 0xf09d3000
agpgart 29864 1 intel_agp, Live 0xf09ca000
psmouse 34600 0 - Live 0xf09ac000
sg 30972 0 - Live 0xf09b7000
i2c_i801 8236 0 - Live 0xf09a8000
i82875p_edac 6244 0 - Live 0xf087d000
edac_mc 12964 1 i82875p_edac, Live 0xf0983000
i2c_core 19552 1 i2c_i801, Live 0xf083c000
serio_raw 6596 0 - Live 0xf084c000
shpchp 34272 0 - Live 0xf0961000
pci_hotplug 27196 1 shpchp, Live 0xf0975000
evdev 9088 0 - Live 0xf0879000
sr_mod 15876 0 - Live 0xf0847000
8250_pnp 8704 0 - Live 0xf0834000
cdrom 32448 1 sr_mod, Live 0xf096c000
rtc 12340 0 - Live 0xf0842000
floppy 54276 0 - Live 0xf08ef000
pcspkr 3040 0 - Live 0xf0802000
ext3 118568 7 - Live 0xf0921000
jbd 50292 1 ext3, Live 0xf08e1000
mbcache 8324 1 ext3, Live 0xf0838000
sd_mod 18592 9 - Live 0xf081d000
ata_piix 11556 8 - Live 0xf0830000
libata 61420 1 ata_piix, Live 0xf0869000
scsi_mod 123080 4 sg,sr_mod,sd_mod,libata, Live 0xf0988000
generic 4420 0 [permanent], Live 0xf081a000
ide_core 111016 1 generic, Live 0xf08a1000
e1000 100248 0 - Live 0xf084f000
thermal 12904 0 - Live 0xf082b000
processor 25512 1 thermal, Live 0xf0823000
fan 4516 0 - Live 0xf0817000

[8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
[8.5.] PCI information ('lspci -vvv' as root)
[8.6.] SCSI information (from /proc/scsi/scsi)
[8.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
All this has been tested on a bunch of distro/kernels with allways the 
same result.

Regardsn

