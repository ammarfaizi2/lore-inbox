Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbVBUUAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbVBUUAn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbVBUUAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:00:43 -0500
Received: from fire.osdl.org ([65.172.181.4]:13283 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262058AbVBUUAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:00:34 -0500
Date: Mon, 21 Feb 2005 12:00:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Merging fails reading /dev/uba1
In-Reply-To: <20050221102431.64de6c6c@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0502211152330.2378@ppc970.osdl.org>
References: <20050220200059.53db7b1e@localhost.localdomain>
 <20050221075131.GT4056@suse.de> <20050221102431.64de6c6c@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Feb 2005, Pete Zaitcev wrote:
> 
> Contiguous pages have nothing to do with it either. I forgot to mention
> that in the first case (whole device), all reads are done with length of
> 4KB, while in the second case (partition), all reads are 512 bytes long.

That's because your partition isn't a full 4kB in size.

So the kernel falls back to 512-byte reads, just because they are the only 
kind that _can_ read the last sector.

> Disk /dev/uba: 1048 MB, 1048576000 bytes

Note: this is a nice multiple of 4kB.

> 64 heads, 32 sectors/track, 1000 cylinders
> Units = cylinders of 2048 * 512 = 1048576 bytes
> 
>    Device Boot      Start         End      Blocks   Id  System
> /dev/uba1   *           1        1000     1023983+   6  FAT16

And note how this is _not_ (see the "+" at the end), you've got a 
1023983.5 kB partition.

> It does not look to me as if the partition started from an odd number
> of sectors. In fact, it starts from a full number of pages.

But it seems to end in an odd number of sectors.

That said, I'm surprised that the difference in performance is _that_ 
large. Regardless of whether the disk blocksize is 512 bytes or 4096 
bytes, you should be getting IO merging - it might use more CPU time, but 
the actual IO should still be done in much larger blocks.

You should be able to try the BLKBSZSET ioctl to set the blocksize by hand 
if you want to try it out:

	int size = 4096;
	ioctl(fd, BLKBSZSET, &size);

or similar. Of course, mounting a filesystem on the device tends to do 
that (or undo it) for you, ie it will set the blocksize to whatever 
blocksize the filesystem wants.

		Linus
