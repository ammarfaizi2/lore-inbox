Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270812AbUJVD5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270812AbUJVD5w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 23:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270937AbUJVD5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 23:57:47 -0400
Received: from ozlabs.org ([203.10.76.45]:23193 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S270812AbUJVD5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 23:57:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16760.34275.675065.538997@cargo.ozlabs.ibm.com>
Date: Fri, 22 Oct 2004 14:00:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jesse Barnes <jbarnes@sgi.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, jgarzik@pobox.com,
       gnb@sgi.com, akepner@sgi.com
Subject: Re: [PATCH] use mmiowb in tg3.c
In-Reply-To: <200410212201.35430.jbarnes@sgi.com>
References: <200410211613.19601.jbarnes@engr.sgi.com>
	<200410211628.06906.jbarnes@engr.sgi.com>
	<20041021164007.4933b10b.davem@davemloft.net>
	<200410212201.35430.jbarnes@sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Barnes writes:

> On Thursday, October 21, 2004 6:40 pm, David S. Miller wrote:
> > On Thu, 21 Oct 2004 16:28:06 -0700
> >
> > Jesse Barnes <jbarnes@engr.sgi.com> wrote:
> > > This patch originally from Greg Banks.  Some parts of the tg3 driver
> > > depend on PIO writes arriving in order.  This patch ensures that in two
> > > key places using the new mmiowb macro.  This not only prevents bugs (the
> > > queues can be corrupted), but is much faster than ensuring ordering using
> > > PIO reads (which involve a few round trips to the target bus on some
> > > platforms).
> >
> > Do other PCI systems which post PIO writes also potentially reorder
> > them just like this SGI system does?  Just trying to get this situation
> > straight in my head.
> 
> The HP guys claim that theirs don't, but PPC does, afaik.  And clearly any 
> large system that posts PCI writes has the *potential* of reordering them.

No, PPC systems don't reorder writes to PCI devices.  Provided you use
inl/outl/readl/writel et al., all PCI accesses from one processor are
strictly ordered, and if you use a spinlock, that gives you strict
access ordering between processors.

Our barrier instructions mostly order cacheable accesses separately
from non-cacheable accesses, except for the strongest barrier
instruction, which orders everything.  Thus it would be useful for us
to have an explicit indication of when a cacheable write (i.e. to main
memory) has to be completed (from a PCI device's point of view) before
a non-cacheable device read or write (e.g. to kick off DMA).

Paul.
