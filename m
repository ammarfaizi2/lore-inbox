Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262518AbSIPPxj>; Mon, 16 Sep 2002 11:53:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262525AbSIPPxj>; Mon, 16 Sep 2002 11:53:39 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:62736 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262518AbSIPPxe>; Mon, 16 Sep 2002 11:53:34 -0400
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for ptrace breakage
References: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain>
	<87vg565eo2.fsf@devron.myhome.or.jp>
	<87wupmrtn1.fsf@devron.myhome.or.jp>
	<20020916130735.GA3920@nevyn.them.org>
	<87sn0at3di.fsf@devron.myhome.or.jp>
	<20020916144204.GA7991@nevyn.them.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 17 Sep 2002 00:57:57 +0900
In-Reply-To: <20020916144204.GA7991@nevyn.them.org>
Message-ID: <87fzwasz96.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> writes:

> > > Some comments.  First of all, you said you fixed a race on
> > > current->ptrace and some other bugs - would you mind saying where they
> > > were?  It's definitely cleaner after your patch but I'd like to
> > > understand where you found bugs, since I think you're introducing more.
> > 
> > It's the following
> > 
> > 		task_t *trace_task = p->parent;
> > 		int ptrace_flag = p->ptrace;
> > 		BUG_ON (ptrace_flag == 0);
> > 
> > 		__ptrace_unlink(p);
> > 		p->ptrace = ptrace_flag;
> > 		__ptrace_link(p, trace_task);
> 
> We have the tasklist lock.  How can there be a race here?  The parent
> can't detach while we're holding the tasklist lock.  If there is a race
> with PTRACE_SETOPTIONS, then PTRACE_SETOPTIONS should take the lock.

No. If the real parent don't change ->ptrace, it doesn't need
lock.

> > > So you reparent children on the ptrace_list right here.  But they still
> > > need to go through zap_thread!  You're right, the do_notify_parent in
> > > zap_thread isn't necessary; it'll be taken care of in sys_wait4.  The
> > > orphaned pgrp check is still relevant though.
> > 
> > ??? You forget tasklist_lock?
> 
> Huh?
> 
> The problem I am describing is when a child - which will become an
> orphaned pgrp when ``father'' dies - is being ptraced at the moment of
> ``father''s death.  With your patch it will be moved to
> reaper->ptrace_children (or child_reaper->ptrace_children) but never
> orphaned properly.  It'll miss a signal.
>
> > > If you're going to remove the if, you need to maintain its effect! 
> > > See:
> > > > -		if (p->parent != father) {
> > > > -			BUG_ON(p->parent != p->real_parent);
> > > > -			return;
> > > > -		}
> > > 
> > > This is the case where we were tracing something.  The ptrace_unlink
> > > returned it to its original parent.  It doesn't need the
> > > remove_parent/add_parent (though they are harmless); it does need to
> > > avoid the orphaned pgrp check.  It may need the do_notify_parent check,
> > > which was a bug in the previous code.
> > 
> > What is the basis which you think it is bug?
> 
> The death of a tracing process should not have any effect on the traced
> process except to untrace it.  It should not go through the orphaning
> checks.  The orphaning checks assume that the exiting process is the
> real parent, and will orphan the pgrp if it is not in the same
> session... as its tracer!  That's a bug.

Ah, ok. I think, it's longtime (odd) behavior. And you think, it's
a bug. Right?

And, both of your and old code has odd behavior. yes?
--
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
