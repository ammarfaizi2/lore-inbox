Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWIJRgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWIJRgR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 13:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWIJRgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 13:36:17 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:49822
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932328AbWIJRgQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 13:36:16 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Sun, 10 Sep 2006 19:35:09 +0200
User-Agent: KMail/1.9.4
References: <17666.8433.533221.866510@cargo.ozlabs.ibm.com> <1157814591.6877.29.camel@localhost.localdomain> <200609101019.11608.jbarnes@virtuousgeek.org>
In-Reply-To: <200609101019.11608.jbarnes@virtuousgeek.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org,
       davem@davemloft.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609101935.09993.mb@bu3sch.de>
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 September 2006 19:19, Jesse Barnes wrote:
> On Saturday, September 09, 2006 8:09 am, Alan Cox wrote:
> > Ar Sad, 2006-09-09 am 17:23 +1000, ysgrifennodd Benjamin 
> Herrenschmidt:
> > > The problem is that very few people have any clear idea of what
> > > mmiowb is :) In fact, what you described is not the definition of
> > > mmiowb according to Jesse
> >
> > Some of us talked a little about this at Linux Kongress and one
> > suggestion so people did understand it was
> >
> > 	spin_lock_io();
> > 	spin_unlock_io();
> >
> > so that it can be expressed not as a weird barrier op but as part of
> > the locking.
> 
> That's what IRIX had.  It would let us get rid of mmiowb and avoid doing 
> a full sync in writeX, so may be the best option.

Last time I suggested that, people did not want it.
Probably about 9 months ago. Don't remember exactly.
We came to the decision that if a driver depends on some weak
ordering, it should either directly use mmiowb() or have its
own locking wrapper which wraps spin_unlock() and mmiowb().

There is one little problem in practice with something
like spin_unlock_io().

spin_lock_io(&lock);
foovalue = new_foovalue;
if (device_is_fooing)
	writel(foovalue, REGISTER);
spin_unlock_io(&lock);

That would be an unneccessary sync in case device is not fooing.
In contrast to the explicit version:

spin_lock(&lock);
foovalue = new_foovalue;
if (device_is_fooing) {
	writel(foovalue, REGISTER);
	mmiowb();
}
spin_unlock(&lock);

-- 
Greetings Michael.
