Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261744AbRESKNx>; Sat, 19 May 2001 06:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbRESKNo>; Sat, 19 May 2001 06:13:44 -0400
Received: from ha2.rdc2.nsw.optushome.com.au ([203.164.2.51]:9095 "EHLO
	mss.rdc2.nsw.optushome.com.au") by vger.kernel.org with ESMTP
	id <S261741AbRESKNc>; Sat, 19 May 2001 06:13:32 -0400
Message-ID: <3B06472D.5BD1E73C@gnu.org>
Date: Sat, 19 May 2001 20:13:01 +1000
From: Andrew Clausen <clausen@gnu.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code 
 inuserspace
In-Reply-To: <Pine.GSO.4.21.0105190416190.3724-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> ioctls are evil, period. At least with these names you can use normal
> scripting and don't need any special tools. Every ioctl means a binary
> that has no business to exist.

Special names are butt-ugly.

ioctl's can be replaced with games on /proc or whatever, which are
better than special names.

> > What about partition editing on other OSs?  There's no reason
> > why fdisk/parted/etc. should be Linux only.  Why should the kernel
> > need to know how to write partition tables?
> 
> It needs to read them. Writing doesn't add much.

Wrong.  When you read, you throw out 90% of the useless crap.
When you write, you need to know about it, and provide
interfaces for it.

> I'd rather see
> trivial partitioning tools that consist only of UI code in case
> of Linux.

Some stuff friendly partition tools should have, IMHO:
(1) ability to predict what's going to happen.  That way, you can
play around until it looks nice, and hit the friendly commit
button.
(2) ability to do data recovery (eg: probe for signatures where
it expects the start of partitions to occur.  You can be
intelligent/quick about it, by knowing about alignment stuff,
for example)
(3) ability to convert between partition table types (and
even LVM ;-)  This can be tricky because of alignment stuff.

So:
(1) could be done in-kernel by being able to discard changes,
and re-reading, I guess.
(2) and (3) really only need alignment stuff.

Also, you need to be able to deal with legacy stuff, like
setting magic flags for booting.

> > Also, different partition table formats have different alignment
> > constraints (which is relevant for creating partitions).  These
> > mainly need to be respected for other braindead OS's and/or BIOSes.
> >
> > Communicating those between user/kernel space doesn't excite me.
> 
> So don't communicate them.

So, what do you do?

Sometimes, you want to force alignment violations (eg: recovering
an accidently deleted partition)

The real problem happens when you want to resize file systems, and
you need to simultaneously satisfy resizer and partition table
constraints.  (there are currently no resizers like this, but
an ext2-resize-the-start and NTFS-resize-the-start would definitely
be like this... when I get time to write them.  It's pure luck
that you don't need this for FAT, but this causes all sorts of
headaches for Linux...)

Anyway, you have one constraint in user space, and one in the
kernel... how do you find the intersection?
 
> > Libtool & friends deals with version skew (ugly, but it works...)
> 
> With statically linked binaries? How?

Why do we need them?
 
> > You can write wrappers for libraries.
> 
> Uh-huh. And you can write them for ioctls. We had been busily doing that
> for years. Results are not pretty, to put it very mildly.

If you can get everything into a nice file system interface,
then you've convinced me.

> BTW, most of the
> code can very well sit in the userland, but that's another story
> (userland filesystems). Anyway, there's only one way to settle such
> stuff - sit down and write the patch. Which is what I'm going to do.

Have fun.

So, my patch will be about 50 lines in parted, to call blkpg,
and provide a "kernelread" command... But, philosophy essay to
write... :-(  (you have to wait until Monday)

Then you can rm -r fs/partitions

But, I don't see how patches will settle anything, when we're
arguing over interfaces & stuff needed for partition tools.  Or
are you writing patches for Parted as well?

Andrew Clausen
