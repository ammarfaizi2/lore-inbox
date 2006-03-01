Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751452AbWCAERg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWCAERg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:17:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWCAERg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:17:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:42213 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751452AbWCAERg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:17:36 -0500
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, laurent.riffard@free.fr,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, rjw@sisk.pl,
       mbligh@mbligh.org, clameter@engr.sgi.com
Subject: Re: 2.6.16-rc5-mm1
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	<20060228190535.41a8c697.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 21:15:41 -0700
In-Reply-To: <20060228190535.41a8c697.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Feb 2006 19:05:35 -0800")
Message-ID: <m1wtfepzpu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

> I have popped the patch stack back to including:
>> trivial-cleanup-to-proc_check_chroot.patch
>> proc-fix-the-inode-number-on-proc-pid-fd.patch
>
> but not past that.  It boots now, unlike before with the full patch
> stack.
>
> I will continue the hunt.
>
> Meanwhile, on the side,  I have a couple of permission problems to
> report to Eric Biederman with apps that are complaining about not being
> able to access /proc/<pid>/fd/[0-9]* files when before they could:
>
>  1) Logged in as root, running "/bin/ls -l /proc/*/fd/*"
>     causes some complaints.  For example:
>
>     # /bin/ls -l /proc/2868/fd/?
>     /bin/ls: cannot read symbolic link /proc/2868/fd/6: Permission denied
>     /bin/ls: cannot read symbolic link /proc/2868/fd/7: Permission denied
>     lr-x------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/0 -> /dev/null
>     lrwx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/1 -> /dev/pts/10
>     lrwx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/2 -> /dev/pts/10
>     lr-x------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/3 ->
> /proc/sal/cmc/event
>     lrwx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/4 -> /proc/sal/cmc/data
>     l-wx------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/6
>     lr-x------ 1 root root 64 Feb 28 18:39 /proc/2868/fd/7
>   
>     I don't recall seeing any similar complaints before.  My first reaction
>     is "wtf - I'm root - what's this permission denied error ?!?"
>
>  2) I have an SGI specific application that runs out of init on boot
>     that spews out some 50 or so "Permission denied" errors on
>     various /proc/<pid>/fd/* files, which it never did before that
>     I can recall.
>
>     For example, this app complained:
>
> 	Cannot stat file /proc/1688/fd/3: Permission denied
> 	Cannot stat file /proc/1688/fd/4: Permission denied
> 	Cannot stat file /proc/1688/fd/5: Permission denied
> 	Cannot stat file /proc/1688/fd/6: Permission denied
> 	Cannot stat file /proc/1688/fd/7: Permission denied
> 	Cannot stat file /proc/2781/fd/3: Permission denied
> 	Cannot stat file /proc/2802/fd/1: Permission denied
> 	Cannot stat file /proc/2802/fd/3: Permission denied
> 	Cannot stat file /proc/2802/fd/4: Permission denied
> 	Cannot stat file /proc/2878/fd/6: Permission denied
> 	Cannot stat file /proc/2878/fd/7: Permission denied
>
>     You can see it is not complaining about all the fd's of a task,
>     but just some.
>
>     I might be confused in what patches I'm running, but I believe that
>     I am getting these permission denied errors with just the patches:

So the function that will be giving you trouble is proc_check_dentry_visible.

The patch should be called something like: 
proc-Properly-filter-out-files-that-are-not-visible-to-a-process

It was the 8th patch on my stack when I submitted it.

Largely what is happening is that I fixed the permission checks that
have been in the kernel since 2.2 so that they work.  I'm not saying
that what I am doing right now is correct but it is something we need
to consider.

The logic is can I access this file in some other way besides through
/proc.

When applied to /proc/<pid>/exe
When applied to /proc/<pid>/root
When applied to /proc/<pid>/cwd

I have some concerns about it's correctness but when applied to
/proc/<pid>/fd/<#>
my only concern is if the checks are complete, or if we even want them.

There may be a capability I need to check that says anything goes.

There are 2 sets out file descriptors that will now be unaccessible.
- Files on internal filesystems like pipefs.
- Files on outside of your filesystem root or filesystem namespace.

If you share the struct file with the process everything should be visible.

We may want different checks for readlink and follow link.

If you want to kill the permission checks to stop the noise for a while
it should be straight forward.

Eric
