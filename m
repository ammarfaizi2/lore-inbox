Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbTDXQ1Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 12:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbTDXQ1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 12:27:24 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:23289 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263761AbTDXQ1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 12:27:22 -0400
Date: Thu, 24 Apr 2003 10:37:34 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@digeo.com>,
       Nigel Cunningham <ncunningham@clear.net.nz>, cat@zip.com.au,
       mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <20030424103734.O26054@schatzie.adilger.int>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>,
	Andrew Morton <akpm@digeo.com>,
	Nigel Cunningham <ncunningham@clear.net.nz>, cat@zip.com.au,
	mbligh@aracnet.com, gigerstyle@gmx.ch, geert@linux-m68k.org,
	linux-kernel@vger.kernel.org
References: <20030424001733.GB678@zip.com.au> <1051143408.4305.15.camel@laptop-linux> <20030423173720.6cc5ee50.akpm@digeo.com> <20030424091236.GA3039@elf.ucw.cz> <20030424022505.5b22eeed.akpm@digeo.com> <20030424093534.GB3084@elf.ucw.cz> <20030424024613.053fbdb9.akpm@digeo.com> <1051182797.2250.10.camel@laptop-linux> <20030424043637.71c3812e.akpm@digeo.com> <20030424142632.GB229@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030424142632.GB229@elf.ucw.cz>; from pavel@suse.cz on Thu, Apr 24, 2003 at 04:26:32PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 24, 2003  16:26 +0200, Pavel Machek wrote:
> > > > > Andrew Morton wrote:
> > > > > > Sorry, I still don't get it.  Go through the steps for me:
> > > > > > 
> > > > > > 1) suspend writes pages to disk
> > > > > > 
> > > > > > 2) machine is shutdown
> > > > > > 
> > > > > > 3) restart, journal replay
> > > 
> > > Corruption comes here. The journal reply tidies things up that shouldn't
> > > be tidied up. They shouldn't be tidied up because once we reload the
> > > image, things should be in the same state as prior to suspend. If replay
> > > frees a block (thinking it wasn't properly linked or something similar),
> > > it introduces corruption.
> > 
> > No, this will not happen.  All swapfile blocks must be allocated by swapon
> > time.  It is just a chunk of disk and replay will not touch it.
> > 
> > That's for ext3, and no other filesystems journal data anyway...
> 
> Its not about data.
> 
> Corruption is not in suspended image. Imagine you have running system
> (X open, applications running, gcc compiling) and someone runs journal
> replay. Bye bye data. And that's what happens there. When you restore,
> restored kernel no longer knows you did replay.

Wouldn't that be true in all cases where you have a journaled filesystem
and you suspend?  Are you talking about someone restarting system (without
doing a resume), mounting the file system (causing journal replay), and
then shutting down and going back to the suspended image?

I think the important thing to note is that if you don't unmount the
filesystem during suspend, then no journal recovery will take place
at resume time, because you are not really mounting the filesystem
at all.  And I can't see how you could be unmounting the filesystems
without killing all of the applications, at which point it would make
suspend pretty useless.

What is also important to note is that during normal filesystem operation,
the ext3 journaling code never reads back any data from the journal, with
the exception of a couple of fields in the journal superblock.  I would
hazard a guess that if you did a suspend, wiped the journal, and then
resumed the journaling code wouldn't know the difference.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

