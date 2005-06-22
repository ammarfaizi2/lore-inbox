Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVFVTEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVFVTEs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 15:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261818AbVFVTEr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 15:04:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:37315 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261806AbVFVTEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 15:04:37 -0400
Date: Wed, 22 Jun 2005 21:04:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Kristian Benoit <kbenoit@opersys.com>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel@vger.kernel.org, bhuey@lnxw.com, andrea@suse.de,
       tglx@linutronix.de, pmarques@grupopie.com, bruce@andrew.cmu.edu,
       nickpiggin@yahoo.com.au, ak@muc.de, sdietrich@mvista.com,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: PREEMPT_RT vs I-PIPE: the numbers, part 2
Message-ID: <20050622190422.GA6572@elte.hu>
References: <1119287612.6863.1.camel@localhost> <20050621015542.GB1298@us.ibm.com> <42B77B8C.6050109@opersys.com> <20050622011931.GF1324@us.ibm.com> <42B9845B.8030404@opersys.com> <20050622162718.GD1296@us.ibm.com> <1119460803.5825.13.camel@localhost> <20050622185019.GG1296@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050622185019.GG1296@us.ibm.com>
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


* Paul E. McKenney <paulmck@us.ibm.com> wrote:

> Any way of getting the logger's latency separately?  Or the target's?

with lpptest (PREEMPT_RT's built-in parallel-port latency driver) that's 
possible, as it polls the target with interrupts disabled, eliminating 
much of the logger-side latencies. The main effect is that it's now only 
a single worst-case latency that is measured, instead of having to have 
two worst-cases meet.

Here's a rough calculation to show what the stakes are: if there's a 
1:100000 chance to trigger a worst-case irq handling latency, and you 
have 600000 samples, then with lpptest you'll see an average of 6 events 
during the measurement. With lrtfb (the one Karim used) the chance to 
see both of these worst-case latencies on both sides of the measurement 
is 1:10000000000, and you'd see 0.00006 of them during the measurement.  
I.e. the chances of seeing the true max latency are pretty slim.

So if you want to reliably measure worst-case latencies in your expected 
lifetime, you truly never want to serially couple the probabilities of 
worst-case latencies on the target and the logger side.

	Ingo
