Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264093AbUENEsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264093AbUENEsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 00:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbUENEsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 00:48:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:34024 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264093AbUENEso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 00:48:44 -0400
Date: Thu, 13 May 2004 21:48:43 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040513214843.N21045@build.pdx.osdl.net>
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <40A42E8E.4030603@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40A42E8E.4030603@myrealbox.com>; from luto@myrealbox.com on Thu, May 13, 2004 at 07:27:26PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
> Chris Wright wrote:
> 
> > * Andy Lutomirski (luto@myrealbox.com) wrote:
> > 
> >>Implement optional working capability support.  Try to avoid giving Andrew
> >>a heart attack. ;)
> > 
> > I think it still needs more work.  Default behavoiur is changed, like
> > Inheritble is full rather than clear, setpcap is enabled, etc.  ...
> 
> In cap_bprm_apply_creds_compat:
> 
> +	} else if (!fixed_init) {
> +		/* This is not strictly correct, as it gives linuxrc more
> +		 * permissions than it used to have.  It was the only way I
> +		 * could think of to keep the resulting disaster contained,
> +		 * though.
> +		 */
> +		current->cap_effective = CAP_OLD_INIT_EFF_SET;
> +		current->cap_inheritable = CAP_OLD_INIT_INH_SET;
> +		fixed_init = 1;
> 
> So that it gets changed back.  Otherwise linuxrc ran without permissions
> and my drives never got mounted.  Yah, it's ugly -- I'm open to
> suggestions to avoid this.

I tested as a module, and this doesn't run AFAICS

>  > ... Also,
> > why do you change from Posix the way exec() updates capabilities?  Sure,
> > there is no filesystem bits present, so this changes the calculation,
> > but I'm not convinced it's as secure this way.  At least with newcaps=0.
> 
> I'm not convinced that Posix's version makes any sense.  Also, there are
> apparently a number of drafts around which disagree on what the right
> rules are.  (My copy, for example, matches the old rules exactly, but
> the old rules caused the sendmail problem.)  And, under Posix, what does
> the inheritable mask mean, anyway?
> 
> Also, I don't find the posix rules to be useful (why is there an
> inheritable mask if all it does is to cause caps to be dropped on
> exec, when the user could just manually drop them?).

Not sure if it's defensible, but it allows passing on an inheritable
capability through an intermediate process that simply can't inherit
that capability.  This is not unlike requiring an unprivileged process
to ask a privileged process for it to do something on it's behalf.
Certainly it's implicit that you trust the privileged process.

> > I believe we can get something functional with fewer changes, hence
> > easier to understand the ramifications.  In a nutshell, I'm still not
> > comfortable with this.
> 
> I'll play with it, but I think this is the shortest patch I've come up
> with.  I'll admit that touching this stuff scares me too, but I'd rather
> redo it that try and patch it over again.

Yeah, the subtleties are unnerving.

> > Also, it breaks my tests which try to drop privs and keep caps across
> > execve() which is really the only issue we're trying to solve ATM.
> 
> Can you send me a sample of what breaks?  I do:

Yes.  It's something like this:

keepcaps
dropuid
drop caps
execve()

The caps that are left are like this.  (effective == inheritable) which
are a subset of permitted.

> [root@luto tmp]# cap -c = ls /home/andy
> ls: /home/andy: Permission denied
> [root@luto tmp]# echo test >foo
> [root@luto tmp]# chmod 700 foo
> [root@luto tmp]# su andy -c 'cat foo'
> cat: foo: Permission denied
> [root@luto tmp]# cap -c '= cap_dac_read_search=eip' -u andy cat foo
> test
> [root@luto tmp]# cap -c '= cap_dac_read_search=eip' -u andy bash
> [andy@luto tmp]$ whoami
> andy
> [andy@luto tmp]$ dumpcap
>          Real        Eff
> User    500         500
> Group   500         500
> 
> Caps: = cap_dac_read_search+eip
> [andy@luto tmp]$ cat foo
> test
> 
> Which looks exactly right to me.
> (cap and dumpcap live at www.stanford.edu/~luto/cap/)
> 
> >>--- linux-2.6.6-mm2/fs/exec.c~caps	2004-05-13 11:42:26.000000000 -0700
> >>+++ linux-2.6.6-mm2/fs/exec.c	2004-05-13 12:15:20.000000000 -0700
> >>@@ -882,8 +882,10 @@
> >> 
> >> 	if(!(bprm->file->f_vfsmnt->mnt_flags & MNT_NOSUID)) {
> >> 		/* Set-uid? */
> >>-		if (mode & S_ISUID)
> >>+		if (mode & S_ISUID) {
> >> 			bprm->e_uid = inode->i_uid;
> >>+			bprm->secflags |= BINPRM_SEC_SETUID;
> >>+		}
> >> 
> >> 		/* Set-gid? */
> >> 		/*
> >>@@ -891,10 +893,19 @@
> >> 		 * is a candidate for mandatory locking, not a setgid
> >> 		 * executable.
> >> 		 */
> >>-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP))
> >>+		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
> >> 			bprm->e_gid = inode->i_gid;
> >>+			bprm->secflags |= BINPRM_SEC_SETGID;
> >>+		}
> >> 	}
> >> 
> >>+	/* Pretend we have VFS capabilities */
> >>+	cap_set_full(bprm->cap_inheritable);
> > 
> > 
> > This looks sketchy.
> 
> My concept of 'inheritable' is that caps that are _not_ inheritable
> may never be gained by this task or its children.  So a process
> should normally have all caps inheritable.

This is the diff with Posix, which allows a process to inherit a
capability that it can never exercise.  However, it could pass the
capablity on to someone else who could inherit it.

<snip>
> >>@@ -36,6 +41,11 @@
> >> int cap_ptrace (struct task_struct *parent, struct task_struct *child)
> >> {
> >> 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
> >>+	/* CAP_SYS_PTRACE still can't bypass inheritable restrictions */
> >>+	if (newcaps &&
> >>+	    !cap_issubset (child->cap_inheritable, current->cap_inheritable))
> >>+		return -EPERM;
> > 
> > 
> > Why no capable() override?  In fact, is this check really necessary?
> 
> If task A has less inheritable caps than B, then A is somehow less trusted
> and has no business tracing B.

But it's not less.  It's just not a subset.  Task B could have only one
inheritable cap, while A could have all but the one cap that B has.  In
fact, that could be CAP_SYS_PTRACE.  So the threat is task A tracing B,
and using it to pass on capabilities that it wasn't allowed to pass on.
Which is what the permitted test was for before, and what CAP_SYS_PTRACE
was used to override.

> A concrete example: a system runs with very restricted inheritable caps
> on all processes except for a magic daemon.  The magic daemon holds on
> to CAP_SYS_ADMIN to umount everything at shutdown.  If the rest of the
> system gets rooted, it still shouldn't be possible to trace the daemon.
> (Yes, this is currently not workable -- I plan to add a sysctl that sets
> what inheritable caps a task must have for setuid to work.  The blanket
> requirement that _all_ must be present is to avoid bugs in which a
> setuid program assumes it will be fully privileged.)

I suppose this eliminates the usefulness of CAP_SYS_PTRACE.

> >> 	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
> >> 	    !capable (CAP_SYS_PTRACE))
> >> 		return -EPERM;
> >>@@ -76,6 +86,11 @@
> >> 		return -EPERM;
> >> 	}
> >> 
> >>+	/* verify the _new_Permitted_ is a subset of the _new_Inheritable_ */
> >>+	if (newcaps && !cap_issubset (*permitted, *inheritable)) {
> >>+		return -EPERM;
> >>+	}

This is what breaks my code.  I specifcally test permitting the parent to
grab back some caps, but never give them away.

> >> 	return 0;
> >> }
> >> 
> >>@@ -115,10 +132,11 @@
> >> 	return 0;
> >> }
> >> 
> >>-void cap_bprm_apply_creds (struct linux_binprm *bprm, int unsafe)
> >>+static void cap_bprm_apply_creds_compat (struct linux_binprm *bprm, int unsafe)
> >> {
> >>-	/* Derived from fs/exec.c:compute_creds. */
> >>+	/* This function will hopefully die in 2.7. */
> >> 	kernel_cap_t new_permitted, working;
> >>+	static int fixed_init = 0;
> >> 
> >> 	new_permitted = cap_intersect (bprm->cap_permitted, cap_bset);
> >> 	working = cap_intersect (bprm->cap_inheritable,
> >>@@ -151,6 +169,15 @@
> >> 		current->cap_permitted = new_permitted;
> >> 		current->cap_effective =
> >> 		    cap_intersect (new_permitted, bprm->cap_effective);
> >>+	} else if (!fixed_init) {
> >>+		/* This is not strictly correct, as it gives linuxrc more
> >>+		 * permissions than it used to have.  It was the only way I
> >>+		 * could think of to keep the resulting disaster contained,
> >>+		 * though.
> >>+		 */
> >>+		current->cap_effective = CAP_OLD_INIT_EFF_SET;
> >>+		current->cap_inheritable = CAP_OLD_INIT_INH_SET;
> >>+		fixed_init = 1;
> > 
> > 
> > Hrm...
> 
> Yup.  It sucks.  I didn't want to touch the system startup code, though,
> and this is the closest LSM comes.  It's too bad there's no LSM hook to do
> this right (although I suppose I could add one, but that would break
> capabilities as a module).

As a module it loosk like.

$ grep ^Cap /proc/1/status
CapInh: 00000000ffffffff
CapPrm: 00000000ffffffff
CapEff: 00000000ffffffff

> Speaking of which, this is a genuine problem if commoncap is a module
> and newcaps=0 -- this code will probably never run.  Does it matter?

Yup, that's the case I tested.  It breaks something that's working
normally now...

> [lots of patch snipped]
> 
> >>--- linux-2.6.6-mm2/include/linux/init_task.h~caps	2004-05-13 11:42:26.000000000 -0700
> >>+++ linux-2.6.6-mm2/include/linux/init_task.h	2004-05-13 11:42:51.000000000 -0700
> >>@@ -92,8 +92,8 @@
> >> 		.function	= it_real_fn				\
> >> 	},								\
> >> 	.group_info	= &init_groups,					\
> >>-	.cap_effective	= CAP_INIT_EFF_SET,				\
> >>-	.cap_inheritable = CAP_INIT_INH_SET,				\
> >>+	.cap_effective	= CAP_FULL_SET,				\
> >>+	.cap_inheritable = CAP_FULL_SET,				\
> > 
> > 
> > This was made unconditional.  And how are you convinced it's safe?
> 
> Same as above.  But even if it were really unconditional (instead
> of just sort-of unconditional), I still think it's safe, because
> (in newcaps=0 mode) only root can get CAP_SETPCAP.  Root
> could always just insert a module to enable it.  So granting it
> costs nothing.
> 
> On the other hand, safety is good, and I can't see any way in the
> old system for anything to get CAP_SETPCAP.  I'll send in a new
> patch that just disables CAP_SETPCAP when newcaps=0.

OK.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
