Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVCRKDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVCRKDv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 05:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbVCRKDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 05:03:51 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25762 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261553AbVCRKDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 05:03:49 -0500
Date: Fri, 18 Mar 2005 11:03:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318100339.GA15386@elte.hu>
References: <20050318002026.GA2693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318002026.GA2693@us.ibm.com>
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


there's a problem in #5's rcu_read_lock():

        void
        rcu_read_lock(void)
        {
                preempt_disable();
                if (current->rcu_read_lock_nesting++ == 0) {
                        current->rcu_read_lock_ptr =
                                &__get_cpu_var(rcu_data).lock;
                        read_lock(current->rcu_read_lock_ptr);
                }
                preempt_enable();
        }

not only are read_lock()-ed sections preemptible, read_lock() itself may
block, so it cannot be called from within preempt_disable(). How about
something like:

        void
        rcu_read_lock(void)
        {
                preempt_disable();
                if (current->rcu_read_lock_nesting++ == 0) {
                        current->rcu_read_lock_ptr =
                                &__get_cpu_var(rcu_data).lock;
                        preempt_enable();
                        read_lock(current->rcu_read_lock_ptr);
                } else
                        preempt_enable();
        }

this would still make it 'statistically scalable' - but is it correct?

	Ingo
