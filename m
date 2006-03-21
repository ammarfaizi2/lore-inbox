Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWCUBWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWCUBWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 20:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964791AbWCUBWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 20:22:41 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:29143 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964779AbWCUBWk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 20:22:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gTaUbdeg3NDQzuLGrei/NFvXyXjd4lkjEcys0YK0971hEUthF2aED7ZlkVFZMrA/I2NtiOOtJ1UHJQs0YdXrpjZ6P47QSv8O3Xx4j2jzghmfu0Hgf4BeuYPKwKmsNDi5gth77x4DEgGx5PgLSk1rSFXjN12Cqlnm/YrnFo6JUDc=
Message-ID: <787b0d920603201722q5c76c4b7g4079effe04c643a9@mail.gmail.com>
Date: Mon, 20 Mar 2006 20:22:39 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 05/23] proc: Simplify the ownership rules for /proc
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <m1k6apvwbf.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920603191941w1e0c0af6p63402d068b61b7a5@mail.gmail.com>
	 <m1k6apvwbf.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Albert Cahalan" <acahalan@gmail.com> writes:

> > Well, that's exactly how "top" gets the EUID. The code:
> >
> > p->euid = sb.st_uid;       /* need a way to get real uid */
> > p->egid = sb.st_gid;       /* need a way to get real gid */
> >
> > I sure hope this patch didn't slip by me somehow.
>
> It is still in -mm so there is sufficient time to comment.  My apologies
> for not cc'ing you.
>
> > Big proc changes
> > ought to get review by the maintainers of procps, gtop, gdb, and
> > probably a good number of packages that don't come to mind right now.
> > I'm lucky I spotted this while reading over old lwn.net stories.
>
> Well it is a bunch of cleanups to the implementation of /proc not
> really a big user visible change.  The problem is that the implementation
> is a maintenance nightmare.

Use of the info returned by stat() goes way back in history, to a
time before the /proc/*/status files even existed.

If you want to rip out something, pick a recent and nasty feature.
The /proc/*/smaps file would be a prime example.

It would be very good to have a set of "deprecated" flags for
the files in /proc. The files could be present but not seen in
directory listings, and could log (rate limited) warnings if used.

> There are some significant changes on my todo list to cope
> with multiple processes having the same pid but those have not
> happened yet.

How in Hell is procps supposed to deal with that?
(and gdb, and gtop, and pstools...) I'd rather not see
the complexity. It seems I'll need multiple /proc mount
points, many extra command options, etc.

This is a lot of work for a feature that seems to be
taken care of by Xen and SE Linux.

> >> /proc/<tgid>/status provides a much better way to read a processes
> >> effecitve userid, so it is silly to try to provide that on the directory.
> >
> > The stat() call is cheap.
>
> So I did not break the fact that stat() works.  But now
> stat does not give you the euid on if the task is not dumpable.

That counts as breaking it.

> > The status file is kind of nasty:
> Agreed.
>
> > The procps code uses stat() for selection by EUID in some
> > cases, and for everything whenever the status file is not
> > needed for some other reason. The "top" program is quite
> > good about not opening the status file. Lots of profiling
> > showed that there would be a noticable performance difference.
>
> All of which sounds sane.  Although I wonder if the kernel side
> implementation of the status file was improved if that could
> help things.

The concept is only well-suited to toy sysadmin tool hacks.

> Looking at 2.4 and 2.2 this case does seem to be consistently
> maintained, although I'm not at all certain if the application
> changed it's euid that the change would be reflected in /proc,
> until the version of revalidate in 2.6.

I'm 100% sure this goes back to the 1.2.xx kernels.
I'm 99% sure it goes back to the 1.0.x kernels. So that
is over a decade of active use.

Remember, there were no /proc/*/status files. There are no UID
values in the /proc/*/stat files. The procps code worked fine.

> My real problem with the implementation is the hard coded magic
> inode numbers.  That does really ugly things to the implementation
> of /proc.

You could probably set all the inode numbers to 42 and
not have anything break.

I notice that you made a comment about being annoyed that
the Alpha has a 32-bit ino_t, which thus can't hold a pointer.

There won't be any more Alpha systems, so memory sizes
won't be getting any bigger for them, so...

cookie = ((unsigned long)ptr-PAGE_OFFSET)/sizeof(struct foo)

BTW, the max pid is limited by the pid allocator and the futex
code, so you only need 7 decimal digits.

> If instead of special case /proc/<pid>/ would it be ok if
> this applied to any directory that is world readable and executable?
>
> ie.
>
> #define S_ISDIR_RXUGO(m) \
>         (((m) & (S_IFMT|S_IRUGO|S_IXUGO)) == (S_IFDIR|S_IRUGO|S_IXUGO))

This kind of S_IRUGORXXWUOG stuff is quite unreadable.
Octal is way easier to deal with, especially once you get
to ORing the values together to make up for not having 512
defines for the permissions.

> if (S_ISDIR_RXUGO(inode->i_mode) || task_dumpable(task)) {
>         inode->i_uid = task->euid;
>         inode->i_gid = task->egid;
> } else {
>         inode->i_uid = 0;
>         inode->i_gid = 0;
> }

That seems OK, depending on how /proc/*/fd/* works.

Given the nature of /proc, checking at read() time is probably
a better idea. Any checking at open() should just be a bit of
politeness. It's not always OK to keep using a file descriptor
after the app went through a setuid exec.

The /proc/*/mem files are broken right now. They should be
readable and writable to anybody who could use ptrace, even
if not currently attached. (as is now, they are just a less-bad
way for debuggers to read memory)

It would be nice to ensure that a PID doesn't get reused while
a /proc file is open. Then, just by keeping the directory open,
apps would avoid inconsistencies.
