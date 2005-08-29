Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbVH2TzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbVH2TzB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 15:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbVH2TzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 15:55:01 -0400
Received: from sigma957.CIS.McMaster.CA ([130.113.64.83]:41966 "EHLO
	sigma957.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S1751481AbVH2TzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 15:55:00 -0400
Date: Mon, 29 Aug 2005 15:54:47 -0400 (EDT)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: Holger Kiehl <Holger.Kiehl@dwd.de>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <Pine.LNX.4.61.0508291811480.24072@diagnostix.dwd.de>
Message-ID: <Pine.LNX.4.44.0508291530310.14200-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version-Mac: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.8.29.24
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>      8 SCSI U320 (15000 rpm) disks where 4 disks (sdc, sdd, sde, sdf)

figure each is worth, say, 60 MB/s, so you'll peak (theoretically) at 
240 MB/s per channel.

> The U320 SCSI controller has a 64 bit PCI-X bus for itself, there is no other
> device on that bus. Unfortunatly I was unable to determine at what speed
> it is running, here the output from lspci -vv:
...
>                  Status: Bus=2 Dev=4 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple,

the "133MHz+" is a good sign.  OTOH the latency (72) seems rather low - my
understanding is that that would noticably limit the size of burst transfers.

> Anyway, I thought with this system I would get theoretically 640 MB/s using
> both channels.

"theoretically" in the same sense as "according to quantum theory,
Bush and BinLadin may swap bodies tomorrow morning at 4:59."

> write speeds for this system. But testing shows that the absolute maximum I
> can reach with software raid is only approx. 270 MB/s for writting. Which is
> very disappointing.

it's a bit low, but "very" is unrealistic...

> deadline and distribution is fedora core 4 x86_64 with all updates. Chunksize
> is always the default from mdadm (64k). Filesystem was always created with the
> command mke2fs -j -b4096 -O dir_index /dev/mdx.

bear in mind that a 64k chunksize means that an 8 disk raid5 will really
only work well for writes that are multiples of of 7*64=448K...

> I also have tried with 2.6.13-rc7, but here the speed was much lower, the
> maximum there was approx. 140 MB/s for writting.

hmm, there should not have been any such dramatic slowdown.

> Version  1.03        ------Sequential Output------ --Sequential Input- --Random-
>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
> Machine         Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
> Raid0 (8 disk)15744M 54406  96 247419 90 100752 25 60266  98 226651 29 830.2   1
> Raid0s(4 disk)15744M 54915  97 253642 89 73976  18 59445  97 198372 24 659.8   1
> Raid0s(4 disk)15744M 54866  97 268361 95 72852  17 59165  97 187183 22 666.3   1

you're obviously saturating something already with 2 disks.  did you play
with "blockdev --setra" setings?

> Raid5 (8 disk)15744M 55881  98 153735 51 61680  24 56229  95 207348 44 741.2   1
> Raid5s(4 disk)15744M 55238  98 81023  28 36859  14 56358  95 193030 38 605.7   1
> Raid5s(4 disk)15744M 54920  97 83680  29 36551  14 56917  95 185345 35 599.8   1

the block-read shows that even with 3 disks, you're hitting ~190 MB/s,
which is pretty close to your actual disk speed.  the low value for block-out
is probably just due to non-stripe writes needing R/M/W cycles.

> /dev/sdc      15744M 53861  95 102270 35 25718   6 37273  60 76275   8 377.0   0

the block-out is clearly distorted by buffer-cache (too high), but the 
input rate is good and consistent.  obvoiusly, it'll fall off somewhat 
towards inner tracks, but will probably still be above 50.

> Why do I only get 247 MB/s for writting and 227 MB/s for reading (from the
> bonnie++ results) for a Raid0 over 8 disks? I was expecting to get nearly
> three times those numbers if you take the numbers from the individual disks.

expecting 3x is unreasonable; 2x (480 or so) would be good.

I suspect that some (sw kernel) components are badly tuned for fast IO.
obviously, most machines are in the 50-100 MB/s range, so this is not
surprising.  readahead is certainly one, but there are also magic numbers
in MD as well, not to mention PCI latency, scsi driver tuning, probably
even /proc/sys/vm settings.

I've got some 4x2.6G opteron servers (same board, 32G PC3200), but alas,
end-users have found out about them.  not to mention that they only have 
3x160G SATA disks...

regards, mark hahn.

