Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbTJAOZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 10:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTJAOZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 10:25:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9105 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262279AbTJAOZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 10:25:54 -0400
Date: Wed, 1 Oct 2003 15:25:53 +0100
From: Matthew Wilcox <willy@debian.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] expand_resource
Message-ID: <20031001142553.GN24824@parcelfarce.linux.theplanet.co.uk>
References: <20030930210410.GD24824@parcelfarce.linux.theplanet.co.uk> <20030930222708.A10154@flint.arm.linux.org.uk> <20030930221411.GF24824@parcelfarce.linux.theplanet.co.uk> <20030930233352.C10154@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930233352.C10154@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 11:33:52PM +0100, Russell King wrote:
> On Tue, Sep 30, 2003 at 11:14:11PM +0100, Matthew Wilcox wrote:
> > /**
> >  * expand_resource - Expand an existing resource
> >  * @res: Resource already linked into the resource tree.
> >  * @size: Amount of additional space requested below @res.
> >  * @align: Required alignment of new space.
> >  *
> >  * This function is intended to be called when we need more space
> >  * below an existing resource than currently exists.  The @size and
> >  * @align parameters describe the requirements of the child resource,
> >  * not the parent.  Note that this call does not attempt to expand
> >  * the parent of @res as that might require reprogramming devices.
> >  * If a caller would like this behaviour, they must handle the recursion.
> >  */
> > 
> > > My main
> > > question though is - what is the intended purpose of "align" ?  As
> > > it is implemented, it seems to have a weird behaviour:
> > > 
> > > - if we expand the "end" of the resource, we round it towards an
> > >   address which is a multiple of align, but "start" may not be
> > >   a multiple of align.
> > > - if we expand "start", we round it down towards a multiple of
> > >   align.  However, "end" may not be a multiple of align.
> 
> Ok, your description covers the latter case, and seems quite reasonable
> given the arguments.  The former case seems to be a little less clear
> though.

I don't understand what you mean here ... Expanding start is clear,
but expanding end isn't clear?

> The problem with expand_resource as it currently stands is that it can
> expand either at the start or the end of the resource, and we don't know
> which it is going to do.  PCMCIA is one example where this information
> matters - not only do we need to know the right IO range for each IO
> window, but we also need to know the IO address for each device.
> 
> This means that if we were to expand these window resources, we must
> know where the new space was allocated.
> 
> I think we can both agree that saving the old resources start, end
> and then comparing it after expand_resource() is fairly disgusting.

Certainly.  For CCIO, we just program both high and low registers.
I guess we could do something like returning the value that changed
and in the caller:

	int new = expand_resource(res, size, align);

	if (new < 0) {
		return new;
	} else if (new == res->start) {
		/* program start */
	} else {
		/* program end */
	}

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
