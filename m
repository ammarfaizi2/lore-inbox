Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWBFOWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWBFOWh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbWBFOWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:22:37 -0500
Received: from sylvester.sraq.qc.ca ([132.214.200.120]:45287 "HELO
	sylvester.sraq.qc.ca") by vger.kernel.org with SMTP id S932125AbWBFOWg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:22:36 -0500
Message-ID: <43E75B97.5050603@logidac.com>
Date: Mon, 06 Feb 2006 09:22:15 -0500
From: Guillaume Filion <gfk@logidac.com>
Organization: Logidac
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: gfk@logidac.com
Subject: AX.25 ARP debugging
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
DomainKey-Status: no signature
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm playing with openslug and AX.25 and I'm having problems passing IP
through AX.25. They are connected by a serial link. The link works at
the AX.25 level: it works with call. But I cannot get it to work with
IP. Bob W5/VK2YQA on rec.radio.amateur.digital.misc helped me pinpoint
this to a arp problem, but now I'm at loss on how to debug it
further...

My config:
I have a PC running Debian Linux testing (ali) and a NSLU2 running
N7IPB's OpenSlug mod
(http://wetnet.net/).
=====
ali:~# uname -a
Linux ali 2.4.27-2-k7 #1 Tue Aug 16 17:30:14 JST 2005 i686 GNU/Linux
ali:~# ifconfig ax0
ax0       Link encap:AMPR AX.25  HWaddr VA2JF-1
           inet addr:172.25.25.1  Bcast:172.25.255.255  Mask:255.255.0.0
           UP BROADCAST RUNNING  MTU:1500  Metric:1
           RX packets:211 errors:0 dropped:0 overruns:0 frame:0
           TX packets:17800 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:10
           RX bytes:6282 (6.1 KiB)  TX bytes:1740572 (1.6 MiB)
ali:~# route -n
Kernel IP routing table
Destination  Gateway      Genmask        Flags Metric Ref  Use  Iface
172.25.25.0  0.0.0.0      255.255.255.0  U     0      0    0    ax0
10.10.16.0   0.0.0.0      255.255.255.0  U     0      0    0    eth0
192.168.0.0  0.0.0.0      255.255.255.0  U     0      0    0    eth0
172.25.0.0   0.0.0.0      255.255.0.0    U     0      0    0    ax0
0.0.0.0      192.168.0.3  0.0.0.0        UG    0      0    0    eth0
=====
root@slug:~# uname -a
Linux slug 2.6.11.2 #1 Mon Dec 5 06:24:32 PST 2005 armv5teb unknown
root@slug:~# ifconfig ax0
ax0       Link encap:AMPR AX.25  HWaddr VA2JF-2
           inet addr:172.25.25.2  Bcast:172.25.255.255  Mask:255.255.0.0
           UP BROADCAST RUNNING  MTU:1500  Metric:1
           RX packets:52 errors:0 dropped:0 overruns:0 frame:0
           TX packets:22 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 txqueuelen:10
           RX bytes:4238 (4.1 Kb)  TX bytes:898 (898.0 b)
root@slug:~# route -n
Kernel IP routing table
Destination  Gateway      Genmask        Flags Metric Ref  Use  Iface
192.168.0.0  0.0.0.0      255.255.255.0  U     0      0    0    eth0
172.25.0.0   0.0.0.0      255.255.0.0    U     0      0    0    ax0
0.0.0.0      192.168.0.3  0.0.0.0        UG    0      0    0    eth0
=====

The actual problem:
=====
root@slug:~# arp -an
? (192.168.0.5) at 00:01:53:80:57:E6 [ether] on eth0
root@slug:~# arp -H ax25 -i ax0 -s 172.25.25.1 VA2JF-1
root@slug:~# arp -an
? (172.25.25.1) at * [ax25] PERM on -
? (192.168.0.5) at 00:01:53:80:57:E6 [ether] on eth0
root@slug:~# cat /proc/net/arp
IP address   HW type  Flags  HW address         Mask     Device
172.25.25.1  0x3      0x6                       *        ax0
192.168.0.5  0x1      0x2    00:01:53:80:57:E6  *        eth0
=====

I can confirm the problem with tcpdump:
=====
root@ali:~/tcpdump-ax25/tcpdump-3.9.3# ./tcpdump -envi ax0
tcpdump: listening on ax0, link-type AX25 (AX.25), capture size 96
bytes

[... root@slug:~# ping 172.25.25.1 ...]
17:30:01.703620 VA2JF-2 > -6: Res 3, C/R 0, UI, ?, pf 0, length 101:
(tos 0x0, ttl  64, id 0, offset 0, flags [DF], proto: ICMP (1), length:
84) 172.25.25.2 > 172.25.25.1: ICMP echo request, id 1691, seq 0,
length 64
[... Notice the "VA2JF-2 > -6" instead of "VA2JF-2 > VA2JF-1" ...]

[... root@ali:~# ping 172.25.25.2 ...]
17:31:24.033354 VA2JF-1 > VA2JF-2: Res 3, C/R 0, UI, ?, pf 0, length
101: (tos 0x0, ttl  64, id 0, offset 0, flags [DF], proto: ICMP (1),
length: 84) 172.25.25.1 > 172.25.25.2: ICMP echo request, id 6003, seq
1, length 64
[... I never get an answer from slug, I guess it's because slug's arp
table doesn't contain ali's address ...]
=====

Any help appreciated,
GFK's
--
Guillaume Filion, ing. jr
Logidac Tech., Beaumont, Québec, Canada - http://logidac.com/
PGP Key and more: http://guillaume.filion.org/
