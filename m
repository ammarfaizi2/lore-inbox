Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSIAFKs>; Sun, 1 Sep 2002 01:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSIAFKs>; Sun, 1 Sep 2002 01:10:48 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:5136 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S313181AbSIAFKq>; Sun, 1 Sep 2002 01:10:46 -0400
Date: Sun, 1 Sep 2002 00:15:12 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Andre Hedrick <andre@linux-ide.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <Pine.LNX.4.10.10208302313040.1033-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.44.0209010014100.6399-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Another update and more information on the "Linux 2.4.20-pre4-ac1 ate
my system" problem...

  Question: I am new to this mailing list; should I keep copying these
  messages to lkml or should I just pester Andre and/or Alan privately
  now?

I've been studying pdc202xx.c and anything else in the other IDE
driver source files which reference any identifier named "addressing".
I think I understand the picture better now.

The addressing field of ide_drive_t describes how the drive is to be
addressed.  Indeed, ide.h defines these values: 0= 28 bit, 1= 48 bit,
2= 48 bit doing 28 bit (a hack?) and 3=64 bit.  Also it appears that
idedisk_add_settings() defines the "address" attribute viewable from
/proc/ide/<host>/<device>/settings which shows the current value of
this field.

Notably, also in pdc202xx.c we find two places where drive->addressing
is used, once each in pdc202xx_old_ide_dma_begin() and
pdc202xx_old_ide_dma_end().  If addressing is 1 (48 bit), then extra
logic is inserted here to manipulate the hardware.  I presume this is
Alan's Promise controller LBA48 fix...

In ide-disk.c we find the function probe_lba_addressing() which
appears to be the only real place where this addressing field gets set
(I think it can also be set somehow through /proc/ide/whatever but I
doubt that's a path I should be concerned about).  There's also
set_lba_addressing() but it just does nothing but pass through to
probe_lba_addressing().  Further down in ide_disk.c we find that
idedisk_setup() calls probe_lba_addressing() with hardcoded arguments
such that it attempts to set the addressing mode to 1 (48 bit
addressing).  So far so good.  However, back in probe_lba_addressing()
there is an interesting thing going on.  It first initializes
addressing to 0 (28 bit), and then after a few checks sets it to the
requested value (second argument of the function).  One of those
checks appears to be a check of another "addressing" field which is a
member of the ide_hwif_t structure.  If _this_ addressing field is
non-zero, then the rest of probe_lba_addressing() is aborted - thus
addressing gets forced to zero (28 bit).  It seems that if
ide_hwif_t::addressing is non-zero, we force 28 bit addressing no
matter what.

Here I should point out the contents of /proc/ide/ide2/hde/settings.
When my system is running under 2.4.19-ac4 (the "good" kernel), the
"address" field is 1 - which makes sense.  I have a 160GB drive as hde
so naturally it should be addressed LBA48 style.  However, that same
field in that same file is 0 while running under 2.4.20-pre4-ac1 (the
"bad" kernel, and 2.4.20-pre5-ac1 - I checked).  So this would suggest
that my drive is being treated with 28 bit addressing, which would go
a long ways towards explaining why I'm getting the corruption.

So why is addressing being set to 0?  Yesterday Andre described a
work-around I should try.  Edit pdc202xx.c and stub out the line
matching "hwif->addressing".  That occurs in init_hwif_pdc202xx()
inside a switch statement based on chip id.  What I found was:

  hwif->addressing = (hwif->channel) ? 0 : 1

in the case for PCI_DEVICE_ID_PROMISE_20265.  Well that makes sense.
I'm on the primary channel, thus the condition is false and
hwif->addressing gets a value of 1.  That kills probe_lba_addressing()
and I'm stuck at 28 bits.  What's more, this line is not in the driver
that's part of 2.4.19-ac4 (but it's still there for the 20267 as Andre
points out).  So the advice to comment out that line makes sense.  I
killed the line, built a new kernel and tried again.

Result?

DMA is completely fubared.  As soon as the new kernel tries to read
hde's partition table, a flurry of DMA timeouts take place and the
system either hangs or falls back to PIO mode (had both cases
happen).  I have no idea why this is happening.  Ideas?

In addition to commenting out the line, I also tried forcing
hwif->addressing to 1 (no effect) and 0 (fubared DMA again).  That
result of course makes sense.

Another thing I did was to force on Alan's LBA48 fix code in
pdc202xx.c (by removing the LBA48 check).  This had no effect (still
got disk corruption).  I don't think Alan's code has anything to do
with the root cause here.

Additional things I am trying right now:

  1. Try the same experiment with 2.4.20-ac5-pre1, i.e. kill the
     hwif->addressing setting in pdc202xx.c and see if it works OK
     there.

  2. Turn off taskfile mode (CONFIG_IDE_TASKFILE_IO), comment out the
     line and see if DMA still works now.

In summary, it seems that we want ide_drive_t::addressing to be 1, but
it's currently 0.  It was 1 in 2.4.19-ac4 (where things worked).  It's
zero because of a piece of duct tape in pdc202xx.c where it recognizes
the 20265 chip and prevents the driver from enabling 48 bit mode on
the primary controller.  However if I remove that duct tape and
presumably let the addressing field go to 1, then all dma to that
device times out.

I want to solve this problem.  I know I'm probably being an annoying
pest by now, but I'm willing to try things, not just sit here and
scream "please fix this or I'll hold my breath until I turn purple".
I know very little unfortunately about IDE standards, but I can learn
quickly.  Use me to help find the cause.  I'm here.  What would you
like me to try?  Is there anything I can do?  Am I missing something
blindingly obvious?  It's happened before :-)  Am I asking too many
questions? :-)

  -Mike

                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

