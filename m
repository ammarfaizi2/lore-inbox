Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267660AbUG3Ii3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267660AbUG3Ii3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 04:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267653AbUG3Ii3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 04:38:29 -0400
Received: from mail4.bluewin.ch ([195.186.4.74]:5256 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id S267658AbUG3Ii1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 04:38:27 -0400
Date: Fri, 30 Jul 2004 10:38:15 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Marc Ballarin <Ballarin.Marc@gmx.de>
Cc: rob@landley.net, linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-ID: <20040730083815.GA16881@k3.hellgate.ch>
Mail-Followup-To: Marc Ballarin <Ballarin.Marc@gmx.de>,
	rob@landley.net, linux-kernel@vger.kernel.org
References: <200407222204.46799.rob@landley.net> <20040729235654.GA19664@k3.hellgate.ch> <20040730102726.57519859.Ballarin.Marc@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040730102726.57519859.Ballarin.Marc@gmx.de>
X-Operating-System: Linux 2.6.8-rc2-bk1 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jul 2004 10:27:26 +0200, Marc Ballarin wrote:
> > --- linux-2.6.8-rc2-bk1/fs/proc/base.c.orig	2004-07-30 01:43:23.535967505 +0200
> > +++ linux-2.6.8-rc2-bk1/fs/proc/base.c	2004-07-30 01:43:27.428303752 +0200
> > @@ -329,6 +329,8 @@ static int proc_pid_cmdline(struct task_
> >  	struct mm_struct *mm = get_task_mm(task);
> >  	if (!mm)
> >  		goto out;
> > +	if (!mm->arg_end)
> > +		goto out;	/* Shh! No looking before we're done */
> >  
> >   	len = mm->arg_end - mm->arg_start;
> >   
> 
> Yes, this seems to fix it. First I replaced "goto out" with a printk, and
> the printks matched the occurence of the bug.
> However, I got multiple printks per bug (between 2 and 7). Is that
> supposed to happen?

Every time we proceed through proc_pid_cmdline with mm->arg_end == 0 is a
bug. AFAICT anyway. Whether you see an "occurence of the bug" depends on
how you measure it. Of course you are wecome to add more printks following
the code path to see how and when it propagates to where you are catching
it.

Roger
