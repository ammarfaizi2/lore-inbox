Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750857AbVJHKBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750857AbVJHKBn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 06:01:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbVJHKBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 06:01:43 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:38411 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750853AbVJHKBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 06:01:42 -0400
To: felixmoeller@gmx.de
CC: jam@McQuil.com, linux-kernel@vger.kernel.org
In-reply-to: <43479019.6070803@gmx.de> (message from
	=?ISO-8859-1?Q?Felix_M=F6ller?= on Sat, 08 Oct 2005 11:23:37 +0200)
Subject: Re: pivot_root doesn't work for me in 2.6.14-rc3
References: <Pine.LNX.4.62.0510061555190.12337@www.mcquillansystems.com> <43479019.6070803@gmx.de>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Message-Id: <E1EOBVd-0006La-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 08 Oct 2005 12:00:53 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix, thanks for the forward.  Please "reply to all" when posting on
LKML.

> Hi James,
> > I've found a problem with pivot_root that worked fine in 2.6.13.3, but
> > fails for me, starting in 2.6.14-rc3  (haven't tried rc1 or rc2).
> > 
> > This is for LTSP.org (Linux Terminal Server Project) thin clients.
> > 
> > In our initramfs, we have a '/init' script that creates a mountpoint for
> > a 2nd ramfs, and i'm trying to pivot_root to that mount point.
> > 
> > I'm getting:
> > 
> >    pivot_root: Invalid Argument
> > 
> > This worked perfectly in 2.6.13.3, so I looked at the 2.6.14-rc3 patch,
> > and I found the code in fs/namespace.c that is causing it to fail for
> > me:
> > 
> > @@ -1334,8 +1332,12 @@ asmlinkage long sys_pivot_root(const cha
> >         error = -EINVAL;
> >         if (user_nd.mnt->mnt_root != user_nd.dentry)
> >                 goto out2; /* not a mountpoint */
> > +       if (user_nd.mnt->mnt_parent == user_nd.mnt)
> > +               goto out2; /* not attached */
> >         if (new_nd.mnt->mnt_root != new_nd.dentry)
> >                 goto out2; /* not a mountpoint */
> > +       if (new_nd.mnt->mnt_parent == new_nd.mnt)
> > +               goto out2; /* not attached */
> >         tmp = old_nd.mnt; /* make sure we can reach put_old from
> > new_root */
> >         spin_lock(&vfsmount_lock);
> >         if (tmp != new_nd.mnt) {
> > 
> > 
> > The first of the 2 new tests are causing the pivot_root to fail for me.
> > If I comment out those lines, it works again.
> > 
> > I'm thinking that somebody put those lines there for a reason, so
> > there's possibly something wrong with the way i've been doing this for a
> > long time, and the tightening of the code has uncovered my problem.
> Miklos Szeredi put these lines there with the following comment:
> "[PATCH] pivot_root() circular reference fix
> 
> Fix http://bugzilla.kernel.org/show_bug.cgi?id=4857
> 
> When pivot_root is called from an init script in an initramfs 
> environment, it causes a circular reference in the mount tree.
> 
> The cause of this is that pivot_root() is not prepared to handle 
> pivoting an unattached mount. In an initramfs environment, rootfs is the 
> root of the namespace, and so it is not attached.
> 
> This patch fixes this and related problems, by returning -EINVAL if 
> either the current root or the new root is detached."
> 
> > I'll explain how we use the initramfs/nfsroot:
> > [...]
> > 
> > Somebody recently told me that pivot_root has been put in the 'evil way
> > to do things' category, and that there was a new way, but he couldn't
> > remember what that was.
> googeling a little bit I found the following link:
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=137005
> 
> Felix Möller

Here's a post by Richard Fish explaining how to go about changing root
in initramfs:

> Tim Sia wrote:
> 
> >
> >
> > From reading the kernel bug tracker:
> >
> > http://bugzilla.kernel.org/show_bug.cgi?id=4857
> >
> > I got the impression that pivot_root is not supported from inside 
> > initramfs.  I can change my initramfs
> > init script not to do pivot root, but the question is  will I be able 
> > to unumount the initramfs root
> > once I chrooted to the "real root fs" ?
> >
> 
> Tim,
> 
> The short answer is "no".
> 
> I am guessing you want to unmount the initramfs to free the memory it is 
> using.  You can do this by simply deleting everything from the initramfs 
> before you chroot.  If you use only statically linked utilities in your 
> initramfs, like busybox, then "rm -rf /etc /bin /sbin ..." will do the 
> trick.  Just make sure your PATH has the bin and sbin directories from 
> your real root filesystem listed first, and run hash -r if necessary 
> before removing the files.  You will also need to symlink /lib to the 
> lib directory on your real root filesystem to run dynamically linked 
> programs (like chroot) from there.  And obviously, be careful that you 
> don't "rm -rf" your real root in the process (like I did once)!!
> 
> If you use dynamically linked utilities (like me), things are bit more 
> complicated, because once you remove /lib/ld-*.so, you cannot run any 
> dynamically linked programs.  I was able to work around this by creating 
> symlinks like this (my real root mounts on /new_root):
> 
> /lib -> /new_root/lib
> /new_root/lib -> ../libdir
> 
> All my dynamic libraries go in /libdir.  The mount of /new_root hides 
> the symlink to ../libdir, so as soon as root is mounted and I run hash 
> -r, all programs and libraries are automatically loaded from /new_root, 
> and I can delete /libdir without any problems.
> 
> If you have other questions for me, feel free to ask.  Unfortunately 
> things are very busy at work, and I will be travelling some next week, 
> so I cannot promise 'real-time' answers.  But if I can help, I will.
> 
> Cheers,
> -Richard
