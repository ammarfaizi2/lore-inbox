Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281393AbRKPN3F>; Fri, 16 Nov 2001 08:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281395AbRKPN2z>; Fri, 16 Nov 2001 08:28:55 -0500
Received: from mail022.mail.bellsouth.net ([205.152.58.62]:44556 "EHLO
	imf22bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281393AbRKPN2h>; Fri, 16 Nov 2001 08:28:37 -0500
Message-ID: <3BF51469.5EC478B7@mandrakesoft.com>
Date: Fri, 16 Nov 2001 08:28:09 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: synchronous mounts
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au> <20011115214525.C14221@redhat.com> <3BF45B9F.DEE1076B@mandrakesoft.com> <20011116122855.C2389@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" wrote:
> On Thu, Nov 15, 2001 at 07:19:43PM -0500, Jeff Garzik wrote:
> > When working on something likely to crash, I always remount my
> > filesystems 'sync' with the intention to have the kernel immediately
> > sync to disk anything and everything it is coded to do.
> 
> The kernel has, in my memory, never behaved like that on sync mounts.
> mount -o sync was always intended just to give people the BSD-style
> sync metadata updates that some users expected.
> 
> The "mount" man page is wrong on this one.

No, that's always been a bug.  Occasionally it gets brought up on lkml
and people have talked about fixing it.


> > Since the
> > kernel is responsible to flushing data to disk, it makes perfect sense
> > to have an option to sync not only metadata but data to disk
> > immediately, if the user desires such.
> 
> If you want to sync _everything_, it's at least 5 seeks per write
> syscall when you're writing a new file: superblock, group descriptor,
> block bitmap, inode, data, and potentially inode indirect.
> 
> There's no point doing all that, especially since some of that data is
> redundant and will be rebuilt by e2fsck anyway after a crash.
> 
> Is it really such an important feature that we're willing to suffer a
> factor-of-100 or more slowdown for it?

mount -o dirsync, if you don't want the slowdown.

I can write a fast, incorrect implementation of 'sync' too.  Let's try
for a correct implementation.


> > Further, expecting all apps to fsync(2) files under the right
> > circumstances is not reasonable.  There are "normal" circumstances where
> > someone expects non-syncing behavior of "cat foo bar > foobar", and then
> > there are extentuating circumstances where another expects the shell to
> > sync that command immediately.  Should we rewrite cat/bash/apps to all
> > fsync, depending on an option?  Should we expect people to modify all
> > their shell scripts to include "/bin/sync" for those times when they
> > want data-sync?  Such is not scalable at all.
> 
> Not-scalable is doing 5000 seeks to write a 4MB file.
> 
> The behaviour you are talking about now, "cat foo bar > foobar" and
> expecting it to be intact on return, is *not the same thing*.  The
> sync mount option is there to order metadata writes for predictable
> recovery of the directory structure.  In the "cat" case, nobody cares
> what the inode is like during the write.  All that is desired in that
> example is fsync-on-close, and it is insane to implement
> fsync-on-close by writing every single block of the file
> synchronously.

The "sync" mount option's purpose is and should be this simple:
"All I/O to the file system should be done synchronously."

If you want different behavior, use a different option.

I still do not understand why you seem to think modifying tons of
programs and shell scripts is reasonable, in order to get "true" sync
behavior.


> At ALS, an ext3 user asked why ext3 performance was entirely unusable
> under mount -o sync (he had a broken config which accidentally set an
> ext3 mount synchronous), whereas ext2 was OK.  I only realised
> afterwards that this was because of ext3's ordered data writes:
> whereas ext2 was just syncing the inodes and indirect blocks on write,
> ext3 was syncing the data too as part of the ordered data guarantees,
> and performance was totally destroyed by the extra seeks.

Sure.  Seems perfectly normal and expected for an fs mounted 'sync'.


> "sync to keep the fs structures intact" and "sync to keep this file
> intact" are two totally different things.  In the latter case, we only
> care about the file contents as a whole, so fsync-on-close is far more
> appropriate.  If we want that, lets add it as a new option, but I
> don't see the benefit in making o- sync do all file data writes 100%
> synchronously.

The benefit is a correct implementation..

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

