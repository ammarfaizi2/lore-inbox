Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288059AbSAQBs3>; Wed, 16 Jan 2002 20:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288057AbSAQBsT>; Wed, 16 Jan 2002 20:48:19 -0500
Received: from unknown.Level3.net ([64.152.86.3]:13603 "HELO [64.152.86.3]")
	by vger.kernel.org with SMTP id <S288059AbSAQBsJ>;
	Wed, 16 Jan 2002 20:48:09 -0500
Message-ID: <3C462E5E.4020802@esstech.com>
Date: Wed, 16 Jan 2002 19:52:30 -0600
From: Gerald Champagne <gerald.champagne@esstech.com>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: Promise 20268 PCI register decoding
In-Reply-To: <Pine.LNX.4.10.10201161713080.30663-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just checked 2.5.3-pre1 and it still makes references to
registers above 0x0f.   I see many references to registers
at  0x11, 0x1b, 0x1f.  For example, the following:

unsigned long atapi_reg	= high_16 + (hwif->channel ? 0x24 : 0x00);

That assumes atapi_reg will be 0x24 beyond the base of bar4 (high_16).
Is my PCI code showing me an incorrect size for bar4, or is this
accessing registers beyond its limits?

Thanks.

Gerald

Andre Hedrick wrote:

> I fixed that problem after it was discovered.
> It is in the newest drivers.
> 
> 
> On Wed, 16 Jan 2002, Gerald Champagne wrote:
> 
> 
>>I thought I understood the way PCI devices are accessed in Linux,
>>but the code for the Promise PCI controllers has me confused.  To
>>me it looks like the code is accessing registers outside the area
>>allocated to the PCI device during initialization.
>>
>>The device is configured with the following resources (on a Mips-based
>>platform):
>>
>>00:08.0 Class 0180: 105a:4d68 (rev 01)
>>         I/O at 0x00000080 [size=0x8]
>>         I/O at 0x00000088 [size=0x4]
>>         I/O at 0x00000090 [size=0x8]
>>         I/O at 0x00000098 [size=0x4]
>>         I/O at 0x000000a0 [size=0x10]
>>         Mem at 0x08004000 [size=0x4000]
>>
>>The Promise code uses registers specified using bar4 but it uses offsets
>>above 0x0f.  Here's an example of the code in drivers/ide/pdc202xx.c:
>>
>>void pdc202xx_reset (ide_drive_t *drive)
>>{
>>         unsigned long high_16   = pci_resource_start(HWIF(drive)->pci_dev, 4);
>>         byte udma_speed_flag    = inb(high_16 + 0x001f);
>>
>>         OUT_BYTE(udma_speed_flag | 0x10, high_16 + 0x001f);
>>         mdelay(100);
>>         OUT_BYTE(udma_speed_flag & ~0x10, high_16 + 0x001f);
>>         mdelay(2000);           /* 2 seconds ?! */
>>}
>>
>>How can the code above try to write to a register 0x1f into a region with
>>a size of 0x10?  Wouldn't that stomp on the registers of some other PCI device?
>>
>>Thanks.
>>
>>Gerald
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>
>>
> 
> 
> 
> 


