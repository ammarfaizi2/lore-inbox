Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751455AbVHZEYe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbVHZEYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 00:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbVHZEYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 00:24:33 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:29885 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751455AbVHZEYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 00:24:33 -0400
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.13-rc4-V0.7.52-01
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050812125844.GA13357@elte.hu>
References: <1122944010.6759.64.camel@localhost.localdomain>
	 <20050802101920.GA25759@elte.hu>
	 <1123011928.1590.43.camel@localhost.localdomain>
	 <1123025895.25712.7.camel@dhcp153.mvista.com>
	 <1123027226.1590.59.camel@localhost.localdomain>
	 <1123035909.11101.1.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123036936.1590.69.camel@localhost.localdomain>
	 <1123037933.11101.11.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <1123080606.1590.119.camel@localhost.localdomain>
	 <1123087447.1590.136.camel@localhost.localdomain>
	 <20050812125844.GA13357@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 26 Aug 2005 00:24:09 -0400
Message-Id: <1125030249.5365.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-12 at 14:58 +0200, Ingo Molnar wrote:
> FYI, in -53-05 i've added a bh->b_update_lock, which enabled me to get 
> rid of the bitlock ugliness in fs/buffer.c. Maybe it could be used to 
> have a better fix for the jbd bitlock thing too?

Well, I just spent several hours trying to use the b_update_lock in
implementing something to replace the bit spinlocks for RT.  It's
getting really ugly and I just hit a stone wall.

The problem is that I have two locks to work with. A
jbd_lock_bh_journal_head and a jbd_lock_bh_state. Unfortunately, I also
have a ranking order of:

jbd_lock_bh_state -> j_state_lock -> jbd_lock_bh_journal_head

If the ranking wasn't like this, I could probably make a little more
progress.

The jbd_lock_bh_journal_head is used to protect against creating a
journal_head and adding it to a buffer_head.  This was the obvious
choice to use your b_update_lock as a replacement, since I need to have
a lock before I acquired a journal descriptor.

The jbd_lock_bh_state was going to exist in the journal desciptor that
is stored in the buffer_head private data.  But this lead to a problem
when this is deleted.  The private data is freed while the lock is held.
So, keeping the lock in with the journal descriptor had the problem of
being freed before it was unlocked.

I started adding code to delay the freeing of the descriptor until after
the lock was held, but this added another problem.  There might be
another process waiting on this lock, and when it gets it, it tests if
the buffer_head even has a journal_descriptor for it. So, even if I
delayed the freeing, another process could be waiting on this so you
still may have a premature free.  Not to mention that this code was
becoming _very_ intrusive, since the freeing takes place deep inside
functions that acquire the lock.

So this lock has the same problem as the jbd_lock_bh_journal_head, where
as, you have a buffer_head and you want to take this lock before you
know that this buffer_head even has a journal descriptor attached to it.

So, the only other solutions that I can think of is:

a) add yet another (bloat) lock to the buffer head.

b) Still use your b_update_lock for the jbd_lock_bh_journal_head and
change the jbd_lock_bh_state to what I discussed earlier, and that being
the hash wait_on_bit code.

So do you have any ideas?

-- Steve


