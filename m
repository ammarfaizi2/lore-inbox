Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265833AbUGZUe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265833AbUGZUe7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 16:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUGZUe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 16:34:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:20150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266072AbUGZT7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 15:59:24 -0400
Date: Mon, 26 Jul 2004 12:57:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rlrevell@joe-job.com, wli@holomorphy.com, lenar@vision.ee,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
Message-Id: <20040726125750.5e467cfd.akpm@osdl.org>
In-Reply-To: <20040726083537.GA24948@elte.hu>
References: <20040713122805.GZ21066@holomorphy.com>
	<40F3F0A0.9080100@vision.ee>
	<20040713143947.GG21066@holomorphy.com>
	<1090732537.738.2.camel@mindpipe>
	<1090795742.719.4.camel@mindpipe>
	<20040726082330.GA22764@elte.hu>
	<1090830574.6936.96.camel@mindpipe>
	<20040726083537.GA24948@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
>   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc2-J3

The bigger this thing gets, the more worried I get.  Sometime this is going
to need to be split up into individual fixes, and they need to be based
upon an overall approach which we haven't yet settled on.

In particular your whole approach (with voluntary_need_resched()) doesn't
work on SMP.

The approach I'm using is to unconditionally drop locks on every Nth pass
around the loop to allow another CPU to grab the lock, do some work, drop
the lock, then be preempted.  eg:

@@ -773,6 +774,12 @@ int get_user_pages(struct task_struct *t
 			struct page *map = NULL;
 			int lookup_write = write;
 
+			if ((++nr_pages & 63) == 0) {
+				spin_unlock(&mm->page_table_lock);
+				cpu_relax();
+				spin_lock(&mm->page_table_lock);
+			}
+
 			/*
 			 * We don't follow pagetables for VM_IO regions - they

This is a bit nasty, because it assumes that the other CPU will be able to
get in there and acquire the lock which is in a different cpu's cache. 
Long transfer latencies may defeat this.

For voluntary preempt the above will need a cond_resched added to it.

So we need to come up with a suitable approach to covering voluntary and
involuntary preemption on both UP and SMP and set up the header file
infrastructure to support it all.  After that we need to redo all the
points-of-high-latency whcih have thus far been discovered to use that
infrastructure.

