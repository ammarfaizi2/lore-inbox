Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266237AbUAGVOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266264AbUAGVOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:14:35 -0500
Received: from simba.math.ucla.edu ([128.97.4.125]:1923 "EHLO
	simba.math.ucla.edu") by vger.kernel.org with ESMTP id S266237AbUAGVOE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:14:04 -0500
Date: Wed, 7 Jan 2004 13:14:02 -0800 (PST)
From: Jim Carter <jimc@math.ucla.edu>
To: Mike Waychison <Michael.Waychison@sun.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <3FFB12AD.6010000@sun.com>
Message-ID: <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
References: <3FFB12AD.6010000@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jan 2004, Mike Waychison wrote:
> We've spent some time over the past couple months researching how Linux
> autofs can be brought to a level that is comparable to that found on
> other major Unix systems out there.
>
> ftp://ftp-eng.cobalt.com/pub/whitepapers/autofs/towards_a_modern_autofs.txt
> ftp://ftp-eng.cobalt.com/pub/whitepapers/autofs/towards_a_modern_autofs.pdf

Mounting on a file descriptor is nice but it takes work for all filesystems
to perform it.  Not to discourage work toward this goal, I suggest not
entangling autofs with that work.  Instead, if we're doing the userspace
helper thing, the kernel knows the process group of the helper it started.
Do "oz" mode for that PG, and revoke the privilege when it exits.  Do the
same thing again for unmounting.

If the userspace helper is invoked in the triggering process' namespace,
any full paths given to it will be resolved in that namespace.  This
bypasses one of the main justifications for having autofs work only with FD
mounts.

If a sysop mounts autofs filesystems (installs triggers), that will and
should happen in the namespace inhabited by him, not in any cloned
namespaces.  Without needing to wait for someone to work through kernel
politics and make FD mounts happen.

> The exception to this rule is when the map entry for /home contains the
> option 'browse':

Solaris 2.6 and above has the -browse option on indirect maps, so the set
of subdirs potentially mountable can be seen, without mounting them. I
don't see where this is implemented in Linux, nor do I see how it's done,
documented in Solaris NFS man pages, but I didn't put a lot of time into
the search.  I *hope* rpc.mountd has an opcode to enumerate every
filesystem it's willing to export.  Does it "stat" and return the stat
data?  That would be important for "ls".

> In order to maintain some form of coherency between changing maps, these
> dummy directory entries will remain in place within the dcache so that
> the kernel doesn't need to query the usermode helper as often.  These
> entries will periodically timeout and will be unhashed from the dcache.

Browsetimeout -- Each autofs instance necessarily has an in-core list of
its subdirectories.  If the caller stats any of these and that one (or
alternatively, any of the known subdirs) is not in the dcache, the module
needs to run the helper again, refreshing all dcache entries.  But you
still need a timeout because the mode etc. might change on the server, but
it's rare.  Let's avoid committing a lot of coding effort and CPU time to
supporting events tht might happen once per year.

> Executing the usermode helper within the namespace of the triggering
> application does have a problem when browsing is used.  We are caching
> map keys in kernelspace and can run into coherency problems when an
> autofs super_block is associated with multiple namespaces which have
> differing automount maps in /etc. This kind of situation may occur if a
> namespace is cloned and a new /etc directory with a different auto_home
> map is mounted.

The uncloned superblock problem is discussed later in the paper.  It looks
to me like the VFS layer ought to be responsible for cloning superblocks.
Not to discourage work towards that goal, but I suggest not delaying autofs
until it happens.  The result is that some users will see mount points
(mounted or potentially mountable) that within-namespace policy says should
be invisible.  That's not too bad, since we rely on UNIX file permissions
or ACLs for security, not visibility in the automount map.  If an indirect
map entry was formerly absent but now present, presumably the userspace
helper will consult the then-prevailing automount map and find it
successfully.

> Sect. 5.2 Direct Maps

> 2) The map key for the direct mount entry is now passed as a new mount
> option called 'mapkey'.

I don't quite see the need for the mapkey mount option.  It seems to me
that the name of the mount point is always equal to the map key.  In my
model, mounting on open FDs isn't going to be implementable, and so the
userspace helper has to know the full path name of the mount point, anyway.

> 5.3 Multimounts and Offsets

> /usr/src                hosta:/export/src	\
>             /linux      hostb:/export/linuxsrc

Suppose someone accesses /usr/src/linux.  Is it not true that both the
original process and mount(8) have to first access /usr/src, triggering
automounting of hostA:/export/src, and only when the stat info and readdir
from that step have come through at least twice, can they go on to monkey
with /usr/src/linux, triggering mounting of hostB:/export/otherlinux? Thus
I don't see the need for multimounts.  The conceptual idea of mounting both
dirs "as a unit" is maybe attractive when not looked at too closely, but it
seems to me that by just punting, you get infinitesimally slower service to
the user and a significant section of logic avoided in the code.

The kernel would need to know to install an autofs structure (trigger) on
/usr/src/linux even though /usr/src was represented by only an autofs
structure, not actually mounted yet, just like we see in procfs.  I doubt
that's a showstopper, although you'd have to write the kernel code
carefully.  The example of userD/server{1,2} indicates that you intend for
the autofs structure, with nothing mounted on it, ought to be a really
existing and traversable directory on whose subdirs other autofs FS's can
be mounted.  Good.

But in sec. 5.3.2 I see you making filesystem dirs in /tmp which seem to
substitute for the synthetic autofs directories.  Bad, if I've understood
the example.  Comments suggest that you need the /tmp directory to avoid
setting off the autofs trigger.  Better: if a synthetic autofs directory
has no corresponding entry in an automount map, you don't mount anything on
it.  But if it *does* have a map entry, you need to mount it in order to
stat it (the server's instance) to determine if the user has permission to
traverse it, before even considering whether to mount the subdir. Remember
that in my model I'm leaving aside FD mounts, so traversing containing
directories by name is a valid concept.

What is the significance of "lazy mount"?  I don't see the word "lazy" in
any of the Solaris NFS or automount docs I looked at.  In sec. 5.3.1
you say it means "mount only when accessed".  Thus the whole idea of autofs
is to "lazy mount" vast numbers of filesystems.  Right?

> 5.4 Expiry

> Handling expiry of mounts is difficult to get right.  Several different
> aspects need to be considered before being able to properly perform
> expiry.

The current daemon (with latest patches) seems to get it right most of the
time.

> The autofs filesystem really should know as little about VFS internal
> structures as possible.  In this case, the filesystem code is charged
> with walking across mountpoints and manually counting reference counts.
> This task is much better left to the VFS internals.

Someone with a more thorough understanding of the code should comment on
this, but I didn't notice the module rooting through VFS data; it looks
like it relies on use counts maintained by the VFS layer, similar to what
mount(2) relies on to declare a mount to be busy.

> Unmounting the filesystem from userspace is racy, as any program can
> begin using a mount between the time the daemon has received a path to
> expire and the time it actually makes the umount(2) system call.

So the helper's umount() will fail.  OK, it failed.  The kernel module
should not recognize the mounted dir as being gone, until the module itself
has seen that it's gone.  This policy also helps in cases where the sysop
manually unmounts an automounted directory for repair purposes.

A common problem is stale NFS filehandles, and in this case we'd like the
userspace helper to be aggressive in using "umount -f" or other advanced
techniques.  The freedom to fail is important here.

> These points suggest that the kernel's VFS sub-system should be charged
> with handling expiry.

The point is well taken that a VFS layer expiry mechanism would be welcomed
by many filesystems.  But autofs has to work with the kernel as it lies
now.

> As described above, we may be installing multiple mounts upon each
> trigger. This tree of mounts will need to expire together as an atomic
> unit.  We will need to register this block of mounts to some expiry
> system.  This will be done by performing a remount on the base
> automounted filesystem after any nested offset mounts have been installed

A filesystem is "in use" if anything is mounted on its subdirs.  That
precludes premature auto-unmounting of a containing directory, in the case
of a multi-mount or jimc's recommended non-implementation thereof.  I don't
see that a multi-mount stack needs to expire as a unit -- just let the
components expire normally, leaf to root.  It doesn't bother jimc that some
members are mounted and some aren't; by the principle of lazy mounting,
that's what we're trying to accomplish.

> 5.5 Handling Changing Maps

The whole issue of changed maps is closely related to the case of cloning a
namespace and discovering that an autofs map is non-identical in the new
namespace.

As pointed out in 5.5.1, when the maps change a userspace program will have
to detect some added or deleted items.  This program will have to run
separately in the context of every namespace.  Thus, we should probably
burden the sysop with remembering to run it if he wants his new/deleted
maps to be recognized. But we'll have to use some ioctl to stimulate the
kernel module to enumerate all known namespaces and run the updater for
each one.

> 5.5.2 Forcing Expiry to Occur

When I do this the reason is generally that I'm going to take down a
server.  Then I don't want "lazy unmounts"; I want immediate unmounts that
will be fatal to the processes using the filesystem.  When the server is
already dead, then I may do a lazy unmount with the expectation that the
structure will never be cleaned up until the client is rebooted, but at
least the client can continue to run.

> 7 Scalability

Necessarily mount(8) is used to mount filesystems, since only it has all
the spaghetti code and pseudo-object-oriented executables to deal with the
various filesystem types.  Hence at least one process (and most likely a
parent shell script) is expected per mount.  We need to be frugal in
writing the userspace helper (and this is a reason to roll our own, not use
hotplug), but the idea of using a userspace helper to mount, rather than a
persistent daemon, doesn't sound scary to me.

For me the biggest attraction of a Solaris-style automount upgrade is
the ability to create wildcard maps with substitutible variables, e.g.
rather than having a kludgey programmatic map that creates little map
files on the fly looking like "* tupelo:/&", a host map can be implemented
via "* $SERVER:/&".  Of course Solaris has a native "-host" map type,
which is also good.


James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA  90095-1555
Email: jimc@math.ucla.edu    http://www.math.ucla.edu/~jimc (q.v. for PGP key)
