Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274824AbRIUUqj>; Fri, 21 Sep 2001 16:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274825AbRIUUqa>; Fri, 21 Sep 2001 16:46:30 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28087 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S274824AbRIUUqW>; Fri, 21 Sep 2001 16:46:22 -0400
Date: Fri, 21 Sep 2001 16:43:04 -0400
From: Greg Ward <gward@python.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: bugs@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: "hde: timeout waiting for DMA": message gone, same behaviour
Message-ID: <20010921164304.A545@gerg.ca>
In-Reply-To: <20010921134402.A975@gerg.ca> <20010921205356.A1104@suse.cz> <20010921150806.A2453@gerg.ca> <20010921154903.A621@gerg.ca> <20010921215622.A1282@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010921215622.A1282@suse.cz>; from vojtech@suse.cz on Fri, Sep 21, 2001 at 09:56:22PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 September 2001, Vojtech Pavlik said:
> There were updates in 2.4.9-pre2 in the VIA driver, so it might be worth
> trying. Also disabling CONFIG_IDEDMA_AUTO may work, but you'll get slow
> performance.

OK, I've just rebooted with CONFIG_IDEDMA_AUTO not set.  Same thing
happens; kernel prints "hde: timeout waiting for DMA" at boot time,
"hdparm /dev/hde" reports DMA on, and "dd if=/dev/hde of=/dev/null
count=1" takes about 20 sec to complete.  (Hmmm: in previous builds,
the kernel would turn DMA off for me after that long DMA timeout delay.
It no longer does so.  If I "hdparm -d0 /dev/hde", then there's no
long delay on read.)

> Afterwards, though, you can do hdparm -i /dev/hd*

cthulhu:~# hdparm -i /dev/hde

/dev/hde:

 Model=ST380021A, FwRev=3.05, SerialNo=3HV03HSB
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=156301488
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 

> and cat /proc/ide/via

OK, but the VIA controller is ide0 and ide1, which are unused -- nothing
is connected to either one.  The only IDE device in the system right now
is the brand-new Seagate 80 GB ATA/100 drive at hde1 (on ide2, which is
controlled by the Promise chip).  So here's the kernel's picture of both
the VIA and Promise controllers:

cthulhu:~# cat /proc/ide/via 
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.23
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0xd800
PCI clock:                          33MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:      120ns     120ns     120ns     120ns
Cmd Active:         480ns     480ns     480ns     480ns
Cmd Recovery:       480ns     480ns     480ns     480ns
Data Active:        330ns     330ns     330ns     330ns
Data Recovery:      270ns     270ns     270ns     270ns
Cycle Time:         600ns     600ns     600ns     600ns
Transfer Rate:    3.3MB/s   3.3MB/s   3.3MB/s   3.3MB/s
cthulhu:~# cat /proc/ide/pdc202xx 

                                PDC20265 Chipset.
------------------------------- General Status ---------------------------------
Burst Mode                           : enabled
Host Mode                            : Normal
Bus Clocking                         : 33 PCI Internal
IO pad select                        : 10 mA
Status Polling Period                : 0
Interrupt Check Status Polling Delay : 0
--------------- Primary Channel ---------------- Secondary Channel -------------
                enabled                          enabled 
66 Clocking     enabled                          disabled
           Mode PCI                         Mode PCI   
                FIFO Empty                       FIFO Empty  
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------
DMA enabled:    no               yes             no                no 
DMA Mode:       UDMA 4           NOTSET          NOTSET            NOTSET
PIO Mode:       PIO 4            NOTSET           NOTSET            NOTSET

> which will tell us interesting information, which may
> lead us further to solving the problem.

Well, I hope it means something to you!  

> Btw, what clock and multiplier
> your CPU is?

800 MHz Athlon.  Not sure what the multiplier is -- I don't mess with
that stuff.

        Greg
-- 
Greg Ward - Unix bigot                                  gward@python.net
http://starship.python.net/~gward/
The world is coming to an end.  Please log off.
