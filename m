Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263156AbVGIHTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263156AbVGIHTj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 03:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbVGIHTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 03:19:39 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55487 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S263156AbVGIHTi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 03:19:38 -0400
Date: Sat, 9 Jul 2005 09:19:11 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT and I-PIPE: the numbers, part 4
Message-ID: <20050709071911.GB31100@elte.hu>
References: <42CF05BE.3070908@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42CF05BE.3070908@opersys.com>
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


* Kristian Benoit <kbenoit@opersys.com> wrote:

> The numbers for PREEMPT_RT, however, have dramatically improved. All 
> the 50%+ overhead we saw earlier has now gone away completely. The 
> improvement is in fact nothing short of amazing. We were actually so 
> surprised that we went around looking for any mistakes we may have 
> done in our testing. We haven't found any though. So unless someone 
> comes out with another set of numbers showing differently, we think 
> that a warm round of applause should go to the PREEMPT_RT folks. If 
> nothing else, it gives us satisfaction to know that these test rounds 
> have helped make things better.

yeah, they definitely have helped, and thanks for this round of testing 
too! I'll explain the recent changes to PREEMPT_RT that resulted in 
these speedups in another mail.

Looking at your numbers i realized that the area where PREEMPT_RT is 
still somewhat behind (the flood ping +~10% overhead), you might be 
using an invalid test methodology:

> ping           = on host: "sudo ping -f $TARGET_IP_ADDR"

i've done a couple of ping -f flood tests between various testboxes 
myself, and one thing i found was that it's close to impossible to 
create a stable, comparable packets per second workload! The pps rate 
heavily fluctuated even within the same testrun. Another phenomenon i 
noticed is that the PREEMPT_RT kernel has a tendency to handle _more_ 
ping packets per second, while the vanilla (and thus i suspect the 
i-pipe) kernel throws away more packets.

Thus lmbench under PREEMPT_RT may perform 'slower', but in fact it was 
just an unbalanced and thus unfair test. Once i created a stable packet 
rate, PREEMPT_RT's IRQ overhead became acceptable.

(if your goal was to check how heavily external interrupts can influence 
a PREEMPT_RT box, you should chrt the network IRQ thread to SCHED_OTHER 
and renice it and softirq-net-rx and softirq-net-tx to nice +19.)

this phenomenon could be a speciality of my network setup, but still, 
could you please verify the comparability of the ping -f workloads on 
the vanilla and the PREEMPT_RT kernels? In particular, the interrupt 
rate should be constant and comparable - but it might be better to look 
at both the received and transmitted packets per second. (Since things 
like iptraf are quite expensive when flood pinging is going on, the best 
way i found to measure the packet rate was to process netstat -s output 
via a simple script.)

	Ingo
