Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVCWVrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVCWVrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 16:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVCWVrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 16:47:18 -0500
Received: from mx1.elte.hu ([157.181.1.137]:38101 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261417AbVCWVrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 16:47:07 -0500
Date: Wed, 23 Mar 2005 22:46:45 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Esben Nielsen <simlo@phys.au.dk>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-07
Message-ID: <20050323214645.GA10535@elte.hu>
References: <20050321090622.GA8430@elte.hu> <20050322054345.GB1296@us.ibm.com> <20050322072413.GA6149@elte.hu> <20050322092331.GA21465@elte.hu> <20050322093201.GA21945@elte.hu> <20050322100153.GA23143@elte.hu> <20050322112856.GA25129@elte.hu> <20050323061601.GE1294@us.ibm.com> <20050323063317.GB31626@elte.hu> <20050323071604.GA32712@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323071604.GA32712@elte.hu>
User-Agent: Mutt/1.4.2.1i
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

> i think the 'migrate read-count' method is not adequate either, 
> because all callbacks queued within an RCU read section must be called 
> after the lock has been dropped - while with the migration method 
> CPU#1 would be free to process callbacks queued in the RCU read 
> section still active on CPU#2.
> 
> i'm wondering how much of a problem this is though. Can there be stale 
> pointers at that point? Yes in theory, because code like:
> 
> 	rcu_read_lock();
> 	call_rcu(&dentry->d_rcu, d_callback);
> 	func(dentry->whatever);
> 	rcu_read_unlock();

but, this cannot happen, because call_rcu() is used by RCU-write code.

so the important property seems to be that any active RCU-read section 
should keep at least one CPU's active_readers count elevated 
permanently, for the duration of the RCU-read section. It doesnt matter 
that the reader migrates between CPUs - because the RCU code itself 
guarantees that no callbacks will be executed until _all_ CPUs have been 
in quiescent state. I.e. all CPUs have to go through a zero 
active_readers value before the callback is done.

	Ingo
