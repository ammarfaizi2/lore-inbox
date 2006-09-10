Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWIJRuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWIJRuJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932336AbWIJRuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:50:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932335AbWIJRuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:50:07 -0400
Date: Sun, 10 Sep 2006 10:49:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Michael Buesch <mb@bu3sch.de>
cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, segher@kernel.crashing.org, davem@davemloft.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
In-Reply-To: <200609101935.09993.mb@bu3sch.de>
Message-ID: <Pine.LNX.4.64.0609101045280.27779@g5.osdl.org>
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com>
 <1157814591.6877.29.camel@localhost.localdomain> <200609101019.11608.jbarnes@virtuousgeek.org>
 <200609101935.09993.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Sep 2006, Michael Buesch wrote:
> > 
> > That's what IRIX had.  It would let us get rid of mmiowb and avoid doing 
> > a full sync in writeX, so may be the best option.
> 
> Last time I suggested that, people did not want it.

I would personally _much_ rather have a separate mmiowb() and a regular 
spinlock, than add a magic new spinlock.

Of course, mmiowb() itself is not a great name, and we could/should 
probably rename it to make it more obvious what the hell it is.

> There is one little problem in practice with something
> like spin_unlock_io().
> 
> spin_lock_io(&lock);
> foovalue = new_foovalue;
> if (device_is_fooing)
> 	writel(foovalue, REGISTER);
> spin_unlock_io(&lock);
> 
> That would be an unneccessary sync in case device is not fooing.
> In contrast to the explicit version:
> 
> spin_lock(&lock);
> foovalue = new_foovalue;
> if (device_is_fooing) {
> 	writel(foovalue, REGISTER);
> 	mmiowb();
> }
> spin_unlock(&lock);

I think this is even more important when the actual IO is done somewhere 
totally different from the locking. It's really confusing if you have a 
"spin_unlock_io()" just because some routine you called wanted it.

But more importantly, I don't want to have "spin_unlock_io[_xyzzy]()", 
where "xyzzy()" is all the irq/irqrestore/bh variations. It's just not 
worth it. We already have enough variations on spinlocks, but at least 
right now they are all in the "same category", ie it's all about what the 
context of the _locking_ is, and at least the lock matches the unlock, and 
there are no separate rules.

			Linus
