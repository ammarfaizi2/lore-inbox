Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314099AbSDKPtH>; Thu, 11 Apr 2002 11:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314100AbSDKPtG>; Thu, 11 Apr 2002 11:49:06 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:54187 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S314099AbSDKPtE>;
	Thu, 11 Apr 2002 11:49:04 -0400
Date: Thu, 11 Apr 2002 17:48:27 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Martin Dalecki <dalecki@evision-ventures.com>, Jens Axboe <axboe@suse.de>,
        Martin Dalecki <martin@dalecki.de>, Vojtech Pavlik <vojtech@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: New IDE code and DMA failures
Message-ID: <20020411174827.C14999@ucw.cz>
In-Reply-To: <200204111236.g3BCaMX10247@Port.imtp.ilyichevsk.odessa.ua> <3CB57C1F.9060607@evision-ventures.com> <200204111341.g3BDfJX10546@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2002 at 04:44:29PM -0200, Denis Vlasenko wrote:
> On 11 April 2002 10:05, Martin Dalecki wrote:
> > > Since you are working on IDE subsystem, I will be glad to
> > > *retain* my flaky IDE setup and test future kernels
> > > for correct operation in this failure mode.
> > >
> > > Please inform me whenever you want me to test your patches.
> >
> > Guessing from the symptoms I would rather suggest that:
> >
> > 1. Are you sure you have the support for your chipset properly
> >     enabled? It's allmost a must for DMA.
> 
> I am deadly sure. lspci:
> 00:00.0 Host bridge: Intel Corp. 440LX/EX - 82443LX/EX Host bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corp. 440LX/EX - 82443LX/EX AGP bridge (rev 03)
> 00:04.0 ISA bridge: Intel Corp. 82371AB PIIX4 ISA (rev 01)
> 00:04.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
> 00:04.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
> 00:04.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 01)
> 00:06.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 24)
> 00:0a.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W [Millennium II]
> 00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
> 
> /boot/2.4.7/config:
> CONFIG_BLK_DEV_PIIX=y

There's new PIIX code by me in the 2.5 kernels. Can you provide
/proc/ide/piix data (and lspci -vvxxx) as well? 

> 
> > 2. Could you please report about the hardware you have. There are
> >     chipsets around there which are using theyr own transport layer
> >     implementations. host chip (aka south bridge) disk types and so on.
> 
> # hdparm -i /dev/hda
>  Model=Maxtor 51369U3, FwRev=DA620CQ0, SerialNo=EK3HAE61C
>  Config={ Fixed }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=57
>  BuffType=3(DualPortCache), BuffSize=2048kB, MaxMultSect=16, MultSect=16
>  DblWordIO=no, maxPIO=2(fast), DMA=yes, maxDMA=0(slow)
>  CurCHS=17475/15/63, CurSects=16513875, LBA=yes
>  LBA CHS=512/511/63 Remapping, LBA=yes, LBAsects=26520480
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2
>  IORDY=on/off, tPIO={min:120,w/IORDY:120}, PIO modes: mode3 mode4
>  UDMA modes: mode0 mode1 *mode2
> 
> # hdparm -i /dev/hdc
>  Model=ST31277A, FwRev=0.75, SerialNo=VAE07701
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=2482/16/63, TrkSize=0, SectSize=0, ECCbytes=4
>  BuffType=0(?), BuffSize=0kB, MaxMultSect=16, MultSect=16
>  DblWordIO=no, maxPIO=1(medium), DMA=yes, maxDMA=2(fast)
>  CurCHS=2482/16/63, CurSects=2501856, LBA=yes
>  LBA CHS=620/64/63 Remapping, LBA=yes, LBAsects=2501856
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 *mword2
>  IORDY=on/off, tPIO={min:383,w/IORDY:120}, PIO modes: mode3 mode4
> 
> I have problems with hdc. hda is mostly unused, so maybe it is DMA errors
> prone too but I have not seen that yet.
> 
> > 3. Some timeout values got increased to more generally used values (in esp.
> >     IBM microdrives advice about timeout values. Could you see whatever
> >     the data doesn't eventually go to the disk after georgeous
> >     amounts of time.
> 
> Erm.. my English comprehension fails here... do you say my disk
> does not like bigger timeouts?
> 
> > 4. Could you try to set the DMA mode lower then it's set up
> >     per default by using hdparm and try whatever it helps?
> 
> Current params:
> 
> # hdparm /dev/hda /dev/hdc
> /dev/hda:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  BLKRAGET failed: Invalid argument
>  geometry     = 1754/240/63, sectors = 26520480, start = 0
> 
> /dev/hdc:
>  multcount    = 16 (on)
>  I/O support  =  1 (32-bit)
>  unmaskirq    =  1 (on)
>  using_dma    =  1 (on)
>  keepsettings =  0 (off)
>  nowerr       =  0 (off)
>  readonly     =  0 (off)
>  BLKRAGET failed: Invalid argument
>  geometry     = 620/64/63, sectors = 2501856, start = 0
> 
> I can't quite figure what MW/UDMA mode is active.
> --
> vda

-- 
Vojtech Pavlik
SuSE Labs
