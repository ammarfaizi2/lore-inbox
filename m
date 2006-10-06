Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWJFRmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWJFRmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 13:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWJFRmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 13:42:14 -0400
Received: from mx2.rowland.org ([192.131.102.7]:36103 "HELO mx2.rowland.org")
	by vger.kernel.org with SMTP id S1422780AbWJFRmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 13:42:13 -0400
Date: Fri, 6 Oct 2006 13:42:11 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: David Brownell <david-b@pacbell.net>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <200610052045.41211.david-b@pacbell.net>
Message-ID: <Pine.LNX.4.44L0.0610061337100.1311-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Oct 2006, David Brownell wrote:

> On Tuesday 03 October 2006 11:03 am, Alan Stern wrote:
> 
> > > > Notice another questionable use of hcd->state. 
> > > 
> > > Questionable in what way?  When that code is called to clean up
> > > after driver death, that loop must be ignored ... every pending I/O
> > > can safely be scrubbed.  That's the main point of that particular
> > > HC_IS_RUNNING() test.  In other cases, it's essential not to touch
> > > DMA queue entries that the host controller is still using.
> > 
> > Questionable because changes to hcd->state aren't synchronized with the
> > driver.  In this case it probably doesn't end up making any difference.
> 
> The driver changes hcd->state with its spinlock held ... or it did,
> last time I audited that code.

Yeah, but usbcore changes hcd->state without holding the spinlock.

> > Removing "regs &&" might change other aspects too.  For instance, does 
> > this routine ever get called from a timer routine, where regs would 
> > normally be NULL?  In such situations removing "regs &&" would reverse 
> > the sense of the test.
> 
> As I said in my previous comments:  should not be an issue.  OHCI doesn't
> have timers.  That routine is normally called in_irq(), with the other
> two call sites being cases where the controller is stopped.

(Or suspended?)

Well, I'm not familiar with the code so I accept your statement.

However, consider that even though ohci-hcd may not have timers, usbcore
does have the root-hub status timer, and it calls into ohci-hcd whenever
that timer expires.  Even though root-hub interrupts are now used, there
still are occasions when the driver asks for polling.  More than there
used to be, thanks to my auto-stop changes.

Alan Stern

