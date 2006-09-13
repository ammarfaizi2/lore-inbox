Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030478AbWIMBe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030478AbWIMBe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 21:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030480AbWIMBe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 21:34:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:53707 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1030478AbWIMBe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 21:34:58 -0400
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
In-Reply-To: <3F3A70F8-3DEE-4B1D-9C49-7A2EBC50156C@kernel.crashing.org>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
	 <1157966269.3879.23.camel@localhost.localdomain>
	 <1157969261.23085.108.camel@localhost.localdomain>
	 <m1pse17hzi.fsf@ebiederm.dsl.xmission.com>
	 <1158040605.15465.70.camel@localhost.localdomain>
	 <m1d5a17g5u.fsf@ebiederm.dsl.xmission.com>
	 <1158045200.15465.94.camel@localhost.localdomain>
	 <8A2F9DF4-1A17-454C-8243-8F86CF04F763@kernel.crashing.org>
	 <1158096125.3337.14.camel@localhost.localdomain>
	 <3F3A70F8-3DEE-4B1D-9C49-7A2EBC50156C@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 11:34:13 +1000
Message-Id: <1158111253.3337.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please explain what drivers will need changes because of this.  Not just
> the few you really care about, but _all_ that could be plugged into  
> PowerPC
> machines' PCI busses, and might need changes because of changing the
> ordering semantics of readX()/writeX() from the supposed standard Linux
> semantics (i.e., the x86 semantics).

They won't. They will still work, and in some (many ?) case better due
to the removal of a potential bug since lots of driver don't have a
barrier where they should be with relaxed semantics. So the net effect
is positive here.

Now, it also means that we -can- start improving drivers we care about
to use the relaxed semantics and benefit from there. And since the
semantics are well defined, all archs with some sort of relaxed ordering
will be able to benefit in a way or another.

In addition, it will allow us to get a small optimisation on PowerPC vs.
the current situation by slightly relaxing wmb() which currently has to
do a full sync because it might be used to order memory vs. MMIO, which
it will no longer do (it will go back to a pure memory store barrier).

Anyway, Paul has a patch we are testing that makes our writel/readl's
synchronous (by moving the sync to before writel, adding an eieio before
readl, and doing the percpu trick so spin_unlock magically does a sync
when a writel occurred). With that, we'll get full correctness with no
more sync's in writel than we had before. We are running some benchs
here now to see what kind of performance impact it has overall, and if
we are happy, that can make it into 2.6.18 and close the problem of
drivers assuming ordered MMIO vs. memory at least.

Then, in a -separate- step, we can provide a set of relaxed accessors
that will allow for additional performance improvements on the hot path
of selected drivers.

I'm tired of arguing over and over again the same thing here anyway,
I'll post a new version of the document including some of the feedback
we got already and will submit it for inclusion along with a
__writel/__readl implementation for powerpc (and a generic one that
defaults to readl/writel) for the 2.6.19 timeframe.

We'll see from there if there are more constructive comments.

Ben.



