Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVGUHUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVGUHUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 03:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGUHUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 03:20:21 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:31404 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261665AbVGUHUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 03:20:19 -0400
Date: Thu, 21 Jul 2005 09:20:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: Jan Blunck <j.blunck@tu-harburg.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ramfs: pretend dirent sizes
Message-ID: <20050721072003.GA17431@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.58.0507151151360.19183@g5.osdl.org> <20050716003952.GA30019@taniwha.stupidest.org> <42DCC7AA.2020506@tu-harburg.de> <20050719161623.GA11771@taniwha.stupidest.org> <42DD44E2.3000605@tu-harburg.de> <20050719183206.GA23253@taniwha.stupidest.org> <42DD50FC.9090004@tu-harburg.de> <20050719191648.GA24444@taniwha.stupidest.org> <20050720112127.GC3890@wohnheim.fh-wedel.de> <20050720181101.GB11609@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050720181101.GB11609@taniwha.stupidest.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 July 2005 11:11:01 -0700, Chris Wedgwood wrote:
> On Wed, Jul 20, 2005 at 01:21:27PM +0200, J?rn Engel wrote:
> 
> > To my understanding, you can lseek to any "proper" offset inside a
> > directory.  Proper means that the offset marks the beginning of a
> > new dirent (or end of file) in the interpretation of the filesystem.
> 
> But you can never tell where these are in general.

Correct.  Any filesystem can have any definition of proper.

> > Userspace doesn't have any means to figure out, which addresses are
> > proper and which aren't.  Except that getdents(2) moves the fd
> > offset to a proper address, which likely will remain proper until
> > the fd is closed.
> 
> I don't see why or how this can be true in general (it might be, but I
> don't see how myself).  If we are half way through scanning a
> directory and people start messing with it we could end up somewhere
> bogus (in which case f_op->readdir I guess is expected to try and do
> something sane here?)

If you read a large directory, it will take you quite a while to go
through the thousands of getdents() invocations.  Someone messing with
the directory meanwhile should be expected and shouldn't cause
userspace to get complete garbage.  If userspace doesn't learn about
all new dirents, that's fine.  If it receives old ones, that were
since deleted, that's fine.  But under no circumstances should you
hand out garbage.

Ext2, iirc, solves this problem by never shrinking directories.  Old
dirents can be invalid and won't get passed to userspace anymore.  But
they don't move around.  Hence, a linear read of the directory gives
you exactly above properties.

> > Reopening the same directory may result in a formerly proper offset
> > isn't anymore.
> 
> For that to be the case where is the state kept to ensure your current
> offset is valid?

Depends on the fs.  Ext2, as seen above, only needs file->offset as
state.  But image a questionable optimization for an uncommon case.
Whenever the last reader or an ext2 directory closes the fd, it is
safe to shuffle things around.  At this time, a "directory
defragmenter" takes the directory and squeezes all holes out of it.
The new, repacked directory consumes less space, which is nice.

Alternatively, the directory defragmenter could create a new
directory, copy all valid contents of the old one over, and new open()
on the directory will get the new copy, while old file descriptors
still point to the old one.

In both cases, what used to be a proper offset in one fd can be
complete bogus for another one.

And no, I don't want to add directory defragmenters to ext2.  It was
just a stupid example of what is possible.

Jörn

-- 
Linux [...] existed just for discussion between people who wanted
to show off how geeky they were.
-- Rob Enderle
