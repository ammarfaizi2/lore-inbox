Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUAHSVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 13:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265662AbUAHSVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 13:21:22 -0500
Received: from simba.math.ucla.edu ([128.97.4.125]:21379 "EHLO
	simba.math.ucla.edu") by vger.kernel.org with ESMTP id S265661AbUAHSVB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 13:21:01 -0500
Date: Thu, 8 Jan 2004 10:20:58 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFC8E5B.40203@sun.com>
Message-ID: <Pine.LNX.4.53.0401080911390.27090@simba.math.ucla.edu>
References: <3FFB12AD.6010000@sun.com> <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
 <3FFC8E5B.40203@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jan 2004, Mike Waychison wrote:
> Jim Carter wrote:

> >  That's not too bad, since we rely on UNIX file permissions
> >or ACLs for security, not visibility in the automount map.  If an indirect
> >map entry was formerly absent but now present, presumably the userspace
> >helper will consult the then-prevailing automount map and find it
> >successfully.
>
> Yes, but then when the other namespace accesses this entry and attempts
> to mount it and no longer finds it in the map, it is unhashed and no
> enumerated as a cache entry, which is still valid in the first
> namespace.  This cache coherency is a subtle point.  The main point is
> that without super_block cloning, we are left with two namespaces that
> can effectively alter each other's automount policy be remounting the
> filesystem.

So for browsing ("ls" an indirect map's mountpoint without statting each
file), one namespace will see targets not in its version of the map, or the
other namespace will fail to see targets in its map.  Hmm, in the strict
userspace helper model, how does the helper get the file list into the
kernel module's data structures?  Perhaps we need an "inverse stat" ioctl
to pass a stat struct down to the kernel.  Plus another ioctl or a special
variant of mkdir, to populate the kernel's view of an indirect map with
names, but not stat data.  Running a pipe/socket/etc. between the kernel
and userspace is yucky.  By the way, IPSec handles the problem by letting
its userspace daemon create a socket with address family PF_KEY.

(About multimounts:)

> This is pretty much needed no matter how you look at it.   If you set it
> up so that it peeked at the NFS share for /usr/src to get permission
> information, you also have to verify that it contains a directory
> 'linux'.  This doesn't seem like much, but these things can change from
> underneath us.

I don't see that.  What I do see is, if /usr/src/linux is an autofs direct
map, and /usr/src is also a direct (or indirect?) map, then both
/usr/src/linux and /usr/src must have autofs filesystems (local kernel data
structures) mounted on them at all times, whether or not the NFS
filesystems were mounted.  And when /usr/src eventually gets NFS mounted,
the /usr/src/linux autofs FS has to percolate upward, and percolate back
when /usr/src is unmounted.  Or else, after /usr/src is NFS mounted you
need some magic (the multimount mechanism) to install an autofs filesystem
on /usr/src/linux.  The two approaches are very similar, but I think the
difference is that in Sun's implementation you have this special feature
with syntax and logic to support it, whereas as described by me, the man
page would just say "don't worry about autofs mount points located in a
filesystem that isn't mounted yet; we'll take care of it one way or
another."

> For justification to it's worth, some institutions have file servers
> that export hundreds or even thousands of shares over NFS.   As /net is
> really just a kind of executable indirect map that returns multimounts
> for each hostname used as a key,  just doing 'cd /net/hostname' may
> potentially mount hundreds of filesystems.  This is not cool!

Definitely not cool.  But some users (yours truly among them) do "alias ls
'ls -F'", which requires "ls" to stat (and thus mount) every exported
filesystem.  More uncool, and I don't see any non-disgusting way around it.

> >So the helper's umount() will fail.  OK, it failed.  The kernel module
> >should not recognize the mounted dir as being gone, until the module itself
> >has seen that it's gone.  This policy also helps in cases where the sysop
> >manually unmounts an automounted directory for repair purposes.

> But this leads to races which cause partial expiries to occur in autofs4.

But it's a fact of life that some umounts will fail.  Perhaps that's one
reason why I'm dragging my heels so hard about the multimounts: they depend
on being mounted and unmounted as a unit, and that atomicity can't be
guaranteed.  Whereas if the subdir and containing dir are unmounted
independently, the use counts will insure that the subdir is unmounted
first, and the containing dir is unmounted (and the subdir's autofs FS
mount is put back in a "storage" state) only after successful unmounting of
the subdir.

Aha, I hear someone snarling, "you can't umount the containing dir if an
autofs FS is mounted on the subdir, and conversely, you can't mount the
subdir autofs FS until after the containing dir is mounted".  So the autofs
private data for the containing dir needs a chain saying "there are
supposed to be autofs subdirs mounted on these subdirs (relative paths or
"offsets").  Perhaps we're both talking about the same mechanism for
multimounts, but I'm just resisting some of the extras that go with them,
such as the atomicity and the special syntax.

> >A filesystem is "in use" if anything is mounted on its subdirs.  That
> >precludes premature auto-unmounting of a containing directory, in the case
> >of a multi-mount or jimc's recommended non-implementation thereof.  I don't
> >see that a multi-mount stack needs to expire as a unit -- just let the
> >components expire normally, leaf to root.  It doesn't bother jimc that some
> >members are mounted and some aren't; by the principle of lazy mounting,
> >that's what we're trying to accomplish.

> The thing is that we use autofs filesystems as traps.  Following from
> the previous /usr/src/linux example:

---- snip most of example ----

> Now, Assume that nobody is using /usr/src and /usr/src/linux.   The
> first fs to expire is going to be the nfs from hostb on /usr/src/linux
>
> # cat /proc/mounts
> rootfs /
> autofs /usr/src
> hosta:/src /usr/src
> autofs /usr/src/linux
>
> Next, /usr/src should go.  The thing is, we do _not_ want to unmount the
> autofs filesystem at /usr/src/linux before unmounting the nfs filesystem
> at /usr/src because that would open ourselves up to a user coming in and
> doing chdir(/usr/src/linux).  We would catch the traversal because our
> trigger on 'linux' is gone.  We also shouldn't unmount the nfs
> filesystem from hosta now, because somebody is using it.

Solution: do a "move" remount, remounting the NFS filesystem from /usr/src
to /tmp/_garbage/src.  In the instant after that finishes, a wayward user
does "cd /usr/src/linux".  Since only the autofs FS is currently on
/usr/src, it triggers and forks another userspace helper to mount
serverA:/export/src on /usr/src, and it *atomically* mounts an autofs FS
on /usr/src/linux before signalling the caller that /usr/src is ready for
use.  Then when the first userspace helper regains the CPU, all the stuff
on /tmp/_garbage/src would be broken down with no need to worry about race
conditions.

Minor detail, applying to both Sun-style multimounts and my ideas: can you
"mount" an autofs FS without statting its mount point?  Probably not.
This means that the kernel has to run the userspace helper twice, once to
mount the containing dir and again to implant the autofs FS on the subdir,
before reporting to the caller that the containing dir is ready.
Alternatively the helper should infer that the subdir needs an autofs FS
when it's mounting the containing dir (potentially needing to consult every
map file and NIS map in the system to figure that out).  Hmm, am I arguing
in favor of the special syntax of Sun multimounts?

More on /tmp/_garbage: when a server crashes and you aren't sure whether
forced or lazy unmounts will get rid of the mount strucures, if you move
the mount into /tmp/_garbage then the main automount tree will still be
functional.  A problem I see from time to time is, serverX is rebooted, the
client has a stale NFS filehandle, and I can't make the broken mount
disappear, hence can't mount that filesystem from the revived serverX.
This is particularly a problem on Solaris 2.6; on Linux I can usually
recover by sufficiently many "umount -f" or "umount -l" or "kill -9".

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
