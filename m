Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274694AbRITXDe>; Thu, 20 Sep 2001 19:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274693AbRITXDY>; Thu, 20 Sep 2001 19:03:24 -0400
Received: from [195.223.140.107] ([195.223.140.107]:17142 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274689AbRITXDM>;
	Thu, 20 Sep 2001 19:03:12 -0400
Date: Fri, 21 Sep 2001 01:03:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010921010340.L729@athlon.random>
In-Reply-To: <20010921003136.H729@athlon.random> <Pine.GSO.4.21.0109201835320.5631-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109201835320.5631-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Sep 20, 2001 at 06:44:18PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2001 at 06:44:18PM -0400, Alexander Viro wrote:
> 
> 
> On Fri, 21 Sep 2001, Andrea Arcangeli wrote:
> 
> > Of course, however if you want I can first fix initrd (I was just
> > looking into it in the last minutes), the security fix broke initrd
> > badly unfortunately [didn't tested initrd but just the ramdisks before
> > posting it] (not sure why initrd broke at the moment but I believe the
> > design of the fix was the right one, so it is probably an implementation
> > detail). So unless you need it urgently I will try to fix initrd first,
> > then I will send to you so you can go ahead without risk of future rejects.
> 
> I'd suggest to stop treating initrd as block device.  It has to keep
> S_IFBLK in mode bits, indeed, but I'd rather set ->f_op upon open() and
> stop worrying about it.
> 
> We don't need buffer-cache access to it anyway - if you look carefully
> you will see that we actually copy its contents to normal ramdisk
> first.  So just having ->read() (essentially copy_to_user()) is
> perfectly OK. 

of course, we never used initrd blkdev, we just use the ramdisk always
from userspace.  Initrd doesn't need to be a blockdev, we could just
copy the ram ourself and just call ->write on the ramdisk. userspace
just sees /dev/ram0, /dev/initrd is a kernel internal thing that doesn't
need to be visible, and if anybody uses /dev/initrd somehow that just
insane (and it doesn't even look possible to make anything useful out of
/dev/initrd anyways).

> Check how old code was dealing with it - it's really the best way to
> treat that sucker.  We probably will be better off if we make it a
> character device at some point in 2.5 and move the thing to char/mem.c,
> but anyway, it had never been a proper block device (== one with
> requests queue, etc.) and there's no point in making it such now.
> 
> Again, the proper way to treat it is to convert it into character
> device at some point.  Userland won't actually care - after the
> boot it's gone.  And kernel is using it only via ->read(), so
> there's no point trying to make it similar to real ramdisks.

1) I am tentated to fix the initrd bug by just killing initrd blkdev,
completly instead of going to mark PageSecure all the initrd pages.

2) Otherwise I can make a brute hack one liner approch with a global
field that ignores the PageSecure bit on reads until I finished to fill
in the /dev/ram0 :) (slowdown production paths for a boot thing but
doesn't matter, but ok we aren't writing proprietary software here and
this isn't the right thing ;)

3) I can just mark the initrd pages as PageSecure, then I can safely
forget about them.

What do you prefer for the next 2.4.10 mainline? I'd like to have this
fixed _fast_ and to be included in mainline, since the security problem
is ugly (not too bad though since /dev/ram0 is readable only by root by
default) and because people really needs initrd.

Suggestions are very welcome.

Andrea
