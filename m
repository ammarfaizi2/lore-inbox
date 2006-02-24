Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWBXPDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWBXPDp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 10:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBXPDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 10:03:45 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:20706 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S932239AbWBXPDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 10:03:44 -0500
Date: Fri, 24 Feb 2006 10:03:42 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Benjamin LaHaise <bcrl@kvack.org>
cc: Andrew Morton <akpm@osdl.org>, <sekharan@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid calling down_read and down_write during startup
In-Reply-To: <20060224143900.GA7101@kvack.org>
Message-ID: <Pine.LNX.4.44L0.0602240959460.5071-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Feb 2006, Benjamin LaHaise wrote:

> On Thu, Feb 23, 2006 at 04:16:31PM -0800, Andrew Morton wrote:
> > down_write() unconditionally (and reasonably) does local_irq_enable() in
> > the uncontended case.  And enabling local interrupts early in boot can
> > cause crashes.
> 
> Why not do a down_write_trylock() instead first?  Then the code doesn't 
> have the dependancy on system_state, which seems horribly fragile.

I suggested this to Andrew.  His reply was as follows:

> > which means we can't avoid calling down_write.  The 
> >  only solution I can think of is to use down_write_trylock in the 
> >  blocking_notifier_chain_register and unregister routines, even though 
> >  doing that is a crock.
> > 
> >  Or else change __down_read and __down_write to use spin_lock_irqsave 
> >  instead of spin_lock_irq.  What do you think would be best?
> 
> Nothing's pretty.  Perhaps look at system_state and not do any locking at all
> in early boot?

I admit that the whole things is fragile.  IMO the safest approach would
be for __down_read and __down_write not to assume that interrupts are
currently enabled.  But that would introduce more overhead as well; at
least this way the overhead is confined to the notifier chain registration
routines.

Alan Stern

