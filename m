Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290587AbSCKTp2>; Mon, 11 Mar 2002 14:45:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSCKTpW>; Mon, 11 Mar 2002 14:45:22 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:42187 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S290767AbSCKTpE>;
	Mon, 11 Mar 2002 14:45:04 -0500
Date: Mon, 11 Mar 2002 19:49:00 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: <linux-kernel@vger.kernel.org>
Subject: Re: chroot_fs_refs and pivot_root question
In-Reply-To: <Pine.LNX.4.33.0203070131550.1091-100000@einstein.homenet>
Message-ID: <Pine.LNX.4.33.0203111946190.1798-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

even more curiously, swapoff is the _final_ answer.

who on Earth would have imagined that swapping-on increments the mnt_count
of the root filesystem? Very very curious.

So, initially, the mnt_count was too high but most references were dropped
by re-execing /sbin/init (I did have to hack /sbin/init to allow
re-execing in runlevel 0 though).

Then, I still had a problem because the refcount was surprizingly 2
instead of 1. Now I discovered that the extra reference was due to
swapping.

Regards,
Tigran

On Thu, 7 Mar 2002, Tigran Aivazian wrote:

> just for the record (and for the curious) -- the solution to this problem
> is to re-exec /sbin/init. I wonder if this sort of scenario is what Al
> Viro had in mind when he added the re-exec code to init in 1998...
>
> On Thu, 7 Mar 2002, Tigran Aivazian wrote:
>
> > On Thu, 7 Mar 2002, Tigran Aivazian wrote:
> >
> > > Amazing that nobody knew the answer but I think I understand now the
> > > reason, the /proc/1/cwd and /proc/1/root point to "/" and the comment
> > > above sys_pivot_root says:
> > >
> > >  * Note:
> > >  *  - we don't move root/cwd if they are not at the root (reason: if
> > > something
> > >  *    cared enough to change them, it's probably wrong to force them
> > > elsewhere)
> > >
> > > So, that is why the /sbin/init wasn't moved, because it's root/cwd were at
> >                                  ~~~~~~
> >
> > I often say "yes" instead of "no" (and other way around) :)
> >
> > It obviously _was_ moved and the problem is that it's executable's mapping
> > and the libc/ld mappings are keeping /sysroot busy...
> >
> > > /initrd so when it got pivoted to / (and / put to /sysroot) the init was
> > > left alone. Well, either the above policy is wrong or I need to figure out
> > > a way to convince init to move peacebly where I want it to... :)
> > >
> > > On Wed, 6 Mar 2002, Tigran Aivazian wrote:
> > >
> > > > Hello,
> > > >
> > > > Looking at (2.4.9's) sys_pivot_root() implementation I can see that it
> > > > moves all the processes' root/pwd references from the old root to the new
> > > > one.
> > > >
> > > > However, somehow /sbin/init managed to survive the move and is keeping the
> > > > filesystem busy:
> > > >
> > > > # lsof /sysroot
> > > > COMMAND PID     USER  FD   TYPE DEVICE    SIZE  NODE NAME
> > > > init      1        0 txt    REG  22,65   28220 11217 /sysroot/sbin/init
> > > > init      1        0 mem    REG  22,65  468849 10376
> > > > /sysroot/lib/ld-2.2.2.so
> > > > init      1        0 mem    REG  22,65 5636080 10370
> > > > /sysroot/lib/i686/libc-2.2.2.so
> > > >
> > > > # cat /proc/1/maps
> > > > 08048000-0804f000 r-xp 00000000 16:41 11217      /sysroot/sbin/init
> > > > 0804f000-08050000 rw-p 00006000 16:41 11217      /sysroot/sbin/init
> > > > 08050000-08054000 rwxp 00000000 00:00 0
> > > > 15556000-1556c000 r-xp 00000000 16:41 10376      /sysroot/lib/ld-2.2.2.so
> > > > 1556c000-1556d000 rw-p 00015000 16:41 10376      /sysroot/lib/ld-2.2.2.so
> > > > 1556d000-1556e000 rw-p 00000000 00:00 0
> > > > 15573000-15699000 r-xp 00000000 16:41 10370      /sysroot/lib/i686/libc-2.2.2.so
> > > > 15699000-1569f000 rw-p 00125000 16:41 10370      /sysroot/lib/i686/libc-2.2.2.so
> > > > 1569f000-156a3000 rw-p 00000000 00:00 0
> > > > 3fffe000-40000000 rwxp fffff000 00:00 0
> > > >
> > > > Any clues why and how to force it to exec a binary on the new root (or
> > > > get rid of it in any other way)?
> > > >
> > > > Regards,
> > > > Tigran
> > > >
> > > >
> > > >
> > > >
> > >
> > >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
>

