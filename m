Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbUBZWHj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUBZWFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:05:08 -0500
Received: from alt.aurema.com ([203.217.18.57]:63635 "EHLO smtp.sw.oz.au")
	by vger.kernel.org with ESMTP id S261168AbUBZWCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:02:47 -0500
Date: Fri, 27 Feb 2004 08:59:41 +1100
From: Kingsley Cheung <kingsley@aurema.com>
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       linux-kernel@vger.kernel.org, Daniel Jacobowitz <dan@debian.org>
Subject: Re: /proc visibility patch breaks GDB, etc.
Message-ID: <20040227085941.A21764@aurema.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, davidm@hpl.hp.com,
	davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
	linux-kernel@vger.kernel.org, Daniel Jacobowitz <dan@debian.org>
References: <16445.37304.155370.819929@wombat.chubb.wattle.id.au> <20040225224410.3eb21312.akpm@osdl.org> <16446.19305.637880.99704@napali.hpl.hp.com> <20040226120959.35b284ff.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040226120959.35b284ff.akpm@osdl.org>; from akpm@osdl.org on Thu, Feb 26, 2004 at 12:09:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 12:09:59PM -0800, Andrew Morton wrote:
> David Mosberger <davidm@napali.hpl.hp.com> wrote:
> >
> > >>>>> On Wed, 25 Feb 2004 22:44:10 -0800, Andrew Morton <akpm@osdl.org> said:
> > 
> >   Andrew> Peter Chubb <peter@chubb.wattle.id.au> wrote:
> >   >> 
> >   >> 
> >   >> In fs/proc/base.c:proc_pid_lookup(), the patch
> >   >> 
> >   >> read_unlock(&tasklist_lock); if (!task) goto out; + if
> >   >> (!thread_group_leader(task)) + goto out_drop_task;
> >   >> 
> >   >> inode = proc_pid_make_inode(dir->i_sb, task, PROC_TGID_INO);
> >   >> 
> >   >> means that threads other than the thread group leader don't
> >   >> appear in the /proc top-level directory.  Programs that are
> >   >> informed via pid of events can no longer find the appropriate
> >   >> process -- for example, using gdb on a multi-threaded process, or
> >   >> profiling using perfmon.
> >   >> 
> >   >> The immediate symptom is GDB saying: Could not open
> >   >> /proc/757/status when 757 is a TID not a PID.
> > 
> >   Andrew> What does `ls /proc/757' say?  Presumably no such file or
> >   Andrew> directory?  It's fairly bizare behaviour to be able to open
> >   Andrew> files which don't exist according to readdir, which is why
> >   Andrew> we made that change.
> > 
> > Excuse, but this seems seriously FOOBAR.  I understand that it's
> > interesting to see the thread-leader/thread relationship, but surely
> > that's no reason to break backwards compatibility and the ability to
> > look up _any_ task's info via /proc/PID/.
> 
> Well you can't look them up - you can only open them.  But I take your
> point.  In another life, these things would appear under a special
> /proc/magical_directory_which_has_dopey_semantics.
> 
> > A program that only wants
> > to show "processes" (thread-group leaders) can simply read
> > /proc/PID/status and ignore the entries for which Tgid != PPid.
> > 
> > Perhaps you could put relative symlinks in task/?  Something like
> > this:
> > 
> >  $ ls -l /proc/self/task
> >  dr-xr-xr-x    3 davidm   users           0 Feb 26 11:37 13494 -> ..
> >  dr-xr-xr-x    3 davidm   users           0 Feb 26 11:37 13495 -> ../../13495
> > 
> > perhaps?
> 
> Well the contents of /proc/pid/task are OK at present.
> 
> I guess we should revert that change.

Ah, so there was some fundamental reason behind that behaviour!
Perhaps then a comment or two in the code to explain that such
behaviour (prior to change) is intended in proc_pid_lookup()?  That
way it will be clear that is intended behaviour.

Am I correct to assume though that the corresponding change in
proc_task_lookup() should stay?  The existing behaviour there was that
one could do say,

cat /proc/<pid>/task/<tid>/stat, where tid could be any thread and not
a part of the thread group pid.  

The patch that broke backwards compatibility for GDB likewise changed
that.  It enforces that tid must be a part of the pid thread group.

--
		Kingsley
