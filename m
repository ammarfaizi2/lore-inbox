Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUBSKKe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 05:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267167AbUBSKKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 05:10:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:37349 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267165AbUBSKKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 05:10:25 -0500
Date: Thu, 19 Feb 2004 02:10:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: mingo@redhat.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: keventd_create_kthread
Message-Id: <20040219021018.408d9c55.akpm@osdl.org>
In-Reply-To: <20040219100549.GA27018@in.ibm.com>
References: <20040218231322.35EE92C05F@lists.samba.org>
	<Pine.LNX.4.58.0402190205040.16515@devserv.devel.redhat.com>
	<20040219001011.6245f163.akpm@osdl.org>
	<20040219100549.GA27018@in.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:
>
> On Thu, Feb 19, 2004 at 08:12:19AM +0000, Andrew Morton wrote:
> > However, if that wake_up_process() comes too early we'll just flip the new
> > thread out of TASK_INTERUPTIBLE into TASK_RUNNING and the schedule() in
> > kthread() will fall straight through.  So perhaps we can simply remove the
> > wait_task_inactive()?
> 
> If wake_up_process() comes too early (when the target task is still
> in TASK_RUNNING state), then won't wake_up_process() be a no-op?
> In which case, the target kthread will miss a wake-up event 
> (kthread_start/kthread_stop)?

No, that's OK - the new kernel thread sets TASK_INTERRUPTIBLE before waking
the invoking thread via complete():

new thread:

	/* OK, tell user we're spawned, wait for stop or wakeup */
	__set_current_state(TASK_INTERRUPTIBLE);
	complete(&create->started);
	schedule();

invoker:

	wait_for_completion(&create->started);
	create->result = find_task_by_pid(pid);
	wait_task_inactive(create->result);

It's the window after the complete() and before the schedule() where
wait_task_inactive() is spinning.

