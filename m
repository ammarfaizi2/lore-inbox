Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbUAHPnB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 10:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265400AbUAHPnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 10:43:01 -0500
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:37049 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S265385AbUAHPkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 10:40:13 -0500
Date: Thu, 08 Jan 2004 10:39:53 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-reply-to: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
To: Ian Kent <raven@themaw.net>
Cc: Jim Carter <jimc@math.ucla.edu>,
       autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <3FFD79C9.1040404@sun.com>
MIME-version: 1.0
Content-type: multipart/signed;
 boundary=------------enig4E10795A029B7FCDF0B4D7B0;
 protocol="application/pgp-signature"; micalg=pgp-sha1
X-Accept-Language: en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107
 Debian/1.5-3
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <Pine.LNX.4.44.0401081827070.285-100000@donald.themaw.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4E10795A029B7FCDF0B4D7B0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ian Kent wrote:

>Don't expect we'll get many readers of posts this long ...
>
>On Wed, 7 Jan 2004, Mike Waychison wrote:
>
>Mike can you enlighten me with a few words about how namespaces are useful
>in the design. I have not seen or heard much about them so please be
>gentle.
>  
>

Your best bet to learn more about namespaces is probably to read 
copy_namespace() in fs/namespace.c.  There isn't much to google for, 
other than the CLONE_NEWNS flag for clone(2).  Basically, the idea is 
that you can give a new process its own independent mount table to play 
with.  Any changes to it are not seen by any other processes and vice-versa.

As for usefulness, the use namespaces in general is up for debate.  
IMHO, namespaces in Linux are ill designed, however I'm told that their 
uses are still far off and it is understood that they break several 
things.  

AFAIK, the long-term goal of namespaces is to one day be able to do 
user-priviledged mounting.  Basically allowing users to play in their 
own sandbox mounttable, mounting/moving/binding/unmounting filesystems 
as they see fit, without affecting the overall security of the machine 
and without disturbing other users.  Someone correct me here if I'm wrong.

>I don't understand the super block cloning problem you describe either.
>Some words on that would be greatly appreciated as well.
>
>  
>
One of the benefits of namespace cloning is complete mount configuration 
isolation between processes.  In my eyes, automounting is a part of that 
configuration.  To over-simplify the problem, any given filesystem may 
have a single set of mount options.  When a namespace is cloned, every 
mounted filesystem is shared between the two namespaces.  Now we have 
the problem that a change in mount options in one namespace affects the 
other.  This breaks the mountpoint isolation namespaces tried to achieve. 

The 'quick-fix' to this is that filesystems should be allowed to 
determine if they should clone themselves when a namespace is cloned.  
This would ensure that each namespace now has its own copy of the 
filesystem, each with individual sets of mount options.

>What is the form of the trigger talked about? Identifying the automount
>points in the autofs filesystem has always been hard and error prone.
>
>  
>
I don't understand what you mean by the identifying part.   However, the 
'trigger' would the traditional method used in autofsv3/4 for indirect 
maps and probably based off what you already have for doing the browsing 
stuff.

The direct map 'triggers' will be taken care of by another filesystem 
with a magic root directory that will catch traversals using some 
follow_link magic.   I wrote a prototype for this last summer, but 
haven't released it as the userspace stuff completely does not fit in 
with the existing daemon that was out at the time do the the mess of 
glue that was pgids, pipes and processes.   It worked in the simple 
case, but it didn't extend to being able to direct mount an indirect 
map, nor was it able to do the lazy mounting in multimounts as I had 
desired.

>Please clearify what we are talking about WRT kernel support for
>automount. Is the plan a new kernel module or are we talking about
>unspecified 'in VFS' support or both?
>
>  
>
This module will have its own new autofs module (hopefully named 
something other than autofs to avoid confusion/mishaps).  The VFS will 
have native support for expiry.  The VFS will also be slightly extended 
to allow the super_block cloning on namespace clone (although this can 
probably hold off a while, it's more a semantic issue than anything else).

>
>Yes. In 4.1 NIS, LDAP and file maps are browsable for both direct and
>indirect maps. The browsability, only, requires my kernel patch.
>The daemon detects the updated modules' presence, and if the option is
>specified 'ghosts' the directories, mounting them only when accessed.
>
>  
>
What is the difference between Solaris's -browse and your ghosting then? 

>>lstat('dir')
>>chdir('dir')
>>lstat('.')
>>    
>>
>
>This suggestion has been made by others several times but doesn't seem
>to be a problem in practice. In all my testing I have only been able to
>find one case that does'nt work as needed when ghosted. This is the
>situation where a home directory in a map exported from a server, is
>actually not available (eg does not exist) and someone logs into the
>account using wu-ftpd. In this case wu-ftpd thinks all is ok but of course
>an error is returned when the directory access is attempted. In fact an
>error should have been returned at login. Further, I believe this can be
>solved with as little as an additional revalidate call in sys_stat (I
>think the problem call was sys_stst ???).
>
>  
>
The find(1) issue is fairly recent.   This check was added some time 
within the last two years (?) and only appears in the latest distros.

Another problem were the ACL patches for ls(1) and friends.  I *really* 
think they should be lgetxattr ing instead of getxattr.  They even 
explicitly check via an lstat _before hand_ to verify if the file 
S_ISLNK, and only then will it getxattr if it isn't.  Why not extend 
it?   I duno.

>>This is the subtle difference between direct and indirect maps.   The
>>direct map keys are absolute paths, not path components.  We are
>>implementing direct mounts as individual filesystems that will trap on
>>traversal into their base directory.  This filesystem has no idea where
>>it is located as far as the user is concerned.  We need to tell the
>>filesystem directly so that the usermode helper can look it up.
>>Conversely, the indirect map uses the sub-directory name as a mapkey.
>>    
>>
>
>I'm not sure what you are saying here. Does this mean there is a mount for
>every direct mount (this might be what you call a trigger)?
>
>  
>
Yes, it is its own filesystem (type autofs).  This is needed because we 
need to overlay direct triggers within NFS filesystems for multimounts.

Browsing however obviously doesn't need that because we control the 
parent directory.

>AIX implemented automounts by mounting everything in each map. This
>made the mount listing very ugly.
>
>  
>
??  Really?  I find that hard to believe.  I thought Solaris shared it's 
automounter with HPUX and AIX.  I may be wrong though.

>This sounds like the stat/lstat question again.
>
>I have been able to provide lazy mounts in 4.1 with directory
>browsing but have had to resort to internal sub-mounts when browsing is
>not requested or available. This process sounds similar to some of
>discussion of muti-mount maps in the paper.
>
>  
>
Yup. We use your browsing stuff for indirect maps with -browse, and we 
use nested direct triggers for the offsets within the multimounts.

>>
>>    
>>
>>>>5.4 Expiry
>>>>
>>>>
>>>>        
>>>>
>>>
>>>      
>>>
>>>>Handling expiry of mounts is difficult to get right.  Several different
>>>>aspects need to be considered before being able to properly perform
>>>>expiry.
>>>>
>>>>
>>>>        
>>>>
>>>The current daemon (with latest patches) seems to get it right most of the
>>>time.
>>>
>>>
>>>
>>>      
>>>
>>It's the rest of the time we want to deal with.  I know Ian has done a
>>lot of good work on this over the past few months and I hope we will be
>>able to use his insight to get everything right.
>>
>>    
>>
>>>>The autofs filesystem really should know as little about VFS internal
>>>>structures as possible.  In this case, the filesystem code is charged
>>>>with walking across mountpoints and manually counting reference counts.
>>>>This task is much better left to the VFS internals.
>>>>
>>>>
>>>>        
>>>>
>>>Someone with a more thorough understanding of the code should comment on
>>>this, but I didn't notice the module rooting through VFS data; it looks
>>>like it relies on use counts maintained by the VFS layer, similar to what
>>>mount(2) relies on to declare a mount to be busy.
>>>
>>>
>>>
>>>      
>>>
>>It manually walks through dentry trees and vfsmount trees (albeit the v3
>>code doesn't do the latter). It manually does reference count checks for
>>business which can change over time.  It also has to do this all with
>>locking, by grabbing vfs specific locks.  I'm pretty sure these
>>structures are _not_ meant to be traversed by anything outside the vfs
>>and the fact that autofs has gotten away with it is a remnant of the
>>fact that dcache_lock used to encompass a lot.  In fact, in 2.5, the
>>vfsmount structures that autofs walks is has split locks and now uses
>>vfsmount_lock, which isn't exported to modules at all.
>>
>>This is a good example of why this stuff should probably be merged into
>>VFS,  autofs4 has yet to be updated to use this lock.  This comes with
>>the decision to a) no longer support it as a module, only built in, or
>>b) make vfsmount_lock accessible to modules.
>>
>>But yes, someone with a more thorough understanding of the code should
>>comment  :)
>>    
>>
>
>Mmm. The vfsmount_lock is available to modules in 2.6. At least it was in
>test11. I'm sure I compiled the module under 2.6 as well???
>
>I thought that, taking the dcache_lock was the correct thing to do when
>traversing a dentry list?
>
>  
>
Walking dentrys still takes the dcache_lock, however walking vfsmounts 
takes the vfsmount_lock.  dcache_lock is no longer used for fast path 
walking either (to the best of my understanding).

find . -name '*.[ch]' -not -path '*SCCS*' | xargs grep vfsmount_lock | 
grep EXPORT

shows no results for vfsmount_lock being exported to modules in 2.6.

>In any case after a mail discussion with Maneesh Soni regarding the
>autofs4 expiry code I rewrote it. Maneesh felt that using reference counts
>was unreliable and recommended that it use VFS api calls where possible. I
>did that and that code is now part of my autofs4 module kit for 2.4 and is
>also present in the patch set I offered to Andrew Morten for inclusion
>in 2.6. It seems to work well. The dentry structures are traversed
>and the dcache_lock is obtained as needed. When I can go no further
>within the autofs filesystem I resort to traversing the vfsmount
>structures to check the mount counts. Maybe we can get some usefull code
>from this.
>
>  
>
I haven't had the chance to step through your new module code 
completely.  sorry.

>>>>Unmounting the filesystem from userspace is racy, as any program can
>>>>begin using a mount between the time the daemon has received a path to
>>>>expire and the time it actually makes the umount(2) system call.
>>>>
>>>>
>>>>        
>>>>
>>>So the helper's umount() will fail.  OK, it failed.  The kernel module
>>>should not recognize the mounted dir as being gone, until the module itself
>>>has seen that it's gone.  This policy also helps in cases where the sysop
>>>manually unmounts an automounted directory for repair purposes.
>>>      
>>>
>
>The autofs4 moudule blocks (auto) mounts during the umount callback.
>Surely this is the sensible thing to do.
>
>  
>
The raciness comes from the fact that we now support the lazy-mounting 
of multimount offsets using embedded direct mounts.  Autofs4 mounts all 
(or as much as it can) from the multimount all together, and unmounts it 
all on expiry.

>>>As pointed out in 5.5.1, when the maps change a userspace program will have
>>>to detect some added or deleted items.  This program will have to run
>>>separately in the context of every namespace.  Thus, we should probably
>>>burden the sysop with remembering to run it if he wants his new/deleted
>>>maps to be recognized. But we'll have to use some ioctl to stimulate the
>>>kernel module to enumerate all known namespaces and run the updater for
>>>each one.
>>>
>>>      
>>>
>>Nah.   I leave that as a namespace-aware cron job problem ;)
>>    
>>
>
>More info please?
>Cloning namespaces?
>
>  
>
I think this 'stimulation' you called it should be the responsibility of 
the namespace cloner.  They could fork off their own little daemon that 
will call 'automount update' every so often.

>>Lazy unmounts appear immediately in your system.
>>
>>This may not be the only functionality needed, yes.  I'm sure there are
>>more options required given the circumstances of the kill.  I probably
>>shouldn't have mentioned the lazy unmounting for the forced expiry.
>>
>>I'd be interested to hear more about the different types of
>>(expire/kill) operations that sysadmins prefer.
>>    
>>
>
>Hang on. From the discussion my impression of a lazy mount is that it is
>not actually mounted!
>
>  
>
Lazy _un_mounts as opposed to lazy mounts. Lazy unmounts are described 
in umount(8):

       -l     Lazy unmount. Detach the filesystem from the filesystem  
hierar-
              chy now, and cleanup all references to the filesystem as 
soon as
              it is not busy anymore.  (Requires kernel 2.4.11 or later.)

HTH,

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


--------------enig4E10795A029B7FCDF0B4D7B0
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Debian - http://enigmail.mozdev.org

iD8DBQE//XnMdQs4kOxk3/MRApBPAKCHeioSpb5O++Csd5h7QYjwRbZZBgCgkKwU
bop3z5UcpTsD2zB1TXY5Rh4=
=yTo+
-----END PGP SIGNATURE-----

--------------enig4E10795A029B7FCDF0B4D7B0--

