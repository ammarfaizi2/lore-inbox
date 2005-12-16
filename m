Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVLPMlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVLPMlU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVLPMlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:41:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55763 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932239AbVLPMlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:41:19 -0500
To: JANAK DESAI <janak@us.ibm.com>
Cc: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm 1/9] unshare system call: system call handler
 function
References: <1134513959.11972.167.camel@hobbs.atlanta.ibm.com>
	<m1k6e687e2.fsf@ebiederm.dsl.xmission.com>
	<43A1D435.5060602@us.ibm.com>
	<m1d5jy83nr.fsf@ebiederm.dsl.xmission.com>
	<43A24362.6000602@us.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 16 Dec 2005 05:39:29 -0700
In-Reply-To: <43A24362.6000602@us.ibm.com> (JANAK DESAI's message of "Thu,
 15 Dec 2005 23:32:34 -0500")
Message-ID: <m11x0d8bcu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JANAK DESAI <janak@us.ibm.com> writes:

> Eric W. Biederman wrote:
>
>>JANAK DESAI <janak@us.ibm.com> writes:
>>
>>
>>
>>>Eric W. Biederman wrote:
>>>
>>>
>>>
>>>>If it isn't legal how about we deny the unshare call.
>>>>Then we can share this code with clone.
>>>>
>>>>Eric
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>unshare is doing the reverse of what clone does. So if you are unsharing
>>>namespace
>>>you want to make sure that you are not sharing fs. That's why the CLONE_FS
> flag
>>>is forced (meaning you are also going to unshare fs). Since namespace is
> shared
>>>by default and fs is not, if clone is called with CLONE_NEWNS, the intent is
> to
>>>create a new namespace, which means you cannot share fs. clone checks to
>>>makes sure that CLONE_NEWNS and CLONE_FS are not specified together, while
>>>unshare will force CLONE_FS if CLONE_NEWNS is spefcified. Basically you
>>>can have a shared namespace and non shared fs, but not the other way around
> and
>>>since clone and unshare are doing opposite things, sharing code between them
>>>that
>>>checks constraints on the flags can get convoluted.
>>>
>>>
>>
>>I follow but I am very disturbed.
>>
>>You are leaving CLONE_NEWNS to mean you want a new namespace.
>>
>>For clone CLONE_FS unset means generate an unshared fs_struct
>>          CLONE_FS set   means share the fs_struct with the parent
>>
>>But for unshare CLONE_FS unset means share the fs_struct with others
>>            and CLONE_FS set   means generate an unshared fs_struct
>>
>>The meaning of CLONE_FS between the two calls in now flipped,
>>but CLONE_NEWNS is not.  Please let's not implement it this way.
>>
>>
>>
> CLONE_FS unset for unshare doesn't mean that share the fs_struct with
> others. It just means that you leave the fs_struct alone (which may or
> maynot be shared). 

Right but that leaves that data shared.  It is a bit challenging
describing the bits in a way that makes sense from both the
clone and the unshare perspective.

What I see as fundamental is that after a the syscall a resource
may be in one of two states.
- possibly shared with others
- definitely not shared with others

In the clone case the sharing is guaranteed unless your
parent has just exited.  But if you don't count your parent
then clone and unshare should look alike.

> I agree that it is confusing, but I am having difficulty
> in seeing this reversal of flag meaning. 

Carefully note that CLONE_NEWNS behaves differently than most
of the other clone flags because by default the NS stays shared.

> clone creates a second task and
> allows you to pick what you want to share with the parent. unshare allows
> you to pick what you don't want to share anymore. The "what" in both
> cases can be same and still you can end up with a task with "share" state
> for a perticular structure. For example, if we #define  FS   CLONE_FS,
> then clone(FS) will imply that you want to share fs_struct but unshare(FS)
> will imply that we want to unshare fs_struct. Does it still appear that
> the flag meaning has changed? 

So you are having clone and unshare do opposite things.

If that is the intention you are broken with respect to CLONE_NEWNS.
In your implementation.
clone(NEWNS) implies you don't share struct namespace  and
unshare(NEWNS) implies you don't share struct namespace.

> clone and unshare are doing different
> things, the flag just indicates the structure on which they operate.

Another way to think of it is one way to implement unshare is
to call clone with the appropriate flags and to have the parent
exit.  Not counting pids and the process tree this should
give identical results to unshare.

If I called sys_unshare(0) without changing the meaning of
the bits I would expect my VM to be unshared, my FS state
to be unshared, my file descriptors to be unshared,  my signal
handling to be unshared, my tgid to be unshared, to continue
sharing my namespace, my sysv semaphore undo semantics to be
unshared, and my thread local storage to be unshared.

Basically I expect sys_unshare(0) to take a thread an turn
it into a full process by default.  That preserves the current
defaults about which things should be shared and which things
should be unshared.  Basically I expect fork() unshare(0) to
be a noop, but not clone(...) unshare(0).

Just using the bits as resource identifiers and not preserving
the default share/unshare status leads to confusion from
implementors because we the set of legal bits is different
in the two cases, and it is confusing to users because they
can't just take bits passed into clone and get the same results
passing those bits into unshare.

They are different in that unshare does not create a new process
and the difference between operating on a new process versus
your current process should be the only difference, not something
that is lost in the noise of given fresh meaning to the bits.

The core expectation is that unshare(CLONE_NEWNS) will give
a new namespace.  Currently to meet that expectation you are
changing the set of bits internally, instead of erring about
a bad set of bits being specified.  If however you leave the
defaults to unshare everything but the namespace you don't
have to toggle the bits to meet the expectation of what will
work, and you don't have to change the meaning of the bits.

>>Part of the problem is the double negative in the name, leading
>>me to suggest that sys_share might almost be a better name.
>>
>>
>>
> I disagree. You cannot start sharing with this system call. You can
> only unshare a shared structure. If you don't specify a flag corresponding
> to a structure, that structure stays in its current state which may be
> shared or unshared. Since the only action you can perform with this
> call is unshare, unshare is the more appropriate name.

Of the two names I agree that unshare is more appropriate however
because we have double negatives things get confusing.  That was
the point in mentioning this strawman.  For my vision of a syscall
that unshared practically everything by default I think unshare
is clearly a better name.

>>So please code don't invert the meaning of the bits.  This will
>>allow sharing of the sanity checks with clone.
>>
>>In addition this leaves open the possibility that routines like
>>copy_fs properly refactored can be shared between clone and unshare.
>>
>>
>>
>>
> umm.. I am not sure how you were thinking of refactoring it, but my attempt at
> using copy_* functions introduced race conditions.

We clearly cannot reuse these copy_* functions as is.

I hadn't looked closely yet.  But lets see.

static int share_fs(unsigned long clone_flags, struct fs_struct **fsp)
{
        struct fs_struct *fs = current->fs;
        if (clone_flags & CLONE_FS) {
                atomic_inc(&fs->count);
        }
        else if (likely(&current->fs != fsp) ||	(atomic_read(&fs->count) > 1)) {
		*fsp = __copy_fs_struct(fs);
                if (!*fsp)
                	return -ENOMEM;
        }
        return 0;
}

static inline int copy_fs(unsigned long clone_flags, struct task_struct *tsk)
{
        return share_fs(clone_flags, &tsk->fs);
}

That should handle both cases.  The only real changes were
passing in the address of a fs_struct pointer, and the additional
test to see if we can avoid copying in the unshare case.

People interested in massive performance tuning of fork might be
concerned but the mere mortals it looks to only be a few cycles
different either way and the gain in maintainability should more than
make up for the performance difference.

Eric
