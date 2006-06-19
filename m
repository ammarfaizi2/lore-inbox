Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWFSKff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWFSKff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 06:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWFSKff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 06:35:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19432 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932354AbWFSKfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 06:35:34 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "Charles P. Wright" <cwright@cs.sunysb.edu>,
       Renzo Davoli <renzo@cs.unibo.it>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>
Subject: Re: [RFC PATCH 0/4] utrace: new modular infrastructure for
  user debug/tracing
In-Reply-To: Chuck Ebbert's message of  Thursday, 15 June 2006 18:58:16 -0400 <200606151900_MC3-1-C293-BD30@compuserve.com>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20060619103528.6B77D180049@magilla.sf.frob.com>
Date: Mon, 19 Jun 2006 03:35:28 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> At least three different sets of people want to extend the syscall
> tracing.  Jeff Dike posted a patch that lets you supply a bitmask of
> syscalls to trace.  Renzo Davoli posted one that lets you decide, after
> trapping entrance to a syscall, whether to skip the trap that would
> normally be done on exit from the same call.  Charles P. Wright also
> had a similar patch.  I think this needs to be done at the utrace
> level -- a tracing engine couldn't add that on its own (could it?)

Indeed I do think a tracing engine can and should do those things itself.
An engine's report_syscall callback can look in a bitmap that it maintains
itself and decide to return quickly without doing anything.  That callback
is only a function call or two away from where a core-level check in a
bitmap would be.  It's my expectation that the overhead of an engine
getting a callback and bailing out quickly will not be troublesome.  (I'd
guess the biggest slowdown might be just from taking the slow path in the
assembly necessary to do any kind of syscall tracing.  To optimally avoid
that would require checking the bitmap in the assembly code, and I tend to
doubt that optimization would be worth its maintenance burden.)  If the
overhead inherent in engines doing their own filtering proves burdensome,
then we could add new calls to the utrace core for setting certain special
kinds of automatic filters like a syscall bitmap.  But that is an
optimization for later; if it proves desireable, it fits cleanly as a
compatible extension of the current interface.

The latter feature, of deciding on a syscall-entry event whether ot not to
see the next syscall-exit event, is already easy to implement in an engine
and about as optimally as any specialized utrace core addition might be.
An engine's report_syscall_entry callback can store a flag that is checked
by its report_syscall_exit callback, and that is pretty simple.  If you
don't want to use a flag bit of your own somewhere (engine->data or a data
structure whose pointer you store there), there is a second way that is
pretty straightforward as well.  Each syscall-exit event is preceded by a
syscall-entry event (except when you've just attached to a threa already in
the middle of a syscall).  So your report_syscall_entry callback call
utrace_set_flags every time to change the set of events of interest to
include or exclude the syscall-exit event, knowing each new setting will
only affect the immediate corresponding syscall exit and you'll be called
again to decide afresh for the next syscall.

> Renzo Davoli also posted a patch to allow "batching" of ptrace requests
> and Systemptap really needs this, too.  AFAICT this can be done by writing
> a custom engine.

That's the idea.  Batching is one of several obvious parts of a decent
user-level interface (in contrast to the whole ptrace model).  The purpose
of the utrace layer is to make it tractable to go and write these things,
and to experiment with many of them, small and large.

> And BTW patches 1 and 2 never made it to the list.  

The patches are rather large and might have been discarded by the mailing
list software because of that.  Having noticed the 40k limit on mailed
patches in Documentation/SubmittingPatches, perhaps I shouldn't be posting
them directly.

> The ones on your server (http://redhat.com/~roland/utrace/) don't apply
> cleanly due to whitespace damage but that can be fixed by stripping
> trailing whitespace from the kernel files patch(1) complains about.

Sorry about that.  (You can also apply them fine with patch -l, which is
why I managed not to notice the problem myself the first time around.)
I've fixed the way I generate the patches, and I've verified that the new
patches now my site do apply to 2.6.17.


Thanks,
Roland
