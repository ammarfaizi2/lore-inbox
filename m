Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262935AbVFVHz1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262935AbVFVHz1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 03:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVFVHyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:54:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4805 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262895AbVFVHth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 03:49:37 -0400
Date: Wed, 22 Jun 2005 00:49:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: miklos@szeredi.hu, pavel@ucw.cz, linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-Id: <20050622004902.796fa977.akpm@osdl.org>
In-Reply-To: <E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
References: <20050620235458.5b437274.akpm@osdl.org>
	<E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu>
	<20050621142820.GC2015@openzaurus.ucw.cz>
	<E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu>
	<20050621220619.GC2815@elf.ucw.cz>
	<E1Dkyas-0006wu-00@dorka.pomaz.szeredi.hu>
	<20050621233914.69a5c85e.akpm@osdl.org>
	<E1DkzTO-00072F-00@dorka.pomaz.szeredi.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > It would be helpful if we could have a brief description of the feature
> > which you're discussing here.  We discussed this a couple of months back,
> > but I've forgotten most of it and it was off-list I think.
> > 
> > Doing `grep uid fs/fuse/*.c' gets us to the implementation, yes?
> > 
> > Which parts are controversial?
> 
> The controversial part is fuse_allow_task() called from
> fuse_permission() and fuse_revalidate() (fs/fuse/dir.c).
> 
> This function (as explained by the header comment) disallows access to
> the filesystem for any task, which the filesystem owner (the user who
> did the mount) is not allowed to ptrace.

That's fairly weird.  Overloading ptraceability is awkward, but also the
*direction* is wrong.  It's saying "if I can ptrace you, you can read my
data".  I'd have expected to see "if you can ptrace me, you can access my
data".

> The rationale is that accessing the filesystem gives the filesystem
> implementor ptrace like capabilities (detailed in
> Documentation/filesystems/fuse.txt)

hrm.  Makes some sense.

> It is controversial, because obviously root owned tasks are not
> ptrace-able by the user, and so these tasks will be denied access to
> the user mounted filesystem (-EACCESS is returned on stat() or any
> other file operation).
> 
> However nobody raised _any_ concrete technical problem associated with
> this, and the 4 years of widespread use didn't turn up any either.  So
> IMO it's "ugly" only in people's heads and not in reality.

It's ugly ;)

But the problem you're addressing here largely revolves around the fact that
the filesystem implementation is a userspace process which is potentially
owned by a different user.  So you need to prevent the mount owner from
peeking at the fs user's activity.  That problem is unique to FUSE and so a
solution within fuse is appropriate.

This security feature doesn't sounds terribly important to me.  So the fuse
server can find out what files I'm looking at.  But I've already
deliberately given the fuse server the ability to ptrace my process?

Can we enhance private namespaces so they can squash setuid/setgid?  If so,
is that adequate?


