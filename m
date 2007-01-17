Return-Path: <linux-kernel-owner+w=401wt.eu-S932509AbXAQQeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbXAQQeA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 11:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbXAQQeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 11:34:00 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:45181 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932509AbXAQQd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 11:33:59 -0500
Date: Wed, 17 Jan 2007 11:33:58 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Christoph Hellwig <hch@infradead.org>
cc: Andrew Morton <akpm@osdl.org>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Kwatch: kernel watchpoints using CPU debug registers
In-Reply-To: <20070116233528.GA19834@infradead.org>
Message-ID: <Pine.LNX.4.44L0.0701171117540.2381-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Christoph Hellwig wrote:

> Fir4st I'd say thanks a lot for forward-porting this, it's really useful
> feature for all kinds of nasty debugging.
> 
> I think you should split this into two patches, one for the debugreg
> infrastructure, and one for the actual kwatch code.
> 
> Also I think you provide one (or even a few) example wathes for
> trivial things, say updating i_ino for an inode given through debugfs.
> 
> Some comments on the code below:

Many thanks for your detailed comments and suggestions.  It probably was
obvious that most of the things you picked up on were inherited from the
original Kwatch patch.  I'll update my patch in accordance with your
suggestions.

Responses to just a couple of the comments:

> I suspect this should be replaced wit ha global and local variant
> to fix the above mentioned issue.  It's a tiny bit duplicated code,
> but seems much cleaner.

It would indeed be cleaner.  And in fact the local variant would have a
large amount of dead code, which could be left out entirely (at least from
the initial version).  That's because the only current user of local debug 
register allocations is ptrace.

> > +static void write_dr(int debugreg, unsigned long addr)
> > +{
> > +	switch (debugreg) {
> > +		case 0:	set_debugreg(addr, 0);	break;
> > +		case 1:	set_debugreg(addr, 1);	break;
> > +		case 2:	set_debugreg(addr, 2);	break;
> > +		case 3:	set_debugreg(addr, 3);	break;
> > +		case 6:	set_debugreg(addr, 6);	break;
> > +		case 7:	set_debugreg(addr, 7);	break;
> > +	}
> > +}
> 
> What's the point of this wrapper?

It is called from two different places, and it's better than including
the "switch" in each place.

> I think large parts of this header should go into a new linux/kwatch.h
> so that generic code can use kwatches.

In the long run that may well be true.  For now, I'm a little hesitant to
put something which works only on i386 under include/linux.

> > +config KWATCH
> > +	bool "Kwatch points (EXPERIMENTAL)"
> > +	depends on EXPERIMENTAL
> > +	help
> > +	  Kwatch enables kernel-space data watchpoints using the processor's
> > +	  debug registers.  It can be very useful for kernel debugging.
> > +	  If in doubt, say "N".
> 
> I think we want different options for debugregs and kwatch.  The debugreg
> one probably doesn't have to be actually user-visible, though.

It's easier to start out like this and then change it later when someone
comes up with another use for debugregs.  Or perhaps by then the whole
thing will have been moved over to utrace, making the issue academic.

Alan Stern

