Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTDIJLx (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 05:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbTDIJLx (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 05:11:53 -0400
Received: from dsl-212-23-25-139.zen.co.uk ([212.23.25.139]:43730 "EHLO
	butternut.transitive.com") by vger.kernel.org with ESMTP
	id S262932AbTDIJLn (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 05:11:43 -0400
Message-ID: <3E93E2F2.9070409@treblig.org>
Date: Wed, 09 Apr 2003 10:08:02 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.20: / corruption on md-raid on large IDE discs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I'm having some really hairy problems on a pair of servers both 
running 2.4.20.  In both cases I'm getting really bad corruption of
/ (hundreds of files going to lost+found, files suddenly become 
inaccessible).

If it was only one box I'd blame it on RAM or the like; but its two of 
them, and I'm not sure what is happening.  Both use straight, unpatched 
2.4.20 kernels. (except a loaded driver on one box - see below).

  Lets call the boxes 'c' and 'n'.

box 'n':
P3-733MHz with 512MB of RAM and 2 x Western digital 200GB IDE drives
connected to
    2 channels of a Intel 82801BA IDE U100 motherboard controller

A pair of MD RAID1 sets gives us a root partition and a 180GB working
directory.

   It runs a SuSE 8.1 installation.

It runs as a general server (NFS, Samba, DNS, YP, squid).

Here is hda:

/dev/hda:

  Model=WDC WD2000JB-00DUA1, FwRev=02.13B02, SerialNo=WD-WMACK1575630
  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
  BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=268435455
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2
  AdvancedPM=no
  Drive Supports : Reserved : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6


---------------------------------------------------------------------
box 'c':

P3-866MHz with 768MB of RAM and 5 x Western digital 200GB IDE drives
connected to:
    1 channel of a PIIX4 82371AB on board IDE interface
    2 channels of a Promise Ultra133 TX2
    2 channels of an HPT302 controller

   (The mix of controllers was prompted by reports on lkml of people 
having problems with multiple promise controllers).

   A pair of MD RAID5 sets gives us a root partition and a big 800GB
main working directory.

   The HPT302 controller driver is built from source and loaded in an 
initrd.

   It runs a SuSE 7.2 installation.

Box 'c' previously had a set of smaller 80GB drives in (all on its
PIIX4) - but with non-RAID root and had been happy for a long time.

It runs as a backup server, rsyncing large amounts of data to it 
overnight and then streaming to tape.

Here is hdc:
/dev/hdc:

  Model=WDC WD2000JB-00DUA0, FwRev=65.13G65, SerialNo=WD-WMACK1345385
  Config={ HardSect NotMFM HdSw>15uSec SpinMotCtl Fixed DTR>5Mbs FmtGapReq }
  RawCHS=16383/16/63, TrkSize=57600, SectSize=600, ECCbytes=74
  BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
  CurCHS=4047/16/255, CurSects=16511760, LBA=yes, LBAsects=268435455
  IORDY=on/off, tPIO={min:120,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes: pio0 pio1 pio2 pio3 pio4
  DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4 udma5
  Drive Supports : ATA-1 ATA-2 ATA-3 ATA-4 ATA-5 ATA-6


------------

Both boxes originally had ext3 root filesystems.  Having suspected
ext3 I replaced the ext3 root on box 'c' with a reiser partition which
still has corruption issues.

The large partition on 'c' is reiser, the large partition on 'n' is
ext3.

So where is the problem?
   1) Could it be the MD code - but I've had no problems with it before.
   2) Some problems with the onboard IDE controllers (both Intel 
derivatives).
   3) Are there any known problems with these drives?
   4) LBA48 issues?
   5) Any known 2.4.20 issues?

We're running 2.4.20 because as far as I can tell it is the first one
that is happy with LBA48.

Any help greatfully received.

Dave

