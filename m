Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266564AbUGUSDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266564AbUGUSDa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUGUSDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:03:30 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:16509 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S266564AbUGUSDU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:03:20 -0400
Date: Wed, 21 Jul 2004 21:03:04 +0300 (EEST)
From: Pasi Valminen <okun@niksula.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: Remotely triggered kernel panic on PPPoE + IPv6 enabled linux boxes
Message-ID: <Pine.GSO.4.58.0407211955310.4647@kekkonen.cs.hut.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I can trigger a kernel panic from a remote host using tracepath6.
First I connect to the internet using pppoe.

Software:
rp-pppoe version 3.5, no patches
http://www.roaringpenguin.com/penguin/open_source_rp-pppoe.php
ppp version 2.4.2, no PPP packet filtering
ftp://ftp.samba.org/pub/ppp/

Then I configure an IPv6 tunnel to a tunnelbroker. I bring the tunnel up
and use tracepath6 from a remote host to trace some IPv6 address
configured to my net devices and the kernel panics.

# cat /proc/version
Linux version 2.6.7 (root@noc) (gcc version 3.3.3 (CRUX)) #1 SMP Wed Jul
21 14:38:22 UTC 2004

The output of the panic message obtained from a serial console, nothing
ends up in the syslog:

Unable to handle kernel paging request at virtual address edc8df7c
 printing eip:
*pde = 0046b067
*pte = 2dc8d000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: uhci_hcd usbcore ipt_MASQUERADE iptable_nat ip_conntrack ip_d
CPU:    0
EIP:    0060:[<c02c8690>]    Not tainted
EFLAGS: 00010296   (2.6.7)
EIP is at ip6_output2+0x10/0x2c0
eax: edc8df50   ebx: ec50df40   ecx: ede8be20   edx: edc8df50
esi: 00000000   edi: 01000000   ebp: c0422d2c   esp: c0422d0c
ds: 007b   es: 007b   ss: 0068
Process pppoe (pid: 523, threadinfo=c0422000 task=ec6d8a60)
Stack: 00000292 c0465434 00000206 00000000 edc8df50 ec50df40 00000000 01000000
       c0422d98 c02c9d6d ec2a8000 00000286 ec2a8848 ef454b34 3a000400 000004d0
       000004d0 01000000 c026dd54 ec8becf0 00000028 000004d0 ec50df40
ec253f18
Call Trace:
Stack pointer is garbage, not printing trace
Code: 8b 40 2c 8b 58 10 66 c7 42 7c 86 dd 89 5a 18 8b 4d f0 8b 51
 <0>Kernel panic: Fatal exception in interrupt
In interrupt handler - not syncing

The output of the panic message run through ksymoops:
# ./ksymoops -v /usr/src/linux/vmlinux -k /proc/kallsyms < oops > ksymoops.out

ksymoops 2.4.9 on i686 2.6.7.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/kallsyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.7/ (default)
     -m /usr/src/linux/System.map (default)

Warning (read_ksyms): no kernel symbols in ksyms, is /proc/kallsyms a
valid ksyms file?
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel paging request at virtual address edc8df7c
*pde = 0046b067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02c8690>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296   (2.6.7)
eax: edc8df50   ebx: ec50df40   ecx: ede8be20   edx: edc8df50
esi: 00000000   edi: 01000000   ebp: c0422d2c   esp: c0422d0c
ds: 007b   es: 007b   ss: 0068
Stack: 00000292 c0465434 00000206 00000000 edc8df50 ec50df40 00000000 01000000
       c0422d98 c02c9d6d ec2a8000 00000286 ec2a8848 ef454b34 3a000400 000004d0
       000004d0 01000000 c026dd54 ec8becf0 00000028 000004d0 ec50df40 ec253f18
Call Trace:
Code: 8b 40 2c 8b 58 10 66 c7 42 7c 86 dd 89 5a 18 8b 4d f0 8b 51


>>EIP; c02c8690 <ip6_output2+10/2c0>   <=====

>>eax; edc8df50 <__crc_update_region+175f7a/2e64c7>
>>ebx; ec50df40 <__crc_proc_root+11c3bc/23c634>
>>ecx; ede8be20 <__crc_rtc_unregister+8d983/236a6b>
>>edx; edc8df50 <__crc_update_region+175f7a/2e64c7>
>>edi; 01000000 <__crc_class_device_get+6f7b6/e53a6>
>>ebp; c0422d2c <softirq_stack+d2c/2000>
>>esp; c0422d0c <softirq_stack+d0c/2000>

Code;  c02c8690 <ip6_output2+10/2c0>
00000000 <_EIP>:
Code;  c02c8690 <ip6_output2+10/2c0>   <=====
   0:   8b 40 2c                  mov    0x2c(%eax),%eax   <=====
Code;  c02c8693 <ip6_output2+13/2c0>
   3:   8b 58 10                  mov    0x10(%eax),%ebx
Code;  c02c8696 <ip6_output2+16/2c0>
   6:   66 c7 42 7c 86 dd         movw   $0xdd86,0x7c(%edx)
Code;  c02c869c <ip6_output2+1c/2c0>
   c:   89 5a 18                  mov    %ebx,0x18(%edx)
Code;  c02c869f <ip6_output2+1f/2c0>
   f:   8b 4d f0                  mov    0xfffffff0(%ebp),%ecx
Code;  c02c86a2 <ip6_output2+22/2c0>
  12:   8b 51 00                  mov    0x0(%ecx),%edx

 <0>Kernel panic: Fatal exception in interrupt

1 warning issued.  Results may not be reliable.

My net setup follows... The IP addresses has been obfuscated because I
need my box online and suspect that some malicious people might want to
crash it. :( If you think you need the real addresses, email me.

/sbin/modprobe 3c59x

/sbin/ifconfig lo 127.0.0.1

/usr/sbin/adsl-start # rp-pppoe script
/usr/sbin/ip tunnel add sit1 mode sit remote 1.2.3.4 local \
        `/usr/sbin/ip -o addr show dev ppp0 | /usr/bin/tail -n 1 | \
         /bin/sed -e "s:\(.*\) inet \(.*\) peer \(.*\):\2:"` \
        ttl 64 dev ppp0
# Setting MTU any lower fails with SIOCSIFMTU: Invalid argument :(
/usr/sbin/ip link set sit1 mtu 1280
/usr/sbin/ip link set sit1 up
/usr/sbin/ip -6 addr add 1::2/64 dev sit1 # Tunnel endpoint IPv6
/usr/sbin/ip -6 route add 2000::/3 dev sit1
# This enables the tunnel from the PoP side
/sbin/heartbeat-client /etc/heartbeat/heartbeat.conf
/usr/sbin/ip -6 addr add 2::3/48 dev sit1 # Additional IPv6
/usr/sbin/ip -6 addr add 3::4/48 dev sit1 # Additional IPv6

/usr/sbin/ip addr add 10.0.0.1/24 broadcast 10.0.0.255 dev eth1
/usr/sbin/ip -6 addr add 4::5/64 dev eth1
/usr/sbin/ip link set eth1 up

/bin/echo 1 > /proc/sys/net/ipv4/ip_forward
/usr/sbin/iptables -t nat -A POSTROUTING --proto ! 41 -o ppp0 -j MASQUERADE

After these steps I only need tracepath6 to crash the box from a remote
box.

$ tracepath6 4::5 # (IPv6 address obfuscated) crashes the box

System environment (same kernel, after the panic)

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 598.145
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips        : 1179.64

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 598.145
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 mmx fxsr sse
bogomips        : 1191.93

# cat /proc/modules
uhci_hcd 33616 0 - Live 0xf0970000
usbcore 118176 3 uhci_hcd, Live 0xf0952000
ipt_MASQUERADE 4576 1 - Live 0xf0998000
iptable_nat 24676 2 ipt_MASQUERADE, Live 0xf0931000
ip_conntrack 37040 2 ipt_MASQUERADE,iptable_nat, Live 0xf0a3a000
ip_tables 19008 2 ipt_MASQUERADE,iptable_nat, Live 0xf0894000
ppp_synctty 10400 0 - Live 0xf0890000
ppp_async 13568 1 - Live 0xf088b000
ppp_generic 31124 6 ppp_synctty,ppp_async, Live 0xf0882000
slhc 7392 1 ppp_generic, Live 0xf0870000
3c59x 40040 0 - Live 0xf0877000
aes 31712 2 - Live 0xf089d000
rd 6848 0 - Live 0xf0865000

# cat /proc/ioports
0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0800-083f : 0000:00:07.3
0840-085f : 0000:00:07.3
0cf8-0cff : PCI conf1
cc00-cc7f : 0000:00:0e.0
  cc00-cc7f : 0000:00:0e.0
cce0-ccff : 0000:00:07.2
  cce0-ccff : uhci_hcd
d000-dfff : PCI Bus #02
  dc80-dcff : 0000:02:09.0
    dc80-dcff : 0000:02:09.0
e000-efff : PCI Bus #01
  ec00-ecff : 0000:01:00.0
ffa0-ffaf : 0000:00:07.1
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Adapter ROM
000cc000-000cc7ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-2fffdfff : System RAM
  00100000-002f88c6 : Kernel code
  002f88c7-003f529f : Kernel data
2fffe000-2fffffff : reserved
f0000000-f3ffffff : 0000:00:00.0
f5000000-f5ffffff : PCI Bus #02
f6000000-f6ffffff : PCI Bus #01
f9000000-faffffff : PCI Bus #02
  f9fffc00-f9fffc7f : 0000:02:09.0
fb000000-fdffffff : PCI Bus #01
  fbfff000-fbffffff : 0000:01:00.0
  fc000000-fcffffff : 0000:01:00.0
fe000000-fe00007f : 0000:00:0e.0
fec00000-fec0ffff : reserved
fee00000-fee0ffff : reserved
fff80000-ffffffff : reserved

The kernel config, the output of dmesg before the panic, and the output of
lspci -vvv are available here:
http://www.niksula.cs.hut.fi/~okun/{config,dmesg,lspci}

If you need additional information try something out or have a fix, please
email me. I'm not a subscriber of the lkml so I would appreciate CC.
Thanks.
