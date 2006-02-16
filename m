Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWBPTxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWBPTxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWBPTxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:53:14 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:30433 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S964783AbWBPTxN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:53:13 -0500
Date: Thu, 16 Feb 2006 11:53:41 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
Message-ID: <20060216195341.GG1296@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D56.2D7AB32F@tv-sign.ru> <20060216192617.GF1296@us.ibm.com> <43F4E6EC.3B9F91C4@tv-sign.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43F4E6EC.3B9F91C4@tv-sign.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2006 at 11:56:12PM +0300, Oleg Nesterov wrote:
> "Paul E. McKenney" wrote:
> > 
> > On Wed, Feb 15, 2006 at 10:13:26PM +0300, Oleg Nesterov wrote:
> > > copy_process:
> > >
> > >       attach_pid(p, PIDTYPE_PID, p->pid);
> > >       attach_pid(p, PIDTYPE_TGID, p->tgid);
> > >
> > > What if kill_proc_info(p->pid) happens in between?
> > 
> > Doesn't your patch 1/2 that expanded the scope of siglock in
> > copy_process() prevent this from happening?
> 
> I think, no. Please see below,
> 
> > o       A new process is being created on CPU 0, and does the first
> >         attach_pid() in copy_process(), but has not yet done
> >         the second attach_pid().
> > 
> > o       Meanwhile, on CPU 1, kill_proc_info() successfully looks up the
> >         new process via find_task_by_pid().
> > 
> > o       Also on CPU 1, kill_proc_info() calls group_send_sig_info(),
> >         which checks permissions, locates the sighand structure,
> >         then attempts to acquire siglock.
> 
> ... and takes it. Without CLONE_THREAD (more precisely, CLONE_SIGHAND)
> we have different ->sighand for parent (current) and for the new child.
> 
> copy_process() holds parents's ->sighand, while group_send_sig_info()
> takes child's.

Good point!!!

The other thing to think through is tkill on a thread/process while it
is being created.  I believe that this is OK, since thread-specific
kill must target a specific thread, so does not do the traversal.

Does this match your understanding?

						Thanx, Paul
