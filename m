Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266327AbUFZRSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266327AbUFZRSl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jun 2004 13:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266314AbUFZRSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jun 2004 13:18:41 -0400
Received: from stat1.steeleye.com ([65.114.3.130]:3217 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266327AbUFZRSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jun 2004 13:18:23 -0400
Subject: Re: [PATCH] Fix the cpumask rewrite
From: James Bottomley <James.Bottomley@steeleye.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Paul Jackson <pj@sgi.com>,
       PARISC list <parisc-linux@lists.parisc-linux.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
References: <1088266111.1943.15.camel@mulgrave> 
	<Pine.LNX.4.58.0406260924570.14449@ppc970.osdl.org>
	<1088268405.1942.25.camel@mulgrave> 
	<Pine.LNX.4.58.0406260948070.14449@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 26 Jun 2004 12:18:16 -0500
Message-Id: <1088270298.1942.40.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-06-26 at 11:54, Linus Torvalds wrote:
> On Sat, 26 Jun 2004, James Bottomley wrote:
> >
> > On Sat, 2004-06-26 at 11:32, Linus Torvalds wrote:
> > > Why not? The thing is, the bitmap operators are supposed to work on 
> > > volatile data, ie people are literally using them for things like
> > > 
> > > 	while (test_bit(TASKLET_STATE_SCHED, &t->state));

I tried this on PA.  Our gcc definitely generates the correct code, even
without the volatile...

By the way, I had to try with a genuine volatile since
tasklet_struct.state isn't actually volatile in linux/interrupt.h

> > > and the thing is supposed to work.
> > 
> > Well, I agree it's supposed to work, what I don't agree about is that
> > generic code gets to designate critical data as volatile.
> 
> I agree in the sense that I don't think the _data_ should be volatile.
> 
> But I think the functions to access various pieces of data should be able 
> to take volatiles without warning.
> 
> See the difference? Same way "memcpy()" takes a "const" argument for the 
> source. That doesn't mean that the source _has_ to be const, it just means 
> that it won't complain if it is.
> 
> And the same is true of "volatile" for the bitop functions. They are 
> volatile not because they require the data to be volatile, but because 
> they have at least traditionally been used for various cases, _including_ 
> volatile.

But in the current kernel, there are no bitops on volatile data in the
parisc tree.  This cpumask is the first such one that we've come
across...

> Now, we could say that we don't do that any more, and decide that the 
> regular bitop functions really cannot be used on volatile stuff. But 
> that's a BIG decision. And it's certainly not a decision that parisc 
> users should make.

But that's my point.  Currently there is no volatile pointer bitops (and
I have bitten the heads off a few people who tried to introduce some),
so there's no existing case to justify being backward compatible with.

> Well, at least judging by your "test_bit()", the function literally is 
> _not_ coded to work with volatile data.

test_bit's a special case.  The lock is to prevent data corruption, not
racing between test_bit and set_bit.

> If the above loop had been a real case, gcc on parisc would have optimized 
> it away, and done the wrong thing.

That's not what our gcc seems to do (both 3.0.4 and 3.3.4)

James


