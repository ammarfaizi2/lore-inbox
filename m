Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWAIG4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWAIG4r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 01:56:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751526AbWAIG4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 01:56:47 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:60088 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1751193AbWAIG4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 01:56:46 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: Bernd Eckenfels <be-news06@lina.inka.de>, linux-kernel@vger.kernel.org,
       Willy Tarreau <willy@w.ods.org>
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Date: Mon, 09 Jan 2006 17:56:42 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <fm14s11j35163al7lcrnpoudh7lvnh91o3@4ax.com>
References: <20060108095741.GH7142@w.ods.org> <E1EvXi5-0000kv-00@calista.inka.de> <igs1s1lje7b7kkbmb9t6d06n8425i1b1i4@4ax.com> <4807377b0601081837u2c1d50b3w218d5ef9e3dc662@mail.gmail.com>
In-Reply-To: <4807377b0601081837u2c1d50b3w218d5ef9e3dc662@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jan 2006 18:37:52 -0800, Jesse Brandeburg <jesse.brandeburg@gmail.com> wrote:

Added Willy to Cc: -- I see a problem with 2 e100 NICs' accounting 
under 2.4.32...  See near and of this report.

>> Are rx checksums not turned on in 2.6' e100 driver?
>> CPU is only pentium/mmx 233
>
>Hey Grant, to answer your question, checksums are not offloaded with
>the current e100 driver but that really shouldn't make that much of a
>difference.  I'm actually going to go with interrupt load due to e100
>being at least related to the problem.
>
>The netdev-2.6 git tree currently has a driver that supports microcode
>loading for your rev 8 PRO/100 and that microcode may help your
>interrupt load due to e100.  however, it may already be loading. 
>Also, what do you have HZ set to? (250 is default in 2.6, 1000 in 2.4)
>so you could try running your 2.6 kernel with HZ=1000
>
>while you're running your test you could try (if you have sysstat)
>sar -I <e100 interrupt> 1 10
>
>or a simpler version, 10 loops of cat /proc/interrupts; sleep 1;

No sar, now I'm running a separate link from the other e100 eth1 
from deltree to another box so measurement and test traffic are 
separated.  I do everything via ssh so I can copy/paste from 
terminals ;)

This run is 2.6.15a, with 100Hz and voluntary preempt:

grant@deltree:~$ cat /proc/interrupts
           CPU0
  0:     106221          XT-PIC  timer
  1:          8          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:      11443          XT-PIC  eth2      <<== ADSL modem
  8:          1          XT-PIC  rtc
 11:      20402          XT-PIC  eth0      <<== localnet
 12:      21860          XT-PIC  eth1      <<== spare -> test
 14:       3260          XT-PIC  ide0
NMI:          0
ERR:          0
grant@deltree:~$

grant@deltree:~$ while true; do grep eth1 /proc/interrupts; sleep 1; done
 12:      26357          XT-PIC  eth1
 12:      26357          XT-PIC  eth1 \
 12:      26573          XT-PIC  eth1  |
 12:      27039          XT-PIC  eth1   > time grep -v 192\.168\. \
 12:      27514          XT-PIC  eth1  |   /var/log/apache/access_log \
 12:      28320          XT-PIC  eth1  |   | cut -c-96
 12:      29090          XT-PIC  eth1  |  real    0m6.205s
 12:      30017          XT-PIC  eth1  |  user    0m0.620s
 12:      30434          XT-PIC  eth1 /   sys     0m0.730s
 12:      30434          XT-PIC  eth1

grant@deltree:~$ while true; do grep eth1 /proc/interrupts; sleep 1; done
 12:      30650          XT-PIC  eth1
 12:      30651          XT-PIC  eth1 \
 12:      30657          XT-PIC  eth1  |
 12:      30661          XT-PIC  eth1   > time cat /var/log/apache/access_log
 12:      30936          XT-PIC  eth1  |  real    0m2.383s
 12:      31343          XT-PIC  eth1  |  user    0m0.010s
 12:      31593          XT-PIC  eth1 /   sys     0m0.480s
 12:      31593          XT-PIC  eth1

This run is 2.6.15b, with 1000Hz and voluntary preempt:

grant@deltree:~$ while true; do grep eth1 /proc/interrupts; sleep 1; done
 12:       4386          XT-PIC  eth1
 12:       4386          XT-PIC  eth1 \
 12:       4427          XT-PIC  eth1  |
 12:       4904          XT-PIC  eth1   > time grep -v 192\.168\. \
 12:       5350          XT-PIC  eth1  |   /var/log/apache/access_log \
 12:       6065          XT-PIC  eth1  |   | cut -c-96
 12:       6906          XT-PIC  eth1  |  real    0m6.649s
 12:       7693          XT-PIC  eth1  |  user    0m0.841s
 12:       8450          XT-PIC  eth1 /   sys     0m1.047s
 12:       8548          XT-PIC  eth1
 12:       8548          XT-PIC  eth1

ran above a few times to gauge repeatability, variation ~200ms in real.

grant@deltree:~$ while true; do grep eth1 /proc/interrupts; sleep 1; done
 12:      18347          XT-PIC  eth1
 12:      18348          XT-PIC  eth1 \
 12:      18417          XT-PIC  eth1  |
 12:      18794          XT-PIC  eth1   > time cat /var/log/apache/access_log
 12:      19181          XT-PIC  eth1  |  real    0m2.573s
 12:      19283          XT-PIC  eth1 /   user    0m0.005s
 12:      19284          XT-PIC  eth1     sys     0m0.547s

No joy with 1000Hz, turn off preempt?

This run is 2.6.15c, with 1000Hz and no preempt:

grant@deltree:~$ while true; do grep eth1 /proc/interrupts; sleep 1; done
 12:       4400          XT-PIC  eth1 
 12:       4400          XT-PIC  eth1 \
 12:       4614          XT-PIC  eth1  |
 12:       5053          XT-PIC  eth1   > time grep -v 192\.168\. \
 12:       5495          XT-PIC  eth1  |   /var/log/apache/access_log \
 12:       6686          XT-PIC  eth1  |   | cut -c-96
 12:       7394          XT-PIC  eth1  |  real    0m6.696s
 12:       8258          XT-PIC  eth1  |  user    0m0.841s
 12:       8456          XT-PIC  eth1 /   sys     0m0.994s
 12:       8457          XT-PIC  eth1
 12:       8457          XT-PIC  eth1

grant@deltree:~$ while true; do grep eth1 /proc/interrupts; sleep 1; done
 12:       8544          XT-PIC  eth1 \
 12:       8814          XT-PIC  eth1  |  time cat /var/log/apache/access_log
 12:       9485          XT-PIC  eth1   > real    0m2.511s
 12:       9486          XT-PIC  eth1  |  user    0m0.004s
 12:       9486          XT-PIC  eth1 /   sys     0m0.529s

Still no joy?

Confirm 2.4 timings, this is with 2.4.32-hf32.1:

grant@deltree:~$ while true; do egrep 'eth0|eth1' /proc/interrupts; sleep 1; done
 11:       6744          XT-PIC  eth0
 12:          4          XT-PIC  eth1
 11:       6746          XT-PIC  eth0 \
 12:          4          XT-PIC  eth1  |
 11:       7178          XT-PIC  eth0   > time grep -v 192\.168\. \
 12:          4          XT-PIC  eth1  |   /var/log/apache/access_log \
 11:       7552          XT-PIC  eth0  |   | cut -c-96
 12:          4          XT-PIC  eth1 /   real    0m1.565s
 11:       7554          XT-PIC  eth0     user    0m0.510s
 12:          4          XT-PIC  eth1     sys     0m0.340s

grant@deltree:~$ while true; do egrep 'eth0|eth1' /proc/interrupts; sleep 1; done
 11:       9136          XT-PIC  eth0 \
 12:          4          XT-PIC  eth1  |
 11:       9516          XT-PIC  eth0   > time cat /var/log/apache/access_log
 12:          4          XT-PIC  eth1  |  real    0m1.946s
 11:      10146          XT-PIC  eth0  |  user    0m0.000s
 12:          4          XT-PIC  eth1 /   sys     0m0.200s
 11:      10321          XT-PIC  eth0
 12:          4          XT-PIC  eth1

Odd, with 2.4, the two e100 NICs are not being accounted properly:

root@deltree:~# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:90:27:42:AA:77
          inet addr:192.168.1.1  Bcast:192.168.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:4840 errors:0 dropped:0 overruns:0 frame:0
          TX packets:8825 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:341812 (333.8 Kb)  TX bytes:9931009 (9.4 Mb)
          Interrupt:11 Base address:0xdcc0 Memory:fd201000-fd201038

eth1      Link encap:Ethernet  HWaddr 00:90:27:58:32:D4
          inet addr:192.168.2.1  Bcast:192.168.2.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:12 Base address:0xdc80 Memory:fd200000-fd200038

dmesg says:
Intel(R) PRO/100 Network Driver - version 2.3.43-k1
Copyright (c) 2004 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

e100: selftest OK.
e100: eth1: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled
  cpu cycle saver enabled

smc-ultra.c:v2.02 2/3/98 Donald Becker (becker@cesdis.gsfc.nasa.gov)
eth2: SMC Ultra at 0x280, 00 00 C0 5D 46 B5,assigned  IRQ 3 memory 0xd0000-0xd3fff.
e100: eth0 NIC Link is Up 100 Mbps Full duplex
e100: eth1 NIC Link is Up 100 Mbps Full duplex

Cheers,
Grant.
