Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVAMEah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVAMEah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 23:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVAMEah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 23:30:37 -0500
Received: from main.gmane.org ([80.91.229.2]:21155 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261426AbVAMEa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 23:30:27 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paolo =?utf-8?b?XCdCbGFpc29yYmxhZGVcJw==?= Giarrusso 
	<blaisorblade@yahoo.it>
Subject: Re: [RFC] add struct =?utf-8?b?aHdfaW50ZXJydXB0X3R5cGUtPnJlbGVhc2U=?=
Date: Thu, 13 Jan 2005 04:22:24 +0000 (UTC)
Message-ID: <loom.20050113T043021-673@post.gmane.org>
References: <20041020023156.GA8597@taniwha.stupidest.org> <20041020130715.GA20287@infradead.org> <20041020023156.GA8597@taniwha.stupidest.org> <20041021022630.GA320@taniwha.stupidest.org> <20041021072338.GA925@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 151.97.230.32 (Opera/7.54 (X11; Linux i686; U)  [en])
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch <at> infradead.org> writes:

> 
> On Wed, Oct 20, 2004 at 07:26:30PM -0700, Chris Wedgwood wrote:
> > On Tue, Oct 19, 2004 at 07:31:56PM -0700, Chris Wedgwood wrote:
> > 
> > > +++ b/kernel/irq/manage.c	2004-10-19 17:47:40 -07:00
> > >  <at>  <at>  -260,6 +260,7  <at>  <at> 
> > >  				else
> > >  					desc->handler->disable(irq);
> > >  			}
> >                        ^^^
> > > +			platform_free_irq_notify(irq, dev_id);
> > >  			spin_unlock_irqrestore(&desc->lock,flags);
> > >  			unregister_handler_proc(irq, action);
> > >  
> > 
> > On Wed, Oct 20, 2004 at 02:07:15PM +0100, Christoph Hellwig wrote:
> > 
> > > This looks rather bogus to me.  What prevents UML from doing it's
> > > work at the struct hw_interrupt_type level?
> > 
> > the ^^^ marked part reads something like if (!desc->action) { ... }
> > presumably meaning the shutdown/disable is only done when the very
> > last user of an interrupt source is removed
> > 
> > UML needs to be notified when *any* user is removed so either need
> > some way to tell the generic code this or perhaps we could introduce
> > another op to hw_interrupt_type along the lines of ->release like
> > this:

> Care to explain why it needs that?  How exactly is UML using hardirqs,
> they seems to fit very badly into the concept of a usermode kernel if
> you ask me.

> Maybe UML would be better off to not use hardirqs at all,
> ala s390.
I don't know about s390, however we have another developer in UML which has 
experience with Linux on that platform... I'll ask him.

However, the main idea is if an hardirq is raised, something has happened on a 
certain file descriptor, associated with the IRQ; the definition of "something 
has happened" is the one which holds for poll(), which is used to implement this 
(see arch/um/kernel/irq_user.c:activate_fd() ).

So, it is clear the need we have?

One real example is for /dev/tty1, when it's emulated by an xterm: we use an IRQ 
to wait for when we receive on a socket the fd of the pipe which connects us 
with the xterm. (The actual datas are not passed through the IRQ).

However, any plan about removing the hardirqs from UML is low-priority for me... 
we have the main need to get the code stable, afterwards to add new missing 
important features, and at the end to rewrite such things... at least until when 
we see the need for such a rewrite.

But the idea is not bad, I think (I am a newcomer, so I don't know why and when 
it was born, for this you could ask to Jeff Dike, if you want).

