Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269288AbUHZSZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269288AbUHZSZH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 14:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269227AbUHZSYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:24:36 -0400
Received: from mail.shareable.org ([81.29.64.88]:48582 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S269335AbUHZSQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:16:29 -0400
Date: Thu, 26 Aug 2004 19:16:20 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       Alex Zarochentsev <zam@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826181620.GT5733@mail.shareable.org>
References: <20040825205149.GA17654@lst.de> <412DA2CF.2030204@namesys.com> <20040826124119.GA431@lst.de> <20040826134812.GB5733@mail.shareable.org> <20040826155744.GA4250@lst.de> <20040826160638.GJ5733@mail.shareable.org> <20040826161303.GA4716@lst.de> <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org> <20040826172029.GP5733@mail.shareable.org> <Pine.LNX.4.58.0408261021250.2304@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408261021250.2304@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> >         -> the setuid program thus ends up opening a device or fifo,
> >            when it does pwd's path walk.  Yes it could use the getcwd
> >            syscall, but some programs do their own path walk.
> 
> .. but even if it did that, it should use O_DIRECTORY when it did so. If 
> it doesn't, it's broken.

Didn't someone just say that O_DIRECTORY will succeed on a device,
precisely because opendir() is supposed to succeed on the device?

I'm not sure.  Let me refresh my memory.

Linus Torvalds wrote:
> And it would be perfectly ok for O_DIRECTORY to open such a file, as long
> as it opens the directory branch, not the special device.

Oh, I see.  You're right.  ".." sees the path of directory branches.

> > It also fits the container idea very well:
> > 
> >         /dev/hda/part1/ <- the filesystem inside partition 1
> 
> I don't think you can do that. The kernel has no idea how to mount the
> filesystem.

It is not the kernel which decides.  The filesystem containing
/dev/hda/part1 opens "the directory branch".  If the filesystem is
suitably configured, it's exactly the same as opening a .zip or ELF
file: it asks userspace for help.  Userspace helps by either mounting
it, or creating a container virtual directory -- in exactly the same
way it helps with .zip and ELF files by creating a container virtual
directory for those.  It would mount it if the kernel supports the fs,
and create a virtual directory if the kernel doesn't support the fs
and userspace does.

This is exactly the same as when you cd into a filesystem image: the
helper mounts (this time with a lookback file mount) if the kernel
supports the image fs, otherwise the helper may be able to decode it
in userspace.

By the way, these mechanisms could allow some of the old filesystems
that nobody uses any more to be removed from the kernel altogether and
kept in an archive of userspace-only supported filesystems.  What do
you think of that idea?

> If it's already mounted somewhere else, that's a different issue.  
> Although it might be mounted in several places (as a bind mount) with
> different writability, I guess, so even then it might be "interesting".

The obvious implementation has the userspace helper just mounting it,
end of story.  If the mount command fails, it fails.  Much like autofs.

-- Jamie
