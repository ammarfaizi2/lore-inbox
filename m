Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264478AbTDXVgB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTDXVgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:36:01 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:25594 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264478AbTDXVf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:35:58 -0400
Date: Thu, 24 Apr 2003 15:46:08 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>, cat@zip.com.au,
       mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424154608.V26054@schatzie.adilger.int>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@digeo.com>,
	Nigel Cunningham <ncunningham@clear.net.nz>, cat@zip.com.au,
	mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
	linux-kernel@vger.kernel.org
References: <20030423173720.6cc5ee50.akpm@digeo.com> <20030424091236.GA3039@elf.ucw.cz> <20030424022505.5b22eeed.akpm@digeo.com> <20030424093534.GB3084@elf.ucw.cz> <20030424024613.053fbdb9.akpm@digeo.com> <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz> <20030424103734.O26054@schatzie.adilger.int> <20030424204805.GA379@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424204805.GA379@elf.ucw.cz>; from pavel@ucw.cz on Thu, Apr 24, 2003 at 10:48:05PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2003  22:48 +0200, Pavel Machek wrote:
> Andreas Dilger wrote:
> > Wouldn't that be true in all cases where you have a journaled filesystem
> > and you suspend?  
> 
> No. In normal state you restore without mounting anything (thus no
> journal replay).
> 
> > Are you talking about someone restarting system (without
> > doing a resume), mounting the file system (causing journal replay), and
> > then shutting down and going back to the suspended image?
> 
> No, I'm not.
> 
> > I think the important thing to note is that if you don't unmount the
> > filesystem during suspend, then no journal recovery will take place
> > at resume time, because you are not really mounting the filesystem
> > at all.  And I can't see how you could be unmounting the filesystems
> > without killing all of the applications, at which point it would make
> > suspend pretty useless.
> 
> No, I'm not unmounting it.

OK, then why all of the talk earlier saying that journal recovery will
corrupt a swapfile?  That was the reason journaling was brought into the
discussion in the first place:

	"And now you have kernel which expects data still in journal (that was
	 state before suspend), but reality on disk is quite different (journal
	 was replayed). Data corruption." -- Pavel

If the filesystem was not unmounted and remounted, then no replay will happen.  
End of story.  If the suspend code is doing something like:
	
	1) save memory contents to disk
	2) suspend/power off
	3) reboot kernel, mount filesystem(s), etc
	4) check for presence of suspend image
	5) replace currently-running kernel with suspended kernel

Then you are in for a world of hurt regardless of whether the data is in a
swap file or a swap partition.  The data in the swapfile isn't touched by
journal replay at all (so that is safe regardless), but the rest of the
filesystem is, which could cause strange disk corruption since the in-memory
data doesn't match the on-disk data.

If that is the case, then the only way to avoid this would be to call
sync_super_lockfs() on each filesystem before the suspend, which will
force the journal to be empty when it returns.  That API is supported
by all of the journaling filesystems, and is probably a good thing to
do anyways, as it will potentially free a lot of dirty data from RAM,
and also ensure that the on-disk data is consistent in case the resume
isn't handled gracefully.

> > What is also important to note is that during normal filesystem operation,
> > the ext3 journaling code never reads back any data from the journal, with
> > the exception of a couple of fields in the journal superblock.  I would
> > hazard a guess that if you did a suspend, wiped the journal, and then
> > resumed the journaling code wouldn't know the difference.
> 
> That's possible, but I do not want suspend to know about filesystem
> specifics.

This was just given as a counterexample saying that the in-kernel ext3
journal code does not actually care what is in the journal on disk, since
it is never read unless there is a crash.  So, the suspend code does not
need to know anything about the filesystem specifics at all in this regard.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

