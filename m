Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUENRqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUENRqn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 13:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUENRqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 13:46:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:61374 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261939AbUENRpj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 13:45:39 -0400
Date: Fri, 14 May 2004 10:45:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Chris Wright <chrisw@osdl.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH] capabilites, take 2
Message-ID: <20040514104534.Q21045@build.pdx.osdl.net>
References: <200405131308.40477.luto@myrealbox.com> <20040513182010.L21045@build.pdx.osdl.net> <40A42E8E.4030603@myrealbox.com> <20040513214843.N21045@build.pdx.osdl.net> <40A46001.9030004@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <40A46001.9030004@myrealbox.com>; from luto@myrealbox.com on Thu, May 13, 2004 at 10:58:25PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@myrealbox.com) wrote:
>  > I tested as a module, and this doesn't run AFAICS
> 
> OK -- I give in.  I'll redo it as a kernel (non-module) boot parameter.
> And touch some more files that have no business being capability-aware
> while I'm at it :(

I'm not yet convinced this is necessary to get the behaviour we'd like,
which is simply execve() doesn't wipe caps categorically.

> The inheritable mask:
> > > Can you send me a sample of what breaks?
> > Yes.  It's something like this:
> >
> > keepcaps
> > dropuid
> > drop caps
> > execve()
> >
> > The caps that are left are like this.  (effective == inheritable) which
> > are a subset of permitted.
> 
> Is (eff == inh) what happens or what should happen?  If the former, then
> my patch is broken.  If the latter, either I'm confused, or see below.

eff == inh is what capset is doing, with intention.

> > > My concept of 'inheritable' is that caps that are _not_ inheritable
> > > may never be gained by this task or its children.  So a process
> > > should normally have all caps inheritable.
> >
> > This is the diff with Posix, which allows a process to inherit a
> > capability that it can never exercise.  However, it could pass the
> > capablity on to someone else who could inherit it.
> 
> So here's where I think we disagree:
> 
> Posix (as interpreted by Linux 2.4/2.6) says:
> pP' = (fP & cap_bset) | (fI & pI)
> 
> So (assuming that set_security did the "obvious" (but dangerous) thing):
> 
> pP := "task may enable and use these capabilities"
> pE := "task may use these capabilities _now_"
> pI := "task may gain these on exec from fI"
> 
> fP := "this program gets these caps (module cap_bset)"
> fI := "this program gets these caps if pI says so"
> 
> Which screams "overcomplicated."  I imagine that the use is for a
> trusted daemon to run an untrusted helper (with pI>0) which then
> calls back into trusted land and gets its caps back.  This is
> possibly convenient, but it seems to break (where break = scare me)
> when there are more than one such system on a given box.  Then one's
> untrusted program (with fI>0) can call the other's trusted fI>0
> helper.  I suppose the point is that a random user's program (with fI==0)
> can't try to exploit anything, but, for this to be at all secure, both
> fI>0 programs need to be secure against attack from the other (unrelated)
> system, should it be compromised.  Which means it might as well have set
> fP>0 and been done with it (I don't believe in security by inconvenience
> of exploit).

I agree it's overcomplicated.  Much of the complication is added in the
fs bits where you now have 6 fields to care about per exec.  And you've
got to make sure the fs bits acutally make sense in all cases and
provide useful security.  This is precisely why they haven't been
implemented yet.  They don't mix nicely with the world people are used
to with setuid, etc, and they add many extra knobs which means it's
difficult to admin.

> I see no particular invariants here, except for pE <= pP.
> 
> IRIX (thanks Valdis) says:
> 
> pI' = pI & fI
> pP' = fP | (pI' & fP)
> 
> Which I interpret as
> 
> pP := "task may enable and use these capabilities"
> pE := "task may use these capabilities _now_"
> pI := ~"task _loses_ these on exec"
> 
> fP := "this program gets these caps"
> fI := "this program may keep these caps"
> 
> This seems to want pP <= pI as an invariant.
> 
> This is what I always thought Linux capabilities meant to be.  They
> don't make my brain hurt.
> 
> But I also think they're overengineered.  Instead of:
> 
> drop_caps_from_inheritable()
> exec()
> 
> a program could do:
> 
> drop_caps_from_permitted()
> exec()

Yes.  Although I suppose the first case allows for simple damage control
when needing some privs locally, and calling into libraries which may
generate a fork/exec.

> And I can't imagine what use fI != ~0 has, since it's trivially
> accomplished by a wrapper.  It is also trivially bypassed by
> loading the program manually (with ld.so).

Not so sure (now that we're dreaming of fs caps), ld.so could have fI == 0.
IOW, similar to ld.so being worthless to gain setuid bit.

> So, in my patch, I decided steal the inheritable mask to mean this:
> 
> pI := "this process may gain these caps"
> fI := "this is an upper bound on pI"
> 
> In other words, if a process is extra-untrusted (e.g. it's a daemon
> that never needs a certain capability and has no business trying
> to gain it), it can drop it from pI.  Then it cannot try to abuse
> programs with pP>0.  The setuid override is just added paranoia.
> Another benefit is that it allows a securelevel-like scheme, where
> even root isn't quite trusted.
> 
> I suppose it might be inappropriate to steal this field like this,
> given that IRIX already has a (somewhat reasonable) use for it. I
> have no problem implementing IRIX-style capabilities and (if there
> is enough interest) adding a _fourth_ process field pM (process
> maximum capabilities) that does what my pI does.
> 
> As for the fE mask, I just don't see the point, although I _really_
> don't like the way it's described in the IRIX manpage.
> 
> IRIX has pE = pP & fE.  This breaks Posix non-capabilities
> compatibility for a program that's uid==0, euid!=0.  It should
> have pE==0 and pP>0.  But it calls exec() and gets pE>0.  This
> is bad.
> 
> Assuming there's something else there to fix that case,
> then I still don't see the point.  If a program is capability-
> aware, it can set its pE however it likes.  If not, then it probably
> expects pE==pP.  I guess there could be a trusted but dumb program
> that runs a trusted, cap-aware helper that needs capabilities.
> Then the admin sets fE==0 on the dump program and everything works.
> Seems a bit contrived, though.
> 
> On the other hand, I'm not wedded to my model of pE.  It'll be harder
> to get IRIX's right for uid!=euid.
> 
> CAP_SYS_PTRACE:
> 
> >>>>@@ -36,6 +41,11 @@
> >>>>int cap_ptrace (struct task_struct *parent, struct task_struct *child)
> >>>>{
> >>>>	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
> >>>>+	/* CAP_SYS_PTRACE still can't bypass inheritable restrictions */
> >>>>+	if (newcaps &&
> >>>>+	    !cap_issubset (child->cap_inheritable, current->cap_inheritable))
> >>>>+		return -EPERM;
> >>>
> >>>
> >>>Why no capable() override?  In fact, is this check really necessary?
> >>
> >>If task A has less inheritable caps than B, then A is somehow less trusted
> >>and has no business tracing B.
> >
> >
> > But it's not less.  It's just not a subset.  Task B could have only one
> > inheritable cap, while A could have all but the one cap that B has.  In
> > fact, that could be CAP_SYS_PTRACE.  So the threat is task A tracing B,
> > and using it to pass on capabilities that it wasn't allowed to pass on.
> > Which is what the permitted test was for before, and what CAP_SYS_PTRACE
> > was used to override.
> >
> >
> >>A concrete example: a system runs with very restricted inheritable caps
> >>on all processes except for a magic daemon.  The magic daemon holds on
> >>to CAP_SYS_ADMIN to umount everything at shutdown.  If the rest of the
> >>system gets rooted, it still shouldn't be possible to trace the daemon.
> >>(Yes, this is currently not workable -- I plan to add a sysctl that sets
> >>what inheritable caps a task must have for setuid to work.  The blanket
> >>requirement that _all_ must be present is to avoid bugs in which a
> >>setuid program assumes it will be fully privileged.)
> >
> > I suppose this eliminates the usefulness of CAP_SYS_PTRACE.
> 
> It lets one uid/gid trace another.  If CAP_SYS_PTRACE allowed a process
> to arbitrarity steal another's capabilities, then the process with
> CAP_SYS_PTRACE might as well have been given those capabilities.  That is,
> this should IMHO be disallowed

Yeah, this is just another example of capabilities being easily used
to leverage greater caps.  Others are:  CAP_SETUID, CAP_DAC_OVERRIDE,
CAP_SYS_MODULE, CAP_SYS_RAWIO...

> drop_all_but_CAP_SYS_PTRACE()
> exec(slightly trusted debugger process)
> ptrace(1) <--- but it was supposed to be "slightly trusted"!
> 
> So:
> 
> Should I redo this to keep IRIX's meaning of fI, should I keep mine,
> or should I do something else.  Chris -- in your examples, you seem
> to have some idea of what should be happening.  What do you think?

I'd like to see smallest possible change to allow exeve() to be more
fine grained rather than 0 or ~0 caps depending on setuid-root.  I think
we can work with existing meaning of Inh, Eff, Perm and find a way to
smarten up the transition rules slightly.  My patch is trivial, although
there's probably some cases where it's still unsafe.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
