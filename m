Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWIKBOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWIKBOX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 21:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWIKBOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 21:14:23 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:26078 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S1750713AbWIKBOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 21:14:22 -0400
In-Reply-To: <200609101734.06839.jbarnes@virtuousgeek.org>
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <0F623199-9152-46B3-8CC3-6FFCDD8AF705@kernel.crashing.org> <1157933531.31071.274.camel@localhost.localdomain> <200609101734.06839.jbarnes@virtuousgeek.org>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2486D031-097B-45C6-AC47-D8745844C5A3@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Mon, 11 Sep 2006 03:13:20 +0200
To: Jesse Barnes <jbarnes@virtuousgeek.org>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, write combining is a good point.  After all these years we  
> *still*
> don't have a good in-kernel interface for changing memory mapped
> attributes, so adding a 'flags' argument to ioremap might be a good
> idea (cached, uncached, write combine are the three variants I can
> think of off the top of my head).

But what does "write-combine" mean?  There are many different
implementations of basically this same idea, and implementing
just the lowest common denominator of this will hardly get us
out of the mess we are in already.

>   - existing readX/writeX routines are defined to be strongly ordered
>   - new MMIO accessors are added with weak semantics (not sure I like
>     the __ naming though, driver authors will have to continually  
> refer
>     to documentation to figure out what they mean) along with new
>     barrier macros to synchronize things appropriately

What exactly will "weak" mean?  If it's weak enough to please all
architectures and busses, it'll be so weak that you'll need 2**N
(with a big N) different barriers.

>   - flags argument to ioremap

ioremap is a bad name anyway, if we'll change the API, change the
name as well (and it's a bad idea to keep the same name but make it
mean something different, anyway).

> Oh, and all MMIO accessors are *documented* with strongly defined
> semantics. :)

Not sure what this means?  Document them in all-caps?  :-)

> If we go this route though, can I request that we don't introduce any
> performance regressions in drivers currently using mmiowb()?  I.e.
> they'll be converted over to the new accessor routines when they  
> become
> available along with the new barrier macros?

In my proposal at least, those drivers won't lose any performance
(except for a conditional on their I/O cookie, which is a trivial
performance loss compared to the cost of the I/O /an sich/); they
won't need any changes either, except for some renaming.  Drivers
_not_ using it might get a performance loss though, because they
will be forced to run with every-I/O-ordered semantics; they will
suddenly start to work *correctly* though.


Segher

