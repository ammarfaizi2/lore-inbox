Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbULJW1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbULJW1z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbULJW0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:26:38 -0500
Received: from mx1.elte.hu ([157.181.1.137]:20892 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261846AbULJWYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:24:46 -0500
Date: Fri, 10 Dec 2004 23:24:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mark_H_Johnson@raytheon.com
Cc: Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, linux-kernel@vger.kernel.org,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Esben Nielsen <simlo@phys.au.dk>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-15
Message-ID: <20041210222432.GD7609@elte.hu>
References: <OFC6899882.DBD65C9D-ON86256F66.00796C43-86256F66.00796C5C@raytheon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFC6899882.DBD65C9D-ON86256F66.00796C43-86256F66.00796C5C@raytheon.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-2.201, required 5.9,
	BAYES_00 -4.90, SORTED_RECIPS 2.70
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mark_H_Johnson@raytheon.com <Mark_H_Johnson@raytheon.com> wrote:

> Here is my get_ltrace.sh script (at the end).
> 
> So I read the preempt_max_latency (to see if its changed) before I
> copy the latency_trace output. I am not so sure that cat is really
> doing an "atomic" read when some of the latency traces are over 300
> Kbytes in length.

reading preempt_max_latency ought to be fine to detect changes.

yes, even a 300 KB trace should be read atomically too, even if it takes
3 seconds to save, hence all the different layers of trace buffers. The
kernel does not update the output buffer until the 'cat' has finished.
(unless a parallel 'cat' interferes - all your scripts are serialized,
right?)

> Also note that some of the files were empty :-(. I don't think I've
> seen that symptom before.

hm, an empty file occurs if the saved output trace is empty. This should
only be the case shortly after resetting preempt_max_latency. (or after
bootup, until it's set for the first time.)

> Note that the preempt_max_latency value DID match the last line of the
> trace output in the example I described. It is just the header that
> had some stale data in it.

yeah. It's weird. Ahh .. reviewing the header-generation code again i
noticed a buglet, which could cause spuriously wrong latency values on
SMP systems. Does the patch below fix this particular symptom?

	Ingo

--- linux/kernel/latency.c.orig
+++ linux/kernel/latency.c
@@ -542,7 +542,7 @@ static void update_out_trace(void)
 	 * trace buffer.
 	 */
 	tmp_out = out_tr.traces + 0;
-	*tmp_out = max_tr.traces[0]; // TODO: dont copy the traces
+	*tmp_out = max_tr.traces[max_tr.cpu]; // TODO: dont copy the traces
 	out_tr.cpu = max_tr.cpu;
 	out_entry = tmp_out->trace + 0;
 
