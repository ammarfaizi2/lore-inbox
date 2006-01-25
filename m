Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWAYSYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWAYSYW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 13:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWAYSYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 13:24:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48542 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932093AbWAYSYV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 13:24:21 -0500
Date: Wed, 25 Jan 2006 10:23:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [patch, validator] fix proc_subdir_lock related deadlock
Message-Id: <20060125102351.28cd52b8.akpm@osdl.org>
In-Reply-To: <20060125180811.GA12762@elte.hu>
References: <20060125170331.GA29339@elte.hu>
	<1138209283.6695.55.camel@localhost.localdomain>
	<20060125180811.GA12762@elte.hu>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > proc_subdir_lock can also be used from softirq (tasklet) context, which 
> > > may lead to deadlocks.
> > > 
> > > This bug was found via the lock validator:
> > > 
> > 
> > Thanks Ingo,
> > 
> > I stressed in sending the patch that there was a big assumption that 
> > the calls would not be done in (soft)irq context.  I just didn't want 
> > to add overhead if it wasn't needed.  But I guess that this is needed 
> > until we can remove all the instances that use it in softirq context. 
> > But that's for a later patch.
> 
> the validator just found another problem with this lock, pointing out 
> that files_lock nests inside of proc_subdir_lock, and that files_lock is 
> a softirq-unsafe lock, creating another (unlikely but possible) deadlock 
> scenario:

files_lock can be taken on the free_irq() path: proc_kill_inodes().

> ...
> to solve this we must either change files_lock to be softirq-safe too 
> (bleh!), or we must forbid remove_proc_entry() use from softirq 
> contexts. Neither is a happy solution - remove_proc_entry() is used 
> within free_irq(), and who knows how many drivers do free_irq() in 
> softirq/tasklet context ...

free_irq()'s /proc fiddling has always been a pain - we just shouldn't be
doing filesystem things in irq/bh context.

> Andrew, this needs to be resolved before v2.6.16, correct? Steve's patch 
> solves a real bug in the upstream kernel.

It's not a very big bug - I think only Steve hit it, and that with a
stress-test which was somewhat tuned to hit it.

So we can afford to sit on the problem for a while, as long as someone is
working on a broader /proc-sanity fix.  But nobody will do that.

I wonder if we can just punt the unregister_handler_proc/kfree up to a
keventd callback.
