Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318995AbSHMRvo>; Tue, 13 Aug 2002 13:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318996AbSHMRvo>; Tue, 13 Aug 2002 13:51:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13326 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318995AbSHMRvW>;
	Tue, 13 Aug 2002 13:51:22 -0400
Message-ID: <3D594A68.88807CEE@zip.com.au>
Date: Tue, 13 Aug 2002 11:05:28 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kwaitd, 2.5.31-A1
References: <3D59436F.3DFAFA36@zip.com.au> <Pine.LNX.4.44.0208131928320.4369-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Tue, 13 Aug 2002, Andrew Morton wrote:
> 
> > > the reaping of the thread is thus not done by the parent (or init), but by
> > > per-CPU [kwaitd] kernel threads. The exiting thread queues itself always
> > > to the CPU-local kwaitd queue, to maintain locality of reference and cheap
> > > switching to kwaitd.
> >
> > I'd be inclined to agree with hch on that.  We have an awful lot of
> > kernel threads nowadays, and keventd would fill the bill.
> 
> i agree. What i did was i looked at the kernel-source as-is, and there was
> no mechanism to do this properly so i took a different approach. Could
> anyone send me per-CPU keventd patches? The thread-exit path is pretty
> timing-critical, the current global keventd spinlock does not work.

I think Arjan has them, or the AIO patch.

> ...
> > And a question: is it not possible to make the exitting task just go and
> > reap itself?  If it's a matter of freeing the stack pages we could just
> > add the page to a per-cpu deferred freeing list and reap it in page
> > reclaim.
> 
> well, yes - but i dislike deferred freeing lists, it's always a problem
> where to free the RAM for real. It didnt really work for bhs, it didnt
> really work for other items either. And we have this nice lazy-TLB
> mechanism for kernel threads so it's really a non-issue to use them.

Well what we can do in there is to just have a one-deep percpu list.
So the exitting task frees the previous thread's stack (if any)
and inserts its own stack.  And that stack can be used in fork, of
course.  Which gives some per-cpu LIFO stack allocation.

It would mean that the thread would have to exit with preempt disabled,
but AFAIK that's just a matter of fixing or deleting that debug warning.
