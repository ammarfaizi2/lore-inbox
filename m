Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267634AbUHJTBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267634AbUHJTBI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267361AbUHJSzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 14:55:02 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:1971 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267673AbUHJSvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 14:51:42 -0400
Subject: Re: bkl cleanup in do_sysctl
From: Lee Revell <rlrevell@joe-job.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Josh Aas <josha@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steiner@sgi.com
In-Reply-To: <1092158905.11212.18.camel@nighthawk>
References: <4118FE9D.2050304@sgi.com> <1092158905.11212.18.camel@nighthawk>
Content-Type: text/plain
Message-Id: <1092163919.782.54.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 14:51:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 13:28, Dave Hansen wrote:

> Remember that the BKL isn't a plain-old spinlock.  You're allowed to
> sleep while holding it and it can be recursively held, which isn't true
> for other spinlocks.
> 
> So, if you want to replace it with a spinlock, you'll need to do audits
> looking for sysctl users that might_sleep() or get called recursively
> somehow.  The might_sleep() debugging checks should help immensely for
> the first part, but all you'll get are deadlocks at runtime for any
> recursive holders.  But, those cases are increasingly rare, so you might
> luck out and not have any.  
> 
> Or, you could just make it a semaphore and forget about the no sleeping
> requirement.  
> 

Someone once suggested that newbies who show up on LKML wanting to learn
kernel hacking should be assigned to find one use of the BKL and replace
it with proper locking.  Something similar worked very well with my
previous employer, before giving someone root, new hires would first be
assigned some task like writing a script to take the user account
database and generate a report of old accounts on a bunch of machines,
or rewrite the RADIUS accounting scripts, where the point was really to
get them familiar with the system.

This way, even if they come back with a totally botched fix, someone
will probably just post a correct one.  We could get rid of the BKL very
soon, I count only 247 files with lock_kernel in them.

For example reiserfs uses the BKL for all write locking (!), but it
probably would not be too hard to fix, because you can just look at
another filesystem that has proper locking.

Maybe this should be added to the FAQ:

Q:  I want to hack the kernel, and I *think* I know what I am doing. 
Where do I start?

Lee

