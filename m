Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbVGIPWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVGIPWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 11:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVGIPWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 11:22:47 -0400
Received: from mx2.elte.hu ([157.181.151.9]:17361 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261521AbVGIPWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 11:22:46 -0400
Date: Sat, 9 Jul 2005 17:22:07 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Rolland <rol@witbe.net>
Cc: "'Kristian Benoit'" <kbenoit@opersys.com>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       karim@opersys.com, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
Message-ID: <20050709152207.GA12797@elte.hu>
References: <42CF05BE.3070908@opersys.com> <200507090901.j6991PD22890@tag.witbe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507090901.j6991PD22890@tag.witbe.net>
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


* Paul Rolland <rol@witbe.net> wrote:

> > "IRQ & hd" run:
> > Measurements   |   Vanilla   |  preempt_rt    |   ipipe
> > ---------------+-------------+----------------+-------------
> > fork           |     101us   |   94us (-7%)   |  103us (+2%)
> > open/close     |     2.9us   |  2.9us (~)     |  3.0us (+3%)
> > execve         |     366us   |  370us (+1%)   |  372us (+2%)
> > select 500fd   |    14.3us   | 18.1us (+27%)  | 14.5us (+1%)
> > mmap           |     794us   |  654us (+18%)  |  822us (+4%)
> 
>                                   ^^^^^^^^^^^^
> You mean -18%, not +18% I think.
> 
> Just having a quick long at the numbers, it seems that now the "weak" 
> part in PREEMPT_RT is the select 500fd test.
> 
> Ingo, any idea about this one ?

yeah. In the '500 fds select' benchmark workload do_select() does an 
extremely tight loop over a 500-entry table that does an fget(). fget() 
acquires/releases current->files->file_lock. So we get 1000 lock and 
unlock operations in this workload. It cannot be for free. In fact, look 
at how the various vanilla kernels compare:

    AVG           v2.6.12        v2.6.12-PREEMPT        v2.6.12-SMP         
 ------------------------------------------------------------------
       select:      11.48           12.35 (  7%)       26.40 (129%)

(tested on one of my single-processor testsystems.)

I.e. SMP locking is already 129% overhead, and CONFIG_PREEMPT (which 
just bumps the preempt count twice(!)) has 7% overhead. In that sense, 
the 27% select-500-fds overhead measured for PREEMPT_RT is more than 
acceptable.

anyway, these days apps that do select() over 500 fds are expected to 
perform bad no matter what locking method is used. [To fix this
particular overhead we could take the current->file_lock outside of the
loop and do a get_file() within do_select(). This would improve SMP too.
But i doubt anyone cares.]

	Ingo
