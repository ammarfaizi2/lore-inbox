Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281547AbRKPUml>; Fri, 16 Nov 2001 15:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281550AbRKPUmb>; Fri, 16 Nov 2001 15:42:31 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:15020 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S281547AbRKPUmR>; Fri, 16 Nov 2001 15:42:17 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: andrew@pimlott.ne.mediaone.net (Andrew Pimlott)
Date: Sat, 17 Nov 2001 07:42:24 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15349.31280.118400.252913@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: message from Andrew Pimlott on Friday November 16
In-Reply-To: <15348.58752.207182.488419@notabene.cse.unsw.edu.au>
	<20011116141423.A11690@pimlott.ne.mediaone.net>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday November 16, andrew@pimlott.ne.mediaone.net wrote:
> Neil,
> 
> I'm just a user (not a kernel hacker), but I strongly support this
> idea.  It is unix-ish yet addresses the problem space aptly.  One of
> the best parts in my view is that it allows devfs to expose multiple
> views of the hardware (eg, organized by bus, by function, by uuid),
> and the admin can then choose the most appropriate.  Another is that
> it puts to rest claims that devfs is policy in the kernel, because
> devlinks would give the admin the same flexibility he has with a
> traditional /dev.

Thankyou.

> 
> In fact, I have brought the same concept up in private mail with
> Richard Gooch and at least once on this list:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.3/0563.html .
> Albert Cahalan replied with a brief proposal that differs a bit from
> yours:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0103.3/0574.html .

Substantial similarities, yes.
The idea of "setuid symlinks" is cute, and I have toyed with it.  But
implementing a general "setuid symlink" that could point anywhere
would require very intrusive changes to the VFS layer.
That doesn't necessarily mean that it is a bad thing, but you would
have to weight the cost/benefit carefully.

> 
> I also have a few comments on your implementation.
> 
> > To create a devlink, you use mknod on a pre-existing symlink.  The
> > mknod must request a device (block or char) with device number 0,0.
> > e.g.
> >     ln -s tty /dev/TTY
> >     mknod /dev/TTY b 0 0
> > 
> > This will create a devlink called "/dev/TTY" which points to the name
> > "tty" in devfs space.
> 
> I think it would be a mistake to have the symlink implicitly rooted
> in the devfs name space.  One, it breaks the principle of least
> surprise.  Two, it means that the target of the symlink suddenly
> changes (from /dev/tty to tty in the devfs namespace) when you do
> the mknod.  Three, it precludes the possibility of extending
> "devlinks" to point to normal files (in which case, devlink isn't
> the right name), which I don't think should be dismissed.

Well, the value of the symlink is simply interpreted by devfs.
You could use
   /dev/tty
or
   /devices/tty
or
   ////IloveLinux//tty
and get the same result as
   tty

I would probably recommend people use "/devices/tty", and then if they
boot with a non-devlink kernel they can mount devfs at /devices and
get a working system, and if they boot with a non-devfs kernel they
can make some devices under /devices and have a working system.

> 
> I also think that lchmod might be a more elegant system call
> interface.

Except that "lchmod" doesn't exist.  I didn't want to add any new
system calls.

> 
> >     ls -l /dev/TTY
> > 
> > will show the devlink.
> > 
> >     ls -lL /dev/TTY
> > 
> > will show the traditional device special file.
> 
> But this would require a patch to ls or libc, no?  I think this can
> be done such that old tools still show something reasonable.

no.  To userspace, devlinks look a lot like symlink.  Try it and see.
Actually they look more like those magic symlinks in /proc.  You
follow them and you get somewhere, but it isn't necessarily the same
place that you get if you did a readlink, and then followed that.

> 
> > Then
> >    cd /dev/ide
> > will work and allow you to move around the directory tree.  Everything
> > in the directory tree will have the same ownership and permissions as
> > the devlink has, except for the execute bits.   For directories, the
> > execute bits are copied from the read bits. For non-directories, the
> > execute bits are cleared. 
> 
> I haven't thought this through carefully, but I think applying too
> much "devfs magic" to devlinks is a mistake.  I think the results
> should be what a unix user would intuitively expect from a "symlink
> with permissions".  So, I don't like the idea of a devlink giving
> access recursively.  Some of the later ideas (eg, the pwd magic)
> strike me as questionable as well.
> 

Devices can appear in the devfs namespace spontaneously (hotplug).  If
devlinks could only point to devices, then you would *have* to have a
daemon just to be able to see the things.
This way, you only need a daemon (or user user-space helper) if you
want to do clever things with permissions or other configuration.

> > You cannot do
> > 
> >     ln -s '' /devices
> >     mknod /devices b 0 0
> > 
> > and get the full devfs namespace under /devices, but only because
> > of a shortcoming the the devfs code (that normally would never be
> > asked to do this anyway).  It could fairly easily be fixed but it
> > didn't seem worth the effort for this proof-of-concept.
> 
> This would be ugly and inconsistent anyway.  Nowhere else in unix
> does an empty path make sense.  The only sane interpretation would
> be an entry in the devfs root whose name is the empty string.

The Emtpy string *should* and *used-to* mean "the current
directory(*).  But some standards body somewhere broke that about 15
years ago.

As I mention above, it is the same as
    ln -s /dev /devices
    mknod /devices b 0 0

NeilBrown


(*)
The correct syntax for filenames is:

directoryname:   slash		   # means root
	       | empty		   # means current directory
               | filename slash	   # means directory stored in the file

filename :    directory member	   # means that member of the directory.


slash == "/+"		# one or more slashes
empty ==  ""		# no characters
member == "[^/]+"	# one or more non-slash characters.


Most (all) directories contain "." as a name for themselves.  Thus
".", which is <empty> followed by "." is a name for the file that
contains the current directory.

That worked fine in 4.4BSD and Edition 7 Unix.  But SysV broke it.
