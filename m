Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271120AbTHLVIC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 17:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271121AbTHLVH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 17:07:59 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:24773
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S271120AbTHLVHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 17:07:53 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [RFC] file extents for EXT3
Date: Tue, 12 Aug 2003 17:09:40 -0400
User-Agent: KMail/1.5
Cc: Jeff Garzik <jgarzik@pobox.com>, Alex Tomas <bzzz@tmi.comex.ru>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <m3ptjcabey.fsf@bzzz.home.net> <200308120533.58020.rob@landley.net> <20030812091453.D4446@schatzie.adilger.int>
In-Reply-To: <20030812091453.D4446@schatzie.adilger.int>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308121709.40263.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 11:14, Andreas Dilger wrote:
> On Aug 12, 2003  05:33 -0400, Rob Landley wrote:
> > With the ability to place a journal on another block device, you could
> > theoretically throw the journal on a 1 megabyte ramdisk, and more or less
> > degrade ext3 to ext2 that way (as long as you made sure to fsck the heck
> > out of it on the way back up each time).
>
> That would be a net loss over ext2, because at least when you crash an
> ext2 system the filesystem will not be marked clean and e2fsck will auto
> check it.

Hence fscking the heck out of it on the way back up.  (Or more accurately, 
only ever using it on a read-only filesystem...)

> There is no reason to use ext3 in such a situation except
> making the system slower, less resiliant to a crash, and use more RAM.
> You would be far better off to just use ext2 in this case.

Assuming you wanted to compile two filesystem drivers into the system with 
basically the same on-disk layout, for use with an initial ramdisk or cd-rom 
boot image...

> > Beyond that, why is the minimum journal size 1 megabyte?  (Having to
> > waste a megabyte of ram on a 4 megabyte filesystem is kind of annoying.
>
> Not only would the journal itself require a 1MB ramdisk, but it could use
> up to another 1MB for dirty journal buffers.  Really, I can not stress it
> enough that this is a terrible setup.

I know it's bad, I'm saying it's possible. :)

It's a gross kludge to get around the lack of a no-journal option by providing 
it with a faux journal, patting it on the head, and sending it about its 
merry way... :)

> > Beyond THAT, ext2 could be considered ext3 with a "no journal" flag
> > (automatically supplied when the mount is read only, for example).  Last
> > time I did an embedded device, I had to stick both ext3 in (for the
> > runtime data partition) and ext2 in (for the initrd that loopback mounted
> > the firmware image, which was a zisofs containing the root partition). 
> > Initramfs addresses this particular annoyance, but still leaves a problem
> > creating a bootable CD that's going to install to ext3...
>
> If you are interested in that, the ext3 code is _nearly_ ready to support
> mounting without a journal, but it never quite was ready.  Basically, you
> skip the journal setup at mount time, and then in all of the journal helper
> functions like ext3_journal_start() you make it a no-op if s_journal is
> NULL. You would need to clear the "clean" flag again at mount.
>
> You would still need to make some more helper functions to avoid
> dereferencing handle and journal pointers in the ext3 code.

I'd need to come way the heck up to speed on the ext3 code.  This evening I'm 
poring over Con's changes to the scheduler.  (I prefer exploring areas that 
are a little less likely to eat my disk when banging away on my laptop.  When 
I get my scratch machines out of storage, then I'll worry about messing up 
the disk. :)

> > Having to compile two filesystems into the kernel with basically the same
> > on-disk layout is kind of annoying, but ext3 simply isn't a good fit for
> > a small ramdisk or for read-only media.
>
> Use something that is - like JFFS2 or similar?

Jffs2 isn't that great a fit for a many-gigabyte hard drive partition for a 
network attached storage device, either...

I had a system where ext2 needed to be compiled in to bring the system up, but 
wasn't used while it was running (ext3 was), and I didn't want to go to a 
modular kernel just for that.  I speced out a way to hack my way around it in 
a gross and disgusting fashion.  The point was that I was looking for a 
no-journal option for ext3 in a real world situation a few months ago, and 
wouldn't have minded a performance hit to get it...

These days, initramfs may make this particular case go away.  Last I heard, 
ext3 still was a bad fit for read-only filesystem images, though...

Rob
