Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWIKXBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWIKXBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWIKXBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:01:37 -0400
Received: from gate.crashing.org ([63.228.1.57]:49588 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932321AbWIKXBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:01:36 -0400
Subject: Re: [RFC] MMIO accessors & barriers documentation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <200609111506.01389.jbarnes@virtuousgeek.org>
References: <1157947414.31071.386.camel@localhost.localdomain>
	 <200609111139.35344.jbarnes@virtuousgeek.org>
	 <1158011129.3879.69.camel@localhost.localdomain>
	 <200609111506.01389.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 12 Sep 2006 09:01:01 +1000
Message-Id: <1158015661.3879.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think that's a separate issue?  As Jeff points out, those macros are 
> intended to provide memory vs. I/O ordering, but isn't PPC the only platform 
> that will reorder accesses so aggressively and independently?  I don't think 
> ia64 for example will reorder them separately, so a regular memory barrier 
> *should* be enough to ensure ordering in both domains.

Well, I don't know, that's what I'm asking since the comment in the
driver specifically mentions IA64 :)

> > Hence the question: do we provide -fully- ordered accessors in class 1,
> > or do we provide -mostly- ordered accessors, ordered in all means except
> > rule #4 vs locks. ia64 is afaik by far the platform taking the biggest
> > hit if you have to provide #4, so I'm interesting in your point of view
> > here.
> 
> Either way is fine with me as long as we have a way to get at the fast and 
> loose stuff (and required barriers of course) in a portable way.  And that we 
> don't regress the existing users of mmiowb().

Well, existing users of mmiowb() will regress in performances if we
decide that class 1 (ordered) accessors do imply rule #4 (ordering with
locks) since they'll end up doing redundant mmiowb's ;) but then,
they'll be affected anyway to to the sheer amount of mmiowb's (one per
IO) unless you implement the trick I described, which would bring down
the cost to nothing except maybe the test in spin_unlock (which I still
need to measure on PowerPC).

> > We don't need counters, just a flag. We did a test implementation, seems
> > to work. We also clear the flag in spin_lock. That means that MMIOs
> > issued before a lock aren't ordered vs. the locked section. But because
> > of rule #1, they should be ordered vs. other MMIOs inside the locked
> > section and thus implicitely get ordered anyway.
> 
> Oh right, a flag would be enough.  Is it good enough for -mm yet?  Might be 
> fun to run on an Altix machine with a bunch of supported devices (not that I 
> work with them anymore...).

The PowerPC patch is probably good enough for 2.6.18 in fact :) I'll let
Paulus post what he has. It's fairly ppc specific in the actual
implementation though.

> > > For ia64 in particular it doesn't matter, though there was speculation
> > > several years that it might be necessary.  No actual examples stepped
> > > forward though, so the current implementation doesn't take an argument.
> >
> > Ok. My question is wether it would improve the implementation to take
> > it. If we define a new macro with a new name, we can do it....
> 
> Right, but unless there's a real need at this point, we probably shouldn't 
> bother.  Let the poor sucker with the future machine needing the device 
> argument do the work. :)

Ok :)

Ben.


