Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132131AbRAPXFB>; Tue, 16 Jan 2001 18:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132600AbRAPXEv>; Tue, 16 Jan 2001 18:04:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:19048 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132131AbRAPXEk>; Tue, 16 Jan 2001 18:04:40 -0500
Date: Wed, 17 Jan 2001 00:05:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: tytso@valinux.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com, aviro@redhat.com
Subject: Re: Locking problem in 2.2.18/19-pre7? (fs/inode.c and fs/dcache.c)
Message-ID: <20010117000510.E19265@athlon.random>
In-Reply-To: <E14IbPR-0007Ye-00@beefcake.hdqt.valinux.com> <20010116203334.C19265@athlon.random> <E14IcR5-0008HB-00@beefcake.hdqt.valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14IcR5-0008HB-00@beefcake.hdqt.valinux.com>; from tytso@valinux.com on Tue, Jan 16, 2001 at 12:10:31PM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 12:10:31PM -0800, Theodore Y. Ts'o wrote:
> Actually, looking at the fast path of down_trylock compared to huge mess
> of code that's currently there, I actually suspect that using
> down_trylock() would actually be faster, since in the fast path case
> there would only two assembly language instructions, whereas the code

The fast path of the current code never hits the "huge mess" (aka wait_event
done with a seralizing spinlock). The main difference is that down() is using
an atomic logic, while `int block' runs out of order and it's serialized only
by the spinlock. I personally prefer current version because serializing
instructions are usually more expensive and I don't consider "huge mess" the
wait event interface as it makes perfect sense there IMHO.

> Ah, OK.  Well, we're currently tracking down a slow inode leak which is
> only happening on SMP machines, especially our mailhubs.  It's gradual,

How long does it takes to reproduce? BTW, I assume you can reproduce also with
vanilla 2.2.x latest kernels.

I suspect that the problem is the caller that is missing an iput or dput. (it
maybe also an userspace application, just check that nothing gets fixed by
SYSRQ+I before using the Big Red Button)

Note also that killing all apps won't decrease of 1 the number of inodes
allocated.  The inodes allocated will _never_ shrink (that's why we need the
hard limit inode-max).  Deleting all in-use inodes is the only way to have them
to showup in the freelist (and they still won't be freed but at least you'll
see that they're not leaked somewhere ;). So the debugging isn't very friendly
unless you play with the sources (2.4.x is much better).

> but if you don't reboot the machine before you run out of inodes, it
> will print the "inode-max limit reach" message, and then shortly after
> that lock up the entire machine locks up until someone can come in and
> hit the Big Red Button.  Monitoring the machine before it locks up, we

If SYSRQ+I doesn't help, can you try to reproduce with vanilla 2.2.19pre7aa1
(that also sets the inode-max and the inode-hash to a rasonable value for big
boxes, and it fixes the inode-hash function to avoid huge collisions)?

Recent 2.2.xaa are running on the same heavily loaded SMP boxes that was able
to reproduce the common code inode leak we had in mid 2.2.x.  They doesn't show
problems anymore since the last fix (that is the one we discussed in this
thread). So I tend to believe this could be a bug in some non-common or
unofficial piece of code or in userspace. But hey, this is just a guess.

> the machine died.  (Yeah, we could put a reboot command into crontab,
> but you should only need to do hacks like that on Windows NT machines.
> :-)

;)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
