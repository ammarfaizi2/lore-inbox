Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWAJDIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWAJDIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 22:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWAJDID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 22:08:03 -0500
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:45196 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S1750705AbWAJDIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 22:08:02 -0500
From: Grant Coady <gcoady@gmail.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: 2.4: e100 accounting bust for multiple adapters
Date: Tue, 10 Jan 2006 14:07:55 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <e196s1pj6u4apbjhgdm3imij4a10s6nb87@4ax.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

While testing for a different issue on a box with two e100 NICs I noticed 
that interrupt and other accounting are accumulated to the first e100 NIC.

Tested 2.4.(29|30|31|32)-hf32.1 plus 2.4.33-pre1 so the issue has been in 
there for a while :(

e100 is compiled as module, the problem is not there with 2.6.15.

The problem also goes away if I compile e100 in, tested with 2.4.32-hf32.1

grant@deltree:~$ while true; do egrep 'eth0|eth1' /proc/interrupts; sleep 1; done
 11:       3407          XT-PIC  eth0
 12:        630          XT-PIC  eth1 
 11:       3436          XT-PIC  eth0  [same test as below]
 12:        921          XT-PIC  eth1
 11:       3439          XT-PIC  eth0
 12:       1266          XT-PIC  eth1
 11:       3443          XT-PIC  eth0
 12:       1343          XT-PIC  eth1
 11:       3446          XT-PIC  eth0
 12:       1343          XT-PIC  eth1
 11:       3449          XT-PIC  eth0
 12:       1343          XT-PIC  eth1
 11:       3456          XT-PIC  eth0
 12:       1343          XT-PIC  eth1

dmesgs + configs on http://bugsplatter.mine.nu/test/boxen/deltree/

Is this a known issue?  

Cheers,
Grant.

more info:
part of http://lkml.org/lkml/2006/1/9/27 -- watching interrupts on 
eth1, but they're being accumulated to eth0:

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
- - -

