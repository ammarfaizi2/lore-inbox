Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWBQHaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWBQHaN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWBQHaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:30:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:16016 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932571AbWBQHaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:30:12 -0500
Date: Thu, 16 Feb 2006 23:29:50 -0800
From: Paul Jackson <pj@sgi.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: pj@sgi.com, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: Robust futexes
Message-Id: <20060216232950.efa39e13.pj@sgi.com>
In-Reply-To: <1140160371.25078.81.camel@localhost.localdomain>
References: <1140152271.25078.42.camel@localhost.localdomain>
	<20060216224207.98526b40.pj@sgi.com>
	<1140160371.25078.81.camel@localhost.localdomain>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ah - that makes more sense - thanks.

So the point is that we only have to cleanup the stale locks of dead
threads when some other task has the misfortune of trying to take
the orphaned lock and gets forced into a wait.

The wait call essentially becomes a "wait unless said other TID is
dead, in which case, a new owner is summarily declared."

Hmmm ...

How do you handle the case where the wait occurred before the death,
not after, and the case where the problem is caused by a task dying
that was not the task that held the lock when the wait was called.

Say task A is holding the lock for a while, during which tasks B,
C and D queue up waiting for the lock, then task A releases and task
B gets it, then task B drops dead unexpectedly.

When C and D began their wait, A owned the lock.  Now it is the death
of B that should lead to the awakening of C.

What does you solution look like in that case?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
