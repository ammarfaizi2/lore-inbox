Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271733AbTGRIAX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 04:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271609AbTGRIAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 04:00:23 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:5902 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271733AbTGRIAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 04:00:19 -0400
Date: Fri, 18 Jul 2003 09:15:12 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Martin Schlemmer <azarah@gentoo.org>,
       Ro0tSiEgE LKML <lkml@ro0tsiege.org>, KML <linux-kernel@vger.kernel.org>
Subject: Re: devfsd
Message-ID: <20030718091512.B16388@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Oliver Neukum <oliver@neukum.org>,
	Martin Schlemmer <azarah@gentoo.org>,
	Ro0tSiEgE LKML <lkml@ro0tsiege.org>,
	KML <linux-kernel@vger.kernel.org>
References: <20030715214610.GA21238@core.citynetwireless.net> <1058507844.13515.1579.camel@workshop.saharacpt.lan> <20030718084417.B14336@infradead.org> <200307180952.33868.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307180952.33868.oliver@neukum.org>; from oliver@neukum.org on Fri, Jul 18, 2003 at 09:52:33AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 09:52:33AM +0200, Oliver Neukum wrote:
> > > Any way, if you are serious, what make you consider it broken (no,
> > > not talking about personal preferences/phobias 8)
> > 
> > There's unsolvable design issues in the way devfsd communication works
> > (with the last two patches the holes are closed as much as possible)
> 
> Could you elaborate?

lookup is called with i_sem on parent, devfs calls up to devfsd in
lookup which might again do operation that would block on the same
i_sem.  To avoid the deadlock we have to drop i_sem somewhere which
always introduces races.  In 2.4 and earlier 2.5 theses races where
huge and easily exploitable at least with the O(1) scheduler.  In
current 2.5 they're much smaller so you usually don't trip them but
they;re not going away as long as we keep the stateful devfsd design.

> > issues so people should switch to that ASAP.  That doesn't mean we
> > can simply rip it out because people started to rely on the non-standard
> > device names, but it's use is pretty much discouraged in 2.6.
> 
> How does udev avoid these complications?

udev is a hotplug upcall, not a stateful deamon.

> If udev doesn't have those issues, why can't they be fixed for devfsd?

Not without changing it to a stateless design, i.e. recreating something
resembling udev..

