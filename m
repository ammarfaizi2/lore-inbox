Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318361AbSIEWMw>; Thu, 5 Sep 2002 18:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318345AbSIEWMt>; Thu, 5 Sep 2002 18:12:49 -0400
Received: from crack.them.org ([65.125.64.184]:65028 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S318275AbSIEWLX>;
	Thu, 5 Sep 2002 18:11:23 -0400
Date: Thu, 5 Sep 2002 18:15:58 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
Message-ID: <20020905221558.GA12837@nevyn.them.org>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209060009280.11747-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209060009280.11747-100000@localhost.localdomain>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 12:09:51AM +0200, Ingo Molnar wrote:
> 
> On Thu, 5 Sep 2002, Daniel Jacobowitz wrote:
> 
> > There's definitely still something wrong... let me just run through my
> > understanding of these lists, to make sure we're on the same page.
> > 
> > tsk->children: tsk's children, which are either untraced or traced by
> > 	tsk.  They have p->parent == p->real_parent == tsk.
> > 	Chained in p->sibling.
> 
> no - the way i wrote it originally was that only untraced children should
> be on the tsk->children list. Traced tasks will be on the debugger's
> ->children list, plus will be on the real parent's ->ptrace_children list.

Right - let me rephrase.  Tasks which are either:
  - untraced, normal
  - traced, but traced _by their parent_
are on the sibling/children list.

Tasks which are traced by some not-my-parent process go on the
ptrace_children list.  So I think we agree.

> > tsk->ptrace_children: tsk's children, which are traced by some other
> > 	process.  They have p->real_parent == tsk and p->parent != tsk.
> > 	Chained in p->ptrace_list.
> 
> yes. This means that the sum of the two lists gives the real, total set of
> children.
> 
> this splitup of the lists makes it possible for the debugger to do a wait4
> that will get events from the debugged task, and for the debugged task to
> also be available to the real parent.

Great.  I'm not exactly sure on how this works right now: sys_wait4
only iterates over ->children, with the exception of the special code
in TASK_ZOMBIE.  I'm not quite sure when events from a traced process
get to the normal parent of that process, or when they're supposed to.

> is this really what we want?
> 
> (note that the meaning of the lists is not necesserily cleanly expressed
> via the code, all deviations are most likely bugs.)

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
