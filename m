Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268357AbRGZRJL>; Thu, 26 Jul 2001 13:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268358AbRGZRJD>; Thu, 26 Jul 2001 13:09:03 -0400
Received: from spring.webconquest.com ([66.33.48.187]:23812 "HELO
	mail.webconquest.com") by vger.kernel.org with SMTP
	id <S268357AbRGZRIr>; Thu, 26 Jul 2001 13:08:47 -0400
Date: Thu, 26 Jul 2001 13:08:53 -0400 (EDT)
From: <sentry21@cdslash.net>
To: <linux-kernel@vger.kernel.org>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Christopher Allen Wing <wingc@engin.umich.edu>,
        <Wayne.Brown@altec.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Horst von Brand <vonbrand@inf.utfsm.cl>,
        Andreas Dilger <adilger@turbolinux.com>
Subject: Re: Weird ext2fs immortal directory bug (all-in-one)
In-Reply-To: <0107261744040P.00907@starship>
Message-ID: <Pine.LNX.4.30.0107261149220.18300-100000@spring.webconquest.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In order to avoid flooding the list and everyone else with replies to all
the e-mails I've recieved, I'm going to put them all in one. Hope this
doesn't cause anyone problems.

One of the suggestions -did- work, but I thought I should post replies to
the rest of the suggestions where possible, so that people know what
worked and what didn't.

Here's the summary:

----

>From Daniel Phillips <phillips@bonn-fries.net>:

> > sentry21@Petra:1:/lost+found$ cd \#3147/
> >
> > sentry21@Petra:0:/lost+found/#3147$ ls
> > #3147@
>
> It's linked to itself.

Yes, it's a directory as well as a symlink to itself. It, quite frankly,
should not exist. Go figure.

----

>From Christopher Allen Wing <wingc@engin.umich.edu>:

> You can remove it using the 'debugfs' program. The safest way to do this
> is to boot your machine to single user mode, and then do:
>
> mount -o remount,rw /
> sync
> debugfs -w /dev/device_that_/_is_mounted_on
>
> then at the debugfs: prompt
>
> cd /lost+found
> rm #3147
> close
> quit
>
>
> Then:
> sync
> reboot
>
> and it should be gone.

This worked admirably, my thanks.

----

>From Wayne.Brown@altec.com:

> Try lsattr ./#3147 and see if the i attribute is set.  If so, then (as
> root) do chattr -i ./#3147 and try again to remove it.

I tried this, after doing 'chattr -AacdijsSu ./#3147' (which did not
help), and tried removing after both, which did not work.

----

>From  Richard B. Johnson <root@chaos.analogic.com>:

> Okay, the file is a link, linked to /lost+found. So, using debugfs,
> just remove the directory:
> # debugfs -w /dev/hda5
> debugfs: rmdir /lost+found
>
> My debugfs is too old, so the above command replies with "Unimplemented".

As did mine - the version in Debian Unstable, which I assume is the latest
(debugfs 1.22, 22-Jun-2001 for EXT2 FS 0.5b, 95/08/09).

----

>From Horst von Brand <vonbrand@inf.utfsm.cl>:

> What machine is that? e2fsprogs-1.22 had some similar weird effects on
> SPARC with kernel 2.4.x, 1.20 works fine AFAICS.

i386, pretty standard boring stuff.

> You can try nuking the directory (clear_inode or such) and have fsck(8)
> pick up the resulting fallout.

This was going to be my next step, if the suggestion that worked hadn't.

----

>From Andreas Dilger <adilger@turbolinux.com>:

> Run "debugfs -w /dev/hdX", and then:
>
> debugfs> mi <3147>
> # set Mode to 0
> # set Deletion time to something other than 0
> # set Link count to 0
> # set Block count to 0
> # set File flags to 0
> debugfs> freei <3147>
> debugfs> q
>
> e2fsck -f /dev/hdX

e2fsck complained about the file not being attached, and attached it to
lost+found - basically, the exact same thing that happened in the first
place. Go figure. Suffice to say, this also did not work.

----

>From Richard B. Johnson <root@chaos.analogic.com>:

> If you try that from a shell, it may fail because '#' means
> "ignore everything thereafter", so you are trying to do muck
> with the directory. I think:
>
> chattr -i ./\#3147 had ought to do it.

bash (and likely others) will figure out that #filename is a directory if
the # is part of a string blah#blah, and will only treat it as a comment
if there is a space in front of it.

----

Thank you all for your help and efforts in solving this extremely peculiar
bug. I still have no idea why it happened, but now that it's gone, cron
should rest happily at night.

Cheers.

--Dan


