Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157481AbQGaLc1>; Mon, 31 Jul 2000 07:32:27 -0400
Received: by vger.rutgers.edu id <S157252AbQGaLcQ>; Mon, 31 Jul 2000 07:32:16 -0400
Received: from pec-58-41.tnt4.b2.uunet.de ([149.225.58.41]:1621 "EHLO router.abc") by vger.rutgers.edu with ESMTP id <S157320AbQGaLcF>; Mon, 31 Jul 2000 07:32:05 -0400
Message-ID: <3985680D.49B19846@baldauf.org>
Date: Mon, 31 Jul 2000 13:50:37 +0200
From: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Organization: Medium.net
X-Mailer: Mozilla 4.74 [en] (Win98; U)
X-Accept-Language: en,de-DE
MIME-Version: 1.0
To: Xuan Baldauf <xuan--reiserfs@baldauf.org>
Cc: Russell King <rmk@arm.linux.org.uk>, reiserfs@devlinux.com, linux-kernel@vger.rutgers.edu
Subject: Re: (reiserfs) Re: sync: why disk cannot spin down
References: <200007302237.XAA11816@flint.arm.linux.org.uk> <3984B985.680B0ACF@baldauf.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: owner-linux-kernel@vger.rutgers.edu



Xuan Baldauf wrote:

> Russell King wrote:
>
> > Xuan Baldauf writes:
> > > this problem is possibly unrelated to reiserfs but related to
> > > linux-kernel, but now I can prove it: regular sync()s do prevent the
> > > spindown of (IDE) disks. There will be a call to sync() after 32 or less
> > > seconds have elapsed since the last sync(). Not a problem itself, but
> > > every sync spins up the disk again.
> >
> > You may want to have a look at the atime/diratime mount options, or
> > even chattr -A to prevent certain files causing a write when they're
> > run/read.
> >
> > Note that just executing "sync" causes its atime to be marked for update,
> > which will cause a write back to disk a short while later.
> >
> > [...]
>
> Thank you for waking me! :o) I forgot the atime issue. I wonder why it still
> is the default...
>

Now I made all my partitions noatime, and wow,

sync; hdparm -C -Y /dev/hda; sync; hdparm -C /dev/hda

does not necessarily spin up the disk!

Someone suggested noflushd (does anybody have pointers?), because every write
would trigger spin up, but that is okay for me, I'd like to have a system where
no writes are done else when needed. About a minute (some more or less seconds)
after spindown, the disk spins up again, but now I cannot find out the cause.

I tried to strace the whole system with

strace `ps x|grep -v PID|grep -v $PPID|awk {' print "-" "p " $1 '}`

but this was not very clueful, because if some process writes, the buffers are
only changed in memory. Then the disk spins down (spindown time set to 20
seconds). After some time, the disk spins up again, because kupdate sends the
buffers to disk. Unfortunately, this way I cannot find (time-)relations between
writes or write-like functions (like munmap) and disk access.

Is there a simple switch or a patch out there which makes every buffer (head)
release synchronous (yet not discarding the buffer, it is still needed so all
daemons can fully run in RAM).

Xuân.:o)



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
