Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUIJQHq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUIJQHq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUIJQD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:03:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267551AbUIJQBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:01:47 -0400
Date: Fri, 10 Sep 2004 12:01:40 -0400
From: Alan Cox <alan@redhat.com>
To: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: tty ldisc locking/ordering
Message-ID: <20040910160140.GA24179@devserv.devel.redhat.com>
References: <20040910153810.GA7431@devserv.devel.redhat.com> <20040910165520.A25852@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040910165520.A25852@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 04:55:20PM +0100, Christoph Hellwig wrote:
> > +return -EBUSY if the ldisc is currently in use. Since the ldisc referencing
> > +code manages the module counts this should not usually be a concern.
> 
> So what is a module supposed to do if this fails?  It's usually called from
> module_exit so there's no way to recover.

Thats an interesting question. For the modular case we manage owner counts
so I think it cannot fail for modules using it at that point. If you want to
rescind a line discipline at some other time however then that isnt true.

> > +Three calls are now provided
> > +
> > +	ldisc = tty_ldisc_ref(tty);
> > +
> > +takes a handle to the line discipline in the tty and returns it. If no ldisc
> > +is currently attached or the ldisc is being closed and re-opened at this
> > +point then NULL is returned. While this handle is held the ldisc will not
> > +change or go away.
> > +
> > +	tty_ldisc_deref(ldisc)
> 
> We tend to call these _get/_put just about everywhere else in the kernel,
> maybe some consisteny is a good idea?

ldisc_get and ldisc_put are used for taking references to each ldisc class
ldisc_ref/deref to each instance of the ldisc class. The two are not the
same thing in the tty layer. The count on the class tells you when you can
unload the module, the count on the driver is users of that instance.

When I named them it seemed that the get/put methods belonged with the case
that behaves most like the other _get/_put cases

Thoughts - I've not found a simple answer for this one ?

Alan

