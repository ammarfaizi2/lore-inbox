Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbTELAVK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbTELAVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:21:09 -0400
Received: from crack.them.org ([146.82.138.56]:52101 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id S261618AbTELAUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:20:50 -0400
Date: Sun, 11 May 2003 20:33:16 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Bernhard Kaindl <bernhard.kaindl@gmx.de>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: Problem: strace -ff fails on 2.4.21-rc1
Message-ID: <20030512003316.GA2167@nevyn.them.org>
Mail-Followup-To: Bernhard Kaindl <bernhard.kaindl@gmx.de>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
References: <200305111140_MC3-1-385D-EEF@compuserve.com> <Pine.LNX.4.53.0305120119540.1572@hase.a11.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0305120119540.1572@hase.a11.local>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 01:50:01AM +0200, Bernhard Kaindl wrote:
> On Sun, 11 May 2003, Chuck Ebbert wrote:
> > Carl-Daniel Hailfinger wrote:
> > > Chuck Ebbert wrote:
> > > >   I just found out minicom is spawing /sbin/lockdev which is setgrp
> > > > 'lock'.  Would that cause ptrace failure??
> > >
> > > AFAIK that could have caused the failure. Please test 2.4.21-rc2 whcih
> > > has fixes for many ptrace problems.
> >
> >   I can now strace minicom and its children with 2.4.21-rc2-ac1 but it
> > hangs on exit.  Both child processes exit successfully:
> 
> Very strange, does this work with 2.4.20? What's your version of strace?
> 
> > However strace and minicom are hung up somehow and the screen is
> > black with a blinking cursor at row 1 column 1.  The other ttys all
> > work OK and killing minicom cleans everything up.
> 
> Hm, this sounds like there could be some error/loop opening the device,
> which could be the effect of another side effect of the original ptrace
> fix, which my fixes which are included in 2.4.21-rc2 don't fix.
> 
> This side effect causes that if a system call needs a module loaded,
> it is not loaded and only an error from request_module() is sent to
> the kernel log. The attached patch on top of 2.4.21-rc2, fixes this
> remaining problem.
> 
> I'm not writing much info about it now, except that I think that it does
> not open any securiy hole, but I would like to give it a little more
> testing on SMP machines. On single CPU it fixed the "modprobe rejected"
> problem fine for me, without sacrifying ptrace securitey.
> 
> I'm uncertain if it would help in your case.
> 
> In your first message, you wrote:
> 
> >   (BTW does minicom work for you on 2.5?  It fails with the "No child
> > processes" message on 2.5.6x here but works on 2.4 when it's not being
> > traced.  Just the very act of running it under strace on 2.4 makes it
> > fail the same way it does on 2.5 here.  And stracing it on 2.5.66 made
> > it start working again!  Something very strange is going on...)
> 
> Very strange, maybe a "tail minicom.trc.*" at the time when it's hanging
> helps to get some idea.
> 
> Another note: suid is ignored when you are tracing the task which runs
> exec() for a setuid program.
> 
> So if minicom relies on having the setgid gid of /sbin/lockdev honored
> has in your case, the only ways I can find to get it working inder strace are:
> 
> - Change the locking config (temporary, for the debug) so that /sbin/lockdev
>   does not need to be setgid.
> 
> - Don't have ptrace follow fork mode activated when forking the child
>   which exec()'s /sbin/lockdev.

Run strace as root, and use strace -u?  Then it should not remove the
setuid-ness, I think.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
