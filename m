Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWIJSD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWIJSD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 14:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbWIJSD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 14:03:59 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:6315
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932347AbWIJSD6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 14:03:58 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 20:02:43 +0200
User-Agent: KMail/1.9.4
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com> <200609101935.09993.mb@bu3sch.de> <Pine.LNX.4.64.0609101045280.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609101045280.27779@g5.osdl.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, segher@kernel.crashing.org, davem@davemloft.net,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609102002.43889.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 19:49, Linus Torvalds wrote:
> 
> On Sun, 10 Sep 2006, Michael Buesch wrote:
> > > 
> > > That's what IRIX had.  It would let us get rid of mmiowb and avoid doing 
> > > a full sync in writeX, so may be the best option.
> > 
> > Last time I suggested that, people did not want it.
> 
> I would personally _much_ rather have a separate mmiowb() and a regular 
> spinlock, than add a magic new spinlock.

Yeah, as far as I remember it was you who rejected it. ;)
But I second your statement because of the practical issues below.

> Of course, mmiowb() itself is not a great name, and we could/should 
> probably rename it to make it more obvious what the hell it is.
> 
> > There is one little problem in practice with something
> > like spin_unlock_io().
> > 
> > spin_lock_io(&lock);
> > foovalue = new_foovalue;
> > if (device_is_fooing)
> > 	writel(foovalue, REGISTER);
> > spin_unlock_io(&lock);
> > 
> > That would be an unneccessary sync in case device is not fooing.
> > In contrast to the explicit version:
> > 
> > spin_lock(&lock);
> > foovalue = new_foovalue;
> > if (device_is_fooing) {
> > 	writel(foovalue, REGISTER);
> > 	mmiowb();
> > }
> > spin_unlock(&lock);
> 
> I think this is even more important when the actual IO is done somewhere 
> totally different from the locking. It's really confusing if you have a 
> "spin_unlock_io()" just because some routine you called wanted it.
> 
> But more importantly, I don't want to have "spin_unlock_io[_xyzzy]()", 
> where "xyzzy()" is all the irq/irqrestore/bh variations. It's just not 
> worth it. We already have enough variations on spinlocks, but at least 
> right now they are all in the "same category", ie it's all about what the 
> context of the _locking_ is, and at least the lock matches the unlock, and 
> there are no separate rules.
> 
> 			Linus
> 

-- 
Greetings Michael.
