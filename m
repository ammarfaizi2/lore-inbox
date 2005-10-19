Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVJSRr2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVJSRr2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 13:47:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbVJSRr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 13:47:28 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:28901 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S1751189AbVJSRr1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 13:47:27 -0400
In-Reply-To: <6DFB5723-0042-46FE-811F-BF372B068014@mac.com>
References: <20051017005855.132266ac.akpm@osdl.org> <1129536482.7620.76.camel@gaston> <6DFB5723-0042-46FE-811F-BF372B068014@mac.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <204AB9A8-7701-402F-A6B9-DF455DAA2A3F@mac.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [BUG] PDC20268 crashing during DMA setup on stock Debian 2.6.12-1-powerpc
Date: Wed, 19 Oct 2005 13:48:47 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do you have any other ideas WRT this bug?  I've been browsing around  
in the code a bit, and I plan to try diffing my 2.6.8.1 version of  
the files against the latest Debian to see what changed, although I  
suspect it will be a relatively fat hunk of changes.  Thanks for your  
help!

On Oct 17, 2005, at 10:35:07, Kyle Moffett wrote:


> On Oct 17, 2005, at 04:08:01, Benjamin Herrenschmidt wrote:
>
>
>>> I'm trying to upgrade the kernel in a Samba fileserver from a  
>>> custom-
>>> compiled 2.6.8.1 to a stock Debian 2.8.12-1-powerpc and running into
>>> an issue with my Sonnet Tempo ATA/100 [The card is a rebranded
>>> FirmTek UltraTek/100 which is _actually_ a Promise PDC20268 with  
>>> Mac-
>>> bootable firmware ROM].  I'm getting the following BUG() output
>>> [NOTE: This was hand-copied from the screen after panic, so there  
>>> may
>>> be typos despite me being careful to avoid them]:
>>>
>>>
>>
>> What is the machine ?
>>
>>
>
> An aging PowerMac G4 400MHz [AGP graphics].
>
>
>
>>> PDC20268: IDE controller at PCI slot 0001:11:02.0
>>> PDC20268: chipset revision 2
>>> PDC20268: ROM enabled at 0x80090000
>>> PDC20268: 100% native mode on irq 52
>>> ide2: PDC20268 Bus-Master DMA disabled (BIOS)
>>>
>>>
>>
>> The above is probably the cause of your problem. That is, on one  
>> side, the code in setup-pci.c will consider your chip has disabled  
>> DMA (which it probably doesn't have but we'll try to figure that  
>> out later) and on the other side, the ide core blows up when it  
>> gets a disabled DMA ... There is something wrong here between ide/ 
>> setup-pci.c and ide/ide-dma.c ...
>>
>>
>
> I noticed that and started browsing around in the code but I don't  
> know it well enough to do much other than find where the log  
> statements are printed :-D.
>
>
>
>> Now, why does it consider your stuff disabled ? Well, that is the  
>> interesting thing ...
>>
>> Looking at the code, it could be ide_get_or_set_dma_base()  
>> returning 0 though I fail to see how. It's not the pci_set_master 
>> () call failing or we would see that printk:
>>
>>     printk(KERN_ERR "%s: %s error updating PCICMD\n",
>>         hwif->name, d->name);
>>
>> If it was dma_base = pci_resource_start(dev, 4); then we would get  
>> another printk as well that we didn't get ...
>>
>> Can you try adding printk's yourself around there to check what  
>> exactly is going on here and why it's thinking DMA is not available ?
>>
>>
>
> Hmm, this will need to wait till thanksgiving week for me to be  
> around the machine to run tests.
>
>
>
>> Also, send the output of lspci -vv as root for this device.
>>
>>
>
> Appended; thanks!
>
> Cheers,
> Kyle Moffett
>
> 0001:02:02.0 Mass storage controller: Promise Technology, Inc.  
> PDC20268 (Ultra100 TX2) (rev 02) (prog-if 85)
>         Subsystem: Promise Technology, Inc.: Unknown device ad68
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
> ParErr- Stepping- SERR- FastB2B-
>         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow  
> >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 16 (1000ns min, 4500ns max), Cache Line Size: 0x08  
> (32 bytes)
>         Interrupt: pin A routed to IRQ 52
>         Region 0: I/O ports at 1440 [size=8]
>         Region 1: I/O ports at 1430 [size=4]
>         Region 2: I/O ports at 1420 [size=8]
>         Region 3: I/O ports at 1410 [size=4]
>         Region 4: I/O ports at 1400 [size=16]
>         Region 5: Memory at 800a0000 (32-bit, non-prefetchable)  
> [size=64K]
>         Expansion ROM at 80090000 [disabled] [size=64K]
>         Capabilities: [60] Power Management version 1
>                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME 
> (D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 10 00 00
> 10: 41 14 00 00 31 14 00 00 21 14 00 00 11 14 00 00
> 20: 01 14 00 00 00 00 0a 80 00 00 00 00 5a 10 68 ad
> 30: 01 00 09 80 60 00 00 00 00 00 00 00 34 01 04 12
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 01 00 21 02 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>
>
>
>



