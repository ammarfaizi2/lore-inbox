Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756981AbWLCV3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbWLCV3j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 16:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760108AbWLCV3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 16:29:39 -0500
Received: from host-233-54.several.ru ([213.234.233.54]:57995 "EHLO
	mail.screens.ru") by vger.kernel.org with ESMTP id S1756981AbWLCV3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 16:29:38 -0500
Date: Mon, 4 Dec 2006 00:29:26 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] introduce put_pid_rcu() to fix unsafe put_pid(vc->vt_pid)
Message-ID: <20061203212926.GA428@oleg>
References: <20061201234826.GA9511@oleg> <20061203130237.761bb15d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061203130237.761bb15d.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03, Andrew Morton wrote:
>
> On Sat, 2 Dec 2006 02:48:26 +0300
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> 
> > drivers/char/vt_ioctl.c changes vc->vt_pid doing
> > 
> > 	put_pid(xchg(&vc->vt_pid, ...));
> > 
> > This is unsafe, put_pid() can actually free the memory while vc->vt_pid is
> > still used by kill_pid(vc->vt_pid).
> > 
> > Add a new helper, put_pid_rcu(), which frees "struct pid" via rcu callback
> > and convert vt_ioctl.c to use it.
> > 
> 
> 
> I'm a bit reluctant to go adding more tricky infrastructure (especially
> 100% undocumented infrastructure) on behalf of a single usage site in a
> place as creepy as the VT ioctl code.
> If we envisage future users of this infrastructure (and if it gets
> documented) then OK.

It is a shame we can't use "struct pid*" lockless, note that "struct pid"
itself is rcu-protected. I hope we can find another usage for put_pid_rcu
(in fact I suggested it before, but didn't have a reason). However, I don't
see any other example immediately.

>                       Otherwise I'd rather just stick another bandaid into
> the vt code.  Can we add some locking there,

Yes, this is possible, and probably we should do just this.

>                                               or change it to use a
> task_struct* or something?

I don't think this is good. It was converted from task_struct* to pid*.

Eric, what do you think?

Oleg.

