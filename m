Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273053AbRIWInD>; Sun, 23 Sep 2001 04:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273324AbRIWImx>; Sun, 23 Sep 2001 04:42:53 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:764 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S273053AbRIWImj>;
	Sun, 23 Sep 2001 04:42:39 -0400
Date: Sun, 23 Sep 2001 04:43:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Cinege <dcinege@psychosis.com>
cc: linux-kernel@vger.kernel.org, LRP <linux-router@linuxrouter.org>,
        LRPD <linux-router-devel@linuxrouter.org>
Subject: Re: [PATCH] Initrd Dynamic v4.2 - New Feature: Tmpfs root support
In-Reply-To: <E15l3IH-0005Tu-00@schizo.psychosis.com>
Message-ID: <Pine.GSO.4.21.0109230415460.14886-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 23 Sep 2001, David Cinege wrote:

> Now, could you please explain to me how the hell you boot to a tmpfs
> root from userland!?!? This feature *creates* your userland.

And that's _all_ you need on the kernel side.

> Maybe you're just confused what this feature does. Maybe you've never
> worked with systems that run a volatile root. Maybe you've just never made
> a boot disk.

> Maybe you even think it's sane to compile userland into the kernel? <snicker 
> snicker> I just looked at your initramfs. From what I see it's the same 
> scheme I used to use In the Linux Router Project before I wrote 
> initrd-archive. Except I did it *entirely* in userland back in 1997. It 
> sucked. Badly.

Which somewhat contradicts the paragraph above (and common sense, while
we are at it).  BTW, I would really love to hear how TF did you manage
a non-breakable chroot jail 4 years ago _and_ in userland.

> > _Please_, let's stop
> > adding complexity to already ridiculously bloated late boot stages.
> 
> It's funny you've refered to my patch as bloated. What you've wrote (which is 
> a limited solution) weighs in at ~122k. Initrd Dynamic is ~35K complete and 

Not patch.  The late-boot logics itself.  BTW, while we are comparing patch
sizes, count how much is added and how much is removed.

> > David, no offence, but let's do it the right way.
> 
> It is done right. Infact, I'm proud that this release finally has implemented 
> it to perfection for the purposes it was designed. It took 3 years
> to get to this point of a completly dynamic, modular, ram based root.
> 
> It never fails, post a patch to kernel and they come out of the wood work 
> with delusional bitching. This is one reason I sat on releases for 9 months.
> BTW Offence intended...

... and failed.  Frankly, it takes more than that to offend.  As a flame
it's below mediocre.

As for the code... _all_ you need on the kernel side is "unpack <some_archive>
to ramfs/tmpfs and do exec()".  That's it.  The rest can be done in userland.
That includes the logics with loading ramdisk from initrd/floppies, handling
nfsroot, choosing final root device, yodda, yodda.  And yes, I consider
ripping that logics from the kernel space a Good Thing(tm).  Among other
things, it allows to replace deeply rotten code with invoking a couple of
syscalls.  I have no problems with using your code as a base for that, but
that should be done.  Current fs/super.c::mount_root() should go.  Again,
I've no problems with keeping that in form of sys_foo() called from the
kernel space (initramfs is incremental to exactly that - see init/do_mounts.c
in namespaces-patch).  But let's get all that logics into one place and
do it in clean way.  Even if we rip 90% of it in 2.5 (loading ramdisk from
multiple floppies with requests to change them - b0rken on powerpc, BTW;
or the lovely way we sometimes forget to ask to eject the damn thing -
have fun with that on Sun boxen), I'd rather see it done when we have
the sucker cleanly separated from the rest of the kernel.  Which is more
than 35Kb - just removing all that code from the multiple places it lives
now will take more.  Grep around for wait_for_keypress() and you'll see
what I mean.

