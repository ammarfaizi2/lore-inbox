Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWJCSDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWJCSDP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 14:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030448AbWJCSDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 14:03:15 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:56585 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1030343AbWJCSDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 14:03:13 -0400
Date: Tue, 3 Oct 2006 14:03:12 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <200610021600.24477.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0610031355370.6765-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Most people removed from CC: since they probably aren't too interested in 
this.]

On Mon, 2 Oct 2006, David Brownell wrote:

> On Monday 02 October 2006 2:34 pm, Alan Stern wrote:
> > On Mon, 2 Oct 2006, David Brownell wrote:
> > 
> > > > >  (*) finish_unlinks() in drivers/usb/host/ohci-q.c needs checking.  It does
> > > > >      something different depending on whether it's been supplied with a regs
> > > > >      pointer or not.
> > > 
> > > gaak!  where did that come from?  I'll be surprised if removing
> > > that causes any problem at all.
> > 
> > Here's the statement in question:
> > 
> > 	if (likely (regs && HC_IS_RUNNING(ohci_to_hcd(ohci)->state))) {
> 
> Where as I said, removing the "regs &&" should be just fine.
> (Is the plan that David Howells re-issue that patch?  If so, I'l
> expect e will just fix it that way...)
> 
> > 		...
> > 
> > Notice another questionable use of hcd->state. 
> 
> Questionable in what way?  When that code is called to clean up
> after driver death, that loop must be ignored ... every pending I/O
> can safely be scrubbed.  That's the main point of that particular
> HC_IS_RUNNING() test.  In other cases, it's essential not to touch
> DMA queue entries that the host controller is still using.

Questionable because changes to hcd->state aren't synchronized with the
driver.  In this case it probably doesn't end up making any difference.

Removing "regs &&" might change other aspects too.  For instance, does 
this routine ever get called from a timer routine, where regs would 
normally be NULL?  In such situations removing "regs &&" would reverse 
the sense of the test.

Alan Stern

