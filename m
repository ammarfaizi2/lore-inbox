Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVCRRUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVCRRUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 12:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbVCRRTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 12:19:50 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62108 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261979AbVCRRTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 12:19:41 -0500
Date: Fri, 18 Mar 2005 18:19:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>, dipankar@in.ibm.com,
       shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318171929.GC30310@elte.hu>
References: <20050318113053.GA18905@elte.hu> <Pine.OSF.4.05.10503181336310.2466-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10503181336310.2466-100000@da410.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> Why can should there only be one RCU-reader per CPU at each given
> instance? Even on a real-time UP system it would be very helpfull to
> have RCU areas to be enterable by several tasks as once. It would
> perform better, both wrt. latencies and throughput: With the above
> implementation an high priority task entering an RCU area will have to
> boost the current RCU reader, make a task switch until that one
> finishes and makes yet another task switch. to get back to the high
> priority task. With an RCU implementation which can take n RCU readers
> per CPU there is no such problem.

correct, for RCU we could allow multiple readers per lock, because the
'blocking' side of RCU (callback processing) is never (supposed to be)
in any latency path.

except if someone wants to make RCU callback processing deterministic at
some point. (e.g. for memory management reasons.)

clearly the simplest solution is to go with the single-reader locks for
now - a separate experiment could be done with a new type of rwlock that
can only be used by the RCU code. (I'm not quite sure whether we could
guarantee a minimum rate of RCU callback processing under such a scheme
though. It's an eventual memory DoS otherwise.)

	Ingo
