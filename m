Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269022AbUIHDeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269022AbUIHDeN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 23:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269026AbUIHDeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 23:34:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2725 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269022AbUIHDeM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 23:34:12 -0400
Date: Wed, 8 Sep 2004 04:34:10 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Dawson Engler <engler@coverity.dreamhost.com>
Cc: linux-kernel@vger.kernel.org, developers@coverity.com
Subject: Re: [CHECKER] possible deadlock in 2.6.8.1 lockd code
Message-ID: <20040908033410.GU23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0409071956380.6778@coverity.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409071956380.6778@coverity.dreamhost.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 07:57:28PM -0700, Dawson Engler wrote:
> Hi All,
> 
> below is a possible deadlock in the linux-2.6.8.1 lockd code found by a
> static deadlock checker I'm writing.  Let me know if it looks valid and/or
> whether the output is too cryptic.  (Note, the locking dependencies go
> across a bunch of function calls, so the paths may be infeasible.)

It's a BS - down() and lock_kernel() do not form a mutual deadlock.

Consider minimal deadlocked state.  By definition, we can exclude tasks
that didn't manage to get at least one lock (we would still have a deadlocked
set without them and we have chosen a minimal set).  Consider the task
that holds semaphore; since we have a deadlock, it would have to be spinning
in lock_kernel().  That requires another task in our set to be holding BKL _and_
having the timeslice, since BKL is dropped when task loses CPU.  But such
task would not be blocked on anything - it can't be blocked on semaphore
since it is runnable and it can't be blocked on BKL since it's already holding
it.  In other words, it could not be a part of our deadlock.  QED.
