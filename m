Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318661AbSIEWZP>; Thu, 5 Sep 2002 18:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318691AbSIEWZO>; Thu, 5 Sep 2002 18:25:14 -0400
Received: from crack.them.org ([65.125.64.184]:2821 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318661AbSIEWZN>;
	Thu, 5 Sep 2002 18:25:13 -0400
Date: Thu, 5 Sep 2002 18:29:47 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020905222947.GA13667@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20020905221558.GA12837@nevyn.them.org> <Pine.LNX.4.44.0209060021360.14643-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209060021360.14643-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 12:25:32AM +0200, Ingo Molnar wrote:
> 
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > Right - let me rephrase.  Tasks which are either:
> >   - untraced, normal
> >   - traced, but traced _by their parent_
> > are on the sibling/children list.
> 
> hm, why the distinction along whether the debugger == real parent? What
> wrong can happen if we always move traced tasks to the ptrace list? The
> task will be both in the ptrace list and in the parent's child list, and 
> everything should work as expected. This looks a more symmetric and 
> simpler thing to me.

Hmm, I like that idea.  But I was talking about current implementation. 
If we want to do this then we'd need to fix up every ptrace
implementation in every architecture to call the appropriate function;
it's a separate problem.

> > > this splitup of the lists makes it possible for the debugger to do a wait4
> > > that will get events from the debugged task, and for the debugged task to
> > > also be available to the real parent.
> > 
> > Great.  I'm not exactly sure on how this works right now: sys_wait4 only
> > iterates over ->children, with the exception of the special code in
> > TASK_ZOMBIE.  I'm not quite sure when events from a traced process get
> > to the normal parent of that process, or when they're supposed to.
> 
> i'm not sure about this either. What happens if an (untraced) parent has
> traced and untraced children, and does a wait4. Would it confuse the
> debugger if the parent could get one of the traced tasks as a result in
> wait4? And how does the debugger solve this problem?

Well, it seems to me that when a traced task has an event, it should be
reported first to the debugger - for signals this happens in do_signal
- and then possibly to the normal parent.  But I'm not sure if this
actually happens right now or not.  Worth investigating some more.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
