Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbVBXGvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbVBXGvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 01:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbVBXGvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 01:51:13 -0500
Received: from fire.osdl.org ([65.172.181.4]:38878 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261875AbVBXGvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 01:51:08 -0500
Date: Wed, 23 Feb 2005 22:50:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Chad N. Tindel" <chad@tindel.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
Message-Id: <20050223225050.22d747b6.akpm@osdl.org>
In-Reply-To: <20050224052330.GA99006@calma.pair.com>
References: <20050223230639.GA33795@calma.pair.com>
	<20050223183634.31869fa6.akpm@osdl.org>
	<20050224052330.GA99006@calma.pair.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chad N. Tindel" <chad@tindel.net> wrote:
>
> > `xterm' is waiting for the other CPU to schedule a kernel thread (which is
> > bound to that CPU).  Once that kernel thread has done a little bit of work,
> > `xterm' can terminate.
> > 
> > But kernel threads don't run with realtime policy, so your userspace app
> > has permanently starved that kernel thread.
> > 
> > It's potentially quite a problem, really.  For example it could prevent
> > various tty operations from completing, it will prevent kjournald from ever
> > writing back anything (on uniprocessor, etc).  I've been waiting for
> > someone to complain ;)
> > 
> > But the other side of the coin is that a SCHED_FIFO userspace task
> > presumably has extreme latency requirements, so it doesn't *want* to be
> > preempted by some routine kernel operation.  People would get irritated if
> > we were to do that.
> > 
> > So what to do?
> 
> It shouldn't need to preempt the kernel operation.  Why is the design such that
> the necessary kernel thread can't run on the other CPU?
> 

This particular kernel function is implemented via a kernel thread per CPU,
with each thread bound to each CPU.  The xterm-does-exit cleanup code is
waiting for the thread which is bound to the busy CPU to do something.

No other CPU can, or is allowed, to do that thread's work.  If it were to
do so, the implicit locking which we get from the per-cpuness would be
violated.

I don't know if any clients of the workqueue code rely upon the
pinned-to-cpu feature.

