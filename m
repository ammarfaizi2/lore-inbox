Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261790AbVFKT2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbVFKT2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 15:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVFKT2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 15:28:20 -0400
Received: from mx2.elte.hu ([157.181.151.9]:28576 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261790AbVFKT2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 15:28:12 -0400
Date: Sat, 11 Jun 2005 21:27:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kristian Benoit <kbenoit@opersys.com>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com, bhuey@lnxw.com,
       andrea@suse.de, tglx@linutronix.de, karim@opersys.com,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, sdietrich@mvista.com, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
Message-ID: <20050611192722.GB24152@elte.hu>
References: <42AA6A6B.5040907@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AA6A6B.5040907@opersys.com>
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


a couple of other wrokloads that are easy to measure and are useful for 
triggering worst-case latencies:

hackbench:

  http://developer.osdl.org/craiger/hackbench/
  http://developer.osdl.org/craiger/hackbench/src/hackbench.c

it creates tons of threads and does message-passing between them. E.g.  
"hackbench 50" or "hackbench 100" is a pretty good test.

i use 40 copies of LTP running in parallel:

   while true; do ./runalltests.sh -x 40; done

this is good at triggering worst-case latencies too. Plus dbench is good 
too:

  http://samba.org/ftp/tridge/dbench/
  http://samba.org/ftp/tridge/dbench/dbench-3.03.tar.gz

  # dbench-3.03> ./dbench 50 -c ./client.txt

also, there's a very good on-host IRQ-latency measurement tool as well:

   http://www.affenbande.org/~tapas/wiki/index.php?rtc_wakeup

this uses TSC timestamping to detect wall-clock delays of the RTC 
interrupt. The tools jumps through lots of hoops to make sure the 
numbers are reliable. If you run it under the -RT kernel then run the 
RTC IRQ thread at a higher-than-all-other-threads priority:

  chrt -f 95 -p `pidof 'IRQ 8'`
  ./rtc_wakeup -f 1024 -t 100000

(when you run it, and if you also have RTC_HISTOGRAM enabled in your 
.config, then the kernel will print a histogram when you stop 
rtc_wakeup, so you've got two sources of information.)

	Ingo
