Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264816AbUEKQOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264816AbUEKQOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 12:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264819AbUEKQOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 12:14:05 -0400
Received: from [213.91.247.3] ([213.91.247.3]:50699 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id S264816AbUEKQNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 12:13:55 -0400
Message-ID: <40A0FB04.1000902@prostak.org>
Date: Tue, 11 May 2004 19:10:44 +0300
From: dobrev <dobrev666@prostak.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Craig Bradney <cbradney@zip.com.au>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: Linux 2.6.6 "IDE cache-flush at shutdown fixes"
References: <409F4944.4090501@keyaccess.nl>	 <200405102125.51947.bzolnier@elka.pw.edu.pl> <409FF068.30902@keyaccess.nl>	 <200405102352.24091.bzolnier@elka.pw.edu.pl>	 <40A0B7E4.7060103@keyaccess.nl> <1084280198.9420.5.camel@amilo.bradney.info>
In-Reply-To: <1084280198.9420.5.camel@amilo.bradney.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Craig Bradney wrote:

>On Tue, 2004-05-11 at 13:24, Rene Herman wrote:
>  
>
>>Bartlomiej Zolnierkiewicz wrote:
>>
>>    
>>
>>>Rene, can you send me copies of /proc/ide/hda/identify and
>>>/proc/ide/hdc/identify?
>>>      
>>>
>>Sure, attached. Quite sure you wanted hdc though? That's a DVD-ROM.
>>
>>    
>>
>>>I still would like to know why these drives don't accept flush cache 
>>>commands (or it is a driver's bug?).
>>>      
>>>
>>No idea I'm afraid. Seems at least new Maxtor drives are affected. Both
>>the "120P0" (120G, 8M cache) and "L0" (120G, 2M cache) were reported in
>>this thread.
>>    
>>
>
>At a guess the 80P0 drives will also be affected (80G, 8mb cache), but
>as yet I havent tried 2.6.6 on the boxes with them. Tonight if theres
>time.
>
>Craig
>

I have Maxtor 6Y060L0 and is also affected. Now I am with 2.6.5.
SvrWks IDE controller also have problems with 2.6.6 because the drive 
works in mdma2 mode.
When in 2.6.5 the transfer mode is udma2.
Probably because of this (from patch-2.6.6):
diff -Nru a/drivers/ide/pci/serverworks.c b/drivers/ide/pci/serverworks.c
--- a/drivers/ide/pci/serverworks.c     Sun May  9 19:33:36 2004
+++ b/drivers/ide/pci/serverworks.c     Sun May  9 19:33:36 2004
@@ -472,7 +472,9 @@
                                int dma = config_chipset_for_dma(drive);
                                if ((id->field_valid & 2) && !dma)
                                        goto try_dma_modes;
-                       }
+                       } else
+                               /* UDMA disabled by mask, try other DMA 
modes */+                               goto try_dma_modes;
                } else if (id->field_valid & 2) {
 try_dma_modes:
                        if ((id->dma_mword & hwif->mwdma_mask) ||

Here is part of dmesg from 2.6.6:


ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SvrWks OSB4: IDE controller at PCI slot 0000:00:0f.1
SvrWks OSB4: chipset revision 0
SvrWks OSB4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: Maxtor 6Y060L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 120103200 sectors (61492 MB) w/2048KiB Cache, CHS=65535/16/63, (U)DMA
 hda: hda1 hda2 hda3 < hda5 hda6 hda7 >
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: GenPS/2 Genius Wheel Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
BIOS EDD facility v0.13 2004-Mar-09, 1 devices found
Please report your BIOS at http://linux.dell.com/edd/results.html
hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=0x04 { DriveStatusError }
hda: Write Cache FAILED Flushing!
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 368k freed
Adding 297192k swap on /dev/hda2.  Priority:-1 extents:1
Linux agpgart interface v0.100 (c) Dave Jones


