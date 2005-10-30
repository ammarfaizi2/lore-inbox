Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVJ3Uhu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVJ3Uhu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 15:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbVJ3Uhu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 15:37:50 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:35014 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1750996AbVJ3Uhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 15:37:50 -0500
Message-ID: <43652F1C.7010500@vc.cvut.cz>
Date: Sun, 30 Oct 2005 21:37:48 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Call for PIIX4 chipset testers
References: <Pine.LNX.4.64.0510251042420.10477@g5.osdl.org> <1cb7.435fd492.4a69a@altium.nl> <Pine.LNX.4.61.0510281056230.24372@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0510281056230.24372@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>Linus Torvalds <torvalds@osdl.org> wrote:
>>| can you please test out this patch and report what it says in dmesg?
> 
> 
> Here is an exotic one, from VMware (uses PIIX too). Says
> 
> 
> PCI quirk: region 1000-103f claimed by PIIX4 ACPI
> PCI quirk: region 1040-105f claimed by PIIX4 SMB
> ...later...
> PCI: Cannot allocate resource region 4 of device 0000:00:07.1

It is caused by Linux quirk which believes that SMB region needs 32 bytes, while 
i440BX datasheet says that 16 bytes are needed, and as we've not found any 
errata which would say that SMB region is 32 bytes on some revisions, system 
BIOS (and emulation) just allocates 16 bytes here.  Thus system BIOS puts SMB at 
0x1040-0x104f (you can see it below as motherboard reported resource), and IDE 
busmastering registers are put at 0x1050-0x105f.

But after Linux kernel quirk is executed, kernel believes that SMB and IDE 
regions overlap and refuse to use this region on IDE adapter.  Fortunately 
kernel automatically moves IDE busmaster from 0x1050 to 0x1070 once IDE is 
activated, as you can see in the ioports output below.  If you'll boot some 
non-Linux guest, you'll find that IDE happilly lives at 0x1050...

							Petr Vandrovec

> ...later...
> PIIX4: IDE controller at PCI slot 0000:00:07.1
> PIIX4: chipset revision 1
> PIIX4: not 100% native mode: will probe irqs later
> 
> 
> 
>>-more /proc/ioports (I'm using sash for this test ;-))
> 
> 0000-001f : dma1
> 0020-0021 : pic1
> 0040-0043 : timer0
> 0050-0053 : timer1
> 0060-006f : keyboard
> 0080-008f : dma page reg
> 00a0-00a1 : pic2
> 00c0-00df : dma2
> 00f0-00ff : fpu
> 0170-0177 : ide1
> 01f0-01f7 : ide0
> 0376-0376 : ide1
> 03c0-03df : vga+
> 03f6-03f6 : ide0
> 0cf8-0cff : PCI conf1
> 1000-103f : 0000:00:07.3
>   1000-103f : motherboard
>     1000-1003 : PM1a_EVT_BLK
>     1004-1005 : PM1a_CNT_BLK
>     1008-100b : PM_TMR
>     100c-100f : GPE0_BLK
> 1040-105f : 0000:00:07.3
>   1040-104f : motherboard
> 1060-106f : 0000:00:0f.0
> 1070-107f : 0000:00:07.1
>   1070-1077 : ide0
>   1078-107f : ide1
> 1080-10ff : 0000:00:10.0

