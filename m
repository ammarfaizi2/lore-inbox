Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbUKRBWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbUKRBWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262604AbUKRBUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:20:48 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:37292 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262588AbUKRBTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:19:19 -0500
To: Dave Hansen <haveblue@us.ibm.com>
cc: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Ian.Pratt@cl.cam.ac.uk
Subject: Re: [patch 2] Xen core patch : arch_free_page return value 
In-reply-to: Your message of "Wed, 17 Nov 2004 17:04:36 PST."
             <1100739876.12373.262.camel@localhost> 
Date: Thu, 18 Nov 2004 01:19:15 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUaxA-0006Fa-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 2004-11-17 at 15:48, Ian Pratt wrote:
> > This patch adds a return value to the existing arch_free_page function
> > that indicates whether the normal free routine still has work to
> > do. The only architecture that currently uses arch_free_page is arch
> > 'um'. arch-xen needs this for 'foreign pages' - pages that don't
> > belong to the page allocator but are instead managed by custom
> > allocators.
> 
> But, you're modifying page allocator functions to do this.  Why would
> you call __free_pages_ok() on a page that didn't belong to the page
> allocator?

Pages that have been allocated by our custom allocators get passed
into standard linux subsystems where we get no control over how
they're freed. We want the normal page ref counting etc to happen
as per normal, we just want to intercept the final free so that
we can return it to our allocator rather than the standard one.

We use custom allocators in a number of places, most notably for
the pages storing the packet data fragments that are pointed to
by skbs. This enables us to providing guest virtual machines with
zero-copy access to the network, which is a big performance win.

The existing arch_free_page mechanism very nearly does what we
want, we just need to add the 'early exit'.

Thanks,
Ian
