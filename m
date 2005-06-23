Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVFWRyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVFWRyO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 13:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVFWRyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 13:54:13 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1225 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262644AbVFWRxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 13:53:43 -0400
Message-ID: <42BAF7AD.2050208@watson.ibm.com>
Date: Thu, 23 Jun 2005 13:55:57 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Reply-To: nagar@watson.ibm.com
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Gerrit Huizenga <gh@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       Chandra Seetharaman <sekharan@us.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>, Shailabh Nagar <nagar@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [patch 02/38] CKRM e18: Processor Delay Accounting
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com> <20050623061754.354811000@w-gerrit.beaverton.ibm.com> <20050623091655.GA28722@elte.hu> <20050623093732.GA30848@elte.hu>
In-Reply-To: <20050623093732.GA30848@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
> 
> 
>>* Gerrit Huizenga <gh@us.ibm.com> wrote:
>>
>>
>>>+#ifdef CONFIG_DELAY_ACCT
>>>+int task_running_sys(struct task_struct *p)
>>>+{
>>>+	return task_is_running(p);
>>>+}
>>>+EXPORT_SYMBOL_GPL(task_running_sys);
>>>+#endif
>>
>>why is this function defined, and why is it exported?

The wrapping of the macro and export of the function was
to allow its use by a module (crbce).

> 
> this:
> 
> +#define task_is_running(p)     (this_rq() == task_rq(p))
> 
> is totally bogus. What you are checking is not whether 'the task is 
> running', but it is a complex way of doing p->thread_info->cpu == 
> smp_processor_id(). This, combined with:
> 
> +               if (pdata == NULL)
> +                       /* some wierdo race condition .. simply ignore */
> +                       continue;
> +               if (thread->state == TASK_RUNNING) {
> +                       if (task_running_sys(thread)) {
> +                               atomic_inc((atomic_t *) &
> +                                          (PSAMPLE(pdata)->cpu_running));
> +                               run++;
> +                       } else {
> +                               atomic_inc((atomic_t *) &
> +                                          (PSAMPLE(pdata)->cpu_waiting));
> +                               wait++;
> +                       }
> +               }
> 
> yields completely incorrect code, and bogus data. If your goal is to 
> sample executing-on-cpu vs. on-runqueue-waiting-to-run states then you 
> should use the already existing task_curr(p) call.

Thanks. task_curr is what we needed.
Would exporting task_curr be ok or should we continue to wrap in a 
separate function ?


--Shailabh

