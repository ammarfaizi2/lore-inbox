Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbTI3WeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 18:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbTI3WeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 18:34:10 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22035 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261781AbTI3Wd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 18:33:57 -0400
Date: Tue, 30 Sep 2003 23:33:52 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] expand_resource
Message-ID: <20030930233352.C10154@flint.arm.linux.org.uk>
Mail-Followup-To: Matthew Wilcox <willy@debian.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <20030930210410.GD24824@parcelfarce.linux.theplanet.co.uk> <20030930222708.A10154@flint.arm.linux.org.uk> <20030930221411.GF24824@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030930221411.GF24824@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Tue, Sep 30, 2003 at 11:14:11PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 11:14:11PM +0100, Matthew Wilcox wrote:
> Certainly.  Rather than answering your question below directly,
> let's see if the kerneldoc answers it (and if not, then the kerneldoc
> needs to be made clearer).
> 
> /**
>  * expand_resource - Expand an existing resource
>  * @res: Resource already linked into the resource tree.
>  * @size: Amount of additional space requested below @res.
>  * @align: Required alignment of new space.
>  *
>  * This function is intended to be called when we need more space
>  * below an existing resource than currently exists.  The @size and
>  * @align parameters describe the requirements of the child resource,
>  * not the parent.  Note that this call does not attempt to expand
>  * the parent of @res as that might require reprogramming devices.
>  * If a caller would like this behaviour, they must handle the recursion.
>  */
> 
> > My main
> > question though is - what is the intended purpose of "align" ?  As
> > it is implemented, it seems to have a weird behaviour:
> > 
> > - if we expand the "end" of the resource, we round it towards an
> >   address which is a multiple of align, but "start" may not be
> >   a multiple of align.
> > - if we expand "start", we round it down towards a multiple of
> >   align.  However, "end" may not be a multiple of align.

Ok, your description covers the latter case, and seems quite reasonable
given the arguments.  The former case seems to be a little less clear
though.

> Heh, this sounds almost identical to the PARISC problem.  I knew other
> users would come out of the woodwork if I sent the patch ;-)  We also
> need to know whether the start or end was changed to reprogram the
> parent device -- see the caller in drivers/parisc/ccio-dma.c:
> 
> > It may make sense to do something more generic, like:
> > 
> > int adjust_resource(struct resource *res, unsigned long start,
> > 		    unsigned long end);
> > 
> > so that the caller knows what he's requesting and knows whether that
> > change succeeded or failed.  However, it is something I'd need to
> > look deeper into when I have more time available to look at such
> > stuff, so please don't take the above as a well thought-out solution.
> 
> I don't like that.  It puts more work into the caller, but doesn't
> seem to simplify the _resource function.

The problem with expand_resource as it currently stands is that it can
expand either at the start or the end of the resource, and we don't know
which it is going to do.  PCMCIA is one example where this information
matters - not only do we need to know the right IO range for each IO
window, but we also need to know the IO address for each device.

This means that if we were to expand these window resources, we must
know where the new space was allocated.

I think we can both agree that saving the old resources start, end
and then comparing it after expand_resource() is fairly disgusting.

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
      Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
      maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                      2.6 Serial core
