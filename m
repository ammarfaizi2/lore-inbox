Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUJNTbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUJNTbZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJNT1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:27:36 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34267 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267368AbUJNT1K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:27:10 -0400
Date: Thu, 14 Oct 2004 21:28:04 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Andrew Morton <akpm@osdl.org>, Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U0
Message-ID: <20041014192803.GA10972@elte.hu>
References: <OF29AF5CB7.227D041F-ON86256F2A.0062D210@raytheon.com> <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <1097779972.30253.947.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097779972.30253.947.camel@dhcp153.mvista.com>
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


* Daniel Walker <dwalker@mvista.com> wrote:

> When I was reviewing this it seemed like it would be possible to keep
> RCU anonymous by moving the callback processing out of the tasklet .
> The reason it was moved into a tasklet was to reduce latency. But if
> you serialize it like you have, aren't you removing all the benefits
> of the RCU type lock in those section that are converted to the new
> API ?

only if compiling for PREEMPT_REALTIME. Given the overhead of
PREEMPT_REALTIME i'm not sure RCU matters that much. But the nicest
would be Dipankar's preemptible-RCU patch.

> > For per-cpu variables i introduced a new API variant that creates a
> > spinlock-array for the per-cpu-variable, and users must make sure the
> > cpu field doesnt change. Migration to another CPU can happen within the
> > critical section, but 'statistically' the variable is still per-CPU and
> > update correctness is fully preserved.
> 
> Why not have a per cpu mutex instead of a per variable per cpu mutex?
> I'm not sure what the trade off are, except size.

well, nesting would be one issue. What if such a section gets preempted
on this CPU and another task tries to use the same mutex? 
Per-var-per-cpu mutexes seemed like the most orthogonal extension to the
existing concept. Keeping the original Linux locking semantics intact
seems like the primary mission, at least until the full scope is mapped.

	Ingo
