Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262498AbUCRJvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 04:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbUCRJvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 04:51:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:51620 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262484AbUCRJuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 04:50:06 -0500
Date: Thu, 18 Mar 2004 01:50:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-Id: <20040318015004.227fddfb.akpm@osdl.org>
In-Reply-To: <20040318060358.GC29530@dualathlon.random>
References: <40591EC1.1060204@geizhals.at>
	<20040318060358.GC29530@dualathlon.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Thu, Mar 18, 2004 at 05:00:01AM +0100, Marinos J. Yannikos wrote:
> > Hi,
> > 
> > we upgraded a few production boxes from 2.4.x to 2.6.4 recently and the 
> > default .config setting was CONFIG_PREEMPT=y. To get straight to the 
> > point: according to our measurements, this results in severe performance 
> > degradation with our typical and some artificial workload. By "severe" I 
> > mean this:
> 
> this is expected (see the below email, I predicted it on Mar 2000),

Incorrectly.

> keep preempt turned off always, it's useless.

Preempt is overrated.  The infrastructure which it has introduced has been
useful for detecting locking bugs.

It has been demonstrated that preempt improves the average latency.  But
not worst-case, because those paths tend to be under spinlock.

> Worst of all we're now taking spinlocks earlier than needed,

Where?  CPU scheduler?

> and the preempt_count stuff isn't optmized away by PREEMPT=n,

It should be.  If you see somewhere where it isn't, please tell us.

We unconditionally bump the preempt_count in kmap_atomic() so that we can
use atomic kmaps in read() and write().  This is why four concurrent
write(fd, 1, buf) processes on 4-way is 8x faster than on 2.4 kernels.

> preempt just wastes cpu with tons of branches in fast paths that should
> take one cycle instead.

I don't recall anyone demonstrating even a 1% impact from preemption.  If
preemption was really causing slowdowns of this magnitude it would of
course have been noticed.  Something strange has happened here and more
investigation is needed.

> ...
> I still think after 4 years that such idea is more appealing then
> preempt, and numbers start to prove me right.

The overhead of CONFIG_PREEMPT is quite modest.  Measuring that is simple.
