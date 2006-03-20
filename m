Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWCTRwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWCTRwV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 12:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWCTRwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 12:52:21 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50342 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932327AbWCTRwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 12:52:21 -0500
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 05/23] proc: Simplify the ownership rules for /proc
References: <787b0d920603191941w1e0c0af6p63402d068b61b7a5@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 20 Mar 2006 10:51:32 -0700
In-Reply-To: <787b0d920603191941w1e0c0af6p63402d068b61b7a5@mail.gmail.com> (Albert
 Cahalan's message of "Sun, 19 Mar 2006 22:41:30 -0500")
Message-ID: <m1k6apvwbf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> Eric W. Biederman writes:
>
>> Currently in /proc if the task is dumpable all of files are owned by
>> the tasks effective users.  Otherwise the files are owned by root.
>> Unless it is the /proc/<tgid>/ or /proc/<tgid>/task/<pid> directory
>> in that case we always make the directory owned by the effective user.
>>
>> However the special case for directories is pointless except as a way
>> to read the effective user, because the permissions on both of those
>> directories are world readable, and executable.
>
> Well, that's exactly how "top" gets the EUID. The code:
>
> p->euid = sb.st_uid;       /* need a way to get real uid */
> p->egid = sb.st_gid;       /* need a way to get real gid */
>
> I sure hope this patch didn't slip by me somehow. 

It is still in -mm so there is sufficient time to comment.  My apologies
for not cc'ing you.

> Big proc changes
> ought to get review by the maintainers of procps, gtop, gdb, and
> probably a good number of packages that don't come to mind right now.
> I'm lucky I spotted this while reading over old lwn.net stories.

Well it is a bunch of cleanups to the implementation of /proc not
really a big user visible change.  The problem is that the implementation
is a maintenance nightmare.

There are some significant changes on my todo list to cope
with multiple processes having the same pid but those have not
happened yet.

>> /proc/<tgid>/status provides a much better way to read a processes
>> effecitve userid, so it is silly to try to provide that on the directory.
>
> The stat() call is cheap.

So I did not break the fact that stat() works.  But now
stat does not give you the euid on if the task is not dumpable.

> The status file is kind of nasty:
Agreed.

> The procps code uses stat() for selection by EUID in some
> cases, and for everything whenever the status file is not
> needed for some other reason. The "top" program is quite
> good about not opening the status file. Lots of profiling
> showed that there would be a noticable performance difference.

All of which sounds sane.  Although I wonder if the kernel side
implementation of the status file was improved if that could
help things.

Looking at 2.4 and 2.2 this case does seem to be consistently
maintained, although I'm not at all certain if the application
changed it's euid that the change would be reflected in /proc,
until the version of revalidate in 2.6.

My real problem with the implementation is the hard coded magic
inode numbers.  That does really ugly things to the implementation
of /proc.

If instead of special case /proc/<pid>/ would it be ok if
this applied to any directory that is world readable and executable?

ie.

#define S_ISDIR_RXUGO(m) \
	(((m) & (S_IFMT|S_IRUGO|S_IXUGO)) == (S_IFDIR|S_IRUGO|S_IXUGO))

if (S_ISDIR_RXUGO(inode->i_mode) || task_dumpable(task)) {
	inode->i_uid = task->euid;
	inode->i_gid = task->egid;
} else {
	inode->i_uid = 0;
	inode->i_gid = 0;
}
	
Eric
