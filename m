Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271178AbUJVBVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271178AbUJVBVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbUJVBSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:18:23 -0400
Received: from gate.crashing.org ([63.228.1.57]:8113 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S271106AbUJVBRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:17:49 -0400
Subject: Re: [PATCH] use mmiowb in tg3.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com,
       Jeff Garzik <jgarzik@pobox.com>, gnb@sgi.com, akepner@sgi.com
In-Reply-To: <20041021164007.4933b10b.davem@davemloft.net>
References: <200410211613.19601.jbarnes@engr.sgi.com>
	 <200410211628.06906.jbarnes@engr.sgi.com>
	 <20041021164007.4933b10b.davem@davemloft.net>
Content-Type: text/plain
Message-Id: <1098407804.6071.22.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 22 Oct 2004 11:16:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-22 at 09:40, David S. Miller wrote:
> On Thu, 21 Oct 2004 16:28:06 -0700
> Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> 
> > This patch originally from Greg Banks.  Some parts of the tg3 driver depend on 
> > PIO writes arriving in order.  This patch ensures that in two key places 
> > using the new mmiowb macro.  This not only prevents bugs (the queues can be 
> > corrupted), but is much faster than ensuring ordering using PIO reads (which 
> > involve a few round trips to the target bus on some platforms).
> 
> Do other PCI systems which post PIO writes also potentially reorder
> them just like this SGI system does?  Just trying to get this situation
> straight in my head.

I think the problem they have is really related to their spinlock, that
is the IO leaking out of the spinlock vs. other CPUs.

On the other hand, as I discussed with Jesse in the past, I'd like to
extend the semantics of mmiowb() to also define full barrier between
cacheable and non-cacheable accesses. That would help fixing a lot of issues
on ppc and ppc64.

Typically, our normal "light" write barrier doesn't reorder between cacheable
and non-cacheable (MMIO) stores, which is why we had to put some heavy sync
barrier in our MMIO writes macros.

By having an mmiowb() that allow to explicitely do this ordering, it would
allow us to relax the barriers in the MMIO macros, and so get back a few
percent of perfs that we lost with the "fix".

I haven't had time to work on that yet though, I need to review with paulus
all the possible race cases, but hopefully, I'll have a patch on top of
Jesse next week or so and will start converting more drivers.

Ben.

