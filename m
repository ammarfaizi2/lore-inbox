Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932580AbWCOBsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932580AbWCOBsD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 20:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932582AbWCOBsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 20:48:01 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41707 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932581AbWCOBr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 20:47:59 -0500
Date: Tue, 14 Mar 2006 17:47:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Paul Mackerras <paulus@samba.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>, akpm@osdl.org,
       linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
       mingo@redhat.com, alan@redhat.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Document Linux's memory barriers [try #4] 
In-Reply-To: <3762.1142385542@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0603141734100.3618@g5.osdl.org>
References: <Pine.LNX.4.64.0603141609520.3618@g5.osdl.org> 
 <17431.14867.211423.851470@cargo.ozlabs.ibm.com> <m1veujy47r.fsf@ebiederm.dsl.xmission.com>
 <16835.1141936162@warthog.cambridge.redhat.com> <32068.1142371612@warthog.cambridge.redhat.com>
 <2301.1142380768@warthog.cambridge.redhat.com>  <3762.1142385542@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 15 Mar 2006, David Howells wrote:

> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > That's not that different from doing
> > 
> > 	ptr = read a
> > 	data = read [ptr]
> > 
> >   and speculating the result of the first read.
> 
> But that would lead to the situation I suggested (q == &b and d == a), not the
> one Paul suggested (q == &b and d == old b) because we'd speculate on the old
> value of the pointer, and so see it before it's updated, and thus still
> pointing to a.

No. If it _speculates_ the old value, and the value has actually changed 
when it checks the speculation, it would generally result in a uarch trap, 
and re-do of the instruction without speculation.

So for data speculation to make a difference in this case, it would 
speculate the _new_ value (hey, doesn't matter _why_ - it could be that a 
previous load at a previous time had gotten that value), and then load the 
old value off the new pointer, and when the speculation ends up being 
checked, it all pans out (the speculated value matched the value when "a" 
was actually later read), and you get a "non-causal" result.

Now, nobody actually does this kind of data speculation as far as I know, 
and there are perfectly valid arguments for why outside of control 
speculation nobody likely will (at least partly due to the fact that it 
would screw up existing expectations for memory ordering). It's also 
pretty damn complicated to do. But data speculation has certainly been a 
research subject, and there are papers on it.

> > Remember: the smp_wmb() only orders on the _writer_ side. Not on the 
> > reader side. The writer may send out the stuff in a particular order, but 
> > the reader might see them in a different order because _it_ might queue 
> > the bus events internally for its caches (in particular, it could end up 
> > delaying updating a particular way in the cache because it's busy).
> 
> Ummm... So whilst smp_wmb() commits writes to the mercy of the cache coherency
> system in a particular order, the updates can be passed over from one cache to
> another and committed to the reader's cache in any order, and can even be
> delayed:

Right. You should _always_ have as a rule of thinking that a "smp_wmb()" 
on one side absolutely _has_ to be paired with a "smp_rmb()" on the other 
side. If they aren't paired, something is _wrong_.

Now, the data-dependent reads is actually a very specific optimization 
where we say that on certain architectures you don't need it, so we relax 
the rule to be "the reader has to have a smp_rmb() _or_ a 
smp_read_barrier_depends(), where the latter is only valid if the address 
of the dependent read depends directly on the first one".

But the read barrier always has to be there, even though it can be of the 
"weaker" type.

And note that the address really has to have a _data_ dependency, not a 
control dependency. If the address is dependent on the first read, but the 
dependency is through a conditional rather than actually reading the 
address itself, then it's a control dependency, and existing CPU's already 
short-circuit those through branch prediction.

			Linus
