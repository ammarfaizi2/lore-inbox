Return-Path: <linux-kernel-owner+w=401wt.eu-S1751791AbXAOCrW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbXAOCrW (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 21:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbXAOCrW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 21:47:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:42951 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751788AbXAOCrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 21:47:21 -0500
X-Authenticated: #5039886
Date: Mon, 15 Jan 2007 03:47:17 +0100
From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>,
       linux-kernel@vger.kernel.org, htejun@gmail.com
Subject: Re: SATA exceptions with 2.6.20-rc5
Message-ID: <20070115024717.GA2736@atjola.homenet>
Mail-Followup-To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Jeff Garzik <jeff@garzik.org>, Robert Hancock <hancockr@shaw.ca>,
	linux-kernel@vger.kernel.org, htejun@gmail.com
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <45AAC039.1020808@shaw.ca> <45AAC95B.1020708@garzik.org> <20070115003448.GA2787@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20070115003448.GA2787@atjola.homenet>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2007.01.15 01:34:48 +0100, Björn Steinbrink wrote:
> On 2007.01.14 19:22:51 -0500, Jeff Garzik wrote:
> > Robert Hancock wrote:
> > >Björn Steinbrink wrote:
> > >>Hi,
> > >>
> > >>with 2.6.20-rc{2,4,5} (no other tested yet) I see SATA exceptions quite
> > >>often, with 2.6.19 there are no such exceptions. dmesg and lspci -v
> > >>output follows. In the meantime, I'll start bisecting.
> > >
> > >...
> > >
> > >>ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> > >>ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0 cdb 0x0 data 0 in
> > >>         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> > >>ata1: soft resetting port
> > >>ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> > >>ata1.00: configured for UDMA/133
> > >>ata1: EH complete
> > >>SCSI device sda: 160086528 512-byte hdwr sectors (81964 MB)
> > >>sda: Write Protect is off
> > >>sda: Mode Sense: 00 3a 00 00
> > >>SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
> > >>support DPO or FUA
> > >
> > >Looks like all of these errors are from a FLUSH CACHE command and the 
> > >drive is indicating that it is no longer busy, so presumably done. 
> > >That's not a DMA-mapped command, so it wouldn't go through the ADMA 
> > >machinery and I wouldn't have expected this to be handled any 
> > >differently from before. Curious..
> > 
> > It's possible the flush-cache command takes longer than 30 seconds, if 
> > the cache is large, contents are discontiguous, etc.  It's a 
> > pathological case, but possible.
> > 
> > Or maybe flush-cache doesn't get a 30 second timeout, and it should...? 
> >  (thinking out loud)
> 
> Bi-section led to commit 249e83fe839 which makes absolutely no sense to
> me, just in case that anyone sees any problem with that commit.
> I'll go and re-check a few of those commits that I marked as good.

Next round of bisecting led to another useless result, a) it was an
unrelated driver, b) the kernel I just marked as good after 20 minutes
of testing decided to fail when I hit reply... Guess that it was pure
luck that the kernel I marked as bad failed within 1-2 minutes.
I send the git bisect log with this mail, maybe at least the early good
kernel are really good and someone can make some sense out of it. At
least I ended up somewhere in a series of libata changes.

Thanks,
Björn

git-bisect start
# bad: [8a2d17a56a71c5c796b0a5378ee76a105f21fdd9] Linux 2.6.20-rc2
git-bisect bad 8a2d17a56a71c5c796b0a5378ee76a105f21fdd9
# good: [c3fe6924620fd733ffe8bc8a9da1e9cde08402b3] Linux 2.6.19
git-bisect good c3fe6924620fd733ffe8bc8a9da1e9cde08402b3
# bad: [2685b267bce34c9b66626cb11664509c32a761a5] Merge master.kernel.org:/pub/scm/linux/kernel/git/davem/net-2.6
git-bisect bad 2685b267bce34c9b66626cb11664509c32a761a5
# good: [a985239bdf017e00e985c3a31149d6ae128fdc5f] [POWERPC] cell: spu management xmon routines
git-bisect good a985239bdf017e00e985c3a31149d6ae128fdc5f
# bad: [33f2ef89f8e181486b63fdbdc97c6afa6ca9f34b] mm: make compound page destructor handling explicit
git-bisect bad 33f2ef89f8e181486b63fdbdc97c6afa6ca9f34b
# bad: [651857a1ecaf97a8ad9d324dd2a61675c53e541e] Merge branch 'upstream-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mfasheh/ocfs2
git-bisect bad 651857a1ecaf97a8ad9d324dd2a61675c53e541e
# bad: [ff51a98799931256b555446b2f5675db08de6229] Merge branch 'upstream-linus' of master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/libata-dev
git-bisect bad ff51a98799931256b555446b2f5675db08de6229
# bad: [3ac551a6a63dcbc707348772a27bd7090b081524] [libata] pata_cs5535: fix build
git-bisect bad 3ac551a6a63dcbc707348772a27bd7090b081524
# good: [750426aa1ad1ddd1fa8bb4ed531a7956f3b9a27c] libata: cosmetic changes to sense generation functions
git-bisect good 750426aa1ad1ddd1fa8bb4ed531a7956f3b9a27c
# good: [62d64ae0ec76360736c9dc4ca2067ae8de0ba9f2] pata : more drivers that need only standard suspend and resume
git-bisect good 62d64ae0ec76360736c9dc4ca2067ae8de0ba9f2
# good: [6a36261e63770ab61422550b774fe949ccca5fa9] libata: fix READ CAPACITY simulation
git-bisect good 6a36261e63770ab61422550b774fe949ccca5fa9
# good: [2432697ba0ce312d60be5009ffe1fa054a761bb9] libata: implement ata_exec_internal_sg()
git-bisect good 2432697ba0ce312d60be5009ffe1fa054a761bb9
# good: [70e6ad0c6d1e6cb9ee3c036a85ca2561eb1fd766] libata: prepare ata_sg_clean() for invocation from EH
git-bisect good 70e6ad0c6d1e6cb9ee3c036a85ca2561eb1fd766
# good: [8e16f941226f15622fbbc416a1f3d8705001a191] ahci: do not powerdown during initialization
git-bisect good 8e16f941226f15622fbbc416a1f3d8705001a191
