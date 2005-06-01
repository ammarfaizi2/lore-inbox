Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVFANRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVFANRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 09:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVFANMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 09:12:10 -0400
Received: from mx1.elte.hu ([157.181.1.137]:12681 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261298AbVFANKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 09:10:34 -0400
Date: Wed, 1 Jun 2005 15:09:49 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: RT : 2.6.12rc5 + realtime-preempt-2.6.12-rc5-V0.7.47-15
Message-ID: <20050601130949.GB32232@elte.hu>
References: <1117551231.19367.48.camel@ibiza.btsn.frna.bull.fr> <1117568825.23283.5.camel@mindpipe> <1117613246.5580.70.camel@ibiza.btsn.frna.bull.fr> <20050601082351.GA30690@elte.hu> <1117627375.5580.283.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1117627375.5580.283.camel@ibiza.btsn.frna.bull.fr>
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


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> > and start a new search for a maximum latency via:
> > 
> >  echo 0 > /proc/sys/kernel/preempt_max_latency
> > 
> > and then do the X test - what is the largest latency reported in 
> > 'dmesg'? Also, please send me a (bzip2 -9 compressed, if too large) 
> > /proc/latency_trace trace output of the largest incident.
> The max latency reported are normal.

yeah. (btw., enable CONFIG_KALLSYMS to get a much more readable trace 
output)

> I have the problem with another program which mesure latencies about 
> semaphore only in X environment too.
>         
> I tried to ssh this machine from another X environment and the problem 
> does not exist. It's only on the console.

does your measurement program do any tty IO during the measurement? That 
could delay the measurement code artificially. Generally, latency 
measurement must be done very carefully (userspace and kernelspace 
alike).

E.g. rtc_wakeup uses a FIFO between two threads to isolate the 
measurement thread as much as possible. rtc_wakeup can be found at:

   http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

and should be run like:

  chrt -f 95 -p `pidof 'IRQ 8'`
  ./rtc_wakeup -f 1024 -t 100000

if you only trust your own measurement code then you can use a hybrid 
tracing method as well: switch the kernel's trace into 'user triggered':

  echo 1 > /proc/sys/kernel/trace_user_triggered

then you can turn tracing on in your code via a syscall hack:

	gettimeofday(0,1);

(yes - gettimeofday. Has nothing to do with tracing.) You can turn 
tracing off via:

	gettimeofday(0,0);

and the kernel will do a maximum search for you, and you should have the 
highest-latency trace available in /proc/latency_trace.

	Ingo

