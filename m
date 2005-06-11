Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261660AbVFKJjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbVFKJjv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 05:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVFKJjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 05:39:40 -0400
Received: from smtp9.wanadoo.fr ([193.252.22.22]:37625 "EHLO smtp9.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261660AbVFKJjU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 05:39:20 -0400
X-ME-UUID: 20050611093920137.219F31C005F5@mwinf0912.wanadoo.fr
Message-ID: <33440948.1118482760126.JavaMail.www@wwinf0903>
From: Pascal CHAPPERON <pascal.chapperon@wanadoo.fr>
Reply-To: pascal.chapperon@wanadoo.fr
To: Francois Romieu <romieu@fr.zoreil.com>,
       Andrew Hutchings <info@a-wing.co.uk>
Subject: Re: sis190
Cc: linux-kernel@vger.kernel.org, vinay kumar <b4uvin@yahoo.co.in>,
       jgarzik@pobox.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.13.91.67]
X-WUM-FROM: |~|
X-WUM-TO: |~||~|
X-WUM-CC: |~||~||~|
X-WUM-REPLYTO: |~|
Date: Sat, 11 Jun 2005 11:39:20 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Message du 11/06/05 01:46
> De : "Francois Romieu" <romieu@fr.zoreil.com>
> 
> Andrew Hutchings <info@a-wing.co.uk> :
> [...]
> > Something went wrong on build.  Getting 'syntax error before '}' token' 
> > on every line there is _msleep(1);
> 
> I have checked it again and the patch applies and compiles correctly
> against 2.6.12-rc6. So does the updated patch of the day:
> 
> http://www.fr.zoreil.com/people/francois/misc/20050611-2.6.12-rc-sis190-test.patch

Sorry, but it does not compile correctly if you define CONFIG_SIS190_NO_DELAY.
# diff -puN /usr/src/linux/drivers/net/sis190.c sis190.c
--- /usr/src/linux/drivers/net/sis190.c 2005-06-11 09:16:41.000000000 +0200
+++ sis190.c    2005-06-11 10:20:01.000000000 +0200
@@ -43,8 +43,8 @@
 #endif

 #ifdef CONFIG_SIS190_NO_DELAY
-#define s_mdelay(d)    do { (d) } while (0)
-#define s_msleep(d)    do { (d) } while (0)
+#define s_mdelay(d)    do {  } while (0)
+#define s_msleep(d)    do {  } while (0)
 #else
 #define s_mdelay(d)    mdelay(d)
 #define s_msleep(d)    msleep(d)

So it works.

> 
> No need to use SIS190_NO_DELAY so far. The media negotiation process has
> been changed. It is now allowed to take longer to complete (it should help).
> 
> dmesg and ifconfig output will be welcome.
> 
> --
> Ueimor
> 
> 
It still do not work :
#dmesg
...
sis190 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ  10
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: sis190 at ffffc20000026c00 (IRQ: 10), 00:11:2f:e9:42:70
eth0: Enabling Auto-negotiation.
eth0: Link on unknown mode.
eth0: no IPv6 routers present
eth0: status = 20000008
eth0: status = 00000004
eth0: status = 20000008
eth0: status = 00000004
eth0: pad error. status = 00000000
eth0: pad error. status = 00000000
eth0: pad error. status = 00000000
eth0: pad error. status = 00000000
...

#ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8 errors:248 dropped:0 overruns:0 frame:248
          TX packets:8 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:762 (762.0 b)  TX bytes:1404 (1.3 KiB)
          Interrupt:10 Base address:0xbeef


I compared sis190_rx_interrupt() in old and new driver, and i tried :
 diff -puN /usr/src/linux/drivers/net/sis190.c sis190.c
--- /usr/src/linux/drivers/net/sis190.c 2005-06-11 09:16:41.000000000 +0200
+++ sis190.c    2005-06-11 10:20:01.000000000 +0200
@@ -478,7 +478,7 @@ static int sis190_rx_interrupt(struct ne
                rmb();
                status = le32_to_cpu(desc->PSize);

-               if (status & OWNbit)
+               if (desc->status & OWNbit)
                        break;

                if (status & RxCRC) {

new test :
# dmesg
...
sis190 Gigabit Ethernet driver 1.2 loaded
ACPI: PCI Interrupt 0000:00:04.0[A] -> Link [LNKD] -> GSI 10 (level, low) -> IRQ  10
PCI: Setting latency timer of device 0000:00:04.0 to 64
0000:00:04.0: sis190 at ffffc20000026c00 (IRQ: 10), 00:11:2f:e9:42:70
eth0: Enabling Auto-negotiation.
eth0: Link on unknown mode.
eth0: no IPv6 routers present
eth0: status = 22000008
eth0: status = 00000004
eth0: status = 20000008
eth0: status = 00000004
eth0: status = 20000040
eth0: status = 20000040
eth0: status = 20000040
eth0: status = 20000040
eth0: status = 20000008
eth0: status = 00000004
...

#ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:6 errors:0 dropped:0 overruns:0 frame:0
          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:1206 (1.1 KiB)  TX bytes:1026 (1.0 KiB)
          Interrupt:10 Base address:0xbeef

As you can see, no more RX errors, but the network script failed to establish the link.

On the other box (dhcp server) :
#dmesg
...
eth2: link down
eth2: link up, 100Mbps, full-duplex, lpa 0x41E0
DHCPREQUEST for 10.169.21.20 from 00:11:2f:e9:42:70 via eth2: unknown lease 10.169.21.20.
DHCPDISCOVER from 00:11:2f:e9:42:70 via eth2
DHCPOFFER on 10.169.21.47 to 00:11:2f:e9:42:70 via eth2
DHCPDISCOVER from 00:11:2f:e9:42:70 via eth2
DHCPOFFER on 10.169.21.47 to 00:11:2f:e9:42:70 via eth2
DHCPDISCOVER from 00:11:2f:e9:42:70 via eth2
DHCPOFFER on 10.169.21.47 to 00:11:2f:e9:42:70 via eth2
...

I also tried without dhcp :
# ifconfig
eth0      Link encap:Ethernet  HWaddr 00:11:2F:E9:42:70
          inet addr:10.169.21.20  Bcast:10.169.23.255  Mask:255.255.252.0
          inet6 addr: fe80::211:2fff:fee9:4270/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:59 errors:0 dropped:0 overruns:0 frame:0
          TX packets:43 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:4148 (4.0 KiB)  TX bytes:1806 (1.7 KiB)
          Interrupt:10 Base address:0xbeef

ping failed both sides, though RX and TX counters were incremented.


Regards
Pascal


