Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264809AbUE0PjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264809AbUE0PjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 11:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264811AbUE0PjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 11:39:16 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:6039
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264809AbUE0PjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 11:39:14 -0400
Date: Thu, 27 May 2004 17:39:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Brian Gerst <bgerst@didntduck.org>, Ingo Molnar <mingo@elte.hu>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjanv@redhat.com>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4k stacks in 2.6
Message-ID: <20040527153908.GJ3889@dualathlon.random>
References: <20040526125014.GE12142@wohnheim.fh-wedel.de> <20040526125300.GA18028@devserv.devel.redhat.com> <20040526130047.GF12142@wohnheim.fh-wedel.de> <20040526130500.GB18028@devserv.devel.redhat.com> <20040526164129.GA31758@wohnheim.fh-wedel.de> <20040527124551.GA12194@elte.hu> <20040527135930.GC3889@dualathlon.random> <40B5F8C0.2010005@didntduck.org> <20040527145033.GF3889@dualathlon.random> <Pine.LNX.4.58.0405270754360.1648@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405270754360.1648@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 07:55:36AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 27 May 2004, Andrea Arcangeli wrote:
> >
> > On Thu, May 27, 2004 at 10:18:40AM -0400, Brian Gerst wrote:
> > > The problem on i386 (unlike x86-64) is that the thread_info struct sits 
> > > at the bottom of the stack and is referenced by masking bits off %esp. 
> > > So the stack size must be constant whether in process context or IRQ 
> > > context.
> > 
> > so what, that's a minor implementation detail, pda is a software thing.
> 
> "minor implementation detail"?
> 
> You need to get to the thread info _some_ way, and you need to get to it
> _fast_. There are really no sane alternatives. I certainly do not want to
> play games with segments.

If the page is "even" the thread_info is at the top of the stack. If the
page is "odd" the thread_info is at the bottom of the stack (or the
other way around depending what you mean with "odd" and "even").

the per-cpu irq stack will have the thread_info at both the top and the
bottom of the 8k naturally aligned order1 compound page. The regular
kernel stack will have it at the top or the bottom depending if it's odd
or even.

this should allow 8k irqstack and bh stack fine at in-cpu-core speed w/o
segments or similar.

The only downside is that itadds a branch to current_thread_info that
will have to check the 12th bitflag in the esp before doing andl, the
second downside is having to update two thread_info during irq, instead
of just one.

It would be probably better if the thread_info was just a pointer to a
"pda" instead of being the PDA itself so there are just two writes into
the kernel stack for every irq. In x86-64 this is much more natural
since the pda-pointer is in the cpu 64bit %gs register and that saves a
branch and defereference on the stack for every "current" invocation,
and two writes for every first-irq or first-bh. 
