Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263510AbUAEFGM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 00:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbUAEFGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 00:06:12 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:18076 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263510AbUAEFGK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 00:06:10 -0500
X-AuthUser: davidel@xmailserver.org
Date: Sun, 4 Jan 2004 21:06:06 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: mingo@redhat.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kthread_create 
In-Reply-To: <20040105043139.B8D642C10E@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0401042100510.15831-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, Rusty Russell wrote:

> In message <Pine.LNX.4.44.0401041501510.12666-100000@bigblue.dev.mdolabs.com> you write:
> > I can see two options:
> > 
> > 1) We do not allow do_exit() from kthreads
> > 
> > 2) We give kthread_exit()
> > 
> > What do you think?
> 
> Well, I've now got a patch which works without any global
> datastructures, but still allows the same semantics.  Includes some
> fixes in the previous code, and test code.
> 
> Also includes a longstanding fix in workqueue.c: we never get SIGCHLD
> if signal handler is SIG_IGN.
> 
> I'm not sure it's neater, though.  We don't have WIFEXITED() in the
> kernel, so lots of manual shifting, probably should add that
> somewhere.
> 
> Thoughts?

Honestly I do not like playing with SIGCLD/waitpid for things that do not 
concern real task exits. But I think it can be avoided, and actually I 
don't know why I did not think about this before. We don't need to return 
a struct task_struct* for kthread_create(). We can have:

struct kthread_struct {
	struct task_struct *tsk;
	int ret;
	struct semaphore ack; /* Or completion if you like */
};

This structure is allocated in kthread_create() and propagated to the 
kthread() void* data. Then they (the creator and the kthread) will have a 
common ground to exchange acks w/out playing with SIGCLD/waitpid. Heh ?



- Davide


