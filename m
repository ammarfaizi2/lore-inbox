Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTFPHo3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 03:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263496AbTFPHo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 03:44:29 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:20235 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S263493AbTFPHo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:44:27 -0400
Date: Mon, 16 Jun 2003 09:58:43 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Rusty Russell <rusty@rustcorp.com.au>
cc: NeilBrown <neilb@cse.unsw.edu.au>, <torvalds@transmeta.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules.
In-Reply-To: <20030616065058.D1C9E2C08A@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0306160907470.2079-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Rusty Russell wrote:

> 	There have been ambitious attempts to do a nice "thread
> creation and stopping" interface before.  Given the delicate logic
> involved in shutting threads down, I think this makes sense.  Maybe
> something like: 
> 
> /* Struct which identifies a kernel thread, handed to creator and
>    thread. */
> struct kthread
> {
> 	int pid;
> 	int should_die; /* Thread should exit when this is set. */
> 
> 	/* User supplied arg... */
> 	void *arg;
> };
> 
> struct kthread *create_thread(int (*fn)(struct kthread*), void *arg, 
> 			      unsigned long flags,
> 			      const char *namefmt, ...);
> void cleanup_thread(struct kthread *);
> 
> create_thread would use keventd to start the thread, and stop_thread
> would tell keventd to set should_die, wmb(), wake it up, and
> sys_wait() for it.
> 
> Thoughts?
> Rusty.

Why using keventd? Personally I'd prefer a synchronous thread start/stop, 
particularly with the thread living in a module.
Maybe some generalisation of:


static DECLARE_WAIT_QUEUE_HEAD(wq_kthread);
static struct completion kthread_died;
static int should_die;

static int my_kthread(void *started)
{
	daemonize("my_kthread");

	complete((struct completion *)started);

	while (!should_die) {
		/* sleep for wq_kthread and do requested stuff */
	}

	complete_and_exit(&kthread_died, 0);
	/* never reached */
	return 0;
}

int my_kthread_create(...)
{
	DECLARE_COMPLETION(started);
	int pid;

	should_die = 0;
	init_completion(kthread_died);
	pid = kernel_thread(my_kthread, &startup, CLONE_FS|CLONE_FILES);
	if (pid <= 0)
		return -EAGAIN;

	wait_for_completion(&started);
	return pid;
}

void my_kthread_join(...)
{
	should_die = 1;	
	wake_up(&wq_kthread);
	wait_for_completion(&kthread_died);
}

Assuming the create/join things are called from module init/exit path this 
eliminates the need to bump the module refcnt.

To make this more generic I think it would be sufficient to move the 
start/exit completions into your struct kthread.

Martin

