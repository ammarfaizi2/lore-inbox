Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWC1WlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWC1WlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 17:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932472AbWC1WlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 17:41:09 -0500
Received: from www.osadl.org ([213.239.205.134]:16804 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932471AbWC1WlH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 17:41:07 -0500
Subject: Re: PI patch against 2.6.16-rt9
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0603282313050.22822-100000@lifa02.phys.au.dk>
References: <Pine.LNX.4.44L0.0603282313050.22822-100000@lifa02.phys.au.dk>
Content-Type: text/plain
Date: Wed, 29 Mar 2006 00:42:06 +0200
Message-Id: <1143585726.5344.238.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 23:23 +0100, Esben Nielsen wrote:
> > If you get to L(x) the underlying dependencies might have changed
> > already as well as the dependencies x ... n. We might get false
> > positives in the deadlock detection that way, as a deadlock is an
> > "atomic" state.
> 
> As I see it you might detect a circular lock graph "atomically". But is
> that a "deadlock"? Yes, if you rule out signals and timeouts, this
> situation does indeed deadlock your program.
> 
> But if you count in signals and timeouts your algoritm also gives "false
> positives": You can detect a circular lock but when you return from
> rt_mutex_slowlock(), a signal is delivered and there is no longer a
> circular dependency and most important: The program wouldn't be
> deadlocked even if you didn't ask for deadlock detection and your task in
> that case would block.
> 
> I would like to see an examble of a false deadlock. I don't rule them out
> in the present code. But they might be simple to fix.

Simply the initial lock chain is L1->L2->L3->L4, which is no deadlock.
Now in the course of your lock dropping L2 gets removed while you are at
L3 and L5 gets added on top of L4. You follow the chain blindly and
detect a dealock vs. L5, but its not longer valid. The L2 cleanup is
blocked by yourself. There is no way to prevent this with your method.

Your method is tempting, but I do not see how it works out right now. 

	tglx



