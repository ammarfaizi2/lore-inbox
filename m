Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272345AbRIQKE0>; Mon, 17 Sep 2001 06:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272404AbRIQKEQ>; Mon, 17 Sep 2001 06:04:16 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:22022 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S272345AbRIQKEJ>; Mon, 17 Sep 2001 06:04:09 -0400
Date: Mon, 17 Sep 2001 12:04:28 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
Message-ID: <20010917120428.A13815@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Sep 2001, Alexander Viro wrote:

> It's _very_ useful in a lot of situations - basically, that's what
> umount -f should have been.  E.g. suppose that /usr is kept busy
> by something (NFS hard mount/hung process/fs bug/whatever).  Right now
> we can't do anything about that - it will keep mountpoint busy.
> umount("/usr", MNT_DETACH) will do the following:
> 	a) detach the damned thing from /usr. Nothing is mounted here
> anymore.
> 	b) umount /usr/local, etc. - no matter what state /usr is in and
> how badly it's b0rken.
> 	c) as soon as that fs becomes not busy it will be deactivated
> (put_super(), etc.)
> 	d) if /usr/local wasn't busy - fine, it gets deactivated
> immediately. If it was - no problem, it will be deactivated as soon
> as it isn't busy anymore.

Well, from a practical point of view two things that would really help
Linux:

1) Be able kill -9 processes from "D" state.

2) Force unmount busy file systems and kill -9 all related processes.

Your idea is getting close to 2) which would relieve the dire need for
2) somewhat, but if your patch really prevents that beast from being
remounted until it's flushed, in the above scenario, a reboot will be
required if I want /usr or /usr/local back.

My personal experience from production use: I automount NFS filesystems
onto /net from several other hosts. When one of these NFS servers goes
down, there is ABSOLUTELY NO WAY of getting rid of the mounts besides
losing unrelated data (i. e. unmount in background, killall -9 rpciod -
will possibly lose data written to other servers).

Now, then the server is back up and I unmounted the old beast, I need to
be able to remount that file system without reboot. Looks like a deeply
sleeping (state == 'D') process might prevent that, and that'd render
the whole good idea no good.

So, if I e. g. umount "/usr", MNT_DETACH, I must be able to reattach it,
lest I wand MNT_DETACH to give me yet another reason to reboot -- which
would probably need to be made through mount -o remount,ro -a -v ; sync
; reboot -f to overcome those "busy" locks that don't recover.

If I could nuke away a process from "D" state with kill -9, all that
would hardly matter, the killall5 before unmount would get rid of all
those hung processes and the shutdown would always succeed. If the
reboot succeeds, well, that's a matter of whether you use hard disk
write caches or journalling/phase tree file systems, BIOS and weather...


If FreeBSD had client-side NFS locking support, I'd have switched long
ago, just because it does umount -f and Linux' ever-rising load with
stuck processes really annoys me and has brought one of my production
machines down more than once. Soft NFS mounts are not really an option.
