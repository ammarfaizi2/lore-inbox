Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280934AbRKLS7Z>; Mon, 12 Nov 2001 13:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280939AbRKLS7Q>; Mon, 12 Nov 2001 13:59:16 -0500
Received: from sttldslgw16poolA74.sttl.uswest.net ([63.231.36.74]:27995 "EHLO
	jerry-garcia.accessgroupinc.com") by vger.kernel.org with ESMTP
	id <S280930AbRKLS7G>; Mon, 12 Nov 2001 13:59:06 -0500
Date: Mon, 12 Nov 2001 10:58:17 -0800
Message-Id: <200111121858.KAA11594@jerry-garcia.accessgroupinc.com>
From: Bob Ramstad <rramstad@alum.mit.edu>
To: hahn@physics.mcmaster.ca
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE SiS730 / SiS5513 incorrect defaults kernel 2.4.9
In-Reply-To: <Pine.LNX.4.10.10111121309370.31731-100000@coffee.psychology.mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   > We downgraded back to 2.4.3-12 and eventually installed RedHat 7.2 on
   > that system which contained kernel 2.4.7-10.  Again, no problems.
   > When we upgraded to 2.4.9-13, the problem recurred.  I've included our
   > system log below from rebooting the machine this morning.

   /proc/ide/sis* would probably be more informative.  the main question
   is: what mode do the disks run in when working?

The disks seem to run fine in ATA100 / UDMA5 once the parameters are
set from rc.sysinit but errors occur in the booting process when these
parameters have not yet been set.

I've only included output below for hdb as hdc is virtually identical
in behavior.

I am making the assumption that the hdparm output below confirms that
the disk in question is running in ATA100 / UDMA5 mode.  If that
assumption is incorrect, please tell me.

[root@accessgroupinc log]# hdparm /dev/hdb

/dev/hdb:
 multcount    = 16 (on)
 I/O support  =  3 (32-bit w/sync)
 unmaskirq    =  1 (on)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 nowerr       =  0 (off)
 readonly     =  0 (off)
 readahead    =  8 (on)
 geometry     = 5005/255/63, sectors = 80418240, start = 0
[root@accessgroupinc log]# hdparm -i /dev/hdb

/dev/hdb:

 Model=IC35L040AVER07-0, FwRev=ER4OA44A, SerialNo=SXPTXTB3920
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=40
 BuffType=DualPortCache, BuffSize=1916kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=-66060037, LBA=yes, LBAsects=80418240
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
 AdvancedPM=yes: disabled (255)
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-2 ATA-3 ATA-4 ATA-5
[root@accessgroupinc log]# cat /proc/ide/sis
--------------- Primary Channel ---------------- Secondary Channel -------------
Channel Status: On                               On
Operation Mode: Compatible                       Compatible
Cable Type:     80 pins                          80 pins
Prefetch Count: 512                              512
Drive 0:        Postwrite Disabled               Postwrite Enabled
                Prefetch  Disabled               Prefetch  Enabled
                UDMA Disabled                    UDMA Enabled
                UDMA Cycle Time    2 CLK         UDMA Cycle Time    2 CLK
                Data Active Time   8 PCICLK      Data Active Time   2 PCICLK
                Data Recovery Time 12 PCICLK     Data Recovery Time 1 PCICLK
Drive 1:        Postwrite Enabled                Postwrite Disabled
                Prefetch  Enabled                Prefetch  Disabled
                UDMA Enabled                     UDMA Disabled
                UDMA Cycle Time    2 CLK         UDMA Cycle Time    2 CLK
                Data Active Time   2 PCICLK      Data Active Time   8 PCICLK
                Data Recovery Time 1 PCICLK      Data Recovery Time 12 PCICLK
[root@accessgroupinc log]# cat /etc/sysconfig/harddiskhdb
# These options are used to tune the hard drives -
# read the hdparm man page for more information

# Set this to 1 to enable DMA. This might cause some
# data corruption on certain chipset / hard drive
# combinations. This is used with the "-d" option

USE_DMA=1

# Multiple sector I/O. a feature of most modern IDE hard drives,
# permitting the transfer of multiple sectors per I/O interrupt,
# rather than the usual one sector per interrupt.  When this feature
# is enabled, it typically reduces operating system overhead for disk
# I/O by 30-50%.  On many systems, it also provides increased data
# throughput of anywhere from 5% to 50%.  Some drives, however (most
# notably the WD Caviar series), seem to run slower with multiple mode
# enabled. Under rare circumstances, such failures can result in
# massive filesystem corruption. USE WITH CAUTION AND BACKUP.
# This is the sector count for multiple sector I/O - the "-m" option
#
# MULTIPLE_IO=16

# (E)IDE 32-bit I/O support (to interface card)
#
EIDE_32BIT=3

# Enable drive read-lookahead
#
#LOOKAHEAD=1

# Add extra parameters here if wanted
# On reasonably new hardware, you may want to try -X66, -X67 or -X68
# Other flags you might want to experiment with are -u1, -a and -m
# See the hdparm manpage (man hdparm) for details and more options.
#
EXTRA_PARAMS="-u1 -X69"

   > Let me note a few things which may be of interest.  We had been
   > getting these errors on and off as the system ran i.e. we'd see errors
   > every hour or two.  From some experimentation, I created
   > /etc/sysconfig/harddiskhd{b,c} to be ran from /etc/rc.sysinit and do
   > the equivalent of
   > 
   > /sbin/hdparm -d1 -u1 -c3 -X69 /dev/hdb
   > /sbin/hdparm -d1 -u1 -c3 -X69 /dev/hdc

   this kind of hdparm tweaking should be unnecessary for 2.4.

I agree 100% but without setting the parameters via rc.sysinit I get
errors over and over.  By setting them manually, the system runs fine
after that point.

   > Nov 12 09:34:39 accessgroupinc kernel: SIS5513: IDE controller on PCI bus 00 dev 01

   is it true that the earlier/working kernels also loaded this driver?
   it's possible they didn't, which means they'd be working with the default,
   non-chipset-specific driver, and therefore be limited to mword-dma2.

Interesting.  Certainly possible.  I don't have the old syslogs
available, but from a bug that was filed directly with RedHat back on
Oct 22 (with no response) I noted that 2.4.9-6 identifies the disks as
UDMA100 while 2.4.3-12 identifies the disks as (U)DMA.

   > Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: status=0x51 { DriveReady SeekComplete Error }
   > Nov 12 09:34:41 accessgroupinc kernel: hdb: dma_intr: error=0x84 { DriveStatusError BadCRC }
   > Nov 12 09:34:41 accessgroupinc kernel: ide0: reset: master: error (0x0a?)

   the code may be somewhat confused by the presence of a master-less slave.

Again, certainly possible.  I would mention that hdc is a secondary
master with no slave and it also experiences the CRC errors... though
there are no problems with ide1 bus reset.

In brief, the issues seem to be:

1) What initial mode settings does the driver attempt to use which
   lead to the errors in the boot process?

2) How do these mode settings differ from the manual settings which
   appear to work?

3) Is there a simple way to either correct the driver code so it
   chooses more appropriate initial settings, or to manually let the
   driver know the appropriate settings earlier in the boot process?

Suppose for a minute I did have bad cables and shouldn't be running
UDMA5/ATA100... how would I communicate this to the driver so that it
chose the proper settings the first time so that errors did not occur?

If the answer is "don't bother, the driver will automatically reduce
the DMA mode over time when it sees errors, and file corruption isn't
an issue", well, that's fine, but I've been going on the assumption
that CRC errors could lead to corruption and that I need to fix this.

I'm happy to take whatever steps anyone would like in regards to
debugging this problem.

-- Bob

