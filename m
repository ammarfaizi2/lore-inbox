Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbTJCKaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 06:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263691AbTJCKaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 06:30:30 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:54495 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S263685AbTJCKaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 06:30:22 -0400
Date: Fri, 3 Oct 2003 12:30:25 +0200
From: Ookhoi <ookhoi@humilis.net>
To: Florian Zwoch <zwoch@backendmedia.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: e1000 -> 82540EM on linux 2.6.0-test[45] very slow in one direction
Message-ID: <20031003103025.GA20676@favonius>
Reply-To: ookhoi@humilis.net
References: <bkeli5$8l2$1@sea.gmane.org> <ble1ma$ul9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <ble1ma$ul9$1@sea.gmane.org>
X-Uptime: 10:31:59 up 116 days,  9:57, 36 users,  load average: 2.21, 1.96, 1.94
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Florian and others,

Florian Zwoch wrote (ao):
> issue seems to partly solved. the e1000 driver seems to be ok!
> i reconfigured my kernel and intentionally left out netfilter options. 
> after that my network performance was back to normal.
> 
> netfilter was only compiled in the kernel. it was not used with any rules!
> 
> so my wild guess would be that something with the netfilter code (i am 
> not 100% sure it was netfilter.. _maybe_ it was some small odd kernel 
> option i accidently enabled/disabled) is broken since test3 (again 
> uncertified. but i firstly noticed this switching from test3 to test4).

I have the same problem with a dual port gigabit intel nic. Download is
very fast, upload around 40k/sec.

Kernel is 2.6.0-test6
Nic is dual port gigabit intel 82546EB
The nic is connected to a 100Mbit switch, only one port in use.

If I do 'ethtool -A eth0 tx on' the machine is offline for 50 seconds.
When it is back online the upload is fast for a few seconds, and then
returns to its old speed. Full 'ethtool -d eth0' output below.

I have netfilter enabled, and will try another -test6 kernel with
netfilter not compiled in to see if that indeed makes a difference.

Btw, I had to compile the e1000 driver as a module. Compiled in it
doesn't work, as is stated on the intel support page:

http://www.intel.com/support/network/adapter/1000/linux/e1000.htm

" This driver is only supported as a loadable module at this time. Intel
is not supplying patches against the kernel source to allow for static
linking of the driver."

This is not clear from the kernel config help. A patch against
2.6.0-test6 is attached (I don't know how to only give n/m as an
option).

Btw2, can somebody please explain what the option E1000_NAPI does?

"
      Use Rx Polling (NAPI) (E1000_NAPI) [N/y] (NEW) ?

Sorry, no help available for this option yet.
"


Thanks in advance.


ethtool -d eth0 gives:

MAC Registers
-------------
0x00000: CTRL (Device control register)  0x08F00249
      Duplex:                            full
      Endian mode (buffers):             little
      Link reset:                        reset
      Set link up:                       1
      Invert Loss-Of-Signal:             no
      Receive flow control:              enabled
      Transmit flow control:             disabled
      VLAN mode:                         disabled
      Auto speed detect:                 disabled
      Speed select:                      1000Mb/s
      Force speed:                       no
      Force duplex:                      no
0x00008: STATUS (Device status register) 0x0000BB43
      Duplex:                            full
      Link up:                           link config
      TBI mode:                          disabled
      Link speed:                        100Mb/s
      Bus type:                          PCI-X
      Bus speed:                         133MHz
      Bus width:                         64-bit
0x00100: RCTL (Receive control register) 0x00008002
      Receiver:                          enabled
      Store bad packets:                 disabled
      Unicast promiscuous:               disabled
      Multicast promiscuous:             disabled
      Long packet:                       disabled
      Descriptor minimum threshold size: 1/2
      Broadcast accept mode:             accept
      VLAN filter:                       disabled
      Cononical form indicator:          disabled
      Discard pause frames:              filtered
      Pass MAC control frames:           don't pass
      Receive buffer size:               2048
0x02808: RDLEN (Receive desc length)     0x00001000
0x02810: RDH   (Receive desc head)       0x00000014
0x02818: RDT   (Receive desc tail)       0x00000010
0x02820: RDTR  (Receive delay timer)     0x00000000
0x00400: TCTL (Transmit ctrl register)   0x0004010A
      Transmitter:                       enabled
      Pad short packets:                 enabled
      Software XOFF Transmission:        disabled
      Re-transmit on late collision:     disabled
0x03808: TDLEN (Transmit desc length)    0x00001000
0x03810: TDH   (Transmit desc head)      0x000000DC
0x03818: TDT   (Transmit desc tail)      0x000000DC
0x03820: TIDV  (Transmit delay timer)    0x00000040

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="e1000-help-patch.diff"

--- drivers/net/Kconfig.orig	2003-10-03 12:17:48.000000000 +0200
+++ drivers/net/Kconfig	2003-10-03 12:27:56.000000000 +0200
@@ -1876,9 +1876,12 @@
 	  More specific information on configuring the driver is in 
 	  <file:Documentation/networking/e1000.txt>.
 
-	  To compile this driver as a module, choose M here and read
-	  <file:Documentation/networking/net-modules.txt>.  The module
-	  will be called e1000.
+	  This driver is only supported as a loadable module at this
+	  time. Intel is not supplying patches against the kernel source
+	  to allow for static linking of the driver.
+
+	  Read <file:Documentation/networking/net-modules.txt>. The
+	  module will be called e1000.
 
 config E1000_NAPI
 	bool "Use Rx Polling (NAPI)"

--3MwIy2ne0vdjdPXF--
