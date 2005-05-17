Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVEQObO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVEQObO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 10:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVEQObN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 10:31:13 -0400
Received: from trixi.wincor-nixdorf.com ([217.115.67.77]:16520 "EHLO
	trixi.wincor-nixdorf.com") by vger.kernel.org with ESMTP
	id S261530AbVEQOaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 10:30:55 -0400
From: "Salomon, Frank" <frank.salomon@wincor-nixdorf.com>
To: linux-net <linux-net@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Don Fry <brazilnut@us.ibm.com>
Message-ID: <4289FF48.9070205@wincor-nixdorf.com>
Date: Tue, 17 May 2005 16:27:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: pci-irq VIA82C586 problem on IBM 4694-205 kernel version 2.4.29
References: <428379AC.9080206@wincor-nixdorf.com> <20050512162803.GA15201@us.ibm.com>   <42847C64.5080405@wincor-nixdorf.com> <20050513164654.GB30792@us.ibm.com>
In-Reply-To: <20050513164654.GB30792@us.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

With kernel version 2.4.18 I have no problem to run pcnet32.o on the IBM 
4694-205. Now I switch to kernel version 2.4.29. insmod crc32 : ok , 
insmod mii : ok , insmod pcnet32 : ok.

But if I run ifconfig (ifup) the system fries. Can't toggle the numlock 
led. I find out that the system generates permanently interrupts from 
the pcnet32 chip after calling request_irq (irq=9).

lspci:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C585VP [Apollo VP1/VPX] 
(rev 25)
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA 
[Apollo VP] (rev 47)
00:07.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus 
Master IDE (rev 06)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02)
00:07.3 Non-VGA unclassified device: VIA Technologies, Inc. VT82C586B 
ACPI (rev 10)
00:0a.0 VGA compatible controller: Cirrus Logic GD 5446
00:0b.0 Ethernet controller: Advanced Micro Devices [AMD] 79c970 
[PCnet32 LANCE] (rev 43)


A possible solution could be (only tested on IBM 4694-205 and I don't 
have other systems with VIA Tech.):


diff -u 2.4.29_orig/arch/i386/kernel/pci-irq.c 
2.4.29/arch/i386/kernel/pci-irq.c
--- 2.4.29_orig/arch/i386/kernel/pci-irq.c      Wed Jan 19 15:09:25 2005
+++ 2.4.29/arch/i386/kernel/pci-irq.c   Tue May 17 15:55:28 2005
@@ -214,6 +214,17 @@
         return 1;
  }

+static int pirq_via_586_get(struct pci_dev *router, struct pci_dev 
*dev, int pirq)
+{
+       return read_config_nybble(router, 0x55, pirq);
+}
+static int pirq_via_586_set(struct pci_dev *router, struct pci_dev 
*dev, int pirq, int irq)
+{
+       write_config_nybble(router, 0x55, pirq, irq);
+       return 1;
+}
+
+
  /*
   * ITE 8330G pirq rules are nibble-based
   * FIXME: pirqmap may be { 1, 0, 3, 2 },
@@ -649,6 +660,10 @@
         switch(device)
         {
                 case PCI_DEVICE_ID_VIA_82C586_0:
+                       r->name = "VIA";
+                       r->get = pirq_via_586_get;
+                       r->set = pirq_via_586_set;
+                       return 1;
                 case PCI_DEVICE_ID_VIA_82C596:
                 case PCI_DEVICE_ID_VIA_82C686:
                 case PCI_DEVICE_ID_VIA_8231:


Best regards, Frank
