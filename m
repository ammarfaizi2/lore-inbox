Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319381AbSIFUkb>; Fri, 6 Sep 2002 16:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319382AbSIFUkb>; Fri, 6 Sep 2002 16:40:31 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:24078 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S319381AbSIFUk3>; Fri, 6 Sep 2002 16:40:29 -0400
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] ptrace-fix-2.5.33-A1
References: <Pine.LNX.4.44.0209060058040.20904-100000@localhost.localdomain>
	<87vg5j2l5g.fsf@devron.myhome.or.jp>
	<20020906154508.GA20709@nevyn.them.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 07 Sep 2002 05:44:40 +0900
In-Reply-To: <20020906154508.GA20709@nevyn.them.org>
Message-ID: <87heh23l1j.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> writes:

> > 	 * Search them and reparent children.
> > 	 */
> > 	list_for_each(_p, &father->children) {
> > 		p = list_entry(_p,struct task_struct,sibling);
> > 		reparent_thread(p, reaper, child_reaper);
> > 	}
> > 
> > Looks like that tracer deprive a process from real parent.
> 
> Oh - when the tracer exits the original parent may be corrupted, you
> mean?  I guess you're right.  But I've made so many changes to this bit
> of code that I'd like to wait until it settles before we fix this -
> it's not a new problem.

Yes, this isn't new problem. However, since other place may be
affected by this, I think should fix this first.

> > 	list_for_each(_p, &father->ptrace_children) {
> > 		p = list_entry(_p,struct task_struct,ptrace_list);
> > 		reparent_thread(p, reaper, child_reaper);
> > 	}
> > 
> > Thread group makes the child which links both ->children and
> > ->ptrace_children.
> 
> I don't understand what you mean.

Sorry, forget this.

> > >  {
> > > -	ptrace_unlink(p);
> > > -	list_del_init(&p->sibling);
> > > -	p->ptrace = 0;
> > > +	/* If we were tracing the thread, release it; otherwise preserve the
> > > +	   ptrace links.  */
> > > +	if (unlikely(traced)) {
> > > +		task_t *trace_task = p->parent;
> > > +		__ptrace_unlink(p);
> > > +		p->ptrace = 1;
> > 
> > Unexpected change of ptrace flag.
> 
> I should've caught that, I actually use the ptrace flags here.  But the
> code that uses them is suffering some other BUG() right now.

I forgot I say another point. This path shouldn't send signal to
parent.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
