Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWCUNug@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWCUNug (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 08:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030381AbWCUNug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 08:50:36 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:47024 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030380AbWCUNuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 08:50:35 -0500
To: "Albert Cahalan" <acahalan@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>
Subject: Re: [PATCH 05/23] proc: Simplify the ownership rules for /proc
References: <787b0d920603191941w1e0c0af6p63402d068b61b7a5@mail.gmail.com>
	<m1k6apvwbf.fsf@ebiederm.dsl.xmission.com>
	<787b0d920603201722q5c76c4b7g4079effe04c643a9@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 21 Mar 2006 06:49:33 -0700
In-Reply-To: <787b0d920603201722q5c76c4b7g4079effe04c643a9@mail.gmail.com> (Albert
 Cahalan's message of "Mon, 20 Mar 2006 20:22:39 -0500")
Message-ID: <m1bqvzucuq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert Cahalan" <acahalan@gmail.com> writes:

> Use of the info returned by stat() goes way back in history, to a
> time before the /proc/*/status files even existed.

Ok.  That make sense.  Definitely worth keeping then.

Like too many pieces of the /proc implementation the functionality
was kept with no memory of why it was they way it is.

Knowing this I just realized the current implementation is actually
broken with respect to fstat.

> If you want to rip out something, pick a recent and nasty feature.
> The /proc/*/smaps file would be a prime example.
>
> It would be very good to have a set of "deprecated" flags for
> the files in /proc. The files could be present but not seen in
> directory listings, and could log (rate limited) warnings if used.

That and we can drop a note in
Documentation/feature-removal-schedule.txt

I am much more likely to go after the non processes local stuff
in /proc.  Although perversely some of the things like /proc/sysvipc
and /proc/net are likely to become process local and stay.

>> There are some significant changes on my todo list to cope
>> with multiple processes having the same pid but those have not
>> happened yet.
>
> How in Hell is procps supposed to deal with that?
> (and gdb, and gtop, and pstools...) I'd rather not see
> the complexity. It seems I'll need multiple /proc mount
> points, many extra command options, etc.

In current draft I make a child pid space show up in it's parent like
a threaded process.  All of the statistics are under one /proc/pid
directory.  So most things work without modification.

Beyond that for the cluster case I really would like to see
a version of tools that can handle multiple mounts of /proc.
That way I can use 9fs, nfs or similar and mount a remote
copy of /proc and see what is going on.

> This is a lot of work for a feature that seems to be
> taken care of by Xen and SE Linux.

The hard part is actually the code cleanups and api review
and the discussions to get it included.  The actual implementation
is pretty simple.

>> >> /proc/<tgid>/status provides a much better way to read a processes
>> >> effecitve userid, so it is silly to try to provide that on the directory.
>> >
>> > The stat() call is cheap.
>>
>> So I did not break the fact that stat() works.  But now
>> stat does not give you the euid on if the task is not dumpable.
>
> That counts as breaking it.

Agreed.  But unfortunately not enough for it to be immediately visible.

>> > The status file is kind of nasty:
>> Agreed.
>>
>> > The procps code uses stat() for selection by EUID in some
>> > cases, and for everything whenever the status file is not
>> > needed for some other reason. The "top" program is quite
>> > good about not opening the status file. Lots of profiling
>> > showed that there would be a noticable performance difference.
>>
>> All of which sounds sane.  Although I wonder if the kernel side
>> implementation of the status file was improved if that could
>> help things.
>
> The concept is only well-suited to toy sysadmin tool hacks.
>
>> Looking at 2.4 and 2.2 this case does seem to be consistently
>> maintained, although I'm not at all certain if the application
>> changed it's euid that the change would be reflected in /proc,
>> until the version of revalidate in 2.6.
>
> I'm 100% sure this goes back to the 1.2.xx kernels.
> I'm 99% sure it goes back to the 1.0.x kernels. So that
> is over a decade of active use.

Yep.  1.2 is interesting to look at.  It didn't report
the euid unless the uid equaled the euid.  But the implementation
looks surprisingly similar to the current proc.  2.2 looks a lot
more different.

> Remember, there were no /proc/*/status files. There are no UID
> values in the /proc/*/stat files. The procps code worked fine.

The lack of uid values in /proc/*/stat files I hadn't realized.

>> My real problem with the implementation is the hard coded magic
>> inode numbers.  That does really ugly things to the implementation
>> of /proc.
>
> You could probably set all the inode numbers to 42 and
> not have anything break.

find in /proc breaks if I do that :)

> I notice that you made a comment about being annoyed that
> the Alpha has a 32-bit ino_t, which thus can't hold a pointer.
>
> There won't be any more Alpha systems, so memory sizes
> won't be getting any bigger for them, so...
>
> cookie = ((unsigned long)ptr-PAGE_OFFSET)/sizeof(struct foo)

Yes.  I have been thinking about that.  That looks like
a good implementation to put into fs/inode.c:new_inode().

Alpha has a 40bit physical address space so I need a structure
that is at least 256 bytes for that to work properly.  Unfortunately
struct inode easily qualifies.  

A related question is do you know if there is a way to tell
if two processes share a the filesystem mount namespace?

> BTW, the max pid is limited by the pid allocator and the futex
> code, so you only need 7 decimal digits.

Yes the pid allocator limits the current pid value to that range.
I'm not at all certain I like the futex code caring.

>> If instead of special case /proc/<pid>/ would it be ok if
>> this applied to any directory that is world readable and executable?
>>
>> ie.
>>
>> #define S_ISDIR_RXUGO(m) \
>>         (((m) & (S_IFMT|S_IRUGO|S_IXUGO)) == (S_IFDIR|S_IRUGO|S_IXUGO))
>
> This kind of S_IRUGORXXWUOG stuff is quite unreadable.
> Octal is way easier to deal with, especially once you get
> to ORing the values together to make up for not having 512
> defines for the permissions.
>

I am almost convinced.  Things like reading the type don't
work quiet as well.

Well the check wound up being:
	if ((inode->i_mode == S_IFDIR|S_IRUGO|S_IXUGO) ||

Which is a little less magic than I proposed, and I don't think
spotting the type of a file is at easy to do in octal.

>> if (S_ISDIR_RXUGO(inode->i_mode) || task_dumpable(task)) {
>>         inode->i_uid = task->euid;
>>         inode->i_gid = task->egid;
>> } else {
>>         inode->i_uid = 0;
>>         inode->i_gid = 0;
>> }
>
> That seems OK, depending on how /proc/*/fd/* works.

I deliberately made the check so it doesn't select
the /proc/*/fd and fd/* files.  So we should be ok there.

That is the one big change I have made.  The /proc/*/fd/*
files no require you to be able to ptrace the process to
use them.  For anyone outside a chroot who isn't root
the change should be totally invisible.

> Given the nature of /proc, checking at read() time is probably
> a better idea. Any checking at open() should just be a bit of
> politeness. It's not always OK to keep using a file descriptor
> after the app went through a setuid exec.

Hmm.  Good point.  All of the serious permission checking in
/proc already does that but this bit in revalidate needs a bit
of reexamination.

> The /proc/*/mem files are broken right now. They should be
> readable and writable to anybody who could use ptrace, even
> if not currently attached. (as is now, they are just a less-bad
> way for debuggers to read memory)

Makes sense.  Currently the mem_write is totally disabled.
Which is probably worse.

> It would be nice to ensure that a PID doesn't get reused while
> a /proc file is open. Then, just by keeping the directory open,
> apps would avoid inconsistencies.

The problem there is that unless we make the pid space a lot bigger
it becomes trivial to exhaust the pid allocator.  I think I could
do that with about 32 processes each with a 1000 open directories.
Something within most systems rlimit values.  The real pain
is that except for my tree in /proc that keeps task_struct pinned
so you can burn a lot of low memory doing that.

A variant of that does work.  You can open the pid directory and then
check the directory to see if the process is still alive.  It's
not quite as good but it does give you a way to detect pid wrap
around.  Unfortunately that isn't completely race free.

Hmm.  It just occurred to me pid files that include the process
start time would be much more robust.  Unfortunately that falls down
because you can't get the start time portably, or easily.

Eric
