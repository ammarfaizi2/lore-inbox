Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262298AbUCBWnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbUCBWle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:41:34 -0500
Received: from NS1.idleaire.net ([65.220.16.2]:4549 "EHLO iasrv1.idleaire.net")
	by vger.kernel.org with ESMTP id S262290AbUCBWlU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:41:20 -0500
Subject: Re: poll() in 2.6 and beyond
From: Dave Dillow <dave@thedillows.org>
To: root@chaos.analogic.com
Cc: Roland Dreier <roland@topspin.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0403021651010.9048@chaos>
References: <Pine.LNX.4.53.0403021318580.796@chaos>
	 <527jy3qalg.fsf@topspin.com> <Pine.LNX.4.53.0403021510270.1856@chaos>
	 <52vflnq807.fsf@topspin.com> <Pine.LNX.4.53.0403021624300.2296@chaos>
	 <52n06zq67n.fsf@topspin.com>  <Pine.LNX.4.53.0403021651010.9048@chaos>
Content-Type: text/plain
Message-Id: <1078267278.31309.37.camel@dillow.idleaire.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 17:41:18 -0500
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Mar 2004 22:41:18.0354 (UTC) FILETIME=[7A3C7F20:01C400A7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-02 at 16:59, Richard B. Johnson wrote:
> On Tue, 2 Mar 2004, Roland Dreier wrote:

> > I don't know why I continue this, but.... can you point out the line
> > in the kernel 2.4 source for __pollwait() where it sleeps?

> The code in fs/select.c about line 101, adds the current caller
> to the wait-queue. This wait-queue is the mechanism by which the
> current caller sleeps, i.e., gives the CPU up to somebody else.

Actually, no, it does not work that way. The wait queue is the mechanism
by which a process can be *woken up* . The call to add_wait_queue() does
not put the process to sleep.

The process is put to sleep in do_poll(), using schedule_timeout() with
the current state as TASK_INTERRUPTIBLE. This is on line 453.

Your driver will eventually have to wake up sleepers on the queue.
do_poll() will also wake up when the timeout expires, or a signal is
sent to the poll()'ing process.

These semantics have not changed since 2.4. The implementation has
changed a bit, but the driver interface has not changed. Read the
documentation the Roland pointed you to.
-- 
Dave Dillow <dave@thedillows.org>

