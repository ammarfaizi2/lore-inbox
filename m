Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbTDYQKF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 12:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263394AbTDYQKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 12:10:05 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:44789 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263380AbTDYQKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 12:10:02 -0400
Date: Fri, 25 Apr 2003 10:20:14 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nigel Cunningham <ncunningham@clear.net.nz>,
       Andrew Morton <akpm@digeo.com>, cat@zip.com.au, mbligh@aracnet.com,
       gigerstyle@gmx.ch, geert@linux-m68k.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030425102014.A26054@schatzie.adilger.int>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Nigel Cunningham <ncunningham@clear.net.nz>,
	Andrew Morton <akpm@digeo.com>, cat@zip.com.au, mbligh@aracnet.com,
	gigerstyle@gmx.ch, geert@linux-m68k.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030424093534.GB3084@elf.ucw.cz> <20030424024613.053fbdb9.akpm@digeo.com> <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz> <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz> <20030424154608.V26054@schatzie.adilger.int> <1051232975.1919.26.camel@laptop-linux> <20030425125918.GA25733@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030425125918.GA25733@atrey.karlin.mff.cuni.cz>; from pavel@ucw.cz on Fri, Apr 25, 2003 at 02:59:18PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 25, 2003  14:59 +0200, Pavel Machek wrote:
> > I don't believe Pavel was saying the image would be corrupted. Rather,
> > the rest of the disk contents are corrupted by replaying the journal and
> > then resuming back to a memory state that has been made inconsistent
> > with the disk state because of the journal replay.
> 
> Right.

But that is happening regardless of whether a swapfile is in use or not.
It is a problem whether the filesystem is journaling or not.  Basically,
if you are entering into a normal boot sequence and mounting filesystems
and then resuming from your saved state you risk filesystem corruption.

The only way to avoid that would be for the kernel to detect the swsusp
magic data in the swap partition _before_ any filesystems are mounted
(probably via initramfs), and then resume from that image (which will
implicitly "mount" the filesystem because it was never unmounted in
that image).  Then, swsusp becomes a special case of the 2-kernel-monte
(or add your other favourite kernel-booting-kernel method here), where
most of your kernel state is swapped out and only a limited recovery
state is loaded into RAM before doing the kernel dance).

> > > If that is the case, then the only way to avoid this would be to call
> > > sync_supers_lockfs() on each filesystem before the suspend, which will
> > > force the journal to be empty when it returns.  That API is supported
> > > by all of the journaling filesystems, and is probably a good thing to
> > > do anyways, as it will potentially free a lot of dirty data from RAM,
> > > and also ensure that the on-disk data is consistent in case the resume
> > > isn't handled gracefully.
> > 
> > Sounds like a good idea to me.
> 
> When I do sys_sync(), will it trigger that?

No, having sys_sync() do journal purging would really hurt journal fs
performance.  That's why I said you need to call sync_supers_lockfs(),
which is unfortunately not in 2.4 kernels (available in the LVM CVS
as a patch), but it does appear to be in 2.5 kernels.  For journaling
filesystems this is the equivalent of temporarily unmounting the
filesystem and then remounting it when unlockfs() is called.

Note that you must explicitly pass a block device to lock, so that you
do this before shutting down the disk device.  I've never tested, but
locking the filesystem probably does not prevent writing to an existing
swapfile on that filesystem, since the swap code bypasses the filesystem
entirely.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

