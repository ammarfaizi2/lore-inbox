Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbTDYTrr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 15:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTDYTrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 15:47:47 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:37873 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263687AbTDYTrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 15:47:45 -0400
Date: Fri, 25 Apr 2003 13:58:00 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
       cat@zip.com.au, mbligh@aracnet.com, gigerstyle@gmx.ch,
       geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030425135800.C26054@schatzie.adilger.int>
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
	cat@zip.com.au, mbligh@aracnet.com, gigerstyle@gmx.ch,
	geert@linux-m68k.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz> <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz> <20030424154608.V26054@schatzie.adilger.int> <1051232975.1919.26.camel@laptop-linux> <20030425125918.GA25733@atrey.karlin.mff.cuni.cz> <20030425102014.A26054@schatzie.adilger.int> <1051295327.1722.7.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1051295327.1722.7.camel@laptop-linux>; from ncunningham@clear.net.nz on Sat, Apr 26, 2003 at 06:28:47AM +1200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 26, 2003  06:28 +1200, Nigel Cunningham wrote:
> On Sat, 2003-04-26 at 04:20, Andreas Dilger wrote:
> > On Apr 25, 2003  14:59 +0200, Pavel Machek wrote:
> > > > I don't believe Pavel was saying the image would be corrupted. Rather,
> > > > the rest of the disk contents are corrupted by replaying the journal and
> > > > then resuming back to a memory state that has been made inconsistent
> > > > with the disk state because of the journal replay.
> > > 
> > > Right.
> > 
> > But that is happening regardless of whether a swapfile is in use or not.
> > It is a problem whether the filesystem is journaling or not.  Basically,
> > if you are entering into a normal boot sequence and mounting filesystems
> > and then resuming from your saved state you risk filesystem corruption.
> > 
> > The only way to avoid that would be for the kernel to detect the swsusp
> > magic data in the swap partition _before_ any filesystems are mounted
> > (probably via initramfs), and then resume from that image (which will
> > implicitly "mount" the filesystem because it was never unmounted in
> > that image).  Then, swsusp becomes a special case of the 2-kernel-monte
> > (or add your other favourite kernel-booting-kernel method here), where
> > most of your kernel state is swapped out and only a limited recovery
> > state is loaded into RAM before doing the kernel dance).
> 
> And that's precisely what we do. SWSUSP runs before any file system is
> mounted. It checks the designed partition's swap header, loads the image
> and then completely replaces the booting kernel with the saved one.
> That's how we avoid corruption at the moment.

OK, then journal replay is again out of the picture...  It's just hard to
follow because one person says "journal replay will corrupt things", and
the other says "we aren't mounting filesystems".  No mounting == no journal
replay == no corruption.  This has nothing to do with swapfiles.

> But if we have a swapfile, we need to do some initialisation of the
> filesystem code in order to get access to our swapfile. Even if we
> record in the swapfile - while suspending - information that gives us
> the locations of blocks, we still need to find the start of the swapfile,
> or store it somewhere. If you have a suggestion in that regard, I might
> be able to see a swapfile as a possibility.

Two options:
1) You already have to store _some_ information about where to get the
   resume image from.  It sounds like you store the swap partition name
   on the kernel command-line or similar.  It should be equally possible
   to store the swap file partition name PLUS a relative offset from the
   start of the partition to where the swapfile starts.  You can easily
   get this via fstat+bmap on the swapfile.

2) You could require that the critical resume information be on a swap
   partition, but allow non-kernel data to be saved to the swapfile.
   If you can read the initial resume data from the swap partition, I'd
   have to imagine that you can read devno+block data from a swapfile
   without needing any of the filesystem code involved.  After all, the
   swap code doesn't depend on the filesystem either - it just makes a
   list of block numbers at swapfile activation time and does direct
   read/write to the device after that.

The lilo suggestion for doing the bmap could also be done, although
I don't see the need if the swap code has already mapped the entire
file in memory already.  Also note - while GRUB _examines_ the
filesystem (via internal fs-aware code), I don't think it acutally
mounts it or does journal replay, so it should be safe also if you
really wanted to go that way (I don't think you need to however).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

