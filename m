Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVCRLbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVCRLbd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 06:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVCRLbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 06:31:33 -0500
Received: from mx1.elte.hu ([157.181.1.137]:18136 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261581AbVCRLbb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 06:31:31 -0500
Date: Fri, 18 Mar 2005 12:30:53 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318113053.GA18905@elte.hu>
References: <20050318002026.GA2693@us.ibm.com> <20050318100339.GA15386@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318100339.GA15386@elte.hu>
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

> [...] How about something like:
> 
>         void
>         rcu_read_lock(void)
>         {
>                 preempt_disable();
>                 if (current->rcu_read_lock_nesting++ == 0) {
>                         current->rcu_read_lock_ptr =
>                                 &__get_cpu_var(rcu_data).lock;
>                         preempt_enable();
>                         read_lock(current->rcu_read_lock_ptr);
>                 } else
>                         preempt_enable();
>         }
> 
> this would still make it 'statistically scalable' - but is it correct?

thinking some more about it, i believe it's correct, because it picks
one particular CPU's lock and correctly releases that lock.

(read_unlock() is atomic even on PREEMPT_RT, so rcu_read_unlock() is
fine.)

	Ingo
