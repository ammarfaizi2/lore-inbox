Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265502AbUFVTeB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUFVTeB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUFVTd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:33:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:2465 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265132AbUFVTTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:19:09 -0400
Date: Tue, 22 Jun 2004 12:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, mikpe@csd.uu.se
Subject: Re: [PATCH][1/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: core
Message-Id: <20040622121805.7c5873a8.akpm@osdl.org>
In-Reply-To: <16600.14436.344871.168096@alkaid.it.uu.se>
References: <200405312218.i4VMIISg012277@harpo.it.uu.se>
	<20040622015311.561a73bf.akpm@osdl.org>
	<16600.14436.344871.168096@alkaid.it.uu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> wrote:
>
> Andrew Morton writes:
>  > Random points:
>  > 
>  > 
>  > - In __vperfctr_set_cpus_allowed(), is it possible for a process to
>  >   generate that printk deliberately, thus spamming the logs?
> 
> On a HT P4, yes that's possible. Should I put in a rate limit?

Spose so - __printk_ratelimit().  Or simply turn the message off until the
next reboot.

>  > - perfctr_set_cpus_allowed() does task_lock().  Should that be
>  >   vperfctr_task_lock() instead?
> 
> vperfctr_task_lock() _is_ task_lock() when HT P4s are possible.

I know.  I was asking whether that could should have used the macro rather
than open-coding the task_lock().  Whatever.

>  >   Please update the locking comment over task_lock() to represent this
>  >   new usage.
> 
> You mean add a comment there to the effect that set_cpus_allowed()
> may do a task_lock()?

That comment describes what data structures are protected by task_lock(). 
If you're aware of missing info or if you're protecting new data via
task_lock(), please update the comment.

>  > - Why does sys_vperfctr_open() call ptrace_check_attach()?  (I suspect
>  >   I'd know that if there was API documentation?)
> 
> In the remote-control case, we must check that the opening process
> has the right to control the target process. I'm using the same
> rules as ptrace(ATTACH) does, hence the ptrace_check_attach() call.

OK.  The term "remote control" has not been defined by you, so I'm to
assume that it refers to one process initiating perfctr instrumentation
against another, in some fashion.  Please feel my minor frustration ;)

>  >   These big structures should be dynamically allocated.
> 
> There's room for a temp copy in the perfctr state object, which as
> you've noticed is an entire page. That should reduce stack usage.

hm, not sure I understand that, but whatever.  Please fix up the big stack
users, especially those which do copy_*_user, or non-atomic memory
allocations.
