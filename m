Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261244AbVA0WY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261244AbVA0WY5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 17:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVA0WY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 17:24:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:46509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261244AbVA0WYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 17:24:53 -0500
Date: Thu, 27 Jan 2005 14:29:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: mauriciolin@gmail.com, tglx@linutronix.de, marcelo.tosatti@cyclades.com,
       edjard@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: User space out of memory approach
Message-Id: <20050127142943.3fea07df.akpm@osdl.org>
In-Reply-To: <20050127221129.GX8518@opteron.random>
References: <1105403747.17853.48.camel@tglx.tec.linutronix.de>
	<20050111083837.GE26799@dualathlon.random>
	<3f250c71050121132713a145e3@mail.gmail.com>
	<3f250c7105012113455e986ca8@mail.gmail.com>
	<20050122033219.GG11112@dualathlon.random>
	<3f250c7105012513136ae2587e@mail.gmail.com>
	<1106689179.4538.22.camel@tglx.tec.linutronix.de>
	<3f250c71050125161175234ef9@mail.gmail.com>
	<20050126004901.GD7587@dualathlon.random>
	<3f250c7105012710541d3e7ad1@mail.gmail.com>
	<20050127221129.GX8518@opteron.random>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> > > Can you replace this:
> > > 
> > >         if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
> > >                 force_sig(SIGTERM, p);
> > >         } else {
> > >                 force_sig(SIGKILL, p);
> > >         }
> > > 
> > > with this?
> > > 
> > >         force_sig(SIGKILL, p);
> > > 
> > > in mm/oom_kill.c.
> > 
> > Nice. Your suggestion made the error goes away.
> > 
> > We are still testing in order to compare between your OOM Killer and
> > Original OOM Killer.
> 
> Ok, thanks for the confirmation. So my theory was right.
> 
> Basically we've to make this patch, now that you already edited the
> code, can you diff and send a patch that will be the 6/5 in the serie?
> 

I've already queued a patch for this:

--- 25/mm/oom_kill.c~mm-fix-several-oom-killer-bugs-fix	Thu Jan 27 13:56:58 2005
+++ 25-akpm/mm/oom_kill.c	Thu Jan 27 13:57:19 2005
@@ -198,12 +198,7 @@ static void __oom_kill_task(task_t *p)
 	p->time_slice = HZ;
 	p->memdie = 1;
 
-	/* This process has hardware access, be more careful. */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO)) {
-		force_sig(SIGTERM, p);
-	} else {
-		force_sig(SIGKILL, p);
-	}
+	force_sig(SIGKILL, p);
 }
 
 static struct mm_struct *oom_kill_task(task_t *p)

However.  This means that we'll now kill off tasks which had hardware
access.  What are the implications of this?
