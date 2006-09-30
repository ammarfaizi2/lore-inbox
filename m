Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWI3Ih2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWI3Ih2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWI3Ih2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:37:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17312 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751144AbWI3IhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:37:24 -0400
Date: Sat, 30 Sep 2006 01:37:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 09/23] dynticks: extend next_timer_interrupt() to use a
 reference jiffie
Message-Id: <20060930013700.784b57f8.akpm@osdl.org>
In-Reply-To: <20060929234439.836620000@cruncher.tec.linutronix.de>
References: <20060929234435.330586000@cruncher.tec.linutronix.de>
	<20060929234439.836620000@cruncher.tec.linutronix.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 23:58:28 -0000
Thomas Gleixner <tglx@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> For CONFIG_NO_HZ we need to calculate the next timer wheel event based
> to a given jiffie value. Extend the existing code to allow the extra now
> argument. Provide a compability function for the existing implementations
> to call the function with now = jiffies.
> This also solves the racyness of the original code vs. jiffies changing
> during the iteration.
> 

I think this change has the potential to significantly increase the hold
time of tvec_base_t.lock.  Quite a lot of code has been moved inside that
lock, but most worrisome is that hrtimer_get_next_event() is also now
inside it.

What workloads is this change likely to impact, and how can we set about
verifying that we aren't introducing a problem?

Was that (unchangelogged) locking change even needed?  If so, why?

