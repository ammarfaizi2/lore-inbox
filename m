Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbVCWHQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbVCWHQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbVCWHQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:16:40 -0500
Received: from mx1.elte.hu ([157.181.1.137]:15824 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262837AbVCWHQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:16:35 -0500
Date: Wed, 23 Mar 2005 08:16:04 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323071604.GA32712@elte.hu>
References: <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323063317.GB31626@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@elte.hu> wrote:

> That callback will be queued on CPU#2 - while the task still keeps
> current->rcu_data of CPU#1. It also means that CPU#2's read counter
> did _not_ get increased - and a too short grace period may occur.
> 
> it seems to me that that only safe method is to pick an 'RCU CPU' when
> first entering the read section, and then sticking to it, no matter
> where the task gets migrated to. Or to 'migrate' the +1 read count
> from one CPU to the other, within the scheduler.

i think the 'migrate read-count' method is not adequate either, because
all callbacks queued within an RCU read section must be called after the
lock has been dropped - while with the migration method CPU#1 would be
free to process callbacks queued in the RCU read section still active on
CPU#2.

i'm wondering how much of a problem this is though. Can there be stale
pointers at that point? Yes in theory, because code like:

	rcu_read_lock();
	call_rcu(&dentry->d_rcu, d_callback);
	func(dentry->whatever);
	rcu_read_unlock();

would be unsafe because the pointer is still accessed within the RCU
read section, and if we get migrated from CPU#1 to CPU#2 after call_rcu
but before dentry->whatever dereference, the callback may be processed
early by CPU#1, making the dentry->whatever read operation unsafe.

the question is, does this occur in practice? Does existing RCU-using
code use pointers it has queued for freeing, relying on the fact that
the callback wont be processed until we drop the RCU read lock?

	Ingo
