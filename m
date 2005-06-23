Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVFWJsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVFWJsu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 05:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVFWJoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 05:44:18 -0400
Received: from mx2.elte.hu ([157.181.151.9]:38075 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262268AbVFWJiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 05:38:25 -0400
Date: Thu, 23 Jun 2005 11:37:32 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>
Subject: Re: [patch 02/38] CKRM e18: Processor Delay Accounting
Message-ID: <20050623093732.GA30848@elte.hu>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061754.354811000@w-gerrit.beaverton.ibm.com> <20050623091655.GA28722@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050623091655.GA28722@elte.hu>
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

> 
> * Gerrit Huizenga <gh@us.ibm.com> wrote:
> 
> > +#ifdef CONFIG_DELAY_ACCT
> > +int task_running_sys(struct task_struct *p)
> > +{
> > +	return task_is_running(p);
> > +}
> > +EXPORT_SYMBOL_GPL(task_running_sys);
> > +#endif
> 
> why is this function defined, and why is it exported?

this:

+#define task_is_running(p)     (this_rq() == task_rq(p))

is totally bogus. What you are checking is not whether 'the task is 
running', but it is a complex way of doing p->thread_info->cpu == 
smp_processor_id(). This, combined with:

+               if (pdata == NULL)
+                       /* some wierdo race condition .. simply ignore */
+                       continue;
+               if (thread->state == TASK_RUNNING) {
+                       if (task_running_sys(thread)) {
+                               atomic_inc((atomic_t *) &
+                                          (PSAMPLE(pdata)->cpu_running));
+                               run++;
+                       } else {
+                               atomic_inc((atomic_t *) &
+                                          (PSAMPLE(pdata)->cpu_waiting));
+                               wait++;
+                       }
+               }

yields completely incorrect code, and bogus data. If your goal is to 
sample executing-on-cpu vs. on-runqueue-waiting-to-run states then you 
should use the already existing task_curr(p) call.

	Ingo
