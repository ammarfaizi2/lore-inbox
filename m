Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUGXVFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUGXVFm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 17:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUGXVFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 17:05:42 -0400
Received: from ns1.landhost.net ([66.98.188.87]:3472 "EHLO secure.landhost.net")
	by vger.kernel.org with ESMTP id S262391AbUGXVFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 17:05:33 -0400
Message-ID: <4102CF17.2010207@marcansoft.com>
Date: Sat, 24 Jul 2004 23:05:27 +0200
From: =?ISO-8859-1?Q?H=E9ctor_Mart=EDn?= <hector@marcansoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; es-ES; rv:1.6) Gecko/20040409
X-Accept-Language: es-es, es, en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: ksoftirqd uses 99% CPU triggered by network traffic
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - secure.landhost.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - marcansoft.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running a home PC here, which is acting as a router/firewall too. 
When I get a
specific network traffic type (detailed below) ksoftirqd/0 starts using 
all CPU
time. Network processes also use an extremely high amount of CPU time 
when this
happens. I/O is extremely jerky and assuming control over the console 
(being in X)
is next to impossible without resorting to SysRq (a million thanks to 
whomever
invented it :)). Always reproducible after some minutes of this traffic.

Machine is an Athlon XP 1800+, ASUS A7V266-E mobo (VIA chipset), PCI 
hardware is:
2x Realtek 8139 (10/100Mbps) (eth1/eth2) (LAN,
1x Realtek 8029 (10Mbps) (eth0) (Internet)
NVIDIA GeForce4 graphics
Bt878 capture card

The specific traffic is incoming small UDP packets to eth2. They're 
debug/logging
message packets and thus very small, here is a partial tcpdump:
19:45:45.541426 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 9
19:45:45.599200 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 14
19:45:45.601448 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 16
19:45:45.602398 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 9
19:45:45.659519 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 14
19:45:45.661014 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 73
19:45:45.663313 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 16
19:45:45.664313 IP 192.168.1.21.18194 > 192.168.1.20.18194: UDP, length: 9

These should (and do) stop at this PC, i.e. they're not forwarded 
(192.168.1.20 is the eth2's IP)

Network usage is, according to iptraf (possibly traffic is much higher 
than what the
dump above would suggest due to the Ethernet/ip/udp headers adding up),
Total rates:         32.8 kbits/sec        Broadcast packets:            0
                     64.0 packets/sec      Broadcast bytes:              0

Incoming rates:      32.8 kbits/sec
                     64.0 packets/sec
                                           IP checksum errors:           0
Outgoing rates:       0.0 kbits/sec
                      0.0 packets/sec

I rebooted with profile=1 and then reproduced the problem. Then I killed 
all (user)
processes and used Secure Access with SysRq to login as root and start 
xinetd
(network still works, although very jerky too) and telnet'ed from a 
remote machine
to get information.

using readprofile -r followed by readprofile 20 secs after gives (top 30 
sorted)
     1 fast_copy_page                             0,0039
     1 finish_task_switch                         0,0069
     1 i8042_interrupt                            0,0028
     1 inet_sendmsg                               0,0104
     1 kmem_cache_free                            0,0125
     1 link_path_walk                             0,0004
     1 remove_vm_struct                           0,0063
     1 run_timer_softirq                          0,0023
     2 acpi_os_acquire_lock                       0,1053
     2 acpi_os_release_lock                       0,0645
     2 preempt_schedule                           0,0250
     6 write_profile                              0,0938
     8 acpi_ev_sci_xrupt_handler                  0,3333
    10 acpi_os_write_port                         0,1852
    11 acpi_irq                                   0,5000
    11 __copy_to_user_ll                          0,0982
    13 net_rx_action                              0,0542
    16 acpi_hw_low_level_write                    0,1019
    20 acpi_ev_fixed_event_detect                 0,2151
    31 usb_hcd_irq                                0,2768
    34 acpi_ev_gpe_detect                         0,1185
    65 acpi_hw_register_read                      0,1929
    89 acpi_hw_low_level_read                     0,5563
   602 rtl8139_rx                                 0,8005
  2409 uhci_irq                                   5,0187
  2420 rtl8139_poll                              10,8036
  2717 acpi_os_read_port                         38,8143
  3292 rtl8139_interrupt                          8,5729
  8677 handle_IRQ_event                          77,4732
 20450 total                                      0,0065


3 snapshots of /proc/interrupts spaced 5 secs:
           CPU0
  0:    7699123          XT-PIC  timer
  1:       2319          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        102          XT-PIC  eth1
  8:          2          XT-PIC  rtc
  9:  151270086          XT-PIC  acpi, uhci_hcd, uhci_hcd, uhci_hcd, eth2
 10:     254469          XT-PIC  CMI8738-MC6, eth0
 11:     438415          XT-PIC  bttv0
 12:     105857          XT-PIC  i8042
 14:      44582          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0
LOC:    7698825
ERR:     297829

           CPU0
  0:    7704263          XT-PIC  timer
  1:       2319          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        102          XT-PIC  eth1
  8:          2          XT-PIC  rtc
  9:  151584417          XT-PIC  acpi, uhci_hcd, uhci_hcd, uhci_hcd, eth2
 10:     254481          XT-PIC  CMI8738-MC6, eth0
 11:     438415          XT-PIC  bttv0
 12:     105857          XT-PIC  i8042
 14:      44590          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0
LOC:    7703965
ERR:     298502

           CPU0
  0:    7709403          XT-PIC  timer
  1:       2319          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:        102          XT-PIC  eth1
  8:          2          XT-PIC  rtc
  9:  151898751          XT-PIC  acpi, uhci_hcd, uhci_hcd, uhci_hcd, eth2
 10:     254483          XT-PIC  CMI8738-MC6, eth0
 11:     438415          XT-PIC  bttv0
 12:     105857          XT-PIC  i8042
 14:      44598          XT-PIC  ide0
 15:         21          XT-PIC  ide1
NMI:          0
LOC:    7709105
ERR:     299141

Interrupt 9 is surely busy, no USB hardware plugged in just in case you're
wondering, and normally (while not using eth2) interrupt 9 is rock solid
(i.e. I doubt ACPI interrupts at all during normal use unless e.g. the power
button is pressed.)

And finally, top tells me (in.telnetd uses a lot of cpu time because I was
accessing this through telnet, any other process using the network would 
have
the same problem once ksoftirqd goes nuts):

top - 19:00:43 up  2:11,  3 users,  load average: 1.41, 1.42, 1.91
Tasks:  29 total,   2 running,  27 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.0% us,  0.0% sy,  0.0% ni,  0.0% id,  0.0% wa, 76.5% hi, 23.5% si
Mem:    251344k total,    82388k used,   168956k free,     6436k buffers
Swap:  1469908k total,       84k used,  1469824k free,    49244k cached

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
    2 root      39  19     0    0    0 R 60.7  0.0  29:22.86 ksoftirqd/0
11285 root      16   0  1844  808 1620 S 28.1  0.3   3:24.98 in.telnetd
11380 root      17   0  1952  968 1736 R  8.7  0.4   0:01.83 top
    1 root      15   0  1344  424 1188 S  0.0  0.2   0:01.82 init
    3 root       5 -10     0    0    0 S  0.0  0.0   0:29.87 events/0
    4 root       5 -10     0    0    0 S  0.0  0.0   0:00.00 khelper
    5 root      14 -10     0    0    0 S  0.0  0.0   0:00.00 kacpid
   22 root       5 -10     0    0    0 S  0.0  0.0   0:00.12 kblockd/0
   23 root      15   0     0    0    0 S  0.0  0.0   0:00.00 khubd
   35 root      15   0     0    0    0 S  0.0  0.0   0:03.32 pdflush
   36 root      15   0     0    0    0 S  0.0  0.0   0:01.19 pdflush
   38 root       6 -10     0    0    0 S  0.0  0.0   0:00.00 aio/0
   37 root      16   0     0    0    0 S  0.0  0.0   0:03.88 kswapd0
   43 root      25   0     0    0    0 S  0.0  0.0   0:00.00 kseriod
  195 root       5 -10     0    0    0 S  0.0  0.0   0:00.43 reiserfs/0
10972 root      25   0  2160 1000 1728 S  0.0  0.4   0:05.61 login
10973 root      17   0  1380  572 1208 S  0.0  0.2   0:00.09 agetty
10974 root      16   0  1380  572 1208 S  0.0  0.2   0:00.11 agetty
10979 root      16   0  1380  572 1208 S  0.0  0.2   0:00.07 agetty
11000 root       5 -10  1316  332 1164 S  0.0  0.1   0:00.17 udevd
11063 root      16   0  1380  572 1208 S  0.0  0.2   0:00.09 agetty
11064 root      16   0  1380  572 1208 S  0.0  0.2   0:00.07 agetty
11141 root      17   0  4536 1500 4332 S  0.0  0.6   0:06.19 bash
11282 root      18   0  2008  924 1672 S  0.0  0.4   0:04.39 xinetd
11286 root      20   0  2160 1152 1728 S  0.0  0.5   0:01.43 login
11287 marcanso  16   0  4796 1468 4332 S  0.0  0.6   0:00.35 bash
11293 root      18   0  2112  948 1664 S  0.0  0.4   0:00.39 su
11294 root      17   0  4540 1496 4332 S  0.0  0.6   0:03.79 bash
11381 root      15   0  3580  396 3424 S  0.0  0.2   0:00.29 cat

Normally, ksoftirqd gets exactly 0 seconds of CPU time, so surely something
is wrong here :)

I think ACPI may be using up cycles because it is on the same interrupt and
thus gets triggered too, I doubt it has anything to do with ACPI.

Maybe some hardware bug that causes it to generate too many interrupts? It's
strange though, both 8139 cards are identical and eth1 has much more traffic
than eth2, and something like this has never happened. I use eth2 sparingly
though, and I have never had it receive so many small packets.

Hope someone helps, it's a pain in the neck and I need eth2 ;)
