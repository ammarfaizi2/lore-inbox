Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270497AbTHLPRx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 11:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270519AbTHLPRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 11:17:53 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:63214 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S270497AbTHLPPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 11:15:53 -0400
Date: Tue, 12 Aug 2003 09:14:53 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Rob Landley <rob@landley.net>
Cc: Jeff Garzik <jgarzik@pobox.com>, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] file extents for EXT3
Message-ID: <20030812091453.D4446@schatzie.adilger.int>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	Jeff Garzik <jgarzik@pobox.com>, Alex Tomas <bzzz@tmi.comex.ru>,
	linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <m3ptjcabey.fsf@bzzz.home.net> <20030811095518.T7752@schatzie.adilger.int> <3F37C2EB.5050503@pobox.com> <200308120533.58020.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308120533.58020.rob@landley.net>; from rob@landley.net on Tue, Aug 12, 2003 at 05:33:58AM -0400
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 12, 2003  05:33 -0400, Rob Landley wrote:
> With the ability to place a journal on another block device, you could 
> theoretically throw the journal on a 1 megabyte ramdisk, and more or less 
> degrade ext3 to ext2 that way (as long as you made sure to fsck the heck out 
> of it on the way back up each time).

That would be a net loss over ext2, because at least when you crash an
ext2 system the filesystem will not be marked clean and e2fsck will auto
check it.  There is no reason to use ext3 in such a situation except
making the system slower, less resiliant to a crash, and use more RAM.
You would be far better off to just use ext2 in this case.

> Beyond that, why is the minimum journal size 1 megabyte?  (Having to waste a 
> megabyte of ram on a 4 megabyte filesystem is kind of annoying.

Not only would the journal itself require a 1MB ramdisk, but it could use
up to another 1MB for dirty journal buffers.  Really, I can not stress it
enough that this is a terrible setup.

FYI, the reason that the journal needs to be 1MB is that the maximum
transaction size is 1/4 of the journal, and you need about 256 blocks
in a transaction to get decent "write merging" of dirty blocks in the
journal, or you will write the superblock and other commonly-dirtied
blocks out too often.

I _think_ (not to be trusted without extensive testing) that you could
make the journal as small as 3*128 blocks, but it would need some hacking
of the jbd code to set up j_max_transaction_buffers smaller, and also
e2fsck to allow you to make a smaller journal.

> Beyond THAT, ext2 could be considered ext3 with a "no journal" flag 
> (automatically supplied when the mount is read only, for example).  Last time 
> I did an embedded device, I had to stick both ext3 in (for the runtime data 
> partition) and ext2 in (for the initrd that loopback mounted the firmware 
> image, which was a zisofs containing the root partition).  Initramfs 
> addresses this particular annoyance, but still leaves a problem creating a 
> bootable CD that's going to install to ext3...

If you are interested in that, the ext3 code is _nearly_ ready to support
mounting without a journal, but it never quite was ready.  Basically, you
skip the journal setup at mount time, and then in all of the journal helper
functions like ext3_journal_start() you make it a no-op if s_journal is NULL.
You would need to clear the "clean" flag again at mount.

You would still need to make some more helper functions to avoid dereferencing
handle and journal pointers in the ext3 code.

> Having to compile two filesystems into the kernel with basically the same 
> on-disk layout is kind of annoying, but ext3 simply isn't a good fit for a 
> small ramdisk or for read-only media.

Use something that is - like JFFS2 or similar?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

