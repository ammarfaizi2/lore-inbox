Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRTVQ>; Mon, 18 Dec 2000 14:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbQLRTVG>; Mon, 18 Dec 2000 14:21:06 -0500
Received: from aragorn.ics.muni.cz ([147.251.4.33]:39059 "EHLO
	aragorn.ics.muni.cz") by vger.kernel.org with ESMTP
	id <S129391AbQLRTUx>; Mon, 18 Dec 2000 14:20:53 -0500
Newsgroups: cz.muni.redir.linux-kernel
Path: news
From: Zdenek Kabelac <kabi@fi.muni.cz>
Subject: Problem with UDMA 4 - deadlocking machine
Message-ID: <3A3E5BF2.4F72EED4@fi.muni.cz>
Date: Mon, 18 Dec 2000 18:48:18 GMT
To: andre@linux-ide.org, linux-abit@geek.net, morton@uow.edu.au
X-Nntp-Posting-Host: dual.fi.muni.cz
Content-Transfer-Encoding: 7bit
X-Accept-Language: Czech, en
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <Pine.GSO.3.96.1001218174625.26395B-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
Organization: unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Last Saturday I've spent some time on testing deadlock which bites me
for a
long time on my BP6 SMP board (practically since I've started to use
ATA66
controller). Before you will stop reading and saying I should buy a
different
board please try to continue for a few moments. (its a bit longer - but
I think
there are few interesting points)

First I'll describe my hw configuration - BP6 128MB 2x400MHz CPU
(usually running @92MHz FSB - ~560MHz)
Cards: SBLive slot 2, TV-Phone98 slot 5, G400Max AGP
Hard drives: 6GB Western on UDMA33 (contains only vfat partitions),
             CD-ROM Ricoh 9060A UDMA33,
             30GB IBM UDMA66 hpt366 (contains only ext2 partitions).
There are no shared interrupts in /proc/interrupts.

hdparm gives me around 34MB/s for UDMA66 drive and 8MB/s for WD6GB
drive.

For testing I've used the following simple sequence:

I've created 650MB file on UDMA66 drive and I've been copying this file
to UDMA33 vfat partition.
(while : ; do cp /ext2/my650 /vfat/  ; md5sum /vfat/my650 ; done)

When this test was running correctly for 6 times I've considered it
stable.

Kernel used for testing has been CLEAN UNPATCHED 2.4.0-test12
(with SMP, and without SMP support)

Here are some initial results:

After reboot and running this on console - everything was OK starting
the X
server and not doing anything else in them (e.g. moving mouse) - again
everything was OK.

And now to the less positive part - as soon as I've turned on programs
which are using SBLive or TV card the locking had begun.

After a while I've came with conclusion it doesn't matter if it's just
emu10k1
driver or bttv driver or both of them running at same time - simply when
one or
both of them were running I've been unable to copy the file from UDMA66
to
UDMA33 (test usually occurred after 200MB has been copied).

For the huge amount of tested environment I've used just fbtv and linux
matrox
framebuffer console with just bttv as this was usually to the fastest
way to
deadlock.

For the testings I've flashed around 9 different BP6 bioses (always
cleaning
all the BIOS settings) - LP, NJ, QQbeta, QQ-2, and couple of RU bioses -
usually I'm using ru with htp 1.26 Also I've been checking
non-overclocked &
overclocked setup with each BIOS.

After few hours the clear result was:

Linux kernel with SMP or without SMP ALWAYS locks during this test - it
has
never finished more then 1 copy of this file - and the crash is always
complete
deadlock - but the console says something about hdf: lost interrupt
first - but
I've already reported this and no one seems to care. (I'll repeat - I've
used
all known to me Bioses & correctly clocked CPU for this test and it had
always
failed)

So I've came to conclusion that there could be several possible
problems:

UDMA 4 mode is not correctly programmed for hpt366 controller (as the
only one
who seems to understand the setting for this chipset is Andre itself, I
afraid
that he is the only one who could play with them and possible fix)

UDMA 4 mode is incorrectly programmed and it doesn't take into account
that
some other interrupt services might lock the system bus for a while
(again this
is for Andre Hedrick probably) (I've also noticed few other peoples
comlaing
about some problems while copying huge files - and they didn't have BP6
board,
so maybe its some more general problem)

BP6 hpt366 is completely bad piece of hardware (I hope it's not that
bad)

Ok after this - I've also found some partial solution for this problem
which is
relatively easy - degrading hpt366 from UDMA 4 to UDMA 2 with 'hdparm
-X66
/dev/hdf' - after issuing this command all my test had never failed (8
copies
without any problems while playing TV and mp3 files with xmms) (btw is
there
some way I could turn it back to UDMA 4 mode ??)

So hpt366 & linux could coexists peacefully they just can't use UDMA4
mode.
I've also run this test with both drives on UDMA33 controllers - again
without
a single problem.

So that's probably all I wanted to say - so maybe some advice for BP6
users -
if they want to have stable system - they should probably not use UDMA 4
mode
(-X66 for hpt366 or just ignore UDMA66 controller at all - especially if
you
are using devices which generates a lot of interrupts - like sound
cards, tv
card, network cards :)

And strange note for the end - I had usually problems even to boot the
machine
when it has not been overclocked and it was running with 66MHz FSB speed
-
however this "hdf: lost interrupt" message has not lead to deadlock of
machine
(deadlock means for me that computer doesn't react even to Magic SysRq)
- after
a few messages about the lost interrupts the system has turned off DMA
and was
continuing with boot process however using computer with just 3MB/s
throughput
is not that funny (also there were no APIC error with 66 FSB). This boot
problem has never happened to me while running with 92MHz FSB even
though APIC
errors makes console practically unusable.

I think this letter is already way to long - so now I'm curios
if this will be helpful for anyone....

-- 
             There are three types of people in the world:
               those who can count, and those who can't.
  Zdenek Kabelac  http://i.am/kabi/ kabi@i.am {debian.org; fi.muni.cz}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
