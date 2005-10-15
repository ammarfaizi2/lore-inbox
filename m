Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbVJOXNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbVJOXNc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 19:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbVJOXNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 19:13:32 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36013
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751249AbVJOXNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 19:13:31 -0400
Date: Sat, 15 Oct 2005 16:13:17 -0700 (PDT)
Message-Id: <20051015.161317.116279401.davem@davemloft.net>
To: benh@kernel.crashing.org
Cc: andrea@suse.de, herbert@gondor.apana.org.au, nickpiggin@yahoo.com.au,
       hugh@veritas.com, paulus@samba.org, anton@samba.org, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Possible memory ordering bug in page reclaim?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <1129414591.7620.13.camel@gaston>
References: <E1EQkpc-0007FI-00@gondolin.me.apana.org.au>
	<20051015180018.GN18159@opteron.random>
	<1129414591.7620.13.camel@gaston>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 16 Oct 2005 08:16:30 +1000

> > Even a write barrier is required on the left side, the read barrier on
> > the right side is useless if there is no write barrier on the left side.
> > 
> > Note that the barrier in atomic_add_negative is useless here because it
> > happens way too late, _after_ the count is decremented (not _before_)
> > so the decreased count could be already visible to the other cpu.
> 
> Not on ppc64.

Or sparc64, or ppc, or ... any platform that adheres to the
rules specified in Documentation/atomic_ops.txt :-)

One really needs the barriers both before and after the atomic
operation when you return a value, because this is the only way to get
sane semantics for dropping the final reference to some object.  When
one does:

	if (atomic_dec_and_test(&obj->count))
		__free_stuff(obj);

All other modifications to object state before the atomic
decrement must reach global visibility _first_, and then
the atomic decrement itself must be strongly ordered wrt.
future memory operations.

That's why it is documented that the memory barriers both before and
after the atomic operation are required when the operation returns a
result value of some kind.

There is a lot of code in the kernel that depends upon this.
