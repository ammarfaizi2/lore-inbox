Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSGEPOC>; Fri, 5 Jul 2002 11:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317464AbSGEPOB>; Fri, 5 Jul 2002 11:14:01 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:17680 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S317214AbSGEPOA>; Fri, 5 Jul 2002 11:14:00 -0400
Date: Fri, 5 Jul 2002 11:16:34 -0400
Message-Id: <200207051516.g65FGYY20854@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: prevent breaking a chroot() jail?
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-07-05, Shaya Potter <spotter@cs.columbia.edu> wrote:

> On Fri, 2002-07-05 at 10:02, Miquel van Smoorenburg wrote:
> > In article <1025877004.11004.59.camel@zaphod>,
> > Shaya Potter  <spotter@cs.columbia.edu> wrote:
> > > I'm trying to develop a way to ensure that one can't break out of a
> > > chroot() jail, even as root.  I'm willing to change the way the
[snip]
> > Run as root and you're out of the chroot jail. This is because
> > chroot() doesn't chdir() to the new root, so after a chroot() in
> > the chroot jail you're suddenly out of it.

> yes, that's what the man page says.  Is that the only hole? i.e. if one
> changed the semantics of chroot() to also do a chdir() to the new root,
> would that be fixed? (not arguing on changing this for everything, just
> for something specific)

No, there are many ways that root can break out of chroot(2).  I maintain
some patches[1] against 2.2 (and grsecurity[2] has ported most of them to
2.4) which aim to try to make it harder for root to break out of chroot(2),
but I won't say I've got them all--in fact I'll say I'm sure I *don't* have
them all, and I'd like to hear suggestions for more.  Here are some things
to worry about:

-chroot(2)'ing with an open directory fd
-prevent chroot(2) by a process already chrooted ("double-chroot")
-block mount(2) attempts inside chroot ("chroot(../..)" ...)
-block mknod of char or block devices inside chroot ("mknod /dev/hda",
   "mknod /dev/kmem")
-block chmod +s by a chrooted process
-block ptrace(2) by a chrooted process of processes outside the jail
-block most signals by a chrooted process to processes outside the jail
-block setting capabilities (capset) by a chrooted process of processes 
   outside the jail
-drop "dangerous" capabilities when chroot(2)'ing.  (See the patch, but
   basically, various *_ADMIN, *RAW*, etc to block ioctl, sysctl for
   dangerous things.)

One area I have not looked at sufficiently is sysv IPC (shared memory,
semaphores...).  It's quite possible that a chrooted process can tamper
with shared memory segments that other, outside-chroot processes are using
(especially if some app is designed to use them to communicate across the
chroot boundary; I don't know of any but they could exist) and use that
vector to attack and try to subvert the other, non-chrooted process(es).

I'd appreciate any suggestions in addition to the above, and/or holes poked
in the implementation (which I'm sure isn't the best...).

[1] http://www.theaimsgroup.com/~hlein/hap-linux/
[2] http://www.grsecurity.org/

Thanks,

--
Hank Leininger <hlein@progressive-comp.com> 
