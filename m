Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129440AbRCFTwW>; Tue, 6 Mar 2001 14:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129446AbRCFTwN>; Tue, 6 Mar 2001 14:52:13 -0500
Received: from pollux.cse.Buffalo.EDU ([128.205.35.2]:21753 "EHLO
	pollux.cse.Buffalo.EDU") by vger.kernel.org with ESMTP
	id <S129440AbRCFTv7>; Tue, 6 Mar 2001 14:51:59 -0500
Date: Tue, 6 Mar 2001 14:51:34 -0500 (EST)
From: Jason Rappleye <rappleye@cse.Buffalo.EDU>
To: linux-kernel@vger.kernel.org
cc: andre@linux-ide.org, jonesm@ccr.buffalo.edu
Subject: [RECAP] timeout waiting for DMA
In-Reply-To: <Pine.GSO.4.21.0102261526330.15135-100000@pollux.cse.Buffalo.EDU>
Message-ID: <Pine.GSO.4.21.0103061427450.6843-100000@pollux.cse.Buffalo.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'd like to thank those who responded to my message. Here's a recap of the
suggestions and results. My original email appears at the end. For those
of you that are getting errors that look like this:

kernel: hda: timeout waiting for DMA 
kernel: ide_dmaproc: chipset supported ide_dma_timeout func only: 14 
kernel: hda: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
kernel: hda: DMA disabled

PLEAE read this and try the suggestions listed before posting here
again. I'm sure it'll save everyone some time and give the developers more
valuable feedback than "it doesn't work."

-Mark Hahn <hahn@coffee.psychology.mcmaster.ca> :

> Andre says that the problem is that (apparently all) ide busmaster
> engines share a common flaw: when they starve for PCI access,
> they glitch.  resetting them is the only solution, and in his latest
> patches, he has code that does this (without losing the use-dma bit).

So I applied ide.2.4.1-p8-01172001 to 2.4.2, with a reject in the hpt
source, which _I_ didn't care about (we have Serverworks boards) and
enabled the "Attempt to HACK around chipsets that TIMEOUT" option (under
ATA works in progress). This didn't work for me. YMMV.

-Jasmeet Sidhu <jsidhu@arraycomm.com>
> Iv'e seen this on a system with 36" IDE ata/100 cables.  I have the same 
> exact system using 24" IDE ultra ata/100 cables and I get no such 
> errors.  These two systems are exactly the same and are using the same 
> drivers, same hardware.
> The only difference is the type of cable used.  Could this be due to bad 
> cables as well?  (I know tha CRC errors are caused by bad cables, but
> this is the only difference in the two boxes that I have).

> Keep the cables as short as possible, 18" is supposed to be the limit.

Our cables are ~ 12" long, and are sliced up every 5 lines or so to fit
"neatly" in our 1U cases. So I don't think this is contributing to the
problem, at least not in our case. Still, a good thing to check.

-Daniela Engert <dani@ngrt.de>

> Reduce the IDE channel speed to UltraDMA mode 1 or less.

Both with and without Andre's patch, udma mode 1 and 0 both exhibited the
same problem. However, switching to mulitword DMA 2 (hdparm -X34 /dev/hdX) 
worked just fine WITH Andre's patch. Without the patch we still experienced 
the problem. Hmm...I just got an email saying that the new BIOS for our
machines disables udma in lieu of PIO mode 4 because it "doesn't work" on
our boards (Serverworks LE III chipset). Great. So you might have better
luck with udma 1 and 0 than we are. 

So, at the moment, _I_ personally suggest a) applying Andre's latest ide
patch, b) trying a lower udma setting or multiword 2 DMA, and c) checking
your cables. You're not really "losing" performance by dropping down to a
different udma mode or mword2, since it's certainly better than pio 4 :-)

Andre, I can replicate this behavior 100% of the time, if you need someone
to do testing let me know, I'm more than happy to help out in any way I
can. Though I might not be a good candidate due to the damn Serverworks
chipset :-(

Hope this helps,

j

On Mon, 26 Feb 2001, Jason Rappleye wrote:

> 
> Hi,
> 
> I'm running kernel 2.4.2 on an SGI 1100 (dual PIIIs) with a Serverworks
> III LE based motherboard. The disk is a Seagate ST330630A. The disk has
> DMA enabled at boot time :
> 
> hda: ST330630A, ATA DISK drive
> hda: 59777640 sectors (30606 MB) w/2048KiB Cache, CHS=3720/255/63, UDMA(33)
> 
> (also verified using hdparm)
> 
> but after a while (eg partway through running bonnie with a 1GB file) I
> get the following errors:
> 
> Feb 24 22:51:02 nash2 kernel: hda: timeout waiting for DMA 
> Feb 24 22:51:02 nash2 kernel: ide_dmaproc: chipset supported ide_dma_timeout 
> func only: 14 
> Feb 24 22:51:02 nash2 kernel: hda: irq timeout: status=0x58 { DriveReady
> SeekComplete DataRequest }
> <repeats a few times>
> Feb 24 22:51:32 nash2 kernel: hda: DMA disabled
> 
> I can reenable DMA without any problems, but after some additional disk
> activity (eg running bonnie again), the error occurs again. 
> 
> Additional information on my hardware is given below. Any suggestions on
> how this can be resolved?
> 
> Thanks,
> 
> Jason
> 
> hdparm -i /dev/hda
> 
> /dev/hda:
> 
>  Model=ST330630A, FwRev=3.21, SerialNo=3CK0JDFE
>  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
>  RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
>  BuffType=0(?), BuffSize=2048kB, MaxMultSect=16, MultSect=off
>  DblWordIO=no, OldPIO=2, DMA=yes, OldDMA=2
>  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=59777640
>  tDMA={min:120,rec:120}, DMA modes: mword0 mword1 mword2 
>  IORDY=on/off, tPIO={min:240,w/IORDY:120}, PIO modes: mode3 mode4 
>  UDMA modes: mode0 mode1 *mode2 mode3 mode4 
> 
> Relevant portion of /proc/pci:
> 
>   Bus  0, device  15, function  1:
>     IDE interface: PCI device 1166:0211 (ServerWorks) (rev 0).
>       Master Capable.  Latency=64.  
>       I/O at 0x3080 [0x308f].
> 
> Relevant portion of lspci -v:
> 
> 00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a
> [Master SecP PriP])
> 	Flags: bus master, medium devsel, latency 64
> 	I/O ports at 3080 [size=16]
> 
> 
> --
> Jason Rappleye
> rappleye@buffalo.edu		
> http://www.ccr.buffalo.edu/jason.htm
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

--
Jason Rappleye
rappleye@buffalo.edu		
http://www.ccr.buffalo.edu/jason.htm









