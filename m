Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317499AbSGEQP3>; Fri, 5 Jul 2002 12:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317500AbSGEQP2>; Fri, 5 Jul 2002 12:15:28 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:2684 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317499AbSGEQP0>; Fri, 5 Jul 2002 12:15:26 -0400
Date: Fri, 5 Jul 2002 19:17:51 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: Hank Leininger <hlein@progressive-comp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: prevent breaking a chroot() jail?
Message-ID: <20020705161750.GO1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Hank Leininger <hlein@progressive-comp.com>,
	linux-kernel@vger.kernel.org
References: <200207051516.g65FGYY20854@marc2.theaimsgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207051516.g65FGYY20854@marc2.theaimsgroup.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2002 at 11:16:34AM -0400, you [Hank Leininger] wrote:
>
> No, there are many ways that root can break out of chroot(2).  I maintain
> some patches[1] against 2.2 (and grsecurity[2] has ported most of them to
> 2.4) which aim to try to make it harder for root to break out of chroot(2),
> but I won't say I've got them all--in fact I'll say I'm sure I *don't* have
> them all, and I'd like to hear suggestions for more.  Here are some things
> to worry about:

I was skimming through FreeBSD jail(2) documents
(http://docs.freebsd.org/44doc/papers/jail/jail.html). 

Compared to jail
(http://docs.freebsd.org/44doc/papers/jail/jail-5.html#section5):
 
> -chroot(2)'ing with an open directory fd
> -prevent chroot(2) by a process already chrooted ("double-chroot")

Jail thwarts these.

> -block mount(2) attempts inside chroot ("chroot(../..)" ...)
> -block mknod of char or block devices inside chroot ("mknod /dev/hda",
>    "mknod /dev/kmem")

Also prohibited in jail.

> -block chmod +s by a chrooted process

Jail appears to allow this, and you can't get out of jail as (jailed) root
anyway.

> -block ptrace(2) by a chrooted process of processes outside the jail

I believe jail prohibits this as well (through its p_trespass() mechanism).

> -block most signals by a chrooted process to processes outside the jail

Likewise - it blocks all signals in and out from jail.

> -block setting capabilities (capset) by a chrooted process of processes 
>    outside the jail

(No idea)

> -drop "dangerous" capabilities when chroot(2)'ing.  (See the patch, but
>    basically, various *_ADMIN, *RAW*, etc to block ioctl, sysctl for
>    dangerous things.)

Jail takes care of this by only allowing 35 operations for jailed root (out
of the 260 allowed for normal root). Capabilies are propably better in linux
context.

> One area I have not looked at sufficiently is sysv IPC (shared memory,
> semaphores...).  It's quite possible that a chrooted process can tamper
> with shared memory segments that other, outside-chroot processes are using
> (especially if some app is designed to use them to communicate across the
> chroot boundary; I don't know of any but they could exist) and use that
> vector to attack and try to subvert the other, non-chrooted process(es).

I would imagine the p_trespass() check is used in FreeBSD to disallow any
memory sharing between processes that are not in the same jail.

In addition to what has been mentioned above, jail(2) notably limits jailed
processes to one ip number (that of jail's). That way the jailed processes
can't connect to hosts services (even through localhost interface) unless
they listen to jail's ip, nor bind to any ip but the one that has been
granted to the jail. They also do not allow any ipconfig, routing or kernel
parameter changes etc from within a jail.
 
In general, I wonder if it would make sense to aim for something like
jail(2). Chroot has its shortcomings, and I take it that many of them have
to be preserved to maintain standard compliance. Jail isolates processes
more completely than chroot is ever ment to.

FreeBSD implements jail by adding a jail pointer to struct proc - I'm not
sure how much of that should/could be done with mere capabilities in linux,
and how much of the "fortificated chroot" implementation jail has overlaps
with Al Viro's namespaces.

All in all, I've seen suprisingly little conversation about jail on
lkml. What do people think of it?


-- v --

v@iki.fi
