Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWBFMky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWBFMky (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 07:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWBFMky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 07:40:54 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:54962 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750874AbWBFMky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 07:40:54 -0500
Date: Mon, 6 Feb 2006 13:40:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: Rafael Wysocki <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       Suspend2 Devel List <suspend2-devel@lists.suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060206124034.GH4101@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602061402.54486.nigel@suspend2.net> <20060206105954.GD3967@elf.ucw.cz> <200602062213.24735.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602062213.24735.nigel@suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 06-02-06 22:13:20, Nigel Cunningham wrote:
> On Monday 06 February 2006 20:59, Pavel Machek wrote:

> > I do not see why I'd have to modify freezer for supporting swap
> > files. It is really unrelated part. If I want to support swap files,
> > I'll just bmap() them from userspace, then write to blockdevice
> > directly, like lilo or grub does.
> 
> It would be needed because they're on filesystems. Freezing the 
> filesystems, then trying to eat memory to the degree that the system tries 
> to swap would lead to a deadlock if that swap was on a frozen filesystem. 
> Conversely, trying to freeze the memory before freezing processes would be 
> unreliable because it relies on not racing against other processes trying 
> to work.

I need to think about that one... it should be possible to allocate
space in swap file *before* freeze, and get disk address via
bmap... are you sure swapfile accesses go through filesystems? I
thought they use something bmap-like internally.

> > > d. Storage of the image.
> > >
> > > As it currently stands, the interface between userspace and the kernel
> > > for uswsusp looks clean and simple. This is mainly, however, because
> > > it only supports writing to swap, and strictly synchronously.
> >
> > ...and it is going to stay that way.
> 
> No plans for writing to anywhere else but swap?

Yes, but with bmap, it is possible to do that with current
interface. Early version even supported swap partitions.

> > > userspace for getting the sector numbers of storage. Finally, you'd
> > > want to use bio functions to submit the I/O, and a kernel routine to
> > > handle the completion. Then you'd need some mechanism to wait for or
> > > check for completion of I/O on a particular page or all pages. Of
> > > course you might decide not to do async I/O because it's too complex,
> > > but then you'd take the performance hit you currently have, and we
> > > wouldn't have an apples with apples comparison.
> >
> > Submit bios from userspace? Eeek? We have perfectly working async io
> 
> Yes. But then how do you submit I/O to files on filesystems you can't 
> mount? You're stuck with swap partitions only forever?

read/write directly block device is perfectly possible from
userspace. Small problem is finding suspend header with the map, but
you somehow solved that already, right?

> > interface for userland, and BTW going async will not give you too much
> > of performance advantage here...
> 
> How do you know that? Suspend2 has async I/O, and can write the image as 
> fast as the drive can take it. Some testing I did a while ago showed a max 
> throughput of 16MB/s for swsusp vs 35 (what the drive is capable of) for 
> Suspend2. Add LZF compression and it's 70MB/s vs 16MB/s.

Userspace is perfectly capable of saturating I/O subsystem. No magical
"async io" is needed for that. time dd if=/dev/zero of=/dev/hda
bs=... if you don't believe me.

> > Current uswsusp is 3K lines of code in kernel, 1K lines of code in
> > userspace.
> >
> > When we are done, we'll have perhaps 2.5K lines of code in kernel
> > (in-kernel swap writing support goes away), and maybe 20K lines in
> > userspace.
> 
> Without adding which out of async I/O, compression, encryption, swap file 
> support, and ordinary file support?

I'll get same bandwidth as you, without need for async I/O. Async I/O
is not really a feature, suspend speed is. (There are existing
interfaces for doing AIO from userspace, anyway, but I'm pretty sure
they will not be needed

Compression, encryption, swapfile/normal file is planned, and should
not affect kernel code.
								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
