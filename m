Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264298AbRFGDcZ>; Wed, 6 Jun 2001 23:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264300AbRFGDcP>; Wed, 6 Jun 2001 23:32:15 -0400
Received: from pop.gmx.net ([194.221.183.20]:44322 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S264298AbRFGDcD>;
	Wed, 6 Jun 2001 23:32:03 -0400
Message-ID: <3B1EF86E.9EDE50A7@gmx.de>
Date: Thu, 07 Jun 2001 05:43:42 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: symlink_prefix
In-Reply-To: <Pine.GSO.4.21.0106062112340.10233-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 7 Jun 2001, Edgar Toernig wrote:
> 
> > Alexander Viro wrote:
> > >         ...
> > >         dir = open("/usr/local", O_DIRECTORY);
> > >         /* error handling */
> > >         new_mount(dir, MNT_SET, fs_fd); /* closes dir and fs_fd */
> >
> > Do you really want to start using fds instead of strings for tree
> > modifying commands (link, unlink, symlink, rename, mount and umount)?
> > Even if it were possible in the new_mount case it wouldn't have the
> > atomic lookup+act nature of the old mount.  And then, _I_ would
> > prefer a uniform interface for tree management commands - strings.
> 
> You have exactly the same atomicity warranties. That is to say, none.
> Mountpoint can be renamed between the lookup and mounting.

Ok.  I thought, mounting is an atomic operation (though normally not
required).  Hmm... but looking at your last batch of VFS patches sent
to lkml you consider mount a more used call in the future ;-)  Maybe
it would be better to have some more strict rules for mount if ie each
login performs a dozen of them...

> Moreover, even after mount(2) you can rename() parent of mountpoint. On
> all Unices I've seen (well, aside of v7 which didn't have rename(2)).
> So if you rely on anything of that kind - you are screwed. Portably
> screwed, at that.

I thought more about a rename of ie "/usr/local" between the open and
the new_mount call.  I guess, an unlink("/usr/local") after the open
will let the new_mount fail.  Btw, what happens in this case of two
concurrent mounts?

	fd1=open("/foo")
	fd2=open("/foo")
	new_mount(fd1...)
	new_mount(fd2...)	// or vice versa, first fd2 then fd1

>[...] but even if your argument makes sense, it only makes sense for
> "dir" argument. "device" is nothing but a filesystem-specific option.

Sure.  I only meant the "dir" argument.

Maybe I've just an uneasy feeling about such a change because it exposes
and depends on internal implementation details of the kernel (the dcache).
On other systems it's normally not possible to associate a unique name
with a file descriptor.  Newer Linux versions may support this for
directories due to the dcache (not sure if this is really always the case).
And this calling convention for new_mount would be the first one that
makes this visible in userspace.  And it would depend on this feature.
This may limit future changes of the kernel VFS implementation (maybe
someone really adds some kind of hardlinked directories or something
else that makes it impossible to get a unique name for a dir fd).

Ciao, ET.
