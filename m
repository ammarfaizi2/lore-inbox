Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281501AbRKPT0C>; Fri, 16 Nov 2001 14:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281502AbRKPTZo>; Fri, 16 Nov 2001 14:25:44 -0500
Received: from chmls20.mediaone.net ([24.147.1.156]:56815 "EHLO
	chmls20.mediaone.net") by vger.kernel.org with ESMTP
	id <S281501AbRKPTZh>; Fri, 16 Nov 2001 14:25:37 -0500
From: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Fri, 16 Nov 2001 14:14:23 -0500
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
Message-ID: <20011116141423.A11690@pimlott.ne.mediaone.net>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil,

I'm just a user (not a kernel hacker), but I strongly support this
idea.  It is unix-ish yet addresses the problem space aptly.  One of
the best parts in my view is that it allows devfs to expose multiple
views of the hardware (eg, organized by bus, by function, by uuid),
and the admin can then choose the most appropriate.  Another is that
it puts to rest claims that devfs is policy in the kernel, because
devlinks would give the admin the same flexibility he has with a
traditional /dev.

In fact, I have brought the same concept up in private mail with
Richard Gooch and at least once on this list:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.3/0563.html .
Albert Cahalan replied with a brief proposal that differs a bit from
yours:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.3/0574.html .

I also have a few comments on your implementation.

> To create a devlink, you use mknod on a pre-existing symlink.  The
> mknod must request a device (block or char) with device number 0,0.
> e.g.
>     ln -s tty /dev/TTY
>     mknod /dev/TTY b 0 0
> 
> This will create a devlink called "/dev/TTY" which points to the name
> "tty" in devfs space.

I think it would be a mistake to have the symlink implicitly rooted
in the devfs name space.  One, it breaks the principle of least
surprise.  Two, it means that the target of the symlink suddenly
changes (from /dev/tty to tty in the devfs namespace) when you do
the mknod.  Three, it precludes the possibility of extending
"devlinks" to point to normal files (in which case, devlink isn't
the right name), which I don't think should be dismissed.

I also think that lchmod might be a more elegant system call
interface.

>     ls -l /dev/TTY
> 
> will show the devlink.
> 
>     ls -lL /dev/TTY
> 
> will show the traditional device special file.

But this would require a patch to ls or libc, no?  I think this can
be done such that old tools still show something reasonable.

> Once you have turned a symlink into a devlink, chmod and chown will
> work directly on the devlink so you can change the permissions and
> ownership freely.  The ownership and permissions are automatically
> imposed on everything that the devlink points to.
> 
> A devlink can point to anything in the devfs namespace, not just
> devices. e.g
> 
>    ln -s ide /dev/ide
>    mknod /dev/ide b 0 0
> 
> will make /dev/ide be a devlink the the ide tree within devfs.
> Then
>    cd /dev/ide
> will work and allow you to move around the directory tree.  Everything
> in the directory tree will have the same ownership and permissions as
> the devlink has, except for the execute bits.   For directories, the
> execute bits are copied from the read bits. For non-directories, the
> execute bits are cleared. 

I haven't thought this through carefully, but I think applying too
much "devfs magic" to devlinks is a mistake.  I think the results
should be what a unix user would intuitively expect from a "symlink
with permissions".  So, I don't like the idea of a devlink giving
access recursively.  Some of the later ideas (eg, the pwd magic)
strike me as questionable as well.

> You cannot do
> 
>     ln -s '' /devices
>     mknod /devices b 0 0
> 
> and get the full devfs namespace under /devices, but only because
> of a shortcoming the the devfs code (that normally would never be
> asked to do this anyway).  It could fairly easily be fixed but it
> didn't seem worth the effort for this proof-of-concept.

This would be ugly and inconsistent anyway.  Nowhere else in unix
does an empty path make sense.  The only sane interpretation would
be an entry in the devfs root whose name is the empty string.

BTW, as to Alan's objections, I think they are greatly overblown.
With sane device registration API's, managing the namespace should
be no harder than managing the module name namespace.  And if
trademark owners come after us for calling things by their names, we
likely have bigger problems (all of userspace that refers to the
verboten device name would have to be changed).

The potential pain is worth it.  Once we get used to hierarchical
text names for kernel objects, we won't know how we did without
them.

Andrew
