Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287490AbSAQBHq>; Wed, 16 Jan 2002 20:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287571AbSAQBHg>; Wed, 16 Jan 2002 20:07:36 -0500
Received: from unknown.Level3.net ([64.152.86.3]:33822 "HELO [64.152.86.3]")
	by vger.kernel.org with SMTP id <S287490AbSAQBHS>;
	Wed, 16 Jan 2002 20:07:18 -0500
Message-ID: <3C4624CC.7020401@esstech.com>
Date: Wed, 16 Jan 2002 19:11:40 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Promise 20268 PCI register decoding
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought I understood the way PCI devices are accessed in Linux,
but the code for the Promise PCI controllers has me confused.  To
me it looks like the code is accessing registers outside the area
allocated to the PCI device during initialization.

The device is configured with the following resources (on a Mips-based
platform):

00:08.0 Class 0180: 105a:4d68 (rev 01)
         I/O at 0x00000080 [size=0x8]
         I/O at 0x00000088 [size=0x4]
         I/O at 0x00000090 [size=0x8]
         I/O at 0x00000098 [size=0x4]
         I/O at 0x000000a0 [size=0x10]
         Mem at 0x08004000 [size=0x4000]

The Promise code uses registers specified using bar4 but it uses offsets
above 0x0f.  Here's an example of the code in drivers/ide/pdc202xx.c:

void pdc202xx_reset (ide_drive_t *drive)
{
         unsigned long high_16   = pci_resource_start(HWIF(drive)->pci_dev, 4);
         byte udma_speed_flag    = inb(high_16 + 0x001f);

         OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
         mdelay(100);
         OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
         mdelay(2000);           /* 2 seconds ?! */
}

How can the code above try to write to a register 0x1f into a region with
a size of 0x10?  Wouldn't that stomp on the registers of some other PCI device?

Thanks.

Gerald

