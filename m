Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274686AbRITWoL>; Thu, 20 Sep 2001 18:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274687AbRITWoC>; Thu, 20 Sep 2001 18:44:02 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:38317 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S274686AbRITWny>;
	Thu, 20 Sep 2001 18:43:54 -0400
Date: Thu, 20 Sep 2001 18:44:18 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
In-Reply-To: <20010921003136.H729@athlon.random>
Message-ID: <Pine.GSO.4.21.0109201835320.5631-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Sep 2001, Andrea Arcangeli wrote:

> Of course, however if you want I can first fix initrd (I was just
> looking into it in the last minutes), the security fix broke initrd
> badly unfortunately [didn't tested initrd but just the ramdisks before
> posting it] (not sure why initrd broke at the moment but I believe the
> design of the fix was the right one, so it is probably an implementation
> detail). So unless you need it urgently I will try to fix initrd first,
> then I will send to you so you can go ahead without risk of future rejects.

I'd suggest to stop treating initrd as block device.  It has to keep
S_IFBLK in mode bits, indeed, but I'd rather set ->f_op upon open() and
stop worrying about it.

We don't need buffer-cache access to it anyway - if you look carefully
you will see that we actually copy its contents to normal ramdisk
first.  So just having ->read() (essentially copy_to_user()) is
perfectly OK. 

Check how old code was dealing with it - it's really the best way to
treat that sucker.  We probably will be better off if we make it a
character device at some point in 2.5 and move the thing to char/mem.c,
but anyway, it had never been a proper block device (== one with
requests queue, etc.) and there's no point in making it such now.

Again, the proper way to treat it is to convert it into character
device at some point.  Userland won't actually care - after the
boot it's gone.  And kernel is using it only via ->read(), so
there's no point trying to make it similar to real ramdisks.

