Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUAGWzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 17:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUAGWzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 17:55:51 -0500
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:30974 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id S261190AbUAGWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 17:55:35 -0500
Date: Wed, 07 Jan 2004 17:55:23 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
To: Jim Carter <jimc@math.ucla.edu>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       autofs mailing list <autofs@linux.kernel.org>
Message-id: <3FFC8E5B.40203@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig908BAA661352E83ECC2C5C94;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <3FFB12AD.6010000@sun.com>
 <Pine.LNX.4.53.0401071139430.20046@simba.math.ucla.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig908BAA661352E83ECC2C5C94
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jim

Thanks for taking the time to read the document thoroughly and for Great 
feedback!  

Please see responses inlined below.

Jim Carter wrote:

>On Tue, 6 Jan 2004, Mike Waychison wrote:
>  
>
>>We've spent some time over the past couple months researching how Linux
>>autofs can be brought to a level that is comparable to that found on
>>other major Unix systems out there.
>>
>>ftp://ftp-eng.cobalt.com/pub/whitepapers/autofs/towards_a_modern_autofs.txt
>>ftp://ftp-eng.cobalt.com/pub/whitepapers/autofs/towards_a_modern_autofs.pdf
>>    
>>
>
>Mounting on a file descriptor is nice but it takes work for all filesystems
>to perform it.  Not to discourage work toward this goal, I suggest not
>entangling autofs with that work.  Instead, if we're doing the userspace
>helper thing, the kernel knows the process group of the helper it started.
>Do "oz" mode for that PG, and revoke the privilege when it exits.  Do the
>same thing again for unmounting.
>
>If the userspace helper is invoked in the triggering process' namespace,
>any full paths given to it will be resolved in that namespace.  This
>bypasses one of the main justifications for having autofs work only with FD
>mounts.
>
>If a sysop mounts autofs filesystems (installs triggers), that will and
>should happen in the namespace inhabited by him, not in any cloned
>namespaces.  Without needing to wait for someone to work through kernel
>politics and make FD mounts happen.
>
>  
>

Yes, this is most likely the way it will happen.  Note that I 'mounted 
on a file descriptor' in the examples
for multimounts by doing a fchdir(fd) and a mount --move 
/tmp/<unique_dir> '.'    Using file descriptors is however important for 
maintaining up to date direct mounts on the system. 

>>The exception to this rule is when the map entry for /home contains the
>>option 'browse':
>>    
>>
>
>Solaris 2.6 and above has the -browse option on indirect maps, so the set
>of subdirs potentially mountable can be seen, without mounting them. I
>don't see where this is implemented in Linux, nor do I see how it's done,
>documented in Solaris NFS man pages, but I didn't put a lot of time into
>the search.  
>

Yes.   Ian Kent has something similar in his release of autofs 4.1.0 
called ghosting.  Unfortunately, I haven't had the chance to play with 
it very much.

>I *hope* rpc.mountd has an opcode to enumerate every
>filesystem it's willing to export.  
>

# showmount -e hostname    ?

>Does it "stat" and return the stat
>data?  That would be important for "ls".
>
>  
>
Yes, an 'ls' actually does an lstat on every file.   This is cool 
because it doesn't follow links, which is how direct mounts and most 
likely browsing will work.   There are other cases where userspace will 
inadvertedly stat (instead of lstat) or getxattr (instead of lgetxattr) 
and these will need to be fixed.

Other known things that will break is gnu find(1).   For some reason, it 
now does:

lstat('dir')
chdir('dir')
lstat('.')

and compares st_dev and st_ino from the two lstat calls.

This obviously breaks when you use browsing and direct mounts.

>>In order to maintain some form of coherency between changing maps, these
>>dummy directory entries will remain in place within the dcache so that
>>the kernel doesn't need to query the usermode helper as often.  These
>>entries will periodically timeout and will be unhashed from the dcache.
>>    
>>
>
>Browsetimeout -- Each autofs instance necessarily has an in-core list of
>its subdirectories.  If the caller stats any of these and that one (or
>alternatively, any of the known subdirs) is not in the dcache, the module
>needs to run the helper again, refreshing all dcache entries.  But you
>still need a timeout because the mode etc. might change on the server, but
>it's rare.  Let's avoid committing a lot of coding effort and CPU time to
>supporting events tht might happen once per year.
>
>  
>
In some environments, maps change fairly often (a couple times a day).  
A timeout of 10 or 15 minutes is reasonable to me for this timeout to 
occur.  Of course, the way things are setup, a stale entry will still 
fail and return ENOENT if it has been removed from the maps since the 
last browse update.

>>Executing the usermode helper within the namespace of the triggering
>>application does have a problem when browsing is used.  We are caching
>>map keys in kernelspace and can run into coherency problems when an
>>autofs super_block is associated with multiple namespaces which have
>>differing automount maps in /etc. This kind of situation may occur if a
>>namespace is cloned and a new /etc directory with a different auto_home
>>map is mounted.
>>    
>>
>
>The uncloned superblock problem is discussed later in the paper.  It looks
>to me like the VFS layer ought to be responsible for cloning superblocks.
>Not to discourage work towards that goal, but I suggest not delaying autofs
>until it happens.  The result is that some users will see mount points
>(mounted or potentially mountable) that within-namespace policy says should
>be invisible.
>
Agreed.  This can hold off until later, as it isn't neccesarily an easy 
thing to do either.

>  That's not too bad, since we rely on UNIX file permissions
>or ACLs for security, not visibility in the automount map.  If an indirect
>map entry was formerly absent but now present, presumably the userspace
>helper will consult the then-prevailing automount map and find it
>successfully.
>
>  
>
Yes, but then when the other namespace accesses this entry and attempts 
to mount it and no longer finds it in the map, it is unhashed and no 
enumerated as a cache entry, which is still valid in the first 
namespace.  This cache coherency is a subtle point.  The main point is 
that without super_block cloning, we are left with two namespaces that 
can effectively alter each other's automount policy be remounting the 
filesystem.

>>Sect. 5.2 Direct Maps
>>    
>>
>
>  
>
>>2) The map key for the direct mount entry is now passed as a new mount
>>option called 'mapkey'.
>>    
>>
>
>I don't quite see the need for the mapkey mount option.  It seems to me
>that the name of the mount point is always equal to the map key.  In my
>model, mounting on open FDs isn't going to be implementable, and so the
>userspace helper has to know the full path name of the mount point, anyway.
>
>  
>
This is the subtle difference between direct and indirect maps.   The 
direct map keys are absolute paths, not path components.  We are 
implementing direct mounts as individual filesystems that will trap on 
traversal into their base directory.  This filesystem has no idea where 
it is located as far as the user is concerned.  We need to tell the 
filesystem directly so that the usermode helper can look it up.  
Conversely, the indirect map uses the sub-directory name as a mapkey.

As noted, we don't actually rely on this value as an absolute path.  
This means that we can move or bind the direct mount trapping 
filesystem.   As for mounting on open fd's, the fchdir(fd); mount --move 
/tmp/foo '.' still works.

>>5.3 Multimounts and Offsets
>>    
>>
>
>  
>
>>/usr/src                hosta:/export/src	\
>>            /linux      hostb:/export/linuxsrc
>>    
>>
>
>Suppose someone accesses /usr/src/linux.  Is it not true that both the
>original process and mount(8) have to first access /usr/src, triggering
>automounting of hostA:/export/src, and only when the stat info and readdir
>from that step have come through at least twice, can they go on to monkey
>with /usr/src/linux, triggering mounting of hostB:/export/otherlinux? Thus
>I don't see the need for multimounts.  The conceptual idea of mounting both
>dirs "as a unit" is maybe attractive when not looked at too closely, but it
>seems to me that by just punting, you get infinitesimally slower service to
>the user and a significant section of logic avoided in the code.
>
>  
>
This is pretty much needed no matter how you look at it.   If you set it 
up so that it peeked at the NFS share for /usr/src to get permission 
information, you also have to verify that it contains a directory 
'linux'.  This doesn't seem like much, but these things can change from 
underneath us.

My understanding of NFS is that you cannot 'pin' a directory on the 
server in order to keep it there as your mountpoint in the client.  You 
have to simply look it up and pin it in the client.  If you don't mount 
/usr/src, then you also won't have permission changes on it's base 
directory reflected on your system either.

>The kernel would need to know to install an autofs structure (trigger) on
>/usr/src/linux even though /usr/src was represented by only an autofs
>structure, not actually mounted yet, just like we see in procfs.  I doubt
>that's a showstopper, although you'd have to write the kernel code
>carefully.  The example of userD/server{1,2} indicates that you intend for
>the autofs structure, with nothing mounted on it, ought to be a really
>existing and traversable directory on whose subdirs other autofs FS's can
>be mounted.  Good.
>
>But in sec. 5.3.2 I see you making filesystem dirs in /tmp which seem to
>substitute for the synthetic autofs directories.  Bad, if I've understood
>the example.  Comments suggest that you need the /tmp directory to avoid
>setting off the autofs trigger.  Better: if a synthetic autofs directory
>has no corresponding entry in an automount map, you don't mount anything on
>it.  But if it *does* have a map entry, you need to mount it in order to
>stat it (the server's instance) to determine if the user has permission to
>traverse it, before even considering whether to mount the subdir. Remember
>that in my model I'm leaving aside FD mounts, so traversing containing
>directories by name is a valid concept.
>
>  
>
The directory /tmp/<unique_dir> is _not_ a synthetic autofs directory, 
it is a point where we perform our mounts before we move them.  The 
synthetic directories for multimounts w/o root offsets are handled by a 
tmpfs filesystem simply because it reduces code duplication.

>What is the significance of "lazy mount"?  I don't see the word "lazy" in
>any of the Solaris NFS or automount docs I looked at.  In sec. 5.3.1
>you say it means "mount only when accessed".  Thus the whole idea of autofs
>is to "lazy mount" vast numbers of filesystems.  Right?
>
>  
>
The term 'lazy mount' as used in the document refers to lazily mounting 
the offsets (subdirectories) of a multimount on an as needed basis.  
 From the Solaris 9 automount(1M) manpage:

  Multiple Mounts
     A multiple mount entry takes the form:
                                                                                 

     key [-mount-options] [[mountpoint] [-mount-options] location...]...
                                                                                 

     The initial /[mountpoint] is optional for  the  first  mount
     and  mandatory  for  all  subsequent  mounts.  The  optional
     mountpoint is taken as a pathname relative to the  directory
     named  by  key.  If  mountpoint  is  omitted  in  the  first
     occurrence, a mountpoint of / (root) is implied.
                                                                                 

     Given an entry in the indirect map for /src
                                                                                 

     beta     -ro\
       /           svr1,svr2:/export/src/beta  \
       /1.0        svr1,svr2:/export/src/beta/1.0  \
       /1.0/man    svr1,svr2:/export/src/beta/1.0/man
                                                                                 

     All offsets must exist on the server under  beta.  automount
     will   automatically  mount  /src/beta,  /src/beta/1.0,  and
     /src/beta/1.0/man, as needed,  from  either  svr1  or  svr2,
     whichever host is nearest and responds first.

The key is the 'as needed' bit, something we don't have in Linux yet.  

For justification to it's worth, some institutions have file servers 
that export hundreds or even thousands of shares over NFS.   As /net is 
really just a kind of executable indirect map that returns multimounts 
for each hostname used as a key,  just doing 'cd /net/hostname' may 
potentially mount hundreds of filesystems.  This is not cool! 
                                                                               


>>5.4 Expiry
>>    
>>
>
>  
>
>>Handling expiry of mounts is difficult to get right.  Several different
>>aspects need to be considered before being able to properly perform
>>expiry.
>>    
>>
>
>The current daemon (with latest patches) seems to get it right most of the
>time.
>
>  
>
It's the rest of the time we want to deal with.  I know Ian has done a 
lot of good work on this over the past few months and I hope we will be 
able to use his insight to get everything right.

>>The autofs filesystem really should know as little about VFS internal
>>structures as possible.  In this case, the filesystem code is charged
>>with walking across mountpoints and manually counting reference counts.
>>This task is much better left to the VFS internals.
>>    
>>
>
>Someone with a more thorough understanding of the code should comment on
>this, but I didn't notice the module rooting through VFS data; it looks
>like it relies on use counts maintained by the VFS layer, similar to what
>mount(2) relies on to declare a mount to be busy.
>
>  
>
It manually walks through dentry trees and vfsmount trees (albeit the v3 
code doesn't do the latter). It manually does reference count checks for 
business which can change over time.  It also has to do this all with 
locking, by grabbing vfs specific locks.  I'm pretty sure these 
structures are _not_ meant to be traversed by anything outside the vfs 
and the fact that autofs has gotten away with it is a remnant of the 
fact that dcache_lock used to encompass a lot.  In fact, in 2.5, the 
vfsmount structures that autofs walks is has split locks and now uses 
vfsmount_lock, which isn't exported to modules at all.

This is a good example of why this stuff should probably be merged into 
VFS,  autofs4 has yet to be updated to use this lock.  This comes with 
the decision to a) no longer support it as a module, only built in, or 
b) make vfsmount_lock accessible to modules.

But yes, someone with a more thorough understanding of the code should 
comment  :) 

>>Unmounting the filesystem from userspace is racy, as any program can
>>begin using a mount between the time the daemon has received a path to
>>expire and the time it actually makes the umount(2) system call.
>>    
>>
>
>So the helper's umount() will fail.  OK, it failed.  The kernel module
>should not recognize the mounted dir as being gone, until the module itself
>has seen that it's gone.  This policy also helps in cases where the sysop
>manually unmounts an automounted directory for repair purposes.
>  
>
But this leads to races which cause partial expiries to occur in autofs4.

>A common problem is stale NFS filehandles, and in this case we'd like the
>userspace helper to be aggressive in using "umount -f" or other advanced
>techniques.  The freedom to fail is important here.
>  
>
I'd much much rather see umount -l happen.  At least with -l, there is a 
slight chance that the file system will come back and the processes 
affected will be able to continue operating as usual.

>  
>
>>These points suggest that the kernel's VFS sub-system should be charged
>>with handling expiry.
>>    
>>
>
>The point is well taken that a VFS layer expiry mechanism would be welcomed
>by many filesystems.  But autofs has to work with the kernel as it lies
>now.
>
>  
>
Why? Things change in the kernel all the time.  Please note, we will be 
doing development against 2.6. 

I'd like to see an independent patch out there for those who want it on 
2.4, but the fact of the matter is that alot has changed since 2.4 and 
the amount of work required may not be worth it.

>>As described above, we may be installing multiple mounts upon each
>>trigger. This tree of mounts will need to expire together as an atomic
>>unit.  We will need to register this block of mounts to some expiry
>>system.  This will be done by performing a remount on the base
>>automounted filesystem after any nested offset mounts have been installed
>>    
>>
>
>A filesystem is "in use" if anything is mounted on its subdirs.  That
>precludes premature auto-unmounting of a containing directory, in the case
>of a multi-mount or jimc's recommended non-implementation thereof.  I don't
>see that a multi-mount stack needs to expire as a unit -- just let the
>components expire normally, leaf to root.  It doesn't bother jimc that some
>members are mounted and some aren't; by the principle of lazy mounting,
>that's what we're trying to accomplish.
>
>  
>
The thing is that we use autofs filesystems as traps.  Following from 
the previous /usr/src/linux example:

# cat /proc/mounts
rootfs /
autofs /usr/src
# cd /usr/src
# cat /proc/mounts
rootfs /
autofs /usr/src
hosta:/src /usr/src
autofs /usr/src/linux
# cd linux
# cat /proc/mounts
rootfs /
autofs /usr/src
hosta:/src /usr/src
autofs /usr/src/linux
hostb:/linux /usr/src/linux
#cd /

Now, Assume that nobody is using /usr/src and /usr/src/linux.   The 
first fs to expire is going to be the nfs from hostb on /usr/src/linux

# cat /proc/mounts
rootfs /
autofs /usr/src
hosta:/src /usr/src
autofs /usr/src/linux

Next, /usr/src should go.  The thing is, we do _not_ want to unmount the 
autofs filesystem at /usr/src/linux before unmounting the nfs filesystem 
at /usr/src because that would open ourselves up to a user coming in and 
doing chdir(/usr/src/linux).  We would catch the traversal because our 
trigger on 'linux' is gone.  We also shouldn't unmount the nfs 
filesystem from hosta now, because somebody is using it.  

However, if we had removed the two filesystems toghether atomically, 
then everything works fine.

Does that clear it up a bit?  

>>5.5 Handling Changing Maps
>>    
>>
>
>The whole issue of changed maps is closely related to the case of cloning a
>namespace and discovering that an autofs map is non-identical in the new
>namespace.
>
>As pointed out in 5.5.1, when the maps change a userspace program will have
>to detect some added or deleted items.  This program will have to run
>separately in the context of every namespace.  Thus, we should probably
>burden the sysop with remembering to run it if he wants his new/deleted
>maps to be recognized. But we'll have to use some ioctl to stimulate the
>kernel module to enumerate all known namespaces and run the updater for
>each one.
>
>  
>
Nah.   I leave that as a namespace-aware cron job problem ;)


>>5.5.2 Forcing Expiry to Occur
>>    
>>
>
>When I do this the reason is generally that I'm going to take down a
>server.  Then I don't want "lazy unmounts"; I want immediate unmounts that
>will be fatal to the processes using the filesystem.  When the server is
>already dead, then I may do a lazy unmount with the expectation that the
>structure will never be cleaned up until the client is rebooted, but at
>least the client can continue to run.
>
>  
>
Lazy unmounts appear immediately in your system.  

This may not be the only functionality needed, yes.  I'm sure there are 
more options required given the circumstances of the kill.  I probably 
shouldn't have mentioned the lazy unmounting for the forced expiry. 

I'd be interested to hear more about the different types of 
(expire/kill) operations that sysadmins prefer.


>>7 Scalability
>>    
>>
>
>Necessarily mount(8) is used to mount filesystems, since only it has all
>the spaghetti code and pseudo-object-oriented executables to deal with the
>various filesystem types.  Hence at least one process (and most likely a
>parent shell script) is expected per mount.  We need to be frugal in
>writing the userspace helper (and this is a reason to roll our own, not use
>hotplug), but the idea of using a userspace helper to mount, rather than a
>persistent daemon, doesn't sound scary to me.
>
>For me the biggest attraction of a Solaris-style automount upgrade is
>the ability to create wildcard maps with substitutible variables, e.g.
>rather than having a kludgey programmatic map that creates little map
>files on the fly looking like "* tupelo:/&", a host map can be implemented
>via "* $SERVER:/&".  Of course Solaris has a native "-host" map type,
>which is also good.
>
>  
>
The substitution stuff I think Ian had worked on: Ian correct me if I'm 
wrong here.

The -host map really is does act like an executable indirect map.   This 
is traditionally implemented on Linux as scripts, but that does keep you 
from using 'The Same Automounter Maps' on linux and solaris.   (It's 
also a big Linux customer complaint afaict).

-- 
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
mailto: Michael.Waychison@Sun.COM
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me, 
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 


--------------enig908BAA661352E83ECC2C5C94
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//I5ddQs4kOxk3/MRAn0oAKCdJRgjY72Iaku/I5ETfUJKre5/7wCdEolU
uJYLXxagIRvKZabmcoPWdsw=
=Hf9n
-----END PGP SIGNATURE-----

--------------enig908BAA661352E83ECC2C5C94--

