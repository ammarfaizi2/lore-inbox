Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUHZAvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUHZAvi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUHZAvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:51:04 -0400
Received: from lakermmtao02.cox.net ([68.230.240.37]:50825 "EHLO
	lakermmtao02.cox.net") by vger.kernel.org with ESMTP
	id S266525AbUHZAuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:50:37 -0400
In-Reply-To: <412D2BD2.2090408@sun.com>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org> <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com> <412D2BD2.2090408@sun.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EAB989A6-F6F9-11D8-A7C9-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
       Tim Hockin <thockin@hockin.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Date: Wed, 25 Aug 2004 20:50:25 -0400
To: Mike Waychison <Michael.Waychison@Sun.COM>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 25, 2004, at 20:16, Mike Waychison wrote:
> Kyle Moffett wrote:
>> Here's a simple way to do what you want in userspace:
>> 1) Apply the kernel bind mount options fix (*)
>> 2) Run the following shell script
>>
>> cat <<'EOF' >fsviews.bash
>> #! /bin/bash
>> # First make the subdirectories
>> mkdir /fsviews_orig
>> mount -t tmpfs tmpfs /fsviews_rw
>> mkdir /fsviews_orig/dir1
>> mkdir /fsviews_orig/dir2
>> mkdir /fsviews_orig/old
>>
>> # Now make it read-only with a copy in /fsviews
>> mkdir /fsviews
>> mount --bind /fsviews_orig /fsviews
>>
>> # Put directories in /fsviews
>> mount --bind /somewhere/dir1 /fsviews/dir1
>> mount --bind -o ro /otherplace/dir2 /fsviews/dir2
>>
>> # Start the process in a new namespace
>> clone_prog bash <<'BACK_TO_OLD_NAMESPACE'
>>
>> mount -o ro,remount /fsviews_orig
>> pivot_root /fsviews /fsviews/old
>> umount -l /fsviews/old
>> /dir1/myscript &
>>
>> BACK_TO_OLD_NAMESPACE
>>
>> # Remove the extra dirs in this namespace
>> umount -l /fsviews
>> umount -l /fsviews_orig
>> rmdir /fsviews
>> rmdir /fsviews_orig
>>
>> EOF
>>
>> This assumes that clone_prog is a short C program that does a clone()
>> syscall
>> with the CLONE_NEWNS flag and executes a new process.
>>
>> Once this is done, "/dir2/script" is running in a _completely_ new
>> namespace
>> with a read-only root directory and two directories from other parts 
>> of
>> the vfs.
>>
>> (*) IIRC currently bind-mount rw/ro options are those of the 
>> underlying
>> mount,
>> the bind-mount options fix provides a separate set of options for each
>> bound
>> copy.  There is only one minimal security implication without said
>> patch, that
>> root can still 'mount -o rw,remount /' to get root writeable again, 
>> but
>> since it's
>> on tmpfs, that doesn't matter much.  You could also just take away 
>> some
>> capabilities, but otherwise except for the shared process tables this
>> acts very
>> much like a completely new, separate computer.  I've used this to
>> thoroughly
>> secure minimally trusted daemons before. :-D
>>
>> Cheers,
>> Kyle Moffett
>
> This provides minimal protection if any: the user may remount any block
> devices on any given tree in his 'namespace' (in the sense of "that is
> what we call a mount-table in Linux").  *

Ok, so just mount the whole darn thing with "-o nodev" :-D

> If I understand what Hans is looking to get done, he's asking for
> someone to architect a system where any given process can be restricted
> to seeing/accessing a subset of the namespace (in the sense of "a tree
> of directories/files").  Eg: process Foo is allowed access to write to
> /etc/group, but _not_ allowed access to /etc/shadow, under any
> circumstances && Foo will be run as root.  Hell, maybe Foo is never 
> able
> to even _see_ /etc/shadow (making it a true shadow file :).

I would find this much more useful if there was a really lightweight 
bind
mount called a "filebind" or somesuch that could only bindmount files 
and
not directories but had a much lower cost.  Actually, on that issue, 
have
there been any extensive benchmarks on the scalability of bind mounts?
I'm curious how much of a performance hit they place on directory 
lookups.

With a lightweight "filebind" you could generate such a namespace with
the above script and a list of files/directories to give access to. One 
other
useful feature would be a bind mount user-override and umask:

# ls -alh /foo
drwxr-xr-x    2 root root 4.0K Aug 25 20:33 .
drwxr-xr-x   13 root root 4.0K Aug 25 20:33 ..
-rwxr-xr-x    1 root root 0 Aug 25 20:33 baz
# mount --bind -o forceuid=1000,filemask=0137,dirmask=0026 /foo /bar
# ls -alh /bar
drwxr-x---    2 1000 1000 4.0K Aug 25 20:33 .
drwxr-xr-x   13 root root 4.0K Aug 25 20:33 ..
-rw-r-----    1 1000 1000 0 Aug 25 20:33 baz
#

This would be a really useful feature.  It would be nice if there was 
some
common VFS mountpoint layer that transparently provided these kinds
of options (And ro,rw,nodev,etc) for all mounted objects (be they bind
mounts or filesystems.  With this, vfat, iso9660, etc could share an
implementation. (Although I could be just blatantly missing where all of
this is actually implemented properly, so if I'm wrong somewhere,
please do correct me :-D)

> Hans, correct me if I misunderstood.
>
> [*] Somebody really should s/struct namespace/struct mounttable/g (or
> even mounttree) on the kernel sources.  'Namespace' isn't very
> descriptive and it leads to confusion :(

Or maybe somebody should s/namespace/file access mask/ on this
thread :-D.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


