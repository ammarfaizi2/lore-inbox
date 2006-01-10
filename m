Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWAJNSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWAJNSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWAJNSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:18:44 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:2729 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP id S932196AbWAJNSn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:18:43 -0500
Date: Tue, 10 Jan 2006 14:18:41 +0100
Message-Id: <419982528@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Burkhard=20Sch=F6lpen?= <bschoelpen@web.de>
To: linux-kernel@vger.kernel.org
Subject: PCI DMA Interrupt latency
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm writing a driver for a custom pci card with an FPGA 
(Xilinx Spartan 2 (XC2S150-6) with PCI 32 LogiCore), 
which  can act as a pci bus master. The device is designed 
to do DMA transfers with high bandwidth. One task is to 
send image data to a printer which already works quite 
well, but sometimes there are randomly occuring 
problems concerning the timing between two DMA 
transfers. The issue seems to be something like interrupt 
latency in hardware. Measuring some signals with an 
oscilloscope shows, that the delay from generating the 
interrupt, which signals a finished transfer, to the time 
when the interrupt register on the card is reset (i.e. the 
beginning of the ISR) sometimes increases to more 
than 500 microseconds, which is dimensions too high. 

I already tried with other hardware deactivated, which 
could cause traffic on the pci bus or generate many interrupts 
(except hard disk). I also increased the priority of the IRQ 
used by the pci board (with a tool called irqtune) to the 
maximum possible value. Another consideration is, that 
another driver could lock all interrupts for too long (but for 
500 us??).  

As my experience on DMA stuff is not yet too 
great, I would be very glad if somebody could give me some 
advice to solve this problem. Below there is some further 
information about my environment and how I set up the DMA 
transfers.

Kind regards,
Burkhard Schölpen


Here is how I set up dma transfers from RAM to the pci device:

while (down_interruptible(my_device->write_semaphore));
my_device->dma_write_complete = 0;
my_device->dma_direction = PCI_DMA_TODEVICE;

writel (cpu_to_le32 (virt_to_phys(dma_buffer)), MY_DMA_ADDR_REGISTER);
writel (cpu_to_le32 (my_device->dma_size/4), MY_DMA_COUNT_REGISTER); //triggers dma transfer

if (wait_event_interruptible(write_wait_queue, my_device->dma_write_complete))
{
  //handle error...
}
//test, if MY_DMA_COUNT_REGISTER contains 0
up(my_device->write_semaphore);

Inside the Interrupt-handler I do the following:

my_device->dma_write_complete = 1;
wake_up_interruptible(&write_wait_queue);
return IRQ_HANDLED;

Here is some information about the PC:
- Gigabyte GA-8I945GMF mainboard with Pentium D processor
- custom pci board with Xilinx FPGA Spartan 2 (XC2S150-6) with PCI 32 LogiCore
- Debian Linux with 2.6.13.4 SMP kernel


______________________________________________________________
Verschicken Sie romantische, coole und witzige Bilder per SMS!
Jetzt bei WEB.DE FreeMail: http://f.web.de/?mc=021193

