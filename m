Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262156AbVGZVv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVGZVv0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbVGZVsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:48:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262156AbVGZVrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:47:20 -0400
Date: Tue, 26 Jul 2005 14:47:05 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.13-rc3a] i386: inline restore_fpu
In-Reply-To: <200507261727_MC3-1-A5A1-F8AB@compuserve.com>
Message-ID: <Pine.LNX.4.58.0507261438540.19309@g5.osdl.org>
References: <200507261727_MC3-1-A5A1-F8AB@compuserve.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 26 Jul 2005, Chuck Ebbert wrote:
> 
>  Since fxsave leaves the FPU state intact, there ought to be a better way to do
> this but it gets tricky.  Maybe using the TSC to put a timestamp in every thread
> save area?

We used to have totally lazy FP saving, and not toucht he FP state at 
_all_ in the scheduler except to just set the TS bit.

It worked wonderfully well on UP, but getting it working on SMP is a major
pain, since the lazy state you want to switch back into might be cached on
some other CPU's registers, so we never did it on SMP. Eventually it got
too painful to maintain two totally different logical code-paths between
UP and SMP, and some bug or other ended up resulting in the current "lazy
on a time slice level" thing which works well in SMP too.

Also, a lot of the cost is really the save, and before SSE2 the fnsave
would clear the FPU state, so you couldn't just do a save and try to elide 
just the restore in the lazy case. In SSE2 (with fxsave) we _could_ try to 
do that, but the thing is, I doubt it really helps.

First off, 99% of all programs don't hit the nasty case at all, and for
something broken like volanomark that _does_ hit it, I bet that there i
smore than one thread using the FP, so you can't just cache the FP state
in the CPU _anyway_.

So we could enhance the current state by having a "nonlazy" mode like in
the example patch, except we'd have to make it a dynamic flag. Which could
either be done by explicitly marking binaries we want to be non-lazy, or
by just dynamically noticing that the rate of FP restores is very high.

Does anybody really care about volanomark? Quite frankly, I think you'd
see a _lot_ more performance improvement if you could instead teach the
Java stuff not to use FP all the time, so it feels a bit like papering
over the _real_ bug if we'd try to optimize this abnormal and silly case
in the kernel.

		Linus
