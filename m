Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUBAFOq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 00:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUBAFOq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 00:14:46 -0500
Received: from nevyn.them.org ([66.93.172.17]:24707 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S265218AbUBAFOg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 00:14:36 -0500
Date: Sun, 1 Feb 2004 00:14:35 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
Message-ID: <20040201051435.GA19421@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
References: <20040201032525.GA10254@nevyn.them.org> <Pine.LNX.4.58.0401312014420.2033@home.osdl.org> <20040201044331.GA27271@nevyn.them.org> <Pine.LNX.4.58.0401312107440.2033@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401312107440.2033@home.osdl.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31, 2004 at 09:12:33PM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 31 Jan 2004, Daniel Jacobowitz wrote:
> > > 
> > > Can you verify that that process doesn't have any sub-threads? (Again, 
> > > that should be easily visible in /proc/<pid>/task/).
> > 
> > It is quite easily visible - in fact, it's hilarious.
> > 
> >  8454 pts/8    Z      0:00 [linux-dp] <defunct>
> > 
> > drow@nevyn:~% ls /proc/8454
> > auxv  cmdline  cwd@  environ  exe@  fd/  maps  mem  mounts  root@  stat
> > 
> > drow@nevyn:~% ls /proc/8454/task
> > ls: /proc/8454/task: No such file or directory
> 
> Oh damn. Yeah, we don't allow you to even see the threads in this case (it
> checks "pid_alive(task)". We don't want you to try to confuse things by 
> opening files of processes that we think are dead.
> 
> For the case of trying to figure out sub-threads of a dead thread group
> leader, that may actually be a bug.
> 
> Just for testing this, you might remove the check for
> 
>         if (!pid_alive(task))
>                 goto out;
> 
> in proc_pident_lookup() in fs/proc/base.c.
> 
> Ingo - comments? We really want the sysadmin to be able to find threads 
> that have a dead group leader, and right now that seems to be impossible.

I thought that a new group leader would be swapped in to that TID?  But
I was always confused by the mechanics of that.

Note that processes going invisible this way is, um, a bit of a
security problem.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
