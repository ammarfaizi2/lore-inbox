Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbUCaCgf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 21:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUCaCgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 21:36:35 -0500
Received: from ozlabs.org ([203.10.76.45]:16105 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261690AbUCaCgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 21:36:33 -0500
Subject: Re: route cache DoS testing and softirqs
From: Rusty Russell <rusty@rustcorp.com.au>
To: Srivatsa Vaddagiri <vatsa@in.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Dipankar Sarma <dipankar@in.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com, Robert Olsson <Robert.Olsson@data.slu.se>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, Dave Miller <davem@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Andrew Morton <akpm@osdl.org>,
       rusty@au1.ibm.com
In-Reply-To: <20040330050614.GA4669@in.ibm.com>
References: <20040329184550.GA4540@in.ibm.com>
	 <20040329222926.GF3808@dualathlon.random>
	 <20040330050614.GA4669@in.ibm.com>
Content-Type: text/plain
Message-Id: <1080700584.17686.237.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 31 Mar 2004 12:36:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-03-30 at 15:06, Srivatsa Vaddagiri wrote:
> On Tue, Mar 30, 2004 at 01:07:12AM +0000, Andrea Arcangeli wrote:
> > btw, the set_current_state(TASK_INTERRUPTIBLE) before
> > kthread_should_stop seems overkill w.r.t. smp locking, plus the code is
> > written in the wrong way around, all set_current_state are in the wrong
> > place. It's harmless but I cleaned up that bit as well.
> 
> I think set_current_state(TASK_INTERRUPTIBLE) before kthread_should_stop()
> _is_ required, otherwise kthread_stop can fail to destroy a kthread.

The problem is that kthread_stop used to send a signal to the kthread,
which meant we didn't have to beware of races (since it would never
sleep any more): kthread_should_stop() was called signal_pending 8)

Andrew hated the signal mechanism, so I abandoned it, but didn't go back
and fix all the users.  It's tempting to send a signal anyway to make
life simpler, though, although that might set a bad example for others.

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

