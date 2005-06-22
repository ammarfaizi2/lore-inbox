Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbVFVWwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbVFVWwi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262560AbVFVWwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:52:38 -0400
Received: from mx1.elte.hu ([157.181.1.137]:49363 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262578AbVFVWlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:41:52 -0400
Date: Thu, 23 Jun 2005 00:41:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Karim Yaghmour <karim@opersys.com>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Kristian Benoit <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622224123.GA7658@elte.hu>
References: <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com> <20050622190422.GA6572@elte.hu> <42B9C777.8040202@opersys.com> <20050622202242.GA17301@elte.hu> <42B9D208.4080305@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B9D208.4080305@opersys.com>
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


* Karim Yaghmour <karim@opersys.com> wrote:

> > so ... give the -50-12 -RT tree a try and report back the lpptest 
> > results you are getting.
> 
> First things first, we want to report back that our setup is validated 
> before we go onto this one. So we've modified LRTBF to do the 
> busy-wait thing.

here's another bug in the way you are testing PREEMPT_RT irq latencies.  
Right now you are doing this in lrtbf-0.1a/drivers/par-test.c:

    if (request_irq ( PAR_TEST_IRQ,
                                          &par_test_irq_handler,
 #if CONFIG_PREEMPT_RT
                                           SA_NODELAY,
 #else //!CONFIG_PREEMPT_RT
                                           SA_INTERRUPT,
 #endif //PREEMPT_RT

you should set the SA_INTERRUPT flag in the PREEMPT_RT case too! I.e. 
the relevant line above should be:

                                           SA_NODELAY | SA_INTERRUPT,

otherwise par_test_irq_handler will run with interrupts enabled, opening 
the window for other interrupts to be injected and increasing the 
worst-case latency! Take a look at drivers/char/lpptest.c how to do this 
properly. Also, double-check that there is no IRQ 7 thread running on 
the PREEMPT_RT kernel, to make sure you are measuring irq latencies.

	Ingo
