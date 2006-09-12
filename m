Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751398AbWILVXp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbWILVXp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 17:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWILVXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 17:23:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:15048 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751398AbWILVXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 17:23:44 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <8A2F9DF4-1A17-454C-8243-8F86CF04F763@kernel.crashing.org>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
	 <1157966269.3879.23.camel@localhost.localdomain>
	 <1157969261.23085.108.camel@localhost.localdomain>
	 <m1pse17hzi.fsf@ebiederm.dsl.xmission.com>
	 <1158040605.15465.70.camel@localhost.localdomain>
	 <m1d5a17g5u.fsf@ebiederm.dsl.xmission.com>
	 <1158045200.15465.94.camel@localhost.localdomain>
	 <8A2F9DF4-1A17-454C-8243-8F86CF04F763@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 07:22:05 +1000
Message-Id: <1158096125.3337.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Or you do the sane thing and just not allow two threads of execution
> access to the same I/O device at the same time.

Why ? Some devices are designed to be able to handle that...

> Now compare this with the similar scenario for "normal" MMIO, where
> we do store;sync (or sync;store or even sync;store;sync) for every
> writel() -- exactly the same problem.

What problem ? "Normal" MMIO doesn't get combined, thus there is no
problem. Of course there is no guarantee of ordering of the stores from
the 2 CPUs unless there is a spinlock etc etc... but we are talking
about a case where that is acceptable here. Howver, combining is not.

> Better lock at a higher level than just per instruction.
> 
> Some devices that want to support multiple clients at the same time
> have multiple identical "register files", one for each client, to
> prevent this and other problems (and it's useful anyway).

Yes, they do, and what happen if those register "files" happen to be
consecutive in the address space and the CPU suddenly combines a store
to the last register of one "file" and an unrelated store from another
thread to the first register of the other ?

This is a very specific problem that has nothing to do with your "grand
general case" which means that at least on Cell, you cannot use explicit
barriers to guarantee the absence of write combining. That's as simple
as that. All I need to figure out now is if that problem is specific to
one CPU implementation or more general, in which case, we'll have to
figure out some way to provide an interface.

> > Anyway, let's not pollute this discussion with that too much now :)
> 
> Au contraire -- if you're proposing to hugely invasively change some
> core interface, and add millions of little barriers(*), you better
> explain how this is going to help us tackle the problems (like WC) that
> we are starting to see already, and that will be a big deal in the
> near future.

No, this is totally irrelevant. I'm proposing a simple change (nothing
invasive there) to the MMIO accessors of weakly ordered platforms only,
to make them guarantee ordering like x86 etc... and I'm proposing the
-addition- (which is not something I would cause invasive) of -one-
class of partially relaxed accessors and the -few- (damn, there are only
4 of them) barriers that precisely match the semantics that drivers
need. Oh, and make sure those semantics are well defined or they are
useless.

This has strictly nothing to do with WC and mixing things up will only
confuse the discussion and guarantee that we'll never get anything done.

<snip useless digression>

Ben.


