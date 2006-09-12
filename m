Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWILHN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWILHN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWILHN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:13:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:4026 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751393AbWILHN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:13:59 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <m1d5a17g5u.fsf@ebiederm.dsl.xmission.com>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <1157965071.23085.84.camel@localhost.localdomain>
	 <1157966269.3879.23.camel@localhost.localdomain>
	 <1157969261.23085.108.camel@localhost.localdomain>
	 <m1pse17hzi.fsf@ebiederm.dsl.xmission.com>
	 <1158040605.15465.70.camel@localhost.localdomain>
	 <m1d5a17g5u.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 17:13:20 +1000
Message-Id: <1158045200.15465.94.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> ioremap_wc is actually the easy half.  I have an old patch that handles
> that.  The trick is to make certain multiple people don't map the same
> thing with different attributes.  Unfortunately I haven't had time to
> work through that one yet.

Actually, that's interesting because I need the exactly oposite on
PowerPC I think.... That is people will -need- to do both a wc and a
non-wc mapping if they want to be able to issue stores that are
guaranteed not to be combined.

The problem I've seen is that at least one processor (the Cell) and
maybe more seem to be combining between threads on the same CPU (unless
the stores are issues to a guarded mapping which prevents combining
completely, that is the sort of mapping we currently do with ioremap).

That means that it's impossible to prevent combining with explicit
barriers. For example:

Thread 0          Thread 1
store to A        store to A+1
barrier           barrier
  \                / 
   \             /
    \          /
   Store unit might sees:
      store to A
      store to A+1
      barrier
      barrier

That is the stores aren't tagged with their source thread and thus the
non cacheable store unit will not prevent combining between them.

Again, it might just be a Cell CPU bug in which case we may have to just
disable use of WC on that processor, period. But it might be a more
generic problem too, we need to investigate.

If the problem ends up being widespread, the only ways I see to prevent
the combining from happening are to do a dual mapping as I explained
earlier, or maybe to have drivers always do the stores that must not be
combine as part of spinlocks, with appropriate use of
io_to_lock_barrier() (mmiowb()).

Anyway, let's not pollute this discussion with that too much now :)

Ben.


