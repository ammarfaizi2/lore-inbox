Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262464AbTGZSLh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbTGZSLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:11:32 -0400
Received: from lidskialf.net ([62.3.233.115]:27324 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S262464AbTGZSKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:10:48 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Nvidia nforce2 IRQ polarity with IO-APIC problem
Date: Sat, 26 Jul 2003 19:26:00 +0100
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307261926.00207.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, over the last week or so I have been developing a patch against 2.5.75 to 
fix the IRQ problems I was having with onboard devices on my Nvidia 
Nforce2-based Epox 8RDA+ motherboard.

It turned out that i386 linux was assuming all IRQs > 15 were active low, 
level, and programming the IO-APIC with these parameters.

However, on my board, it turned out this was not the case. They were actually 
active HIGH, level. My patch fixes the io_apic code in linux to use the IRQ 
resource definitions from ACPI to setup the APIC. With this, my onboard 
devices now work.

The next problem is more troublesome. PCI cards plugged into the expansion 
slots do not appear to transmit IRQs (I'm testing with a Netgear MA311 
wavelan card).

The PCI expansion slot IRQs are mapped to IO-APIC pins 16,17,18,19 (system 
IRQ#16,17,18,19). In the ACPI IRQ resource definitions, these are defined as 
active HIGH, level (whereas standard PCI IRQs are active LOW, level).

I suspected there might be an error in the ACPI definitions, so I tried 
hacking my patch to force IRQs 16->19 to active low. With this hack, I do see 
device IRQs, but I also see MILLIONS of spurious IRQs.... so the code in 
irq.c masks off the interrupts with the message "IRQ#18: nobody cared".

I went into windows and checked how it was programming the IO-APIC. It is 
programming it as per the ACPI definitions.... i.e. the PCI expansion device 
IRQs are set to active HIGH, level. The PCI cards work in windows perfectly.

Checking the chip documentation for the wavelan PCI device shows that 
(suprise!) it generates IRQs which are active low, level.

So. 

1) The motherboard is expecting IRQs which are active HIGH, level.
2) PCI expansion devices are generating active LOW, level IRQs.

Something must be missing between these two. Does anyone have any ideas what. 
As this is an nvidia chipset, I do not have documentation on the MCP-T 
southbridge chipset.

