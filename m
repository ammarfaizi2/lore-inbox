Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262486AbVAUUZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbVAUUZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbVAUUZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:25:41 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:12361
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262486AbVAUUYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:24:21 -0500
Date: Fri, 21 Jan 2005 21:24:20 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121202420.GA11112@dualathlon.random>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121124701.GA5179@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121124701.GA5179@elte.hu>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2005 at 01:47:01PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> > > This is the seccomp patch ported to 2.6.11-rc1-bk8, that I need for
> > > Cpushare (until trusted computing will hit the hardware market). 
> > > [...]
> > 
> > why do you need any kernel code for this? This seems to be a limited
> > ptrace implementation: restricting untrusted userspace code to only be
> > able to exec read/write/sigreturn.
> > 
> > So this patch, unless i'm missing something, duplicates in essence what
> > ptrace can do [...]
> 
> there's one thing ptrace wont do: if the ptrace parent dies unexpectedly
> and the child was 'running' (there is a small window where the child

You got it, I couldn't use ptrace right now. Pavel already suggested it
and I told him the problem with the parent being killed by oom.

> might not be stopped and where this may happen) then the child can get
> runaway. While i think this is theoretical (UML doesnt suffer from this
> problem), it is simple to fix - find below a proof-of-concept patch that
> introduces PTRACE_ATTACH_JAIL - ptraced children can never escape out of
> such a jail. (barely tested - but you get the idea.)

IMHO the complexity of ptrace makes it by definition less secure than
seccomp. Seccomp is extremely simple and self contained. This is why I
still prefer seccomp to fixing ptrace w.r.t. security.

Fixing ptrace w.r.t. security-tracing it'd be still nice, but I'd prefer
not to relay on ptrace when something as simple and robust as seccomp
can be implemented instead.

However if the kerneel folks wants me to use a "fixed version of
ptrace", I could use it too (performance isn't the issue). In _theory_
you're right it'd be completely equivalent after fixing the problem with
the parent dying unexpectedly. But from my part in practice I prefer to
relay _only_ on the much simpler seccomp patch (and on trusted computing
as soon as the hardware is available).

Even trusted computing will be less secure than seccomp from the point
of view of the seller (because it's a lot more complicated than
seccomp), but unlike with ptrace, the buyer will get both privacy
guarantees and guarantees about reliably results too (only against
software attacks). Having those two guarantees for the buyer will be
fundamental, so it will worth to decrease the seller security a bit to
give these guarantees to the buyer (I'll most certainly leave an
exchange for seccomp at the same time I start the trusted computing
exchange, so if some seller doesn't trust the trusted computing code,
they can stick with the very secure seccomp approach), but right now,
seccomp seems the most secure solution from the seller standpoint, and
the buyer won't notice the difference between ptrace and seccomp.

Thanks.
