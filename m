Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbVLLSOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbVLLSOb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 13:14:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932106AbVLLSOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 13:14:31 -0500
Received: from fmmailgate05.web.de ([217.72.192.243]:51858 "EHLO
	fmmailgate05.web.de") by vger.kernel.org with ESMTP id S932104AbVLLSOa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 13:14:30 -0500
Date: Mon, 12 Dec 2005 19:14:29 +0100
Message-Id: <356942780@web.de>
MIME-Version: 1.0
From: =?iso-8859-1?Q?Burkhard=20Sch=F6lpen?= <bschoelpen@web.de>
To: linux-kernel@vger.kernel.org
Subject: Strange delay on PCI-DMA-transfer completion by wait_event_interruptible()
Organization: http://freemail.web.de/
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to write a driver for a custom PCI-Board which is DMA-Busmaster capable (kernel 2.6.13 with SMP). Unfortunately I get some strange delay between the start of the transfer until the interrupt appears, which signals its completion.

Concerning a dma transfer from RAM to the pci device, my code does the following:

while (down_interruptible(my_device->write_semaphore));
my_device->dma_write_complete = 0;
my_device->dma_direction  = PCI_DMA_TODEVICE;
my_device->bus_addr = pci_map_single(my_device->pci_device, pointer_to_buffer, my_device->dma_size, my_device->dma_direction);

writel (cpu_to_le32 (bus_addr), MY_DMA_ADDR_REGISTER);
writel (cpu_to_le32 (my_device->dma_size/4), MY_DMA_COUNT_REGISTER);	    //triggers dma transfer	

if (wait_event_interruptible(write_wait_queue, my_device->dma_write_complete))
{
      //handle error...
}
//test, if MY_DMA_COUNT_REGISTER contains 0
up(my_device->write_semaphore);

Inside the Interrupt-handler I do the following:

pci_unmap_single (my_device->pci_device, my_device->bus_addr, my_device->dma_size, my_device->dma_direction);
my_device->dma_write_complete = 1;
wake_up_interruptible(&write_wait_queue);
return IRQ_HANDLED;

Actually the dma transfer works but I get a strange timing issue, which seems to be caused by wait_event_interruptible(). I measured the clock ticks elapsing from the start of the transfer until the interrupt appears. Converted to microseconds I get more than 600 us for less than 3 kB buffers. If I try out busy waiting using "while (!my_device->dma_write_complete)" instead of wait_event_interruptible() the transfer already completes successfully after about 80 us. The device has to transport very large amounts of data, so I have to get the transfer rate as high as possible.

I'm sorry if I made a very simple mistake, because I'm quite unexperienced in driver development, so hints would be very appreciated.

Kind regards,
Burkhard
______________________________________________________________________
XXL-Speicher, PC-Virenschutz, Spartarife & mehr: Nur im WEB.DE Club!		
Jetzt gratis testen! http://freemail.web.de/home/landingpad/?mc=021130

