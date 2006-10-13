Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751812AbWJMTBW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbWJMTBW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 15:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751813AbWJMTBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 15:01:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59565 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751812AbWJMTBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 15:01:21 -0400
Date: Fri, 13 Oct 2006 12:00:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>, Jan Beulich <jbeulich@novell.com>,
       Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 0/7] fault-injection capabilities (v5)
Message-Id: <20061013120006.e18e89d9.akpm@osdl.org>
In-Reply-To: <20061013174623.GA29079@localhost>
References: <452df20e.025ef312.44f0.7578@mx.google.com>
	<20061012142625.520d3d87.akpm@osdl.org>
	<20061013174623.GA29079@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Oct 2006 02:46:24 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> On Thu, Oct 12, 2006 at 02:26:25PM -0700, Andrew Morton wrote:
> 
> > You've presumably run a kernel with these various things enabled.  What
> > happens?  Does the kernel run really slowly?  Does userspace collapse in a
> > heap?  Does it oops and die?
> 
> I don't feel much slowness with STACKTRACE & FRAME_POINTER and
> enabling stacktrace filter. But with enabling STACK_UNWIND I feel
> big latency on X. (There are two type of implementation of stacktrace
> filter in it [1] using STACKTRACE with FRAME_POINTER, and [2] STACK_UNWIND)
> 
> I don't know why there is quite difference between simple STACKTRACE and
> STACK_UNWIND. I'm about to try to use rb tree rather than linked list in
> unwind.

umm, we've hit this before, recently - iirc it was making lockdep run
really slowly.

The new unwinding code is apparently really inefficient in some situations.
It wasn't expected that it would be called at a high frequency, except people
_do_ want to do that.

I forget the details, but I can cc people who have better memory.

> In order to prevent from breaking other userspace programs and to
> inject failures into only a specific code or process, process filter and
> stacktrace filter are available. Without using them the system would be
> almost unusable.
> 
> Now I'm stuck on the script in fault-injection.txt with random 700
> modules. This script just tries to load/unload for all available kernel
> modules. It usually get several oopses or CPU soft lockup now.  It
> seems that relatively large number of them involved around driver model
> (drivers/base/*).

I'm shocked ;)

> (I hope recent large number of error handle fixes
> especially by Jeff Garzik fix them)

We're getting there, but there's a lot more to do.

> > Also, one place where this infrastructure could be of benefit is in device
> > drivers: simulate a bad sector on the disk, a pulled cable, a timeout
> > reading from a status register, etc.  If that works well and is useful then
> > I can see us encouraging driver developers to wire up fault-injection in
> > the major drivers.
> > 
> > Hence it would be useful at some stage to go in and to actually do all this
> > for a particular driver.  As an example implementation for others to
> > emulate and as a test for the fault-injection infrastructure itself - we
> > may discover that new capabilities are needed as this work is done.
> > 
> > I wouldn't say this is an urgent thing to be doing, but it is a logical
> > next step..
> 
> Yes. I'm learning from md/faulty and scsi-debug module what they are
> doing and how to integrate such kind of features in general form.

Neato, thanks.  Please don't slow down!

It's the GFP_ATOMIC allocations which we care about, really.  Things like
GFP_KERNEL actually don't fail in the current implementation (unless the
caller got oom-killed), and all this check-for-allocation-failures work
we're doing is mainly for completeness, and in anticipation of changes in
the page allocator strategy.

