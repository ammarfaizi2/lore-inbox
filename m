Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266425AbUHYXWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266425AbUHYXWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266149AbUHYXUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:20:52 -0400
Received: from lakermmtao12.cox.net ([68.230.240.27]:32756 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S266281AbUHYXT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:19:27 -0400
In-Reply-To: <20040825205618.GA7992@hockin.org>
References: <410D96DC.1060405@namesys.com> <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com> <20040825205618.GA7992@hockin.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>,
       michael.waychison@sun.com, ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant architect in the USA for Phase I of a DARPA funded linux kernel project
Date: Wed, 25 Aug 2004 19:19:19 -0400
To: Tim Hockin <thockin@hockin.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 25, 2004, at 16:56, Tim Hockin wrote:
> On Wed, Aug 25, 2004 at 04:25:24PM -0400, Rik van Riel wrote:
>>> You can think of this as chroot on steroids.
>>
>> Sounds like what you want is pretty much the namespace stuff
>> that has been in the kernel since the early 2.4 days.
>>
>> No need to replicate VFS functionality inside the filesystem.
>
> When I was at Sun, we talked a lot about this.  Mike, does Sun have any
> iterest in this?
>
> We found a lot of shortcomings in implementing various namespace-ish
> things.

Here's a simple way to do what you want in userspace:
1) Apply the kernel bind mount options fix (*)
2) Run the following shell script

cat <<'EOF' >fsviews.bash
#! /bin/bash
# First make the subdirectories
mkdir /fsviews_orig
mount -t tmpfs tmpfs /fsviews_rw
mkdir /fsviews_orig/dir1
mkdir /fsviews_orig/dir2
mkdir /fsviews_orig/old

# Now make it read-only with a copy in /fsviews
mkdir /fsviews
mount --bind /fsviews_orig /fsviews

# Put directories in /fsviews
mount --bind /somewhere/dir1 /fsviews/dir1
mount --bind -o ro /otherplace/dir2 /fsviews/dir2

# Start the process in a new namespace
clone_prog bash <<'BACK_TO_OLD_NAMESPACE'

mount -o ro,remount /fsviews_orig
pivot_root /fsviews /fsviews/old
umount -l /fsviews/old
/dir1/myscript &

BACK_TO_OLD_NAMESPACE

# Remove the extra dirs in this namespace
umount -l /fsviews
umount -l /fsviews_orig
rmdir /fsviews
rmdir /fsviews_orig

EOF

This assumes that clone_prog is a short C program that does a clone() 
syscall
with the CLONE_NEWNS flag and executes a new process.

Once this is done, "/dir2/script" is running in a _completely_ new 
namespace
with a read-only root directory and two directories from other parts of 
the vfs.

(*) IIRC currently bind-mount rw/ro options are those of the underlying 
mount,
the bind-mount options fix provides a separate set of options for each 
bound
copy.  There is only one minimal security implication without said 
patch, that
root can still 'mount -o rw,remount /' to get root writeable again, but 
since it's
on tmpfs, that doesn't matter much.  You could also just take away some
capabilities, but otherwise except for the shared process tables this 
acts very
much like a completely new, separate computer.  I've used this to 
thoroughly
secure minimally trusted daemons before. :-D

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


