Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264356AbUAHL7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264366AbUAHL7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:59:43 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:11447 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S264356AbUAHL7c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:59:32 -0500
Date: Thu, 8 Jan 2004 20:00:14 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFC8E5B.40203@sun.com>
Message-ID: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't expect we'll get many readers of posts this long ...

On Wed, 7 Jan 2004, Mike Waychison wrote:

Mike can you enlighten me with a few words about how namespaces are useful
in the design. I have not seen or heard much about them so please be
gentle.

I don't understand the super block cloning problem you describe either.
Some words on that would be greatly appreciated as well.

What is the form of the trigger talked about? Identifying the automount
points in the autofs filesystem has always been hard and error prone.

Please clearify what we are talking about WRT kernel support for
automount. Is the plan a new kernel module or are we talking about
unspecified 'in VFS' support or both?

> >
> >Solaris 2.6 and above has the -browse option on indirect maps, so the set
> >of subdirs potentially mountable can be seen, without mounting them. I
> >don't see where this is implemented in Linux, nor do I see how it's done,
> >documented in Solaris NFS man pages, but I didn't put a lot of time into
> >the search.
> >
>
> Yes.   Ian Kent has something similar in his release of autofs 4.1.0
> called ghosting.  Unfortunately, I haven't had the chance to play with
> it very much.

Yes. In 4.1 NIS, LDAP and file maps are browsable for both direct and
indirect maps. The browsability, only, requires my kernel patch.
The daemon detects the updated modules' presence, and if the option is
specified 'ghosts' the directories, mounting them only when accessed.

>
> >I *hope* rpc.mountd has an opcode to enumerate every
> >filesystem it's willing to export.
> >
>
> # showmount -e hostname    ?
>
> >Does it "stat" and return the stat
> >data?  That would be important for "ls".
> >
> >
> >
> Yes, an 'ls' actually does an lstat on every file.   This is cool
> because it doesn't follow links, which is how direct mounts and most
> likely browsing will work.   There are other cases where userspace will
> inadvertedly stat (instead of lstat) or getxattr (instead of lgetxattr)
> and these will need to be fixed.
>
> Other known things that will break is gnu find(1).   For some reason, it
> now does:
>
> lstat('dir')
> chdir('dir')
> lstat('.')

This suggestion has been made by others several times but doesn't seem
to be a problem in practice. In all my testing I have only been able to
find one case that does'nt work as needed when ghosted. This is the
situation where a home directory in a map exported from a server, is
actually not available (eg does not exist) and someone logs into the
account using wu-ftpd. In this case wu-ftpd thinks all is ok but of course
an error is returned when the directory access is attempted. In fact an
error should have been returned at login. Further, I believe this can be
solved with as little as an additional revalidate call in sys_stat (I
think the problem call was sys_stst ???).

> >
> >
> In some environments, maps change fairly often (a couple times a day).
> A timeout of 10 or 15 minutes is reasonable to me for this timeout to
> occur.  Of course, the way things are setup, a stale entry will still
> fail and return ENOENT if it has been removed from the maps since the
> last browse update.

My thoughts on map info and cacheing of it will come when I have had more
time to digest your paper.

> This is the subtle difference between direct and indirect maps.   The
> direct map keys are absolute paths, not path components.  We are
> implementing direct mounts as individual filesystems that will trap on
> traversal into their base directory.  This filesystem has no idea where
> it is located as far as the user is concerned.  We need to tell the
> filesystem directly so that the usermode helper can look it up.
> Conversely, the indirect map uses the sub-directory name as a mapkey.

I'm not sure what you are saying here. Does this mean there is a mount for
every direct mount (this might be what you call a trigger)?

AIX implemented automounts by mounting everything in each map. This
made the mount listing very ugly.

>
> >What is the significance of "lazy mount"?  I don't see the word "lazy" in
> >any of the Solaris NFS or automount docs I looked at.  In sec. 5.3.1
> >you say it means "mount only when accessed".  Thus the whole idea of autofs
> >is to "lazy mount" vast numbers of filesystems.  Right?
> >

>
> The key is the 'as needed' bit, something we don't have in Linux yet.
>
> For justification to it's worth, some institutions have file servers
> that export hundreds or even thousands of shares over NFS.   As /net is
> really just a kind of executable indirect map that returns multimounts
> for each hostname used as a key,  just doing 'cd /net/hostname' may
> potentially mount hundreds of filesystems.  This is not cool!

This sounds like the stat/lstat question again.

I have been able to provide lazy mounts in 4.1 with directory
browsing but have had to resort to internal sub-mounts when browsing is
not requested or available. This process sounds similar to some of
discussion of muti-mount maps in the paper.

>
>
>
> >>5.4 Expiry
> >>
> >>
> >
> >
> >
> >>Handling expiry of mounts is difficult to get right.  Several different
> >>aspects need to be considered before being able to properly perform
> >>expiry.
> >>
> >>
> >
> >The current daemon (with latest patches) seems to get it right most of the
> >time.
> >
> >
> >
> It's the rest of the time we want to deal with.  I know Ian has done a
> lot of good work on this over the past few months and I hope we will be
> able to use his insight to get everything right.
>
> >>The autofs filesystem really should know as little about VFS internal
> >>structures as possible.  In this case, the filesystem code is charged
> >>with walking across mountpoints and manually counting reference counts.
> >>This task is much better left to the VFS internals.
> >>
> >>
> >
> >Someone with a more thorough understanding of the code should comment on
> >this, but I didn't notice the module rooting through VFS data; it looks
> >like it relies on use counts maintained by the VFS layer, similar to what
> >mount(2) relies on to declare a mount to be busy.
> >
> >
> >
> It manually walks through dentry trees and vfsmount trees (albeit the v3
> code doesn't do the latter). It manually does reference count checks for
> business which can change over time.  It also has to do this all with
> locking, by grabbing vfs specific locks.  I'm pretty sure these
> structures are _not_ meant to be traversed by anything outside the vfs
> and the fact that autofs has gotten away with it is a remnant of the
> fact that dcache_lock used to encompass a lot.  In fact, in 2.5, the
> vfsmount structures that autofs walks is has split locks and now uses
> vfsmount_lock, which isn't exported to modules at all.
>
> This is a good example of why this stuff should probably be merged into
> VFS,  autofs4 has yet to be updated to use this lock.  This comes with
> the decision to a) no longer support it as a module, only built in, or
> b) make vfsmount_lock accessible to modules.
>
> But yes, someone with a more thorough understanding of the code should
> comment  :)

Mmm. The vfsmount_lock is available to modules in 2.6. At least it was in
test11. I'm sure I compiled the module under 2.6 as well???

I thought that, taking the dcache_lock was the correct thing to do when
traversing a dentry list?

In any case after a mail discussion with Maneesh Soni regarding the
autofs4 expiry code I rewrote it. Maneesh felt that using reference counts
was unreliable and recommended that it use VFS api calls where possible. I
did that and that code is now part of my autofs4 module kit for 2.4 and is
also present in the patch set I offered to Andrew Morten for inclusion
in 2.6. It seems to work well. The dentry structures are traversed
and the dcache_lock is obtained as needed. When I can go no further
within the autofs filesystem I resort to traversing the vfsmount
structures to check the mount counts. Maybe we can get some usefull code
from this.

>
> >>Unmounting the filesystem from userspace is racy, as any program can
> >>begin using a mount between the time the daemon has received a path to
> >>expire and the time it actually makes the umount(2) system call.
> >>
> >>
> >
> >So the helper's umount() will fail.  OK, it failed.  The kernel module
> >should not recognize the mounted dir as being gone, until the module itself
> >has seen that it's gone.  This policy also helps in cases where the sysop
> >manually unmounts an automounted directory for repair purposes.

The autofs4 moudule blocks (auto) mounts during the umount callback.
Surely this is the sensible thing to do.

> >
> >>These points suggest that the kernel's VFS sub-system should be charged
> >>with handling expiry.
> >>
> >>
> >
> >The point is well taken that a VFS layer expiry mechanism would be welcomed
> >by many filesystems.  But autofs has to work with the kernel as it lies
> >now.
> >
> >
> >
> Why? Things change in the kernel all the time.  Please note, we will be
> doing development against 2.6.

Mmm ... exirey in VFS ... later also.

>
> I'd like to see an independent patch out there for those who want it on
> 2.4, but the fact of the matter is that alot has changed since 2.4 and
> the amount of work required may not be worth it.
>
> >>As described above, we may be installing multiple mounts upon each
> >>trigger. This tree of mounts will need to expire together as an atomic
> >>unit.  We will need to register this block of mounts to some expiry
> >>system.  This will be done by performing a remount on the base
> >>automounted filesystem after any nested offset mounts have been installed
> >>
> >>
> >
> >A filesystem is "in use" if anything is mounted on its subdirs.  That
> >precludes premature auto-unmounting of a containing directory, in the case
> >of a multi-mount or jimc's recommended non-implementation thereof.  I don't
> >see that a multi-mount stack needs to expire as a unit -- just let the
> >components expire normally, leaf to root.  It doesn't bother jimc that some
> >members are mounted and some aren't; by the principle of lazy mounting,
> >that's what we're trying to accomplish.

My understanding of the multi-mount/tree mounts is flawed. Don't look to
autofs v4 for correct functionality ... bummer ... missed that.

>
> >>5.5 Handling Changing Maps
> >>
> >>
> >
> >The whole issue of changed maps is closely related to the case of cloning a
> >namespace and discovering that an autofs map is non-identical in the new
> >namespace.
> >
> >As pointed out in 5.5.1, when the maps change a userspace program will have
> >to detect some added or deleted items.  This program will have to run
> >separately in the context of every namespace.  Thus, we should probably
> >burden the sysop with remembering to run it if he wants his new/deleted
> >maps to be recognized. But we'll have to use some ioctl to stimulate the
> >kernel module to enumerate all known namespaces and run the updater for
> >each one.
> >
> >
> >
> Nah.   I leave that as a namespace-aware cron job problem ;)

More info please?
Cloning namespaces?

>
>
> >>5.5.2 Forcing Expiry to Occur
> >>
> >>
> >
> >When I do this the reason is generally that I'm going to take down a
> >server.  Then I don't want "lazy unmounts"; I want immediate unmounts that
> >will be fatal to the processes using the filesystem.  When the server is
> >already dead, then I may do a lazy unmount with the expectation that the
> >structure will never be cleaned up until the client is rebooted, but at
> >least the client can continue to run.
> >
> >
> >
> Lazy unmounts appear immediately in your system.
>
> This may not be the only functionality needed, yes.  I'm sure there are
> more options required given the circumstances of the kill.  I probably
> shouldn't have mentioned the lazy unmounting for the forced expiry.
>
> I'd be interested to hear more about the different types of
> (expire/kill) operations that sysadmins prefer.

Hang on. From the discussion my impression of a lazy mount is that it is
not actually mounted!

Indeed, why should it be, it's basically a directory or a dentry in the
kernel.

>
>
> >>7 Scalability
> >>
> >>
> >
> >Necessarily mount(8) is used to mount filesystems, since only it has all
> >the spaghetti code and pseudo-object-oriented executables to deal with the
> >various filesystem types.  Hence at least one process (and most likely a
> >parent shell script) is expected per mount.  We need to be frugal in
> >writing the userspace helper (and this is a reason to roll our own, not use
> >hotplug), but the idea of using a userspace helper to mount, rather than a
> >persistent daemon, doesn't sound scary to me.
> >
> >For me the biggest attraction of a Solaris-style automount upgrade is
> >the ability to create wildcard maps with substitutible variables, e.g.
> >rather than having a kludgey programmatic map that creates little map
> >files on the fly looking like "* tupelo:/&", a host map can be implemented
> >via "* $SERVER:/&".  Of course Solaris has a native "-host" map type,
> >which is also good.
> >
> >
> >
> The substitution stuff I think Ian had worked on: Ian correct me if I'm
> wrong here.
>
> The -host map really is does act like an executable indirect map.   This
> is traditionally implemented on Linux as scripts, but that does keep you
> from using 'The Same Automounter Maps' on linux and solaris.   (It's
> also a big Linux customer complaint afaict).

If wildcard map entries are not in autofs v3 then Jeremy implemented this
in v4.

And yes the host map is basically a program map and that's all. Worse, as
pointed out in the paper it mounts everything under it. This is a source
of stress for mount and umount. I have put in a fair bit of time on ugly
hacks to work around this. This same problem is also evident in startup
and shutdown for master maps with a good number of entries (~50 or more).
A consequence of the current multiple daemon approach.

Ian

