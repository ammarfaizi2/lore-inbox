Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbWDMJ1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbWDMJ1r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 05:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWDMJ1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 05:27:47 -0400
Received: from gateway0.EECS.Berkeley.EDU ([169.229.60.93]:5817 "EHLO
	gateway0.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S964851AbWDMJ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 05:27:45 -0400
Message-Id: <6.2.5.6.2.20060413015645.033d3fc8@comcast.net>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.5.6
Date: Thu, 13 Apr 2006 02:18:55 -0700
To: Andrew Morton <akpm@osdl.org>
From: Dan Bonachea <bonachead@comcast.net>
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060412214613.404cf49f.akpm@osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
 <20060412214613.404cf49f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:46 PM 4/12/2006, Andrew Morton wrote:
>Locking for file.f_pos is generally file->f_dentry->d_inode->i_mutex.  We
>could use that if we were to restructure the code a lot.  Or we could add a
>new lock to `struct file'.
>
>Or we could do nothing, because a) the application is going to produce
>inderterminate output anyway and b) because it only affects silly testcases
>and not real-world apps.
>
>OK, there _might_ be a real-world case: threads appending logging
>information to a flat file.  Trivially workable-around with a userspace
>lock, or by switching to stdio (same thing).
>
>Yes, really we should fix it.  But it's not worth adding more overhead to
>do so.  So the fix would involve widespread (but simple) change, to draw
>that f_pos update inside i_mutex.

Hi Andrew - thanks for the detailed response.

I don't know enough about the kernel implementation to comment on your 
proposed fixes.

However, I should clarify that this problem definitely affects more than just 
"silly testcases", and the fact that a program generates non-deterministically 
ordered output does not necessarily make it erroneous, invalid or unuseful.

This problem arose in the parallel runtime system for a scientific language 
compiler (nearly a million lines of code total - definitely a "real-world" 
program) - the example code is merely a pared-down demonstration of the 
problem. In parallel scientific computing, it's very common for many threads 
to be writing to stdout (usually for monitoring purposes) and it's expected 
and normal for output from separate threads to be arbitrarily interleaved, but 
it's *not* ok for output to be lost entirely. This is essentially equivalent 
to the real-world example you gave of many threads logging to a file.

We've worked around the problem in Linux 2.6 by adding locking at user-level 
around our writes, as you suggest, although this of course penalizes our 
performance on kernels that already correctly implement the thread-safety 
required by the POSIX spec. In any case it seemed like a problem that we 
should report, to be good open-source citizens - especially given that it 
appears to be a regression with respect to the Linux 2.4 kernel. How you 
choose to handle the report is of course your decision.

Thanks for your time.
Dan

