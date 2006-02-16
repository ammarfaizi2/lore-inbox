Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964778AbWBPTib@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWBPTib (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 14:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWBPTib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 14:38:31 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:43752 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964778AbWBPTia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 14:38:30 -0500
Message-ID: <43F4E6EC.3B9F91C4@tv-sign.ru>
Date: Thu, 16 Feb 2006 23:56:12 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Roland McGrath <roland@redhat.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] fix kill_proc_info() vs fork() theoretical race
References: <43E77D3C.C967A275@tv-sign.ru> <20060214223214.GG1400@us.ibm.com> <43F3352C.E2D8F998@tv-sign.ru> <43F37D56.2D7AB32F@tv-sign.ru> <20060216192617.GF1296@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> On Wed, Feb 15, 2006 at 10:13:26PM +0300, Oleg Nesterov wrote:
> > copy_process:
> >
> >       attach_pid(p, PIDTYPE_PID, p->pid);
> >       attach_pid(p, PIDTYPE_TGID, p->tgid);
> >
> > What if kill_proc_info(p->pid) happens in between?
> 
> Doesn't your patch 1/2 that expanded the scope of siglock in
> copy_process() prevent this from happening?

I think, no. Please see below,

> o       A new process is being created on CPU 0, and does the first
>         attach_pid() in copy_process(), but has not yet done
>         the second attach_pid().
> 
> o       Meanwhile, on CPU 1, kill_proc_info() successfully looks up the
>         new process via find_task_by_pid().
> 
> o       Also on CPU 1, kill_proc_info() calls group_send_sig_info(),
>         which checks permissions, locates the sighand structure,
>         then attempts to acquire siglock.

... and takes it. Without CLONE_THREAD (more precisely, CLONE_SIGHAND)
we have different ->sighand for parent (current) and for the new child.

copy_process() holds parents's ->sighand, while group_send_sig_info()
takes child's.

Oleg.
