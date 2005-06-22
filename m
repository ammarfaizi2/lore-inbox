Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVFVJMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVFVJMy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVFVJLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 05:11:12 -0400
Received: from 238-071.adsl.pool.ew.hu ([193.226.238.71]:9226 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262904AbVFVJH5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 05:07:57 -0400
To: akpm@osdl.org
CC: pavel@ucw.cz, linux-kernel@vger.kernel.org
In-reply-to: <20050622004902.796fa977.akpm@osdl.org> (message from Andrew
	Morton on Wed, 22 Jun 2005 00:49:02 -0700)
Subject: Re: -mm -> 2.6.13 merge status (fuse)
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	<20050621233914.69a5c85e.akpm@osdl.org>
	<E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu> <20050622004902.796fa977.akpm@osdl.org>
Message-Id: <E1Dl1Ce-0007BO-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jun 2005 11:07:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But the problem you're addressing here largely revolves around the fact that
> the filesystem implementation is a userspace process which is potentially
> owned by a different user.  So you need to prevent the mount owner from
> peeking at the fs user's activity.  That problem is unique to FUSE and so a
> solution within fuse is appropriate.

It's in fact not so unique to FUSE.  It would equally well apply to
v9fs or even samba, since both want to allow unprvileged mounts, and
synthetic (or at least user-controlled) file serving.

> This security feature doesn't sounds terribly important to me.  So the fuse
> server can find out what files I'm looking at.  But I've already
> deliberately given the fuse server the ability to ptrace my process?

If it's deliberate, than OK. 

However with suid/sgid, this is not a deliberate action of the user
under whose capabilities the process runs.  Neither in the case, when
it's a daemon doing some recursive directory traversal.

And it's not just peeking at the filesystem access patterns.  A much
more dangerous aspect is controlling _when_ an operation returns
(e.g. delaying it forever), and _what_ it returns (e.g. huge
files/directories).

Of course, this is only truly relevant for systems with untrusted
users.  But I do want to make FUSE work securely in those cases too.

For the single user system, the sysadmin can turn this feature off,
and be done with it.

> Can we enhance private namespaces so they can squash setuid/setgid?  If so,
> is that adequate?

We could.  But that would again be overly restrictive.  The goal is to
make the use of FUSE filesystems for users as simple as possible.  If
the user has to manage multiple namespaces, each with it's own
restrictions, it's becoming a very un-user-friendly environment.

Thanks,
Miklos
