Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263571AbTLDVRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTLDVRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 16:17:30 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:45749 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S263571AbTLDVR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 16:17:27 -0500
Date: Fri, 5 Dec 2003 08:16:11 +1100
From: Nathan Scott <nathans@sgi.com>
To: Mihai RUSU <dizzy@roedu.net>, Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: kernel BUG at mm/filemap.c:332!
Message-ID: <20031204211611.GA567@frodo>
References: <Pine.LNX.4.56L0.0312041645560.7551@ahriman.bucharest.roedu.net> <Pine.LNX.4.58.0312040834480.2055@home.osdl.org> <Pine.LNX.4.56L0.0312041849250.10045@ahriman.bucharest.roedu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56L0.0312041849250.10045@ahriman.bucharest.roedu.net>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 07:26:38PM +0200, Mihai RUSU wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi Linus
> 
> First of all thanks for the answer!
> 
> On Thu, 4 Dec 2003, Linus Torvalds wrote:
> 
> > 
> > Nathan,
> >  you're not off the hook yet. This is a smoking gun on XFS, and this time
> > with a big clue: large directories, and a low-memory situation.
> 
> Sorry to have misguided you guys in the first post. After rebooting the
> machine I have some more information, the actual directory size its about
> some hundred entries (~400) and not thousands as I previously speculated

Still, its a clue - all metadata I/O in XFS goes though the
pagebuf code, so we're looking in the right place.

> However I have some more usefull (I hope) information about the subject.  
> Before rebooting I wanted to first install a do_brk() patched 2.4.21-xfs
> kernel with lilo. Unfortunetly lilo stuck in a fsync() call after writing
> to screen that it did added all kernel images to MBR as configured in
> lilo.conf. When I booted I had no problem to boot from the new do_brk()
> fixed kernel so lilo seems it did the job, I dont know why it stuck
> in fsync().

Was your filesystem near full?  There was a 2.4 deadlock fixed
recently which could be what you hit there.

> After power on, one coleague complained that a file on which he worked a
> couple of minutes before I took the machine down had NULL bytes instead of
> actual content. I know that "dirty" data gets flushed to disk every 30
> seconds so this seems a little bit strange (in general I know that XFS
> leaves NULL bytes in files modified just before a unclean reboot but this
> file was modified some 5 minutes before the "hard" reboot).

You'll want a more recent 2.4 XFS kernel I suspect - Steve made
several improvements in this area awhile back.

> > Also, this time the config file doesn't have any MD/RAID support according
> > to the attachment:
> > 
> > 	# Multi-device support (RAID and LVM)
> > 	#
> > 	# CONFIG_MD is not set
> > 
> > so it looks like the XFS and MD issues really are totally unrelated.

Sure does.

> > Mihai: the oops itself is in this case not very telling, since it's just a
> > result of corruption of some fundamental data structures (probably
> > somebody using a page cache page after having free'd it - and it probably
> > only shows up when memory gets low and pages have to be cleaned). Can you
> > tell Nathan more about the filesystem setup (block size, as much as
> > possible about the affected directory, etc).
> 
> Ok.
> 
> $ xfs_info /var
> meta-data=/var                   isize=256    agcount=18, agsize=262144 blks
> data     =                       bsize=4096   blocks=4482127, imaxpct=25
>          =                       sunit=0      swidth=0 blks, unwritten=0
> naming   =version 2              bsize=4096  
> log      =internal               bsize=4096   blocks=1200
> realtime =none                   extsz=65536  blocks=0, rtextents=0

OK, looks like a default mkfs then (with an old-ish mkfs binary)?
Newer mkfs' will give you a better AG layout and unwritten extents
would be turned on - not relevent to this problem at all though.

An "ls -ld" and "xfs_bmap -v" on the directory would also provide
me a bit more info to work with -- thanks!

I have a few ideas about what this might be, let me stew on those
for a bit and try a few things.

cheers.

-- 
Nathan
