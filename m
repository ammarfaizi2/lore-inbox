Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbSIPQAy>; Mon, 16 Sep 2002 12:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262429AbSIPQAv>; Mon, 16 Sep 2002 12:00:51 -0400
Received: from crack.them.org ([65.125.64.184]:34833 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S262402AbSIPQAs>;
	Mon, 16 Sep 2002 12:00:48 -0400
Date: Mon, 16 Sep 2002 12:05:37 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for ptrace breakage
Message-ID: <20020916160537.GA12905@nevyn.them.org>
Mail-Followup-To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain> <87vg565eo2.fsf@devron.myhome.or.jp> <87wupmrtn1.fsf@devron.myhome.or.jp> <20020916130735.GA3920@nevyn.them.org> <87sn0at3di.fsf@devron.myhome.or.jp> <20020916144204.GA7991@nevyn.them.org> <87fzwasz96.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fzwasz96.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 12:57:57AM +0900, OGAWA Hirofumi wrote:
> Daniel Jacobowitz <dan@debian.org> writes:
> 
> > > > Some comments.  First of all, you said you fixed a race on
> > > > current->ptrace and some other bugs - would you mind saying where they
> > > > were?  It's definitely cleaner after your patch but I'd like to
> > > > understand where you found bugs, since I think you're introducing more.
> > > 
> > > It's the following
> > > 
> > > 		task_t *trace_task = p->parent;
> > > 		int ptrace_flag = p->ptrace;
> > > 		BUG_ON (ptrace_flag == 0);
> > > 
> > > 		__ptrace_unlink(p);
> > > 		p->ptrace = ptrace_flag;
> > > 		__ptrace_link(p, trace_task);
> > 
> > We have the tasklist lock.  How can there be a race here?  The parent
> > can't detach while we're holding the tasklist lock.  If there is a race
> > with PTRACE_SETOPTIONS, then PTRACE_SETOPTIONS should take the lock.
> 
> No. If the real parent don't change ->ptrace, it doesn't need
> lock.

I don't understand what you mean by that.  Do you mean, "if it does
change ->ptrace, it doesn't need a lock"?

The locking requirements for tsk->ptrace are not documented anywhere
right now; we basically don't have any.

> > > > So you reparent children on the ptrace_list right here.  But they still
> > > > need to go through zap_thread!  You're right, the do_notify_parent in
> > > > zap_thread isn't necessary; it'll be taken care of in sys_wait4.  The
> > > > orphaned pgrp check is still relevant though.
> > > 
> > > ??? You forget tasklist_lock?
> > 
> > Huh?
> > 
> > The problem I am describing is when a child - which will become an
> > orphaned pgrp when ``father'' dies - is being ptraced at the moment of
> > ``father''s death.  With your patch it will be moved to
> > reaper->ptrace_children (or child_reaper->ptrace_children) but never
> > orphaned properly.  It'll miss a signal.
> >
> > > > If you're going to remove the if, you need to maintain its effect! 
> > > > See:
> > > > > -		if (p->parent != father) {
> > > > > -			BUG_ON(p->parent != p->real_parent);
> > > > > -			return;
> > > > > -		}
> > > > 
> > > > This is the case where we were tracing something.  The ptrace_unlink
> > > > returned it to its original parent.  It doesn't need the
> > > > remove_parent/add_parent (though they are harmless); it does need to
> > > > avoid the orphaned pgrp check.  It may need the do_notify_parent check,
> > > > which was a bug in the previous code.
> > > 
> > > What is the basis which you think it is bug?
> > 
> > The death of a tracing process should not have any effect on the traced
> > process except to untrace it.  It should not go through the orphaning
> > checks.  The orphaning checks assume that the exiting process is the
> > real parent, and will orphan the pgrp if it is not in the same
> > session... as its tracer!  That's a bug.
> 
> Ah, ok. I think, it's longtime (odd) behavior. And you think, it's
> a bug. Right?
> 
> And, both of your and old code has odd behavior. yes?

Before your patch, do_notify_parent didn't get called; I think that
perhaps it should be.  I'll think about that.  After your patch the
process group will be unexpectedly orphaned, which is not now the case.

Let me sit on this for a couple of hours.  I'll send you an alternative
patch to look at.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
