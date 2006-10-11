Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161281AbWJKXrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbWJKXrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161284AbWJKXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:47:09 -0400
Received: from mx1.suse.de ([195.135.220.2]:18081 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161281AbWJKXrG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:47:06 -0400
From: Neil Brown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 12 Oct 2006 09:46:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17709.33386.884615.679131@cse.unsw.edu.au>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       rusty@rustcorp.com.au
Subject: Re: _cpu_down deadlock [was Re: 2.6.19-rc1-mm1]
In-Reply-To: message from Andrew Morton on Wednesday October 11
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100610p6eb65726of92b85f7d49e80bb@mail.gmail.com>
	<6bffcb0e0610100704m32ccc6bakb446671f04b04c2b@mail.gmail.com>
	<17708.33450.608010.113968@cse.unsw.edu.au>
	<6bffcb0e0610110348i1d3fc15qa0c57a6586aca3e@mail.gmail.com>
	<1160565786.3000.369.camel@laptopd505.fenrus.org>
	<17708.60613.451322.747200@cse.unsw.edu.au>
	<20061011093920.32fc2d07.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 11, akpm@osdl.org wrote:
> > 
> > So A waits on B and C, C waits on B, B waits on A.
> > Deadlock.
> 
> Except the entire operation is serialised by the the two top-level callers
> (cpu_up() and cpu_down()) taking mutex_lock(&cpu_add_remove_lock).  Can
> lockdep be taught about that?

So you are saying that even though we have locking sequences
  A -> B  and B -> A,
that cannot - in this case - cause a deadlock as both sequences only
ever happen under a third exclusive lock C,
So when lockdep records a lock-dependency A -> B, it should also
record a list of locks that are *always* held when that dependency
occurs.
Then, when it finds a new dependency and does loop detection, it
should exclude from the path any dependency which is always under a
lock that some other dependency in the path is always under.
Also, loop checking as to happen both when a new dependency is found,
and when a lock is removed from the set of locks that protect the
dependency.

Recording stack traces might be interesting as you potentially need to
record a trace for ever minimal set of locks that the dependency is
created under.

So the ball is back in Ingo's court ?

Though it is odd that the warning doesn't trigger every time....


> 
> > Who do we blame this on?  Are you still the cpu-hot-plug guy Rusty?
> 
> It's fun blaming Rusty for stuff, but he can dodge this one with
> more-than-usual ease, I'm afraid.

In that case,  I was never dreaming of blaming him, only letting him
know that there is a lock-dep warning in code that he might be seen as
responsible for - just in case anyone does blame him.
Yes.  That's what I was doing.  Definitely.

NeilBrown
