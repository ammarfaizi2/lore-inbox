Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTI3WOY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261777AbTI3WOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:14:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5063 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261782AbTI3WON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:14:13 -0400
Date: Tue, 30 Sep 2003 23:14:11 +0100
From: Matthew Wilcox <willy@debian.org>
To: Matthew Wilcox <willy@debian.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] expand_resource
Message-ID: <20030930221411.GF24824@parcelfarce.linux.theplanet.co.uk>
References: <20030930210410.GD24824@parcelfarce.linux.theplanet.co.uk> <20030930222708.A10154@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930222708.A10154@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 10:27:08PM +0100, Russell King wrote:
> On Tue, Sep 30, 2003 at 10:04:10PM +0100, Matthew Wilcox wrote:
> > +/*
> > + * Expand an existing resource by size amount.
> > + */
> > +int expand_resource(struct resource *res, unsigned long size,
> > +			   unsigned long align)
> > +{
> 
> Could we have the kerneldoc stuff added to this function?

Certainly.  Rather than answering your question below directly,
let's see if the kerneldoc answers it (and if not, then the kerneldoc
needs to be made clearer).

/**
 * expand_resource - Expand an existing resource
 * @res: Resource already linked into the resource tree.
 * @size: Amount of additional space requested below @res.
 * @align: Required alignment of new space.
 *
 * This function is intended to be called when we need more space
 * below an existing resource than currently exists.  The @size and
 * @align parameters describe the requirements of the child resource,
 * not the parent.  Note that this call does not attempt to expand
 * the parent of @res as that might require reprogramming devices.
 * If a caller would like this behaviour, they must handle the recursion.
 */

> My main
> question though is - what is the intended purpose of "align" ?  As
> it is implemented, it seems to have a weird behaviour:
> 
> - if we expand the "end" of the resource, we round it towards an
>   address which is a multiple of align, but "start" may not be
>   a multiple of align.
> - if we expand "start", we round it down towards a multiple of
>   align.  However, "end" may not be a multiple of align.
> 
> This may actually be of use to PCMCIA IO space handling - we only
> have two windows, but we may need to expand them if we have a multi-
> function card if we have more than 2 areas to map.  In this case,
> we'd need to know whether "start" was expanded or "end" was expanded
> since we can't change the use of the already-allocated resource.

Heh, this sounds almost identical to the PARISC problem.  I knew other
users would come out of the woodwork if I sent the patch ;-)  We also
need to know whether the start or end was changed to reprogram the
parent device -- see the caller in drivers/parisc/ccio-dma.c:

        if (expand_resource(parent, size, align) != 0) {
                printk(KERN_ERR "Unable to expand %s window by 0x%lx\n",
                       parent->name, size);
                return;
        }
        __raw_writel(((parent->start)>>16) | 0xffff0000,
                     (unsigned long)&(ioc->ioc_hpa->io_io_low));
        __raw_writel(((parent->end)>>16) | 0xffff0000,
                     (unsigned long)&(ioc->ioc_hpa->io_io_high));

> It may make sense to do something more generic, like:
> 
> int adjust_resource(struct resource *res, unsigned long start,
> 		    unsigned long end);
> 
> so that the caller knows what he's requesting and knows whether that
> change succeeded or failed.  However, it is something I'd need to
> look deeper into when I have more time available to look at such
> stuff, so please don't take the above as a well thought-out solution.

I don't like that.  It puts more work into the caller, but doesn't
seem to simplify the _resource function.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
