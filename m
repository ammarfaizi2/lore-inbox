Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbTIZTVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 15:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbTIZTVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 15:21:04 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:1035 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261590AbTIZTU5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 15:20:57 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Vojtech Pavlik <vojtech@sgo>, <mru@users.sourceforge.net>
Subject: Re: [BUG?] SIS IDE DMA errors
Date: Sat, 27 Sep 2003 03:19:37 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <yw1x7k3vlokf.fsf@users.sourceforge.net> <yw1x3cejjvdw.fsf@users.sourceforge.net> <20030926183323.GA12614@ucw.cz>
In-Reply-To: <20030926183323.GA12614@ucw.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309270319.37985.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 September 2003 02:33, Vojtech Pavlik wrote:
> On Fri, Sep 26, 2003 at 07:46:03PM +0200, M?ns Rullg?rd wrote:
> > Vojtech Pavlik <vojtech@suse.cz> writes:
> > 
> > >> > Actually, it's me who wrote the 961 and 963 support. It works fine for
> > >> > most people. Did you check you cabling?
> > >> 
> > >> I'm dealing with a laptop, but I suppose I could wiggle the cables a
> > >> bit.  I still doubt it's a cable problem, since reading works
> > >> flawlessly.
> > >
> > > Hmm, that's indeed interesting and it'd point to a driver problem -
> > 
> > See, I told you :)
> > 
> > > when reading, the drive is dictating the timing, but when writing, it's
> > > the controllers turn.
> > >
> > > So if the controller timing is not correctly programmed, reads function,
> > > but writes don't.
> > 
> > Furthermore, short writes work just fine.  The errors usually start
> > happening after about 100 MB at full speed.  When copying from NFS
> > over a 100 MB/s network it usually goes a little longer, sometimes
> > even up to 500 MB.  All this could indicate that there is some error
> > in the timing, and that it takes some time for it build up enough to
> > trigger the bad things.  Or am I wrong?
> 
> Well, yes. There's nothing to build up. There are no two timers to
> synchronize - basically the controller sends the data at a certain speed
> and the drive must be able to understand the data at that speed. So, if
> you configure the controller to UDMA133 and the drive can only do
> UDMA100, it'll fail sooner or later. It doesn't necessarily fail
> immediately, since the drive has some margin above its engineered speed
> that it'll be able to receive.
> 
> > Why can't the drive give notice when it's ready to accept more data?
> 
> It does, it does. The problem would only occur if the signalling rate
> was too high for the driver to receive it. If the drive's buffers are
> full, it'll signal the controller to delay sending, but first the data
> must reach the buffer.
> 
> > That would seem like the simple solution, instead of trying to
> > synchronize the timers.
> 
> There fortunately are no timers to be synchronized. However, you can't
> do the handshake at every single byte, that'd slow down the transfers
> considerablt.
> 
> > 
> > > Can you send me the output of 'lspci -vvxxx' of the IDE device?
> > > I'll take a look to see if it looks correct.
> > 
> > Here you go:
> 
> Thanks.
> 
> > 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
> >         Subsystem: Asustek Computer, Inc.: Unknown device 1688
> >         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
> >         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
> >         Latency: 128
> >         Region 4: I/O ports at b800 [size=16]
> > 00: 39 10 13 55 07 00 00 00 d0 80 01 01 00 80 80 00
> > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 20: 01 b8 00 00 00 00 00 00 00 00 00 00 43 10 88 16
> > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 40: 31 81 00 00 31 85 00 00 08 01 e6 51 00 02 00 02
> 
> Ok, this means:
> 
> 31 - hda: 90ns data active time, 30 ns data recovery time (PIO4)
> 41 - hda: UDMA enabled, UDMA mode 5 (UDMA100)
> 00 - hdb: 240ns/360ns (PIO0) - no drive present
> 00 - hdb: UDMA disabled
> 31 - hdc: 90ns/30ns PIO4
> 85 - hdc: UDMA enabled, UDMA mode 2 (UDMA33)
> 00 - hdd: 240ns/360ns (PIO0) - no drive present
> 00 - hdd: UDMA disabled
> 
> So the config is correct if you have /dev/hda your harddrive, that's
> capable of UDMA100 and /dev/hdc a CDROM and capable of UDMA33. Is that
> right?
> 
> 08 - 80-wire cables (needed for UDMA44 and higher) NOT installed.
>      FIFO threshold set to 3/4 for read and to 1/4 for write.
> 
> 01 - IDE controller in compatibility mode. Native and test modes
>      disabled. (normal)
> 
> e6 - PCI burst enable, EDB R-R pipeline enable, Fast postwrite enable,
>      device ID masqueraded as sis5513 (although real is 5517)
>      channels 0 and 1 enabled in normal mode
> 
> 51 - Postwrite enabled on hda and hdc, prefetch on hda only
> 
> 00 02 - 512 bytes prefetch size for hda
> 00 02 - 512 bytes prefetch size for hdc
> 
> All this is OK, possibly except for the 80-wire cable not being present,
> but if this is a notebook, there might be a completely different cable
> type than what's standard, and the detection might not work there.
> 
> > 50: 01 00 01 06 00 00 00 00 00 00 00 00 00 00 00 00
> > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> > >> It appears to me that during heavy IO load, some DMA interrupts get
> > >> lost, for some reason.
> > >
> > > Well, I've got this feeling that not just IDE interrupts get lost under
> > > heavy IO load with recent kernels ...
> > 
> > Like mouse and keyboard...
> 
> Like everything. But only for mouse, keyboard, timer and ide it HURTS.
> 
> -- 
> Vojtech Pavlik
> SuSE Labs, SuSE CR
> 
> 

Was running 2.4.22.

Now running 2.6.0-test5. Fresh boot.

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e000 [size=256]
        Region 1: Memory at eb102000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: ec 10 39 81 07 00 90 02 10 00 00 02 00 20 00 00
10: 01 e0 00 00 00 20 10 eb 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 ec 10 39 81
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 20 40
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I am surprised at your analysis of the pci bus data. By what you
stated my drive(r) should be doing PIO ;)

50: 01 00 c2 f7 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.36 seconds =352.67 MB/sec
 Timing buffered disk reads:  64 MB in  1.20 seconds = 53.25 MB/sec
[root@mhfl4 03:10:20 mhf]# v ht

/dev/hda:
 Timing buffer-cache reads:   128 MB in  0.37 seconds =346.00 MB/sec
 Timing buffered disk reads:  64 MB in  1.20 seconds = 53.21 MB/sec

It does 53MB/s and by earlier drive info as mailed drive reports set to udma5.

Regards
Michael

 







