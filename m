Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWDCMdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWDCMdM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 08:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWDCMdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 08:33:12 -0400
Received: from smtpout.mac.com ([17.250.248.70]:43460 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751625AbWDCMdL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 08:33:11 -0400
In-Reply-To: <200604031135.k33BZ10b028599@harpo.it.uu.se>
References: <200604031135.k33BZ10b028599@harpo.it.uu.se>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A3D48486-67A2-4392-A062-22C3B60AC7A7@mac.com>
Cc: alan@lxorguk.ukuu.org.uk, edmudama@gmail.com, hahn@physics.mcmaster.ca,
       hancockr@shaw.ca, jujutama@comcast.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RESEND][2.6.15] New ATA error messages on upgrade to 2.6.15
Date: Mon, 3 Apr 2006 08:32:43 -0400
To: Mikael Pettersson <mikpe@it.uu.se>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 3, 2006, at 07:35:01, Mikael Pettersson wrote:
> PDC20269: IDE controller at PCI slot 0000:00:0e.0
> PDC20269: chipset revision 2
> PDC20269: ROM enabled at 0x81804000
> PDC20269: 100% native mode on irq 24
>     ide2: BM-DMA at 0x0880-0x0887, BIOS settings: hde:pio, hdf:pio
>     ide3: BM-DMA at 0x0888-0x088f, BIOS settings: hdg:pio, hdh:pio

Looks like the controller ends up in the same initial state as mine.   
After playing with hdparm a bit, I've determined that my /dev/hdg  
(Maxtor disk on the PDC20268) comes up in udma4 and falls back to  
udma3 after a few CRC errors.  It appears that the /dev/hdi (Samsung  
disk on the PDC20268) comes up in an indeterminate udma state and  
falls back to a lower DMA state after a few CRC errors.  At some  
point later the MULTWRITE_EXT problem triggers DMA timeouts and the  
kernel falls back to PIO.  I can reenable DMA with "hdparm -d1 /dev/ 
hdi" and it will come back in udma2 mode, but it refuses to go  
higher, giving these errors:
   hdi: dma_timer_expiry: dma status == 0x21
   hdi: DMA timeout error
   hdi: dma timeout error: status=0xd0 { Busy }
   ide: failed opcode was: unknown
   hdi: DMA disabled
   PDC202XX: Secondary channel reset.
   ide4: reset: success
And at this point it falls back to udma2 again.  Both card and drive  
should support UDMA4 (ATA100?)

> hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
> ide: failed opcode was: unknown
> PDC202XX: Primary channel reset.
> ide2: reset: success

You get the exact same reset I do on the bad CRCs.  When this happens  
the udma level is lowered by 1 on my system.

> /dev/hde:
>
>  Model=IBM-DTLA-307030, FwRev=TX4OA6AA, SerialNo=YKEYKTTY645
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
>  BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=off
>  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=60036480
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
>  PIO modes:  pio0 pio1 pio2 pio3 pio4
>  DMA modes:  mdma0 mdma1 mdma2
>  UDMA modes: udma0 udma1 udma2 udma3 *udma4 udma5

My card and Maxtor drive refuse to run in udma4 mode, although I know  
the card and drive support it.  The CRC errors on the Maxtor always  
trigger a fallback to udma3.

> 00:0e.0 Unknown mass storage controller: Promise Technology, Inc.  
> 20269 (rev 02) (prog-if 85)
> 	Subsystem: Promise Technology, Inc. Ultra133TX2
> 	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
> ParErr- Stepping- SERR- FastB2B-
> 	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-  
> <TAbort- <MAbort- >SERR- <PERR-
> 	Latency: 32 (1000ns min, 4500ns max), Cache Line Size 08
> 	Interrupt: pin A routed to IRQ 24
> 	Region 0: I/O ports at fe0008c0 [size=8]
> 	Region 1: I/O ports at fe0008b0 [size=4]
> 	Region 2: I/O ports at fe0008a0 [size=8]
> 	Region 3: I/O ports at fe000890 [size=4]
> 	Region 4: I/O ports at fe000880 [size=16]
> 	Region 5: Memory at 0000000081808000 (32-bit, non-prefetchable)  
> [size=16K]
> 	Expansion ROM at 0000000081804000 [size=16K]
> 	Capabilities: [60] Power Management version 1
> 		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME 
> (D0-,D1-,D2-,D3hot-,D3cold-)
> 		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
> 00: 5a 10 69 4d 07 00 30 04 02 85 80 01 08 20 00 00
> 10: c1 08 00 00 b1 08 00 00 a1 08 00 00 91 08 00 00
> 20: 81 08 00 00 00 80 80 81 00 00 00 00 5a 10 68 4d
> 30: 01 40 80 81 60 00 00 00 00 00 00 00 18 01 04 12

My controller looks like this:
0001:11:02.0 Mass storage controller: Promise Technology, Inc.  
PDC20268 (Ultra100 TX2) (rev 02) (prog-if 85)
         Subsystem: Promise Technology, Inc.: Unknown device ad68
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-  
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=slow  
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 16 (1000ns min, 4500ns max), Cache Line Size: 0x08  
(32 bytes)
         Interrupt: pin A routed to IRQ 52
         Region 0: I/O ports at f2001440 [size=8]
         Region 1: I/O ports at f2001430 [size=4]
         Region 2: I/O ports at f2001420 [size=8]
         Region 3: I/O ports at f2001410 [size=4]
         Region 4: I/O ports at f2001400 [size=16]
         Region 5: Memory at 800a0000 (32-bit, non-prefetchable)  
[size=64K]
         Expansion ROM at 80090000 [disabled] [size=64K]
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME 
(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 5a 10 68 4d 07 00 30 04 02 85 80 01 08 10 00 00
10: 41 14 00 00 31 14 00 00 21 14 00 00 11 14 00 00
20: 01 14 00 00 00 00 0a 80 00 00 00 00 5a 10 68 ad
30: 01 00 09 80 60 00 00 00 00 00 00 00 34 01 04 12

Thanks for the help!

Cheers,
Kyle Moffett

