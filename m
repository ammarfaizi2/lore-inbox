Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTFPGhJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 02:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTFPGhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 02:37:09 -0400
Received: from dp.samba.org ([66.70.73.150]:13760 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263455AbTFPGhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 02:37:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: NeilBrown <neilb@cse.unsw.edu.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add module_kernel_thread for threads that live in modules.
Date: Mon, 16 Jun 2003 16:50:33 +1000
Message-Id: <20030616065058.D1C9E2C08A@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

	There are several problems with this patch.  Ignoring the fact
that you use __module_get.  Firstly, you bump the module count
permentantly while the thread is running: how does it ever get
unloaded?  Secondly, modprobe becomes your parent.

	There have been ambitious attempts to do a nice "thread
creation and stopping" interface before.  Given the delicate logic
involved in shutting threads down, I think this makes sense.  Maybe
something like: 

/* Struct which identifies a kernel thread, handed to creator and
   thread. */
struct kthread
{
	int pid;
	int should_die; /* Thread should exit when this is set. */

	/* User supplied arg... */
	void *arg;
};

struct kthread *create_thread(int (*fn)(struct kthread*), void *arg, 
			      unsigned long flags,
			      const char *namefmt, ...);
void cleanup_thread(struct kthread *);

create_thread would use keventd to start the thread, and stop_thread
would tell keventd to set should_die, wmb(), wake it up, and
sys_wait() for it.

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
