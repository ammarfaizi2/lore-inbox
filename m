Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWI3IkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWI3IkV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWI3IkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:40:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11937 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751143AbWI3IkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:40:19 -0400
Date: Sat, 30 Sep 2006 01:36:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>, Dipankar Sarma <dipankar@in.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 08/23] dynticks: prepare the RCU code
Message-Id: <20060930013641.263a1cc3.akpm@osdl.org>
In-Reply-To: <20060929234439.721237000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234439.721237000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:27 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> 
> prepare the RCU code for dynticks/nohz. Since on nohz kernels there
> is no guaranteed timer IRQ that processes RCU callbacks, the idle
> code has to make sure that all RCU callbacks that can be finished
> off are indeed finished off. This patch adds the necessary APIs:
> rcu_advance_callbacks() [to register quiescent state] and
> rcu_process_callbacks() [to finish finishable RCU callbacks].
> 
> ...
>  
> +void rcu_advance_callbacks(int cpu, int user)
> +{
> +	if (user ||
> +	    (idle_cpu(cpu) && !in_softirq() &&
> +				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
> +		rcu_qsctr_inc(cpu);
> +		rcu_bh_qsctr_inc(cpu);
> +	} else if (!in_softirq())
> +		rcu_bh_qsctr_inc(cpu);
> +}
> +

I hope this function is immediately clear to the RCU maintainers, because it's
complete mud to me.

An introductory comment which describes what this function does and how it
does it seems appropriate.  And some words which decrypt the tests in there
might be needed too.

