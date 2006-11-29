Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758932AbWK2XJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758932AbWK2XJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 18:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758934AbWK2XJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 18:09:12 -0500
Received: from smtp.osdl.org ([65.172.181.25]:29396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758932AbWK2XJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 18:09:12 -0500
Date: Wed, 29 Nov 2006 15:05:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: eranian@hpl.hp.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [PATCH] i386 add idle notifier
Message-Id: <20061129150544.ebd952f3.akpm@osdl.org>
In-Reply-To: <20061129221853.GD29670@frankl.hpl.hp.com>
References: <20061129162540.GL28007@frankl.hpl.hp.com>
	<20061129170939.GA29203@infradead.org>
	<20061129130944.82e3d9bb.akpm@osdl.org>
	<20061129221853.GD29670@frankl.hpl.hp.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 14:18:53 -0800
Stephane Eranian <eranian@hpl.hp.com> wrote:

> Hello,
> 
> On Wed, Nov 29, 2006 at 01:09:44PM -0800, Andrew Morton wrote:
> > On Wed, 29 Nov 2006 17:09:39 +0000
> > Christoph Hellwig <hch@infradead.org> wrote:
> > 
> > > On Wed, Nov 29, 2006 at 08:25:40AM -0800, Stephane Eranian wrote:
> > > > Hello,
> > > > 
> > > > Here is a patch that adds an idle notifier to the i386 tree.
> > > > The idle notifier functionalities and implementation are
> > > > identical to the x86_64 idle notifier. We use the idle notifier
> > > > in the context of perfmon.
> > > > 
> > > > The patch is against Andi Kleen's x86_64-2.6.19-rc6-061128-1.bz2
> > > > kernel. It may apply to other kernels but it needs some updates
> > > > to poll_idle() and default_idle() to work correctly.
> > > 
> > > Walking through a notifier chain on every single interrupt (including
> > > timer interrupts) seems rather costly.  What do you need this for
> > > exactly?
> > 
> Let me give you the background on this.
> 
> In system-wide mode, perfmon wants to exclude useless kernel execution
> from being monitored. That execution is performed by the idle thread
> when it enters its lowest loop level, i.e., poll_idle(), defaut_idle(),
> mwait_idle(). It used to be that the idle loop was simply looping, waiting
> for an interrupt or polling a variable. These days, it is a bit more
> complex because on many processors, idle means going to a lower power state.
> We want to capture useful idle thread execution such as interrupt servicing
> but we want to exclude polling and low-power state.

An alternative approach might be to change perfmon so that it works out
whether it is being called by an idle thread

	if ((current->flags & PF_IDLE) && (other stuff to do with irqs?))
		return;

> We would still need the test_and_set
> to avoid a race with interrupts.

btw, I don't think anyone promised that __test_and_set_bit is atomic wrt
interrupts on all architectures.  Is OK for x86.

