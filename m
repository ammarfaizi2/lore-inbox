Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131972AbRCVJo2>; Thu, 22 Mar 2001 04:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131973AbRCVJoS>; Thu, 22 Mar 2001 04:44:18 -0500
Received: from gold.MUSKOKA.COM ([199.212.175.5]:38160 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S131972AbRCVJoD>;
	Thu, 22 Mar 2001 04:44:03 -0500
Message-ID: <3AB9C53E.75D7D965@yahoo.com>
Date: Thu, 22 Mar 2001 04:26:22 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk, andre@linux-ide.org,
        linux-kernel@vger.kernel.org, Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] off-by-1 error in ide-probe (2.4.x)
In-Reply-To: <3AB47DA4.795B609B@yahoo.com> <20010318223558.L29105@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> You don't need a slow disk, it's trivial to provoke 256 sector sized
> request on even the fastest disk available. People hit it all the time,
> just with working drives...

Here is an update on the 255 vs 256 IDE issue.  As Jens said, if it
screws up on every 256, then I shouldn't have to try at all to trip
it up - a simple dd should do it (but it doesn't).  So I thought I'd
test some more & collect up the details before posting again.

Offending disk:
--------------
 Model=Maxtor 7850 AV, FwRev=OA7X5B57, SerialNo=********
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>5Mbs FmtGapReq }
 RawCHS=1654/16/63, TrkSize=0, SectSize=0, ECCbytes=11
 BuffType=3(DualPortCache), BuffSize=64kB, MaxMultSect=8, MultSect=8
 DblWordIO=yes, maxPIO=2(fast), DMA=yes, maxDMA=1(medium)
 CurCHS=1654/16/63, CurSects=1667232, LBA=yes, LBAsects=1667232
 tDMA={min:150,rec:150}, DMA modes: sword0 sword1 *sword2 *mword0
 IORDY=on/off, tPIO={min:180,w/IORDY:150}, PIO modes: mode3

System Details:
--------------
Installed as primary (and only device) on ide1, which is a VL-bus 
PIO card on 40MHz bus, booting with idebus=40, Am5x86-WT (i.e. 486)
in a Gigabyte SiS '471 chipset board. Disk tuned with "-c1 -m8 -u1".
Interface ide0 on same card has 2Gig Maxtor on it, which does not
appear to have problems (easier to show a failure happens than prove a
failure will never happen...) ide0 is not in use during failures, as
root fs is on SCSI.

Failure Cases:
--------------
My "test" at the moment consists of:
    nice -n20 make bootstrap > make.log 2>&1 & tail -f make.log
while also doing a:
    while [ 1 ]; do gunzip -vt some-7MB-o-cruft.tar.gz ; sleep 60 ; done
The GCC src & the tarball are on problem disk.  The sleep ensures the
gcc build has pushed the tarball out of the 24MB of RAM.  This then gives:

  hdc: lost interrupt
  hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }

in less than an hour (it varies of course).  The one case where I happened 
to "see" it fail, the drive LED stayed on (drive quiet, no seeks) until 
the timer fired off and printed the message(s).  Some times (3 out of 13
failures so far) I have seen the more suspect:

  hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
  ide1: unexpected interrupt, status=0x58, count=1
  hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hdc: drive not ready for command

all with the same timestamp in the syslog.  (IRQ timeout followed by
unexpected IRQ ... ???  Hrrm.)

Most times gzip will get invalid data when a failure happens, but on 
occasion random cruft has appeared in the GCC source that stops the 
build.  Forcing a re-read from the disk will return the correct data 
in both cases.  I haven't seen corrupt writes (at least none I've
detected yet...)

Compiler/Kernel:
----------------
I went back and double checked (2.4.3-pre4) breaks on 256 but works
reliably on 255.  I have confirmed this for both gcc-2.95.2 and 
gcc-2.7.2 (with appropriate workarounds for old gcc bugs) so it 
shouldn't be a compiler issue.

More interesting is that I took a bone stock 2.2.18, which still uses
MAX_SECTORS (==128) in ide-probe.c and changed that to 256.  This
caused 2.2.18 to fail in exactly the same way under the same test.
The 2.2.18 kernel without this change will complete the whole gcc
build without fail (on a 486-24MB, with gzip eating CPU, this takes
a while...)

Conclusions:
------------
I don't see this problem on any other machines, which includes some
pretty lame hardware (even an early 40MB *stepper motor* based WD IDE
seems to behave OK on 256).

So the 255 (or even the old 128) fixes things vs. 256, but I'd feel 
better being 100% sure why. (i.e. is 255 a "fix" or a perturbation that
happens to paper over something else).  If time permits, I will try
swapping hda with hdc - that will get the problem disk off of the
possibly noisy IRQ15 - and see what happens then.  If it truly is a 
one-off buggy disk, then maybe the fix is a large hammer, not a patch.

Ok, I think that is about as detailed as I can get.  Ask if I left
something out.  Commentary welcome, even an <aol> Me too! </aol>.

Paul.




