Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266854AbUHZAQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUHZAQs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbUHZAQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 20:16:48 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:6800 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S266854AbUHZAQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 20:16:40 -0400
Date: Wed, 25 Aug 2004 20:16:18 -0400
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: Using fs views to isolate untrusted processes: I need an assistant
 architect in the USA for Phase I of a DARPA funded linux kernel project
In-reply-to: <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Tim Hockin <thockin@hockin.org>, LKML <linux-kernel@vger.kernel.org>,
       Rik van Riel <riel@redhat.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Message-id: <412D2BD2.2090408@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <410D96DC.1060405@namesys.com>
 <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
 <20040825205618.GA7992@hockin.org>
 <30958D95-F6ED-11D8-A7C9-000393ACC76E@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Kyle Moffett wrote:
> On Aug 25, 2004, at 16:56, Tim Hockin wrote:
>
>> On Wed, Aug 25, 2004 at 04:25:24PM -0400, Rik van Riel wrote:
>>
>>>> You can think of this as chroot on steroids.
>>>
>>>
>>> Sounds like what you want is pretty much the namespace stuff
>>> that has been in the kernel since the early 2.4 days.
>>>
>>> No need to replicate VFS functionality inside the filesystem.
>>
>>
>> When I was at Sun, we talked a lot about this.  Mike, does Sun have any
>> iterest in this?
>>
>> We found a lot of shortcomings in implementing various namespace-ish
>> things.
>
>
> Here's a simple way to do what you want in userspace:
> 1) Apply the kernel bind mount options fix (*)
> 2) Run the following shell script
>
> cat <<'EOF' >fsviews.bash
> #! /bin/bash
> # First make the subdirectories
> mkdir /fsviews_orig
> mount -t tmpfs tmpfs /fsviews_rw
> mkdir /fsviews_orig/dir1
> mkdir /fsviews_orig/dir2
> mkdir /fsviews_orig/old
>
> # Now make it read-only with a copy in /fsviews
> mkdir /fsviews
> mount --bind /fsviews_orig /fsviews
>
> # Put directories in /fsviews
> mount --bind /somewhere/dir1 /fsviews/dir1
> mount --bind -o ro /otherplace/dir2 /fsviews/dir2
>
> # Start the process in a new namespace
> clone_prog bash <<'BACK_TO_OLD_NAMESPACE'
>
> mount -o ro,remount /fsviews_orig
> pivot_root /fsviews /fsviews/old
> umount -l /fsviews/old
> /dir1/myscript &
>
> BACK_TO_OLD_NAMESPACE
>
> # Remove the extra dirs in this namespace
> umount -l /fsviews
> umount -l /fsviews_orig
> rmdir /fsviews
> rmdir /fsviews_orig
>
> EOF
>
> This assumes that clone_prog is a short C program that does a clone()
> syscall
> with the CLONE_NEWNS flag and executes a new process.
>
> Once this is done, "/dir2/script" is running in a _completely_ new
> namespace
> with a read-only root directory and two directories from other parts of
> the vfs.
>
> (*) IIRC currently bind-mount rw/ro options are those of the underlying
> mount,
> the bind-mount options fix provides a separate set of options for each
> bound
> copy.  There is only one minimal security implication without said
> patch, that
> root can still 'mount -o rw,remount /' to get root writeable again, but
> since it's
> on tmpfs, that doesn't matter much.  You could also just take away some
> capabilities, but otherwise except for the shared process tables this
> acts very
> much like a completely new, separate computer.  I've used this to
> thoroughly
> secure minimally trusted daemons before. :-D
>
> Cheers,
> Kyle Moffett

This provides minimal protection if any: the user may remount any block
devices on any given tree in his 'namespace' (in the sense of "that is
what we call a mount-table in Linux").  *

If I understand what Hans is looking to get done, he's asking for
someone to architect a system where any given process can be restricted
to seeing/accessing a subset of the namespace (in the sense of "a tree
of directories/files").  Eg: process Foo is allowed access to write to
/etc/group, but _not_ allowed access to /etc/shadow, under any
circumstances && Foo will be run as root.  Hell, maybe Foo is never able
to even _see_ /etc/shadow (making it a true shadow file :).

Hans, correct me if I misunderstood.

[*] Somebody really should s/struct namespace/struct mounttable/g (or
even mounttree) on the kernel sources.  'Namespace' isn't very
descriptive and it leads to confusion :(

- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice
http://www.sun.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBLSvRdQs4kOxk3/MRAnopAJ91xpTEqf1I/jaRdqbjbgfnNuPpugCfbkvz
VeJUBr2UuagZ5UGMGC1nebw=
=XuQT
-----END PGP SIGNATURE-----
