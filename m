Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVFVKF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVFVKF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 06:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVFVKDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 06:03:45 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:39943 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262867AbVFVJ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:59:22 -0400
To: akpm@osdl.org
CC: pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <20050622024423.66d773f3.akpm@osdl.org> (message from Andrew
	Morton on Wed, 22 Jun 2005 02:44:23 -0700)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	<20050621233914.69a5c85e.akpm@osdl.org>
	<E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
	<20050622004902.796fa977.akpm@osdl.org>
	<E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
	<20050622021251.5137179f.akpm@osdl.org>
	<E1Dl1Oz-0007Dq-00@dorka.pomaz.szeredi.hu> <20050622024423.66d773f3.akpm@osdl.org>
Message-Id: <E1Dl20U-0007Ic-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 11:58:54 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >  We could.  But that would again be overly restrictive.  The goal is to
> > > >  make the use of FUSE filesystems for users as simple as possible.  If
> > > >  the user has to manage multiple namespaces, each with it's own
> > > >  restrictions, it's becoming a very un-user-friendly environment.
> > > 
> > > I'd have thought that it would be possible to offer the same user interface
> > > as you currently have with private namespaces.  Hide any complexity in the
> > > userspace tools?  Where's the problem?
> > 
> > Sorry, I don't get it.
> 
> I'm asking you to expand on what the problems would be if we were to
> enhance the namespace code as suggested.

OK, what I was thinking, is that the user could create a new
namespace, that has all the filesystems remounted 'nosuid'.  This
wouldn't need any new kernel infrastructure, just a suid-root program
(e.g. newns_nosuid), that would do a clone(CLONE_NEWNS), then
recursively remount everything 'nosuid' in the new namespace.  Then
restore the user's privileges, and exec a shell.

In this namespace the user could mount things to his heart's content.
He could mount over system directories or even the root directory,
without being able to do any harm.

This is very nice, but a bit inpractical, since now all the other
programs of the user, his desktop environment, login shells etc. Won't
be able to see the userspace filesystems mounted in the private
namespace.

Of course he can enter the private namespace immediately after login,
but then he won't be able to send mail for example, because 'sendmail'
could be suid-mail or whatever.

I think the following must be true, for a namespace environment to be
useful:

 1) All the processes should be able to access the same files
    (including new mounts)

 2) User should be able to run suid/sgid programs


If the suid/sgid programs want to access the contents of a userspace
filesystem, that's tough.  You can't have that, because it's insecure.
But experience shows that this isn't a problem.  The exception is the
'mount' program itself, and that is why I'm slowly working towards
making sys_mount() and sys_umount() unprivileged.

Miklos
