Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261994AbSIPOYY>; Mon, 16 Sep 2002 10:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261997AbSIPOYY>; Mon, 16 Sep 2002 10:24:24 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:47119 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S261994AbSIPOYV>; Mon, 16 Sep 2002 10:24:21 -0400
To: Daniel Jacobowitz <dan@debian.org>
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix for ptrace breakage
References: <Pine.LNX.4.44.0209161349270.29027-100000@localhost.localdomain>
	<87vg565eo2.fsf@devron.myhome.or.jp>
	<87wupmrtn1.fsf@devron.myhome.or.jp>
	<20020916130735.GA3920@nevyn.them.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 16 Sep 2002 23:28:57 +0900
In-Reply-To: <20020916130735.GA3920@nevyn.them.org>
Message-ID: <87sn0at3di.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jacobowitz <dan@debian.org> writes:

> On Mon, Sep 16, 2002 at 09:44:34PM +0900, OGAWA Hirofumi wrote:
> > OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> writes:
> > 
> > > Grr, sorry. This patch is bad version.
> > > 
> > >  	list_for_each(_p, &father->ptrace_children) {
> > > 
> > > of course, this should
> > > 
> > >  	list_for_each_safe(_p, _n, &father->ptrace_children) {
> > 
> > This is a patch which fixed the above. Please apply.
> 
> Some comments.  First of all, you said you fixed a race on
> current->ptrace and some other bugs - would you mind saying where they
> were?  It's definitely cleaner after your patch but I'd like to
> understand where you found bugs, since I think you're introducing more.

It's the following

		task_t *trace_task = p->parent;
		int ptrace_flag = p->ptrace;
		BUG_ON (ptrace_flag == 0);

		__ptrace_unlink(p);
		p->ptrace = ptrace_flag;
		__ptrace_link(p, trace_task);

> If this is unnecessary, perhaps a BUG_ON()?  This function is called
> from daemonize at which point the ptrace flag should be clear, and
> that's it.

You aren't looking the source.

void reparent_to_init(void)
{
	write_lock_irq(&tasklist_lock);

	ptrace_unlink(current);
	/* Reparent to init */
	REMOVE_LINKS(current);
	current->parent = child_reaper;
	current->real_parent = child_reaper;
	SET_LINKS(current);

	/* Set the exit signal to SIGCHLD so we signal init on exit */
	current->exit_signal = SIGCHLD;

	current->ptrace = 0;

> > @@ -443,7 +442,7 @@ void exit_mm(struct task_struct *tsk)
> >  static inline void forget_original_parent(struct task_struct * father)
> >  {
> >  	struct task_struct *p, *reaper = father;
> > -	struct list_head *_p;
> > +	struct list_head *_p, *_n;
> >  
> >  	reaper = father->group_leader;
> >  	if (reaper == father)
> > @@ -462,52 +461,37 @@ static inline void forget_original_paren
> >  		if (father == p->real_parent)
> >  			reparent_thread(p, reaper, child_reaper);
> >  	}
> > -	list_for_each(_p, &father->ptrace_children) {
> > +	list_for_each_safe(_p, _n, &father->ptrace_children) {
> >  		p = list_entry(_p,struct task_struct,ptrace_list);
> > +		list_del_init(&p->ptrace_list);
> >  		reparent_thread(p, reaper, child_reaper);
> > +		if (p->parent != p->real_parent)
> > +			list_add(&p->ptrace_list, &p->real_parent->ptrace_children);
> >  	}
> >  }
> 
> So you reparent children on the ptrace_list right here.  But they still
> need to go through zap_thread!  You're right, the do_notify_parent in
> zap_thread isn't necessary; it'll be taken care of in sys_wait4.  The
> orphaned pgrp check is still relevant though.

??? You forget tasklist_lock?

> If you're going to remove the if, you need to maintain its effect! 
> See:
> > -		if (p->parent != father) {
> > -			BUG_ON(p->parent != p->real_parent);
> > -			return;
> > -		}
> 
> This is the case where we were tracing something.  The ptrace_unlink
> returned it to its original parent.  It doesn't need the
> remove_parent/add_parent (though they are harmless); it does need to
> avoid the orphaned pgrp check.  It may need the do_notify_parent check,
> which was a bug in the previous code.

What is the basis which you think it is bug?
--
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
