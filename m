Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWCDVkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWCDVkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 16:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWCDVkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 16:40:42 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:61707 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751444AbWCDVkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 16:40:41 -0500
Date: Sat, 4 Mar 2006 22:40:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: bug-make@gnu.org, LKML <linux-kernel@vger.kernel.org>, psmith@gnu.org
Cc: kbuild-devel@lists.sourceforge.net, Art Haas <ahaas@airmail.net>
Subject: Re: kbuild: Problem with latest GNU make rc
Message-ID: <20060304214026.GB1539@mars.ravnborg.org>
References: <17413.49617.923704.35763@lemming.engeast.baynetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17413.49617.923704.35763@lemming.engeast.baynetworks.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[linux-kernel added. Please keep both bug-make and linux-kernel]

On Wed, Mar 01, 2006 at 10:46:25AM -0500, psmith@gnu.org wrote:
Content-Description: message body text
> Hi all.  I've set Reply-To: to the bug-make@gnu.org list; I'm hoping we
> can keep the discussion there since I don't subscribe to kbuild-devel.
> 
> 
> I'm working on getting the next release of GNU make, 3.81, out the door
> (amazing!)  The weekend before last I released 3.81rc1 for people to
> test.  A day or two ago, Art Haas <ahaas@airmail.net> emailed me that he
> was having problems using kbuild with this version.  The previous
> version, 3.81beta4, works fine.
> 
> The symptoms are that much of the kernel was rebuilding over gain
> every time he ran make, even after he'd just done a top-down build.
> 
> I pulled the 2.6.15 kernel and sure enough, I see the same behavior.  I
> delved into the kbuild infrastructure and I found the problem.
> 
> 
> The kbuild system uses a trick to force rebuilds if the command line
> changes for a given target (normally make only rebuilds if the target is
> out of date--some versions of make, like Solaris make, have a
> .KEEP_STATE feature but GNU make does not support this).  Here's a
> stripped-down example of what kbuild does:
> 
> .PHONY: FORCE
> 
> %.o : %.c FORCE
>         $(if_changed_rule ...)
> 
> if_changed_rule = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
>             @set -e; \
>             $(rule_$(1)))
> 
> The FORCE prerequisite causes ALL .o targets that match this rule to be
> considered by make to be out of date (because FORCE is always
> out-of-date and it's a prerequisite of the .o).
> 
> The trick is in the if_changed_rule macro: it tests whether any
> prerequisites have changed ($? is the changed prerequisites; it'll be
> empty if none have changed) and whether the command lines have changed
> (the call to arg-check).  If those values are true (non-empty) it
> expands to the rule.  Otherwise it expands to nothing.
> 
> GNU make takes several shortcuts to provide efficiency in places where
> it doesn't matter, and so if it sees an empty command it doesn't try to
> run a shell.  In this way, kbuild gets the benefit of checking the
> command line for every target without paying a price for useless shells
> being invoked during the build.
> 
> 
> However, this trick as implemented is accidentally relying on what may
> be a misbehavior on GNU make's part: one that was changed in the latest
> rc release.  This is causing rebuilds to happen.
> 
> In previous versions of GNU make, prerequisites that didn't exist were
> not included in the $? variable.  In the new version that's been changed
> (fixed?) so that all out-of-date prerequisites are included in the $?
> variable, even if they don't exist.
> 
> 
> The old behavior allowed this rule to work, because even though FORCE
> was out-of-date and would normally always appear in $?, it didn't exist
> as a file and this exception caused it to be left out.  So, the value of
> $? was empty in the old version if the only prerequisite that was
> considered out-of-date was the non-existent file FORCE.
> 
> In the new version of GNU make, the value of $? is FORCE in that
> situation, so the test in if_changed_rule is always true and it always
> evaluates to the compile line, and rebuilds.
> 
> 
> Neither the GNU make manual nor the POSIX definition of make gives us
> clear direction as to the correct behavior in this particular situation.
> SuS says:
> 
>   $?
>       The $? macro shall evaluate to the list of prerequisites that are
>       newer than the current target. It shall be evaluated for both target
>       and inference rules.
> 
> The GNU make manual says:
> 
>   $?
>       The names of all the prerequisites that are newer than the target,
>       with spaces between them.
> 
> So... is a non-existent file "newer than the target"?  This specific
> situation is not addressed.  However, other versions of make (SysV make
> for example) interpret a non-existent file as out-of-date and DO include
> it in $?.  Given the meaning of "newer than the current target" to make
> (that it causes the target to be rebuilt) and the implied meaning of $?
> (a list of the prerequisites that cause the target to be rebuilt), I
> feel that the new behavior is correct and the old behavior is incorrect.
> 
> 
> So.  If the change is correct, how should we proceed?  Obviously it's
> not hard to change kbuild to fix the majority of the problem; replace
> the above macro with something like:
> 
>   if_changed_rule = $(if $(strip $(filter-out FORCE,$?) $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
>             @set -e; \
>             $(rule_$(1)))
> 
> and all will be well.  There are other, similar macros that need this
> change as well.

> And, there are other places where this $(filter-out
> FORCE,...) is already done, so it's apparently come up before.
Current use of $(filter-out FORCE, ...) is always with $^ where FORCE
correctly are included.

> I attach a patch here which makes this fix in kbuild.
> 
> The above solution is backward-compatible (will work with older versions
> of GNU make), so that's nice.  But of course, current releases will still
> be broken unless patched.  Is it OK to say, if you upgrade GNU make you
> have to patch kbuild, unless you want to rebuild everything every time?

This will affect all users that does:
- use an upgraded make
- build kernels without proposed fix

I foresee a lot of mails to lkml the next year or more with this issue
if kept. People do build older kernels and continue to do so the next
long time. Especially the embedded market seem keen to stay at 2.4
(wonder why), and as such we will see many systems that keep older
kernel src but never make behaviour.

Suggestion:
We are now warned about an incompatibility in kbuild and we
will fix this asap. But that you postpone this particular behaviour
change until next make release. Maybe you add in this change as the
first thing after the stable relase so all bleeding edge make users see
it and can report issues.

And I make sure that 2.6.17 are clean in this respect - maybe with some
help from you.

Sound reasonable?


> Ouch.
> 
> 
> There is another slight problem: some targets have extra PHONY
> prerequisites as well.  For example, here:
> 
>   .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
>           $(call if_changed_dep,as_o_S)
> 
> from the root Makefile.  Now, "scripts" here is PHONY, so it will always
> appear in $? in the new version of make as well.  Unless we want to add
> all those PHONY target to the $(filter-out ...) test in the if_* macros
> we're going to get some rebuild: this causes the final link to be done
> again even if nothing has changed.  That's probably not a big deal since
> most people WILL change something before they build.  Nevertheless, it's
> unpleasant.  I don't know of any way, given the current features of GNU
> make, to solve this problem generically (like, "remove all PHONY targets
> from this list of targets").

It is not acceptable that the kernel links each time we do a make.
We keep track of a version number, we do partly jobs as root etc.
So any updates on an otherwise build tree is a bug - and will be
reported and has to get fixed.

Now we use if_changed only 5 places in top-level Makefile so that is
doable.
But the troublesome part is in the arch kbuild files were we do
some tricks here and there. Here it will take some effort to understand
that a rebuild happens only because a target happens to be .PHONY:
It does not follow the principle of least suprise.


> 
> 
> Well, I'll stop typing now :-).
> 
> Please send me your thoughts.
> 
> 

Can you please Sign-off you patch as described in
Documentation/SubmittingPatches chapter 11)

	Sam

Content-Description: kbuild.patch
> --- scripts/Kbuild.include-dist	2006-01-02 22:21:10.000000000 -0500
> +++ scripts/Kbuild.include	2006-03-01 10:42:30.398316278 -0500
> @@ -73,8 +73,8 @@
>  # function to only execute the passed command if necessary
>  # >'< substitution is for echo to work, >$< substitution to preserve $ when reloading .cmd file
>  # note: when using inline perl scripts [perl -e '...$$t=1;...'] in $(cmd_xxx) double $$ your perl vars
> -# 
> -if_changed = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
> +#
> +if_changed = $(if $(strip $(filter-out FORCE,$?) $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ), \
>  	@set -e; \
>  	$(echo-cmd) \
>  	$(cmd_$(1)); \
> @@ -82,7 +82,7 @@
>  
>  # execute the command and also postprocess generated .d dependencies
>  # file
> -if_changed_dep = $(if $(strip $? $(filter-out FORCE $(wildcard $^),$^)\
> +if_changed_dep = $(if $(strip $(filter-out FORCE,$?) $(filter-out FORCE $(wildcard $^),$^)\
>  	$(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),                  \
>  	@set -e; \
>  	$(echo-cmd) \
> @@ -94,6 +94,6 @@
>  # Usage: $(call if_changed_rule,foo)
>  # will check if $(cmd_foo) changed, or any of the prequisites changed,
>  # and if so will execute $(rule_foo)
> -if_changed_rule = $(if $(strip $? $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
> +if_changed_rule = $(if $(strip $(filter-out FORCE,$?) $(call arg-check, $(cmd_$(1)), $(cmd_$@)) ),\
>  			@set -e; \
>  			$(rule_$(1)))

