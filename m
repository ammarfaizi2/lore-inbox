Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264295AbUENF7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264295AbUENF7J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 01:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUENF7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 01:59:09 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:18910 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S264295AbUENF6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 01:58:30 -0400
Message-ID: <40A46001.9030004@myrealbox.com>
Date: Thu, 13 May 2004 22:58:25 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <40A42E8E.4030603@myrealbox.com> <20040513214843.N21045@build.pdx.osdl.net>
In-Reply-To: <20040513214843.N21045@build.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Pardon my gross butchery and reordering.]

Compatibility (i.e. newcaps=0):

Chris Wright wrote:
 > * Andy Lutomirski (luto@myrealbox.com) wrote:
 >
 >>Chris Wright wrote:
 >>
 >>
 >>>* Andy Lutomirski (luto@myrealbox.com) wrote:

 >>>I think it still needs more work.  Default behavoiur is changed, like
 >>>Inheritble is full rather than clear, setpcap is enabled, etc.  ...
 >>
 >>In cap_bprm_apply_creds_compat:
 >>
 >>+	} else if (!fixed_init) {
 >>+		/* This is not strictly correct, as it gives linuxrc more
 >>+		 * permissions than it used to have.  It was the only way I
 >>+		 * could think of to keep the resulting disaster contained,
 >>+		 * though.
 >>+		 */
 >>+		current->cap_effective = CAP_OLD_INIT_EFF_SET;
 >>+		current->cap_inheritable = CAP_OLD_INIT_INH_SET;
 >>+		fixed_init = 1;
 >>
 >>So that it gets changed back.  Otherwise linuxrc ran without permissions
 >>and my drives never got mounted.  Yah, it's ugly -- I'm open to
 >>suggestions to avoid this.
 >
 >
 > I tested as a module, and this doesn't run AFAICS

OK -- I give in.  I'll redo it as a kernel (non-module) boot parameter.
And touch some more files that have no business being capability-aware
while I'm at it :(


The inheritable mask:

 >>>Also, it breaks my tests which try to drop privs and keep caps across
 >>>execve() which is really the only issue we're trying to solve ATM.
 >>
 >>Can you send me a sample of what breaks?  I do:
 >
 >
 > Yes.  It's something like this:
 >
 > keepcaps
 > dropuid
 > drop caps
 > execve()
 >
 > The caps that are left are like this.  (effective == inheritable) which
 > are a subset of permitted.
 >

Is (eff == inh) what happens or what should happen?  If the former, then
my patch is broken.  If the latter, either I'm confused, or see below.

 >>>why do you change from Posix the way exec() updates capabilities?  Sure,
 >>>there is no filesystem bits present, so this changes the calculation,
 >>>but I'm not convinced it's as secure this way.  At least with newcaps=0.
 >>
 >>I'm not convinced that Posix's version makes any sense.  Also, there are
 >>apparently a number of drafts around which disagree on what the right
 >>rules are.  (My copy, for example, matches the old rules exactly, but
 >>the old rules caused the sendmail problem.)  And, under Posix, what does
 >>the inheritable mask mean, anyway?
 >>
 >>Also, I don't find the posix rules to be useful (why is there an
 >>inheritable mask if all it does is to cause caps to be dropped on
 >>exec, when the user could just manually drop them?).
 >
 >
 > Not sure if it's defensible, but it allows passing on an inheritable
 > capability through an intermediate process that simply can't inherit
 > that capability.  This is not unlike requiring an unprivileged process
 > to ask a privileged process for it to do something on it's behalf.
 > Certainly it's implicit that you trust the privileged process.
 >

[and:]
 >>>>+	/* Pretend we have VFS capabilities */
 >>>>+	cap_set_full(bprm->cap_inheritable);
 >>>
 >>>
 >>>This looks sketchy.
 >>
 >>My concept of 'inheritable' is that caps that are _not_ inheritable
 >>may never be gained by this task or its children.  So a process
 >>should normally have all caps inheritable.
 >
 >
 > This is the diff with Posix, which allows a process to inherit a
 > capability that it can never exercise.  However, it could pass the
 > capablity on to someone else who could inherit it.
 >
 > <snip>
 >

So here's where I think we disagree:

Posix (as interpreted by Linux 2.4/2.6) says:
pP' = (fP & cap_bset) | (fI & pI)

So (assuming that set_security did the "obvious" (but dangerous) thing):

pP := "task may enable and use these capabilities"
pE := "task may use these capabilities _now_"
pI := "task may gain these on exec from fI"

fP := "this program gets these caps (module cap_bset)"
fI := "this program gets these caps if pI says so"

Which screams "overcomplicated."  I imagine that the use is for a
trusted daemon to run an untrusted helper (with pI>0) which then
calls back into trusted land and gets its caps back.  This is
possibly convenient, but it seems to break (where break = scare me)
when there are more than one such system on a given box.  Then one's
untrusted program (with fI>0) can call the other's trusted fI>0
helper.  I suppose the point is that a random user's program (with fI==0)
can't try to exploit anything, but, for this to be at all secure, both
fI>0 programs need to be secure against attack from the other (unrelated)
system, should it be compromised.  Which means it might as well have set
fP>0 and been done with it (I don't believe in security by inconvenience
of exploit).

I see no particular invariants here, except for pE <= pP.

IRIX (thanks Valdis) says:

pI' = pI & fI
pP' = fP | (pI' & fP)

Which I interpret as

pP := "task may enable and use these capabilities"
pE := "task may use these capabilities _now_"
pI := ~"task _loses_ these on exec"

fP := "this program gets these caps"
fI := "this program may keep these caps"

This seems to want pP <= pI as an invariant.

This is what I always thought Linux capabilities meant to be.  They
don't make my brain hurt.

But I also think they're overengineered.  Instead of:

drop_caps_from_inheritable()
exec()

a program could do:

drop_caps_from_permitted()
exec()

And I can't imagine what use fI != ~0 has, since it's trivially
accomplished by a wrapper.  It is also trivially bypassed by
loading the program manually (with ld.so).

So, in my patch, I decided steal the inheritable mask to mean this:

pI := "this process may gain these caps"
fI := "this is an upper bound on pI"

In other words, if a process is extra-untrusted (e.g. it's a daemon
that never needs a certain capability and has no business trying
to gain it), it can drop it from pI.  Then it cannot try to abuse
programs with pP>0.  The setuid override is just added paranoia.
Another benefit is that it allows a securelevel-like scheme, where
even root isn't quite trusted.

I suppose it might be inappropriate to steal this field like this,
given that IRIX already has a (somewhat reasonable) use for it. I
have no problem implementing IRIX-style capabilities and (if there
is enough interest) adding a _fourth_ process field pM (process
maximum capabilities) that does what my pI does.

As for the fE mask, I just don't see the point, although I _really_
don't like the way it's described in the IRIX manpage.

IRIX has pE = pP & fE.  This breaks Posix non-capabilities
compatibility for a program that's uid==0, euid!=0.  It should
have pE==0 and pP>0.  But it calls exec() and gets pE>0.  This
is bad.

Assuming there's something else there to fix that case,
then I still don't see the point.  If a program is capability-
aware, it can set its pE however it likes.  If not, then it probably
expects pE==pP.  I guess there could be a trusted but dumb program
that runs a trusted, cap-aware helper that needs capabilities.
Then the admin sets fE==0 on the dump program and everything works.
Seems a bit contrived, though.

On the other hand, I'm not wedded to my model of pE.  It'll be harder
to get IRIX's right for uid!=euid.

CAP_SYS_PTRACE:

 >>>>@@ -36,6 +41,11 @@
 >>>>int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 >>>>{
 >>>>	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
 >>>>+	/* CAP_SYS_PTRACE still can't bypass inheritable restrictions */
 >>>>+	if (newcaps &&
 >>>>+	    !cap_issubset (child->cap_inheritable, current->cap_inheritable))
 >>>>+		return -EPERM;
 >>>
 >>>
 >>>Why no capable() override?  In fact, is this check really necessary?
 >>
 >>If task A has less inheritable caps than B, then A is somehow less trusted
 >>and has no business tracing B.
 >
 >
 > But it's not less.  It's just not a subset.  Task B could have only one
 > inheritable cap, while A could have all but the one cap that B has.  In
 > fact, that could be CAP_SYS_PTRACE.  So the threat is task A tracing B,
 > and using it to pass on capabilities that it wasn't allowed to pass on.
 > Which is what the permitted test was for before, and what CAP_SYS_PTRACE
 > was used to override.
 >
 >
 >>A concrete example: a system runs with very restricted inheritable caps
 >>on all processes except for a magic daemon.  The magic daemon holds on
 >>to CAP_SYS_ADMIN to umount everything at shutdown.  If the rest of the
 >>system gets rooted, it still shouldn't be possible to trace the daemon.
 >>(Yes, this is currently not workable -- I plan to add a sysctl that sets
 >>what inheritable caps a task must have for setuid to work.  The blanket
 >>requirement that _all_ must be present is to avoid bugs in which a
 >>setuid program assumes it will be fully privileged.)
 >
 >
 > I suppose this eliminates the usefulness of CAP_SYS_PTRACE.
 >
 >

It lets one uid/gid trace another.  If CAP_SYS_PTRACE allowed a process
to arbitrarity steal another's capabilities, then the process with
CAP_SYS_PTRACE might as well have been given those capabilities.  That is,
this should IMHO be disallowed

drop_all_but_CAP_SYS_PTRACE()
exec(slightly trusted debugger process)
ptrace(1) <--- but it was supposed to be "slightly trusted"!



So:

Should I redo this to keep IRIX's meaning of fI, should I keep mine,
or should I do something else.  Chris -- in your examples, you seem
to have some idea of what should be happening.  What do you think?

--Andy
