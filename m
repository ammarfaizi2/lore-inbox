Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVCRJF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVCRJF7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 04:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVCRJF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 04:05:58 -0500
Received: from mx2.elte.hu ([157.181.151.9]:15769 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261512AbVCRJEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 04:04:21 -0500
Date: Fri, 18 Mar 2005 10:04:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318090406.GA9188@elte.hu>
References: <20050318002026.GA2693@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318002026.GA2693@us.ibm.com>
User-Agent: Mutt/1.4.1i
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

> 4. Preemptible read side.
> 
> 	RCU read-side critical sections can (in theory, anyway) be quite
> 	large, degrading realtime scheduling response.	Preemptible RCU
> 	read-side critical sections avoid such degradation.  Manual
> 	insertion of "preemption points" might be an alternative as well.
> 	But I have no intention of trying to settle the long-running
> 	argument between proponents of preemption and of preemption
> 	points.  Not today, anyway!  ;-)

i'm cleverly sidestepping that argument by offering 4 preemption models
in the -RT tree :-) We dont have to pick a winner, users will. The way
low latencies are achieved depends on the preemption model:

               ( ) No Forced Preemption (Server)
               ( ) Voluntary Kernel Preemption (Desktop)
               ( ) Preemptible Kernel (Low-Latency Desktop)
               (X) Complete Preemption (Real-Time)

"Server" is the current default !PREEMPT model. Best throughput, bad
worst-case latencies.

"Low-Latency Desktop" is the current PREEMPT model. Has some runtime
overhead relative to Server, offers fair worst-case latencies.

"Desktop" is a new mode that is somewhere between Server and Low-Latency
Desktop: it's what was initially called 'voluntary preemption'. It
doesnt make the kernel forcibly preemptible anywhere, but inserts a fair
number of preemption points to decrease latencies statistically, while
keeping the runtime overhead close to the "Server". (a variant of this
model is utilized by Fedora and RHEL4 currently, so if this gets
upstream i expect distros to pick it up - it can be a migration helper
towards the "Low-Latency Desktop" model.)

"Real-Time" is the no-compromises hard-RT model: almost everything but
the scheduler itself is fully preemptible. Phenomenal worst-case
latencies in every workload scenario, but also has the highest runtime
overhead.

preemptable RCU makes sense for the "Low-Latency Desktop" and
"Real-Time" preemption models - these are the ones that do forced
preemption.

	Ingo
