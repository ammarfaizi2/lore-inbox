Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267312AbTBPSBe>; Sun, 16 Feb 2003 13:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267315AbTBPSBe>; Sun, 16 Feb 2003 13:01:34 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46600 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267312AbTBPSB2>; Sun, 16 Feb 2003 13:01:28 -0500
Date: Sun, 16 Feb 2003 10:07:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fw: 2.5.61 oops running SDET
In-Reply-To: <11830000.1045368054@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0302160952280.2619-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Feb 2003, Martin J. Bligh wrote:
> 
> OK, I did the following, which is what I think you wanted, plus Zwane's
> observation that task_state acquires the task_struct lock (we're the only 
> caller, so I just removed it), but I still get the same panic and this time
> the box hung.

Yeah, a closer look shows that the exit path doesn't actually take the
task lock at all around any of the signal stuff, so the lock protects
"task->mm", "task->files" and "task->fs", but it does NOT protect
"task->signal" or "task->sighand" (illogical, but true).

Oh, damn.

The core that checks for "p->sighand" takes the tasklist lock for this
reason (see "collect_sigign_sigcatch()"

So the choice seems to be either:

 - make the exit path hold the task lock over the whole exit path, not 
   just over mm exit.

 - take the "tasklist_lock" over more of "task_sig()" (not just the 
   collect_sigign_sigcatch() thing, but the "&p->signal->shared_pending"  
   rendering too.

The latter is a two-liner. The former is the "right thing" for multiple 
reasons.

The reason I'd _like_ to see the task lock held over _all_ of the fields
in the exit() path is:

 - right now we actually take it and drop it multiple times in exit. See 
   __exit_files(), __exit_fs(), __exit_mm(). Which all take it just to 
   serialize setting ot "mm/files/fs" to NULL.

 - task_lock is a nice local lock, no global scalability impact.

So it really would be much nicer to do something like this in do_exit():

	struct mm_struct *mm;
	struct files_struct *files;
	struct fs_struct *fs;
	struct signal_struct *signal;
	struct sighand_struct *sighand;

	task_lock(task);
	mm = task->mm;
	files = task->files;
	fs = task->fs;
	signal = task->signal;
	sighand = task->sighand;

	task->mm = NULL;
	task->files = NULL;
	task->fs = NULL;
	task->signal = NULL;
	task->sighand = NULL;
	task_unlock(task);

	.. actually do the "__exit_mm(task, mm)" etc here ..

which would make things a lot more readable, and result in us taking the
lock only _once_ instead of three times, and would properly protect
"signal" and "sighand" so that the /proc code wouldn't need to take the
heavily used "tasklist_lock" just to read the signal state for a single
task.

But fixing up exit to do the above would require several (trivial) calling 
convention changes, like changing 

	static inline void __exit_mm(struct task_struct * tsk)
	{
	        struct mm_struct *mm = tsk->mm;
		...

into

	static inline void __exit_mm(struct task_struct * tsk,
			struct mm_struct *mm)
	{
		...

instead and updatign the callers. 

Is anybody willing to do that (hopefully fairly trivial) fixup and test
it, or should we go with the stupid "take the 'tasklist_lock'" approach?

			Linus

