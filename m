Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbVIFI2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVIFI2a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 04:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932446AbVIFI2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 04:28:30 -0400
Received: from main.gmane.org ([80.91.229.2]:705 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932444AbVIFI23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 04:28:29 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kalin KOZHUHAROV <kalin@thinrope.net>
Subject: Re: 2.6.13 (was 2.6.11.11) and rsync oops (SATA or NFS related?)
Date: Tue, 06 Sep 2005 17:24:35 +0900
Message-ID: <dfjjp9$f7k$1@sea.gmane.org>
References: <dfg2sa$peu$2@sea.gmane.org> <dfguoq$eng$1@sea.gmane.org> <dfhjp3$fd4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: s175249.ppp.asahi-net.or.jp
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050804)
X-Accept-Language: en-us, en
In-Reply-To: <dfhjp3$fd4$1@sea.gmane.org>
X-Enigmail-Version: 0.92.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kalin KOZHUHAROV wrote:
> Kalin KOZHUHAROV wrote:
> 
>> Kalin KOZHUHAROV wrote:
>> 
>>> Hi, there. Long time no posting - didn't have kernel problems for
>>> long time :-)
[snip]
But I really hate when my "production boxes" turn into development ones...

>>> Although it does not seem very related to the drive, that is the
>>> only recent change in hardware, in software: udev . The machine
>>> (MB: A7N8X Deluxe) was working stable for 6 months with a few
>>> restarts.

A closer examination of the drive:
	(Model=ST3300831AS, FwRev=3.03, SerialNo=3NF07KA1 )
and why is it so slow revealed that it was running not in UDMA.

According to the specs:
	http://www.seagate.com/support/disc/manuals/sata/cuda72008_sata_pm.pdf
it supports (page 13 of 50):
	PIO modes 0–4
	Multiword DMA modes 0–2
	Ultra DMA modes 0–6

but hdparm gives:
# hdparm -i /dev/hdg |grep modes
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 *udma2

Where are udma3-6 gone?

Does anyone have this particular model (Barracuda 7200.8) and do you have it working properly?

Issuing `hdparm -d1 -X udma2` was accepted and looks good.
Continuing to test like that...

My other drive (on the same controller):
  Model=WDC WD360GD-00FLA0, FwRev=21.08U21, SerialNo=WD-WMAKE1163111

# hdparm -i /dev/hde |grep modes
 PIO modes:  pio0 pio1 pio2 pio3 pio4
 DMA modes:  mdma0 mdma1 mdma2
 UDMA modes: udma0 udma1 udma2 udma3 udma4 udma5 *udma6

The controller:
# lspci -s 01:0b -vv
0000:01:0b.0 RAID bus controller: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 [SATALink/SATARaid] Serial ATA Controller (rev 02)
        Subsystem: Silicon Image, Inc. (formerly CMD Technology Inc) SiI 3112 SATARaid Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 01
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at a400 [size=1024M]
        Region 1: I/O ports at a800 [size=4]
        Region 2: I/O ports at ac00 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at b400 [size=16]
        Region 5: Memory at e1001000 (32-bit, non-prefetchable) [size=512]
        Expansion ROM at 00080000 [disabled]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

>> OK, I upgraded to the latest 2.6.13 kernel and still got (similar?) oops.
>> 
>> Looking again at it it might be NFS (using v4 recently) related.
> 
> 
> After stopping nfs (both v3 and v4) and rebooting, I could finish the
>  required 170GB rsync without more oopses. But I am still not
> convinced whether this is a nfs issue or just I am being lucky this
> time. Will keep on eye on the machine and report here again.

Got one total oops, even no logs were written to disk.
Seems that rsync-ing huge amounts of data (200 GB in *many* small files) streses the system too much.

> / When nobody answers, try answering yourself :-| /
Second on that!

Kalin.

-- 
|[ ~~~~~~~~~~~~~~~~~~~~~~ ]|
+-> http://ThinRope.net/ <-+
|[ ______________________ ]|

