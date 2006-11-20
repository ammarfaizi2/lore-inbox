Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966602AbWKTT5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966602AbWKTT5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 14:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966604AbWKTT5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 14:57:17 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:57763 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S966602AbWKTT5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 14:57:15 -0500
Date: Mon, 20 Nov 2006 14:56:52 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Pavel Emelianov <xemul@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>
Subject: Re: [RFC] [PATCH] Fix misrouted interrupts deadlocks
Message-ID: <20061120195652.GA6141@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <455484E4.1020100@openvz.org> <20061120192335.GA11879@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120192335.GA11879@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 02:23:35PM -0500, Vivek Goyal wrote:
> On Fri, Nov 10, 2006 at 04:55:48PM +0300, Pavel Emelianov wrote:
> > As the second lock on booth CPUs is taken before checking that
> > this irq is being handled in another processor this may cause
> > a deadlock. This issue is only theoretical.
> > 
> > I propose the attached patch to fix booth problems: when trying
> > to handle misrouted IRQ active desc->lock may be unlocked.
> > 
> > Please comment.
> 
> > --- ./kernel/irq/spurious.c.irqlockup	2006-11-09 11:19:10.000000000 +0300
> > +++ ./kernel/irq/spurious.c	2006-11-10 16:53:38.000000000 +0300
> > @@ -147,7 +147,11 @@ void note_interrupt(unsigned int irq, st
> >  	if (unlikely(irqfixup)) {
> >  		/* Don't punish working computers */
> >  		if ((irqfixup == 2 && irq == 0) || action_ret == IRQ_NONE) {
> > -			int ok = misrouted_irq(irq);
> > +			int ok;
> > +
> > +			spin_unlock(&desc->lock);
> > +			ok = misrouted_irq(irq);
> > +			spin_lock(&desc->lock);
> 
> Hi Pavel,
> 
> Till -rc5, I was able to boot a kernel with irqpoll option and in -rc6 I 
> can't. It simply hangs. I suspect it is realted to this change. I have yet
> to confirm that. But before that one observation.
> 

Hi Pavel,

If I backout your changes, everything works fine. So it looks like that
the problem I am facing is because of your patch but I don't have a logical
explanation yet that why the problem is there. Just realasing a lock
which is not currently acquired should not hang the system?

Thanks
Vivek
